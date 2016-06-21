#!/bin/bash

# This script takes TEM calculations produced by Wuke Wang for DART-WACCM data 
# and changes the time units and axies to something CDO can deal with, and 
# then splits yearly files into months, deletes everything that's not January (to save space), 
# and then splits what's left into days. 

# first need to create a list of input files, e.g. like this:  
#ls /data/c1/wwang/Data/DART-CESM/nechpc-waccm-dart-gpsro-ncep-global-02/TEM_DW-Global-02.cam.h1.20* > file_list

# cycle over years
for ff in $(cat file_list)
do 



	# output filename stub - take off the nc and add a dash....
	stub="${ff/.nc/-}"

	# ...and also move it into the current directory 
	ffout=`basename $stub`
	echo $ffout

	# set the correct time units
	cdo -settunits,days -settaxis,${y}-01-01,00:00:00,1day $ff temp_correctunits.nc

	# split into days
	cdo splitday temp_correctunits.nc $ffout

done
