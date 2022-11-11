#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Agregar el taskmanager en el taskbar
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHor Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         RuHor Ru

 Script Function:
	Agregar el administrador de tareas en la barra de tarea

#ce ----------------------------------------------------------------------------
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("TaskMan in TaskBar", 286, 144)
$Group1 = GUICtrlCreateGroup(" Configuración ", 24, 16, 249, 97)
$Button1 = GUICtrlCreateButton("Activar", 104, 40, 75, 25)
$Button2 = GUICtrlCreateButton("Desactivar", 104, 72, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label1 = GUICtrlCreateLabel("RuHor Ru", 224, 120, 52, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button1
			RegWrite('HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\4\1887869580', 'EnabledState','REG_DWORD',Number('2'))
			RegWrite('HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\4\1887869580', 'EnabledStateOptions','REG_DWORD',Number('0'))
			MsgBox(64,"TaskMan in TaskBar","Reinicie el computador para aplicar los cambios")

		Case $Button2
			RegDelete('HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\4\1887869580', 'EnabledState')
			RegDelete('HKLM\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\4\1887869580', 'EnabledStateOptions')
			MsgBox(64,"TaskMan in TaskBar","Reinicie el computador para aplicar los cambios")

	EndSwitch
WEnd


