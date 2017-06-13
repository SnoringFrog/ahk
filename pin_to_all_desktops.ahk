#SingleInstance force

; Shift+middle click to toggle pin to all desktops
WS_EX_TOOLWINDOW := 0x00000080
+MButton::WinSet, ExStyle, ^%WS_EX_TOOLWINDOW%, A
