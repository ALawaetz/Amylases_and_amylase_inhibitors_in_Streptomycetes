import os
import subprocess

# conda environment CAZyme_annotation_main installed with dbcan

# === CONFIGURATION ===
base_dir = "/Users/andreaslawaetz/Streptomyces/Angeliga_project/SCOG/faa_files"
db_dir = "/Users/andreaslawaetz/Streptomyces/dbcan/db"
output_base = "/Users/andreaslawaetz/Streptomyces/dbcan_results"

# Make sure output directory exists
os.makedirs(output_base, exist_ok=True)

# === Search and Process Each protein.faa ===
for accession_folder in os.listdir(base_dir):
    full_path = os.path.join(base_dir, accession_folder)

    # Skip if not a directory
    if not os.path.isdir(full_path):
        continue

    # Path to expected protein.faa
    faa_file = os.path.join(full_path, "ncbi_dataset", "data", accession_folder, "protein.faa")

    if os.path.exists(faa_file):
        print(f"Processing: {faa_file}")

        # Output folder per accession
        output_dir = os.path.join(output_base, accession_folder)
        os.makedirs(output_dir, exist_ok=True)

        # Build command
        cmd = [
            "run_dbcan", "CAZyme_annotation",
            "--input_raw_data", faa_file,
            "--mode", "protein",
            "--output_dir", output_dir,
            "--db_dir", db_dir
        ]

        # Run dbCAN
        subprocess.run(cmd, check=True)
    else:
        print(f"[WARNING] protein.faa not found for {accession_folder}")

print("All done.")
