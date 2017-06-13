identifyMonitors()

identifyMonitors(mon=0){
	if (mon = 0) {
		SysGet, count, MonitorCount

		Loop, %count% {
			SysGet, mon, MonitorWorkArea, %A_Index%
			Gui, New
			Gui, add, text,, %A_Index%
			Gui, Add, Button, default, Close
			
			x := (monLeft + monRight)//2
			y := (monTop + monBottom)//2
			Gui, show, x%x% y%y% w100

		}
	} else {
		SysGet, mon, MonitorWorkArea, %A_Index%
		Gui, New
		Gui, add, text,, %A_Index%
		Gui, Add, Button,, Close
		
		x := (monLeft + monRight)//2
		y := (monTop + monBottom)//2
		Gui, show, x%x% y%y% w100
	}	

}

return
GuiClose:
ButtonClose: 
{
	exitapp
}
return
