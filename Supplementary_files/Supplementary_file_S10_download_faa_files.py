import subprocess
import os
import pandas as pd
import sys

### Run in conda environment with ncbi_datasets_cli installed

# === Input ===
# List of accession numbers (GCFs)
file = '/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/tip_labels.csv'
df = pd.read_csv(file, sep = ',', header = 0)

accession_list = df['tip_label'].tolist()


# Output folder
output_dir = "/Users/andreaslawaetz/Streptomyces/genomes_test/"
os.makedirs(output_dir, exist_ok=True)

# === Download loop ===
for acc in accession_list:
    print(f"Downloading {acc}...")
    zip_path = os.path.join(output_dir, f"{acc}.zip")

    # Download using datasets CLI
    subprocess.run([
        "datasets", "download", "genome", "accession", acc,
        "--include", "protein",
        "--filename", zip_path
    ])

    # Unzip contents into a subfolder
    subprocess.run([
        "unzip", "-o", zip_path, "-d", os.path.join(output_dir, acc)
    ])


