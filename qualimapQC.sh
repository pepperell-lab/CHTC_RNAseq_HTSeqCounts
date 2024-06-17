#!/bin/bash

# run qualimap-bamqc
qualimap bamqc -bam 5075_10_S1.sort.bam -outdir 5075_10_S1_bamqc --java-mem-size=2G

# run qualimap-rnaseq
qualimap rnaseq -bam 5075_10_S1.sort.bam -outdir 5075_10_S1_rnaseq -pe -gtf MtbNCBIH37Rv.gtf --java-mem-size=2G

tar -zcvf 5075_10_S1.qualimap.tar.gz 5075_10_S1_bamqc/ 5075_10_S1_rnaseq/
