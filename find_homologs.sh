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
blastp -query $query_file -subject $subject_file -task blastp-short -outfmt "6 std qlen" -out $output_file

# Notify the user
# echo "BLAST completed. Results saved in $output_file"

# Filter the BLAST results
awk -F'\t' '$3 > 30.000 && $4 == 0.9*$13 {print}' $output_file > $temp_file

# Move the result back to output file
mv $temp_file $output_file

# Notify the user
echo "Filtered results saved in $output_file"