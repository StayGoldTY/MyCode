'******************************************************************************
'* File:     DeletePrivateAttributes.bas
'* Purpose:  This VBA program shows how to delete all private attributes 
'*           in the current OOM model
'* Title:    Delete Private Attributes
'* Category: Modify Model, Delete Attributes
'* Company:  Sybase Inc.
'* Author:   
'* Created:  
'* Modified: 
'* Version:  1.0
'* Comment:  You can use Word, Excel, Visual Basic or any other program that supports VBA to execute this program.
'*           You need to add the Sybase PdCommon and the Sybase PdOOM type libraries in the type library references.
'******************************************************************************
'
' This VB Script shows how to delete all private attributes
' in the current OOM model
'
Option Explicit

Sub DeletePrivateAttributes()
    ' PowerDesigner server connection
    ' (it must not be reset until client is over)
    Dim PD As PdCommon.application

    ' Get Application object
    Set PD = CreateObject("PowerDesigner.Application")

    DeleteModelPrivateAttributes PD, PD.ActiveModel
        
    ' Clean up
    Set PD = Nothing
    
End Sub


Function DeleteModelPrivateAttributes(application, model)

   If Not IsObject(model) Then
      application.Output "No model to update: not an object!"
   ElseIf model Is Nothing Then
      application.Output "No model to update."
   ElseIf Not model.IsKindOf(PdOOM.cls_Model) Then
      application.Output "Not a valid Object-Oriented-Model"
   Else

      application.Output "Deleteing all Private Attributes of all Classes in the model..."

      DeleteModelFolderPrivateAttributes application, model, model.GetObjFullName

      application.Output "Done."

   End If

End Function

Function DeleteModelFolderPrivateAttributes(application, fldr, path)

   If IsObject(fldr) And Not (fldr Is Nothing) Then

      ' First delete from current folder,
      DeleteFolderPrivateAttributes application, fldr, path

      ' Then recurse to delete in sub-folders
      Dim subfldr
      For Each subfldr In fldr.Packages
         DeleteModelFolderPrivateAttributes application, subfldr, (path + ", " + subfldr.GetObjFullName)
      Next

   End If

End Function

Function DeleteFolderPrivateAttributes(application, fldr, path)

   If IsObject(fldr) And Not (fldr Is Nothing) Then

      ' Loop to delete in each folder classes
      Dim cls
      For Each cls In fldr.Classes
         DeleteClassPrivateAttributes application, cls, (path + ", " + cls.GetObjFullName)
      Next

   End If

End Function

Function DeleteClassPrivateAttributes(application, cls, path)

   If IsObject(cls) And Not (cls Is Nothing) Then

      ' Loop to delete in each folder classes
      Dim attr
      For Each attr In cls.Attributes

         ' Only delete attribute if visibility is private
         If attr.Visibility = "-" Then
            application.Output "Deleteing: " + path + ", " + attr.GetObjFullName
            attr.Delete
         End If

      Next

   End If

End Function

