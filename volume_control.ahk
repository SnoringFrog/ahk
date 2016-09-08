#SingleInstance force
; Control system volume

; Toggle added to work around conflicts with tmux shortcuts
+!Up::
+!Down::
	Suspend, Toggle
	if A_IsSuspended 
		SoundBeep 137, 200
	else
		SoundBeep 237, 200
	Return

!Up::
RAlt & Up::
	Volume_Up()
	Return

!Down::
RAlt & Down::
	Volume_Down()
	Return

Volume_Up() {
	Send {Volume_Up 1}
	Return
}

Volume_Down() {
	Send {Volume_Down 1} 
	Return
}
