library(igraph)

data <- read.csv("resources/family-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)

node.type <- read.csv("resources/family-data.csv")
node.type.dict <- list()

for (r in 1:nrow(node.type)) {
  node.type.dict[[ node.type[r,"Family"] ]]  <-  list( "positions"= node.type[r,"Positions"],
                                                            "doges"= node.type[r,"Doges"],
                                                            "type" = node.type[r,"Type"] )
}

positions = NULL
shapes = NULL
doges = NULL
label.colors = NULL
label.colors.choice = c("white","lightgray","gray","lightblue","lightgreen","lightyellow", "magenta","darkgray","black")

for (r in V(venice.sn)$name) {
  if (! is.null(node.type.dict[[r]])) {
    positions <- c(positions, node.type.dict[[r]]$positions)
    shapes <- c(shapes,
                     ifelse(node.type.dict[[r]]$positions == "Doge",
                            "square",
                            ifelse(node.type.dict[[r]]$positions == "Dogaressa","sphere","circle")))
    doges <- c(1+as.numeric(node.type.dict[[r]]$doges))
    label.colors <- c(label.colors,label.colors.choice[1+as.numeric(node.type.dict[[r]]$doges)])
  } else {
    positions <- c(positions,"None")
    shapes <- c(shapes,"sphere")
  }
  
}

V(venice.sn)$positions <- positions
V(venice.sn)$shapes <- shapes
V(venice.sn)$label.colors <- label.colors

plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes)

V(venice.sn)$betweenness <- betweenness(venice.sn)

plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes,
     layout=layout_with_fr(venice.sn),
     vertex.size=5+(V(venice.sn)$betweenness/20),
     vertex.frame.color=V(venice.sn)$label.colors,
     vertex.frame.width=)

write_graph(venice.sn,"resources/venice-social-network.graphml",format="graphml")

