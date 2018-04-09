#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileRemoveDir, compdata, 1
FileCreateDir, compdata
Loop, Files, data\*.csv, R
{
  fileNArr := StrSplit(A_LoopFileName, "_")
  FileCreateDir, % "compdata\" . fileNArr[1]
  existed := 0
  IfExist, % "compdata\" . fileNArr[1] . "\" . fileNArr[1] . "_" . fileNArr[2] . ".csv"
    existed := 1
  compFile := FileOpen("compdata\" . fileNArr[1] . "\" . fileNArr[1] . "_" . fileNArr[2] . ".csv", "a")
  if (existed = 0) {
    compFile.Write("Match,LineTS,ExchangeTS,ExchangeInt,SwitchTS,SwitchInt,SwitchSF,ScaleTS,ScaleInt,ScaleSF,OpSwitchTS,OpSwitchInt,OpSwitchSF,DroppedTS,DroppedInt,DefTS,ClimbTS,ClimbInt`r`n")
  }
  Loop, Read, %A_LoopFileLongPath%
  {
    if (InStr(A_LoopReadLine,"TS") = 0) {
      compFile.Write(SubStr(fileNArr[3], 1, StrLen(fileNArr[3])-4) . "," . A_LoopReadLine . "`r`n")
    }
  }
  compFile.Close()
}

Loop, Files, compdata\*.csv, R
{
  fileNArr := StrSplit(A_LoopFileName, "_")
  FileCreateDir, % "compdata\" . fileNArr[1]
  existed := 0
  IfExist, % "compdata\" . fileNArr[1] . "\" . fileNArr[1] . ".csv"
    existed := 1
  compFile := FileOpen("compdata\" . fileNArr[1] . "\" . fileNArr[1] . ".csv", "a")
  if (existed = 0) {
    compFile.Write("Match,LineTS,ExchangeTS,ExchangeInt,SwitchTS,SwitchInt,SwitchSF,ScaleTS,ScaleInt,ScaleSF,OpSwitchTS,OpSwitchInt,OpSwitchSF,DroppedTS,DroppedInt,DefTS,ClimbTS,ClimbInt`r`n")
  }
  Loop, Read, %A_LoopFileLongPath%
  {
    if (InStr(A_LoopReadLine,"TS") = 0) {
      compFile.Write("W" . SubStr(fileNArr[2], 1, StrLen(fileNArr[2])-4) . A_LoopReadLine . "`r`n")
    }
  }
  compFile.Close()
}