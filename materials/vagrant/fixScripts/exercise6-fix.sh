#!/bin/bash
#add fix to exercise6-fix here


# Check the number of arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <source_file1> <source_file2> ... <destination_folder>"
    exit 1
fi

# Get the current server's hostname
current_server=$(hostname)

# Determine the other server's hostname
if [ "$current_server" == "server1" ]; then
    dest_server="server2"
elif [ "$current_server" == "server2" ]; then
    dest_server="server1"
else
    echo "Unknown server: $current_server"
    exit 1
fi

# Extract the destination folder (last argument)
dest_folder="${!#}"

# Loop through all arguments except the last one
for ((i = 1; i <= $# - 1; i++)); do
    src_file="${!i}"

    # Check if the source file exists
    if [ -f "$src_file" ]; then
        # Copy the file to the destination folder on the other server
        ssh "$dest_server" "sudo scp $src_file $dest_folder"
        echo "'$src_file' copied to '$dest_server:$dest_folder'"
        # Calculate the file size and add it to the total size
        file_size=$(stat -c "%s" "$src_file")
        total_size=$((total_size + file_size))
    else
        echo "Source file '$src_file' does not exist."
    fi
done

# Print the total size in bytes
echo "$total_size"