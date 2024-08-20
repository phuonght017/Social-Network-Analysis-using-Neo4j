// List all users and friend relationships
MATCH (u:User)-[r:`friend with`]-(v:User)
RETURN u, r, v

// List all friends of a user
MATCH (u:User {username: 'Bob'})-[:`friend with`]-(friend)
RETURN friend.username AS Friend

// Degree centrality
MATCH (u:User)
RETURN u.username AS User, SIZE([(u)-[:`friend with`]-() | 1]) AS Degree
ORDER BY Degree DESC
LIMIT 10

// Find shorstest path
MATCH p=shortestPath((start:User {username: 'Frank'})-[:`friend with`*]-(end:User {username: 'Jack'}))
RETURN p

