'******************************************************************************
'* File:     Checkmodel.vbs
'* Purpose:  Show how to use check model function
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************
option explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

' Get the current active model
Dim model
Set model = ActiveModel
If (model Is Nothing) Or (Not model.IsKindOf(PdOOM.cls_Model)) Then
   MsgBox "The current model is not a OOM model."
Else
   TestModel model
End If


'-----------------------------------------------------------------------------
' Run specific check on current model
'-----------------------------------------------------------------------------

Sub TestModel(obj)
   Output obj.Name

   'access package option and check controller
   Dim PkgOpts : Set PkgOpts = obj.GetPackageOptions()
   Dim ChkCtrl : Set ChkCtrl = PkgOpts.GetCheckModelControler()
   
   ' Parse all available checks to select the ones we want to execute
   ' the check we want to execute is the "Empty classifier" check on class
   '
   Output ChkCtrl.ShortDescription
   dim ChkCateg, ChkCheck, ChkMssg
   For each ChkCateg in ChkCtrl.Categories
      output "  " & ChkCateg.ShortDescription
      ' test the name of the category
      ' category names can be found in check model dialog
      if (ChkCateg.Name = "Class") then
         For each ChkCheck in ChkCateg.Checks
            output "     " & ChkCheck.ShortDescription
            ' test the name of the check
            ' check names can be found in check model dialog
            if (ChkCheck.Name = "Empty classifier") then
               ChkCheck.AutoCorrect = 1
               ChkCheck.Execution = 1
            else
               ChkCheck.Execution = 0
            end if
         next
      else
         For each ChkCheck in ChkCateg.Checks
            ChkCheck.Execution = 0
         next
      end if
   next

   ' Execute check model method
   obj.CheckModel
end sub