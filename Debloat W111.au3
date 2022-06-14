#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Desinstalador de apps
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=RuHorRu Software Solutions
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         RuHor Ru

 Script Function:
	Aplicación para poder desinstalar las apps por defecto que vienen instalados en Windows 10 y 11

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
#include <Array.au3>
Global $msg, $apps[0], $appsID[0]
Global $titulo = "Debloat Apps Windows 111"
GUICreate($titulo,  550, 360)
$LV1 = GUICtrlCreateListView("Apps|ID", 10, 10, 440,315)
$Desmarcar = GUICtrlCreateButton("Desmarcar", 465, 10, 75, 27)
$Desinstalar = GUICtrlCreateButton("Desinstalar", 465, 300, 75, 27)
GUICtrlCreateLabel("RuHor Ru", 10, 335, 75, 27)
_GUICtrlListView_SetExtendedListViewStyle($LV1, BitOr($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES, $LVS_EX_GRIDLINES))
GUICtrlSendMsg($LV1, $LVM_SETCOLUMNWIDTH, 0, 185)
GUICtrlSendMsg($LV1, $LVM_SETCOLUMNWIDTH, 1, 210)
AgregaSoftware()
GUISetState(@SW_SHOW)
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Desmarcar
			UnCheck()

		Case $Desinstalar
			Local $totalApps = 0
			Local $code
			For $k=0 to UBound($apps)
				if _GUICtrlListView_GetItemChecked($LV1, $k) Then
					$totalApps += 1
				EndIf
			Next
			if $totalApps > 0 then
				Local $confirma = MsgBox(4, $titulo, "Usted ha seleccionado " & $totalApps & " app(s), está seguro que desea desinstalar?")
				if $confirma = 6 Then
					GUISetState(@SW_HIDE)
					For $x = 0 to UBound($apps)
						if _GUICtrlListView_GetItemChecked($LV1, $x) Then
							$code = _GUICtrlListView_GetItemText($LV1, $x, 1)
							RunWait("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " & "Get-AppxPackage *" & $code & "* | Remove-AppxPackage", "", @SW_SHOW)
						EndIf
					Next
					UnCheck()
					MsgBox(64,$titulo, "Ha finalizado el proceso de desinstalación de las aplicaciones seleccionadas.")
					GUISetState(@SW_SHOW)
				EndIf
			Else
				MsgBox(64,$titulo, "Antes de continuar, por favor seleccione una aplicación dentro de la lista.")
			EndIf

	EndSwitch
WEnd

