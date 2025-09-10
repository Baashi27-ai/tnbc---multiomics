import sys
import re

# Define file paths
input_file = "C:/TNBC_project/results/REPORTS/phase6/repurpose_enrichment.tsv"
output_file = "C:/TNBC_project/results/REPORTS/phase6/repurpose_enrichment_clean.tsv"

# Define the new header
new_header = "Class\tTag\tPathway\tCount\tpValue"

try:
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        # Write the correct header to the new file
        outfile.write(new_header + '\n')

        # Read the lines from the original file
        lines = infile.readlines()

        # This regex will match a number, followed by letters/slashes/numbers, a number, and another number.
        # It's a universal pattern to capture all variations.
        pattern = re.compile(r'^(\S+)\s*(\S+)\s*(\S+)\s*(\S+)\s*(\S+)$')

        # Skip the first line (the incorrect header) and process the rest
        for line in lines[1:]:
            line_str = line.strip()

            # Use regex to split the line by any whitespace
            match = pattern.search(line_str)

            if match:
                # Extract the matched groups
                parts = list(match.groups())
                outfile.write('\t'.join(parts) + '\n')
            else:
                print(f"Skipping line due to no match: {line_str}")

    print("Header and file fixed successfully!")

except FileNotFoundError:
    print(f"Error: The file {input_file} was not found.")
    sys.exit(1)
