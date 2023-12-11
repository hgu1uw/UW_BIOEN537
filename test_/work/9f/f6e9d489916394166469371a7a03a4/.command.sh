#!/bin/bash -euo pipefail
#bcftools doesn't like non-normed regions
bcftools norm -m +both variant_db.sorted.normalised.vcf.gz -Oz -o variant_db.sorted.normalised.vcf.gz.norm
tabix variant_db.sorted.normalised.vcf.gz.norm

# run mpileup
bcftools mpileup       --max-depth 8000       --threads 4       -BI       -Q 1       --ff SECONDARY,UNMAP       --annotate INFO/AD,INFO/ADF,INFO/ADR       -R TB_amplicons.bed       -O v       -f NC_000962.3.fasta sample1.bam > sample1.mpileup.vcf

bgzip sample1.mpileup.vcf
tabix sample1.mpileup.vcf.gz

bcftools norm --remove-duplicates -Oz sample1.mpileup.vcf.gz -o sample1.mpileup.vcf.gz.dedup
tabix sample1.mpileup.vcf.gz.dedup

bcftools norm -m- -Oz sample1.mpileup.vcf.gz.dedup -o sample1.mpileup.vcf.gz.norm
tabix sample1.mpileup.vcf.gz.norm

bcftools view sample1.mpileup.vcf.gz.norm > sample1.mpileup.vcf.gz.norm.vcf


# call variants from pileup
workflow-glue process_mpileup       --template template.vcf       --mpileup sample1.mpileup.vcf.gz.norm.vcf       --out_vcf sample1.mpileup.annotated.processed.vcf       --sample sample1       -a 0.1       -d 5       -b 1000       -p 20

# filter PASS variants
bcftools view --exclude-type indels sample1.mpileup.annotated.processed.vcf | bcftools view -f 'PASS' - > sample1.mpileup.annotated.processed.PASS.vcf
