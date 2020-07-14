'******************************************************************************
'* File:     ReadFile.vbs
'* Purpose:  This VB Script shows how to read a file and display the contains of the file in the output window.
'* Title:    Read a text file and display the contents
'* Category: Read File
'* Author:   
'* Version:  
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

Set file = system.OpenTextFile("C:\readme.txt", ForReading)
Dim noLine
noLine = 0
Do While file.AtEndOfStream <> True
   Output file.ReadLine
   noLine = noLine + 1
Loop
file.Close
Output CStr(noLine) + " line(s) read."
