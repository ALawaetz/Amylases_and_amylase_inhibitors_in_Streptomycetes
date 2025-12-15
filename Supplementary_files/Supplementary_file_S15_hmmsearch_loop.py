### blast against all angelikas genomes
### Have to type python3 in terminal
import os
import subprocess
from pathlib import Path
from glob import glob

# 1. build an HMM from your seed alignment
# hmmbuild tendamistat.hmm seed_alignment.fasta

# === INPUTS ===
reference_root = "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/acarviosin/gator_redo/results21_Amy_is_only_Opt_allBGC_we30/windows_genbanks_faa"
output_dir = "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/amylase_inhibitors/acarviosin/gator_redo/results21_Amy_is_only_Opt_allBGC_we30/hmmer_search"
hmmer_file = '/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tree_amylases/alignment/alpha_amylases/hmmer/coelicolor/tendamistat.hmm'

# === SETTINGS ===
os.makedirs(output_dir, exist_ok=True)

# === Step 1: Find all reference .faa files ===
reference_files = glob(f"{reference_root}/*.faa", recursive=True)


for ref in reference_files:
    ref_path = Path(ref)
    ref_name = ref_path.parts[-1]  # e.g. GCF_000009765.2
    out_name = output_dir + '/' + ref_name + '_hits.tbl'

    cmd = [
        "hmmsearch", 
        "-E", "10", 
        "--tblout", f'{out_name}',
        "--cpu", "4",
        f'{hmmer_file}', 
        f'{ref_path}'
    ]

    subprocess.run(cmd, check=True)
