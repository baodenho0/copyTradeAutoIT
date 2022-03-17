#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIProc.au3>
#include <Array.au3>
#include <WinAPIFiles.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 455, 291, 192, 124)
$run = GUICtrlCreateButton("Run", 288, 256, 75, 25)
$play = GUICtrlCreateButton("Play", 368, 256, 75, 25)
$Edit1 = GUICtrlCreateEdit("", 8, 8, 433, 241)
GUICtrlSetData(-1, "Edit1")
$update = GUICtrlCreateButton("Update", 8, 256, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Global $fileDB = "db.txt"
Global $arrLocations
Global $arrHwnds[0]

loadFile()


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $run
			runProcess()
		Case $play
			play()
		Case $update
			update()

	EndSwitch
WEnd

Func runProcess()
   openApp()
EndFunc

Func play()

EndFunc

Func update()
   $txt = _GUICtrlEdit_GetText($Edit1)
   saveFile($txt)
   loadFile()
   MsgBox(0, "", "Success")
EndFunc

Func loadFile()
   $arrLocations = FileReadToArray($fileDB)
   Local $sFileRead = FileRead($fileDB)
   GUICtrlSetData($Edit1, $sFileRead)
EndFunc

Func createFile()
   If Not _FileCreate($fileDB) Then
	  MsgBox($MB_SYSTEMMODAL, "Error", " Error Creating/Resetting log.      error:" & @error)
   EndIf
EndFunc

Func saveFile($Edit1)
    Local $hFileOpen = FileOpen($fileDB, 2)
    If $hFileOpen = -1 Then
        createFile()
    EndIf
    FileWrite($fileDB, $Edit1)
    FileClose($hFileOpen)
EndFunc

Func openApp()
   For $prog In $arrLocations
	  $progDir = Stringleft($prog,StringInStr($Prog,'\',0,-1))
	  $pid = Run($prog,$progDir,@SW_SHOWNOACTIVATE)
	  $hwnd = getHwndFromPID($pid)
	  _ArrayAdd($arrHwnds, $hwnd)
	  WinWait($hwnd, "", 10)
   Next
EndFunc

Func getHwndFromPID($PID)
    $hWnd = 0
    $stPID = DllStructCreate("int")
    Do
        $winlist2 = WinList()
        For $i = 1 To $winlist2[0][0]
            If $winlist2[$i][0] <> "" Then
                DllCall("user32.dll", "int", "GetWindowThreadProcessId", "hwnd", $winlist2[$i][1], "ptr", DllStructGetPtr($stPID))
                If DllStructGetData($stPID, 1) = $PID Then
                    $hWnd = $winlist2[$i][1]
                    ExitLoop
                EndIf
            EndIf
        Next
        Sleep(100)
    Until $hWnd <> 0
    Return $hWnd
EndFunc