#!/usr/bin/awk -f

# prints lines with degrees and minutes separated by whitespace for latitude and longitude
#
# Works with Navigation data with format:
# Col 1-6: Date/Time
# Col 7: Latitude (Deg Min)
# Col 8: Longitude (Deg Min)
# Col 9: Depth (m)
# Col 10: Heading (∞)
# Col 11: Course Over Ground (∞)
# Col 12: Speed Over Ground (kts)
#
# Note: Gulf of Alaska = 2 digit latitude and 3 digit longitude (degrees west)
#


{
if (substr($1,1,1) !~ "#") 
	{
	print $1, $2, $3, $4, $5, $6, substr($7,1,2), substr($7,3,9), substr($8,1,3), substr($8,4,9), $9, $10, $11, $12
	}
}