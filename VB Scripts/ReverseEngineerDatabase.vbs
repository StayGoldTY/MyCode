' 
' This sample shows how to use the new availability of database 
' reverse engineering methods in PowerDesigner.
' The VBScript reverse engineers a database using ODBC in a new PDM model
'
' First lines define some used constants
' - cnxDSN is either the ODBC DSN string, the path of an ODBC file DSN or the path of a connection profile
' - cnxUSR is the ODBC connection user name
' - cnxPWD is the ODBC connection password
'
option explicit

' To use a user or system data source, define constant with "odbc:<datasourcename>:<driver>":
' Const cnxDSN = "odbc:asa9-delphes-sdp-syb:SQL Anywhere 9.0"
' To use a file data source, define constant with the full path to the DSN file:
' Const cnxDSN = "\\juliette\public\DATABASES\_filedsn\sybase_asa9_delphes.dsn"
' To use a connection profile data source, define constant with the full path to the DCP file:
' Const cnxDSN = "C:\Program Files\Sybase\PowerDesigner 12\Connection Profiles\ase15.dcp"

' Use ODBC datasource
Const cnxDSN = "odbc:asa9-delphes-sdp-syb:SQL Anywhere 9.0"
Const cnxUSR = "mledier"
Const cnxPWD = "mledier"

' Call to main function with the newly created PDM
' This sample use an ASA9 database
Start CreateModel(PdPDM.cls_Model, "|DBMS=Sybase AS Anywhere 9")

Sub Start(model)

   If (model is Nothing) then
      output "Unable to create a Physical Data Model for selected DBMS"
      Exit Sub
   End If

   ' Set interactive mode to batch to bypass the reverse engineering window
   InteractiveMode = im_Batch

   ' First connect to the database with connection parameters
   model.ConnectToDatabase cnxDSN, cnxUSR, cnxPWD

   ' Get the generation/reverse option of the model
   Dim opt
   Set opt = model.GetPackageOptions()

   ' Set reverse engineer mode to direct connection
   opt.ReversedScript = False

   ' Force ODBC Reverse of all listed objects
   opt.ReverseAllTables = true
   opt.ReverseAllViews = true
   opt.ReverseAllStorage = true
   opt.ReverseAllTablespace = true
   opt.ReverseAllDomain = true
   opt.ReverseAllUser = true
   opt.ReverseAllProcedures = true
   opt.ReverseAllTriggers = true
   opt.ReverseAllSystemTables = true
   opt.ReverseAllSynonyms = true

   ' Start the reverse engineering
   model.ReverseDatabase

   ' Close model at the end
   model.Close false

End Sub
