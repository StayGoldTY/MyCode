Attribute VB_Name = "Module2"
'******************************************************************************
'* File:     ListClassifiers.bas
'* Purpose:  This VBA programt shows how to display the properties of the first five classifiers
'*           defined in the current active OOM using message box
'*           It also shows how to convert RTF description into ASCII text.
'* Title:    Display classifiers properties in message box
'* Category: Display classifier properties
'* Company:  Sybase Inc.
'* Author:
'* Created:
'* Modified:
'* Version:  1.0
'* Comment:  You can use Word, Excel, Visual Basic or any other program that supports VBA to execute this program.
'*           You need to add the Sybase PdCommon and the Sybase PdOOM type libraries in the type library references.
'******************************************************************************

Option Explicit

Sub ListClassifers()

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
    ElseIf Not model.IsKindOf(PdOOM.cls_Model) Then
       MsgBox "The current model is not an OOM model."
    Else
       ShowProperties PD, model
    End If
    
    ' Clean Up
    Set PD = Nothing
    
End Sub

Sub ShowProperties(PD, model)
   ' Get the Classes collection
   Dim ModelClassifiers
   Set ModelClassifiers = model.Classifiers
   MsgBox "The model '" + model.Name + "' contains " + CStr(ModelClassifiers.Count) + " classifiers."

   ' For each classifier
   Dim cls
   Dim noClass
   noClass = 1
   For Each cls In ModelClassifiers
      If IsEmpty(cls) Then
         MsgBox "Empty!"
      ElseIf IsObject(cls) Then
         Dim Desc As String
         Desc = "Classifier " + CStr(noClass) + ":"
         Desc = Desc + vbCrLf + "ObjectID: " + cls.ObjectID
         Desc = Desc + vbCrLf + "Name: " + cls.Name
         Desc = Desc + "    " + "Code: " + cls.Code
         If IsObject(cls.parent) Then
            Desc = Desc + vbCrLf + "Parent: " + cls.parent.Name
         Else
            Desc = Desc + vbCrLf + "Parent: " + "<None>"
         End If
         Desc = Desc + vbCrLf + "DisplayName: " + cls.DisplayName
         Desc = Desc + vbCrLf + "ObjectType: " + cls.ObjectType
         Desc = Desc + vbCrLf + "CreationDate: " + CStr(cls.CreationDate)
         Desc = Desc + vbCrLf + "Creator: " + cls.Creator
         Desc = Desc + vbCrLf + "ModificationDate: " + CStr(cls.ModificationDate)
         Desc = Desc + vbCrLf + "Modifier: " + cls.Modifier
         Desc = Desc + vbCrLf + "Comment: " + cls.Comment
         Desc = Desc + vbCrLf + "Description: " + PD.Rtf2Ascii(cls.Description)
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
