'******************************************************************************
'* File:     BPM-CDM.vbs
'* Purpose:  Convert a BPM into a CDM model containing one entities for each ressource
'            External shortcuts are lost.
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************
         

Option Explicit
ValidationMode = false
InteractiveMode = im_Batch

Const Debugging = false 'constant to display debug string

' get the current active model
Dim mdl ' the current model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current model"
ElseIf Not mdl.IsKindOf(PdBPM.cls_Model) Then
   MsgBox "The current model is not an Business Process model."
Else
   dim Actmdl 'CDM model
   Set actmdl = createmodel(pdcdm.cls_model)

   CopyObjectProperties mdl, actmdl
   '
   ' Business rules
   '

   Dim Map 'Object map
   Set Map = CreateObject("Scripting.Dictionary")

   Dim br
   
   for each br in mdl.BusinessRules
      if not br.isshortcut then
         if Debugging then output "Copy Busines Rule " & br.name end if 
         Dim rbr
         set rbr=actmdl.BusinessRules.createnew

         CopyObjectProperties br, rbr

         'specific attribute copy
         rbr.Type = br.Type
         rbr.ClientExpression = br.ClientExpression
         rbr.ServerExpression = br.ServerExpression

         Map.add br, rbr 'Fill map with BR
         
      end if
   next

   ' Resources
   '    
   ' Resources are transformed into entities 
   
   Dim r 'Resources
   for each r in mdl.Resources
      if not r.isshortcut then
         if Debugging then output "Transform resource " & r.name end if 
         Dim rr
         set rr=actmdl.Entities.createnew

         CopyObjectProperties r, rr
         AttachBR r, rr

      end if
   next

  
End If


'-----------------------------------------------------------------------------
' Attach the BR of the source object to the target object
'-----------------------------------------------------------------------------
Private sub attachBR (objs,objt)
   Dim brs
   Dim brt
   For Each brs in objs.AttachedRules
      set brt = Map.item(brs)
      if not brt is nothing then
          objt.attachedrules.add (brt)
      end if
   next

end sub


'-----------------------------------------------------------------------------
' Display class name and name for an object (debugging function)
'-----------------------------------------------------------------------------
Function Disp (obj)
   output obj.classname & "  " & obj.name 
end function

'-----------------------------------------------------------------------------
' Copy the common properties of a source object into a target object
'-----------------------------------------------------------------------------
Private Sub CopyObjectProperties (S, T)
         T.Code = S.Code
         T.Name = S.Name
         T.Description = S.Description
         T.Annotation = S.Annotation      
         T.Comment = S.Comment
         T.ExtendedAttributesText = S.ExtendedAttributesText
         T.Stereotype = S.Stereotype
         
End Sub

