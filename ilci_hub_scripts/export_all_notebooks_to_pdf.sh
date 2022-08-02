#!/bin/bash

INPUT_DIR=$1
if [ ! -d "${INPUT_DIR}" ]
then
   echo "Error. Directory name expected as input."
   echo "Converts all the notebooks (e.g. .ipynb format) of a directory to PDF."
   echo "Usage: $(basename $0) DIR_NAME"
   exit 0
fi
for N in ${INPUT_DIR}*.ipynb;do
   OUT="${N%.ipynb}.pdf"
   echo "Converting: $N --> ${OUT}";
   pandoc --to pdf --from ipynb $N --pdf-engine=xelatex -o ${OUT}
done
