library(igraph)

data <- read.csv("resources/family-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)
plot(cnet,venice.sn)
