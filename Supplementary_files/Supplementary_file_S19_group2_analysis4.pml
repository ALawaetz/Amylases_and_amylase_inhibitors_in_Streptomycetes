reinitialize

# =========================
# 1. Load docking PDBs
# =========================
load /Users/andreaslawaetz/Streptomyces/alphafold/CaoLab/Group2_WTConformer3D_COMPOUND_CID_98117041764938826184/Group2_WT_Conformer3D_COMPOUND_CID_9811704_out_3.-6.6.complex.pdb, WT
load /Users/andreaslawaetz/Streptomyces/alphafold/CaoLab/Group2_MutantConformer3D_COMPOUND_CID_98117041764939448082/Group2_Mutant_Conformer3D_COMPOUND_CID_9811704_out_3.-6.7.complex.pdb, Mutant
load /Users/andreaslawaetz/Streptomyces/alphafold/CaoLab/stepping_back/revert_WT_to_MUT/CaoLab/WT_6b_7aConformer3D_COMPOUND_CID_98117041765541006790/WT_6b_7a_Conformer3D_COMPOUND_CID_9811704_out_3.-6.7.complex.pdb, WT_reverted
load /Users/andreaslawaetz/Streptomyces/alphafold/CaoLab/stepping_back/CaoLab/narrow_6b_and_7aConformer3D_COMPOUND_CID_98117041765532691132/narrow_6b_and_7a_Conformer3D_COMPOUND_CID_9811704_out_2.-6.7.complex.pdb, Mutant_reverted

# =========================
# 2. Rename objects for simplicity
# =========================
# Rename objects
set_name WT_0001, WT_protein
set_name Mutant_0001, MUT_protein
set_name WT_0002, WT_ligand
set_name Mutant_0002, MUT_ligand

set_name WT_reverted_0001, WT_reverted_protein
set_name Mutant_reverted_0001, MUT_reverted_protein
set_name WT_reverted_0002, WT_reverted_ligand
set_name Mutant_reverted_0002, MUT_reverted_ligand

# =========================
# 3. Create complexes (protein + ligand)
# =========================
create WT_complex, WT_protein WT_ligand
create MUT_complex, MUT_protein MUT_ligand

create WT_reverted_complex, WT_reverted_protein WT_reverted_ligand
create MUT_reverted_complex, MUT_reverted_protein MUT_reverted_ligand

# disable originals
delete WT_protein
delete WT_ligand
delete MUT_protein
delete MUT_ligand

delete WT_reverted_protein
delete WT_reverted_ligand
delete MUT_reverted_protein
delete MUT_reverted_ligand

# =========================
# 4. Align proteins (ligands move with proteins)
# =========================
# Use WT as reference
super MUT_complex and polymer.protein, WT_complex and polymer.protein
super WT_reverted_complex and polymer.protein, WT_complex and polymer.protein
super MUT_reverted_complex and polymer.protein, WT_complex and polymer.protein


# =========================
# 5. Color proteins and ligands
# =========================
hide everything
show surface, WT_complex and polymer.protein
set transparency, 0.5, WT_complex and polymer.protein
show sticks, WT_complex and not polymer.protein
color cyan, WT_complex and polymer.protein
color cyan, WT_complex and not polymer.protein and elem C

show surface, MUT_complex and polymer.protein
set transparency, 0.5, MUT_complex and polymer.protein
show sticks, MUT_complex and not polymer.protein
color cyan, MUT_complex and polymer.protein
color cyan, MUT_complex and not polymer.protein and elem C

show surface, WT_reverted_complex and polymer.protein
set transparency, 0.5, WT_reverted_complex and polymer.protein
show sticks, WT_reverted_complex and not polymer.protein
color cyan, WT_reverted_complex and polymer.protein
color cyan, WT_reverted_complex and not polymer.protein and elem C

show surface, MUT_reverted_complex and polymer.protein
set transparency, 0.5, MUT_reverted_complex and polymer.protein
show sticks, MUT_reverted_complex and not polymer.protein
color cyan, MUT_reverted_complex and polymer.protein
color cyan, MUT_reverted_complex and not polymer.protein and elem C

