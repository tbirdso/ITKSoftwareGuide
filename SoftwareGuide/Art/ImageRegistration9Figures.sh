#!/usr/bin/zsh
# script to execute ImageRegistration9.cxx and capture the output and plot it
# gnuplot

EXAMPLESBINDIR="/home/karthik/work/ITK/binaries/Insight/Nightly/bin"
DATADIR="/home/karthik/work/ITK/src/Insight/Nightly/Examples/Data"

OUTPUTDATAFILE="ImageRegistration9Output.txt"
OUTPUTDATAFILECLEANED="ImageRegistration9OutputCleaned.txt"

#
# Execute the example and capture the output.
#
$EXAMPLESBINDIR/ImageRegistration9 $DATADIR/BrainProtonDensitySliceBorder20.png $DATADIR/BrainProtonDensitySliceR10X13Y17.png ImageRegistration9Output.png ImageRegistration9DifferenceAfter.png ImageRegistration9DifferenceBefore.png 1.0 300 | tee $OUTPUTDATAFILE
#
# Take the first N lines, and remove the characters "["  "]"  ","
#
head -n 67 $OUTPUTDATAFILE | sed "s/\]/ /g"  | sed "s/\,/ /g"  | sed "s/\[/ /g"  | sed "s/AffineAngle://g" > $OUTPUTDATAFILECLEANED

#
# Take the metric and translation data and generate plots with GNUPlot
#
gnuplot ImageRegistration9Figures.gnup