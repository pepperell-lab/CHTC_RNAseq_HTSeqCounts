# RNASeq_CHTC
### Updated versions of condor scripts for work on CHTC for RNAseq using Docker containers. 

This repository contains an RNA-Seq analysis pipeline designed to process sequencing data through several stages on CHTC, from quality control to gene expression quantification.

## Pipeline Overview

The pipeline consists of the following stages:

1. **FastQC1:** Initial quality check of raw reads.
2. **Trim:** Adapter and quality trimming of reads.
3. **FastQC2:** Quality check of trimmed reads.
4. **BWA:** Alignment of reads to the reference genome.
5. **Samtools View:** Conversion of SAM to BAM format.
6. **Samtools Sort:** Sorting of BAM files.
7. **HTSeq & Qualimap:** Gene expression quantification and quality control of BAM files.

## Required Files

To run the pipeline, the following files are needed:

- **Reference File:** `MtbNCBIH37Rv.fa`
- **Adapter File:** `adapters.fa`
- **GFF File:** `MtbNCBIH37Rv.gff`
- **Data Files:** Raw sequencing reads
  - `3151_19_S13_R1_001.fastq.gz`
  - `3151_19_S13_R2_001.fastq.gz`
- **Input File:** `input.txt` (contains sample identifiers, one per line)
    ```plaintext
    3151_17_S11
    3151_18_S12
    3151_19_S13
    ```

## DAG Files

The pipeline uses Directed Acyclic Graph (DAG) files to manage the workflow. These files are automatically generated and include:

- **Top-Level DAG File:** `input_topLevel.dag`
  - Runs individual DAG files for each sample.
  - Example DAG files for individual samples:
    - `3151_17_S11_RNAseq.dag`
    - `3151_18_S12_RNAseq.dag`
    - `3151_19_S13_RNAseq.dag`
- **Template and Script for DAG Generation:**
  - `RNAseq_dag.template`: Template DAG file with placeholders (`$(RUN)`, `$(REF)`, `$(annot_gtf)`) to be replaced.
  - `make_RNAseq_dag.py`: Script to generate individual DAG files by replacing placeholders with actual values.

## Generating DAG Files

To generate the individual DAG files from the template, run the following command:

```bash
python3 make_RNAseq_dag.py input.txt RNAseq_dag.template MtbNCBIH37Rv.fa MtbNCBIH37Rv.gtf
```
