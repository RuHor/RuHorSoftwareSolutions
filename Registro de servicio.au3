#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Información de soporte previo
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductName=Registro de servicio
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Ru Software Solutions
#AutoIt3Wrapper_Res_LegalCopyright=Technical Tools
#AutoIt3Wrapper_Res_LegalTradeMarks=Technical Tools
#AutoIt3Wrapper_Res_Language=12298
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         RuHorRu

 Script Function:
	Software para registrar un mantenimiento previo de un registro de servicio.
	El código se ha modificado y simplificado el código que se mostró en el tutorial en el video de youtube.

#ce ----------------------------------------------------------------------------
#include <GUIConstantsEx.au3>
#include <Date.au3>
#Region
Global $aSoporte = "C:\Support\Support.data"
Global $Titulo = "Registro de servicio 1.0"
Global $sFileRead
Global $sPlantilla = "Código: " & @CRLF & @CRLF & "Fecha de soporte: " & @CRLF & @CRLF & _
					"Equipo: " & @CRLF & @CRLF & "Modelo: " & @CRLF & @CRLF & "Problema: " & @CRLF & @CRLF & _
					"Solución: " & @CRLF & @CRLF & "Costo: " & @CRLF & @CRLF & "Observación: "
Global $nRepairMan = IniRead(@ScriptDir & "\conf.ini", "Configuracion","Nombre","") & ", " & IniRead(@ScriptDir & "\conf.ini", "Configuracion","Tecnico","")
If FileExists($aSoporte) then
	$fAbierto = FileOpen($aSoporte)
	$sFileRead = FileRead($fAbierto)
Else
	$sFileRead = $sPlantilla
	MsgBox(64,$Titulo, "No se encuentra el log del mantenimiento previo, quizá sea un equipo que se le brinda por primera vez nuestro servicio de mantenimiento.")
EndIf
GUICreate($Titulo, 611, 390)
GUICtrlCreateLabel($nRepairMan, 8, 10, 600, 17)
$tMantemimienot = GUICtrlCreateEdit("", 8, 35, 593, 313)
GUICtrlSetData(-1,$sFileRead)
$Eliminar = GUICtrlCreateButton("Eliminar", 448, 356, 75, 25)
$Guardar = GUICtrlCreateButton("Guardar", 527, 356, 75, 25)
GUICtrlCreateLabel("Diseñado por RuHor Ru", 8, 363, 130, 17)
GUISetState(@SW_SHOW)
#EndRegion

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Eliminar
			if FileExists("C:\Support") then
				FileSetAttrib($aSoporte,"-R")
				FileSetAttrib("C:\Support","-RSH")
				DirRemove("C:\Support",1)
				MsgBox(64,$Titulo, "Log eliminado del sistema con éxito.")
				GUICtrlSetData($tMantemimienot, $sPlantilla)
			Else
				GUICtrlSetData($tMantemimienot, $sPlantilla)
				MsgBox(64,$Titulo, "Lo sentimos no se encuentra el log en el sistema.")
			EndIf

		Case $Guardar
			if not FileExists("C:\Support") then
				FileSetAttrib($aSoporte,"-R")
				DirCreate("C:\Support")
			EndIf
			$nDescripcion = GUICtrlRead($tMantemimienot)
			If $nDescripcion <> $sPlantilla Then
				FileSetAttrib($aSoporte,"-R")
				FileDelete($aSoporte)
				$fAbierto = FileOpen($aSoporte, 128 + 1)
				$sFileRead = FileRead($fAbierto)
				FileWrite($fAbierto, $nDescripcion & @CR)
				FileClose($fAbierto)
				FileSetAttrib($aSoporte,"+R")
				FileSetAttrib("C:\Support","+RSH")
				$bLog = MsgBox(4,$Titulo, "La información se ha guardado con éxito, desea guardar una copia del log?")
				if $bLog == 6 Then
					Local $sMensaje = "Seleccione donde guardar el backup"
					Local $dDestino = FileSaveDialog($sMensaje, "::{450D8FBA-AD25-11D0-98A8-0800361B1103}", "(*.txt)", $FD_PATHMUSTEXIST)
					If not @error Then
						FileCopy($aSoporte, $dDestino,1)
						FileSetAttrib($dDestino, "-R")
					EndIf
				EndIf
			Else
				FileSetAttrib("C:\Support","-RSH")
				FileSetAttrib($aSoporte,"-R")
				DirRemove("C:\Support",1)
			EndIf
	EndSwitch
WEnd
