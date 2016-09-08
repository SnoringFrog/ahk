#Persistent	; to keep the script allive for testing

; https://autohotkey.com/board/topic/65169-autoreload-script-if-changed-even-compiled-ones/

AutoUpdate2()	; testing the function

return; end of the autoexecute section

AutoUpdate2() {

	static A_ScriptPath, Time

		A_ScriptPath := A_IsCompiled ? SubStr(A_ScriptFullPath,1, -3) "ahk" : A_ScriptFullPath

		FileDelete, %A_ScriptFullPath%_; Delete the old file on reload

		FileGetTime, Time , %A_ScriptPath%, M; Retrieves the datetime stamp of the curent script

		SetTimer,UPDATEDSCRIPT2,1000; Start the timer

		UPDATEDSCRIPT2:

		FileGetTime, NewTime , %A_ScriptPath%, M	; Retrieves the datetime stamp of the script

		Tooltip,%A_ScriptPath%`ntest234; change this line to test it

		if (Time <> NewTime) {; if the script file has changed

	if (A_IsCompiled == 1) {; if the file is compiled

	FileMove,%A_ScriptFullPath%,%A_ScriptFullPath%_,1	; Move the file (rename)

	RunWait, "D:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "%A_ScriptPath%"	; compile the new script

	Run %A_ScriptFullPath%	; run the new exe (if #SingleInstance force is there, it will kill the script here)

	ExitApp ; if #SingleInstance force is not there, this script wil exit now

	} else Reload; reload the script

		}

	return; exit the sub (function at first run)

}
