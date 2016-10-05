#SingleInstance force

; run whatever sequence of commands I'm currently using
; probably generally through #Include so I can save the commands

#Include %A_ScriptDir%/do_not_autostart/openOpentmsPage.ahk 
actionFile = %A_ScriptDir%/do_not_autostart/openOpentmsPage.ahk ; duplicated since #Include can't take variables

FileRead lastFileContent, %actionFile%

^+\::
	FileRead newFileContent, %actionFile%
	if(newFileContent != lastFileContent) {
		SoundBeep 300, 300
		Reload
	} else {
		openOpentms("ContactPlace:Contacts", 1, 3)
	}
Return
