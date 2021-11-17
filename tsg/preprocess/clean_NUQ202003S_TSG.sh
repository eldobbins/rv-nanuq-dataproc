#!/bin/sh

# cleanup from prior runs
rm nuq_nav.dat nuq_tsg.dat


# loop through all the files and cut out just the best parts for Cruise NUQ202003S
# (three different directories are involved)


cruise_id=NUQ202001P
./clean_nanuk_cruise.sh $cruise_id
\cp ../data/Level_0/$cruise_id/NUQ_TSG_${cruise_id}.dat nuq_tsg.dat
\cp ../data/Level_0/$cruise_id/NUQ_NAV_${cruise_id}.dat nuq_nav.dat


cruise_id=NUG202003S	
./clean_nanuk_cruise.sh $cruise_id
\cat ../data/Level_0/$cruise_id/NUQ_TSG_${cruise_id}.dat >> nuq_tsg.dat
\cat ../data/Level_0/$cruise_id/NUQ_NAV_${cruise_id}.dat >> nuq_nav.dat


cruise_id=NUQ202003S	
./clean_nanuk_cruise.sh $cruise_id
\cat ../data/Level_0/$cruise_id/NUQ_TSG_${cruise_id}.dat >> nuq_tsg.dat
\cat ../data/Level_0/$cruise_id/NUQ_NAV_${cruise_id}.dat >> nuq_nav.dat


# make a single cruise that is data from all three previously defined
cruise_id=NUQ202003S_all	
\mv nuq_tsg.dat ../data/Level_0/$cruise_id/NUQ_TSG_${cruise_id}.dat
\mv nuq_nav.dat ../data/Level_0/$cruise_id/NUQ_NAV_${cruise_id}.dat