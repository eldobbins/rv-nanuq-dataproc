#!/bin/sh
rm nuq_nav.dat nuq_tsg.dat
#loop through all the files and cut out just the best parts
for file in ../data/Level_0/NUQ202001P/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./fix_tsg.awk $file >> nuq_tsg.dat	
	done
for file in ../data/Level_0/NUQ202001P/Navigation/nav.*;
	do
		echo "$file";
		./fix_nav.awk $file >> nuq_nav.dat	
	done
#	
for file in ../data/Level_0/NUG202003S/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./fix_tsg.awk $file >> nuq_tsg.dat	
	done
for file in ../data/Level_0/NUG202003S/Navigation/nav.*;
	do
		echo "$file";
		./fix_nav.awk $file >> nuq_nav.dat	
	done	
#	
for file in ../data/Level_0/NUQ202003S/SBE45-TSG/tsg.*;
	do
		echo "$file";
		./fix_tsg.awk $file >> nuq_tsg.dat	
	done
for file in ../data/Level_0/NUQ202003S/Navigation/nav.*;
	do
		echo "$file";
		./fix_nav.awk $file >> nuq_nav.dat	
	done
