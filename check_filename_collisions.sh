# Get a list of all MATLAB files in the repository
matlab_files=$(find . -type f -name "*.m")

# Check for file name collisions
duplicate_files=""
for file in $matlab_files; do
    # Remove the leading "./" from the file path
    filename=$(echo $file | cut -c 3-)
    # Check if there's another file with the same name
    if [[ $(find . -type f -name "$filename" | wc -l) -gt 1 ]]; then
        duplicate_files="$duplicate_files\n- $filename"
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