# =========================
# 6. Select binding site residues (within 6 Å of ligand)
# =========================
select acarbose_site_WT, byres (WT_complex and polymer.protein within 6 of WT_complex and not polymer.protein)
show sticks, acarbose_site_WT
color green, acarbose_site_WT

select acarbose_site_MUT, byres (MUT_complex and polymer.protein within 6 of WT_complex and not polymer.protein)
show sticks, acarbose_site_MUT
color green, acarbose_site_MUT

select acarbose_site_WT_reverted, byres (WT_reverted_complex and polymer.protein within 6 of WT_complex and not polymer.protein)
show sticks, acarbose_site_WT_reverted
color green, acarbose_site_WT_reverted

select acarbose_site_MUT_reverted, byres (MUT_reverted_complex and polymer.protein within 6 of WT_complex and not polymer.protein)
show sticks, acarbose_site_MUT_reverted
color green, acarbose_site_MUT_reverted



###################################################################################################################
###################################################################################################################
###################################################################################################################

#####################################
# colour and label catalytic residues
# WT
# D210
# E237
# K213
show sticks, WT_complex and polymer.protein and resi 210
show sticks, WT_complex and polymer.protein and resi 237
label WT_complex and polymer.protein and resi 213 and name NZ, "LYS213"
set label_position, [-0.4, -2.3, 20], WT_complex and polymer.protein and resi 213
#label WT_complex and polymer.protein and resi 237 and name CA, "Glu237"
#color red, WT_complex and polymer.protein and resi 210
#color warmpink, WT_complex and polymer.protein and resi 237
# colour and label acarbose_resistance residues
# WT
# H240
# D298
show sticks, WT_complex and polymer.protein and resi 240
show sticks, WT_complex and polymer.protein and resi 298
label WT_complex and polymer.protein and resi 240 and name CD2, "HIS240"
set label_position, [0.0, 1.2, 20], WT_complex and polymer.protein and resi 240
label WT_complex and polymer.protein and resi 298 and name OD2, "ASP298"
set label_position, [-0.5, -1.4, 20], WT_complex and polymer.protein and resi 298
#color blue, WT_complex and polymer.protein and resi 240
#color blue, WT_complex and polymer.protein and resi 298
# Change label colors
set label_color, white, WT_complex and polymer.protein and resi 213 and name NZ
set label_color, white, WT_complex and polymer.protein and resi 240 and name CD2
set label_color, white, WT_complex and polymer.protein and resi 298 and name OD2


