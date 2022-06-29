#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=theme.ico
#AutoIt3Wrapper_Res_Comment=Developor RuHor Ru
#AutoIt3Wrapper_Res_Description=Colores
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductName=1.0
#AutoIt3Wrapper_Res_ProductVersion=Colores
#AutoIt3Wrapper_Res_CompanyName=RurHor Ru Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
GUICreate("Colores 1.0", 251, 165)
GUICtrlCreateLabel("Aplicación para cambiar el color de Windows", 16, 24, 220, 17)
$btnApp = GUICtrlCreateButton("App", 80, 64, 75, 25)
$btnSys = GUICtrlCreateButton("Sys", 80, 104, 75, 25)
GUICtrlCreateLabel("RuHor Ru", 192, 144, 52, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $btnApp
			Local $rApp, $vApp
			$rApp = RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme")
			$rApp = NUMBER($rApp)
			$vApp = 1 - $rApp
			if $vApp <> 1 Then
				RegWrite("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme", "REG_DWORD", 0)
				MsgBox(64,"Colores", "Se ha cambiado a tema dark")
			Else
				RegWrite("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme", "REG_DWORD", 1)

				MsgBox(64,"Colores", "Se ha cambiado a tema light")
			EndIf

		Case $btnSys
			Local $rSys, $vSys
			$rSys = RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize", "SystemUsesLightTheme")
			$rSys = NUMBER($rSys)
			$vSys = 1 - $rSys
			if $vSys <> 1 Then
				RegWrite("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize", "SystemUsesLightTheme", "REG_DWORD", 0)
				MsgBox(64,"Colores", "Se ha cambiado a tema dark")
			Else
				RegWrite("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize", "SystemUsesLightTheme", "REG_DWORD", 1)

				MsgBox(64,"Colores", "Se ha cambiado a tema light")
			EndIf

	EndSwitch
WEnd
