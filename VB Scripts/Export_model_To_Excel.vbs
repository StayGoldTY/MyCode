'******************************************************************************
'* File:     Export_model_to_excel.vbs
'* Purpose:  Scan CDM Model and display objects information
'            Export object desc to Excel
'* Title:    
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit


Dim nb
'
' get the current active model
'
Dim mdl ' the current model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no Active Model"
End If
Dim fldr
Set Fldr = ActiveDiagram.Parent
nb =2
Dim HaveExcel
Dim RQ
RQ = MsgBox ("Is Excel Installed on your machine ?", vbYesNo + vbInformation,"Confirmation")
if RQ= VbYes then
   HaveExcel= True
   ' Open & Create Excel Document
   Dim x1  '
   Set x1 = CreateObject("Excel.Application") 
   x1.Visible = True 
   x1.Workbooks.Add
   x1.Range("A1").Value = "Class Name"
   x1.Range("B1").Value = "Object Name"
   x1.Range("C1").Value = "Object Creator"
   x1.Range("D1").Value = "Creation date"    


else
   HaveExcel= false
end if


ListObjects(fldr)
if HaveExcel= True Then '
      x1.Columns("A:D").EntireColumn.AutoFit 'To adjust the 
      'column's width.
end if   

Sub ListObjects(fldr)
   Dim obj ' running object
   For Each obj In fldr.children
      DescribeObject obj
   Next

   ' go into the sub-packages
   Dim f ' running folder
   For Each f In fldr.Packages
      ListObjects f
   Next
End Sub


Sub DescribeObject(CurrentObject)
   if CurrentObject.ClassName ="Association-Class link" then exit sub
   'Export informations to the output list
   output "Found "+CurrentObject.ClassName+" "+CurrentObject.Name+", Created by "+CurrentObject.Creator+" On "+mid(Cstr(CurrentObject.CreationDate),1,10)   
   if HaveExcel= True Then 'Export informations to Excel document      
      x1.Range("A"+Cstr(nb)).Value = CurrentObject.ClassName
      x1.Range("B"+Cstr(nb)).Value = CurrentObject.Name    
      x1.Range("C"+Cstr(nb)).Value = CurrentObject.Creator    
      x1.Range("D"+Cstr(nb)).Value = mid(Cstr(CurrentObject.CreationDate),1,10)    
      nb = nb+1
   end if
End Sub


