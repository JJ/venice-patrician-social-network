library(igraph)

data <- read.csv("resources/family-pairs.csv",header=FALSE)
venice.sn <- graph.data.frame(data.frame(data$V1,data$V2),directed=F)
plot(venice.sn)
V(venice.sn)$degree <- degree(venice.sn)
cnet <- cluster_edge_betweenness(venice.sn)

library(Dict)
node.type <- read.csv("resources/family-positions.csv")
node.type.dict <- Dict$new()

for (r in 1:nrow(node.type)) {
  print(node.type[r,])
  node.type.dict[ node.type[r,"Family.name"] ] <-  node.type[r,"Positions"]
}

positions <- c()
shapes <- c()

for (r in 1:nrow(V(venice.sn))) {
  
  print(r)
  if (node.type.dict[r]) {
    positions <- append(positions, node.type[r,"Positions"])
    shapes <- append(shapes,
                     ifelse(node.type[r,"Positions"] == "Doge",
                            "square",
                            ifelse(node.type(r,"Positions") == "Dogaressa","rectangle","circle")))
    
  } else {
    positions <- append(positions,"None")
    shapes <- append(shapes,"sphere")
  }
  
}
plot(cnet,venice.sn,shape=V(venice.sn)$shape)
