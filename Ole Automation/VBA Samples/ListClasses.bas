Attribute VB_Name = "Module2"
'******************************************************************************
'* File:     ListClasses.bas
'* Purpose:  This VBA pogram shows how to display properties of classes defined in
'*           the model and subpackages in the output window for the current active OOM.
'*           It also shows how to convert RTF description into ASCII text.
'* Title:    Show class properties in output window
'* Category: Show class properties
'* Company:  Sybase Inc.
'* Author:
'* Created:
'* Modified:
'* Version:  1.0
'* Comment:  You can use Word, Excel, Visual Basic or any other program that supports VBA to execute this program.
'*           You need to add the Sybase PdCommon and the Sybase PdOOM type libraries in the type library references.
'******************************************************************************

Option Explicit

Sub ListClasses()

    ' PowerDesigner server connection
    ' (it must not be reset until client is over)
    Dim PD As PdCommon.application

    ' Get Application object
    Set PD = CreateObject("PowerDesigner.Application")
    If Not PD Is Nothing Then
       ' Get the current active model
       Dim model As PdCommon.BaseModel
       Set model = PD.ActiveModel
       If model Is Nothing Then
          MsgBox "There is no current model."
       ElseIf Not model.IsKindOf(PdOOM.cls_Model) Then
          MsgBox "The current model is not an OOM model."
       Else
          ' Get the Classes collection
          Dim ModelClasses
          Set ModelClasses = model.Classes
          PD.Output "The model '" + model.Name + "' contains " + CStr(ModelClasses.Count) + " classes."
          PD.Output ""
       
          ShowProperties PD, model
       End If
    
       ' Clean Up
       Set PD = Nothing
    Else
       MsgBox "Cannot launch PowerDesigner."
    End If

End Sub

' Show properties of classes
Sub ShowProperties(PD, package)
   ' Show classes of the current model/package
   Dim cls
   Dim noClass
   noClass = 1
   ' For each class
   For Each cls In package.Classes
      ShowClass PD, cls, noClass
      noClass = noClass + 1
   Next
   
   ' Show classes in the sub-packages
   Dim subpackage
   For Each subpackage In package.Packages
      ShowProperties PD, subpackage
   Next
   
End Sub

' Show class properties
Sub ShowClass(PD, cls, noClass)
   If IsObject(cls) Then
      ' Show properties
      PD.Output "================================"
      PD.Output "Class " + CStr(noClass) + ":"
      PD.Output "================================"
      PD.Output "ObjectID: " + cls.ObjectID
      PD.Output "Name: " + cls.Name
      PD.Output "Code: " + cls.Code
      If IsObject(cls.parent) Then
         PD.Output "Parent: " + cls.parent.Name
      Else
         PD.Output "Parent: " + "<None>"
      End If
      PD.Output "DisplayName: " + cls.DisplayName
      PD.Output "ObjectType: " + cls.ObjectType
      PD.Output "CreationDate: " + CStr(cls.CreationDate)
      PD.Output "Creator: " + cls.Creator
      PD.Output "ModificationDate: " + CStr(cls.ModificationDate)
      PD.Output "Modifier: " + cls.Modifier
      PD.Output "Comment: " + cls.Comment
      PD.Output "Description: " + PD.Rtf2Ascii(cls.Description)
      PD.Output "Preview: " + cls.Preview
      PD.Output ""

      ' Show attributes
      ShowAttributes PD, cls

      ' Show operations
      ShowOperations PD, cls

   Else
      MsgBox "It is not an object!"
   End If
End Sub

' Show class attributes
Sub ShowAttributes(PD, cls)
   Dim attr
   Dim noAttr
   noAttr = 1
   If IsObject(cls) Then
      For Each attr In cls.Attributes
         PD.Output "   Attribute " + CStr(noAttr) + ":"
         PD.Output "   --------------------------------"
         PD.Output "   Name: " + attr.Name
         PD.Output "   Code: " + attr.Code
         If IsObject(attr.parent) Then
            PD.Output "   Parent: " + attr.parent.Name
         Else
            PD.Output "   Parent: " + "<None>"
         End If
         PD.Output "   DateType: " + attr.DataType
         PD.Output "   Persistent: " + CStr(attr.Persistent)
         PD.Output "   PersistentDataType: " + attr.PersistentDataType
         PD.Output "   PersistentLength: " + CStr(attr.PersistentLength)
         PD.Output "   Comment: " + attr.Comment
         PD.Output "   Description: " + PD.Rtf2Ascii(attr.Description)
         PD.Output ""
         noAttr = noAttr + 1
      Next
   End If
End Sub

' Show class operations
Sub ShowOperations(PD, cls)
   Dim oper
   Dim noOper
   noOper = 1
   If IsObject(cls) Then
      For Each oper In cls.Operations
         PD.Output "   Operation " + CStr(noOper) + ":"
         PD.Output "   --------------------------------"
         PD.Output "   Name: " + oper.Name
         PD.Output "   Code: " + oper.Code
         If IsObject(oper.parent) Then
            PD.Output "   Parent: " + oper.parent.Name
         Else
            PD.Output "   Parent: " + "<None>"
         End If
         PD.Output "   Visibility: " + oper.Visibility
         PD.Output "   RetunType: " + oper.ReturnType
         PD.Output "   Signature: " + oper.Signature
         PD.Output "   Body: " + oper.body
         PD.Output "   Comment: " + oper.Comment
         PD.Output "   Description: " + PD.Rtf2Ascii(oper.Description)
         PD.Output ""
         noOper = noOper + 1
      Next
   End If
End Sub

