#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Ajuste de servicios
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Ru Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 Version: 1.0
 Author:         RuHor Ru

 Script Function:
	Ajustar los servicios de windows en modo manual o deshabilitado

#ce ----------------------------------------------------------------------------

#include <Array.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region
Global $estado, $modo
Global $titulo = "OptSer 1.0"
$Form1_1 = GUICreate($titulo, 250, 229)
$Group1 = GUICtrlCreateGroup("Servicios", 8, 8, 233, 193)
$Radio1 = GUICtrlCreateRadio("Deshabilitar", 32, 32, 81, 17)
$Radio2 = GUICtrlCreateRadio("Manual", 152, 32, 57, 17)
$Checkbox1 = GUICtrlCreateCheckbox("Seguro", 96, 88, 57, 17)
$Label1 = GUICtrlCreateLabel("---------- Modo ----------", 77, 64, 97, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Óptimo", 96, 112, 57, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Extremo", 96, 136, 65, 17)
$Button1 = GUICtrlCreateButton("Aplicar", 88, 168, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label2 = GUICtrlCreateLabel("RuHorRu", 8, 208, 49, 17)
GUISetState(@SW_SHOW)
#EndRegion

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Checkbox1
			$modo = "seguro"
			if IsChecked($Checkbox2) Then
				GUICtrlSetState($Checkbox2, $GUI_UNCHECKED)
			EndIf
			if IsChecked($Checkbox3) Then
				GUICtrlSetState($Checkbox3, $GUI_UNCHECKED)
			EndIf

		Case $Checkbox2
			$modo = "óptimo"
			if IsChecked($Checkbox1) Then
				GUICtrlSetState($Checkbox1, $GUI_UNCHECKED)
			EndIf
			if IsChecked($Checkbox3) Then
				GUICtrlSetState($Checkbox3, $GUI_UNCHECKED)
			EndIf

		Case $Checkbox3
			$modo = "extremo"
			if IsChecked($Checkbox1) Then
				GUICtrlSetState($Checkbox1, $GUI_UNCHECKED)
			EndIf
			if IsChecked($Checkbox2) Then
				GUICtrlSetState($Checkbox2, $GUI_UNCHECKED)
			EndIf

		Case $Button1
			if IsChecked($Radio1) Then
				$estado = "deshabilitar"
			EndIf
			if IsChecked($Radio2) Then
				$estado = "manual"
			EndIf
			if $estado <> "" Then
				if IsChecked($Checkbox1) Then
					Local $confirma = MsgBox(4, $titulo, "Está seguro que desea aplicar el estado " & $estado & " a los servicios del modo " & $modo & "?")
					if $confirma = 6 Then
						Seguro($estado)
					EndIf
				EndIf
				if IsChecked($Checkbox2) Then
					Local $confirma = MsgBox(4, $titulo, "Está seguro que desea aplicar el estado " & $estado & " a los servicios del modo " & $modo & "?")
					if $confirma = 6 Then
		;~ 						funcion aplique los servicios
							MsgBox(64,"","SI 2")
					EndIf
				EndIf
				if IsChecked($Checkbox3) Then
					Local $confirma = MsgBox(4, $titulo, "Está seguro que desea aplicar el estado " & $estado & " a los servicios del modo " & $modo & "?")
					if $confirma = 6 Then
;~ 						funcion aplique los servicios
					MsgBox(64,"","SI 3")
					EndIf
				EndIf
			EndIf

	EndSwitch
WEnd

Func IsChecked($control)
	Return BitAnd(GUICtrlRead($control), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

Func Seguro($tipo)
	Local $inicio, $comando, $comandoSet
	Local $servicios[1] = ["WSearch"]
	_ArrayAdd($servicios, "WMPNetworkSvc")
	_ArrayAdd($servicios, "SNMPTRAP")
	_ArrayAdd($servicios, "SCPolicySvc")
	_ArrayAdd($servicios, "SCardSvr")
	_ArrayAdd($servicios, "RemoteRegistry")
	_ArrayAdd($servicios, "RpcLocator")
	_ArrayAdd($servicios, "WPCSvc")
	_ArrayAdd($servicios, "CscService")
	_ArrayAdd($servicios, "napagent")
	_ArrayAdd($servicios, "Netlogon")
	_ArrayAdd($servicios, "iphlpsvc")
	_ArrayAdd($servicios, "TrkWks")
	_ArrayAdd($servicios, "CertPropSvc")
	_ArrayAdd($servicios, "PeerDistSvc")
	_ArrayAdd($servicios, "bthserv")
	_ArrayAdd($servicios, "SensrSvc")
	_ArrayAdd($servicios, "WinHttpAutoProxySvc")
	_ArrayAdd($servicios, "WinRM")
	_ArrayAdd($servicios, "WerSvc")
	_ArrayAdd($servicios, "WcsPlugInService")
	_ArrayAdd($servicios, "ALG")
	_ArrayAdd($servicios, "BDESVC")
	_ArrayAdd($servicios, "EFS")
	_ArrayAdd($servicios, "Fax")
	_ArrayAdd($servicios, "hidserv")
	_ArrayAdd($servicios, "SessionEnv")
	_ArrayAdd($servicios, "TermService")
	_ArrayAdd($servicios, "TabletInputService")
	_ArrayAdd($servicios, "WbioSrvc")
	_ArrayAdd($servicios, "UmRdpService")
	_ArrayAdd($servicios, "DiagTrack")
	_ArrayAdd($servicios, "SysMain")
	_ArrayAdd($servicios, "MapsBroker")
	_ArrayAdd($servicios, "MapsBrokerDoSvc")
	if $tipo == "deshabilitar" Then
		$inicio = "disabled"
	Else
		$inicio = "demand"
	EndIf
	For $i = 0 to UBound($servicios) -1
		$comando = 'sc stop "' & $servicios[$i] & '"'
		$comandoSet = 'sc config "' & $servicios[$i] & '" start=' & $inicio
		RunWait(@ComSpec & " /c " & $comando, "", @SW_HIDE)
		RunWait(@ComSpec & " /c " & $comandoSet, "", @SW_HIDE)
	Next
	MsgBox(64, $titulo, "Se ha configurado " & UBound($servicios) & " servicio(s)")
EndFunc
