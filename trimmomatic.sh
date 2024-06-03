#!/bin/bash

trimmomatic PE 3151_17_S11_R1_001.fastq.gz 3151_17_S11_R2_001.fastq.gz -baseout 3151_17_S11.fq.gz -threads 4 ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50
