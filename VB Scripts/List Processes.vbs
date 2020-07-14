'******************************************************************************
'* File:     List Processes.vbs
'* Purpose:  This VB Script shows how to display properties of business processes 
'*           defined  in the current active BPM in the output window.
'* Title:    Display processes properties in output window
'* Category: Display processes properties
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

' Get the current active model
Dim model
Set model = ActiveModel
If (model Is Nothing) Or (Not model.IsKindOf(PdBPM.cls_Model)) Then
   MsgBox "The current model is not a BPM model."
Else
   ShowProperties model
End If


'-----------------------------------------------------------------------------
' Display processes properties of a folder
'-----------------------------------------------------------------------------
Sub ShowProperties(parent)
   ' Get the Processes collection
   Dim ModelProcesses
   Set ModelProcesses = parent.Processes
   Output "The process '" + parent.Name + "' contains " + CStr(ModelProcesses.Count) + " processes."
   Output ""

   ' Show processes defined in the first level
   Dim noProc
   Dim proc
   noProc = 1
   For Each proc In ModelProcesses
      ShowProcess proc, noProc
      noProc = noProc + 1
   Next
   
   ' Show processes defined in subprocesses
   For Each proc In ModelProcesses
      If Not proc.IsShortcut Then
         ShowProperties proc
      End If
   Next

End Sub

'-----------------------------------------------------------------------------
' Display properties of a process
'-----------------------------------------------------------------------------
Sub ShowProcess(proc, noProc)
   If IsObject(proc) Then
      Dim bShortcutClosed
      bShortcutClosed = false
      If proc.IsShortcut Then
		 '
		 If Not (proc.TargetObject Is Nothing) Then
            Set proc = proc.TargetObject
         Else
            bShortcutClosed = true
         End If
      End If
   
      ' Show properties
      Output "================================"
      Output "Process " + CStr(noProc) + ":"
      Output "================================"
      If Not bShortcutClosed Then
         Output "ObjectID: "   + proc.ObjectID
         Output "Name: "       + proc.Name
         Output "Code: "       + proc.Code
         If IsObject(proc.Parent) Then
            Output "Parent: "  + proc.Parent.Name
         Else
            Output "Parent: "  + "<None>"
         End If
         Output "DisplayName: " + proc.DisplayName
         Output "ObjectType: " + proc.ObjectType
         Output "CreationDate: " + CStr(proc.CreationDate)
         Output "Creator: "    + proc.Creator
         Output "ModificationDate: " + CStr(proc.ModificationDate)
         Output "Modifier: "   + proc.Modifier
         Output "Comment: "    + proc.Comment
         Output "Description: " + Rtf2Ascii(proc.Description)
      Else
         Output "The target object of the process shortcut " + proc.Name + " is not accessible."
      End If
      Output ""
   Else
      MsgBox "It is not an object!"
   End If
End Sub
