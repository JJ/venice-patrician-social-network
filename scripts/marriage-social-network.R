library(igraph)

marriages <- read.csv("data/venice_marriages_puga_treffler_families.csv")
marriages <- marriages[ marriages$husband_familyname_std != '' & marriages$wife_familyname_std != '',]
marriages <- marriages[ marriages$husband_familyname_std != marriages$wife_familyname_std,]
marriages <- marriages[ marriages$year <= 1797 | is.na(marriages$year) ,]
marriages.sn <- graph.data.frame(data.frame(marriages$husband_familyname_std,marriages$wife_familyname_std),directed=F)
plot(marriages.sn)
V(marriages.sn)$degree <- degree(marriages.sn)

V(marriages.sn)$betweenness <- betweenness(marriages.sn)
V(marriages.sn)$eigen <- eigen_centrality(marriages.sn)
V(marriages.sn)$pr <- unname(unlist(page_rank(marriages.sn)$vector))

plot(marriages.sn,
     layout=layout_in_circle(marriages.sn),
     vertex.size=V(marriages.sn)$betweenness/500,
     vertex.label.cex= V(marriages.sn)$degree/500,
     vertex.label.degree=V(marriages.sn)$degree)


