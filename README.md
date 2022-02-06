# rv-nanuq-data
## A repository to hold code associated with R/V Nanuq, CFOS, UAF

R/V Nunuq is a small research vessel belonging to the College of Fisheries and Ocean Sciences at
the University of Alaska Fairbanks. She is equiped with scientific instrumentation and makes regular
trips through Resurrection Bay to sample water quality parameters at stations GAK1, GAKOA, and Res2.5.
These data should be easy to process and integrate into existing projects, so this repository was created.

### Requirements

The MATLAB code requires certain packages be installed.

* m_map with the GSHHS coastline database: https://www.eoas.ubc.ca/~rich/mapug.html
* the MATLAB installation itself must be recent enough to include support for tables

Preprocessing requires access to *nix commands like bash and awk. These tools are meant to be run from the command line.

## Data Types

Please see the nested directories for details on each data type.

### Navigation

Vessel position, heading, course over ground, and speed over ground are recorded every second. This code
cleans up these data and stores them in MATLAB formatted files that can be used for subsequent analysis.

### TSG

Thermosalinograph data are recorded every 5 seconds. These data must be combined with navigation data to be
useful.


## Credits

* Elizabeth Dobbins (Feb. 2020)
* Hank Statscewich (preliminary TSG code)
