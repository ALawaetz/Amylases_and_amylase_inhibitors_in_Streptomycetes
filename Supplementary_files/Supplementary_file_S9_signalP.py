import os 
from pathlib import Path
import sys

# signalp6 installed locally via conda

base_dir = Path('/Users/andreaslawaetz/Streptomyces/dbcan_results')


for folder in base_dir.iterdir():
    if folder.is_dir():
        overview_path = folder / "overview_GH13.tsv.faa" 
        if overview_path.exists():
            os.system(f'signalp6 --fastafile {overview_path} --organism other --output_dir {folder}/SignalP --format txt --mode fast')