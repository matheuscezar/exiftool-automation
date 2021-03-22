#!/bin/bash

# Downloading all images of URL
curl -s https://$1 | grep "<img" | grep -v svg | awk -F "src=" '{print $2;}' | cut -d\" -f2 | sort -u > images.tmp
for url in $(cat images.tmp);
do
        wget -q  "$url"
done

# Downloading other files
curl -s https://$1 | grep "<a"  | awk -F "href=" '{print $2;}' | cut -d\" -f2 | sort -u | grep ".*\(pdf$\|doc$\|docx$\)" > others.tmp
for url in $(cat others.tmp);
do
        wget -q "$url"
done

# Executing exiftool of all files
ls -1 | grep -v images.tmp > files.tmp
for file in $(cat files.tmp);
do
        exiftool "$file" >> output.txt
        echo -e "================================================================================\n\n" >> output.txt
done
cat output.txt
