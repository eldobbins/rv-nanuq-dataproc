# m3s_weather

Code to use with the M3S (Mobile Marine Met Station) 

## Background

The M3S weather station is temporarily installed on vessels for the NGA LTER program.
It logs data using Campbell Scientific programs, and it will write to disk no matter what 
the conditions are. There are no deployment logs associated with the deployments, so
information on deployments must be inferred from the data itself.

The data sets labeled "Series" and "Ethernet" represent two different ways one can 
download logged data from the CR1000X. "Ethernet" data represents the time series 
that is written directly to the CR1000X memory every 5 seconds. "Series" data is data 
that is backed up on the CF card that is installed on the CR1000X.  The "Series" data 
has to be converted from a binary format to ascii by a Campbell Scientific proprietary 
piece of software.


## Likely installations (as of Oct, 2021):

### CR1000XSeries_Five_Sec.dat:
* 2019-05-03 08:22:25+00:00  -  2019-05-09 15:28:15+00:00
* 2021-09-20 03:44:40+00:00  -  2021-09-26 18:16:40+00:00
* plus 2 snippets of data from times with too-warm temperatures - presumably testing inside.

### CR1000X_Ethernet_Five_Sec.dat:
* 2019-04-26 22:00:55+00:00  -  2019-05-09 15:28:15+00:00
* 2019-06-29 00:43:00+00:00  -  2019-07-18 22:55:45+00:00
* 2019-07-23 15:12:25+00:00  -  2019-08-01 23:43:05+00:00
* 2019-09-11 22:27:05+00:00  -  2019-09-25 21:08:25+00:00
* plus 3 snippets with warm temperatures.

### Cruises
* Spring Tiglax 2019: 4/26/2019 - 5/9/2019 (Series and Ethernet)
* Summer Sikuliaq 2019: 6/29/2019 - 7/18/2019 (Ethernet only)
* Summer Nanuq 2019: 7/23/2019 - 8/2/2019 (Ethernet only)
* Fall Tiglax 2019: 9/11/2019 - 9/25/2019 (Ethernet only)
* Fall Tiglax 2021: 9/11/2021 - 9/27/2021 (Series only, but partial)

## Usage

1. Install geographiclib in MATLAB - either from the .mltbx file included here, or 
from [MATLAB File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/50605-geographiclib?s_tid=mwa_osa_a)  See [this MATLAB answer](https://www.mathworks.com/matlabcentral/answers/101885-how-do-i-install-additional-toolboxes-into-an-existing-installation-of-matlab#answer_182191) for how to install third-party toolboxes.


## Acknowledgements

### geographiclib

Charles Karney (2021). geographiclib (https://www.mathworks.com/matlabcentral/fileexchange/50605-geographiclib), MATLAB Central File Exchange. Retrieved October 20, 2021.

Karney, Charles F. F. “Algorithms for Geodesics.” Journal of Geodesy, vol. 87, no. 1, Springer Science and Business Media LLC, June 2012, pp. 43–55, doi:10.1007/s00190-012-0578-z.

### True Wind Corrections

Smith, S.R., Bourassa, M.A., Sharp, R.J (1999) "Establishing More Truth in True Winds"
Journal of Atmospheric and Oceanic Technology, vol. 16, no. 7, pp. 939-952,
doi: https://doi.org/10.1175/1520-0426(1999)016<0939:EMTITW>2.0.CO;2

A copy is included in the resources directory of this repo.

Code is provided by [WOCE-MET](https://www.coaps.fsu.edu/woce/truewind/truewinds.html),
with MATLAB code posted at [MATLAB Codes for True Winds](https://www.coaps.fsu.edu/woce/truewind/true-MATLAB.html) as MATLAB-codes.tar

