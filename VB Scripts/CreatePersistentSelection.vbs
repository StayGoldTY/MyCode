'******************************************************************************
'* File:     CreatePersistenSelection.vbs
'* Purpose:  Show how to create and use persistent selection
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit
Randomize

Const MaxTablePerLetter = 3

Start

'-----------------------------------------------------------------------------
' create 26 tables each with name starting by a different letter
' then creates three different persistent selections including tables 
' with name starting by a specified group of letter
' then generates a sql file from each selection
'-----------------------------------------------------------------------------

Sub Start
   dim pdm : Set pdm = CreateModel(PdPDM.cls_Model, "|DBMS=Sybase SQL Anywhere 12")
   Dim x
   For x = Asc("A") to Asc("Z")
      CreateTables pdm, Chr(x), Rnd()*MaxTablePerLetter
   Next
   SetTableSelection(pdm, "AZERTYUIOP").CreatePersistentSelectionManager("AZERTYUIOP")
   SetTableSelection(pdm, "QSDFGHJKLM").CreatePersistentSelectionManager("QSDFGHJKLM")
   SetTableSelection(pdm, "WXCVBN").CreatePersistentSelectionManager("WXCVBN")
   GenerateFileScript pdm, "QSDFGHJKLM", "c:\temp\"
   GenerateFileScript pdm, "AZERTYUIOP", "c:\temp\"
   GenerateFileScript pdm, "WXCVBN", "c:\temp\"
   pdm.save
   pdm.close
End Sub

'-----------------------------------------------------------------------------
' create table with columns starting which name starts by a specfic letter
'-----------------------------------------------------------------------------

Sub CreateTables(pModel, FirstLetter, Number)
   Dim I, T, S
   S = FirstLetter
   For I = 1 to Number
      Set T = pModel.Tables.CreateNew()
      T.SetNameAndCode sName(S, Rnd() * 12), sName(S, 4), True
      AddColumns T, "C" & S, 5
   Next
End Sub

'-----------------------------------------------------------------------------
' generate table name
'-----------------------------------------------------------------------------

Function sName(W, Number)
   if (Number > 0) then
      sName = sName(W & Chr(Asc("A") + Rnd()*26), Number - 1)
   else
      sName = W
   end if
End Function

'-----------------------------------------------------------------------------
' add columns to the table
'-----------------------------------------------------------------------------

Sub AddColumns(pTable, FirstLetter, Number)
   Dim I, C, S
   S = FirstLetter
   For I = 1 to Number
      Set C = pTable.Columns.CreateNew()
      C.SetNameAndCode sName(S, Rnd() * 12), sName(S, 4), True
   Next
End Sub

'-----------------------------------------------------------------------------
' create selection including tables with name starting by specified letters
'-----------------------------------------------------------------------------

Function SetTableSelection(pModel, LetterList)
   Dim pRetSel : Set pRetSel = pModel.CreateSelection()
   Dim T
   For each T in pModel.Tables
      if (InStr(LetterList, Left(T.Code, 1)) > 0) then
         pRetSel.Objects.Add T
      end if
   Next
   Set SetTableSelection = pRetSel
End Function

'-----------------------------------------------------------------------------
' generate sql file having selection name
'-----------------------------------------------------------------------------

Function GenerateFileScript(pModel, PerSelName, sFolder)
   Dim pOpts : Set pOpts = pModel.GetPackageOptions()
   InteractiveMode = im_Batch ' Avoid displaying generate window
   
   ' set generation options using model package options
   pOpts.GenerateODBC = False ' Force sql script generation rather than ODBC
   
   pOpts.GenerationPathName = sFolder
   pOpts.GenerationScriptName = PerSelName & ".sql"
   
   pModel.UseSelection fct_DatabaseGeneration, PerSelName
   pModel.GenerateDatabase ' Launch the Generate Database feature
End Function
