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

tree <- ape::read.tree('/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/04_tbe.raxml.support_modified2')
tree <-midpoint.root(tree)
options(repr.plot.width=8, repr.plot.height=6)

metadata <- read.csv('/Users/andreaslawaetz/Streptomyces/Amylase_paper/Re_References_updated_2/Revisions/Master_table_with_amyPhyloGroups_known_clusters_and_inhibitors_GatorAcarviosin_GatorAcarbose_gatorValidamycinA_gatorBafilomycin_tendamisatPFAM_tendamisatSMART_tendamisatPFAM_gatorTrestatin_acarviosinMinReq_NAMES_UPDATED_APRIL_2026.csv')
p <- ggtree(tree, layout = "circular")+
  geom_tiplab2(size = 0, align = TRUE, linetype = "dotted") # aligned labels with connector lines
p

# GH_13_occurences
p <- p +
  new_scale_fill() +
  geom_fruit(
    data = metadata,
    geom = geom_tile,
    mapping = aes(y = tip_label, fill = Group_1_amylase),
    alpha = 0.9,
    width = 0.01,
    offset = 0.03,
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
    mapping = aes(y = tip_label, fill = resistant_amylase),
    alpha = 0.9,
    width = 0.01,
    offset = 0.025,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'Resistant pullulanase',
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
    mapping = aes(y = tip_label, fill = Group_2_amylase),
    alpha = 0.9,
    width = 0.01,
    offset = 0.025,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = expression(alpha~"-1,4-amylases"),
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
    width = 0.01,
    offset = 0.025,
    color = 'black',
    size = 0.05,
    show.legend = TRUE
  ) +
  scale_fill_gradient(
    name = 'CMD-amylases',
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
    mapping = aes(y = tip_label, fill = gator_acarbose),
    alpha = 0.9,
    width = 0.01,
    offset = 0.025,
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
    guide = guide_colorbar(order = 4)
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
    width = 0.01,
    offset = 0.025,
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
    width = 0.01,
    offset = 0.025,
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
    mapping = aes(y = tip_label, fill = tendamistatPFAM),
    alpha = 0.9,
    width = 0.01,
    offset = 0.025,
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

# Extract data and add bootstrap numeric column
p$data <- p$data %>%
  mutate(bootstrap = as.numeric(label))

p <- p +
  ggnewscale::new_scale_color() + 
  geom_point2(
    aes(subset = !isTip & bootstrap >= 0, color = bootstrap),
    size = 1
  ) +
  scale_color_viridis_c(option = "plasma", name = "Bootstrap") +
  theme(
    legend.position = "inside",
    legend.position.inside = c(0.9, 0.4),
    legend.justification = c("left", "center"),
    
    legend.title = element_text(size = 26),  # Bootstrap title bigger
    legend.text = element_text(size = 16)    # Bootstrap numbers smaller
  )

p

# Shrinks tree toward the center
t <- p + xlim_tree(0.7)  # smaller = tree takes less radial space
t
q <- t + geom_tiplab2(size = 2, align = TRUE, offset = 0.085, linetype = NA) # aligned labels with connector lines
q

q <- q + theme(
  legend.key.height = unit(0.20, "cm"),
  legend.key.width  = unit(0.25, "cm"),
  legend.text = element_text(size = 5),
  legend.title = element_text(size = 8),
  legend.box = "vertical",
  legend.position = c(0.92, 0.73),
  # ↓ reduce space between legends
  legend.spacing.y = unit(0.05, "cm"),
  legend.margin = margin(t = 0.05, r = 0.05, b = 0.05, l = 0.05, unit = "cm")
)

q

ggsave(
  "/Users/andreaslawaetz/Streptomyces/Amylase_paper/Re_References_updated_2/Revisions/Figure_2_w_names_updated_April_2026_w_bootstrap.pdf", 
  plot = q,
  width = 15, height = 15, dpi = 600
)

