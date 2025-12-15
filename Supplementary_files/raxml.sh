#!/bin/bash
# run_raxml_ng.sh
# A simple script to run RAxML-NG on a protein alignment

# -------------------------------
# User parameters
# -------------------------------
MSA_FILE="/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/alignment/amylases_in_inhibitor_strains_and_non_inhibitor_strains_ALIGNED_no_seed.faa"   # your aligned sequences
MODEL="LG+G"                                   # substitution model
BS_TREES=100                                   # number of bootstrap replicates
THREADS=4                                      # number of CPU threads
PREFIX="mytree"                                # output file prefix


# -------------------------------
# Run RAxML-NG
# -------------------------------
raxml-ng --search1 \
         --msa $MSA_FILE \
         --model $MODEL \
         --threads $THREADS \
         --prefix $PREFIX \
