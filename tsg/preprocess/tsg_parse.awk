#!/usr/bin/awk -f

# prints TSG data lines stripping out the strings identifying parameters
#
# Works with TSG data of format:
# Col 1-6: Date/Time
# Col 7: Temperature (∞C)
# Col 8: Conductivity (S/m)
# Col 9: Salinity (PSU)
# Col 10: Sound Velocity (m/s)
# 
# Parameters in the original file are formatted like:
# "t1= 14.4441, c1= 2.43766, s= 18.9918, sv=1486.252"
# Strip out everything but the numbers. 

{
if (substr($1,1,1) !~ "#") 
	{
	print $1, $2, $3, $4, $5, $6, substr($8,1,7), substr($10,1,7), substr($12,1,7), substr($13,4,8)
	}
}