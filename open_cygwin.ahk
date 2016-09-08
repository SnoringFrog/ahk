#SingleInstance force

;open Cygwin with sup+alt+t and (try to) focus the window

#!t::

  Run, C:\cygwin\bin\mintty.exe - , , , cygwinPID
  WinWait, ~ ahk_pid %cygwinPID%
  WinActivate, ~ ahk_pid %cygwinPID%
Return
