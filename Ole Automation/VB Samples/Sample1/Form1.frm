VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "PowerDesigner OLE Automation Demo"
   ClientHeight    =   2385
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5145
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2385
   ScaleWidth      =   5145
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Exit 
      Caption         =   "&Exit"
      Height          =   375
      Left            =   3480
      TabIndex        =   2
      Top             =   1935
      Width           =   1575
   End
   Begin VB.CommandButton Use 
      Caption         =   "Show OOM &Info"
      Height          =   375
      Left            =   1800
      TabIndex        =   1
      Top             =   1920
      Width           =   1575
   End
   Begin VB.CommandButton Create 
      Caption         =   "&Create an OOM"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   1920
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   $"Form1.frx":0000
      Height          =   1695
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   4935
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'******************************************************************************
'* Purpose:  This program shows how to use OLE automation and Visual Basic
'*           to control PowerDesigner from outside of PowerDesigner.
'*           You can use any language that supports COM.
'*           This program displays information about the current OOM model
'*           in the PowerDesigner output window.
'* Company:  Sybase Inc.
'* Category: VBA, Excel
'* Company:  Sybase, Inc.
'* Author:   Xiao Wang
'* Created:
'* Modified:
'* Version:  1.0
'* Comment:
'******************************************************************************

Option Explicit

' PowerDesigner server connection (it must not be reset until client is over)
Dim PD As PdCommon.Application

Private Sub Create_Click()

    ' Create an OOM model
    Dim model As PdOOM.model
    
    PD.Output ""
    PD.Output "Creating a new OOM model..."
    
    Set model = PD.CreateModel(PdOOM.cls_Model)
    PD.Output "   Created model name:" + model.Name

    ' Create a class within model
    PD.Output "Creating a new class..."
    Dim clss As PdOOM.Class
    Set clss = model.CreateObject(PdOOM.cls_Class)
    clss.Name = "customer"
    clss.Code = "customer"
    PD.Output "   Created class code:" + clss.Code
    
    ' Create an attribute in the class
    PD.Output "Creating a new attribute..."
    Dim attr As PdOOM.Attribute
    Set attr = clss.CreateObject(PdOOM.cls_Attribute)
    attr.Name = "customer name"
    attr.Code = "name"
    PD.Output "   Created attribute code:" + attr.Code
    
    ' Show symbol
    model.DefaultDiagram.AttachObject clss
    
    ' Clean up
    Set model = Nothing
    
    PD.Output "Done."
    MsgBox "Successfully created a PowerDesigner OOM.", vbOKOnly
    
End Sub

Private Sub Exit_Click()
   End
End Sub

Private Sub Form_Load()
    On Error Resume Next
    
    ' Create Application object
    If PD Is Nothing Then
        PD = CreateObject("PowerDesigner.Application.16.5")
        If PD Is Nothing Then
            MsgBox "Cannot launch PowerDesigner.  Please verify that PowerDesigner is well installed.", vbOKOnly
            Me.Exit = True
        End If
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    ' Drop the Application object LAST!
    Set PD = Nothing
    
End Sub

Private Sub Use_Click()
    
    Dim model As PdCommon.BaseModel
    Set model = PD.ActiveModel
    
    PD.Output ""
    If model Is Nothing Then
       MsgBox "There is no current OOM model.", vbOKOnly
       Exit Sub
    End If
    
    If Not model.IsKindOf(PdOOM.cls_Model) Then
       MsgBox "The current model is not an OOM model", vbOKOnly
       Exit Sub
    End If
    
    PD.Output "The current OOM model is " + model.Name + "."
    Dim c As PdOOM.Class
    If model.Classes.Count() > 0 Then
       Set c = model.Classes.Item(0)
       PD.Output "This OOM model contains " + CStr(model.Classes.Count()) + " classe(s)."
       PD.Output "The first class of the model is " + c.Name + "."
    Else
       PD.Output "The current OOM does not contain class defined under the model."
    End If
    
    If (PD.ActiveSelection.Count > 0) Then
       PD.Output "Selected object(s):"
       Dim obj As PdCommon.BaseObject
       For Each obj In PD.ActiveSelection
          PD.Output obj.ObjectType + " " + obj.Name + " (" + obj.Code + ")"
       Next
    Else
       PD.Output "There is no selected object."
    End If
    
    MsgBox "You can go to PowerDesigner to see the result in the output Window.", vbOKOnly
End Sub
