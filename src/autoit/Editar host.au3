#cs ----------------------------------------------------------------------------

 Author:         RuHor Ru

 Script Function:
	Script para editar el archivo host con nuevo contenido.

#ce ----------------------------------------------------------------------------


#RequireAdmin
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Local $hostsFile = @WindowsDir & "\System32\drivers\etc\hosts"
Local $hGUI = GUICreate("Hosts Editor v0.1 by RuHor Ru", 560, 340)
Local $hMemo = GUICtrlCreateEdit("", 10, 10, 540, 280)
GUICtrlSetFont($hMemo, 9, 400, 0, "Calibri")
Local $fileContent = FileRead($hostsFile)
GUICtrlSetData($hMemo, $fileContent)
Local $hButton = GUICtrlCreateButton("Guardar", 450, 300, 100, 30)
GUISetState(@SW_SHOW, $hGUI)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $hButton
            Local $nuevoContenido = GUICtrlRead($hMemo)
            Local $archivoHost = FileOpen($hostsFile, $FO_OVERWRITE)
            If $archivoHost = -1 Then
                MsgBox($MB_OK + $MB_ICONERROR, "Error", "No se pudo abrir el archivo hosts.")
                ExitLoop
            EndIf
            FileWrite($archivoHost, $nuevoContenido)
            FileClose($archivoHost)
            MsgBox($MB_OK, "Hosts Editor v0.1", "El archivo hosts ha sido actualizado.")
    EndSwitch
WEnd

GUIDelete($hGUI)
