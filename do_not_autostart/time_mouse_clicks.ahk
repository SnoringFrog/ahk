#SingleInstance force

tooltip Awaiting input
return

last_click := 0

~LButton::
		tooltip
		if (last_click){
			Msgbox % "Time between clicks: " A_TickCount - last_click
			exitapp
		} else {
			last_click := A_TickCount
		}
		return
