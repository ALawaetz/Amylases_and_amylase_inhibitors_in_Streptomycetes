### This script is to do a GATOR-GC run
### The GATOR script at "/Users/andreaslawaetz/miniconda/envs/gator-gc/bin/gator-gc" terminates if genome files are not
### formatted correctly, so I added 
                # try:
                #     locus, start_position, end_position = split_hit[0], split_hit[1], split_hit[2]
                # except IndexError:
                #     genome_id = query_protein.split('_')[0] 
                #     print(f"[WARNING] Skipping malformed hit from genome '{genome_id}': {hit}")
                #     bad_hit_count += 1
                #     continue
### to the script at around line 766 in code

import os 


genome_folder = '/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/genbank_files_modified/' # has to end with /
output_folder = '/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/acarbose/Gator' # this folder cannot be existing before run
required_proteins = '/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/acarbose/Gator_input_genes/acarbose_BGC_required.txt'
optional_proteins = '/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/acarbose/Gator_input_genes/acarbose_BGC_optional.txt'

os.system(f'pre-gator-gc -g {genome_folder}/ -o {output_folder} -v')

os.system(f'gator-gc -rq {required_proteins} -op {optional_proteins} -g {genome_folder} -d {output_folder} -v -o {f"{output_folder}/results"}')
