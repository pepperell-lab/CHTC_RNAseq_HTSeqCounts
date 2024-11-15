# Pepperell_Lab_RNAseq_HTSeqCounts_Pipeline
### Updated versions of condor scripts for work on CHTC for RNAseq using Docker containers. 

This repository contains an RNA-Seq analysis pipeline designed to process sequencing data through several stages on CHTC, from quality control to gene expression quantification.

## Pipeline Overview

The pipeline consists of the following stages:

1. **FastQC1:**
   - Initial quality check of raw reads.
   - Docker image: `staphb/fastqc`

2. **Trim:**
   - Adapter and quality trimming of reads.
   - Docker image: `staphb/trimmomatic`

3. **FastQC2:**
   - Quality check of trimmed reads.
   - Docker image: `staphb/fastqc`

4. **BWA:**
   - Alignment of reads to the reference genome.
   - Docker image: `staphb/bwa`

5. **Samtools View:**
   - Conversion of SAM to BAM format.
   - Docker image: `staphb/samtools`

6. **Samtools Sort:**
   - Sorting of BAM files.
   - Docker image: `staphb/samtools`

7. **HTSeq & Qualimap:**
   - Gene expression quantification and quality control of BAM files.
   - Docker images: `fischuu/htseq` and `pegi3s/qualimap`

8. **MultiQC:**
   - Final quality control of all raw FASTA files, trimmed FASTA files, and BAM files.
   - Docker image: `staphb/multiqc`

## Required Files

To run the pipeline, the following files are needed:

- **Reference File:** `MtbNCBIH37Rv.fa`
- **Adapter File:** `adapters.fa`
- **GTF File:** `MtbNCBIH37Rv.gtf`
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

The pipeline uses HTcondor DAG files to manage the workflow. These files are automatically generated and include:

- **Top-Level DAG File:** `input_topLevel.dag`
  - Runs individual DAG files for each sample.
  - Example DAG files for individual samples:
    - `3151_17_S11_RNAseq.dag`
    - `3151_18_S12_RNAseq.dag`
    - `3151_19_S13_RNAseq.dag`
- **Template and Script for DAG Generation:**
  - `RNAseq_dag.template`: Template DAG file with placeholders (`$(RUN)`, `$(REF)`, `$(annot_gtf)`) to be replaced.
  - `make_RNAseq_dag.py`: Script to generate individual DAG files by replacing placeholders with actual values.
- **Generating DAG Files:**
  - To generate the individual DAG files and top-level DAG file from the template, run the following command:
  ```bash
  python3 make_RNAseq_dag.py input.txt RNAseq_dag.template MtbNCBIH37Rv.fa MtbNCBIH37Rv.gtf
  ```

## CHTC HTCondor DAG Job Submission and Debugging Guide

### Submitting and Watching a DAG Job

To submit the DAG job described in `input_topLevel.dag` on CHTC, use the following command:

```sh
condor_submit_dag input_topLevel.dag
```

To check the status of a DAG job on HTCondor, use the following command:

```sh
condor_q -nobatch
```

### Debugging Errors in HTCondor Environment

#### Step 1: Check the `.dag.rescue` File

If your DAG job encounters an error, HTCondor will generate a `.dag.rescue` file. This file contains information about the state of the DAG at the time of failure and can be used to resume the job from where it left off.

#### Step 2: Inspect Job Error, Log, and Output Files

To debug a failed job, you need to identify which job failed(in `.dag.rescue` file) and inspect the job's error, log, and output files. 

#### Step 3: Update the Submit File

After identifying and fixing the issue, update the corresponding submit/shell file. Then resume the job from the point of failure using the `.dag.rescue` file.

To resume the job, submit the rescue DAG file:

```sh
condor_submit_dag input_topLevel.dag
```

This command will restart the DAG job from the last successful checkpoint, skipping the jobs that have already completed successfully(if rescue file is not deleted).


---

For more detailed information, refer to the [HTCondor Manual](https://htcondor.readthedocs.io/en/latest/).
* DAG Workflow: https://htcondor.readthedocs.io/en/latest/automated-workflows/index.html
* DAG Recovery: https://htcondor.readthedocs.io/en/23.0/automated-workflows/dagman-resubmit-failed.html

## Visualizations
![RNAseq_Pipeline_HTseqCounts](https://github.com/user-attachments/assets/dc06e571-0849-410a-b08b-f2f422037603)
![CHTC_RNAseqData_Organization](https://github.com/user-attachments/assets/4eb7d4fd-3bb1-4de0-9cb5-383f97328e18)
![RNAseqOnCHTC (4)](https://github.com/pepperell-lab/RNASeq_CHTC/assets/108096710/83429397-70bc-45d0-ad0c-f46b9e433ba9)
