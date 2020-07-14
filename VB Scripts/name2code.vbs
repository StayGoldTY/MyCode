'******************************************************************************
'* File:     name2code.vbs
'* Title:    Name to Code Conversion
'* Purpose:  To update existing objects in your model with your current naming
'*           standards based in your model options by executing the Name To Code.
'*
'* Model:    Physical Data Model
'* Objects:  Table, Column, View
'* Category: Naming Standards
'* Author:   Matt Creason - Sr. System Consultant - Sybase, Inc.
'* Created:  Aug 8, 2005
'* Mod By:   
'* Modified: 
'* Version:  1.0
'* Comment:  
'*  v1.0 - Must have Conversion Tables assigned as a model option and
'*         turn on Enable Name/Code Conversion
'******************************************************************************

Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

Dim mdl ' the current model
Dim i

' get the current active model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current Model"
ElseIf Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "The current model is not an Physical Data model."
Else
   ProcessFolder mdl
End If

' This routine copies the name into code for each table, column and view
' of the current folder
Private sub ProcessFolder(folder)
   Dim Tab 'running  table
   Dim rc 'return code

   for each Tab in folder.tables
      if not tab.isShortcut then
         rc = tab.SetNametoCode()
         Dim col ' running column
         for each col in tab.columns
            rc = col.SetNametoCode()
         next
      end if
   next

   Dim view 'running view
   for each view in folder.Views
      if not view.isShortcut then
         rc = view.SetNametoCode()
      end if
   next

   ' go into the sub-packages
   Dim f ' running folder
   For Each f In folder.Packages
      if not f.IsShortcut then
         ProcessFolder f
      end if
   Next
end sub
