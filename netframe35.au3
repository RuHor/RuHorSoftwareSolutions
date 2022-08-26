#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Setup Net35 Off/On
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         RuHor Ru

 Script Function:
	Instalar Net Framework 3.5 online y offline.

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <AutoitConstants.au3>
#include <MsgBoxConstants.au3>
#include <GuiComboBox.au3>
#include <ColorConstants.au3>

Global $rutaNet35, $titulo
$titulo = "Install GUI Net 3.5"
GUICreate($titulo, 413,125)
$Group1 = GUICtrlCreateGroup(" Offline ", 8, 8, 257, 89)
$Label1 = GUICtrlCreateLabel("Ruta: ", 16, 32, 30, 17)
$sUnidades = GUICtrlCreateCombo("", 64, 30, 97, 25,BitOr($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
$Update = GUICtrlCreateButton("Actualizar", 168,28,85,25)
$installOff = GUICtrlCreateButton("Instalar", 168,60,85,25)
$Label2 = GUICtrlCreateLabel("Estado:", 16,64,40,17)
$Label3 = GUICtrlCreateLabel("", 64,64,71,30)
GUICtrlCreateGroup("", -99,-99,1,1)
$Group2 = GUICtrlCreateGroup(" Online ", 272,8,129,89)
$installOn = GUICtrlCreateButton("Instalar", 288, 28, 99, 57)
GUICtrlCreateGroup("", -99,-99,1,1)
$Label4 = GUICtrlCreateLabel("Desarrollado por RuHor Ru", 15, 104 , 241, 17)
Unidades()

GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Update
			_GUICtrlComboBox_ResetContent($sUnidades)
			GUICtrlSetData($Label3, "")
			Unidades()

		Case $sUnidades
			local $uSeleccionada = GUICtrlRead($sUnidades)
			$rutaNet35 = $uSeleccionada & "sources\sxs"
			if FileExists($rutaNet35) then
				GuiCtrlSetData($Label3, "Encontrado ;)")
				GuiCtrlSetColor($Label3, $COLOR_GREEN)
			Else
				GuiCtrlSetData($Label3, "No encontrado T.T")
				GuiCtrlSetColor($Label3, $COLOR_RED)
			EndIf

		Case $installOff
			local $encontrado = GUICtrlRead($Label3)
			if FileExists($rutaNet35) and $encontrado == "Encontrado ;)" Then
				GUISetState(@SW_HIDE)
				Local $codeOff = "Dism /online /enable-feature /featurename:NetFX3 /All /source:" & $rutaNet35 & " /LimitAccess"
				RunWait(@ComSpec & " /K " & $codeOff, "", @SW_SHOW)
				MsgBox(64,$titulo, "Tarea completa.")
				GUICtrlSetData($Label3, "Instalado ;)")
				GUISetState(@SW_SHOW)
			Else
				MsgBox(64,$titulo, "No se encuentra los archivos de instalación, intente en otro momento")
				GuiCtrlSetData($Label3, "No encontrado T.T")
				GuiCtrlSetColor($Label3, $COLOR_RED)
			EndIf

		Case $installOn
			Local $codeOn = "Dism /online /enable-feature /featurename:NetFX3"
			RunWait(@ComSpec & " /K " & $codeOn, "", @SW_SHOW)
			MsgBox(64,$titulo, "Tarea completa.")

	EndSwitch
WEnd

Func Unidades()
	_GUICtrlComboBox_AddDir($sUnidades,"", $DDL_DRIVES, False)
EndFunc
