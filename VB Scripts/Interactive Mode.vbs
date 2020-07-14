'******************************************************************************
'* File:     Interactive Mode.vbs
'* Purpose:  This VB Script shows how to use the Interactive mode.
'*           The Interactive mode checks if the modifications are allowed and 
'*           may display confirmation messages.
'*           The Batch mode never displays messages.
'* Title:    Demo interactive mode
'* Category: Interactive Mode
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

' Display initial InteractiveMode
Output "InteractiveMode is " + CStrInteractiveMode(InteractiveMode)

' Set interactive mode to display Dialogs
' =======================================
InteractiveMode = im_Dialog
Output "InteractiveMode set to " + CStrInteractiveMode(InteractiveMode)
Dim model
Set model = CreateModel(PDCdm.cls_Model)
model.Name = "im_Dialog mode test"
model.Close ' Queries user for save confirmation, then file path

' Set interactive mode to Batch
' =============================
InteractiveMode = im_Batch
Output "InteractiveMode set to " + CStrInteractiveMode(InteractiveMode)
Set model = CreateModel(PDCdm.cls_Model)
model.Name = "im_Batch mode test"
model.Close ' Does not query user but save with default file name

' Set interactive mode to Abort
' =============================
InteractiveMode = im_Abort
Output "InteractiveMode set to " + CStrInteractiveMode(InteractiveMode)
Set model = CreateModel(PDCdm.cls_Model)
model.Name = "im_Abort mode test"
model.Close ' ABORTS SCRIPT EXECUTION !

' =============================

Output "Never reached!"

' =============================


'-----------------------------------------------------------------------------
' Display the interactive mode
'-----------------------------------------------------------------------------
Function CStrInteractiveMode(Mode)
   Select Case Mode
   Case im_Batch
      CStrInteractiveMode = "im_Batch"  ' Default: don't display dialogs just take dialog's corresponding default
   Case im_Dialog
      CStrInteractiveMode = "im_Dialog" ' Display dialog and wait for user input
   Case im_Abort
      CStrInteractiveMode = "im_Abort"  ' Trigger a scripting error if a dialog would be displayed
   Case Else
      CStrInteractiveMode = "<Not a valid InteractiveMode!>"
   End Select
End Function
