#!/bin/bash
echo "tar multiQC ..."
tar -xzf multiQC.tar.gz
cd multiQC

echo "untaring bamqc..."
for f in *bamqc.tar.gz; do tar -xzf $f; done

#echo "running kraken ..."
#for f in *_1.fastq.gz; do kraken2 --db /staging/mtopf/BactDB --gzip-compressed --paired $f ${f/_1.fastq.gz/_2.fastq.gz} --output ${f/_1.fastq.gz/_kraken.out} --report ${f/_1.fastq.gz/_kraken_report.txt} --use-names; done

echo "running multiqc..."
multiqc -ds .

mv multiqc_report.html multiqc_data/
mv multiqc_data/ multiQC-report
tar -czvf multiqc-report.tar.gz multiQC-report/
mv multiqc-report.tar.gz ../
