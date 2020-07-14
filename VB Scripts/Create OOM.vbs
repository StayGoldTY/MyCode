'******************************************************************************
'* File:     Create OOM.vbs
'* Purpose:  This VB Script shows how to create a new OOM model
'* Title:    Create a new OOM
'* Category: Create Model
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Initialization
'-----------------------------------------------------------------------------
' Set interactive mode to Batch
InteractiveMode = im_Batch

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

' Create an OOM model with a class diagram
Dim Model
Set model = CreateModel(PdOOM.cls_Model, "|Diagram=ClassDiagram")
model.Name = "Customer Management"
model.Code = "CustomerManagement"

' Get the class diagram
Dim diagram
Set diagram = model.ClassDiagrams.Item(0)

' Create classes
CreateClasses model, diagram


'-----------------------------------------------------------------------------
' Create classes function
'-----------------------------------------------------------------------------
Function CreateClasses(model, diagram)
   ' Create a class
   Dim cls
   Set cls = model.CreateObject(PdOOM.cls_Class)
   cls.Name = "Customer"
   cls.Code = "Customer"
   cls.Comment = "Customer class"
   cls.Stereotype = "Class"
   cls.Description = "The customer class defines the attributes and behaviors of a customer."

   ' Create attributes
   CreateAttributes cls
   ' Create methods
   CreateOperations cls

   ' Create a symbol for the class
   Dim sym
   Set sym = diagram.AttachObject(cls)

   CreateClasses = True
End Function

'-----------------------------------------------------------------------------
' Create attributes function
'-----------------------------------------------------------------------------
Function CreateAttributes(cls)
   Dim attr
   Set attr = cls.CreateObject(PdOOM.cls_Attribute)
   attr.Name = "ID"
   attr.Code = "ID"
   attr.DataType = "int"
   attr.Persistent = True
   attr.PersistentCode = "ID"
   attr.PersistentDataType = "I"
   attr.PrimaryIdentifier = True

   Set attr = cls.CreateObject(PdOOM.cls_Attribute)
   attr.Name = "Name"
   attr.Code = "Name"
   attr.DataType = "String"
   attr.Persistent = True
   attr.PersistentCode = "NAME"
   attr.PersistentDataType = "A30"

   Set attr = cls.CreateObject(PdOOM.cls_Attribute)
   attr.Name = "Phone"
   attr.Code = "Phone"
   attr.DataType = "String"
   attr.Persistent = True
   attr.PersistentCode = "PHONE"
   attr.PersistentDataType = "A20"

   Set attr = cls.CreateObject(PdOOM.cls_Attribute)
   attr.Name = "Email"
   attr.Code = "Email"
   attr.DataType = "String"
   attr.Persistent = True
   attr.PersistentCode = "EMAIL"
   attr.PersistentDataType = "A30"

   CreateAttributes = True
End Function

'-----------------------------------------------------------------------------
' Create operations function
'-----------------------------------------------------------------------------
Function CreateOperations(cls)
   Dim oper
   Set oper = cls.CreateObject(PdOOM.cls_Operation)
   oper.Name = "GetName"
   oper.Code = "GetName"
   oper.ReturnType = "String"
   Dim body
   body = "{" + vbCrLf
   body = body + "   return Name;" + vbCrLf
   body = body + "}"
   oper.Body = body

   Set oper = cls.CreateObject(PdOOM.cls_Operation)
   oper.Name = "SetName"
   oper.Code = "SetName"
   oper.ReturnType = "void"
   Dim param
   Set param = oper.CreateObject(PdOOM.cls_Parameter)
   param.Name = "newName"
   param.Code = "newName"
   param.DataType = "String"
   body = "{" + vbCrLf
   body = body + "   Name = newName;" + vbCrLf
   body = body + "}"
   oper.Body = body

   CreateOperations = True
End Function

