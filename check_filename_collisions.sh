# Get a list of all MATLAB files in the repository
matlab_files=$(find . -type f -name "*.m")

# Check for file name collisions
declare -A file_names_count
duplicate_files=""

for file in $matlab_files; do
    # Extract the filename without the path
    filename=$(basename "$file")

    # Check if the filename already exists in the associative array
    if [[ ${file_names_count["$filename"]} ]]; then
        file_names_count["$filename"]=$((file_names_count["$filename"] + 1))
    else
        file_names_count["$filename"]=1
    fi
done

# Find duplicate filenames
for filename in "${!file_names_count[@]}"; do
    count=${file_names_count["$filename"]}
    if [[ $count -gt 1 ]]; then
        duplicate_files="$duplicate_files\n- $filename (found $count times)"
    fi
done

# If there are duplicate files, exit with an error message
if [[ ! -z "$duplicate_files" ]]; then
    echo "Found file name collisions:"
    echo -e "$duplicate_files"
    exit 1
else
    echo "No file name collisions found."
fi
