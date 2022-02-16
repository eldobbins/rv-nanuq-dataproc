# Notes on Logging

## Original notes from 2019 build

The only NMEA strings Hank was able to grab off the Airmar and parse into useful data with the campbell sci recorder 
were the $GPRMC and $GPGGA strings, the parsed variables in these two strings are as follows:

```
Alias GPSData(1)=Latitude_A
Alias GPSData(2)=Latitude_B
Alias GPSData(3)=Longitude_A
Alias GPSData(4)=Longitude_B
Alias GPSData(5)=Speed
Alias GPSData(6)=Course
Alias GPSData(7)=MagVar
Alias GPSData(8)=FixQual
Alias GPSData(9)=NumSats
Alias GPSData(10)=Altitude
Alias GPSData(11)=PPS
Alias GPSData(12)=SecSinceGPRMC
Alias GPSData(13)=GPSReady
Alias GPSData(14)=MaxClockChange
Alias GPSData(15)=NumClockChange
```

By default, the Airmar does not output the $GPGGA string and it's baud rate was set to 4800. 
That baud rate is not compatible with the CR1000X data logger. There are a number of commands that need to 
be issued to the GPS receiver to change it to 38400 baud and to output $GPGGA strings, these are issued to 
the Airmar when it is running in realtime, "run only" mode:
```
>$PAMTX,0*hh
>$PAMTC,EN,GGA,1,10*hh<cr><lf>
>$PAMTC,BAUD,38400*hh<CR><LF>
>$PAMTX,1
```

The Airmar also produces:
```
$HCHDG (heading, deviation and variation)
$TIROT (rate of turn)
$YXXDR (angular displacement, pitch
```

### Reassessment in 2021

Revisit the coding in the Campbell Sci programming and see how to grab additional NMEA data 
that the Airmar is producing. Currently, a Campbell routine does the parsing as a black box.
The line in the MS3 code that produces the variables we are storing looks like this:

```
GPS(GPSData(),-ComC3,0*3600,500,NMEASent())
```

[Thread on the campbell sci programming forum](https://www.campbellsci.com/forum?forum=1&l=thread&tid=1223)
that might address the parsing issue.
