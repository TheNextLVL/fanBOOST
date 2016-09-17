;fanBOOSTv1.00 for toshiba satellite l855-11k

#NoTrayIcon

#include <Constants.au3>
#include <GUIConstants.au3>

; ======================== FAN SPEED TABLE FOR L855-11k ========================
Global $speedValue[5] = ["0x02", "0x04", "0x05", "0x06", "0x0D"]

; ============================ FAN REG FOR L855-11k ============================
Global $regSetSpeed="0XA0"
Global $regSpeed=""
Global $regTemp=""


Global $rwpath="unread"
Global $version="v1.00"

;fanBOOSTiniread()
checkrwpath()

If $CmdLine[0]= 0 Then 
   trayicon()
Else
   Select									;commandlineswitches: -a1, -a2, -b1, -b2, -b3 
	  Case $CmdLine[1]= "-a1"
		 changeFanSpeed($speedValue[0])
	  Case $CmdLine[1]= "-a2"
		 changeFanSpeed($speedValue[1])
	  Case $CmdLine[1]= "-b1"
		 changeFanSpeed($speedValue[2])
	  Case $CmdLine[1]= "-b2"
		 changeFanSpeed($speedValue[3])
	  Case $CmdLine[1]= "-b3"
		 changeFanSpeed($speedValue[4])
	  Case Else
		 trayicon()
   EndSelect
EndIf  

Func trayicon()
   Opt("TrayMenuMode", 1) 
   $auto1item = TrayCreateItem("auto", -1, -1, 1)
   $auto2item = TrayCreateItem("auto BOOST", -1, -1, 1)
   $boost1item = TrayCreateItem("BOOST-1", -1, -1, 1)
   $boost2item = TrayCreateItem("BOOST-2", -1, -1, 1)
   $boost3item = TrayCreateItem("BOOST-3", -1, -1, 1)
   $readspeeditem = TrayCreateItem("current speed")
   TrayCreateItem("")
   $aboutitem = TrayCreateItem("about")
   $exititem = TrayCreateItem("exit")
   TraySetState()
   TrayTip("fanBOOST" & $version, "is now running", 2)
   While 1
	  $msg = TrayGetMsg()
	  Select
        Case $msg = 0
            ContinueLoop
		Case $msg = $auto1item
			changeFanSpeed($speedValue[0])
		Case $msg = $auto2item
			TrayItemSetState($auto2item, $TRAY_UNCHECKED)
			TrayItemSetState($auto1item, $TRAY_CHECKED)
			changeFanSpeed($speedValue[1])
		Case $msg = $boost1item
            changeFanSpeed($speedValue[2])
		Case $msg = $boost2item
			changeFanSpeed($speedValue[3])
		Case $msg = $boost3item
			changeFanSpeed($speedValue[4])
		Case $msg = $readspeeditem
			TrayItemSetState($readspeeditem, $TRAY_UNCHECKED)
			readSpeed()
		Case $msg = $aboutitem
			TrayItemSetState($aboutitem, $TRAY_UNCHECKED)
            MsgBox(0, "fanBOOST" & $version, "FanBOOST for toshiba satellite L855-11k modified by nextlvl." & @CRLF & "This program uses rw-read and write utility to control the hardware." & @CRLF & "based on fanBOOSTv1.00 by nem0 2013.")
		Case $msg = $exititem
            Exit
	  EndSelect
   WEnd
EndFunc

Func changeFanSpeed($regcode)
	; command send to RW  'WEC16 fanreg regcode; rwexit'
   If crashprev() Then Run($rwpath & ' /Command="WEC16 ' & $regSetSpeed & ' ' & $regcode &'; rwexit" /Stdout',"", @SW_HIDE)
EndFunc


Func readSpeed()
   ; If crashprev() Then
	  ; $rs = Run($rwpath & ' /Command="REC16 0X5c; rwexit" /Stdout',"", @SW_HIDE, $STDOUT_CHILD)
	  ; ProcessWaitClose($rs)
	  ; $rs2 = StdoutRead($rs)
	  ; If Not @error Then 
		; $rs3 = StringRight(StringLeft($rs2,26),6)
		; If $rs3 = "0x0000" Then 
		 ; $speed = 0
		; Else
		 ; $speed = Round(988600/(Dec(Hex($rs3))))
		; EndIf
		; TrayTip("fanBOOST", "current speed:  " & $speed & " rpm", 3)
	  ; EndIf
   ; Endif
   TrayTip("fanBOOST" & $version, "Feature not available :C", 3)
EndFunc

Func crashprev()
  Local $rwbusy=0
  If ProcessExists("rw.exe") Then
	 Sleep(250)
	 If ProcessExists("rw.exe") Then
		Sleep(250)
		If ProcessExists("rw.exe") Then
		   Sleep(250)
		   If ProcessExists("rw.exe") Then
			  $rwbusy=1
			  MsgBox(0, "fanBOOST" & $version, "you need to close running instances of rw-read and write utility (rw.exe) for fanBOOST to be able to issue commands through it.")
		   EndIf
		EndIf
	 EndIf   
   EndIf
   Return (Not $rwbusy)
EndFunc

Func checkrwpath()
   If Not FileExists($rwpath) Then
	  $rwpath= @ProgramFilesDir & "\RW-Everything\rw.exe"
	  If Not FileExists($rwpath) Then
		 $rwpath= @ProgramFilesDir & "\..\Program Files\RW-Everything\rw.exe"
		 If Not FileExists($rwpath) Then
			$rwpath= "rw.exe"
			If Not FileExists($rwpath) Then  
			   $rwpath= "unread"
			   rwdown()
			EndIf
		 EndIf
	  EndIf
	  ;fanBOOSTiniwrite()
   EndIf
EndFunc

Func rwdown()
   GUICreate("fanBOOST", 420, 150)
   GUICtrlCreateLabel("fanBOOST" & $version & @CRLF & @CRLF & "to obtain the desired functionality you need to install rw-read and write utility." & @CRLF & @CRLF & "it's a great hardware register editor freely available at:", 30, 10)
   $Label1 = GUICtrlCreateLabel("http://rweverything.com", 145, 80, 136, 17)
   GUICtrlSetFont($label1, 8.5,"", 4)
   GUICtrlSetColor ($label1,0x256D7B)
   $butt = GUICtrlCreateButton("ok", 180, 100, 60)
   GUISetState(@SW_SHOW)
   While 1
	  $nMsg = GUIGetMsg()
	  Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $butt
			Exit
		 Case $Label1
			ShellExecute("http://rweverything.com")
	  EndSwitch
   WEnd
   GUIDelete ("fanBOOST")
EndFunc

Exit

