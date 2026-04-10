#!/bin/bash
# run_raxml_ng.sh
# A script to run RAxML-NG on a protein alignment

# -------------------------------
# User parameters
# -------------------------------
MSA_FILE="/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/all_secreted_amylases_aligned_wo_seed.fa"   # your aligned sequences
MODEL="LG+G"                                   # substitution model
BS_TREES=100                                   # number of bootstrap replicates
THREADS=4                                      # number of CPU threads
PREFIX="mytree"                                # output file prefix


# -------------------------------
# Run RAxML-NG
# -------------------------------
raxml-ng --all \
         --msa $MSA_FILE \
         --model $MODEL \
         --bs-trees $BS_TREES \
         --threads $THREADS \
         --prefix $PREFIX \