reinitialize

# =========================
# 1. Load docking PDBs
# =========================
load /Users/andreaslawaetz/Streptomyces/alphafold/CaoLab/Pullulanase_Mutant_N_to_HConformer3D_COMPOUND_CID_98117041765742886146/Pullulanase_Mutant_N_to_H_Conformer3D_COMPOUND_CID_9811704_out_1.-7.7.complex.pdb, WT
load /Users/andreaslawaetz/Streptomyces/alphafold/CaoLab/Pullulanase_MutantConformer3D_COMPOUND_CID_98117041764950592526/Pullulanase_Mutant_Conformer3D_COMPOUND_CID_9811704_out_3.-8.4.complex.pdb, Mutant

# =========================
# 2. Rename objects for simplicity
# =========================
# Rename objects
set_name WT_0001, WT_protein
set_name Mutant_0001, MUT_protein
set_name WT_0002, WT_ligand
set_name Mutant_0002, MUT_ligand


# =========================
# 3. Create complexes (protein + ligand)
# =========================
create WT_complex, WT_protein WT_ligand
create MUT_complex, MUT_protein MUT_ligand

# disable originals
delete WT_protein
delete WT_ligand
delete MUT_protein
delete MUT_ligand

# =========================
# 4. Align proteins (ligands move with proteins)
# =========================
# Use WT as reference
super MUT_complex and polymer.protein, WT_complex and polymer.protein


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

#####################################
# colour and label catalytic residues
# MUT
# K305
# N306
show sticks, MUT_complex and polymer.protein and resi 305
label MUT_complex and polymer.protein and resi 305 and name CA, "LYS305"
set label_position, [3, 2, 20], MUT_complex and polymer.protein and resi 305

show sticks, MUT_complex and polymer.protein and resi 306
label MUT_complex and polymer.protein and resi 306 and name CA, "ASN306"
set label_position, [-2.5, 0, 20], MUT_complex and polymer.protein and resi 306
# Change label colors
set label_color, white, MUT_complex and polymer.protein and resi 305 and name CA
set label_color, white, MUT_complex and polymer.protein and resi 306 and name CA


show sticks, WT_complex and polymer.protein and resi 305
label WT_complex and polymer.protein and resi 305 and name CA, "LYS305"
set label_position, [2, 1, 20], WT_complex and polymer.protein and resi 305

show sticks, WT_complex and polymer.protein and resi 306
label WT_complex and polymer.protein and resi 306 and name CA, "HIS306"
set label_position, [-2.5, 1, 20], WT_complex and polymer.protein and resi 306
# Change label colors
set label_color, white, WT_complex and polymer.protein and resi 305 and name CA
set label_color, white, WT_complex and polymer.protein and resi 306 and name CA


set label_size, 22
set label_position, [0,0,20]

set_view (\
    -0.704089761,    0.047751475,   -0.708503067,\
     0.460261643,   -0.729095638,   -0.506529093,\
    -0.540756941,   -0.682739735,    0.491374403,\
     0.000014171,   -0.000031531, -109.150512695,\
    12.227708817,  -31.579023361,  -18.051069260,\
    77.464416504,  140.832733154,  -20.000000000 )

# disable all
# enable WT_complex
# draw
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_pullulanase_MUT_reverted_to_WT.png, 2000, 2000, dpi=300, ray=0

disable all
enable MUT_complex
draw
png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pymol_pullulanase_MUT.png, 2000, 2000, dpi=300, ray=0



# =========================
# # 6. Select binding site residues (within 6 Å of ligand)
# # =========================
# select acarbose_site_WT, byres (WT_complex and polymer.protein within 6 of WT_complex and not polymer.protein)
# show sticks, acarbose_site_WT
# color green, acarbose_site_WT

# select acarbose_site_MUT, byres (MUT_complex and polymer.protein within 6 of WT_complex and not polymer.protein)
# show sticks, acarbose_site_MUT
# color green, acarbose_site_MUT


