#!/bin/bash
## For a given DART-WACCM experiment, loop over dates and compute the ensemble mean for 
## a given type of h-file  
#
## Lisa Neef, 4 Apr 2015  



# ----automatic file list generation - comment out to make this make the script go over all avail. 
# history files 

## paths and settings  
#data_dir='/data/b4/swahl/cesm1_2_0/archive/nechpc-waccm-dart-gpsro-ncep-no-assim-02/atm/hist/'
#h='1'

## use instance 1 (i.e. ensemble member 1) to get a list of the date extensions  
#file_list="$data_dir*001.h$h*.nc"

#---manuarl file list generation
# in the shell, generate a list of desired files like this (make sure it only lists ensemble member 1):  
#ls /data/b4/swahl/cesm1_2_0/archive/nechpc-waccm-dart-gpsro-ncep-no-assim-02/atm/hist/data_dir*001.h1*.nc

# loop over the list of date extensions and use ncea to compute the ensemble mean  
#for ff in $file_list 
for ff in $(cat file_list)
do 
	# replace the filename with a wild card  
	fens="${ff/cam_0001/cam_*}"

	# create a name for the ensemble mean file
	ftemp=$(basename "$ff")
	fmean="${ftemp/cam_0001/cam_ensemble_mean}"

	# now use ncea to compute the ensemble mean in each case
	ncea $fens $fmean  

	# print 
	echo $fmean
done 


#ncea /data/c1/swahl/cesm1_2_0/archive/nechpc-waccm-dart-gpsro-ncep-no-assim-01/atm/hist/nechpc-waccm-dart-gpsro-ncep-no-assim-01.cam_*.h1.2009-11-30-21600.nc test.nc

