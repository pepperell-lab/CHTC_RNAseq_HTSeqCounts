#!/bin/bash

bwa index $2
bwa mem -M -t 8 $2 $1_1P.fq.gz $1_2P.fq.gz > $1.sam
