#!/bin/bash -euo pipefail
# whatshap needs read group
samtools addreplacerg -r "ID:Positive	SM:Positive" -o Positive.rg.bam Positive.bam
samtools index Positive.rg.bam

# index fasta
samtools faidx NC_000962.3.fasta

read_count=`samtools view -c Positive.rg.bam`

if [ "${read_count}" -gt "0" ]; then

  # phase variants
  whatshap phase         -o Positive.phased.vcf         --reference=NC_000962.3.fasta         Positive.mpileup.annotated.processed.PASS.vcf Positive.rg.bam
else
  cp template.vcf Positive.phased.vcf
fi

# add codon numbers to those variants which are noit in our db but we want to phase because they could affect the same codon
vcf-annotator Positive.phased.vcf NC_000962.3.gb > Positive.phased.codon.vcf

# process phased variants
workflow-glue process_whatshap       --phased_vcf Positive.phased.codon.vcf       --out_vcf Positive.phased.processed.vcf       --template template.vcf       --sample Positive

# sort
bcftools sort Positive.phased.processed.vcf > Positive.phased.processed.sorted.vcf

# re-annotate our newly phased variants
bgzip Positive.phased.processed.sorted.vcf
tabix Positive.phased.processed.sorted.vcf.gz
tabix variant_db.sorted.normalised.vcf.gz

bcftools annotate       -c CHROM,POS,REF,GENE,STRAND,AA,FEATURE_TYPE,EFFECT,GENE_LOCUS,WHO_POS,ANTIBIOTICS,PROTEIN_ID,HGVS_NUCLEOTIDE,HGVS_PROTEIN,CODON_NUMBER,ORIGIN       --remove INFO/FeatureType,INFO/IsSynonymous,INFO/IsTransition,INFO/IsGenic,INFO/IsPseudo,INFO/Inference,INFO/AltCodon,INFO/AltAminoAcid,INFO/Note,INFO/AminoAcidChange,INFO/Product,INFO/SNPCodonPosition       -h bcftools_annotate_header.txt       -a variant_db.sorted.normalised.vcf.gz       Positive.phased.processed.sorted.vcf.gz > Positive.phased.processed.sorted.annotated.vcf

# filter out those without annotation - they are not in the WHO database
bcftools filter -i 'INFO/ORIGIN=="WHO_CANONICAL"' Positive.phased.processed.sorted.annotated.vcf > Positive.final.vcf
