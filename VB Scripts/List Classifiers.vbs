'******************************************************************************
'* File:     List Classifiers.vbs
'* Purpose:  This VB Script shows how to display the properties of the first five classifiers 
'*           defined in the current active OOM using message box
'*           It also shows how to convert RTF description into ASCII text.
'* Title:    Display classifiers properties in message box
'* Category: Display classifier properties
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
   ShowProperties
End If


'-----------------------------------------------------------------------------
' Show properties of classifiers
'-----------------------------------------------------------------------------
Sub ShowProperties()
   ' Get the Classes collection
   Dim ModelClassifiers
   Set ModelClassifiers = Model.Classifiers
   MsgBox "The model '" + Model.Name + "' contains " + CStr(ModelClassifiers.Count) + " classifiers."

   ' For each classifier
   Dim noClass
   noClass = 1
   Dim Desc
   Dim bShortcutClosed
   Dim cls
   For Each cls In ModelClassifiers
      If IsEmpty(cls) Then
         MsgBox "It is not an object."
      ElseIf IsObject(cls) Then
         bShortcutClosed = false
         If cls.IsShortcut Then
            If cls.Status = "Opened" Then
               ' Show properties of the target object
               Set cls = cls.TargetObject
            Else
               bShortcutClosed = true
            End If
         End If
           
         Desc = "Classifier " + CStr(noClass) + ":"
         If Not bShortcutClosed Then
            Desc = Desc + vbCrLf + "ObjectID: "   + cls.ObjectID
            Desc = Desc + vbCrLf + "Name: "       + cls.Name
            Desc = Desc + "    " + "Code: "       + cls.Code
            If IsObject(cls.Parent) Then
               Desc = Desc + vbCrLf + "Parent: "  + cls.Parent.Name
            Else
               Desc = Desc + vbCrLf + "Parent: "  + "<None>"
            End If
            Desc = Desc + vbCrLf + "DisplayName: " + cls.DisplayName
            Desc = Desc + vbCrLf + "ObjectType: " + cls.ObjectType
            Desc = Desc + vbCrLf + "CreationDate: " + CStr(cls.CreationDate)
            Desc = Desc + vbCrLf + "Creator: "    + cls.Creator
            Desc = Desc + vbCrLf + "ModificationDate: " + CStr(cls.ModificationDate)
            Desc = Desc + vbCrLf + "Modifier: "   + cls.Modifier
            Desc = Desc + vbCrLf + "Comment: "    + cls.Comment
            Desc = Desc + vbCrLf + "Description: " + Rtf2Ascii(cls.Description)
         Else
            ' The target model is not opened
            Desc = Desc + vbCrLf + "The target object of the classifier shortcut " + cls.Name + " is not accessible."
         End If
         MsgBox Desc
      Else
         MsgBox "Not an object!"
      End If
      noClass = noClass + 1
   
      If noClass > 5 Then
         Exit For
      End If
   Next
End Sub