#!/usr/bin/awk -f
{
if (substr($1,1,1) !~ "#") 
	{
	print $1, $2, $3, $4, $5, $6, substr($7,1,2), substr($7,3,9), substr($8,1,3), substr($8,4,9), $9, $10, $11, $12
	}
}