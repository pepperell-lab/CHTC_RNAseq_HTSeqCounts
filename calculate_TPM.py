import re
import argparse

def get_gene_length(filename):
    gene_length = {}
    with open(filename, 'r') as file:
        for line in file:
            parts = line.strip().split('\t')
            if len(parts) >= 9 and parts[2] == 'gene':
                # Extract gene name
                match = re.search(r'gene_name "([^"]+)"', parts[8])
                if match:
                    gene_name = match.group(1)
                else:
                    gene_name = 'unknown'
                
                # Calculate gene length
                try:
                    start = int(parts[3])
                    end = int(parts[4])
                    length = end - start
                except ValueError:
                    length = 'error'
                gene_length[gene_name] = length
    return gene_length

def read_HTSeqCount(filename):
    data = {}
    with open(filename, 'r') as file:
        for line in file:
            parts = line.strip().split()
            if len(parts) == 2:
                gene_name, counts = parts
                data[gene_name] = int(counts)
    return data

def write_output(output_file, gene_length, counts):
    with open(output_file, 'w') as file:
        # Prepare header
        file.write('Gene_name\tLength\tCount\tTPM\n')
        
        # Compute combined data
        total_rpk = 0
        rows = []
        for gene in gene_length:
            length = gene_length.get(gene, 0)
            count = counts.get(gene, 0)
            rpk = count / length if length else 0
            rows.append((gene, length, count, rpk))
            total_rpk += rpk
        
        scale_factor = total_rpk / 1000000
        
        # Write data rows
        for gene, length, count, rpk in rows:
            tpm = rpk / scale_factor if scale_factor else 0
            file.write(f'{gene}\t{length}\t{count}\t{tpm:.4f}\n')

def main():
    parser = argparse.ArgumentParser(description='Process a text file.')
    parser.add_argument('gtf', type=str, help='The GTF file to process')
    parser.add_argument('txt', type=str, help='The HTSeq counts file to process')
    parser.add_argument('output_file', type=str, help='The output file to write')

    args = parser.parse_args()
    gene_length = get_gene_length(args.gtf)
    counts = read_HTSeqCount(args.txt)

    # Write results to the output file
    write_output(args.output_file, gene_length, counts)

if __name__ == '__main__':
    main()