# #####################################
# # colour and label catalytic residues
# # WT
# # D210
# # E237
# # K213
# show sticks, WT_complex and polymer.protein and resi 210
# show sticks, WT_complex and polymer.protein and resi 237
# label WT_complex and polymer.protein and resi 213 and name NZ, "LYS213"
# set label_position, [-0.4, -2.3, 20], WT_complex and polymer.protein and resi 213
# #label WT_complex and polymer.protein and resi 237 and name CA, "Glu237"
# #color red, WT_complex and polymer.protein and resi 210
# #color warmpink, WT_complex and polymer.protein and resi 237
# # colour and label acarbose_resistance residues
# # WT
# # H240
# # D298
# show sticks, WT_complex and polymer.protein and resi 240
# show sticks, WT_complex and polymer.protein and resi 298
# label WT_complex and polymer.protein and resi 240 and name CD2, "HIS240"
# set label_position, [0.0, 1.2, 20], WT_complex and polymer.protein and resi 240
# label WT_complex and polymer.protein and resi 298 and name OD2, "ASP298"
# set label_position, [-0.5, -1.4, 20], WT_complex and polymer.protein and resi 298
# #color blue, WT_complex and polymer.protein and resi 240
# #color blue, WT_complex and polymer.protein and resi 298
# # Change label colors
# set label_color, white, WT_complex and polymer.protein and resi 213 and name NZ
# set label_color, white, WT_complex and polymer.protein and resi 240 and name CD2
# set label_color, white, WT_complex and polymer.protein and resi 298 and name OD2


# ##################################################
# # WT
# # show hydrogen bonds between protein and acarbose
# dist hbonds_protein_acarbose_WT, (WT_complex and polymer.protein), (WT_complex and not polymer.protein), mode=2, label=0
# color yellow, hbonds_protein_acarbose_WT
# # Polar contacts between residues inside the binding site and the rest of the protein
# dist acarbose_site_polar_conts_WT_to_all, acarbose_site_WT, WT_complex and polymer.protein, quiet=1, mode=2, label=0, reset=1
# color cyan, acarbose_site_polar_conts_WT_to_all
# # show hydrogen bonds between acarbose_resistant_ASP and protein
# dist acarbose_resistant_ASP_WT, (WT_complex and polymer.protein and resi 298), (WT_complex and polymer.protein), mode=2, label=0
# color cyan, acarbose_resistant_ASP_WT
# # show hydrogen bonds between acarbose_resistant_HIS and protein
# dist acarbose_resistant_HIS_WT, (WT_complex and polymer.protein and resi 240), (WT_complex and polymer.protein), mode=2, label=0
# color cyan, acarbose_resistant_HIS_WT



# #####################################
# # colour and label catalytic residues
# # MUT
# # D205
# # E232
# # K208
# show sticks, MUT_complex and polymer.protein and resi 205
# show sticks, MUT_complex and polymer.protein and resi 232
# label MUT_complex and polymer.protein and resi 208 and name NZ, "LYS208"
# set label_position, [-0.2, -1.9, 20], MUT_complex and polymer.protein and resi 208
# #label MUT_complex and polymer.protein and resi 237 and name CA, "Glu237"
# #color red, MUT_complex and polymer.protein and resi 205
# #color warmpink, MUT_complex and polymer.protein and resi 232
# # colour and label acarbose_resistance residues
# # WT
# # G235
# # T293
# show sticks, MUT_complex and polymer.protein and resi 235
# show sticks, MUT_complex and polymer.protein and resi 293
# label MUT_complex and polymer.protein and resi 235 and name CA, "GLY235"
# set label_position, [1.7, 1.5, 20], MUT_complex and polymer.protein and resi 235
# label MUT_complex and polymer.protein and resi 293 and name OG1, "THR293"
# set label_position, [-1.3, 1.0, 20], MUT_complex and polymer.protein and resi 293
# #color blue, MUT_complex and polymer.protein and resi 235
# #color blue, MUT_complex and polymer.protein and resi 293
# # Change label colors
# set label_color, white, MUT_complex and polymer.protein and resi 208 and name NZ
# set label_color, white, MUT_complex and polymer.protein and resi 235 and name CA
# set label_color, white, MUT_complex and polymer.protein and resi 293 and name OG1


# ##################################################
# # MUT
# # show hydrogen bonds between protein and acarbose
# dist hbonds_protein_acarbose_MUT, (MUT_complex and polymer.protein), (MUT_complex and not polymer.protein), mode=2, label=0
# color yellow, hbonds_protein_acarbose_MUT
# # Polar contacts between residues inside the binding site and the rest of the protein
# dist acarbose_site_polar_conts_MUT_to_all, acarbose_site_MUT, MUT_complex and polymer.protein, quiet=1, mode=2, label=0, reset=1
# color cyan, acarbose_site_polar_conts_MUT_to_all
# # show hydrogen bonds between acarbose_resistant_THR and protein
# dist acarbose_resistant_THR_MUT, (MUT_complex and polymer.protein and resi 293), (MUT_complex and polymer.protein), mode=2, label=0
# color cyan, acarbose_resistant_THR_MUT
# # show hydrogen bonds between acarbose_resistant_THR and protein
# dist acarbose_resistant_GLY_MUT, (MUT_complex and polymer.protein and resi 235), (MUT_complex and polymer.protein), mode=2, label=0
# color cyan, acarbose_resistant_GLY_MUT
