library(igraph)

data <- read.csv("resources/colleganza-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)
plot(cnet,venice.sn)

V(venice.sn)$betweenness <- betweenness(venice.sn)
V(venice.sn)$eigen <- eigen_centrality(venice.sn)
V(venice.sn)$pr <- unname(unlist(page_rank(venice.sn)$vector))

plot(cnet,venice.sn,
     layout=layout_with_fr(venice.sn),
     vertex.size=5+(V(venice.sn)$betweenness/100))

plot(cnet,venice.sn,
     layout=layout_with_fr(venice.sn),
     vertex.size=500*V(venice.sn)$pr)

write_graph(venice.sn,"resources/venice-social-network.graphml",format="graphml")
