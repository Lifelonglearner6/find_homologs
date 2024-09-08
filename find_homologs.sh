#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <query_file> <subject_file> <output_file>"
    exit 1
fi

# Extract arguments
query_file="$1"
subject_file="$2"
output_file="$3"
temp_file="${output_file}_temp"

# Run BLAST
tblastn -query $query_file -subject $subject_file -task blastp-short -outfmt "6 qseqid sseqid pident length qlen" -out temp_results.txt

# Notify the user
# echo "BLAST completed. Results saved in $output_file"

# Filter the BLAST results
awk '$3 > 30.000 && $4 / $5 > 0.9' temp_results.txt > $output_file

# Count the number of matches
num_matches=$(wc -l < $output_file)

# Notify the user
echo "Filtered results saved in $output_file"
echo "Number of matches identified: $num_matches"

# Cleanup
rm temp_results.txt