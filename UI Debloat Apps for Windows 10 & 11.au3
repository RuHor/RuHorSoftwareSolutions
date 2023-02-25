#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icono.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Developer RuHor Ru
#AutoIt3Wrapper_Res_Description=Desinstalador de apps
#AutoIt3Wrapper_Res_Fileversion=2.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=2.0
#AutoIt3Wrapper_Res_CompanyName=RuHorRu Software Solutions
#AutoIt3Wrapper_Res_Language=12298
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------
 AutoIt Version: 2.0
 Author:         RuHor Ru
 Script Function:
	Aplicación para poder instalar/desinstalar las apps (bloatware) por defecto que vienen instalados en Windows 10 y 11
#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
#include <Array.au3>
Global $msg, $apps[0], $appsID[0]
Global $Radio1Executed = False
Global $Radio2Executed = False
Global $titulo = "UI Debloat Apps for Windows 10 & 11"
GUICreate($titulo,  570, 360)
$LV1 = GUICtrlCreateListView("Apps|ID", 10, 10, 445,315)
GUICtrlCreateLabel("Usted quiere:", 465,10,75,27)
$SDesinstalar = GUICtrlCreateRadio("Desinstalar", 465, 25, 75, 27)
$SInstalar = GUICtrlCreateRadio("Instalar", 465, 45, 75, 27)
$LTSC = GUICtrlCreateButton("Tipo LTSC", 465, 150, 95, 35)
GUICtrlSetState($LTSC, $GUI_DISABLE)
$Aplicar = GUICtrlCreateButton("Aplicar", 465, 190, 95, 35)
GUICtrlSetImage(-1, @SystemDir & "\shell32.dll", 16810)
$Desmarcar = GUICtrlCreateButton("Desmarcar", 465, 230, 95, 35)
GUICtrlSetImage(-1, @SystemDir & "\shell32.dll", 240)
GUICtrlCreateLabel("Desarrollado por RuHor Ru", 10, 335, 145, 27)
GUICtrlCreateLabel("Comunidades: ", 340, 335, 69, 27)
$facebook = GUICtrlCreateLabel("Facebook", 413, 335, 50, 20)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor(-1, 0)
$telegram = GUICtrlCreateLabel("Telegram", 465, 335, 50, 20)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor(-1, 0)
$youtube = GUICtrlCreateLabel("Youtube", 515, 335, 50, 20)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor(-1, 0)

_GUICtrlListView_SetExtendedListViewStyle($LV1, BitOr($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES, $LVS_EX_GRIDLINES))
GUICtrlSendMsg($LV1, $LVM_SETCOLUMNWIDTH, 0, 185)
GUICtrlSendMsg($LV1, $LVM_SETCOLUMNWIDTH, 1, 210)
GUISetState(@SW_SHOW)
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $SDesinstalar
			GUICtrlSetState($LTSC, $GUI_ENABLE)
			If Not $Radio1Executed Then
				_GUICtrlListView_DeleteAllItems($LV1)
				DesinstalaSoftware()
				$Radio1Executed = True
				$Radio2Executed = False
			EndIf

		Case $SInstalar
			GUICtrlSetState($LTSC, $GUI_DISABLE)
			If Not $Radio2Executed Then
				_GUICtrlListView_DeleteAllItems($LV1)
				InstalaSoftware()
				$Radio2Executed = True
				$Radio1Executed = False
			EndIf

		Case $Desmarcar
			UnCheck()

		Case $LTSC
			Local $confirma = MsgBox(4, $titulo, "Está a punto de eliminar todas las aplicaciones preinstaladas en el sistema, está seguro que desea continuar?")
			if $confirma = 6 Then
				GUISetState(@SW_HIDE)
				local $comando = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " & "Get-AppxPackage -AllUsers | Remove-AppxPackage"
				RunWait($comando, "", @SW_SHOW)
				GUISetState(@SW_SHOW)
				MsgBox(64,$titulo, "Ha finalizado el proceso de desinstalación de todas las aplicaciones preinstaladas en el sistema.")
			EndIf

		Case $Aplicar
			Local $totalApps = 0
			Local $code, $accion
			For $k=0 to UBound($apps)
				if _GUICtrlListView_GetItemChecked($LV1, $k) Then
					$totalApps += 1
				EndIf
			Next
			if $totalApps > 0 then
				Local $confirma = MsgBox(4, $titulo, "Usted ha seleccionado " & $totalApps & " app(s), está seguro que desea continuar?")
				if $confirma = 6 Then
					GUISetState(@SW_HIDE)
					For $x = 0 to UBound($apps)
						if _GUICtrlListView_GetItemChecked($LV1, $x) Then
							If GUICtrlRead($SInstalar) = $GUI_CHECKED Then
								$code = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " & "winget install " & _GUICtrlListView_GetItemText($LV1, $x, 1)
								$accion = "instalación"
							EndIf
							If GUICtrlRead($SDesinstalar) = $GUI_CHECKED Then
								$code = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " & "Get-AppxPackage *" & _GUICtrlListView_GetItemText($LV1, $x, 1) & "* | Remove-AppxPackage"
								$accion = "desinstalación"
							EndIf
							RunWait($code, "", @SW_SHOW)
						EndIf
					Next
					UnCheck()
					MsgBox(64,$titulo, "Ha finalizado el proceso de " & $accion & " de las aplicaciones seleccionadas.")
					GUISetState(@SW_SHOW)
				EndIf
			Else
				MsgBox(64,$titulo, "Antes de continuar, por favor seleccione una aplicación dentro de la lista.")
			EndIf

		Case $facebook
			ShellExecute("https://bit.ly/38lcZK2")

		Case $telegram
			ShellExecute("https://bit.ly/3MdAF1F")

		Case $youtube
			ShellExecute("https://www.youtube.com/RuHorRu")

	EndSwitch
