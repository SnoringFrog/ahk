#SingleInstance force

; HalfKeyboard invented by Matias Corporation between 1992 and 1996
; Originally coded in AutoHotkey by jonny in 2004
; Many thanks to Chris for helping him out with this script.
; Capslock hacks and `~ remap to '" by Watcher
; This implementation was done by mbirth in 2007
; getKeyboardLayout and dec2hex taken from animeaime (written in 2011)
; Colemak support added by SnoringFrog in 2016

ahk_resources_dir := "C:\cygwin\home\ethanp\ahk\resources"


Menu Tray, Icon, %ahk_resources_dir%\HalfKeyboard.ico
Menu Tray, Tip, HalfKeyboard emulator
Menu Tray, Add, E&xit, MenuExit
Menu Tray, NoStandard
;FileInstall HK_dn.gif, HalfKeyboard_help.gif

;RegRead KLang, HKEY_CURRENT_USER, Keyboard Layout\Preload, 1
;StringRight KLang, KLang, 4
;If (!KLang)
;  KLang := A_Language
; lWord below is equivalent to KLang with '0x' prepended

getKeyboardLayout(hWord, lWord) ; hWord = layout; lWord = lang
;msgBox, % hWord . " " . lWord



If (lWord = "0x407") {
  ; 0407 DE_de QWERTZ mirror set
  original := "^12345qwertasdfgyxcvb"
  mirrored := "ß09876poiuzölkjh-.,mn"
} Else If (lWord = "0x40c" || lWord = "0x40C") {
  ; 040c FR_fr AZERTY mirror set         
  original := "²&é" . """" . "'(azertqsdfgwxcvb"   ; split up string for better
  mirrored := ")àç" . "_"  . "è-poiuymlkjh!:;,n"   ; human readability
} Else If (lWord = "0x409") {
  ; 0409 US_us QWERTY mirror set
  If (hWord = "0x409") {
  ; Default QWERTY layout
    original := "``" . "12345qwertasdfgzxcvbh6"   ; split up string for better
    mirrored := "'"  . "09876poiuy;lkjh/.,mn'="   ; human readability
  } Else If (hWord = "0xF0C0") {
  ; Colemak layout
    original := "``" . "12345qwfpgarstdzxcvbh6"   ; split up string for better
    mirrored := "'"  . "09876;yuljoienh/.,mk'="   ; human readability
  }
}

; Now define all hotkeys
Loop % StrLen(original)
{
  c1 := SubStr(original, A_Index, 1)
  c2 := SubStr(mirrored, A_Index, 1)
  Hotkey Space & %c1%, DoHotkey
  Hotkey Space & %c2%, DoHotkey
}

return


; This key may help, as the space-on-up may get annoying, especially if you type fast.
;Control & Space::Suspend ; disables bc it conflicts with Eclipse shortcuts

; Not exactly mirror but as close as we can get, Capslock enter, Tab backspace.
Space & Escape::Send {Enter} ; for users with Caps mapped to Esc
Space & CapsLock::Send {Enter}
Space & Tab::Send {Backspace}

; If spacebar didn't modify anything, send a real space keystroke upon release.
+Space::Send {Space}
Space::Send {Space}

; Looks dumb, but Win+Space (for changing language) and Ctrl+Space (autocomplete suggestions in Eclipse) fail without this  
; TODO: I feel like there has to be something else in the code messing this up
#Space::Send #{Space}
^Space::Send ^{Space}

; Define special key combos here (took them from RG's mod):
^1::Send {Home}
^2::Send {End}
^3::Send {Del}

; General purpose
DoHotkey:
  StringRight ThisKey, A_ThisHotkey, 1
  i1 := InStr(original, ThisKey)
  i2 := InStr(mirrored, ThisKey)
  If (i1+i2 = 0) {
    MirrorKey := ThisKey
  } Else If (i1 > 0) {
    MirrorKey := SubStr(mirrored, i1, 1)
  } Else {
    MirrorKey := SubStr(original, i2, 1)
  }
  
  Modifiers := ""
  If (GetKeyState("LWin") || GetKeyState("RWin")) {
    Modifiers .= "#"
  }
  If (GetKeyState("Control")) {
    Modifiers .= "^"
  }
  If (GetKeyState("Alt")) {
    Modifiers .= "!"
  }
  If (GetKeyState("Shift") + GetKeyState("CapsLock", "T") = 1) {
    ; only add if Shift is held OR CapsLock is on (XOR) (both held down would result in value of 2)
    Modifiers .= "+"
  }
  Send %Modifiers%{%MirrorKey%}
return

Space & F1::
  ; Help-screen using SplashImage
  CoordMode Caret, Screen
  y := A_CaretY + 20
  If (y > A_ScreenHeight-100)
    y := A_CaretY - 20 - 100
  SplashImage HalfKeyboard_help.gif, B X%A_CaretX% Y%y%
  Sleep 5000
  SplashImage OFF
return

MenuExit:
  ExitApp
return

;below is from https://autohotkey.com/board/topic/34798-solved-get-keyboard-layout-for-active-window/
dec2hex(decValue)
{
    if (decValue < 0)
    {
        ErrorLevel := 1
        return 0
    }

    hexStr := ""
    base := 16

    Loop
    {
        remainder := mod(decValue, base)
        decValue //= base
        
        if (remainder >= 0 && remainder <= 9)
        {
            hexStr := remainder . hexStr
        }
        else
        {
            hexStr := Chr(remainder - 10 + Asc("A")) . hexStr
        }

        if (decValue = 0)
        {
            ErrorLevol := 0
            return "0x" . hexStr
        }
    }
}

getKeyboardLayout(ByRef hWord, ByRef lWord)
{
    keyboardLayout := DllCall("user32.dll\GetKeyboardLayout", "uint")

    hWord := dec2hex(keyboardLayout >> 16) ; layout
    lWord := dec2hex(keyboardLayout & 0xFFFF) ; language
}

