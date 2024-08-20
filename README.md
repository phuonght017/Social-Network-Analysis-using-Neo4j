# Social Network Analysis Using Neo4j
## Project Overview
This project performs a social network analysis using Neo4j, a graph database management system. The analysis focuses on understanding relationships and centrality within a social network graph, leveraging Neo4j’s powerful graph algorithms.

## Performed Tasks
### Database schema design
- Define nodes, edges
- Add properties for nodes and edges
  
### Data Preparation and Import
- Prepared CSV Files: Created CSV files for users and friendships with appropriate columns (user_id, username, source, target).
- Imported User Data: Loaded user data into Neo4j using Cypher queries.
- Imported Friendship Data: Loaded friendship data into Neo4j, establishing relationships between users.

### Graph Projection
- Projected Graph: Created an in-memory graph projection named socialNetwork with User nodes and Friend relationships.

### Graph Analysis
- Visualize the graph. Write some basic queries to compute centrality degree, find shortest path between two users.
- Community Detection: Used the Louvain algorithm and Label propagation to identify communities within the social network.
