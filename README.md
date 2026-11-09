# Assignment-4-Intro-to-R

# DNA Sequence Analysis

## Info 

- **Programmer:** Yash
- **Language:** R
- **Date** 11/08/26

- **Purpose:** Reads a FASTA DNA sequence, reports selected bases, creates its reverse complement, and counts A, C, G, and T in consecutive 1,000-base segments.

## Required Files

- `chr1_GL383518v1_alt.fa` — Input FASTA file containing the DNA sequence. Make sure it is in the working directory or in your files

## What the program does
The program prints the A, C, G, and T counts for the first kilo base, the sums for all segments, and any segments whose sums differ from their expected lengths. A final segment shorter than 1,000 bases is expected if the sequence length is not divisible by 1,000. Ambiguous bases such as N are not included in the A, C, G, T counts. It also uses slicing and indexing to find nucleotide letter on specific number like 10th letter = c
