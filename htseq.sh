#!/bin/bash

gunzip -c $1.sort.bam.gz > $1.sort.bam
python3 -m HTSeq.scripts.count -f bam -r pos -t gene -i gene_name --nonunique none -s reverse $1.sort.bam $2 > $1_HTSeqCounts.txt