##################################################
# WT
# show hydrogen bonds between protein and acarbose
dist hbonds_protein_acarbose_WT, (WT_complex and polymer.protein), (WT_complex and not polymer.protein), mode=2, label=0
color yellow, hbonds_protein_acarbose_WT
# Polar contacts between residues inside the binding site and the rest of the protein
dist acarbose_site_polar_conts_WT_to_all, acarbose_site_WT, WT_complex and polymer.protein, quiet=1, mode=2, label=0, reset=1
color cyan, acarbose_site_polar_conts_WT_to_all
# show hydrogen bonds between acarbose_resistant_ASP and protein
dist acarbose_resistant_ASP_WT, (WT_complex and polymer.protein and resi 298), (WT_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_ASP_WT
# show hydrogen bonds between acarbose_resistant_HIS and protein
dist acarbose_resistant_HIS_WT, (WT_complex and polymer.protein and resi 240), (WT_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_HIS_WT



#####################################
# colour and label catalytic residues
# MUT
# D205
# E232
# K208
show sticks, MUT_complex and polymer.protein and resi 205
show sticks, MUT_complex and polymer.protein and resi 232
label MUT_complex and polymer.protein and resi 208 and name NZ, "LYS208"
set label_position, [-0.2, -1.9, 20], MUT_complex and polymer.protein and resi 208
#label MUT_complex and polymer.protein and resi 237 and name CA, "Glu237"
#color red, MUT_complex and polymer.protein and resi 205
#color warmpink, MUT_complex and polymer.protein and resi 232
# colour and label acarbose_resistance residues
# WT
# G235
# T293
show sticks, MUT_complex and polymer.protein and resi 235
show sticks, MUT_complex and polymer.protein and resi 293
label MUT_complex and polymer.protein and resi 235 and name CA, "GLY235"
set label_position, [1.7, 1.5, 20], MUT_complex and polymer.protein and resi 235
label MUT_complex and polymer.protein and resi 293 and name OG1, "THR293"
set label_position, [-1.3, 1.0, 20], MUT_complex and polymer.protein and resi 293
#color blue, MUT_complex and polymer.protein and resi 235
#color blue, MUT_complex and polymer.protein and resi 293
# Change label colors
set label_color, white, MUT_complex and polymer.protein and resi 208 and name NZ
set label_color, white, MUT_complex and polymer.protein and resi 235 and name CA
set label_color, white, MUT_complex and polymer.protein and resi 293 and name OG1


##################################################
# MUT
# show hydrogen bonds between protein and acarbose
dist hbonds_protein_acarbose_MUT, (MUT_complex and polymer.protein), (MUT_complex and not polymer.protein), mode=2, label=0
color yellow, hbonds_protein_acarbose_MUT
# Polar contacts between residues inside the binding site and the rest of the protein
dist acarbose_site_polar_conts_MUT_to_all, acarbose_site_MUT, MUT_complex and polymer.protein, quiet=1, mode=2, label=0, reset=1
color cyan, acarbose_site_polar_conts_MUT_to_all
# show hydrogen bonds between acarbose_resistant_THR and protein
dist acarbose_resistant_THR_MUT, (MUT_complex and polymer.protein and resi 293), (MUT_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_THR_MUT
# show hydrogen bonds between acarbose_resistant_THR and protein
dist acarbose_resistant_GLY_MUT, (MUT_complex and polymer.protein and resi 235), (MUT_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_GLY_MUT


###############################
###############################
###############################
###############################
#####################################
# colour and label catalytic residues
# WT_reverted
# D210
# E237
# K213
show sticks, WT_reverted_complex and polymer.protein and resi 210
show sticks, WT_reverted_complex and polymer.protein and resi 237
label WT_reverted_complex and polymer.protein and resi 213 and name NZ, "LYS213"
set label_position, [0.7, -1.5, 20], WT_reverted_complex and polymer.protein and resi 213
#label WT_complex and polymer.protein and resi 237 and name CA, "Glu237"
#color red, WT_reverted_complex and polymer.protein and resi 210
#color warmpink, WT_reverted_complex and polymer.protein and resi 237
# colour and label acarbose_resistance residues
# WT_reverted
# H240 becomes GLY240
# D298 becomes THR298
show sticks, WT_reverted_complex and polymer.protein and resi 240
show sticks, WT_reverted_complex and polymer.protein and resi 298
label WT_reverted_complex and polymer.protein and resi 240 and name CA, "GLY240"
set label_position, [1.5, 1.2, 20], WT_reverted_complex and polymer.protein and resi 240
label WT_reverted_complex and polymer.protein and resi 298 and name OG1, "THR298"
set label_position, [-1.5, 1.3, 20], WT_reverted_complex and polymer.protein and resi 298
#color blue, WT_complex and polymer.protein and resi 240
#color blue, WT_complex and polymer.protein and resi 298
# Change label colors
set label_color, white, WT_reverted_complex and polymer.protein and resi 213 and name NZ
set label_color, white, WT_reverted_complex and polymer.protein and resi 240 and name CA
set label_color, white, WT_reverted_complex and polymer.protein and resi 298 and name OG1


##################################################
# WT
# show hydrogen bonds between protein and acarbose
dist hbonds_protein_acarbose_WT_reverted, (WT_reverted_complex and polymer.protein), (WT_reverted_complex and not polymer.protein), mode=2, label=0
color yellow, hbonds_protein_acarbose_WT_reverted
# Polar contacts between residues inside the binding site and the rest of the protein
dist acarbose_site_polar_conts_WT_reverted_to_all, acarbose_site_WT_reverted, WT_reverted_complex and polymer.protein, quiet=1, mode=2, label=0, reset=1
color cyan, acarbose_site_polar_conts_WT_reverted_to_all
# show hydrogen bonds between acarbose_resistant_ASP and protein
dist acarbose_resistant_ASP_WT_reverted, (WT_reverted_complex and polymer.protein and resi 298), (WT_reverted_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_ASP_WT_reverted
# show hydrogen bonds between acarbose_resistant_HIS and protein
dist acarbose_resistant_HIS_WT_reverted, (WT_reverted_complex and polymer.protein and resi 240), (WT_reverted_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_HIS_WT_reverted



#####################################
# colour and label catalytic residues
# MUT
# D205
# E232
# K208
show sticks, MUT_reverted_complex and polymer.protein and resi 205
show sticks, MUT_reverted_complex and polymer.protein and resi 232
label MUT_reverted_complex and polymer.protein and resi 208 and name NZ, "LYS208"
set label_position, [-0.4, -2.3, 20], MUT_reverted_complex and polymer.protein and resi 208
#label MUT_complex and polymer.protein and resi 237 and name CA, "Glu237"
#color red, MUT_reverted_complex and polymer.protein and resi 205
#color warmpink, MUT_reverted_complex and polymer.protein and resi 232
# colour and label acarbose_resistance residues
# WT
# G235 becomes HIS235
# T293 becomes ASP293
show sticks, MUT_reverted_complex and polymer.protein and resi 235
show sticks, MUT_reverted_complex and polymer.protein and resi 293
label MUT_reverted_complex and polymer.protein and resi 235 and name CD2, "HIS235"
label MUT_reverted_complex and polymer.protein and resi 293 and name OD2, "ASP293"
set label_position, [1.0, 1.0, 20], MUT_reverted_complex and polymer.protein and resi 235
set label_position, [-1.3, 0.5, 20], MUT_reverted_complex and polymer.protein and resi 293

# Change label colors
set label_color, white, MUT_reverted_complex and polymer.protein and resi 208 and name NZ
set label_color, white, MUT_reverted_complex and polymer.protein and resi 235 and name CD2
set label_color, white, MUT_reverted_complex and polymer.protein and resi 293 and name OD2

set label_position, [0,0,20]


##################################################
# MUT
# show hydrogen bonds between protein and acarbose
dist hbonds_protein_acarbose_MUT_reverted, (MUT_reverted_complex and polymer.protein), (MUT_reverted_complex and not polymer.protein), mode=2, label=0
color yellow, hbonds_protein_acarbose_MUT_reverted
# Polar contacts between residues inside the binding site and the rest of the protein
dist acarbose_site_polar_conts_MUT_reverted_to_all, acarbose_site_MUT_reverted, MUT_reverted_complex and polymer.protein, quiet=1, mode=2, label=0, reset=1
color cyan, acarbose_site_polar_conts_MUT_reverted_to_all
# show hydrogen bonds between acarbose_resistant_THR and protein
dist acarbose_resistant_THR_MUT_reverted, (MUT_reverted_complex and polymer.protein and resi 293), (MUT_reverted_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_THR_MUT_reverted
# show hydrogen bonds between acarbose_resistant_THR and protein
dist acarbose_resistant_GLY_MUT_reverted, (MUT_reverted_complex and polymer.protein and resi 235), (MUT_reverted_complex and polymer.protein), mode=2, label=0
color cyan, acarbose_resistant_GLY_MUT_reverted


set label_size, 22
set label_position, [0,0,20]



# save fig
# png figure_fast.png, 2000, 2000, dpi=300, ray=0
# for high resolution
# png figure_slow.png, 2000, 2000, dpi=300, ray=1

# to get view coordinates
# get_view

# set view
set_view (\
     0.127167031,    0.971007407,    0.202419594,\
    -0.156194553,    0.221134305,   -0.962654471,\
    -0.979505718,    0.090801165,    0.179786652,\
     0.000004720,   -0.000009514,  -96.924491882,\
   -11.542943954,  -11.634748459,   -0.639652848,\
  -46897.609375000, 47091.460937500,  -20.000000000 )


##########################################################
################# Save figures ###########################
# WT
# disable all
# enable WT_complex hbonds_protein_acarbose_WT
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_WT.png, 2000, 2000, dpi=300, ray=0
# draw

# disable hbonds_protein_acarbose_WT
# enable acarbose_site_polar_conts_WT_to_all acarbose_resistant_ASP_WT acarbose_resistant_HIS_WT
# hide sticks, WT_complex and not polymer.protein
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_WT_wo_acarbose.png, 2000, 2000, dpi=300, ray=0
# draw

# # MUT
# disable all
# enable MUT_complex hbonds_protein_acarbose_MUT
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_MUT.png, 2000, 2000, dpi=300, ray=0
# draw

# disable hbonds_protein_acarbose_MUT
# enable acarbose_site_polar_conts_MUT_to_all acarbose_resistant_THR_MUT acarbose_resistant_GLY_MUT
# hide sticks, MUT_complex and not polymer.protein
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_MUT_wo_acarbose.png, 2000, 2000, dpi=300, ray=0
# draw


# WT_reverted
# disable all
# enable WT_reverted_complex hbonds_protein_acarbose_WT_reverted
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_WT_reverted.png, 2000, 2000, dpi=300, ray=0
# draw

# disable hbonds_protein_acarbose_WT_reverted
# enable acarbose_site_polar_conts_WT_reverted_to_all acarbose_resistant_ASP_WT_reverted acarbose_resistant_HIS_WT_reverted
# hide sticks, WT_reverted_complex and not polymer.protein
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_WT_reverted_wo_acarbose.png, 2000, 2000, dpi=300, ray=0
# draw

# # MUT
# disable all
# enable MUT_reverted_complex hbonds_protein_acarbose_MUT_reverted
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_MUT_reverted.png, 2000, 2000, dpi=300, ray=0
# draw

# disable hbonds_protein_acarbose_MUT_reverted
# enable acarbose_site_polar_conts_MUT_reverted_to_all acarbose_resistant_THR_MUT_reverted acarbose_resistant_GLY_MUT_reverted
# hide sticks, MUT_reverted_complex and not polymer.protein
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_MUT_reverted_wo_acarbose.png, 2000, 2000, dpi=300, ray=0
# draw

set_view (\
     0.006377478,    0.987931788,   -0.154760569,\
    -0.096204504,   -0.153439388,   -0.983464062,\
    -0.995341480,    0.021160841,    0.094064280,\
     0.000004720,   -0.000009514,  -96.924491882,\
   -11.542943954,  -11.634748459,   -0.639652848,\
  -46897.609375000, 47091.460937500,  -20.000000000 )

disable all
enable WT_complex MUT_complex 
# enable WT_reverted_complex MUT_reverted_complex
hide sticks, WT_complex and not polymer.protein
hide sticks, MUT_complex and not polymer.protein
# hide sticks, WT_reverted_complex and not polymer.protein
# hide sticks, MUT_reverted_complex and not polymer.protein
color magenta, MUT_complex
color yellow WT_reverted_complex
color red MUT_reverted_complex
set transparency, 0.8, WT_complex and polymer.protein
set transparency, 0.8, MUT_complex and polymer.protein
# set transparency, 0.8, WT_reverted_complex and polymer.protein
# set transparency, 0.8, MUT_reverted_complex and polymer.protein

color green, WT_complex and polymer.protein and resi 298
set label_position, [1.0, 1.5, 20], WT_complex and polymer.protein and resi 298
set label_position, [-2.0, 0.5, 20], MUT_complex and polymer.protein and resi 293
set label_position, [0.5, 1.3, 20], WT_complex and polymer.protein and resi 240
set label_position, [0.0, 3.5, 20], MUT_complex and polymer.protein and resi 235
set label_position, [1.0, -1.5, 20], WT_complex and polymer.protein and resi 213
set label_position, [-1.3, -0.2, 20], MUT_complex and polymer.protein and resi 208

label WT_complex and polymer.protein and resi 301 and name OD2, "ASP301"
set label_position, [0, -1.3, 20], WT_complex and polymer.protein and resi 301
set label_color, white, WT_complex and polymer.protein and resi 301 and name OD2

label MUT_complex and polymer.protein and resi 296 and name OD2, "ASP296"
set label_position, [1.3, 0, 20], MUT_complex and polymer.protein and resi 296
set label_color, white, MUT_complex and polymer.protein and resi 296 and name OD2

# show sticks, WT_complex and polymer.protein and resi 238
# show sticks, MUT_complex and polymer.protein and resi 233

draw

# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_WT_MUT_overlay.png, 2000, 2000, dpi=300, ray=0






# set label position
# set label_position, [-0.2, -1.5, 20], WT_complex and polymer.protein and resi 213
# set label colour
# set label_color, white, MUT_complex and resi 296
