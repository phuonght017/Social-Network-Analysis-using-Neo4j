// Louvain Community detection
CALL gds.graph.project(
  'socialNetwork',
  'User',
  'FRIENDS'
)
YIELD graphName

CALL gds.louvain.stream('socialNetwork')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS user, communityId
RETURN user.username AS User, communityId
ORDER BY communityId

// Community detection with Label Propagation
CALL gds.graph.project(
  'socialNetwork',
  'User',
  'FRIENDS'
)
YIELD graphName

CALL gds.labelPropagation.stream('socialNetwork')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS user, communityId
RETURN user.username AS User, communityId
ORDER BY communityId
