#!/bin/bash

#samtools index $1.sam
gunzip -c $1.sam.gz > $1.sam
samtools view -bhSu $1.sam | gzip > $1.bam.gz
