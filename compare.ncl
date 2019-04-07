
dir1="/home/lyl/WORK2/cosp_cesm1_2_1/archive/FC5_f19f19_update_cospv1.4/atm/hist/"
dir2="/home/lyl/WORK2/cesm1_2_1/archive/FC5_f19f19_cospv1.3/atm/hist/"
dir3="./"

case1			= (/"FC5_f19f19_update_cospv1.4.cam.h0.0001-01.nc","FC5_f19f19_update_cospv1.4.cam.h1.0001-01-31-00000.nc"/)
case2			= (/"FC5_f19f19_cospv1.3.cam.h0.0001-01.nc","FC5_f19f19_cospv1.3.cam.h1.0001-01-31-00000.nc"/)
case3			= (/"diff.cam.h0.nc","diff.cam.h1.nc"/)

do it=0,dimsizes(case1)-1
;do it=0,0

print("--------------"+case1(it)+"---------------------")

f0				= addfile(dir3+case3(it),"r")
f1				= addfile(dir1+case1(it),"r")
f2				= addfile(dir2+case2(it),"r")

vnames			= getfilevarnames(f0)

count=0		; to count the number of variables which are different in COSPv1.3 and COSPv1.4
count1=0	; to count the total number of variables which are always zero

do ivar=0,dimsizes(vnames)-1


	if(vnames(ivar).eq."time_written".or.vnames(ivar).eq."date_written")then
		continue
	end if
	var1			= f1->$vnames(ivar)$
	var2			= f2->$vnames(ivar)$
	var3			= var1-var2

	if(min(var1).eq.0 .and. max(var1).eq.0)then
		count1 = count1+1
		print("-------always is zero-------"+vnames(ivar)+"---------------------")
		print(min(var1)+"		"+max(var1))
		print(min(var2)+"		"+max(var2))
		print(min(var3)+"		"+max(var3))
	end if

	if(min(var3).eq.0 .and. max(var3).eq.0)then
		delete([/var1, var2, var3/])
		continue
	else
		count = count+1
		print("-----difference between COSv1.3 and COSPv1.4---------"+vnames(ivar)+"---------------------")
		print(min(var1)+"		"+max(var1))
		print(min(var2)+"		"+max(var2))
		print(min(var3)+"		"+max(var3))

;		if(dimsizes(dimsizes(var1)).eq.3)then
;			wks						= gsn_open_wks("pdf","./figure/compare-diff-plot-"+it+"-"+vnames(ivar))
;			gsn_define_colormap(wks,"BlueYellowRed")
;			res						= True
;			res@gsnFrame			= False
;			res@gsnDraw				= False
;			res@cnFillOn			= True
;			res@cnLinesOn			= False
;			res@cnLineLabelsOn		= False
;
;			resd					= res
;
;			plot0				 	= gsn_csm_contour_map_ce(wks,var1(0,:,:),res)
;			plot1					= gsn_csm_contour_map_ce(wks,var2(0,:,:),res)
;			resd@gsnLeftString		= "COSPv1.4-COSPv1.3"
;			symMinMaxPlt(var3,15,False,resd)
;			plot2					= gsn_csm_contour_map_ce(wks,var3(0,:,:),resd)
;
;			gsn_panel(wks,(/plot0,plot1,plot2/),(/2,2/),False)
;
;		end if
		delete([/var1, var2, var3/])
	end if
	

end do ; do ivar=

print("count=	"+count+"	count1=	"+count1)

delete(vnames)

end do ; do it=
