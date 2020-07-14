VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} Criteria 
   Caption         =   "Create List of Columns in Excel"
   ClientHeight    =   5628
   ClientLeft      =   36
   ClientTop       =   420
   ClientWidth     =   7020
   OleObjectBlob   =   "Criteria.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "Criteria"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'******************************************************************************
'* Purpose:  This program shows how to use OLE automation to control
'*           PowerDesigner from outside of PowerDesigner.
'*           The program allows you to select an opened PowerDesigner PDM in
'*           PowerDesigner workspace, choose table and column criteria and
'*           table and column attributes to create a customized List of Columns
'*           in Microsoft Excel.
'* Category: VBA, Excel
'* Company:  Sybase, Inc.
'* Author:   Xiao Wang
'* Created:
'* Modified:
'* Version:  1.0
'* Comment:
'******************************************************************************

Option Explicit

' Define PowerDesigner Application object variable
Dim PD As PdCommon.Application

' Table attribute names
Dim tblAttr(20)       As String
' Table attribute headings
Dim tblAttrHead(20)   As String
' Table attribute exported
Dim tblAttrExport(20) As Boolean
' Number of table attributes
Dim nbTblAttr         As Integer

' Column attribute names
Dim colAttr(20)       As String
' Column attribute headings
Dim colAttrHead(20)   As String
' Column attribute exported
Dim colAttrExport(20) As Boolean
' Number of column attributes
Dim nbColAttr         As Integer

' Initialize the form
Private Sub UserForm_Initialize()
   ' Get PowerDesigner Application object
   If PD Is Nothing Then
      Set PD = CreateObject("PowerDesigner.Application")
      If PD Is Nothing Then
         MsgBox "Cannot launch PowerDesigner.  Please verify that PowerDesigner is well installed.  You could try the command: pdshell9.exe /RegServer to register the PowerDesigner application.", vbOKOnly
      End If
   End If
   
   ' Fill list of models
   FillModelList
   
   ' Fill list of column data types
   FillColumnTypeList
   
   ' Fill table & column attributes to be exported
   FillTableAttributes
   FillColumnAttributes

   ' Create a new workbook by default
   AddWorkbook.Value = True
End Sub

' Exit the form
Private Sub UserForm_Terminate()
   Set PD = Nothing
End Sub

' Exit the program
Private Sub ExitButton_Click()
   End
End Sub

' Define exportable table attributes
Sub FillTableAttributes()
   nbTblAttr = 4
   
   ' Table attribute code
   tblAttr(0) = "Name"
   tblAttr(1) = "Code"
   tblAttr(2) = "Comment"
   tblAttr(3) = "Owner"
   
   ' Table attribute name
   tblAttrHead(0) = "Table Name"
   tblAttrHead(1) = "Table Code"
   tblAttrHead(2) = "Table Comment"
   tblAttrHead(3) = "Owner"
   
   ' Export Yes/No
   tblAttrExport(0) = False
   tblAttrExport(1) = True
   tblAttrExport(2) = False
   tblAttrExport(3) = True
   
   ' Fill table attributes list
   Dim n
   For n = 0 To nbTblAttr - 1
      TableAttrs.AddItem tblAttr(n)
      TableAttrs.Selected(n) = tblAttrExport(n)
   Next
   
   TableAttrs.TopIndex = 0
   
End Sub

