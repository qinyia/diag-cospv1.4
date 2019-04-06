
dir1="/home/share3/lyl/work3/qinyi/scam/cosp_cesm1_2_2/update_COSPv1.4/run/"
dir2="/home/share3/lyl/work3/qinyi/scam/cesm1_2_2/def_COSPv1.3/run/"
dir3="./"

case1			= (/"COSP_v1.4_cosp_runall.cam.h0.2006-01.nc","COSP_v1.4_cosp_runall.cam.h1.2006-01-18-00000.nc",\
					"COSP_v1.4_cosp_cfmip.cam.h0.2006-01.nc","COSP_v1.4_cosp_cfmip.cam.h1.2006-01-18-00000.nc",\
					"COSP_v1.4_cosp_cfmip.cam.h2.2006-01-18-00000.nc"/)

case2			= (/"COSP_v1.3_cosp_runall.cam.h0.2006-01.nc","COSP_v1.3_cosp_runall.cam.h1.2006-01-18-00000.nc",\
					"COSP_v1.3_cosp_cfmip.cam.h0.2006-01.nc","COSP_v1.3_cosp_cfmip.cam.h1.2006-01-18-00000.nc",\
					"COSP_v1.3_cosp_cfmip.cam.h2.2006-01-18-00000.nc"/)

case3			= (/"diff.cosp_runall.cam.h0.nc","diff.cosp_runall.cam.h1.nc",\
					"diff.cosp_cfmip.cam.h0.nc","diff.cosp_cfmip.cam.h1.nc",\
					"diff.cosp_cfmip.cam.h2.nc"/)

;do it=0,dimsizes(case1)-1
do it=0,0

print("--------------"+case1(it)+"---------------------")

f0				= addfile(dir3+case3(it),"r")
f1				= addfile(dir1+case1(it),"r")
f2				= addfile(dir2+case2(it),"r")

vnames			= getfilevarnames(f0)

do ivar=0,dimsizes(vnames)-1

	if(vnames(ivar).eq."time_written".or.vnames(ivar).eq."date_written")then
		continue
	end if
	var1			= f1->$vnames(ivar)$
	var2			= f2->$vnames(ivar)$
	var3			= var1-var2

	print("--------------"+vnames(ivar)+"---------------------")
	print(min(var1)+"		"+max(var1))
	print(min(var2)+"		"+max(var2))
	print(min(var3)+"		"+max(var3))
	
	delete([/var1, var2, var3/])

end do ; do ivar=

delete(vnames)

end do ; do it=
