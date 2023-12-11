#!/bin/bash -euo pipefail
#bcftools doesn't like non-normed regions
bcftools norm -m +both variant_db.sorted.normalised.vcf.gz -Oz -o variant_db.sorted.normalised.vcf.gz.norm
tabix variant_db.sorted.normalised.vcf.gz.norm

# run mpileup
bcftools mpileup       --max-depth 8000       --threads 4       -BI       -Q 1       --ff SECONDARY,UNMAP       --annotate INFO/AD,INFO/ADF,INFO/ADR       -R TB_amplicons.bed       -O v       -f NC_000962.3.fasta Positive.bam > Positive.mpileup.vcf

bgzip Positive.mpileup.vcf
tabix Positive.mpileup.vcf.gz

bcftools norm --remove-duplicates -Oz Positive.mpileup.vcf.gz -o Positive.mpileup.vcf.gz.dedup
tabix Positive.mpileup.vcf.gz.dedup

bcftools norm -m- -Oz Positive.mpileup.vcf.gz.dedup -o Positive.mpileup.vcf.gz.norm
tabix Positive.mpileup.vcf.gz.norm

bcftools view Positive.mpileup.vcf.gz.norm > Positive.mpileup.vcf.gz.norm.vcf


# call variants from pileup
workflow-glue process_mpileup       --template template.vcf       --mpileup Positive.mpileup.vcf.gz.norm.vcf       --out_vcf Positive.mpileup.annotated.processed.vcf       --sample Positive       -a 0.1       -d 5       -b 1000       -p 20

# filter PASS variants
bcftools view --exclude-type indels Positive.mpileup.annotated.processed.vcf | bcftools view -f 'PASS' - > Positive.mpileup.annotated.processed.PASS.vcf
