#!/bin/bash

bwa index $(REF)
bwa mem -M -t 8 $(REF) $(RUN)_1P.fq.gz $(RUN)_2P.fq.gz > $(RUN).sam
