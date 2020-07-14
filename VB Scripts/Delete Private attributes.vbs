'******************************************************************************
'* File:     Delete Private Attributes.vbs
'* Purpose:  This VB Script shows how to delete all private attributes 
'*           in the current OOM model
'* Title:    Delete Private Attributes
'* Category: Modify Model, Delete Attributes
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Global Variables
'-----------------------------------------------------------------------------
Dim nbAttributs
nbAttributs = 0

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

DeleteModelPrivateAttributes(ActiveModel)


'-----------------------------------------------------------------------------
' Delete private attributes of a model
'-----------------------------------------------------------------------------
Function DeleteModelPrivateAttributes(model)

   If Not IsObject(model) Then
      Output "The current selection is not a model."
   ElseIf model Is Nothing Then
      Output "There is no current model."
   ElseIf Not Model.IsKindOf(PDOom.cls_Model) Then
      Output "The current model is not an Object-Oriented-Model."
   Else

      Output "Deleteing all Private Attributes of all Classes in the model..."

      DeleteModelFolderPrivateAttributes model, model.GetObjFullName

      Output "Done.  " + CStr(nbAttributs) + " attribute(s) deleted."

   End If

End Function

'-----------------------------------------------------------------------------
' Delete private attributes of a folder and its subfolders
'-----------------------------------------------------------------------------
Function DeleteModelFolderPrivateAttributes(fldr, path)

   If IsObject(fldr) And Not(fldr Is Nothing) Then

      ' First delete from current folder,
      DeleteFolderPrivateAttributes fldr, path

      ' Then recurse to delete in sub-folders
      Dim subfldr
      For Each subfldr In fldr.Packages
         If Not subfldr.IsShortcut Then
            DeleteModelFolderPrivateAttributes subfldr, (path + ", " + subfldr.GetObjFullName)
         End If
      Next

   End If

End Function

'-----------------------------------------------------------------------------
' Delete private attributes of classes in a folder
'-----------------------------------------------------------------------------
Function DeleteFolderPrivateAttributes(fldr, path)

   If IsObject(fldr) And Not(fldr Is Nothing) Then

      ' Loop to delete in each folder classes
      Dim cls
      For Each cls In fldr.Classes
         If Not cls.IsShortcut Then
            DeleteClassPrivateAttributes cls, (path + ", " + cls.GetObjFullName)
         End If
      Next

   End If

End Function

'-----------------------------------------------------------------------------
' Delete private attributes of a class
'-----------------------------------------------------------------------------
Function DeleteClassPrivateAttributes(cls, path)

   If IsObject(cls) And Not(cls Is Nothing) Then

      ' Loop to delete in each folder classes
      Dim attr
      For Each attr In cls.Attributes

         If Not attr.IsShortcut Then 
            ' Only delete attribute if visibility is private
            If attr.Visibility = "-" Then
               Output "Deleteing: " + path + ", " + attr.GetObjFullName
               attr.Delete
               nbAttributs = nbAttributs + 1
            End If
         End If
         
      Next

   End If

End Function
