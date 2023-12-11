#!/bin/bash -euo pipefail
mini_align -i seqs.fastq.gz -r NC_000962.3.fasta -p sample1_tmp -t 4 -m

# keep only mapped reads
samtools view --write-index -F 4 sample1_tmp.bam -o sample1.bam##idx##sample1.bam.bai

# get stats from bam
stats_from_bam -o sample1.bamstats -s sample1.bam.summary -t 4 sample1.bam
