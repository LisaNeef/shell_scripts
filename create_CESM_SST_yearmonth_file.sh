#!/bin/bash
# Run through CESM output and pull out SST fields, then slap together into one big file 

# set run directory 
datadir='/work/bb0519/cesm1_0_6/archive/b350071/B1850WCN_f19g16_1000y/atm/hist/'
run_stub='B1850WCN_f19g16_1000y'
# set start and end year  

y0=0001
yf=0156

# loop over available years and extract SST  

for y in $(seq -w $y0 $yf)
do
	# TEMP
	month='01'

	# loop over months 
	for m in $(seq -w 01 12)
	do

		# input filename  
		ffin="${datadir}${run_stub}.cam2.h0.${y}-${m}.pl.nc"
		echo ${ffin}

		# output filename stub 
		ffout="TEMP_${run_stub}.cam2.SST.${y}-${m}.nc"

		# use CDO to extract SST  
		cdo selname,SST ${ffin} ${ffout}

	done
done

# combine the SST files into one  

files_in="TEMP_${run_stub}.cam2.SST.*.nc"
merged_out="${run_stub}.cam2.SST.${y0}_${yf}.nc"
cdo mergetime ${files_in} ${merged_out}

# delete the temporary SST files 
#rm -rf TEMP*
