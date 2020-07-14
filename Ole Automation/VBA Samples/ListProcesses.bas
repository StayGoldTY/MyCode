Attribute VB_Name = "Module2"
'******************************************************************************
'* File:     ListProcesses.bas
'* Purpose:  This VBA program shows how to display properties of business processes
'*           defined  in the current active BPM in the output window.
'* Title:    Display processes properties in output window
'* Category: Display processes properties
'* Company:  Sybase Inc.
'* Author:
'* Created:
'* Modified:
'* Version:  1.0
'* Comment:  You can use Word, Excel, Visual Basic or any other program that supports VBA to execute this program.
'*           You need to add the Sybase PdCommon and the Sybase PdBPM type libraries in the type library references.
'******************************************************************************

Option Explicit


Sub ListProcesses()

    ' PowerDesigner server connection
    ' (it must not be reset until client is over)
    Dim PD As PdCommon.application

    ' Get Application object
    Set PD = CreateObject("PowerDesigner.Application")

    ' Get the current active model
    Dim model As PdCommon.BaseModel
    Set model = PD.ActiveModel
    If model Is Nothing Then
       MsgBox "There is no current model."
    ElseIf Not model.IsKindOf(PdBPM.cls_Model) Then
       MsgBox "The current model is not a BPM model."
    Else
       ShowProperties PD, model
    End If
    
    ' Clean Up
    Set PD = Nothing
    
End Sub

Sub ShowProperties(PD, parent)
   ' Get the Processes collection
   Dim ModelProcesses
   Set ModelProcesses = parent.Processes
   PD.Output "The process '" + parent.Name + "' contains " + CStr(ModelProcesses.Count) + " processes."
   PD.Output ""

   ' Show processes defined in the first level
   Dim proc
   Dim noProc
   noProc = 1
   For Each proc In ModelProcesses
      ShowProcess PD, proc, noProc
      noProc = noProc + 1
   Next
   
   ' Show processes defined in subprocesses
   For Each proc In ModelProcesses
      ShowProperties PD, proc
   Next

End Sub

' Show process properties
Sub ShowProcess(PD, proc, noProc)
   If IsObject(proc) Then
      ' Show properties
      PD.Output "================================"
      PD.Output "Process " + CStr(noProc) + ":"
      PD.Output "================================"
      PD.Output "ObjectID: " + proc.ObjectID
      PD.Output "Name: " + proc.Name
      PD.Output "Code: " + proc.Code
      If IsObject(proc.parent) Then
         PD.Output "Parent: " + proc.parent.Name
      Else
         PD.Output "Parent: " + "<None>"
      End If
      PD.Output "DisplayName: " + proc.DisplayName
      PD.Output "ObjectType: " + proc.ObjectType
      PD.Output "CreationDate: " + CStr(proc.CreationDate)
      PD.Output "Creator: " + proc.Creator
      PD.Output "ModificationDate: " + CStr(proc.ModificationDate)
      PD.Output "Modifier: " + proc.Modifier
      PD.Output "Comment: " + proc.Comment
      PD.Output "Description: " + PD.Rtf2Ascii(proc.Description)
      PD.Output ""
   Else
      MsgBox "It is not an object!"
   End If
End Sub
