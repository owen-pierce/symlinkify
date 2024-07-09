#!/bin/bash

# Default values for variables
target_directory="~/symlinks/"
paths_file="paths.txt"
paths_prefix=""

# Function to display usage information
usage() {
    echo "Usage: $0 [-d <target_directory>] [-p <paths_file>] [-x <paths_prefix>]"
    echo "Options:"
    echo "  -d <target_directory>: Set the target directory for symlinks (default: ~/symlinks)"
    echo "  -p <paths_file>: Set the paths file containing paths to symlink (default: paths.txt)"
    echo "  -x <paths_prefix>: Set a prefix for paths in the paths file"
    exit 1
}

# Parse command-line options
while getopts "d:p:x:" opt; do
    case $opt in
        d)
            target_directory="$OPTARG"
            ;;
        p)
            paths_file="$OPTARG"
            ;;
        x)
            paths_prefix="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
    esac
done

# Shift the positional parameters so that $1 now refers to the first non-option argument, if needed
shift $((OPTIND - 1))

# Check if the target directory exists
if [ ! -d "$target_directory" ]; then
    echo "Error: Target directory '$target_directory' does not exist."
    exit 1
fi

# Check if the paths file exists
if [ ! -f "$paths_file" ]; then
    echo "Error: Paths file '$paths_file' not found."
    exit 1
fi

# Read each path from the file and create symlinks
while IFS= read -r path; do
    # Skip empty lines or lines starting with #
    if [ -z "$path" ] || [[ "$path" == \#* ]]; then
        continue
    fi

    # If paths_prefix is set, prepend it to the path
    if [ -n "$paths_prefix" ]; then
        path="$paths_prefix/$path"
    fi

    # Check if the path exists
    if [ ! -e "$path" ]; then
        echo "Warning: Path '$path' does not exist. Skipping symlink creation."
        continue
    fi

    # Extract the base name of the path (file or directory name)
    base_name=$(basename "$path")

    # Create symlink in the target directory
    symlink_path="$target_directory/$base_name"

    # If symlink already exists, skip
    if [ -e "$symlink_path" ]; then
        echo "Warning: Symlink '$symlink_path' already exists. Skipping."
    else
        ln -s "$path" "$symlink_path"
        echo "Created symlink: $symlink_path -> $path"
    fi

    # Recursively create symlinks for directories
    if [ -d "$path" ]; then
        recursive_create_symlinks "$path" "$target_directory"
    fi

done < "$paths_file"

# Function to recursively create symlinks for directories
recursive_create_symlinks() {
    local source_dir="$1"
    local target_dir="$2"

    # Iterate over files and directories in source_dir
    for entry in "$source_dir"/*; do
        # Check if entry is a directory
        if [ -d "$entry" ]; then
            # Recursively create symlink for the directory
            recursive_create_symlinks "$entry" "$target_dir"
        fi

        # Create symlink for the file or directory
        base_name=$(basename "$entry")
        symlink_path="$target_dir/$base_name"

        # If symlink already exists, skip
        if [ -e "$symlink_path" ]; then
            echo "Warning: Symlink '$symlink_path' already exists. Skipping."
        else
            ln -s "$entry" "$symlink_path"
            echo "Created symlink: $symlink_path -> $entry"
        fi
    done
}
