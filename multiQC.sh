#!/bin/bash
echo "tar multiQC ..."
tar -xzf multiQC.tar.gz
cd multiQC

echo "running multiqc..."
multiqc -ds .

mv multiqc_report.html multiqc_data/
mv multiqc_data/ multiQC-report
tar -czvf multiqc-report.tar.gz multiQC-report/
mv multiqc-report.tar.gz ../
