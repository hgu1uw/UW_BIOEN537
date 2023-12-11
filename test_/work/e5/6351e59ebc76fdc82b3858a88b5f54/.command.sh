#!/bin/bash -euo pipefail
minimap2 --version | sed 's/^/minimap2,/' >> versions.txt
samtools --version | head -n 1 | sed 's/ /,/' >> versions.txt
bedtools --version | sed 's/ /,/' >> versions.txt
bcftools --version | grep bcftools | sed 's/ /,/' >> versions.txt
