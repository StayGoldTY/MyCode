'******************************************************************************
'* File:     Command Execution.vbs
'* Purpose:  This VB Script shows:
'*           - How to execute shell commands
'*           - How to display logs in the output window
'*           - How to display the command output to the output window
'* Title:    Execute shell command
'* Category: Shell Command
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

Output "Show in output the result of ""tree C:\Tools"" command ..."
Output "----------------------------------------------------------"
ExecuteCommand "tree", "C:\Tools /A", cmd_PipeOutput
Output "----------------------------------------------------------"
Output ""

Output ""
Output "Show in output the result of ""tree C:\Tools"" command ..."
Output "----------------------------------------------------------"
ExecuteCommand "cmd", "/C dir C:\*.* /C", cmd_PipeOutput
Output "----------------------------------------------------------"
Output ""

Output ""
Output "Launch an explorer..."
ExecuteCommand "explorer", "C:\Tools"
Output "Explorer launched and self detached => execution isn't blocked"
Output ""

Output ""
Output "Launch NotePad on a given file..."
ExecuteCommand "NotePad", "C:\Temp\Todo.txt"
Output "NotePad exited..."
Output ""

Output ""
Dim str
str = ExecuteCommand("cmd", "/C dir C:\ /B", cmd_PipeResult)
Output "DIR ====> " + str + "======"
Output ""
