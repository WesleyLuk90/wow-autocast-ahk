#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include ImageLib.ahk

#SingleInstance force
#IfWinActive World of Warcraft

Addresses := Object()
Windows := Object()
hModule := DllCall("LoadLibrary", "str", "Potato.dll")
Menu, tray, add, Reset, ResetAddresses

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

NumPad9::
	hwnd := WinActive("World of Warcraft")
	if(hwnd){
		if(!Windows[hwnd]){
			Windows[hwnd] := true
			ToolTip,Window Enabled,,, 1
		} else {
			Windows[hwnd] := false
			ToolTip,Window Disabled,,, 1
		}
		SetTimer, RemoveToolTip, -1000
	}
return

RemoveToolTip:
	ToolTip,,,, 1
return

ResetAddresses:
	Addresses := Object()
return

main:
	startTime := A_TickCount
	for hwnd, enab in Windows 
	{
		if(!enab){
			continue
		}
		if(!Addresses[hwnd]){
			ToolTip, Searching for offset
			address := DllCall("Potato\searchForDouble", "Double", 571565, "Int", hwnd)
			Addresses[hwnd] := address
			ToolTip
		} else {
			value := DllCall("Potato\getDoubleAtAddress", "Int", hwnd, "Int", Addresses[hwnd], "Double")
			value2 := DllCall("Potato\getDoubleAtAddress", "Int", hwnd, "Int", Addresses[hwnd] + 32, "Double")
			if(value != 571565 || value2 != 414804){
				ToolTip, Incorrect values
			}
		}
	}
	for hwnd, enab in Windows 
	{
		if(!enab){
			continue
		}
		if(!Addresses[hwnd]){
			continue
		} else {
			value := DllCall("Potato\getDoubleAtAddress", "Int", hwnd, "Int", Addresses[hwnd], "Double")
			value2 := DllCall("Potato\getDoubleAtAddress", "Int", hwnd, "Int", Addresses[hwnd] + 32, "Double")
			if(value != 571565 || value2 != 414804){
				continue
			}
		}
		b := DllCall("Potato\getDoubleAtAddress", "Int", hwnd, "Int", Addresses[hwnd] + 16, "Double")
		;ToolTip, %b%
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
	delay := startTime + time - A_TickCount
	if (delay < 0){
		delay := 0
	}
	SetTimer, main, -%delay%
return