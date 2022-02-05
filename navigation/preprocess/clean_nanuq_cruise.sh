#!/bin/sh
#
# Concatinate multiple navigation files into a single file per cruise.
# 
# Loop through all the files. Reformat the latitude/longitude degrees and minutes
# into separate columns. Resulting files contain the same data (still Level 0)
# but in a new format (v2).
#
# If the format changes, you'll need to revise the awk script.
#
# ELD
# 2/4/2022
# Original code developed by Hank Statscewich
#

#
# Set up
#

cruise_id=$1

indir=../../data/Navigation/Level_0/${cruise_id}
outdir=../../data/Navigation/Level_0_v2

# remove previous work if it exists
outfile=${outdir}/uaf_${cruise_id}_NAV_L0_v2.dat
\rm ${outfile}

#
# Write data from the little files into a single file
#

# add a header
echo "#Year Month Day Hour Minute Second Lat_Deg Lat_Min Lon_Deg Lon_Min Depth Heading COG SOG" > ${outfile}

# parse each incoming Navigation file and add it to the outgoing file
for file in ${indir}/nav.*;
	do
		echo "$file";
		./nav_parse.awk $file >> ${outfile}
	done

