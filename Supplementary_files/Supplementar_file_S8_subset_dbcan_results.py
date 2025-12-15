import pandas as pd
import os
import re
from Bio import SeqIO
from pathlib import Path

### Subset dbcan results for GH13 proteins

base_dir = Path('/Users/andreaslawaetz/Streptomyces/dbcan_results')
def clean_category(cat):
    # Remove subcategory suffixes (e.g. GH13_16 -> GH13)
    cat = re.sub(r"(_\d+)+$", "", cat)
    return cat
    # Loop through all subfolders
for folder in base_dir.iterdir():
    if folder.is_dir():
        accession = folder.name
        overview_path = folder / "overview.tsv" 
        if overview_path.exists():
            df = pd.read_csv(overview_path, sep = '\t', header = 0)
            # Split rows where 'Recommend Results' contains '|'
            df = df.assign(**{
                'Recommend Results': df['Recommend Results'].str.split('|')
            }).explode('Recommend Results').reset_index(drop=True)
            recommend_results2 = []
            for item in df['Recommend Results'].tolist():
                recommend_results2.append(clean_category(item))
            df['Recommend_results_base'] = recommend_results2
            df = df[df["Recommend_results_base"] == "GH13"]
            df.to_csv(f'{folder}/overview_GH13.tsv', sep = '\t', index = False)