' Define exportable column attributes
Sub FillColumnAttributes()
   nbColAttr = 11
   
   ' Column attribute code
   colAttr(0) = "Name"
   colAttr(1) = "Code"
   colAttr(2) = "Comment"
   colAttr(3) = "DataType"
   colAttr(4) = "Length"
   colAttr(5) = "Precision"
   colAttr(6) = "Domain"
   colAttr(7) = "Primary"
   colAttr(8) = "ForeignKey"
   colAttr(9) = "Mandatory"
   colAttr(10) = "DefaultValue"
   
   ' Column attribute name
   colAttrHead(0) = "Column Name"
   colAttrHead(1) = "Column Code"
   colAttrHead(2) = "Column Comment"
   colAttrHead(3) = "Data Type"
   colAttrHead(4) = "Length"
   colAttrHead(5) = "Precision"
   colAttrHead(6) = "Domain"
   colAttrHead(7) = "Primary Key"
   colAttrHead(8) = "Foreign Key"
   colAttrHead(9) = "Mandatory"
   colAttrHead(10) = "Default Value"

   ' Export Yes/No
   colAttrExport(0) = False
   colAttrExport(1) = True
   colAttrExport(2) = False
   colAttrExport(3) = True
   colAttrExport(4) = True
   colAttrExport(5) = True
   colAttrExport(6) = True
   colAttrExport(7) = True
   colAttrExport(8) = True
   colAttrExport(9) = True
   colAttrExport(10) = True

   ' Fill column attributes list
   Dim n
   For n = 0 To nbColAttr - 1
      ColumnAttrs.AddItem colAttr(n)
      ColumnAttrs.Selected(n) = colAttrExport(n)
   Next
   
   ColumnAttrs.TopIndex = 0
   
End Sub

' Update table attributes & column attributes
Sub UpdateAttributes()
   Dim n
   For n = 0 To nbTblAttr - 1
      tblAttrExport(n) = TableAttrs.Selected(n)
   Next
   For n = 0 To nbColAttr - 1
      colAttrExport(n) = ColumnAttrs.Selected(n)
   Next
End Sub

' Fill PDM model list
Private Sub FillModelList()
   Dim model As PdCommon.BaseModel
   Dim nbModel
   Dim bFound
   nbModel = 0
   bFound = False
   Models.Clear
   For Each model In PD.Models
      If model.IsKindOf(PdPDM.cls_Model) Then
         Models.AddItem model.code
         If (Not PD.ActiveModel Is Nothing) And (model.ObjectID = PD.ActiveModel.ObjectID) Then
            Models.ListIndex = nbModel
            bFound = True
         End If
         nbModel = nbModel + 1
      End If
   Next
   If nbModel = 0 Then
      Models.AddItem "<None>"
      CreateSheet.Enabled = False
      Models.ListIndex = 0
   Else
      CreateSheet.Enabled = True
      If bFound = False Then
         Models.ListIndex = 0
      End If
   End If
End Sub

' Fill column data type list
Private Sub FillColumnTypeList()
   ColumnTypes.Clear
   ColumnTypes.AddItem "char"
   ColumnTypes.AddItem "varchar"
   ColumnTypes.AddItem "integer"
   ColumnTypes.AddItem "numeric"
   ColumnTypes.AddItem "decimal"
   ColumnTypes.AddItem "short"
   ColumnTypes.AddItem "byte"
   ColumnTypes.AddItem "date"
   ColumnTypes.AddItem "time"
   ColumnTypes.AddItem "datetime"
End Sub

' Refresh PDM model list
Private Sub Refresh_Click()
   ' Fill list of models
   FillModelList
End Sub

' Create spreadsheet in Excel
Private Sub CreateSheet_Click()
   ' Check the selected PDM
   Dim model As PdPDM.Model
   Set model = GetModel()
   If Not model Is Nothing Then
      ' Update table attributes & column attributes selection
      UpdateAttributes
      ' Create spreadsheet
      CreateSpreadsheet
   End If
End Sub

' Create spreadsheet in Excel
Sub CreateSpreadsheet()
   On Error Resume Next
   If AddWorkbook.Value = True Then
      Workbooks.Add
   End If
   ' Export header
   ExportHeader
   ' Export model
   ExportModel
   ' Adjust the columns width
   AdjustColumns
End Sub

' Create headers in Excel
Sub ExportHeader()
   On Error Resume Next
   Dim noCol, n
   noCol = 0
   ' Export table attributes header
   For n = 0 To nbTblAttr - 1
      If tblAttrExport(n) Then
         Range(Chr(65 + noCol) + "1").Value = tblAttrHead(n)
         noCol = noCol + 1
      End If
   Next
   ' Export column attributes header
   For n = 0 To nbColAttr - 1
      If colAttrExport(n) Then
         Range(Chr(65 + noCol) + "1").Value = colAttrHead(n)
         noCol = noCol + 1
      End If
   Next
