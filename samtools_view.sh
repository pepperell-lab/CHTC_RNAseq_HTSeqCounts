#!/bin/bash

samtools index $(RUN).sam
samtools view -bhSu $(RUN).sam > $(RUN).bam
