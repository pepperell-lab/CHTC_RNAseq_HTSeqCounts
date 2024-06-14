#!/bin/bash

python3 -m HTSeq.scripts.count -f bam -r pos -t gene --idattr=gene_name --nonunique none -s reverse $1.sort.bam $2 > $1_HTSeqCounts.txt
