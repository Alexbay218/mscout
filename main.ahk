;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileCreateDir, data
Gui, Add, Text,, Team Number
Gui, Add, Edit, vTeamEdit,
Gui, Add, Text,, Week Number
Gui, Add, Edit, vEventEdit
Gui, Add, Text,, Match Type
Gui, Add, DropDownList, vMatchDDL, Q||QF|SF|F
Gui, Add, Text,, Match Number
Gui, Add, Edit, vMatchEdit,
Gui, Add, Text, HwndDisTHwnd, Seconds Left 150.00
Gui, Add, ListBox, r12 w300 HwndDisLBHwnd,
Gui, Show

restart:

CurrTime := 150
CurrTime := Round(CurrTime, 2)

TimeInt := 0
TimeTS := 0
Disp := []
CubeStat := "C"
ClimbStat := "N"

LineTS := []

ExchangeTS := []
ExchangeInt := []
ExchangeSF := []

SwitchTS := []
SwitchInt := []
SwitchSF := []

ScaleTS := []
ScaleInt := []
ScaleSF := []

OpSwitchTS := []
OpSwitchInt := []
OpSwitchSF := []

DroppedTS := []
DroppedInt := []

DefTS := []

ClimbTS := []
ClimbInt := []
Return

Enter::
Disp.Push(Round((150 - CurrTime),2) . " Has Cube")
TimeInt := A_TickCount
TimeTS := CurrTime
while CurrTime > -10 and TimeInt != 0
{
  CT := A_TickCount
  GuiControl,, %DisTHwnd%, Seconds Left %CurrTime%
  DispStr := ""
  for index, element in Disp
  {
    DispStr := DispStr . "|" . element
  }
  DispStr := DispStr . "||"
  GuiControl,, %DisLBHwnd%, %DispStr%
  Sleep, 100
  CurrTime -= (A_TickCount - CT)/1000
  CurrTime := Round(CurrTime, 2)
}
TimeInt := 0

Gui, Submit, NoHide
FileCreateDir, data\%TeamEdit%
file := FileOpen("data\" . TeamEdit . "\" . TeamEdit . "_" . EventEdit . "_" . MatchDDL . MatchEdit . ".csv", "w")
file.Write("LineTS,ExchangeTS,ExchangeInt,SwitchTS,SwitchInt,SwitchSF,ScaleTS,ScaleInt,ScaleSF,OpSwitchTS,OpSwitchInt,OpSwitchSF,DroppedTS,DroppedInt,DefTS,ClimbTS,ClimbInt`r`n")
i := 1
while i <= LineTS.length() or i <= ExchangeTS.Length() or i <= SwitchTS.Length() or i <= ScaleTS.Length() or i <= OpSwitchTS.Length() or i <= DroppedTS.Length() or i <= ClimbTS.Length() 
{
  CurrString := ""
  if(i <= LineTS.length()) {
    CurrString := LineTS[i]
  }
  if(i <= ExchangeTS.Length()) {
    CurrString := CurrString . "," . ExchangeTS[i] . "," . ExchangeInt[i]
  } else {
    CurrString := CurrString . ",,"
  }
  if(i <= SwitchTS.Length()) {
    CurrString := CurrString . "," . SwitchTS[i] . "," . SwitchInt[i] . "," . SwitchSF[i]
  } else {
    CurrString := CurrString . ",,,"
  }
  if(i <= ScaleTS.Length()) {
    CurrString := CurrString . "," . ScaleTS[i] . "," . ScaleInt[i] . "," . ScaleSF[i]
  } else {
    CurrString := CurrString . ",,,"
  }
  if(i <= OpSwitchTS.Length()) {
    CurrString := CurrString . "," . OpSwitchTS[i] . "," . OpSwitchInt[i] . "," . OpSwitchSF[i]
  } else {
    CurrString := CurrString . ",,,"
  }
  if(i <= DroppedTS.Length()) {
    CurrString := CurrString . "," . DroppedTS[i] . "," . DroppedInt[i]
  } else {
    CurrString := CurrString . ",,"
  }
  if(i <= DefTS.Length()) {
    CurrString := CurrString . "," . DefTS[i]
  } else {
    CurrString := CurrString . ","
  }
  if(i <= ClimbTS.Length()) {
    CurrString := CurrString . "," . ClimbTS[i] . "," . ClimbInt[i]
  } else {
    CurrString := CurrString . ",,"
  }
  CurrString := CurrString . "`r`n"
  file.Write(CurrString)
  i += 1
}
file.Close()
GuiControl,, %DisTHwnd%, Seconds Left 150.00
gosub restart
Return

Delete::
Gui, Submit, NoHide
GuiControl,, %DisTHwnd%, Seconds Left 150.00
gosub restart
Return

L::
if (TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Line Crossed")
  LineTS.Push((150-CurrTime))
}
Return

D::
if (TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Defense Played")
  DefTS.Push((150-CurrTime))
}
Return

E::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Placed in Exchange")
  CubeStat := "E"
  ExchangeTS.Push((150-TimeTS))
  ExchangeInt.Push(((A_TickCount-TimeInt)/1000))
}
Return

W::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Placed in Switch")
  CubeStat := "W"
  SwitchTS.Push((150-TimeTS))
  SwitchInt.Push(((A_TickCount-TimeInt)/1000))
  SwitchSF.Push(1)
}
Return

+W::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Failed Switch")
  CubeStat := "W"
  SwitchTS.Push((150-TimeTS))
  SwitchInt.Push(((A_TickCount-TimeInt)/1000))
  SwitchSF.Push(0)
}
Return

S::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Placed in Scale")
  CubeStat := "S"
  ScaleTS.Push((150-TimeTS))
  ScaleInt.Push(((A_TickCount-TimeInt)/1000))
  ScaleSF.Push(1)
}
Return

+S::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Failed Scale")
  CubeStat := "S"
  ScaleTS.Push((150-TimeTS))
  ScaleInt.Push(((A_TickCount-TimeInt)/1000))
  ScaleSF.Push(0)
}
Return

O::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Placed in Op Switch")
  CubeStat := "O"
  OpSwitchTS.Push((150-TimeTS))
  OpSwitchInt.Push(((A_TickCount-TimeInt)/1000))
  OpSwitchSF.Push(1)
}
Return

+O::
if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Failed Op Switch")
  CubeStat := "O"
  OpSwitchTS.Push((150-TimeTS))
  OpSwitchInt.Push(((A_TickCount-TimeInt)/1000))
  OpSwitchSF.Push(0)
}
Return

C::
if (ClimbStat != "CA" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Climb Attempt")
  ClimbStat := "CA"
  TimeInt := A_TickCount
  TimeTS := CurrTime
  ClimbTS.Push((150-CurrTime))
} else if (ClimbStat == "CA" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Climbed")
  ClimbStat := "CD"
  ClimbInt.Push(((A_TickCount-TimeInt)/1000))
}
Return

Space::
if (CubeStat != "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Has Cube")
  CubeStat := "C"
  TimeInt := A_TickCount
  TimeTS := CurrTime
} else if (CubeStat == "C" and TimeInt != 0) {
  Disp.Push(Round((150 - CurrTime),2) . " Dropped Cube")
  CubeStat := "D"
  DroppedTS.Push((150-TimeTS))
  DroppedInt.Push(((A_TickCount-TimeInt)/1000))
}
Return

GuiClose:
ExitApp

Escape::
ExitApp