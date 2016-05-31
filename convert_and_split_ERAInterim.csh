#!/bin/bash

# This script takes TEM calculations produced by Wuke Wang for ERA-Interim data 
# and changes the time units and axies to something CDO can deal with, and 
# then splits yearly files into months, deletes everything that's not January (to save space), 
# and then splits what's left into days. 

# this is the path to Wuke's data 
datadir=/data/c1/wwang/Data/ERA-Interim/daily/


# cycle over years
for y in $(seq 2001 2012)
do

	# input filename  -- choose TEM files of heating rate files  
	ff="${datadir}TEM_ERA-Interim_Daily_DailyMean_${y}.nc"
	#ff="${datadir}WS_VTy_ERA-Interim_Daily_DailyMean_${y}.nc"
	echo $ff

	# output filename stub 
	ffout="TEM_ERA-Interim_dm_${y}-"
	#ffout="WS_VTy_ERA-Interim_dm_${y}-"

	# clean up 
	rm temp*nc

	# set the correct time units
	cdo -settunits,days -settaxis,${y}-01-01,00:00:00,1day $ff temp_correctunits.nc

	# split into months 
	cdo splitmon temp_correctunits.nc $ffout

	# delete non-winter files 
	#rm -rf ${ffout}02.nc
	rm -rf ${ffout}03.nc
	rm -rf ${ffout}04.nc
	rm -rf ${ffout}05.nc
	rm -rf ${ffout}06.nc
	rm -rf ${ffout}07.nc
	rm -rf ${ffout}08.nc
	rm -rf ${ffout}09.nc
	rm -rf ${ffout}10.nc
	rm -rf ${ffout}11.nc
	#rm -rf ${ffout}12.nc

	# split output into days 
	cdo splitday "${ffout}12.nc" "${ffout}12-"
	cdo splitday "${ffout}01.nc" "${ffout}01-"
	cdo splitday "${ffout}02.nc" "${ffout}02-"

	# delete the remaining winter monthly files 
	rm -rf ${ffout}01.nc
	rm -rf ${ffout}02.nc
	rm -rf ${ffout}12.nc

done
