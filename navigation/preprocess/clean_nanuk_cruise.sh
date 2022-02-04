#!/bin/sh
#
# Concatinate the multiple navigation files into a single files per cruise
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

cruise_id=$1

# remove previous work if it exists
\rm ../data/Level_0_v2/uaf_${cruise_id}_NAV_L0_v1.dat

# Navigation files
for file in ../data/Level_0/$cruise_id/Navigation/nav.*;
	do
		echo "$file";
		./config/$cruise_id/nav_parse.awk $file >> ../data/Level_0_v2/uaf_${cruise_id}_NAV_L0_v2.dat
	done

