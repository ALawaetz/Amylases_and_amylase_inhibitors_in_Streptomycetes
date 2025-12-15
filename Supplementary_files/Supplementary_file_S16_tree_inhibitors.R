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

tree <- ape::read.tree('/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/04_tbe.raxml.support')
tree <-midpoint.root(tree)
options(repr.plot.width=8, repr.plot.height=6)

metadata <- read.csv('/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/Master_table_with_amyPhyloGroups_known_clusters_and_inhibitors_GatorAcarviosin_GatorAcarbose_gatorValidamycinA_gatorBafilomycin_tendamisatPFAM_tendamisatSMART_tendamisatPFAM_gatorTrestatin_acarviosinMinReq.csv')
p <- ggtree(tree, layout = "circular") +
  geom_tiplab2(size = 1.5, align = TRUE, linetype = "dotted", align.length = 0.01) # aligned labels with connector lines
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = Group_1_amylase),
    alpha = 0.9,
    width = 0.025,
    offset = 0.22,
    color = 'black',
    size = 0.05,
    show.legend = TRUE,
  ) +
  scale_fill_gradient(
    name = 'Pullulanases',
    low = "white",    # lowest value = white
    high = "red",   # highest value = black
    limits = c(0,
               max(metadata$Group_1_amylase)),
    guide = guide_colorbar(order = 1)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = Group_2_amylase),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Alpha-1,4-amylases',
    low = "white",    # lowest value = white
    high = "green",   # highest value = black
    limits = c(0,
               max(metadata$Group_2_amylase)),
    guide = guide_colorbar(order = 2)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = Group_3_amylase),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Cyclomaltodextrinases',
    low = "white",    # lowest value = white
    high = "blue",   # highest value = black
    limits = c(0,
               max(metadata$Group_3_amylase)),
    guide = guide_colorbar(order = 3)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = resistant_amylase),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Resistant amylase',
    low = "white",    # lowest value = white
    high = "red3",   # highest value = black
    limits = c(0,
               max(metadata$resistant_amylase)),
    guide = guide_colorbar(order = 2)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = gator_acarbose),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Acarbose',
    low = "white",    # lowest value = white
    high = "black",   # highest value = black
    limits = c(0,
               max(metadata$gator_acarbose)),
    guide = guide_colorbar(order = 3)
  )
p


# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = gator_acarviosin),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Acarviostatin',
    low = "white",    # lowest value = white
    high = "darkgrey",   # highest value = black
    limits = c(0,
               1),
    guide = guide_colorbar(order = 5)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = gator_trestatin),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Trestatin',
    low = "white",    # lowest value = white
    high = "grey",   # highest value = black
    limits = c(0,
               1),
    guide = guide_colorbar(order = 6)
  )
p


# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = gator_validamycinA),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'gator_validamycinA',
    low = "white",    # lowest value = white
    high = "black",   # highest value = black
    limits = c(0,
               1),
    guide = guide_colorbar(order = 8)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = tendamistatPFAM),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Tendamistat',
    low = "white",    # lowest value = white
    high = "purple",   # highest value = black
    limits = c(0,
               max(metadata$tendamistatPFAM)),
    guide = guide_colorbar(order = 7)
  )
p


# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = tendamistatSMART),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'tendamistatSMART',
    low = "white",    # lowest value = white
    high = "black",   # highest value = black
    limits = c(0,
               max(metadata$tendamistatSMART)),
    guide = guide_colorbar(order = 10)
  )
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = gator_acarviosin_minReq),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'gator_acarviosin_minReq',
    low = "white",    # lowest value = white
    high = "black",   # highest value = black
    limits = c(0,
               max(metadata$gator_acarviosin_minReq)),
    guide = guide_colorbar(order = 11)
  )
p



# GH_13_occurences
#p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = gator_bafilomycin),
    alpha = 0.9,
    width = 0.025,
    offset = 0.06,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'gator_bafilomycin',
    low = "white",    # lowest value = white
    high = "black",   # highest value = black
    limits = c(0,
               max(metadata$gator_bafilomycin)),
    guide = guide_colorbar(order = 10)
  )
p



p <- p + theme(
  legend.key.height = unit(0.25, "cm"),
  legend.key.width  = unit(0.25, "cm"),
  legend.text = element_text(size = 5),
  legend.title = element_text(size = 8),
  legend.box = "vertical",
  legend.position = "right",
  # ↓ reduce space between legends
  legend.spacing.y = unit(0.05, "cm"),
  legend.margin = margin(t = 0.05, r = 0.05, b = 0.05, l = 0.05, unit = "cm")
)

p

ggsave(
  "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/figures/tree_inhibitors_resistant_amylases.pdf", 
  plot = p,
  width = 12, height = 12, dpi = 600
)
