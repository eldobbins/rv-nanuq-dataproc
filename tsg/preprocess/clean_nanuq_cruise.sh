#!/bin/sh
# Loop through all the TSG files. Parameters in the original file are formatted like:
# "t1= 14.4441, c1= 2.43766, s= 18.9918, sv=1486.252"
# Strip out everything but the numbers. 
# Resulting files contain the same data (still Level 0)but in a new format (v2).
#
# If the format changes, you'll need to revise the awk script.
#
# ELD
# 2/7/2022
# Original code developed by Hank Statscewich
#

#
# Set up
#

cruise_id=$1

indir=../../data/TSG/Level_0/${cruise_id}
outdir=../../data/TSG/Level_0_v2

# remove previous work if it exists
outfile=${outdir}/uaf_${cruise_id}_TSG_L0_v2.dat
\rm ${outfile}

#
# Write data from the little files into a single file
#

# add a header
echo "#Year Month Day Hour Minute Second Temperature Conductivity Salinity Sound_Velocity" > ${outfile}

# parse each incoming TSG file and add it to the outgoing file
for file in ${indir}/tsg.*;
	do
		echo "$file";
		./tsg_parse.awk $file >> ${outfile}
	done
