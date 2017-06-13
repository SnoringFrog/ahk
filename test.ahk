SysGet, monp, MonitorPrimary
;MsgBox, Primary: %monp%

SysGet, monc, MonitorCount
;MsgBox, Count: %monc%

SysGet, Mon2, Monitor, 1
SysGet, monname, MonitorName, 1
;MsgBox, %monname% Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.


SysGet, Mon2, Monitor, 2
SysGet, monname, MonitorName, 2
;MsgBox, %monname% Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.


SysGet, Mon2, Monitor, 3
SysGet, monname, MonitorName, 3
;MsgBox, %monname% Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.

identifyMonitors()
return

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

GuiClose:
ButtonClose: 
{
	exitapp
}
return
