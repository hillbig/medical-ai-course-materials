#!/bin/bash

URLBASE="https://japan-medical-ai.github.io/medical-ai-course-materials/notebooks/"
OPEN_IN_COLAB_PREFIX="https://colab.research.google.com/github/japan-medical-ai/medical-ai-course-materials"
NOTEBOOK_DIR="notebooks"

rm -rf docs
mkdir docs && touch docs/.nojekyll

# Replace with the latest notebooks
rm -rf source/source/notebooks
cp -r notebooks source/source/

cd source
for fn in $(find source/notebooks -name "*.ipynb");
do
    python3 ../scripts/process_cells.py $fn source/notebooks ${URLBASE}
done
ls -la source/notebooks
python3 -m sphinx source ../docs
cd ..

for fn in $(find docs/notebooks -name "*.html");
do
    python3 scripts/insert_colab_link.py $fn ${OPEN_IN_COLAB_PREFIX} ${NOTEBOOK_DIR}
done
