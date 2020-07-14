'******************************************************************************
'* File:     code2name.vbs
'* Title:    Code to Name Conversion
'* Purpose:  To 
'
'* Model:    Physical Data Model
'* Category: Naming Standards
'* Author:   Matt Creason - Sr. System Consultant - Sybase, Inc.
'* Created:  Apr 8, 2005
'* Mod By:   
'* Modified: 
'* Version:  1.0
'* Comment:  
'*  v1.0 - Must have Conversion Tables assigned as a model option
'******************************************************************************


Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

Dim mdl ' the current model
Dim opt ' model options

' get the current active model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current Model"
ElseIf Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "The current model is not an Physical Data model."
Else
   Set opt = mdl.GetModelOptions()
   opt.EnableNameCodeTranslation = true
   opt.save
   opt.UpdateModelOptions ' need to call this you have made changes
   ProcessFolder 
End If

' This routine transform code into name for each table, each column of the current folder
Private sub ProcessFolder
   Dim obj, tbl, col
   for each tbl in mdl.Tables
      Dim codeToName, cTN
      for each codeToName in opt.CodeNamingConventions
         if (codeToName.Name = tbl.ObjectType) then
            output "Converting " + codeToName.Name + " " + tbl.Code + " code to name using " + codeToName.Script
            tbl.Name = tbl.EvaluateText(codeToName.Script)
            for each col in tbl.Columns
               for each cTN in opt.CodeNamingConventions
                  if (cTN.Name = col.ObjectType) then
                     output "Converting " + cTN.Name + " " + col.Code + " code to name using " + cTN.Script
                     col.Name = col.EvaluateText(cTN.Script)
                  end if
               next
            next
         end if
      next
   next
end sub
