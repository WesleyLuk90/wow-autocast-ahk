#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include Gdip.ahk

If !gdi_ptoken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}

getHWNDPixel(hwnd, x, y){
	pBitmap := Gdip_BitmapFromHWND(hwnd)
	color := Gdip_GetPixel(pBitmap, x, y)
	Gdip_DisposeImage(pBitmap)
	return color
}

saveWindowToFile(hwnd, file){
	bmp := Gdip_BitmapFromHWND(hwnd)
	Gdip_SaveBitmapToFile(bmp, file)
	Gdip_DisposeImage(bmp)
}