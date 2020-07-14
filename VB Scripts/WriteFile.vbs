'******************************************************************************
'* File:     WriteFile.vbs
'* Purpose:  This VB Script shows how to create a text file and write text in it.
'* Title:    Write a text file
'* Category: Write File
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Initialization
'-----------------------------------------------------------------------------
Dim system, file
Set system = CreateObject("Scripting.FileSystemObject")

' Open mode constants...
Dim ForReading, ForWriting, ForAppending
ForReading   = 1 ' Open a file for reading only. You can't write to this file. 
ForWriting   = 2 ' Open a file for writing. 
ForAppending = 8 ' Open a file and write to the end of the file. 

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------

Dim text
text = "Create a file using VB Scipt"
text = text + vbCrLf + "and the FileSystemObject object."
Output "Writing the following text in the c:\output.log file:"
Output text

Set file = system.OpenTextFile("C:\output.log", ForWriting, true)
file.Write text
file.Close
