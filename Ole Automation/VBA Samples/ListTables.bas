Attribute VB_Name = "Module2"
'******************************************************************************
'* File:     ListTables.bas
'* Purpose:  This VBA program shows how to display properties of the first 5 tables
'*           defined in the current active PDM using message box.
'* Title:    Display tables properties in message box
'* Category: Display tables properties
'* Company:  Sybase Inc.
'* Author:
'* Created:
'* Modified:
'* Version:  1.0
'* Comment:  You can use Word, Excel, Visual Basic or any other program that supports VBA to execute this program.
'*           You need to add the Sybase PdCommon and the Sybase PdPDM type libraries in the type library references.
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Show properties of tables
'-----------------------------------------------------------------------------
Sub ListTables()

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
    ElseIf Not model.IsKindOf(PdPDM.cls_Model) Then
       MsgBox "The current model is not a PDM model."
    Else
       ShowProperties PD, model
    End If
    
    ' Clean Up
    Set PD = Nothing
    
End Sub

'-----------------------------------------------------------------------------
' Show properties of tables defined in a package
'-----------------------------------------------------------------------------
Sub ShowProperties(PD, package)
   ' Get the Tables collection
   Dim ModelTables
   Set ModelTables = package.Tables
   MsgBox "The model or package '" + package.Name + "' contains " + CStr(ModelTables.Count) + " tables."
   ' For each table
   Dim tbl
   Dim noTable
   Dim bShortcutClosed
   Dim Desc
   noTable = 1
   For Each tbl In ModelTables
      If IsObject(tbl) Then
         bShortcutClosed = False
         If tbl.IsShortcut Then
            If tbl.Status = "Opened" Then
               Set tbl = tbl.TargetObject
            Else
               bShortcutClosed = True
            End If
         End If

         Desc = "Table " + CStr(noTable) + ":"
         If Not bShortcutClosed Then
            Desc = Desc + vbCrLf + "ObjectID: " + tbl.ObjectID
            Desc = Desc + vbCrLf + "Name: " + tbl.Name
            Desc = Desc + "    " + "Code: " + tbl.Code
            If IsObject(tbl.parent) Then
               Desc = Desc + vbCrLf + "Parent: " + tbl.parent.Name
            Else
               Desc = Desc + vbCrLf + "Parent: " + "<None>"
            End If
            Desc = Desc + vbCrLf + "DisplayName: " + tbl.DisplayName
            Desc = Desc + vbCrLf + "ObjectType: " + tbl.ObjectType
            Desc = Desc + vbCrLf + "CreationDate: " + CStr(tbl.CreationDate)
            Desc = Desc + vbCrLf + "Creator: " + tbl.Creator
            Desc = Desc + vbCrLf + "ModificationDate: " + CStr(tbl.ModificationDate)
            Desc = Desc + vbCrLf + "Modifier: " + tbl.Modifier
            Desc = Desc + vbCrLf + "Comment: " + tbl.Comment
            Desc = Desc + vbCrLf + "Description: " + PD.Rtf2Ascii(tbl.Description)
         Else
            Desc = Desc + vbCrLf + "The target object of the table shortcut " + tbl.Code + " is not accessible."
         End If
         MsgBox Desc
      Else
         MsgBox "Not an object!"
      End If
      noTable = noTable + 1
      
      If noTable > 5 Then
         Exit For
      End If
   Next
   
   ' Display tables defined in subpackages
   Dim subpackage
   For Each subpackage In package.Packages
      ShowProperties PD, subpackage
   Next
End Sub

