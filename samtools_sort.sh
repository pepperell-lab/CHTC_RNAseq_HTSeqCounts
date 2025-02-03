#!/bin/bash
results_staging_prefix=/staging/groups/pepperell_group/Mtb_RNAseq/HTSeqCounts/Results
cp $results_staging_prefix/$1.bam.gz ./

gunzip -c $1.bam.gz > $1.bam
samtools sort -O bam -T $1.sort $1.bam -o $1.sort.bam
gzip $1.sort.bam

mv $1.sort.bam.gz $results_staging_prefix/

rm $results_staging_prefix/$1.bam.gz
