#!/bin/bash

# Script to create a directory structure for ACDC Data Transfer and initialize a manifest file.

# Function to display help message
show_help() {
  echo "Usage: $0 [-h] [-s STUDY_ID] [-o OUTPUT_DIR]"
  echo
  echo "This script creates a directory structure for ACDC Data Transfer and initializes a manifest file."
  echo
  echo "Options:"
  echo "  -s STUDY_ID    The study identifier used to name the root directory."
  echo "  -o OUTPUT_DIR  Specify the output directory where the structure will be created. Default is the current directory."
}

# Default output directory is the current directory
OUTPUT_DIR="."
STUDY_ID=""

# Parse options
while getopts ":hs:o:" opt; do
  case ${opt} in
    h )
      show_help
      exit 0
      ;;
    s )
      STUDY_ID=$OPTARG
      ;;
    o )
      OUTPUT_DIR=$OPTARG
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      show_help
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Check if STUDY_ID is provided
if [ -z "$STUDY_ID" ]; then
  echo "Error: STUDY_ID is required."
  show_help
  exit 1
fi

DATE=$(date +%Y-%m-%d)
ROOT_NAME="${OUTPUT_DIR}/${DATE}_${STUDY_ID}_ACDC_Data_Transfer"

# Create root directory
if ! mkdir -p "$ROOT_NAME"; then
  echo "Error: Failed to create directory $ROOT_NAME" 1>&2
  exit 1
fi

# Echo the root directory name
echo "Root directory created: $ROOT_NAME"

# Create subdirectories
for dir in clinical genomic imaging metabolomic proteomic study study/data_dictionaries; do
  if ! mkdir -p "$ROOT_NAME/$dir"; then
    echo "Error: Failed to create directory $ROOT_NAME/$dir" 1>&2
    exit 1
  fi
done

# Create manifest file with header
if ! echo -e "study_id\tsubject_id\tfile_path\tfile_name\tdata_category\tfile_size\tmd5_hash" > "$ROOT_NAME/manifest.tsv"; then
  echo "Error: Failed to create manifest file $ROOT_NAME/manifest.tsv" 1>&2
  exit 1
fi