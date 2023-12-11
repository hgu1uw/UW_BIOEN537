#!/bin/bash -euo pipefail
echo '[
    {
        "sample_id": "sample1",
        "type": "test_sample",
        "barcode": "barcode79"
    },
    {
        "sample_id": "Negative",
        "type": "no_template_control",
        "barcode": "barcode93"
    },
    {
        "sample_id": "Positive",
        "type": "positive_control",
        "barcode": "barcode92"
    }
]' > metadata.json
    mkdir jsons
    workflow-glue report         --revision master         --commit b70b8d2fa003bf6e347dec6768fe486bae00db0a         --per_barcode_stats per_barcode_stats/*         --bed TB_amplicons.bed         --genotype_json variants/*         --params params.json         --pickedreads pickedreads/*         --reference NC_000962.3.fasta         --metadata metadata.json         --readcounts bed_files         --ntc_threshold="20,3"         --positive_threshold="-20,2"         --sample_threshold="-20,8"         --versions versions         --canned_text report_config.eng.json         --style ont
