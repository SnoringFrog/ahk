#SingleInstance force
last_click := 0

~LButton::
	if (A_TickCount - last_click < 70) {
		Send ^{l}
		Sleep, 100
		Send ^{c}
		Sleep, 100
		Send ^{w}
		Sleep, 100
		WinActivate, ahk_exe chrome.exe 
		Send ^{n}
		Sleep, 100
		Send ^{v}
		Sleep, 100
		Send {Enter}
		last_click := 0
	} else {
		last_click := A_TickCount
	}
	return
