#!/bin/bash

# Get the current date in yyyy-mm-dd format
current_date=$(date +"%Y-%m-%d")

# Define the file name
file_name="notas-$current_date.md"

# Check if the file exists
if [ ! -f "$file_name" ]; then
  # Create the file if it doesn't exist
  touch "$file_name"
  echo "# Notas $current_date" >> $file_name
  echo "File '$file_name' created."
else
  echo "File '$file_name' already exists."
fi

# Open the file with gedit
code "$file_name" &
