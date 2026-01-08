

the_seed="/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/alignment/alpha_amylases/alpha_amylase_cd00551_seed.txt"
input_fasta="/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/all_secreted_amylases.fa"
output_alignment="/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/all_secreted_amylases_aligned_w_amySeed_cd00551.fa"


mafft --seed "$the_seed" "$input_fasta" > "$output_alignment"
