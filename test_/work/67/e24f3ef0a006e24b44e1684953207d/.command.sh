#!/bin/bash -euo pipefail
mini_align -i seqs.fastq.gz -r NC_000962.3.fasta -p Positive_tmp -t 4 -m

# keep only mapped reads
samtools view --write-index -F 4 Positive_tmp.bam -o Positive.bam##idx##Positive.bam.bai

# get stats from bam
stats_from_bam -o Positive.bamstats -s Positive.bam.summary -t 4 Positive.bam
