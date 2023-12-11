#!/bin/bash -euo pipefail
samtools view -q 1 -bh sample1.bam | bedtools coverage -d -a TB_amplicons.bed -b - > sample1.bedtools-coverage.bed
