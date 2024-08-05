#!/bin/bash

gunzip -c $1.sort.bam.gz > $1.sort.bam
python3 -m HTSeq.scripts.count -f bam -r pos -t gene -i gene_name --nonunique none -s reverse $1.sort.bam $2 > $1_HTSeqCounts.txt
# Correct the format of HTSeqCounts.txt file
python3 format_HTSeqCounts.py $1_HTSeqCounts.txt $1_HTSeqCounts.txt
# Generate the TPM HTSeq file
python3 calculate_TPM.py $2 $1_HTSeqCounts.txt $1_TPM.txt
