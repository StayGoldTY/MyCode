'******************************************************************************
'* File:     CreateOOM.bas
'* Purpose:  This VBA program shows how to create a new OOM model
'* Title:    Create a new OOM
'* Category: Create Model
'* Company:  Sybase Inc.
'* Author:   
'* Created:  
'* Modified: 
'* Version:  1.0
'* Comment:  You can use Word, Excel, Visual Basic or any other program that supports VBA to execute this program.
'*           You need to add the Sybase PdCommon and the Sybase PdOOM type libraries in the type library references.
'******************************************************************************

Option Explicit

Sub CreateOOM()
    ' PowerDesigner server connection
    ' (it must not be reset until client is over)
    Dim PD As PdCommon.application

    ' Get Application object
    Set PD = CreateObject("PowerDesigner.Application")

    ' Set interactive mode to Batch
    PD.InteractiveMode = im_Batch

    ' Create an OOM model and a class diagram
    Dim model As PdOOM.model
    Set model = PD.CreateModel(PdOOM.cls_Model, "|Diagram=ClassDiagram")
    model.Name = "Customer Management"
    model.Code = "CustomerManagement"

    ' Create a class diagram
    Dim diagram As PdOOM.ClassDiagram
    Set diagram = model.ClassDiagrams.Item(0)

    ' Create classes
    CreateClasses model, diagram
    
    ' Clean up
    Set PD = Nothing
    
End Sub

' Create classes function
Function CreateClasses(model, diagram)
   ' Create a class
   Dim cls As PdOOM.Class
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
   Dim sym As Object
   Set sym = diagram.AttachObject(cls)

   CreateClasses = True
End Function

' Create attributes function
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

' Create operations function
Function CreateOperations(cls)
   Dim oper
   Set oper = cls.CreateObject(PdOOM.cls_Operation)
   oper.Name = "GetName"
   oper.Code = "GetName"
   oper.ReturnType = "String"
   Dim body As String
   body = "{" + vbCrLf
   body = body + "   return Name;" + vbCrLf
   body = body + "}"
   oper.body = body

   Set oper = cls.CreateObject(PdOOM.cls_Operation)
   oper.Name = "SetName"
   oper.Code = "SetName"
   oper.ReturnType = "void"
   Dim param As PdOOM.Parameter
   Set param = oper.CreateObject(PdOOM.cls_Parameter)
   param.Name = "newName"
   param.Code = "newName"
   param.DataType = "String"
   body = "{" + vbCrLf
   body = body + "   Name = newName;" + vbCrLf
   body = body + "}"
   oper.body = body

   CreateOperations = True
End Function