Func AgregaSoftware()
	_ArrayAdd($apps, "3D Builder")
	_ArrayAdd($apps, "3D Viewer")
	_ArrayAdd($apps, "Adobe Photoshop Express ")
	_ArrayAdd($apps, "Alarms & Clock")
	_ArrayAdd($apps, "App Connector")
	_ArrayAdd($apps, "Asphalt 8:Airborne")
	_ArrayAdd($apps, "Calculator")
	_ArrayAdd($apps, "Calendar and Mail")
	_ArrayAdd($apps, "Camera")
	_ArrayAdd($apps, "Candy Crush Soda Saga")
	_ArrayAdd($apps, "Cortana")
	_ArrayAdd($apps, "Disney")
	_ArrayAdd($apps, "Drawboard PDF")
	_ArrayAdd($apps, "Facebook")
	_ArrayAdd($apps, "Feedback Hub")
	_ArrayAdd($apps, "Game bar")
	_ArrayAdd($apps, "Get Help")
	_ArrayAdd($apps, "Get Started")
	_ArrayAdd($apps, "Groove Music")
	_ArrayAdd($apps, "Maps")
	_ArrayAdd($apps, "Messaging")
	_ArrayAdd($apps, "Microsoft Edge Stable")
	_ArrayAdd($apps, "Microsoft News")
	_ArrayAdd($apps, "Microsoft Solitaire Collection")
	_ArrayAdd($apps, "Microsoft Store")
	_ArrayAdd($apps, "Microsoft To-Do")
	_ArrayAdd($apps, "Microsoft Whiteboard")
	_ArrayAdd($apps, "Microsoft Wi-Fi")
	_ArrayAdd($apps, "MinecraftUWP")
	_ArrayAdd($apps, "Mixed Reality Portal")
	_ArrayAdd($apps, "Mobile Plans")
	_ArrayAdd($apps, "Movies & TV")
	_ArrayAdd($apps, "Netflix")
	_ArrayAdd($apps, "Notepad")
	_ArrayAdd($apps, "Office")
	_ArrayAdd($apps, "OneNote")
	_ArrayAdd($apps, "Paint 3D")
	_ArrayAdd($apps, "Pandora")
	_ArrayAdd($apps, "People")
	_ArrayAdd($apps, "Phone")
	_ArrayAdd($apps, "Phone Companion")
	_ArrayAdd($apps, "Photos")
	_ArrayAdd($apps, "Print 3D")
	_ArrayAdd($apps, "Remote Desktop")
	_ArrayAdd($apps, "Scan")
	_ArrayAdd($apps, "Sketch Book")
	_ArrayAdd($apps, "Skype")
	_ArrayAdd($apps, "Snip & Sketch")
	_ArrayAdd($apps, "Sports")
	_ArrayAdd($apps, "Sticky Notes")
	_ArrayAdd($apps, "Sway")
	_ArrayAdd($apps, "Tik Tok")
	_ArrayAdd($apps, "Tips")
	_ArrayAdd($apps, "Twitter")
	_ArrayAdd($apps, "View 3D Preview")
	_ArrayAdd($apps, "Voice Recorder")
	_ArrayAdd($apps, "Weather")
	_ArrayAdd($apps, "Xbox Console Companion")
	_ArrayAdd($apps, "Xbox One SmartGlass")
	_ArrayAdd($apps, "Xbox Game Bar")
	_ArrayAdd($apps, "Xbox Game Speech Window")
	_ArrayAdd($apps, "Your Phone")
	For $i = 0 to UBound($apps) -1
		GUICtrlCreateListViewItem($apps[$i], $LV1)
	Next
	_ArrayAdd($appsID, "Microsoft.3dbuilder")
	_ArrayAdd($appsID, "Microsoft3DViewer")
	_ArrayAdd($appsID, "AdobeSystemsIncorporated.AdobePhotoshopExpress")
	_ArrayAdd($appsID, "Microsoft.WindowsAlarms")
	_ArrayAdd($appsID, "Microsoft.Appconnector")
	_ArrayAdd($appsID, "Microsoft.Asphalt8Airborne")
	_ArrayAdd($appsID, "Microsoft.WindowsCalculator")
	_ArrayAdd($appsID, "Microsoft.WindowsCommunicationsapps")
	_ArrayAdd($appsID, "Microsoft.WindowsCamera")
	_ArrayAdd($appsID, "King.com.CandyCrushSodaSaga")
	_ArrayAdd($appsID, "Microsoft.549981C3F5F10")
	_ArrayAdd($appsID, "Disney.37853FC22B2CE")
	_ArrayAdd($appsID, "Microsoft.DrawboardPDF")
	_ArrayAdd($appsID, "Facebook")
	_ArrayAdd($appsID, "Microsoft.WindowsFeedbackHub")
	_ArrayAdd($appsID, "Microsoft.XboxGamingOverlay")
	_ArrayAdd($appsID, "Microsoft.GetHelp")
	_ArrayAdd($appsID, "Microsoft.Getstarted")
	_ArrayAdd($appsID, "Microsoft.ZuneMusic")
	_ArrayAdd($appsID, "Microsoft.WindowsMaps")
	_ArrayAdd($appsID, "Microsoft.Messaging")
	_ArrayAdd($appsID, "Microsoft.MicrosoftEdge")
	_ArrayAdd($appsID, "Microsoft.BingNews")
	_ArrayAdd($appsID, "Microsoft.MicrosoftSolitaireCollection")
	_ArrayAdd($appsID, "Microsoft.WindowsStore")
	_ArrayAdd($appsID, "Todos")
	_ArrayAdd($appsID, "Microsoft.Whiteboard")
	_ArrayAdd($appsID, "ConnectivityStore")
	_ArrayAdd($appsID, "MinecraftUWP")
	_ArrayAdd($appsID, "Microsoft.MixedReality.Portal")
	_ArrayAdd($appsID, "Microsoft.OneConnect")
	_ArrayAdd($appsID, "Microsoft.ZuneVideo")
	_ArrayAdd($appsID, "Netflix")
	_ArrayAdd($appsID, "Microsoft.WindowsNotepad")
	_ArrayAdd($appsID, "Microsoft.MicrosoftOfficeHub")
	_ArrayAdd($appsID, "OneNote")
	_ArrayAdd($appsID, "Microsoft.MSPaint")
	_ArrayAdd($appsID, "PandoraMediaInc")
	_ArrayAdd($appsID, "Microsoft.People")
	_ArrayAdd($appsID, "CommsPhone")
	_ArrayAdd($appsID, "windowsphone")
	_ArrayAdd($appsID, "Microsoft.Windows.Photos")
	_ArrayAdd($appsID, "Microsoft.Print3D")
	_ArrayAdd($appsID, "Microsoft.RemoteDesktop")
	_ArrayAdd($appsID, "WindowsScan")
	_ArrayAdd($appsID, "AutodeskSketchBook")
	_ArrayAdd($appsID, "Microsoft.SkypeApp")
	_ArrayAdd($appsID, "Microsoft.ScreenSketch")
	_ArrayAdd($appsID, "bingsports")
	_ArrayAdd($appsID, "Microsoft.MicrosoftStickyNotes")
	_ArrayAdd($appsID, "Office.Sway")
	_ArrayAdd($appsID, "BytedancePte.Ltd.TikTok")
	_ArrayAdd($appsID, "Microsoft.Getstarted")
	_ArrayAdd($appsID, "Twitter")
	_ArrayAdd($appsID, "Microsoft3DViewer")
	_ArrayAdd($appsID, "Microsoft.WindowsSoundRecorder")
	_ArrayAdd($appsID, "Microsoft.BingWeather")
	_ArrayAdd($appsID, "Microsoft.XboxApp")
	_ArrayAdd($appsID, "XboxOneSmartGlass")
	_ArrayAdd($appsID, "Microsoft.XboxGamingOverlay")
	_ArrayAdd($appsID, "Microsoft.XboxSpeechToTextOverlay")
	_ArrayAdd($appsID, "Microsoft.YourPhone")
	For $b = 0 to UBound($appsID) -1
		_GUICtrlListView_AddSubItem($LV1, $b, $appsID[$b], 1)
	Next
EndFunc

Func UnCheck()
	For $p = 0 to UBound($apps)
		_GUICtrlListView_SetItemChecked($LV1, $p, false)
	Next
EndFunc