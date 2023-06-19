import sys
import pandas as pd
import os
import glob
from datetime import datetime

# Check if the directory path is provided as an argument
if len(sys.argv) < 2:
    print("Please provide the directory path as a command-line argument.")
    sys.exit(1)

# Get the directory path from the command-line argument
directory_path = sys.argv[1]

# Create an empty DataFrame to store the concatenated results
concatenated_data = pd.DataFrame()

# Get the list of files with the desired pattern
file_list = glob.glob(os.path.join(directory_path, 'output/3_aligned_sequences/*.genes.results'))

# Loop through each file and extract the required columns
for file_path in file_list:
    # Read the file and select the 'gene_id' and 'expected_count' columns
    extracted_data = pd.read_table(file_path, usecols=['gene_id', 'expected_count'])
    
    # Get the base name of the file
    file_base = os.path.basename(file_path)
    
    # Extract the desired column name from the file base name
    column_name = file_base
    
    # Rename the columns with the desired column name
    extracted_data.columns = ['gene_id', column_name]
    
    if concatenated_data.empty:
        # If concatenated_data is empty, assign the extracted data directly
        concatenated_data = extracted_data
    else:
        # Otherwise, merge the extracted data with the existing concatenated_data
        concatenated_data = pd.merge(concatenated_data, extracted_data, on='gene_id', how='left')


# Remove rows with all zero values
concatenated_data = concatenated_data.loc[(concatenated_data != 0).any(axis=1)]

# Generate a timestamp for the output file name
timestamp = datetime.now().strftime('%Y%m%d%H%M%S')

# Create the output file name with the timestamp
output_file_name = f'rsem_star_rawcount_output_file_{timestamp}.txt'

# Save the concatenated data to the output file
concatenated_data.to_csv(output_file_name, sep='\t', index=False)

print(f"Concatenated data saved to '{output_file_name}'.")
