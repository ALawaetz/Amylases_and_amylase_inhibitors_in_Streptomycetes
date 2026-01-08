#!/usr/bin/env python3
"""
consensus_and_rank.py
Usage: python3 consensus_and_rank.py alignment.fasta output_dir
Produces:
 - output_dir/consensus.fasta
 - output_dir/identities.csv (sequence_id, identity_fraction, identity_percent)
"""
import sys, os
from collections import Counter
from Bio import AlignIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Align import MultipleSeqAlignment
import csv

def compute_consensus(aln, threshold=0.5, gap_char='-'):
    """
    aln: Bio.Align.MultipleSeqAlignment
    threshold: fraction (0..1) required to call a residue; else 'X'
    gap_char: char used for gaps in alignment
    """
    ncols = aln.get_alignment_length()
    consensus_chars = []
    for i in range(ncols):
        col = [rec.seq[i] for rec in aln]
        counts = Counter(col)
        total_non_gaps = sum(v for k,v in counts.items() if k != gap_char)
        if total_non_gaps == 0:
            consensus_chars.append(gap_char)
            continue
        most_common, count = max(((k,v) for k,v in counts.items() if k != gap_char), key=lambda x: x[1])
        freq = count / total_non_gaps
        if freq >= threshold:
            consensus_chars.append(most_common)
        else:
            consensus_chars.append('X')
    return ''.join(consensus_chars)

def identity_to_consensus(seq, consensus, gap_char='-'):
    matches = 0
    total = 0
    for a,b in zip(str(seq), consensus):
        total += 1
        if a == b:
            matches += 1
    return matches / total if total>0 else 0.0

def main():
    if len(sys.argv) < 3:
        print("Usage: python3 consensus_and_rank.py alignment.fasta output_dir")
        sys.exit(1)

    aln_path = sys.argv[1]
    outdir = sys.argv[2]

    # make output directory if it doesn't exist
    os.makedirs(outdir, exist_ok=True)

    # try common formats
    aln = None
    for fmt in ("fasta","clustal","stockholm","phylip"):
        try:
            aln = AlignIO.read(aln_path, fmt)
            print(f"Read alignment as {fmt} with {len(aln)} sequences, length {aln.get_alignment_length()}")
            break
        except Exception:
            continue
    if aln is None:
        print("Could not read alignment. Try converting to FASTA or CLUSTAL.")
        sys.exit(1)

    threshold = 0.5   # majority consensus
    consensus = compute_consensus(aln, threshold=threshold)

    # write consensus FASTA
    consensus_file = os.path.join(outdir, "consensus.fasta")
    rec = SeqRecord(Seq(consensus), id="CONSENSUS", description=f"threshold={threshold}")
    AlignIO.write(MultipleSeqAlignment([rec]), consensus_file, "fasta")
    print(f"Wrote {consensus_file}")

    # compute identities
    results = []
    for r in aln:
        ident = identity_to_consensus(r.seq, consensus)
        results.append((r.id, ident))

    results.sort(key=lambda x: x[1], reverse=True)

    # write CSV
    csv_file = os.path.join(outdir, "identities.csv")
    with open(csv_file,"w",newline="") as fh:
        w = csv.writer(fh)
        w.writerow(["seq_id","identity_fraction","identity_percent"])
        for sid,frac in results:
            w.writerow([sid, f"{frac:.6f}", f"{frac*100:.4f}"])
    print(f"Wrote {csv_file}")

    print("Top 5 sequences most similar to consensus:")
    for sid,frac in results[:5]:
        print(f"  {sid}: {frac*100:.2f}%")

if __name__ == "__main__":
    main()
