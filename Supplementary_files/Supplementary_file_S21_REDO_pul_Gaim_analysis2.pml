reinitialize

load /Users/andreaslawaetz/Streptomyces/alphafold/Peptide_docking_clusPro/Gaim/pul_WT_fromAca_ADomain_Gaim/model.000.00.pdb
set_name rec.pdb, pul_wt
set_name lig.000.00.pdb, tendamistat

load /Users/andreaslawaetz/Streptomyces/alphafold/Peptide_docking_clusPro/Gaim/pul_long_ADomain_Gaim/model.000.00.pdb
set_name rec.pdb, pul_mut_long
set_name lig.000.00.pdb, tendamistat_PML
create pul_mut_long_complex, pul_mut_long tendamistat_PML

load /Users/andreaslawaetz/Streptomyces/alphafold/Pul_MUT_short_AmyDomain.pdb, pul_mut_short
load /Users/andreaslawaetz/Streptomyces/alphafold/Peptide_docking_clusPro/pig_pancr_amy_w_tendamistat.cif, pig

remove pig and not polymer.protein

super pul_mut_short, pul_wt
super pul_mut_long_complex, pul_wt
super pig and chain P, pul_wt
super pul_mut_long, pul_mut_long_complex
super tendamistat_PML, pul_mut_long_complex

split_chains

enable all

color cyan, pul_wt
color green, tendamistat
color orange, pig_P
color green, pig_T
color yellow, pul_mut_short
color magenta, pul_mut_long
color green, tendamistat_PML


hide everything
show surface, pul_wt
# show cartoon, pul_wt
show surface, tendamistat
show cartoon, tendamistat
set transparency, 0.5, tendamistat
select clashes_pul_wt, byres (pul_wt within 1.0 of tendamistat) and not name H*
color red, clashes_pul_wt
color blue, pul_wt and (resi 257+291)
# dist hbonds_pul_wt, pul_wt, tendamistat, quiet=1, mode=2, label=0, reset=1
# select hbonds_pul_wt_residues, byres (pul_wt within 3.5 of tendamistat)
# show sticks, hbonds_pul_wt_residues
# select hbonds_pul_wt_tenda_residues, byres (tendamistat within 3.5 of pul_wt)
# show sticks, hbonds_pul_wt_tenda_residues
# png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pul_resistance/pul_WT_from_Aca_&_tendamistat.png, 2000, 2000, dpi=300, ray=0

hide everything
show surface, pig_P
# show cartoon, pig_P
show surface, pig_T
show cartoon, pig_T
set transparency, 0.5, pig_T
select clashes_pig, byres (pig_P within 1.0 of pig_T) and not name H*
color red, clashes_pig
color blue, pig_P and (resi 197+233)
# dist hbonds_pig, pig_P, pig_T, quiet=1, mode=2, label=0, reset=1
# select hbonds_pig_residues, byres (pig_P within 3.5 of pig_T)
# show sticks, hbonds_pig_residues
# select hbonds_pig_tenda_residues, byres (pig_T within 3.5 of pig_P)
# show sticks, hbonds_pig_tenda_residues

# # png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pul_resistance/pig_Amy_&_tendamistat.png, 2000, 2000, dpi=300, ray=0

hide everything
show surface, pul_mut_long
show surface, tendamistat_PML
show cartoon, tendamistat_PML
set transparency, 0.5, tendamistat_PML
select clashes_pul_long, byres (pul_mut_long within 1.0 of tendamistat_PML) and not name H*
color red, clashes_pul_long
color blue, pul_mut_long and (resi 252+286)
# # # png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pul_resistance/pul_MUT_long_&_tendamistat.png, 2000, 2000, dpi=300, ray=0

hide everything
show surface, pul_mut_short
set transparency, 0.5, pul_mut_short
# show cartoon, pul_mut_short
show surface, tendamistat
show cartoon, tendamistat
set transparency, 0.5, tendamistat
select clashes_pul_short, byres (pul_mut_short within 1.0 of tendamistat) and not name H*
color red, clashes_pul_short
color blue, pul_mut_short and (resi 252+286)
# # png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pul_resistance/pul_MUT_short_&_tendamistat.png, 2000, 2000, dpi=300, ray=0

set_view (\
     0.286761910,   -0.824160099,   -0.488362670,\
    -0.856250286,    0.008112520,   -0.516482353,\
     0.429638058,    0.566282570,   -0.703369260,\
    -0.000110567,    0.000071310, -131.063552856,\
     0.233016938,   -9.367357254,    7.259516239,\
  -129452.484375000, 129714.750000000,  -20.000000000 )


# color cyan, pul_wt
# color green, tendamistat
# color orange, pig_P
# color green, pig_T
# color yellow, pul_mut_short
# color magenta, pul_mut_long
# color green, tendamistat_PML


# hide everything
# show cartoon, pul_wt
# show cartoon, pul_mut_long
# show cartoon, pul_mut_short
# show sticks, clashes_pul_long
# show sticks, clashes_pul_short
# color magenta, clashes_pul_long
# color yellow, clashes_pul_short
# show sticks, pul_wt and (resi 416+222)
# show sticks, pul_mut_long and (resi 411+217)
# show sticks, pul_mut_short and (resi 411+79+217)

# select base_217, pul_mut_short and resi 217 and name NZ
# select acid_411, pul_mut_short and resi 411 and name OD1+OD2
# distance saltbridge_217_411, base_217, acid_411, cutoff=5.0
# set dash_width, 4
# color paleyellow, saltbridge_217_411
# set label_position, (0.5, 1., 2)

# label pul_mut_short and resi 411 and name CA, "ASP411"
# set label_position, [-1, -5.5, 10], pul_mut_short and resi 411
# label pul_mut_short and resi 217 and name CA, "LYS217"
# set label_position, [1, 6.5, 10], pul_mut_short and resi 217

# set label_size, 22

# set_view (\
#      0.475351363,   -0.526834965,   -0.704600453,\
#     -0.266976535,    0.676727057,   -0.686114311,\
#      0.838304102,    0.514261067,    0.181041300,\
#     -0.000032783,    0.000115126,  -94.010017395,\
#      3.362733364,   -1.219094992,   -7.612080097,\
#     69.474876404,  118.678070068,  -20.000000000 )

# # # # # png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pul_resistance/pul_overlay.png, 2000, 2000, dpi=300, ray=0



# show surface, tendamistat
# set transparency, 0.5, tendamistat


# # # png /Users/andreaslawaetz/Streptomyces/Amylase_paper/Figures/pul_resistance/pul_overlay_&_tendamistat.png, 2000, 2000, dpi=300, ray=0



