'******************************************************************************
'* File:     List Classes.vbs
'* Purpose:  This VB Script shows how to display properties of classes defined in 
'*           the model and subpackages in the output window for the current active OOM.
'*           It also shows how to convert RTF description into ASCII text.
'* Title:    Show class properties in output window
'* Category: Show class properties
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
   ' Get the Classes collection
   Dim ModelClasses
   Set ModelClasses = Model.Classes
   Output "The model '" + Model.Name + "' contains " + CStr(ModelClasses.Count) + " classes."
   Output ""
   
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
      ShowClass cls, noClass
      noClass = noClass + 1
   Next
   
   ' Show classes in the sub-packages
   Dim subpackage
   For Each subpackage In package.Packages
      If Not subpackage.IsShortcut Then
         ShowProperties subpackage
      ElseIf Not subpackage.External Then
         ' Accept internal shortcut of packages
         ShowProperties subpackage
      End If
   Next
   
End Sub

'-----------------------------------------------------------------------------
' Show class properties
'-----------------------------------------------------------------------------
Sub ShowClass(cls, noClass)
   If IsObject(cls) Then
      Dim bShortcutClosed
      bShortcutClosed = false
      If cls.IsShortcut Then
      	 If Not (cls.TargetObject Is Nothing) Then
            ' Show properties of the target class
            Set cls = cls.TargetObject
         Else
            ' The target model is not opened (closed or not found)
            bShortcutClosed = true
         End If
      End If
   
      ' Show properties
      Output "================================"
      Output "Class " + CStr(noClass) + ":"
      Output "================================"
      If Not bShortcutClosed Then
         Output "ObjectID: "   + cls.ObjectID
         Output "Name: "       + cls.Name
         Output "Code: "       + cls.Code
         If IsObject(cls.Parent) Then
            Output "Parent: "  + cls.Parent.Name
         Else
            Output "Parent: "  + "<None>"
         End If
         Output "DisplayName: " + cls.DisplayName
         Output "ObjectType: " + cls.ObjectType
         Output "CreationDate: " + CStr(cls.CreationDate)
         Output "Creator: "    + cls.Creator
         Output "ModificationDate: " + CStr(cls.ModificationDate)
         Output "Modifier: "   + cls.Modifier
         Output "Comment: "    + cls.Comment
         Output "Description: "    + Rtf2Ascii(cls.Description)
         Output "Preview: " + cls.Preview
         Output ""

         ' Show attributes
         ShowAttributes cls

         ' Show operations
         ShowOperations cls
      Else
         Output "The target class of the shortcut " + cls.Code + " is not accessible."
         Output ""
      End If
   End If
End Sub

'-----------------------------------------------------------------------------
' Show class attributes
'-----------------------------------------------------------------------------
Sub ShowAttributes(cls)
   Dim noAttr
   noAttr = 1
   If IsObject(cls) Then
      Dim attr
      For Each attr In cls.Attributes
         If Not attr.IsShortcut Then
            Output "   Attribute " + CStr(noAttr) + ":"
            Output "   --------------------------------"
            Output "   Name: "       + attr.Name
            Output "   Code: "       + attr.Code
            If IsObject(attr.Parent) Then
               Output "   Parent: "  + attr.Parent.Name
            Else
               Output "   Parent: "  + "<None>"
            End If
            Output "   DateType: " + attr.DataType
            Output "   Persistent: " + CStr(attr.Persistent)
            Output "   PersistentDataType: " + attr.PersistentDataType
            Output "   PersistentLength: " + CStr(attr.PersistentLength)
            Output "   Comment: "    + attr.Comment
            Output "   Description: " + Rtf2Ascii(attr.Description)
            Output ""
            noAttr = noAttr + 1
         End If
      Next
   End If
End Sub

'-----------------------------------------------------------------------------
' Show class operations
'-----------------------------------------------------------------------------
Sub ShowOperations(cls)
   Dim noOper
   noOper = 1
   If IsObject(cls) Then
      Dim oper
      For Each oper In cls.Operations
         If Not oper.IsShortcut Then
            Output "   Operation " + CStr(noOper) + ":"
            Output "   --------------------------------"
            Output "   Name: "       + oper.Name
            Output "   Code: "       + oper.Code
            If IsObject(oper.Parent) Then
               Output "   Parent: "  + oper.Parent.Name
            Else
               Output "   Parent: "  + "<None>"
            End If
            Output "   Visibility: " + oper.Visibility
            Output "   RetunType: " + oper.ReturnType
            Output "   Signature: " + oper.Signature
            Output "   Body: " + oper.Body
            Output "   Comment: "    + oper.Comment
            Output "   Description: " + Rtf2Ascii(oper.Description)
            Output ""
            noOper = noOper + 1
         End If
      Next
   End If
End Sub
