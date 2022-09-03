#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=NetworkPC
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         RuHor Ru

 Script Function:
	Software para listar recursos en red

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <Array.au3>
Global $msg, $aArray
Global $titulo = "Recursos en red local"
GUICreate($titulo, 750, 360)
$ListView1 = GUICtrlCreateListView("Propietario|Recurso", 10, 10, 640, 315)
$Explorar = GUICtrlCreateButton("Explorar", 665, 10, 75, 27)
$Refrescar = GUICtrlCreateButton("Refrescar", 665, 40, 75, 27)
$Editar = GUICtrlCreateButton("Abrir config", 665, 70, 75, 27)
GUICtrlCreateLabel("Desarrollado por RuHor Ru", 10, 335, 155, 27)
_GUICtrlListView_SetExtendedListViewStyle($ListView1, BitOr($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES))
GUICtrlSendMsg($ListView1, $LVM_SETCOLUMNWIDTH, 0, 170)
GUICtrlSendMsg($ListView1, $LVM_SETCOLUMNWIDTH, 1, 460)
LeerEquipos()
GUISetState(@SW_SHOW)
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Explorar
			Local $sIndex = _GUICtrlListView_GetSelectedIndices($ListView1)
			Local $rec = _GUICtrlListView_GetItemText($ListView1, Number($sIndex), 1)
			ShellExecute($rec)

		Case $Refrescar
			_GUICtrlListView_DeleteAllItems($ListView1)
			LeerEquipos()

		Case $Editar
			ShellExecute(@ScriptDir & "\equipos.ini")

	EndSwitch
WEnd

Func LeerEquipos()
	Local $equipo, $propietario, $recurso
	Local $sFilePath = @ScriptDir & "\equipos.ini"
	$aArray = IniReadSectionNames($sFilePath)
	If Not @error Then
		For $i=0 to UBound($aArray) -1
			$equipo = Unicode(IniRead($sFilePath, $aArray[$i], "equipo", ""))
			$propietario = Unicode(IniRead($sFilePath, $aArray[$i], "propietario", ""))
			$recurso = Unicode(IniRead($sFilePath, $aArray[$i], "recurso", ""))
			GUICtrlCreateListViewItem($propietario, $ListView1)
			_GUICtrlListView_AddSubItem($ListView1, $i, "\\" & $equipo & "\" & $recurso, 1)
		Next
		_GUICtrlListView_DeleteItem($ListView1, 0)
	EndIf
EndFunc

Func Unicode($sString = "")
	Local Const $SF_ANSI = 1
	Local Const $SF_UTF8 = 4
	Return BinaryToString(StringToBinary($sString, $SF_ANSI), $SF_UTF8)
EndFunc

