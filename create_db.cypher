:param {
  // Define the file path root and the individual file names required for loading.
  // https://neo4j.com/docs/operations-manual/current/configuration/file-locations/
  file_path_root: 'file:///', // Change this to the folder your script can access the files at.
  file_0: 'user.csv',
  file_1: 'friendship.csv'
};

// CONSTRAINT creation
// -------------------
//
// Create node uniqueness constraints, ensuring no duplicates for the given node label and ID property exist in the database. This also ensures no duplicates are introduced in future.
//
// NOTE: The following constraint creation syntax is generated based on the current connected database version 5.22-aura.
CREATE CONSTRAINT `user_id_User_uniq` IF NOT EXISTS
FOR (n: `User`)
REQUIRE (n.`user_id`) IS UNIQUE;
CREATE CONSTRAINT `user_id_User_uniq` IF NOT EXISTS
FOR (n: `User`)
REQUIRE (n.`user_id`) IS UNIQUE;

:param {
  idsToSkip: []
};

// NODE load
// ---------
//
// Load nodes in batches, one node label at a time. Nodes will be created using a MERGE statement to ensure a node with the same label and ID property remains unique. Pre-existing nodes found by a MERGE statement will have their other properties set to the latest values encountered in a load file.
//
// NOTE: Any nodes with IDs in the 'idsToSkip' list parameter will not be loaded.
LOAD CSV WITH HEADERS FROM ($file_path_root + $file_0) AS row
WITH row
WHERE NOT row.`user_id` IN $idsToSkip AND NOT toInteger(trim(row.`user_id`)) IS NULL
CALL {
  WITH row
  MERGE (n: `User` { `user_id`: toInteger(trim(row.`user_id`)) })
  SET n.`user_id` = toInteger(trim(row.`user_id`))
  SET n.`username` = row.`username`
  SET n.`age` = toInteger(trim(row.`age`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_0) AS row
WITH row
WHERE NOT row.`user_id` IN $idsToSkip AND NOT toInteger(trim(row.`user_id`)) IS NULL
CALL {
  WITH row
  MERGE (n: `User` { `user_id`: toInteger(trim(row.`user_id`)) })
  SET n.`user_id` = toInteger(trim(row.`user_id`))
  SET n.`username` = row.`username`
  SET n.`age` = toInteger(trim(row.`age`))
} IN TRANSACTIONS OF 10000 ROWS;


// RELATIONSHIP load
// -----------------
//
// Load relationships in batches, one relationship type at a time. Relationships are created using a MERGE statement, meaning only one relationship of a given type will ever be created between a pair of nodes.
LOAD CSV WITH HEADERS FROM ($file_path_root + $file_1) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `User` { `user_id`: toInteger(trim(row.`source_id`)) })
  MATCH (target: `User` { `user_id`: toInteger(trim(row.`target_id`)) })
  MERGE (source)-[r: `friend with`]->(target)
  SET r.`interaction_type` = row.`interaction_type`
} IN TRANSACTIONS OF 10000 ROWS;
