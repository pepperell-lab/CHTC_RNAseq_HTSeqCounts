#!/bin/bash
staging_prefix=/staging/groups/pepperell_group/Mtb_RNAseq/HTSeqCounts
results_staging_prefix=/staging/groups/pepperell_group/Mtb_RNAseq/HTSeqCounts/Results
cp $results_staging_prefix/$2_1P.fq.gz $results_staging_prefix/$2_2P.fq.gz $staging_prefix/$1 ./

bwa index $1
bwa mem -M -t 8 $1 $2_1P.fq.gz $2_2P.fq.gz | gzip > $2.sam.gz

mv $2.sam.gz $results_staging_prefix/
rm $results_staging_prefix/$2_1P.fq.gz $results_staging_prefix/$2_2P.fq.gz
