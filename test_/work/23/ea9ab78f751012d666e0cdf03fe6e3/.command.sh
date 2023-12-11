#!/bin/bash -euo pipefail
samtools view -q 1 -bh Negative.bam | bedtools coverage -d -a TB_amplicons.bed -b - > Negative.bedtools-coverage.bed
