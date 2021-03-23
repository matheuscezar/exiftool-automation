#!/bin/bash

# Downloading all images of URL
curl -s https://$1 | grep "<img" | grep -v svg | awk -F "src=" '{print $2;}' | cut -d\" -f2 | sort -u > files.tmp
curl -s https://$1 | grep "<a"  | awk -F "href=" '{print $2;}' | cut -d\" -f2 | sort -u | grep ".*\(pdf$\|doc$\|docx$\)" >> files.tmp
for url in $(cat files.tmp);
do
        wget -q  "$url"
done

# Executing exiftool of all files
for file in $(ls -1 |grep -v .tmp | grep -v .sh | grep -v output.txt ) ;
do
        exiftool "$file" >> output.txt
        echo -e "================================================================================\n\n" >> output.txt
done
cat output.txt
                
