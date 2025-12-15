library(ape)
library(phytools)
library(ggtree)
library(ggplot2)
library(ggnewscale)
library(ggtreeExtra)
library(tidyr)
library(dplyr)
library(viridis)
library(cowplot)


# Load tree
tree <- ape::read.tree('/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/mytree.raxml.support')
tree <- midpoint.root(tree)
options(repr.plot.width=8, repr.plot.height=6)


# Basic circular tree
p <- ggtree(tree, layout = "circular") + 
  geom_tiplab(size = 3)
p

p <- p + geom_text(aes(label=node), hjust=-0.3, size=2)

p
ggsave(
  "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/figures/amylases_tree_highres_unrooted_circular.pdf", 
  plot = p,
  width = 1000, height = 1000, dpi = 600, limitsize = FALSE
)


metadata <- read.table(
  "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/all_tip_labels_w_group_numbers_TendamistatRelated.txt",
  sep = "\t",
  header = TRUE
)

# Make sure column names are nice
colnames(metadata) <- c("tip_label", "cluster")

# Join metadata with tree tip labels
metadata <- metadata %>%
  mutate(tip_label = as.character(tip_label),
         cluster = as.factor(cluster))  # treat cluster as categorical


manual_colors <- c(
  "Clade 1: Pullulanases" = "red",
  "Clade 2: Amylases" = "green",
  "Clade 3: Cyclomaltodextrin-like amylases" = "blue"
)

manual_colors <- c(
  "BGC_related" = "red",
  "not_BGC_related" = "lightgrey"
)

manual_colors <- c(
  "tendamistat_related" = "red",
  "not_tendamistat_related" = "lightgrey"
)

# Build tree and color tips by cluster
p <- ggtree(tree, layout = "circular") %<+% metadata +
  geom_tiplab(aes(color = cluster, alpha = cluster), size = 1.5, show.legend = FALSE) +
  #geom_tippoint(aes(color = cluster), shape = 16, size = 2) +
  scale_color_manual(values = c(
    "tendamistat_related" = "black",
    "not_tendamistat_related" = "grey"
  )) +
  scale_alpha_manual(values = c(
    "tendamistat_related" = 1,
    "not_tendamistat_related" = 0.5
  )) +
  guides(color = guide_legend(override.aes = list(shape = 16, size = 3))) +
  theme(legend.position = "right")

p




ggsave(
  "/Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/Figure_tendamistat_related_amylases.pdf", 
  plot = p,
  width = 30, height = 30, dpi = 600
)
