#!/bin/bash
echo "tar multiQC ..."
tar -xzf MultiQC.tar.gz
cd MultiQC

echo "tar qualimap ..."
for f in *qualimap.tar.gz; do tar -xcf $f; done

echo "running multiqc..."
multiqc -ds .

mv multiqc_report.html multiqc_data/
mv multiqc_data/ multiqc-report
tar -czvf multiqc-report.tar.gz umltiqc-report/
mv multiqc-report.tar.gz ../
