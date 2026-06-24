#! /bin/bash

Log_Dir="$1"
if [ -z "$Log_Dir" ]; then
  echo "Error: no log directory is provided"
  echo "Usage: $0 <log-dir>"
  exit 1
fi

if [ ! -d "$Log_Dir" ]; then
  echo "Error: dir not exists or it is not a directory"
  exit 1
fi

if [ ! -r "$Log_Dir" ]; then
  echo "Error: dir not exists or it is not readable"  
  exit 1
fi


Log_files=("$Log_Dir"/*.log)
Files_Count=${#Log_files[@]}

if [ "$Files_Count" -eq 1 ] && [ ! -f "${Log_files[0]}" ]; then
  echo "no log files found in $Log_Dir"
  exit 0
fi

ARCHIVE_DIRECTORY="$Log_Dir/archive"
if [ ! -d "$ARCHIVE_DIRECTORY" ]; then
  echo "Archive Directory is not found, Creating one..."
  mkdir -p "$ARCHIVE_DIRECTORY"
fi

TIME_STAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIME_STAMP}.tar.gz"

cd "$Log_Dir" || {
  echo "Can not change to directory $Log_Dir"
}

echo "Creating archive.."
tar -czf "$ARCHIVE_DIRECTORY/$ARCHIVE_NAME" *.log


echo "dir exists and readable"
echo "reading from $Log_Dir and files count is: $Files_Count"