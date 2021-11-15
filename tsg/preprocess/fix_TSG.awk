#!/usr/bin/awk -f
{
if (substr($1,1,1) !~ "#") 
	{
	print $1, $2, $3, $4, $5, $6, substr($8,1,7), substr($10,1,7), substr($12,1,7), substr($13,4,8)
	}
}