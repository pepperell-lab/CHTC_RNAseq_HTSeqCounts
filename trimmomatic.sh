#!/bin/bash

trimmomatic PE $(RUN)_R1_001.fastq.gz $(RUN)_R2_001.fastq.gz -baseout $(RUN).fq.gz -threads 4 ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50
