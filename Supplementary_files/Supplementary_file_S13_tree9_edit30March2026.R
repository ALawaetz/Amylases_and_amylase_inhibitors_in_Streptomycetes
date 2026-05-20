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


metadata <- read.table(
  "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/all_tip_labels_w_group_numbers_METADATA_FORMAT_copy_copy.txt",
  sep = "\t",
  header = TRUE
)

# Make sure column names are nice
colnames(metadata) <- c("tip_label", "Cluster")

# Join metadata with tree tip labels
metadata <- metadata %>%
  mutate(tip_label = as.character(tip_label),
         Cluster = as.factor(Cluster))  # treat cluster as categorical


manual_colors <- c(
  "Clade 1: Pullulanases" = "red",
  "Clade 2: Alpha-1,4-amylases" = "green",
  "Clade 3: CMD-like amylases" = "blue"
)



# Build tree and color tips by cluster
p <- ggtree(tree, layout = "circular") %<+% metadata +
  geom_tiplab(aes(color = Cluster), size = 0.8, show.legend = FALSE) +
  geom_tippoint(aes(color = Cluster), shape = 16, size = 0, show.legend = TRUE) +
  guides(color = guide_legend(override.aes = list(shape = 16, size = 10))) +
  #theme(legend.position = "right") +
  scale_color_manual(
    values = manual_colors,
    breaks = c(
      "Clade 1: Pullulanases",
      "Clade 2: Alpha-1,4-amylases",
      "Clade 3: CMD-like amylases"
    ),
    labels = c(
      "1: Pullulanases",
      expression("2: " * alpha * "-1,4-amylases"),
      "3: CMD-like amylases"
    ),
    name = 'Clades' # removes legend title
  ) +
  theme(
    legend.position = "inside",
    legend.position.inside = c(0.80, 0.4),
    legend.justification = c("left", "center"),
    legend.text = element_text(size = 30),
  )

# Extract data and add bootstrap numeric column
p$data <- p$data %>%
  mutate(bootstrap = as.numeric(label))

p <- p +
  ggnewscale::new_scale_color() + 
  geom_point2(
    aes(subset = !isTip & bootstrap >= 70, color = bootstrap),
    size = 1
  ) +
  scale_color_viridis_c(option = "plasma", name = "Bootstrap") +
  theme(
    legend.position = "inside",
    legend.position.inside = c(0.8, 0.35),
    legend.justification = c("left", "center"),
    
    legend.title = element_text(size = 30),  # Bootstrap title bigger
    legend.text = element_text(size = 20)    # Bootstrap numbers smaller
  )

p

# Shrinks tree toward the center
t <- p + xlim_tree(0.1)  # smaller = tree takes less radial space
t


ggsave(
  "/Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/SUBMIT/revised/Figure_1a_w_bootstrap.pdf", 
  plot = t,
  width = 30, height = 30, dpi = 600, limitsize = FALSE
)

