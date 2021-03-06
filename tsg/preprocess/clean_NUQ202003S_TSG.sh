#!/bin/sh
#
# There is one cruise that had files split between multiple directories with
# multiple cruise names. It will be nicer to copy those all to a single file. Once
# done, the original cruises are stashed in a subdirectory.
#
# Remember that all the original files have headers, so those need to be stripped off.
#
# ELD
# 2/4/2022
#

#
# Set up
#

dir=../../data/TSG/Level_0_v2
# make up a new cruise id
outfile=uaf_NUQ202003S_TSG_L0_v2.dat

# cleanup from prior runs - remove the temporary file
\rm nuq_tsg.dat

#
# Process the 3 cruises and copy output to a single file
#

cruise_id=NUQ202001P
./clean_nanuq_cruise.sh $cruise_id
\cp ${dir}/uaf_${cruise_id}_TSG_L0_v2.dat nuq_tsg.dat
\mv -f ${dir}/uaf_${cruise_id}_TSG_L0_v2.dat ${dir}/separate_originals


cruise_id=NUG202003S	
./clean_nanuq_cruise.sh $cruise_id
\cat ${dir}/uaf_${cruise_id}_TSG_L0_v2.dat >> nuq_tsg.dat
\mv -f ${dir}/uaf_${cruise_id}_TSG_L0_v2.dat ${dir}/separate_originals


cruise_id=NUQ202003S	
./clean_nanuq_cruise.sh $cruise_id
\cat ${dir}/uaf_${cruise_id}_TSG_L0_v2.dat >> nuq_tsg.dat
\mv -f ${dir}/uaf_${cruise_id}_TSG_L0_v2.dat ${dir}/separate_originals

#
# make a single cruise that is data from all three previously defined
#

# add a header
echo "#Year Month Day Hour Minute Second Temperature Conductivity Salinity Sound_Velocity" > ${dir}/${outfile}

# add the data without header lines
sed '/#/d' nuq_tsg.dat >> ${dir}/${outfile}

# clean up
\rm nuq_tsg.dat