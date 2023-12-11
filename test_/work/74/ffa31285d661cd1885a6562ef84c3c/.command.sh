#!/bin/bash -euo pipefail
mini_align -i seqs.fastq.gz -r NC_000962.3.fasta -p Negative_tmp -t 4 -m

# keep only mapped reads
samtools view --write-index -F 4 Negative_tmp.bam -o Negative.bam##idx##Negative.bam.bai

# get stats from bam
stats_from_bam -o Negative.bamstats -s Negative.bam.summary -t 4 Negative.bam
