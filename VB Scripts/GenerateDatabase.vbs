' This script shows how to use generation methods in VBScript.
' - Create a new model (on Sybase AS Anywhere 12) with two tables linked by a reference (see Sub "AddTestObjects")
' - Generate a script of this model in directory defined in constant "GenDir" (see Sub "GenerateDatabaseScripts")
' - Modify the model by adding a column to each tables (see Sub "ModifyModel")
' - Generate a modify database script accordingly (see Sub "GenerateAlterScripts")
' - Finally generate a set of test data (see Sub "GenerateTestDataScript")

Option Explicit

Const GenDir = "D:\temp\test\"

Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

Start

Sub Start()
   dim model
   Set model = CreateModel(PdPDM.cls_Model, "|DBMS=Sybase AS Anywhere 12")
   If (model is Nothing) then
      Output "Unable to create a Physical Data Model for Sybase AS Anywhere 12"
      Exit Sub
   End if

   If Not (AddTestObjects(model)) Then
      model.Close false
      Exit Sub
   End If
   
   GenerateDatabaseScripts model
   ModifyModel model
   GenerateAlterScripts model
   GenerateTestDataScript model
End Sub

Function AddTestObjects(model)
   ' Create first table, parent
   Dim prnt
   Set prnt = CreateTestTable(model, "Parent", "PRNT")
   If (prnt is Nothing) then
      Output "Unable to create the first table"
      AddTestObjects = false
      Exit Function
   End If
   
   ' Create second table child
   Dim chld
   Set chld = CreateTestTable(model, "Enfant", "CHLD")
   If (chld is Nothing) then
      Output "Unable to create the second table"
      AddTestObjects = false
      Exit Function
   End If
   
   ' Create the reference between child and parent
   Dim refr
   Set refr = AddTestReference(chld, prnt)
   If (refr is Nothing) then
      Output "Unable to create the reference"
      AddTestObjects = false
      Exit Function
   End If

   ' Save the model in order to refer it during modify database
   model.Save GenDir & "model.apm", True, "XML Archive"
   
   AddTestObjects = True
End Function

Sub ModifyModel(model)
   dim table, col
   ' Add a new column in each table
   For each table in model.Tables
      Set col = table.Columns.CreateNew()
      col.SetNameAndCode "az" & table.Name, "AZ" & table.Code
      col.Mandatory = False
   Next
End Sub

Function AddTestReference(pT1, pT2)

   Dim pR
   Set pR = pT2.Model.References.CreateNew()
   if (pR is Nothing) then
      Set AddTestReference = Nothing
      Exit Function
   end if

   Set pR.ChildTable = pT1
   Set pR.ParentTable = pT2

   Dim pJ
   For each pJ in pR.Joins
      pJ.ChildTableColumn.SetNameAndCode "ref" & pT2.Name, "F" & pT2.Code
   next
   Set AddTestReference = pR
End Function


Function CreateTestTable(model, sName, sCode)

   Dim table
   Set table = model.Tables.CreateNew()
   If (table is Nothing) then
      Output "Unable to create the first table"
      Set CreateTestTable = Nothing
      Exit Function
   End If
   table.SetNameAndCode sName, sCode

   ' Set the number of row for future test data generation
   table.TestNumber = Int(Rnd() * 53 + 12)

   If (AddTestColumns(table)) Then
      Set CreateTestTable = table
   Else
      output "Unable to add columns to " & sName & " - " & sCode
      Set CreateTestTable = Nothing
   End If
End Function

Function AddTestColumns(table)

   ' Add a PK Column, named "ID<tablename>"
   dim pPKCol: Set pPKCol = table.Columns.CreateNew()
   pPKCol.SetNameAndCode "id" & table.Name, "ID" & table.Code
   pPKCol.Primary = True

   ' Add a second column , named "A<tablename>"
   dim col: Set col = table.Columns.CreateNew()
   col.SetNameAndCode "a" & table.Name, "A" & table.Code
   AddTestColumns = True
End Function

Sub GenerateDatabaseScripts(model)

   Dim opts
   Set opts = model.GetPackageOptions()
   InteractiveMode = im_Batch ' Avoid displaying generation window
   
   ' set generation options using model package options
   opts.GenerateODBC = False ' Force sql script generation rather than ODBC
   
   opts.GenerationPathName = GenDir
   opts.GenerationScriptName = "script.sql"

   model.GenerateDatabase ' Launch the Generate Database feature
   
End Sub

Sub GenerateAlterScripts(model)
   Dim opts
   Set opts = model.GetPackageOptions()
   InteractiveMode = im_Batch ' Avoid displaying generate window
   
   ' set generation options using model package options
   opts.GenerateODBC = False ' Force sql script generation rather than ODBC
   
   opts.GenerationPathName = GenDir
   opts.DatabaseSynchronizationChoice = 0 'force already saved apm as source
   opts.DatabaseSynchronizationArchive = GenDir & "model.apm"
   opts.GenerationScriptName = "alter.sql"

   model.ModifyDatabase ' Launch the Modify Database feature
End Sub

Sub GenerateTestDataScript(model)
   Dim opts
   Set opts = model.GetPackageOptions()
   InteractiveMode = im_Batch ' Avoid displaying generate window

   ' set generation options using model package options
   opts.TestDataGenerationByODBC = False ' Force sql script generation rather than ODBC
   opts.TestDataGenerationDeleteOldData = False

   opts.TestDataGenerationPathName = GenDir
   opts.TestDataGenerationScriptName = "Test.sql"

   model.GenerateTestData ' Launch the Generate Test Data feature
End Sub