WEnd

Func InstalaSoftware()
	DeleteItemsArray()
	_ArrayAdd($apps, "3D Builder")
	_ArrayAdd($apps, "3D Viewer")
	_ArrayAdd($apps, "Calculator")
	_ArrayAdd($apps, "Camara")
	_ArrayAdd($apps, "Clipchamp")
	_ArrayAdd($apps, "Clock")
	_ArrayAdd($apps, "Cortana")
	_ArrayAdd($apps, "Feedback Hub")
	_ArrayAdd($apps, "Get Help")
	_ArrayAdd($apps, "Correo y calendario")
	_ArrayAdd($apps, "Maps")
	_ArrayAdd($apps, "Media Player")
	_ArrayAdd($apps, "Microsoft Edge")
	_ArrayAdd($apps, "Microsoft Store")
	_ArrayAdd($apps, "Microsoft Teams")
	_ArrayAdd($apps, "Microsoft To Do")
	_ArrayAdd($apps, "Microsoft Whiteboard")
	_ArrayAdd($apps, "Mixed Reality Portal")
	_ArrayAdd($apps, "Movies & TV")
	_ArrayAdd($apps, "News")
	_ArrayAdd($apps, "Notepad")
	_ArrayAdd($apps, "OneNote")
	_ArrayAdd($apps, "Paint")
	_ArrayAdd($apps, "Phone Link")
	_ArrayAdd($apps, "Photos")
	_ArrayAdd($apps, "Quick Assist")
	_ArrayAdd($apps, "Snipping Tool")
	_ArrayAdd($apps, "Sticky Notes")
	_ArrayAdd($apps, "Terminal")
	_ArrayAdd($apps, "Tips")
	_ArrayAdd($apps, "Grabadora de voz")
	_ArrayAdd($apps, "Weather")
	_ArrayAdd($apps, "Xbox")
	_ArrayAdd($apps, "Xbox Game Bar")
	_ArrayAdd($apps, "NanaZIP")
	_ArrayAdd($apps, "WhatsApp")
	_ArrayAdd($apps, "VLC Player")
	_ArrayAdd($apps, "SublimeText 4")

	For $i = 0 to UBound($apps) -1
		GUICtrlCreateListViewItem($apps[$i], $LV1)
	Next
	_ArrayAdd($appsID, "9WZDNCRFJ3T6")
	_ArrayAdd($appsID, "9nblggh42ths")
	_ArrayAdd($appsID, "9WZDNCRFHVN5")
	_ArrayAdd($appsID, "9WZDNCRFJBBG")
	_ArrayAdd($appsID, "9P1J8S7CCWWT")
	_ArrayAdd($appsID, "9WZDNCRFJ3PR")
	_ArrayAdd($appsID, "9NFFX4SZZ23L")
	_ArrayAdd($appsID, "9NBLGGH4R32N")
	_ArrayAdd($appsID, "9PKDZBMV1H3T")
	_ArrayAdd($appsID, "9WZDNCRFHVQM")
	_ArrayAdd($appsID, "9WZDNCRDTBVB")
	_ArrayAdd($appsID, "9WZDNCRFJ3PT")
	_ArrayAdd($appsID, "XPFFTQ037JWMHS")
	_ArrayAdd($appsID, "XP8BT8DW290MPQ")
	_ArrayAdd($appsID, "9WZDNCRFJBMP")
	_ArrayAdd($appsID, "9WZDNCRFJBMP")
	_ArrayAdd($appsID, "9MSPC6MP8FM4")
	_ArrayAdd($appsID, "9NG1H8B3ZC7M")
	_ArrayAdd($appsID, "9WZDNCRFJ3P2")
	_ArrayAdd($appsID, "9WZDNCRFHVFW")
	_ArrayAdd($appsID, "9MSMLRH6LZF3")
	_ArrayAdd($appsID, "XPFFZHVGQWWLHB")
	_ArrayAdd($appsID, "9PCFS5B6T72H")
	_ArrayAdd($appsID, "9NMPJ99VJBWV")
	_ArrayAdd($appsID, "9WZDNCRFJBH4")
	_ArrayAdd($appsID, "9P7BP5VNWKX5")
	_ArrayAdd($appsID, "9MZ95KL8MR0L")
	_ArrayAdd($appsID, "9NBLGGH4QGHW")
	_ArrayAdd($appsID, "9N0DX20HK701")
	_ArrayAdd($appsID, "9WZDNCRDTBJJ")
	_ArrayAdd($appsID, "9WZDNCRFHWKN")
	_ArrayAdd($appsID, "9WZDNCRFJ3Q2")
	_ArrayAdd($appsID, "9MV0B5HZVK9Z")
	_ArrayAdd($appsID, "9NZKPSTSNW4P")
	_ArrayAdd($appsID, "9N8G7TSCL18R")
	_ArrayAdd($appsID, "9NKSQGP7F2NH")
	_ArrayAdd($appsID, "XPDM1ZW6815MQM")
	_ArrayAdd($appsID, "SublimeHQ.SublimeText.4")
	For $b = 0 to UBound($appsID) -1
		_GUICtrlListView_AddSubItem($LV1, $b, $appsID[$b], 1)
	Next
EndFunc

Func DesinstalaSoftware()
	DeleteItemsArray()
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

Func DeleteItemsArray()
	For $i = UBound($apps) - 1 To 0 Step -1
		_ArrayDelete($apps, $i)
		_ArrayDelete($appsID, $i)
	Next
EndFunc

