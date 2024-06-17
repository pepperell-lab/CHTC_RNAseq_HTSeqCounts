#!/bin/bash

samtools index 5075_10_S1.sam
samtools view -bhSu 5075_10_S1.sam > 5075_10_S1.bam
