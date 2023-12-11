#!/bin/bash -euo pipefail
# Output nextflow params object to JSON
    echo '{
    "help": false,
    "version": false,
    "analyse_unclassified": false,
    "out_dir": "output",
    "fastq": "/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_nanopore_alignment",
    "sample": null,
    "sample_sheet": "/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_nanopore_alignment/sample_sheet.csv",
    "align_threads": 4,
    "mpileup_threads": 4,
    "maf": 0.1,
    "strand_bias": 1000,
    "minimum_read_support": 5,
    "downsample": null,
    "ntc_threshold": "20,3",
    "sample_threshold": "-20,8",
    "positive_threshold": "-20,2",
    "disable_ping": false,
    "aws_image_prefix": null,
    "aws_queue": null,
    "process_label": "microbial",
    "monochrome_logs": false,
    "validate_params": true,
    "show_hidden_params": false,
    "schema_ignore_params": "show_hidden_params,validate_params,monochrome_logs,aws_queue,aws_image_prefix,wf,process_label",
    "wf": {
        "example_cmd": [
            "--fastq test_data/fastq",
            "--sample_sheet test_data/sample_sheet.csv"
        ],
        "agent": null,
        "container_sha": "sha837f62ff13f7f65a6d58f4d0aff6a9f86dda6fb7"
    },
    "_reference": "/Users/nello/.nextflow/assets/epi2me-labs/wf-tb-amr/./data/primer_schemes/V3/NC_000962.3.fasta",
    "_variant_db": "/Users/nello/.nextflow/assets/epi2me-labs/wf-tb-amr/./data/primer_schemes/V3/variant_db.sorted.normalised.vcf.gz",
    "_genbank": "/Users/nello/.nextflow/assets/epi2me-labs/wf-tb-amr/./data/primer_schemes/V3/NC_000962.3.gb",
    "_amplicons_bed": "/Users/nello/.nextflow/assets/epi2me-labs/wf-tb-amr/./data/primer_schemes/V3/TB_amplicons.bed",
    "_report_config": "/Users/nello/.nextflow/assets/epi2me-labs/wf-tb-amr/./data/primer_schemes/V3/report_config.eng.json"
}' > params.json
