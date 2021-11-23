#!/bin/sh

#loop through all the files and cut out just the best parts

cruise_id=$1

# remove previous work
\rm ../data/Level_0/$cruise_id/uaf_${cruise_id}_TSG_L0_v1.dat
\rm ../data/Level_0/$cruise_id/uaf_${cruise_id}_NAV_L0_v1.dat

# TSG files
for file in ../data/Level_0/$cruise_id/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./config/$cruise_id/tsg_parse.awk $file >> ../data/Level_0/$cruise_id/uaf_${cruise_id}_TSG_L0_v1.dat	
	done

# Navigation files
for file in ../data/Level_0/$cruise_id/Navigation/nav.*;
	do
		echo "$file";
		./config/$cruise_id/nav_parse.awk $file >> ../data/Level_0/$cruise_id/uaf_${cruise_id}_NAV_L0_v1.dat
	done

