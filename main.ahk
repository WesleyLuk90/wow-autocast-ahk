#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include ImageLib.ahk

#SingleInstance force
#IfWinActive World of Warcraft

time := 50

SetTimer, main, -%time%

sendToAll(key){
	WinGet, IDs, List, World of Warcraft
	Loop, %IDs%
	{
		thisID := IDs%A_Index%
		ControlSend,, %key%, ahk_id %thisID%
	}
}

F3::
	sendToAll("{F3}")
return

F10::
	sendToAll("{F10}")
return

F11::
	sendToAll("{F11}")
return

F12::
	sendToAll("{F12}")
return

XButton2::

return

NumPadDiv::

return

main:
	startTime := A_TickCount
	if(GetKeyState("XButton2", "P") || GetKeyState("NumPadDiv", "P")){
		if(WinActive("World of Warcraft")){
			;hwnd := WinExist("A")
			WinGet, IDs, List, World of Warcraft
			Loop, %IDs%
			{
				hwnd := IDs%A_Index%
				pixel := getHWNDPixel(hwnd, 0, 0)
				r := (pixel >> 16) & 0xff
				g := (pixel >> 8) & 0xff
				b := (pixel >> 0) & 0xff
				;ToolTip, %r% %g% %b%
				if(b == 1){
					ControlSend,, 1, ahk_id %hwnd%
				} else if(b == 2){
					ControlSend,, 2, ahk_id %hwnd%
				} else if(b == 3){
					ControlSend,, 3, ahk_id %hwnd%
				} else if(b == 4){
					ControlSend,, 4, ahk_id %hwnd%
				} else if(b == 5){
					ControlSend,, q, ahk_id %hwnd%
				} else if(b == 6){
					ControlSend,, e, ahk_id %hwnd%
				} else if(b == 7){
					ControlSend,, f, ahk_id %hwnd%
				} else if(b == 8){
					ControlSend,, r, ahk_id %hwnd%
				} else if(b == 9){
					ControlSend,, v, ahk_id %hwnd%
				} else if(b == 10){
					ControlSend,, 5, ahk_id %hwnd%
				} else if(b == 11){
					ControlSend,, 6, ahk_id %hwnd%
				} else if(b == 12){
					ControlSend,, z, ahk_id %hwnd%
				} else if(b == 13){
					ControlSend,, x, ahk_id %hwnd%
				} else if(b == 14){
					ControlSend,, c, ahk_id %hwnd%
				}
			}
		}
	}
	delay := startTime + time - A_TickCount
	if (delay < 0){
		delay := 0
	}
	SetTimer, main, -%delay%
return