; TODO: confirm chromix is running
; chromix 2>/dev/null || nohup chromix-server &

; TODO: close all current incognito windows instead of just OpenTMS tabs

; TODO: arg for incognito or not

; Run via VBScript that hides bash windows
;	was a good idea except then VBS makes a window
; Included for posterity. Lack of quotes is important from cmd onward.
; RunWait cscript.exe C:\cygwin\home\ethanp\vbs\hideBatch.vbs cmd /c chromix with .*127\.0\.0\.1:8888.* close, , hide

opentmsRoot := "http://127.0.0.1:8888/#"

openOpentms(page:="") {
	global opentmsRoot

	RunWait %comspec% "/c chromix with .*127\.0\.0\.1:8888.* close", , hide

	opentmsUrl := opentmsRoot . page

	Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito %opentmsUrl%, , chromeId

	WinWait, ahk_exe chrome.exe
	Sleep, 250
	moveToLeftMonitorRightHalf()
	;moveToLeftMonitorFullscreen()
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
