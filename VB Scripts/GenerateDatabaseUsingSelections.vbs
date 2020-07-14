' This script shows how to use generation selections in VBScript.
' - Open sample PDM model (Project.PDM) which contains two selections
'   - Selection "Organization" includes tables DIVISION, EMPLOYEE, MEMBER & TEAM
'   - Selection "Materials" includes tables COMPOSE, MATERIAL, PROJECT & USED
' - Generate a first script of this model for selection "Organization"
' - Generate test data creation script for these tables
' - Generate a second script and dataset for selection "Materials"
'
' Generated sql script will be created in 'GenDir' directory
' there names are the name of the used selection with extension ".sql" for DDL scripts
' and extension "_td.sql" for DML scripts (for test data generations).

Option Explicit

Const GenDir = "D:\temp\test\"

Start EvaluateNamedPath("%_EXAMPLES%\project.pdm")

Sub Start(sModelPath)
   on error resume next
   dim pModel : Set pModel = OpenModel(sModelPath)
   If (pModel is Nothing) then
      Output "Unable to open model " & sModelPath
      Exit Sub
   End if

   GenerateDatabaseScripts pModel, "Organization"
   GenerateTestDataScript pModel, "Organization"

   GenerateDatabaseScripts pModel, "Materials"
   GenerateTestDataScript pModel, "Materials"
   pModel.Close
   on error goto 0
End Sub


Sub GenerateDatabaseScripts(pModel, sSelectionName)

   Dim pOpts : Set pOpts = pModel.GetPackageOptions()
   InteractiveMode = im_Batch ' Avoid displaying generate window
   
   ' set generation options using model package options
   pOpts.GenerateODBC = False ' Force sql script generation rather than ODBC
   
   pOpts.GenerationPathName = GenDir
   pOpts.GenerationScriptName = sSelectionName & ".sql"

 ' Launch the Generate Database feature with selected objects
   pModel.UseSelection fct_DatabaseGeneration, sSelectionName
   pModel.GenerateDatabase

End Sub

Sub GenerateTestDataScript(pModel, sSelectionName)
   Dim pOpts : Set pOpts = pModel.GetPackageOptions()
   InteractiveMode = im_Batch ' Avoid displaying generate window

   ' set generation options using model package options
   pOpts.TestDataGenerationByODBC = False ' Force sql script generation rather than ODBC
   pOpts.TestDataGenerationDeleteOldData = False

   pOpts.TestDataGenerationPathName = GenDir
   pOpts.TestDataGenerationScriptName = sSelectionName & "_td.sql"

 ' Launch the Generate Test Data feature for selected objects
   pModel.UseSelection fct_TestDataGeneration, sSelectionName
   pModel.GenerateTestData 
End Sub
