#!/bin/bash
staging_prefix=/staging/groups/pepperell_group/Mtb_RNAseq/HTSeqCounts
results_staging_prefix=/staging/groups/pepperell_group/Mtb_RNAseq/HTSeqCounts/Results
cp $staging_prefix/$1_R1_001.fastq.gz $staging_prefix/$1_R2_001.fastq.gz $staging_prefix/adapters.fa ./

trimmomatic PE $1_R1_001.fastq.gz $1_R2_001.fastq.gz -baseout $1.fq.gz -threads 4 ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50

mv $1_1P.fq.gz $results_staging_prefix/
mv $1_2P.fq.gz $results_staging_prefix/

# keep the original fastq.gz file
# rm $staging_prefix/$1_R1_001.fastq.gz $staging_prefix/$1_R2_001.fastq.gz
