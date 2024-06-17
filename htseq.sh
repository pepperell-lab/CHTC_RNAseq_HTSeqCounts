#!/bin/bash

python3 -m HTSeq.scripts.count -f bam -r pos -t gene --idattr=gene_name --nonunique none -s reverse 5075_10_S1.sort.bam MtbNCBIH37Rv.gtf > 5075_10_S1_HTSeqCounts.txt
