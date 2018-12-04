
library("tidyverse")
# Reference: https://github.com/STATWORX/blog/tree/master/flowchart.
library("igraph")
dir <- "../tidyselect/R"
stopifnot(dir.exists(dir))
network <- helfRlein::get_network(dir = dir)

viz_network <- network$igraph
viz_network %>% plot()
# l <- layout_with_fr(g1)
# colrs <- rainbow(length(unique(V(g1)$color)))
# 
# plot(g1,
#      edge.arrow.size=.1,
#      edge.width = 5*E(g1)$weight/max(E(g1)$weight),
#      vertex.shape="none",
#      vertex.label.color=colrs[V(g1)$color],
#      vertex.label.color="black",
#      vertex.size = 20,
#      vertex.color = colrs[V(g1)$color],
#      edge.color="steelblue1",
#      layout = l)
# legend(x=0,
#        unique(V(g1)$folder), pch=21,
#        pt.bg= colrs[unique(V(g1)$color)],
#        pt.cex=2, cex=.8, bty="n", ncol=1)

network_tidy <-
  network$matrix %>%
  as_tibble() %>% 
  rownames_to_column("file") %>% 
  gather(f, matches, -matches("file")) %>% 
  mutate_at(vars(matches), funs(as.integer))
network_tidy

network_filt <-
  network_tidy %>%
  filter(matches > 0L)

network_tidy %>%
  filter(matches > 0L) %>% 
  count(f, sort = TRUE)
