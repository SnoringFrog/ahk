; TODO: confirm chromix is running
; chromix 2>/dev/null || nohup chromix-server &

; TODO: close all current incognito windows instead of just OpenTMS tabs

; TODO: arg for incognito or not

; Run via VBScript that hides bash windows
;	was a good idea except then VBS makes a window
; Included for posterity. Lack of quotes is important from cmd onward.
; RunWait cscript.exe C:\cygwin\home\ethanp\vbs\hideBatch.vbs cmd /c chromix with .*127\.0\.0\.1:8888.* close, , hide

; Uncomment the line below if you don't know which window is which
;identifyWindows()

opentmsRoot := "http://127.0.0.1:8888/#"
defaultPosition := 3

openOpentms(page:="", pos=0, mon=0) {
	global defaultPosition
	global opentmsRoot

	RunWait %comspec% "/c chromix with .*127\.0\.0\.1:8888.* close", , hide

	opentmsUrl := opentmsRoot . page

	Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito %opentmsUrl%, , chromeId

	window := "ahk_exe chrome.exe"
	WinWait, %window%
	Sleep, 250

	;If (pos = 3)
	;	moveToLeftMonitorRightHalf()
	;Else	
	;	moveToLeftMonitorFullscreen()
	moveWindow(window, pos, mon) 
}

moveWindow(window, pos=0, mon=0) {
	global defaultPosition

	if (pos = 0)
		pos := defaultPosition

	if (mon = 0)
		SysGet, mon, MonitorPrimary

	WinRestore, %window%

	getPos(pos, mon, x, w, y, h)

	if (pos = 1) {
		WinMove, %window%,, %x%, %y%
		WinMaximize, %window%
	} else {
		WinMove, %window%,, %x%, %w%, %y%, %h%
	}
}

getPos(pos, monNumber, byref x, byref width, byref y, byref height)  {
	; instead of all the math, I could just get the monitor to the proper
	;	monitor and then rely on shortcuts (how do quarter shortcuts work?)

	; positions:
	; 1 full screen
	; 2 left half
	; 3 right half
	; 4 top half
	; 5 bottom half
	; 6 top left corner
	; 7 top right corner
	; 8 bottom left corner
	; 9 bottom right corner
	
	SysGet, mon, MonitorWorkArea, %monNumber%

	monWidth := monRight - monLeft
	monHeight := monBottom - monTop

	x := monLeft
	y := monTop
	width := monWidth
	height := monHeight

	if (pos = 1)
		max := "true"

	if (pos = 3) or (pos = 7) or (pos = 9)
		x := (monLeft+monRight)//2

	if (pos = 5) or (pos = 8) or (pos = 9)
		y := (monTop+monBottom)//2

	if (pos = 2) or (pos = 3) or (pos >= 6 and pos <= 9)
		width//=2

	if (pos >= 4) and (pos <= 9)
		height//=2

	; return x, width, y, height
}

moveToLeftMonitorRightHalf(){
	WinRestore, ahk_exe chrome.exe
	
	; move window to right half of leftmost monitor
	WinMove, ahk_exe chrome.exe,,-970,10,960,1050 ; gets pretty close, ensures we're on the correct monitor
	; Send, #{Right} ; gets the size right, but alone has no guarantees about monitor
	; Send, {Escape} ; cancel out of Windows' auto "select monitor for left half" thing
}

moveToLeftMonitorFullscreen(){
	WinRestore, ahk_exe chrome.exe

	; move window to leftmost monitor and maximize
	WinMove, ahk_exe chrome.exe,,-1900,10
	WinMaximize, ahk_exe chrome.exe
}

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
