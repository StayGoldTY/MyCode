'******************************************************************************
'* File:     AccessRTFDescription.vbs
'* Purpose:  This VB Script shows how to get RTF description in ASCII format 
'*           and how to modify description.
'* Title:    Convert RTF description to ASCII
'* Category: Convert RTF to ASCII
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

' Get the current active model
Dim Model
Set Model = ActiveModel
If (Model Is Nothing) Or (Not Model.IsKindOf(PdOOM.cls_Model)) Then
   MsgBox "The current model is not an OOM model."
Else
   ShowProperties Model
End If


'-----------------------------------------------------------------------------
' Show properties of classes
'-----------------------------------------------------------------------------
Sub ShowProperties(package)
   ' Show classes of the current model/package
   Dim noClass
   noClass = 1
   ' For each class
   Dim cls
   For Each cls In package.Classes
      If Not cls.IsShortcut Then
         ShowClass cls, noClass
         noClass = noClass + 1
      End If
   Next
End Sub

'-----------------------------------------------------------------------------
' Show class properties
'-----------------------------------------------------------------------------
Sub ShowClass(cls, noClass)
   If IsObject(cls) Then
      ' Show properties
      Output "================================"
      Output "Class " + CStr(noClass) + ":"
      Output "================================"
      Output "Name: "       + cls.Name
      Output "Code: "       + cls.Code
      Output "Comment: "    + cls.Comment
      Output "Description (RTF): "    + cls.Description      
      ' Convert description to ASCII
      Output "Description (ASCII): "  + Rtf2Ascii(cls.Description)
      Output "CreationDate: " + CStr(cls.CreationDate)
      Output "Creator: "    + cls.Creator
      Output "ModificationDate: " + CStr(cls.ModificationDate)
      Output "Modifier: "   + cls.Modifier
      Output ""
      
      ' Change the description to ASCII
      cls.Description = "Description of the class " + cls.Name + "."
      
   End If
End Sub
