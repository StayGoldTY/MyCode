' 
' This sample VBSCript shows how to reverse engineering a database using a SQL script 
' in an existing PDM model
'

option explicit

' SQL script file name 
const sScrptFile = "d:\tmp\crebas.sql"

' Reverse engineer in the current model
ReverseEngineerScript ActiveModel

Sub ReverseEngineerScript(model)

   If (model is Nothing) then
      output "There is no current Physical Data Model."
      Exit Sub
   End If

   ' Set interactive mode to batch to bypass the reverse engineering and merge windows
   InteractiveMode = im_Batch

   ' Get the generation/reverse engineering option of the model
   Dim opt
   Set opt = model.GetPackageOptions()

   ' Set reverse engineer mode to script file
   opt.ReversedScript = True

   ' Set the SQL script file name
   opt.ReversedFile = sScrptFile

   ' Start the reverse engineering
   model.ReverseDatabase

End Sub
