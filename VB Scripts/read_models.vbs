'******************************************************************************
'* File:     read_models.vbs
'* Purpose:  Scan model and display objects information
'            going down each package
'* Title:    
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

' get the current active model
Dim mdl ' the current model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no Active Model"
Else
   ListObjects(mdl)
End If

'-----------------------------------------------------------------------------
' Sub procedure to scan current package and print information on objects from current package
' and call again the same sub procedure on all children pacakge 
' of the current package
'-----------------------------------------------------------------------------
Private Sub ListObjects(fldr)
   output "Scanning " & fldr.code
   Dim obj ' running object
   For Each obj In fldr.children
      ' Calling sub procedure to print out information on the object
      DescribeObject obj
   Next

   ' go into the sub-packages
   Dim f ' running folder
   For Each f In fldr.Packages
      'calling sub procedure to scan children package
      ListObjects f
   Next
End Sub

'-----------------------------------------------------------------------------
' Sub procedure to print information on current object in output
'-----------------------------------------------------------------------------
Private Sub DescribeObject(CurrentObject)
   if not CurrentObject.Iskindof(cls_NamedObject) then exit sub
   output "Found "+CurrentObject.ClassName+" """+CurrentObject.Name+""", Created by "+CurrentObject.Creator+" On "+Cstr(CurrentObject.CreationDate)   
End Sub


