#!/bin/sh
#
# Process all the TSG data for Nanuq cruises.
# 
# Loop through all the cruises and call the script that concatenates the little files 
# together.
#
# ELD
# 2/4/2022

#
# Set up
# 

indir=../../data/TSG/Level_0/

#
# call the processing script for each cruise
#

for cruise in `ls ${indir}`;
	do
		echo "$cruise";
		./clean_nanuq_cruise.sh ${cruise}
	done
