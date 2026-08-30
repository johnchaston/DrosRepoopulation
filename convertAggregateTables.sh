#!/bin/sh

#  standard_qiime2.sh
#
#
#  Created by John Chaston on 7/25/18.
#

## taxonomy folder, tree.qza, table.qza, mapper.tsv
# $7 if yes makes the rarefaction curve and a table.qzv of the rarefaction. $7 if no or if not entered skips these steps, both of which are fairly computationally intensive, so it can save time to ignore them.

tablename=$1
treename=$2
name=$3
sdepth=$4
mapper=$5
iterations=$7
sdi=$8
echo $2
echo $3
echo $4
echo $5
echo $6
echo $7
echo $8

qiime tools import \
    --input-path core-metrics-results-$name/bray_curtis_distance_matrix/distance-matrix.tsv \
    --output-path core-metrics-results-$name/bray_curtis_distance_matrix.qza \
    --type DistanceMatrix

qiime tools import \
    --input-path core-metrics-results-$name/weighted_unifrac_distance_matrix/distance-matrix.tsv \
    --output-path core-metrics-results-$name/weighted_unifrac_distance_matrix.qza \
    --type DistanceMatrix

qiime tools import \
    --input-path core-metrics-results-$name/unweighted_unifrac_distance_matrix/distance-matrix.tsv \
    --output-path core-metrics-results-$name/unweighted_unifrac_distance_matrix.qza \
    --type DistanceMatrix


biom convert -i core-metrics-results-""$name/rarefied_table.txt -o core-metrics-results-""$name/table_$name"".biom --to-hdf5 --table-type="OTU table"
qiime tools import --input-path core-metrics-results-""$name/table_$name"".biom --type 'FeatureTable[Frequency]' --input-format BIOMV210Format --output-path core-metrics-results-""$name/table_$name"".qza
