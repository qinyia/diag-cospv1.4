
workdir=/home/lyl/WORK3/qinyi/scripts/diag-cospv1.4/

casename=(FC5_f19f19_cospv1.3 FC5_f19f19_update_cospv1.4)
dir1=/home/lyl/WORK2/cesm1_2_1/archive/${casename[0]}/atm/hist/
dir2=/home/lyl/WORK2/cosp_cesm1_2_1/archive/${casename[1]}/atm/hist/

dirs=($dir1 $dir2)

ncase=${#casename[@]}
echo $ncase

pncdump=F
diffs=T

cd $workdir

#====================================== ncdump first to check all variables ==========================================
if [ $pncdump == "T" ] ; then
	for icase in `seq 0 $[ncase-1]`
		do
			dirtmp=${dirs[icase]}
			ncdump -h $dirtmp/${casename[icase]}.cam.h0.0001-01.nc | tee ${casename[icase]}.cam.h0.0001-01.nc.ncdump
			ncdump -h $dirtmp/${casename[icase]}.cam.h1.0001-01-31-00000.nc | tee ${casename[icase]}.cam.h1.0001-01-31-00000.nc.ncdump
#			ncdump -h $dirtmp/${casename[icase]}.cam.h2.0001-01-31-00000.nc | tee ${casename[icase]}.cam.h2.0001-01-31-00000.nc.ncdump
		done
fi

#====================================== ncdump first to check all variables ==========================================
excludev=(ATB532_CAL,DBZE_CS,MOL532_CAL,SCOPS_OUT,CLDHGH_CAL_ICE,CLDHGH_CAL_LIQ,CLDHGH_CAL_UN,CLDLOW_CAL_ICE,CLDLOW_CAL_LIQ,CLDLOW_CAL_UN,CLDMED_CAL_ICE,CLDMED_CAL_LIQ,CLDMED_CAL_UN,CLDTOT_CAL_ICE,CLDTOT_CAL_LIQ,CLDTOT_CAL_UN,CLD_CAL_ICE,CLD_CAL_LIQ,CLD_CAL_TMP,CLD_CAL_TMPICE,CLD_CAL_TMPLIQ,CLD_CAL_TMPUN,CLD_CAL_UN)
#excludev=(ATB532_CAL,DBZE_CS,MOL532_CAL,SCOPS_OUT)

if [ $diffs == "T" ] ; then
	ncdiff -O -x -v ${excludev} ${dirs[1]}/${casename[1]}.cam.h0.0001-01.nc ${dirs[0]}/${casename[0]}.cam.h0.0001-01.nc diff.cam.h0.nc
	ncdiff -O ${dirs[1]}/${casename[1]}.cam.h1.0001-01-31-00000.nc ${dirs[0]}/${casename[0]}.cam.h1.0001-01-31-00000.nc diff.cam.h1.nc
#	ncdiff -O ${dirs[1]}/${casename[1]}.cam.h2.0001-01-31-00000.nc ${dirs[0]}/${casename[0]}.cam.h2.0001-01-31-00000.nc diff.cam.h2.nc
fi

