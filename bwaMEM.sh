#!/bin/bash

bwa index MtbNCBIH37Rv.fa
bwa mem -M -t 8 MtbNCBIH37Rv.fa 5075_10_S1_1P.fq.gz 5075_10_S1_2P.fq.gz > 5075_10_S1.sam
