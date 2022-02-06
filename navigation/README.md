# Navigation Data Overview
## (as of Feb. 2022)

This code was delivered as a set of 13 separate cruises that needed to be processed in a big chunk. The emphasis
was on preparing data files that could be used in subsequent analysis. Tidy CSV files were not prepared because
it is unlikely that these data will be archived as their own unit.

## Requirements

In addition to the code requirements listed at the repository base, this code expects data in a directory with the 
following directory structure.  I've used `data/` as a symbolic link to where the data really are.

```
├── data                                    # symbolic link to 
  ├── Navigation
  │   ├── Level_0                           # raw data
  │   │   ├── NUG202003S                    # raw data are separated by cruise id
  │   │   │   ├── nav.20200728T184757Z
  │   │   │   ├── nav.20200728T190000Z
  │   │   │   ├── nav.20200728T194726Z
  │   │   │   ├── ...
  │   ├── Level_0_v2                        # raw data in the corrected format
  │   ├── Level_1                           # editted data
  │   │   ├── Plots                         # for maps and timeseries
```

## Pre-processing Raw Files

Multiple raw data files are produced every cruise. Each begins with this header:

```
# R/V NANUQ
# Call Sign: WDL4512
# MMSI: 368132150
#
# Navigation Sensors:
# Garmin GPSMAP 7610xsv
# Furuno SC-70
# Airmar 50/200 kHz Sonar
#
# Col 1-6: Date/Time
# Col 7: Latitude (Deg Min)
# Col 8: Longitude (Deg Min)
# Col 9: Depth (m)
# Col 10: Heading (∞)
# Col 11: Course Over Ground (∞)
# Col 12: Speed Over Ground (kts)
#
# End of Header
```

Note that position degrees and minutes are not separated into different columns. The preprocessing code:

1. concatinates all the separate files together
2. separates degrees and minutes into separate columns
3. adds a single line of column headers that can be used by MATLAB to generate a table

Use:
```
> ./clean_all_nanuq.sh         # loops through all the cruises to perform the corrections
> ./clean_NUQ202003S_Nav.sh    # this cruise was split between several cruise ids. This joins them
```

If in the future, just a single cruise needs to be processed, you can use
```
> ./clean_nanuq_cruise.sh {cruise_id}
```
Assuming, of course, that the data have been added to the directory structure described above.

## Processing

This is a single script that performs some very basic clean-up on all the Navigation files:

1. remove lat = lon = 0, and depth and speed too
2. sort time and remove duplicate timesteps
3. trim 3 cruises that have data at odd times
4. it reads from Level_0_v2 and writes to Level_1

No hand-editting is performed.  These data are of limited use. There
is the possibility that NUQ202003Sall will be useful for the M3S weather
station, but if that needs more clean-up, I will do it later.

## Plotting

There are 2 plotting scripts: one for raw data and one for the clean-up verions. They make maps and timeseries. 
The plots of clean data (Level 1) are saved.  Both scripts run on all the available data files.

*Feb 6, 2022*
