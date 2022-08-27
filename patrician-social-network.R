library(igraph)

data <- read.csv("resources/family-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)

node.type <- read.csv("resources/family-data.csv")
node.type.dict <- list()

family.types <- list("None"="white","Ancient"="lightgray","Extinct pre-serrata"="gray","Evangeliche"="gold","Nuove"="blue",
                     "Nuovissime"="red","Soldi"="yellow","Evangeliche"="green","Vecchie"="black","Apostoliche"="pink")

for (r in 1:nrow(node.type)) {
  node.type.dict[[ node.type[r,"Family"] ]]  <-  list( "positions"= node.type[r,"Positions"],
                                                        "doges"= node.type[r,"Doges"],
                                                        "type" = node.type[r,"Type"] )
}

positions = NULL
shapes = NULL
doges = NULL
label.colors = NULL
types = NULL
label.colors.choice = c("white","lightgray","gray","lightblue","lightgreen","lightyellow", "magenta","darkgray","black")

for (r in V(venice.sn)$name) {
  if (! is.null(node.type.dict[[r]])) {
    positions <- c(positions, node.type.dict[[r]]$positions)
    shapes <- c(shapes,
                     ifelse(node.type.dict[[r]]$positions == "Doge",
                            "square",
                            ifelse(node.type.dict[[r]]$positions == "Dogaressa","sphere","circle")))
    doges <- c(doges,(1+as.numeric(node.type.dict[[r]]$doges))/3)
    label.colors <- c(label.colors,label.colors.choice[1+as.numeric(node.type.dict[[r]]$doges)])
    types <- c(types,family.types[[node.type.dict[[r]]$type]])
  } else {
    positions <- c(positions,"None")
    shapes <- c(shapes,"sphere")
    types <- c(types,"white")
  }
  
}

V(venice.sn)$positions <- positions
V(venice.sn)$shapes <- shapes
V(venice.sn)$label.colors <- label.colors
V(venice.sn)$doges <- doges
V(venice.sn)$types <- types


plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes)

V(venice.sn)$betweenness <- betweenness(venice.sn)
V(venice.sn)$eigen <- eigen_centrality(venice.sn)
V(venice.sn)$pr <- unname(unlist(page_rank(venice.sn)$vector))

plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes,
     layout=layout_with_fr(venice.sn),
     vertex.size=5+(V(venice.sn)$betweenness/20),
     vertex.label.cex=V(venice.sn)$doges,
     vertex.label.color=V(venice.sn)$types)

plot(cnet,venice.sn,vertex.shape=V(venice.sn)$shapes,
     layout=layout_with_fr(venice.sn),
     vertex.size=500*V(venice.sn)$pr,
     vertex.label.cex=V(venice.sn)$doges,
     vertex.label.color=V(venice.sn)$types)

write_graph(venice.sn,"resources/venice-social-network.graphml",format="graphml")
