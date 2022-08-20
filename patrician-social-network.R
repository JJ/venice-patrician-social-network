library(igraph)

data <- read.csv("resources/family-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)
plot(cnet,venice.sn)

node.type <- read.csv("resources/family-positions.csv")

library(Dict)
family.types <- Dict$new()

for (r in 1:nrow(node.type)) {
  family.types[node.type[r,"Family.name"])] <- print(node.type[r,"Positions"]
}
