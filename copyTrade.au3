#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
#include <WinAPIProc.au3>
#include <Array.au3>
; Script Start - Add your code below here

$prog = "D:\Source\autoit\test.exe"
$progDir = Stringleft($prog,StringInStr($Prog,'\',0,-1))
ConsoleWrite($progDir & @CRLF)

$checkRun = Run($prog,$progDir,@sw_hide)
ConsoleWrite($checkRun)
ConsoleWrite("-")
$prog1 = "D:\Source\autoit\test1.exe"
$checkRun1 = Run($prog,$progDir,@sw_hide)
ConsoleWrite($checkRun)
Local $aData = _WinAPI_EnumProcessWindows($checkRun, true)

Local $aWinList = WinList("Form1")
;_ArrayDisplay($aWinList)
;_ArrayDisplay($aData, '_WinAPI_EnumProcessWindows')
$hwnd1 = $aData[1][0];
ConsoleWrite($hwnd1)
WinWait($hwnd1)
WinMove($hwnd1, "", 1, 1, 150, 200, -1)