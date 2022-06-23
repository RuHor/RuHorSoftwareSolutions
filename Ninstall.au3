#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Instalador Ninite
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Ru Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         RuHor Ru

 Script Function:
	Software para instalar aplicaciones desatendidas de ninite.

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ColorConstantS.au3>
#include <GUIConstants.au3>
#Region
Global $titulo = "Ninstall 1.0"
GUICreate($titulo, 290, 440)
GUISetBkColor(0x202020)
$Label1 = GUICtrlCreateLabel("INSTALADORES ONLINE", 80, 8, 130, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox1 = GUICtrlCreateCheckbox("", 16, 30, 15, 17)
GUICtrlCreateLabel("7zip", 36, 31, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox2 = GUICtrlCreateCheckbox("", 16, 55, 15, 17)
GUICtrlCreateLabel("Aimp", 36, 56, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox3 = GUICtrlCreateCheckbox("", 16, 80, 15, 17)
GUICtrlCreateLabel("Audacity", 36, 81, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox4 = GUICtrlCreateCheckbox("", 16, 105, 15, 17)
GUICtrlCreateLabel("Chrome", 36, 106, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox5 = GUICtrlCreateCheckbox("", 16, 130, 15, 17)
GUICtrlCreateLabel("Firefox", 36, 131, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox6 = GUICtrlCreateCheckbox("", 16, 155, 15, 17)
GUICtrlCreateLabel("Foobar2000", 36, 156, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox7 = GUICtrlCreateCheckbox("", 16, 180, 15, 17)
GUICtrlCreateLabel("HandBrake", 36, 181, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox8 = GUICtrlCreateCheckbox("", 16, 205, 15, 17)
GUICtrlCreateLabel("K-Lite Codec", 36, 206, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox9 = GUICtrlCreateCheckbox("", 16, 230, 15, 17)
GUICtrlCreateLabel("Notepad++", 36, 231, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox10 = GUICtrlCreateCheckbox("", 16, 255, 15, 17)
GUICtrlCreateLabel("ShareX", 36, 256, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox11 = GUICtrlCreateCheckbox("", 16, 280, 15, 17)
GUICtrlCreateLabel("Sumatra PDF", 36, 280, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox12 = GUICtrlCreateCheckbox("", 16, 305, 15, 17)
GUICtrlCreateLabel("Teamviewer", 36, 305, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox13 = GUICtrlCreateCheckbox("", 16, 330, 15, 17)
GUICtrlCreateLabel("VLC Player", 36, 330, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Checkbox14 = GUICtrlCreateCheckbox("", 16, 355, 15, 17)
GUICtrlCreateLabel("WinRAR", 36, 355, 97, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Button1 = GUICtrlCreateButton("Instalar", 24, 385, 243, 25)
GUICtrlSetBkColor(-1, 0x282828)
GUICtrlSetColor(-1, $COLOR_WHITE)
$Label2 = GUICtrlCreateLabel("RuHor Ru", 120, 420, 52, 17)
GUICtrlSetColor(-1, $COLOR_WHITE)
GUISetState(@SW_SHOW)
#EndRegion

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button1
			GUISetState(@SW_HIDE)
			if BitAND(GuiCtrlRead($Checkbox1), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("7zip")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox2), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("aimp")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox3), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("audacity")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox4), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("chrome")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox5), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("firefox")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox6), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("foobar2000")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox7), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("handbrake")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox8), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("klite")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox9), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("notepad")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox10), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("sharex")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox11), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("sumatrapdf")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox12), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("teamviewer")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox13), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("vlc")
				Sleep(1000)
				tNinite()
			EndIf
			if BitAND(GuiCtrlRead($Checkbox14), $GUI_CHECKED) = $GUI_CHECKED Then
				Install("winrar")
				Sleep(1000)
				tNinite()
			EndIf
			GUISetState(@SW_SHOW)

	EndSwitch
WEnd

Func Install($nBin)
	tNinite()
	Local $texto
	Local $iPID = Run(@ScriptDir & "\bin\" & $nBin & ".exe")
	While 1
		WinSetTrans("Preparing", "", 0)
		WinSetTrans("Ninite", "", 0)
		$texto = WinGetText("Ninite", "")
		If StringInStr($texto, "Finished.", 1) Then
			ExitLoop
		EndIf
		Sleep(700)
	WEnd
	Sleep(1500)
	if ProcessExists($iPID) Then
		ProcessClose($iPID)
	EndIf
	tNinite()
EndFunc

Func tNinite()
	if ProcessExists("Ninite.exe") Then
		ProcessClose("Ninite.exe")
	EndIf
EndFunc