End Sub

' Export model in Excel
Sub ExportModel()
   On Error Resume Next
   Dim model As PdPDM.Model
   Set model = GetModel()
   If Not model Is Nothing Then
      Dim tbl As PdPDM.Table
      Dim col As PdPDM.Column
      Dim nbRow
      nbRow = 2
      For Each tbl In model.Tables
         If VerifyTableCriteria(tbl) Then
            For Each col In tbl.Columns
               If VerifyColumnCriteria(col) Then
                  ExportRow tbl, col, nbRow
                  nbRow = nbRow + 1
               End If
            Next
         End If
      Next
   End If
End Sub

' Export a column as a row in Excel
Sub ExportRow(tbl, col, nbRow)
   On Error Resume Next
   Dim noCol, n
   noCol = 0
   ' Export table attributes header
   For n = 0 To nbTblAttr - 1
      If tblAttrExport(n) And tbl.HasAttribute(tblAttr(n)) Then
         Range(Chr(65 + noCol) + CStr(nbRow)).Value = tbl.GetAttributeText(tblAttr(n))
         noCol = noCol + 1
      End If
   Next
   ' Export column attributes header
   For n = 0 To nbColAttr - 1
      If colAttrExport(n) And col.HasAttribute(colAttr(n)) Then
         Range(Chr(65 + noCol) + CStr(nbRow)).Value = col.GetAttributeText(colAttr(n))
         noCol = noCol + 1
      End If
   Next
End Sub

' Verify table criteria
Private Function VerifyTableCriteria(tbl) As Boolean
   VerifyTableCriteria = True
   ' Verify code
   If TableCode.Text <> "" Then
      If LCase(Left(tbl.code, Len(TableCode.Text))) <> LCase(TableCode.Text) Then
         VerifyTableCriteria = False
      End If
   End If
End Function

' Verify column criteria
Private Function VerifyColumnCriteria(col) As Boolean
   VerifyColumnCriteria = True
   ' Verify code
   If ColumnCode.Text <> "" Then
      If LCase(Left(col.code, Len(ColumnCode.Text))) <> LCase(ColumnCode.Text) Then
         VerifyColumnCriteria = False
         Exit Function
      End If
   End If
   ' Verify data type
   If ColumnTypes.Text <> "" Then
      Dim n
      Dim sType
      sType = col.DataType
      n = InStr(sType, "(")
      If n > 0 Then
         sType = Left(sType, n - 1)
      End If
      If LCase(sType) <> LCase(ColumnTypes.Text) Then
         VerifyColumnCriteria = False
      End If
   End If
End Function

' Adjust columns width in Excel
Sub AdjustColumns()
   Dim noCol, n
   noCol = 0
   ' Count column numbers
   For n = 0 To nbTblAttr - 1
      If tblAttrExport(n) Then
         noCol = noCol + 1
      End If
   Next
   For n = 0 To nbColAttr - 1
      If colAttrExport(n) Then
         noCol = noCol + 1
      End If
   Next
   
   Columns("A:" + Chr(65 + noCol)).EntireColumn.AutoFit 'To adjust the columns' width.
End Sub

' Get the current selected PDM model in the combobox
Function GetModel() As PdPDM.model
   ' Get selected model code
   On Error Resume Next
   Dim code
   code = Models.Text
   Dim model As PdCommon.BaseModel
   Set GetModel = Nothing
   For Each model In PD.Models
      If model.IsKindOf(PdPDM.cls_Model) And model.code = code Then
         Set GetModel = model
         Exit For
      End If
   Next
   ' Check if the model is valid
   If GetModel Is Nothing Then
      MsgBox "The selected PDM model is no longer valid.", vbExclamation + vbOKOnly
   End If
End Function

