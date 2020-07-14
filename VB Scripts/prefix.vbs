'******************************************************************************
'* File:     prefix.vbs
'* Purpose:  This script adds back a prefix that previous versions of PowerDesigner
'            inserted automatically in front of objects. 
'* Title:    
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************


Option Explicit

Dim mdl ' the current model

' get the current active model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current Model"
ElseIf Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "The current model is not an Physical Data model."
Else
   Dim domn 'current domain
   For each domn in mdl.Domains
      if not domn.IsShortcut then
         if not Left(domn.code,2) = "T_" then
            output "Changing domain code "& domn.code
            domn.Code = "T_" & domn.Code
         end if
      end if
   next
End If


