'******************************************************************************
'* File:     MeasurePDMComplexity.vbs
'* Purpose:  Compute some measures on a Physical Data Model
'            This script measure models complexity
'            Produced results
'
'                  Statistics for the model "Project Management (PDM)":
'
'                  Independent tables: 55%
'                  Highly-related tables: 0% (3+ references)
'                  Small tables: 55% (3- columns)
'                  Average number of columns: 4
'                  Non-key columns: 55% (100% nullable)
'                  Average number of keys: 1,1
'                  Average number of references: 1,2
'                  Identifying references: 69%
'
'                  Raw numbers:
'
'                  Tables: 11
'                  Columns: 44
'                  Keys: 12
'                  References: 13
'
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************


Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

Const HIGHREFERENCE = 3 ' cut-off for highly related tables
Const SMALLCOLUMN = 3 ' cut-off for small tables

Dim numTables ' number of tables in the model
Dim numChildTables ' number of tables relative to an other
Dim numRelatedTables ' number of highly related tables
Dim numSmallTables ' tables with few columns
Dim numColumns ' number of columns in the model
Dim numKeyColumns ' number of columns linked to keys
Dim numNullableColumns ' number of non-key nullable columns
Dim numKeys ' number of keys in the model
Dim numReferences ' number of out-references
Dim numParentReferences ' number of non-parent references

numTables = 0
numChildTables = 0
numRelatedTables = 0
numSmallTables = 0
numColumns = 0
numKeyColumns = 0
numNullableColumns = 0
numKeys = 0
numReferences = 0
numParentReferences = 0

' get the current active model
Dim mdl ' the current model
Set mdl = ActiveModel
If (mdl Is Nothing) Or Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "The current model is not a Physical Data model."
Else
   ComputeFolder mdl
   DisplayResults mdl
End If


' Display the results of the computations
Private Sub DisplayResults(mdl)
   Output "Statistics for the model """ & mdl.Name & """:"
   Output ""
   If numTables <> 0 Then
      Output "Independent tables: " & Round((numTables - numChildTables)/numTables*100,0) & "%"
      Output "Highly-related tables: " & Round(numRelatedTables/numTables*100,0) & "% (" & HIGHREFERENCE & "+ references)"
      Output "Small tables: " & Round(numSmallTables/numTables*100,0) & "% (" & SMALLCOLUMN & "- columns)"
      Output "Average number of columns: " & Round(numColumns/numTables, 1)
      Dim suff ' suffix string
      If numColumns <> 0 Then
         If numColumns <> numKeyColumns Then
            suff = " (" & Round(numNullableColumns/(numColumns-numKeyColumns)*100,0) & "% nullable)"
         Else
            suff = ""
         End If
         Output "Non-key columns: " & Round((numColumns-numKeyColumns)/numColumns*100,0) & "%" & suff
      End If
      Output "Average number of keys: " & Round(numKeys/numTables, 1)
      Output "Average number of references: " & Round(numReferences/numTables, 1)
      If numReferences <> 0 Then
         Output "Identifying references: " & Round(numParentReferences/numReferences*100,0) & "%"
      End If

      Output ""
      Output "Raw numbers:"
      Output ""
      Output "Tables: " & numTables
      Output "Columns: " & numColumns
      Output "Keys: " & numKeys
      Output "References: " & numReferences
   Else
      Output "No table defined in this model."
   End If
   Output ""
End Sub


' Recursive computation of statistics starting with a folder
Private Sub ComputeFolder(fldr)
   ' compute the statistics for each table
   Dim t ' running table
   For Each t In fldr.Tables
      ComputeTable t
   Next

   ' go into the sub-packages
   Dim f ' running folder
   For Each f In fldr.Packages
      ComputeFolder f
   Next
End Sub


' Compute statistics for one table
Private Sub ComputeTable(tbl)
   If tbl.IsShortcut() Then Exit Sub

   ' count one more table
   numTables = numTables + 1

   ' count the columns
   Dim c ' column iterator
   For Each c In tbl.Columns
      numColumns = numColumns + 1
      If c.Keys.Count <> 0 Then
         numKeyColumns = numKeyColumns + 1
      Else
         If Not c.Mandatory Then
            numNullableColumns = numNullableColumns + 1
         End If
      End If
   Next

   ' check whether the table qualify as small
   If tbl.Columns.Count <= SMALLCOLUMN Then
      numSmallTables = numSmallTables + 1
   End If

   ' count the keys
   Dim k ' running key
   For Each k In tbl.Keys
      numKeys = numKeys + 1
   Next

   ' check whether the table has a parent
   Dim r ' running reference
   Dim parent ' has the table a parent?
   parent = False
   For Each r In tbl.OutReferences
      numReferences = numReferences + 1
      If IsReferenceParent(r) Then
         parent = True
         numParentReferences = numParentReferences + 1
      End If
   Next
   If parent Then
      numChildTables = numChildTables + 1
   End If

   ' check whether the table count as highly-related
   If tbl.OutReferences.Count >= HIGHREFERENCE Then
      numRelatedTables = numRelatedTables + 1
   End If
End Sub


' Check whether a reference links to a parent of a table
Private Function IsReferenceParent(refr)
   IsReferenceParent = False
   Dim n ' foreign key count
   n = refr.Joins.Count
   If n = 0 Then Exit Function

   ' check that all the joins are filled
   Dim rf ' reference join iterator
   For Each rf In refr.Joins
      If rf.Object2 Is Nothing Then Exit Function
   Next

   Dim col ' first column of the reference
   Set col = refr.Joins.Item(0).Object2
   Dim keys ' collection of keys containing the first column
   Set keys = col.Keys
   If keys.Count = 0 Then Exit Function

   ' all the reference foreign keys must be in one of the keys containing this column
   Dim k ' key iterator
   Dim c ' running foreign key column
   Dim i ' other foreign column iterator
   Dim valid ' does the key contain all the columns?
   For Each k In keys
      valid = 1
      For i = 0 To n-1
         Set c = refr.Joins.Item(i).Object2
         If Not IsColumnInKey(c, k) Then
            valid = 0
            Exit For
         End If
      Next
      ' found one matching key?
      If valid = 1 Then
         IsReferenceParent = True
         Exit Function
      End If
   Next
End Function


' Check whether a column is in a key
Private Function IsColumnInKey(col, key)
   IsColumnInKey = False
   Dim c ' column iterator
   For Each c In key.Columns
      If c Is col Then
         IsColumnInKey = True
         Exit Function
      End If
   Next
End Function

