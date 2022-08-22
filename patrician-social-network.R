library(igraph)

data <- read.csv("resources/family-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)

node.type <- read.csv("resources/family-data.csv")
node.type.dict <- list()

for (r in 1:nrow(node.type)) {
  node.type.dict[[ node.type[r,"Family.name"] ]]  <-  list( "positions"= node.type[r,"Positions"],
                                                            "doges"= node.type[r,"Doges"],
                                                            "type" = node.type[r,"Type"] )
}

positions = NULL
shapes = NULL

for (r in V(venice.sn)$name) {
  if (! is.null(node.type.dict[[r]])) {
    positions <- c(positions, node.type.dict[[r]])
    shapes <- c(shapes,
                     ifelse(node.type.dict[[r]] == "Doge",
                            "square",
                            ifelse(node.type.dict[[r]] == "Dogaressa","sphere","circle")))
    
  } else {
    positions <- c(positions,"None")
    shapes <- c(shapes,"sphere")
  }
  
}

V(venice.sn)$positions <- positions
V(venice.sn)$shapes <- shapes

plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes)

V(venice.sn)$betweenness <- betweenness(venice.sn)

plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes,
     layout=layout_with_fr(venice.sn),
     vertex.size=5+(V(venice.sn)$betweenness/20))

write_graph(venice.sn,"resources/venice-social-network.graphml",format="graphml")

