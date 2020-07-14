'******************************************************************************
'* File:     Form1.vb
'* Purpose:  This program shows how to create a PowerDesigner PDM model using VB .NET
'* Title:    Create OOM model
'* Category: Create OOM
'* Company:  Sybase Inc.
'* Author:   Xiao Wang   
'* Created:  
'* Modified: 
'* Version:  1.0
'* Comment:  You need to add the Sybase PdCommon and the Sybase PdOOM type libraries in the type library references.
'*           You need to define the contants for the object kinds you need to use.
'******************************************************************************

Public Class Form1
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents Button1 As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(143, 138)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(133, 40)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "&Create OOM"
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(287, 138)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(133, 40)
        Me.Button2.TabIndex = 1
        Me.Button2.Text = "Exit"
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(10, 10)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(400, 89)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "This program shows how to use VB .NET and OLE automation to create a PowerDesigne" & _
        "r OOM."
        '
        'Form1
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(6, 15)
        Me.ClientSize = New System.Drawing.Size(430, 186)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Label1, Me.Button2, Me.Button1})
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "Form1"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "VB .NET for PowerDesigner Sample1"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        ' Get PowerDesigner Application object
        Dim pd As PdCommon.Application
        Try
            pd = CreateObject("PowerDesigner.Application.16.5")
            ' Create an OOM model with a class diagram
            Dim model As PdOOM.Model
            model = pd.CreateModel(PdOOM.PdOOM_Classes.cls_Model, "|Diagram=ClassDiagram")
            model.Name = "Customer Management"
            model.Code = "CustomerManagement"

            ' Create a class diagram
            Dim diagram As PdOOM.ClassDiagram
            diagram = model.ClassDiagrams.Item(0)

            ' Create classes
            CreateClasses(model, diagram)

            MsgBox("Successfully created a PowerDesigner OOM model.", MsgBoxStyle.OKOnly)
        Catch ex As Exception
            MsgBox("Cannot create PowerDesigner application object.  Please verify that PowerDesigner is installed and the PowerDesigner application object is registered.", MsgBoxStyle.OKOnly)
        End Try

    End Sub

    ' Create classes function
    Function CreateClasses(ByVal model As PdOOM.Model, ByVal diagram As PdOOM.ClassDiagram)
        ' Create a class
        Dim cls As PdOOM.Class

        cls = model.Classes.CreateNew
        cls.Name = "Customer"
        cls.Code = "Customer"
        cls.Comment = "Customer class"
        cls.Stereotype = "Class"
        cls.Description = "The customer class defines the attributes and behaviors of a customer."

        ' Create attributes
        CreateAttributes(cls)
        ' Create methods
        CreateOperations(cls)

        ' Create a symbol for the class
        Dim sym As Object
        sym = diagram.AttachObject(cls)

        Return True
    End Function

    ' Create attributes function
    Function CreateAttributes(ByVal cls As PdOOM.Class)
        Dim attr As PdOOM.Attribute
        attr = cls.Attributes.CreateNew
        attr.Name = "ID"
        attr.Code = "ID"
        attr.DataType = "int"
        attr.Persistent = True
        attr.PersistentCode = "ID"
        attr.PersistentDataType = "I"
        attr.PrimaryIdentifier = True

        attr = cls.Attributes.CreateNew
        attr.Name = "Name"
        attr.Code = "Name"
        attr.DataType = "String"
        attr.Persistent = True
        attr.PersistentCode = "NAME"
        attr.PersistentDataType = "A30"

        attr = cls.Attributes.CreateNew
        attr.Name = "Phone"
        attr.Code = "Phone"
        attr.DataType = "String"
        attr.Persistent = True
        attr.PersistentCode = "PHONE"
        attr.PersistentDataType = "A20"

        attr = cls.Attributes.CreateNew
        attr.Name = "Email"
        attr.Code = "Email"
        attr.DataType = "String"
        attr.Persistent = True
        attr.PersistentCode = "EMAIL"
        attr.PersistentDataType = "A30"

        Return True
    End Function

    ' Create operations function
    Function CreateOperations(ByVal cls As PdOOM.Class)
        Dim oper As PdOOM.Operation
        oper = cls.Operations.CreateNew
        oper.Name = "GetName"
        oper.Code = "GetName"
        oper.ReturnType = "String"
        Dim body As String
        body = "{" + vbCrLf
        body = body + "   return Name;" + vbCrLf
        body = body + "}"
        oper.Body = body

        oper = cls.Operations.CreateNew
        oper.Name = "SetName"
        oper.Code = "SetName"
        oper.ReturnType = "void"
        Dim param As PdOOM.Parameter
        param = oper.Parameters.CreateNew
        param.Name = "newName"
        param.Code = "newName"
        param.DataType = "String"
        body = "{" + vbCrLf
        body = body + "   Name = newName;" + vbCrLf
        body = body + "}"
        oper.Body = body

        Return True
    End Function

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        ' Exit program
        End
    End Sub
    Friend WithEvents Button2 As System.Windows.Forms.Button

    Private Sub Label1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label1.Click

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
