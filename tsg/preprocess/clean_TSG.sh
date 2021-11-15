#!/bin/sh

# cleanup from prior runs
rm nuq_nav.dat nuq_tsg.dat


#loop through all the files and cut out just the best parts

cruise_id=NUQ202001P
for file in ../data/Level_0/$cruise_id/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./config/$cruise_id/tsg_parse.awk $file >> nuq_tsg.dat	
	done
for file in ../data/Level_0/$cruise_id/Navigation/nav.*;
	do
		echo "$file";
		./config/$cruise_id/nav_parse.awk $file >> nuq_nav.dat	
	done


cruise_id=NUG202003S	
for file in ../data/Level_0/$cruise_id/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./config/$cruise_id/tsg_parse.awk $file >> nuq_tsg.dat	
	done
for file in ../data/Level_0/$cruise_id/Navigation/nav.*;
	do
		echo "$file";
		./config/$cruise_id/nav_parse.awk $file >> nuq_nav.dat	
	done	

cruise_id=NUQ202003S	
for file in ../data/Level_0/$cruise_id/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./config/$cruise_id/tsg_parse.awk $file >> nuq_tsg.dat	
	done
for file in ../data/Level_0/$cruise_id/Navigation/nav.*;
	do
		echo "$file";
		./config/$cruise_id/nav_parse.awk $file >> nuq_nav.dat	
	done
