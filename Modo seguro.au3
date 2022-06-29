#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Modo seguro item
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductName=Modo seguro
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Ru Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
GUICreate("Safe Mode", 243, 146)
GUICtrlCreateGroup("Modo seguro", 8, 8, 225, 113)
$btnAgregar = GUICtrlCreateButton("Agregar", 32, 80, 75, 25)
$btnEliminar = GUICtrlCreateButton("Eliminar", 135, 80, 75, 25)
GUICtrlCreateLabel("Agrega en el menú contextual del escritorio" & @CRLF & "opciones de reinicio avanzado", 15, 32, 210, 34)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("RuHor Ru", 180, 128, 52, 17)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $btnAgregar
			$KeyReg = RegEnumKey("HKCR\DesktopBackground\Shell\SafeMode", 1)
			if $KeyReg <> "shell" Then
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode', 'icon','REG_SZ','bootux.dll,-1032')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode', 'MUIVerb','REG_SZ','Modo Seguro')
				RegDelete('HKCR\DesktopBackground\Shell\SafeMode','Position')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode', 'SubCommands','REG_SZ','')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\001-NormalMode', '','REG_SZ','Reiniciar en modo normal')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\001-NormalMode', 'HasLUAShield','REG_SZ','')
				$RegData = 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/s,/c,bcdedit /deletevalue'
				$RegData &= ' {current} safeboot & bcdedit /deletevalue {current} safebootalternateshell & shutdown -r -t 00 -f'' '
				$RegData &= '-Verb runAs"'
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\001-NormalMode\command', '','REG_SZ', $RegData)
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\002-SafeMode', '','REG_SZ','Reiniciar modo seguro')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\002-SafeMode', 'HasLUAShield','REG_SZ','')
				$RegData = 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/s,/c,bcdedit /set {curren'
				$RegData &= 't} safeboot minimal & bcdedit /deletevalue {current} safebootalternateshell & shutdown -r -t 00 -f'' '
				$RegData &= '-Verb runAs"'
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\002-SafeMode\command', '','REG_SZ', $RegData)
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\003-SafeModeNetworking', '','REG_SZ','Reiniciar modo seguro con red')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\003-SafeModeNetworking', 'HasLUAShield','REG_SZ','')
				$RegData = 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/s,/c,bcdedit /set {curren'
				$RegData &= 't} safeboot network & bcdedit /deletevalue {current} safebootalternateshell & shutdown -r -t 00 -f'' '
				$RegData &= '-Verb runAs"'
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\003-SafeModeNetworking\command', '','REG_SZ', $RegData)
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\004-SafeModeCommandPrompt', '','REG_SZ','Reiniciar modo seguro con cmd')
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\004-SafeModeCommandPrompt', 'HasLUAShield','REG_SZ','')
				$RegData = 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/s,/c,bcdedit /set {curren'
				$RegData &= 't} safeboot minimal & bcdedit /set {current} safebootalternateshell yes & shutdown -r -t 00 -f'' -Ver'
				$RegData &= 'b runAs"'
				RegWrite('HKCR\DesktopBackground\Shell\SafeMode\shell\004-SafeModeCommandPrompt\command', '','REG_SZ', $RegData)
				$KeyReg = RegEnumKey("HKCR\DesktopBackground\Shell\SafeMode", 1)
				if $KeyReg <> "shell" Then
					MsgBox(48, "Safe Mode", "Ha ocurrido un error por favor intente en otro momento.")
				Else
					MsgBox(64, "Safe Mode", "El ítem de modo seguro se ha agregado con éxito.")
				EndIf
			Else
				MsgBox(64, "Safe Mode", "El ítem modo seguro ya está agregado en el menú contextual del escritorio.")
			EndIf

		Case $btnEliminar
			$KeyReg = RegEnumKey("HKCR\DesktopBackground\Shell\SafeMode", 1)
			if $KeyReg == "shell" Then
				RegDelete("HKCR\DesktopBackground\Shell\SafeMode")
				$KeyReg = RegEnumKey("HKCR\DesktopBackground\Shell\SafeMode", 1)
				if $KeyReg == "" Then
					MsgBox(64, "Safe Mode", "El ítem de modo seguro se ha eliminado del menú contextual del escritorio.")
				Else
					MsgBox(48, "Safe Mode", "Ha ocurrido un error por favor intente en otro momento.")
				EndIf
			Else
				MsgBox(64, "Safe Mode", "El ítem modo seguro no se encuentra dentro del menú contextual del escritorio.")
			EndIf

	EndSwitch
WEnd