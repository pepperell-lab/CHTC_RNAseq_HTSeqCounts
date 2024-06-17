#!/bin/bash

trimmomatic PE 5075_10_S1_R1_001.fastq.gz 5075_10_S1_R2_001.fastq.gz -baseout 5075_10_S1.fq.gz -threads 4 ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50
