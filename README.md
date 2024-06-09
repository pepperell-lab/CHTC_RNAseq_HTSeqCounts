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
- **Generating DAG Files:**
  - To generate the individual DAG files from the template, run the following command:
  ```bash
  python3 make_RNAseq_dag.py input.txt RNAseq_dag.template MtbNCBIH37Rv.fa MtbNCBIH37Rv.gtf
  ```

## CHTC HTCondor DAG Job Submission and Debugging Guide

### Submitting and Watching a DAG Job

To submit the DAG job described in `input_topLevel.dag` on CHTC, use the following command:

```sh
condor_submit_dag input_topLevel.dag
```

To watch a DAG job on CHTC, use the following command:

```sh
condor_q -nobatch
```

### Debugging Errors in HTCondor Environment

#### Step 1: Check the `.dag.rescue` File

If your DAG job encounters an error, HTCondor will generate a `.dag.rescue` file. This file contains information about the state of the DAG at the time of failure and can be used to resume the job from where it left off.

#### Step 2: Inspect Job Error, Log, and Output Files

To debug a failed job, you need to identify which job failed(in `.dag.rescue` file) and inspect the job's error, log, and output files. 

#### Step 3: Update the Submit File

After identifying and fixing the issue that caused the job to fail, update the corresponding submit file. Once the submit file is updated, you can resume the job from the point of failure using the `.dag.rescue` file.

To resume the job, submit the rescue DAG file:

```sh
condor_submit_dag input_topLevel.dag
```

This command will restart the DAG job from the last successful checkpoint, skipping the jobs that have already completed successfully(if rescue file is not deleted).


---

For more detailed information, refer to the [HTCondor Manual](https://htcondor.readthedocs.io/en/latest/).
* DAG Workflow: https://htcondor.readthedocs.io/en/latest/automated-workflows/index.html
* DAG Recovery: https://htcondor.readthedocs.io/en/23.0/automated-workflows/dagman-resubmit-failed.html
