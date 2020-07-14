'******************************************************************************
'* File:     CreateViews.vbs
'* Purpose:  This VB Script creates a view for each table.
'* Title:    Create a view for each table
'* Category: Create Views
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

ValidationMode = True

Dim mdl ' the current model

' get the current active model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current Model."
ElseIf Not mdl.IsKindOf(PdPDM.cls_Model) Then
   MsgBox "The current model is not a Physical Data model."
Else
   ProcessFolder mdl
End If


'--------------------------------------------------------------------------------
' This routine creates a tablespace for each table
' of the current folder
'--------------------------------------------------------------------------------
Private Sub ProcessFolder(folder)
   Dim Tab  'table
   Dim View 'new View
   Dim Col  'Cols of the table
   Dim ViewCol ' Col of the View
   Dim SqlStmt

   ' Get the class diagram
   Dim diagram
   Dim sym
   Set diagram = folder.PhysicalDiagrams.Item(0)

   For each Tab in folder.Tables
      If not Tab.isShortcut then
         ' Test if there is a view with the same name or code
         Dim name, code, no
         name = "View" + Tab.Name
         code = "View" + Tab.Code
         no = 1
         Do
            If Not hasView(folder, name, code) Then
               Exit Do
            End If
            ' Try a new name & code
            no = no + 1
            name = "View" + Tab.Name + CStr(no)
            code = "View" + Tab.Code + CStr(no)
         Loop
         
         ' Create a new View
         Output "Create View " + code
         
         set View = folder.Views.CreateNew
         View.Name = name
         View.Code = code

         ' Add Columns for the table to the View
         Dim noCol
         noCol = 0
         SqlStmt = "select "
         For each Col in Tab.Columns
            If noCol > 0 Then
               SqlStmt = SqlStmt + ", "
            End If
            SqlStmt = SqlStmt + Col.Code
            noCol = noCol + 1
         Next 
         'Set the referenz
         SqlStmt = SqlStmt + " from " + Tab.Code
         View.SQLQuery = SqlStmt

         ' Create a symbol for the view
         Set sym = diagram.AttachObject(View)

      End If
   Next
End Sub

'--------------------------------------------------------------------------------
' This routine tests if there is a view with the same name or code
'--------------------------------------------------------------------------------
Private Function hasView(folder, name, code)
   Dim View
   For each View in folder.Views
      If Not View.isShortcut Then
         If View.Name = name or View.Code = code Then
            hasView = true
            Exit Function
         End If
      End If
   Next   
   hasView = false
End Function
