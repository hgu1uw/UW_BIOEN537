#!/bin/bash -euo pipefail
# whatshap needs read group
samtools addreplacerg -r "ID:sample1	SM:sample1" -o sample1.rg.bam sample1.bam
samtools index sample1.rg.bam

# index fasta
samtools faidx NC_000962.3.fasta

read_count=`samtools view -c sample1.rg.bam`

if [ "${read_count}" -gt "0" ]; then

  # phase variants
  whatshap phase         -o sample1.phased.vcf         --reference=NC_000962.3.fasta         sample1.mpileup.annotated.processed.PASS.vcf sample1.rg.bam
else
  cp template.vcf sample1.phased.vcf
fi

# add codon numbers to those variants which are noit in our db but we want to phase because they could affect the same codon
vcf-annotator sample1.phased.vcf NC_000962.3.gb > sample1.phased.codon.vcf

# process phased variants
workflow-glue process_whatshap       --phased_vcf sample1.phased.codon.vcf       --out_vcf sample1.phased.processed.vcf       --template template.vcf       --sample sample1

# sort
bcftools sort sample1.phased.processed.vcf > sample1.phased.processed.sorted.vcf

# re-annotate our newly phased variants
bgzip sample1.phased.processed.sorted.vcf
tabix sample1.phased.processed.sorted.vcf.gz
tabix variant_db.sorted.normalised.vcf.gz

bcftools annotate       -c CHROM,POS,REF,GENE,STRAND,AA,FEATURE_TYPE,EFFECT,GENE_LOCUS,WHO_POS,ANTIBIOTICS,PROTEIN_ID,HGVS_NUCLEOTIDE,HGVS_PROTEIN,CODON_NUMBER,ORIGIN       --remove INFO/FeatureType,INFO/IsSynonymous,INFO/IsTransition,INFO/IsGenic,INFO/IsPseudo,INFO/Inference,INFO/AltCodon,INFO/AltAminoAcid,INFO/Note,INFO/AminoAcidChange,INFO/Product,INFO/SNPCodonPosition       -h bcftools_annotate_header.txt       -a variant_db.sorted.normalised.vcf.gz       sample1.phased.processed.sorted.vcf.gz > sample1.phased.processed.sorted.annotated.vcf

# filter out those without annotation - they are not in the WHO database
bcftools filter -i 'INFO/ORIGIN=="WHO_CANONICAL"' sample1.phased.processed.sorted.annotated.vcf > sample1.final.vcf
