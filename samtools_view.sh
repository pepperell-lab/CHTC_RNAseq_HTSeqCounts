#!/bin/bash
results_staging_prefix=/staging/groups/pepperell_group/Mtb_RNAseq/HTSeqCounts/Results

cp $results_staging_prefix/$1.sam.gz ./

#samtools index $1.sam
gunzip -c $1.sam.gz > $1.sam
samtools view -bhSu $1.sam | gzip > $1.bam.gz

mv $1.bam.gz $results_staging_prefix/

rm $results_staging_prefix/$1.sam.gz
