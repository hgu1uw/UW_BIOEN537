#!/bin/bash -euo pipefail
workflow-glue report_single_sample       --revision master       --commit b70b8d2fa003bf6e347dec6768fe486bae00db0a       --canned_text report_config.eng.json       --sample_id sample1       --barcode barcode79       --jsons jsons/*       --ntc_threshold="20,3"       --pos_threshold="-20,2"       --sample_threshold="-20,8"       --group 1       --style ont
