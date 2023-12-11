
# nanopore_alignment

A Python package for nanopore sequence alignment and primer design. This package provides tools to set up an environment for nanopore sequence analysis and to design primers from DNA sequences.

## Introduction

The primer Design function is to optimize primer design from a given fasta file. Currently, it is working with a single sequence (a single fasta file)


The Sequence Alignment function is a subprocess of the "wf_tb_amr" workfrom from Nanopore Sequencing. It is a workflow for determining the antibiotic resistance of Mycobacterium tuberculosis targeted sequencing samples. It handles multiplexed sequencing runs and provides clear reports summarizing the predicted resistance profile of each sample based on genetic variants discovered.


### Sequence Alignment Workflow Details

- Align reads to NC_000962.3 reference genome (minmap2)
- Use mpileup to determine base composition of pre-defined variants, “genotyping” (bcftools)
- Phase variants (whatshap)
- Report results

## Prerequisites

Before installing `nanopore_alignment`, ensure that you have the following software installed on your system:
- Java
- Docker
- Nextflow

These are external dependencies that cannot be installed via pip and need to be set up separately.

## Installation

To install the `nanopore_alignment` package, follow these steps:

   pip install nanoseq

## Usage

### Sequence Alignment

Important: `fastq_data_path` should be the directory containing the `sample_sheet.csv` and the subfolders with the fastq files, not the folder directly containing the fastq files.
e.g. The test_nanopore folder contains the accurate structure and all the files to run the function. Your 'fastq_data_path' should be pointing to this folder instead of the individual fastq files.

This workflow also requires a sample sheet which identifies test samples and controls. The sample sheet must have three columns: `barcode`, `alias`, and `type`:
- `barcode`: the barcode of the sample (e.g., barcode02).
- `alias`: a unique identifier for the sample.
- `type`: can be `test_sample`, `positive_control`, or `no_template_control`.


To run sequence alignment:

```python
from nanopore_alignment.alignment import main_Parsed

# Path to the directory containing 'sample_sheet.csv' and subfolders with fastq files

fastq_data_path = 'path/to/your/folder_with_samplesheet_and_sub_folders'
main_Parsed.run_wf_tb_amr(fastq_data_path)
```

** Note: If you want to compare the alignment result in Geneious Prime, you can use the bam file generated and the "NC_000962.3.fasta" file in the TB Data file for demo comparison.



### Primer Design

To design primers from a DNA sequence:

```python
from nanopore_alignment.primer import primer_design

# Path to your FASTA file - e.g. the path to the 'reference_primer' file in the 'test_primer' folder
fasta_file = 'path/to/your/fasta/file.fasta'
sequence = primer_design.read_fasta(fasta_file)
primers = primer_design.main(sequence)

# Process or print your primers as needed
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/hgu1uw/UW_BIOEN537/blob/71fcb6fdbf6b4f99d18303e0e0bb32ac0ee0acbd/LICENSE) file for details.

## Contact

For any queries or further assistance, please reach out to Nello at hgu1@uw.edu.
