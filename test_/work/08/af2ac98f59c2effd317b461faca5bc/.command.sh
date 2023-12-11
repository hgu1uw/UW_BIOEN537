#!/bin/bash -euo pipefail
samtools view -q 1 -bh Positive.bam | bedtools coverage -d -a TB_amplicons.bed -b - > Positive.bedtools-coverage.bed
