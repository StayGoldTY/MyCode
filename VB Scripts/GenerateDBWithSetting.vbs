' 
' This sample shows how to use the new availability of database 
' generation and reverse method in PowerDesigner.
' The VBScript reverse an ODBC database in a new PDM model and 
' then generate one file for each object found.
'
' First lines define some used constants
' - cnxDSN is either the ODBC dsn string or the path to an ODBC file dsn
' - cnxUSR is the ODBC connection user name
' - cnxPWD is the ODBC connection password
' - GenDir is the path where the script files will be generated
' - GenSet is the setting set used for generation
'
option explicit

' Define ODBC connection
Const cnxDSN = "odbc:ASA 9.0 Sample:SQL Anywhere 9.0"
Const cnxUSR = "dba"
Const cnxPWD = "sql"
' Define generation output directory
Const GenDir = "C:\temp\"
' Define generation setting names
Const gAllSet = "All objects" 
Const gTbSet  = "Tables & Views (with permissions)"
Const gTpSet  = "Triggers & Procedures (with permissions)"
' Define the generation type
Dim sStgFunction 
sStgFunction = fct_DatabaseGeneration

' Call to main function with the newly created PDM
' This sample use an ASA9 database
Start CreateModel(PdPDM.cls_Model, "|DBMS=Sybase AS Anywhere 9")

sub Start(model)

   if (model is Nothing) then
      output "Unable to create a Physical Data Model for selected DBMS"
      exit sub
   end if

   ' Check destination path
   dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   if (not fso.FolderExists(GenDir)) then
      Output "Destination path (" & GenDir & ") does not exist. You must either create it or choose an existing path"
      exit sub
   end if
   
   ' Select the batch mode to bypass the generation window
   InteractiveMode = im_Batch
   
   ' First connect to the database with connection parameters
   model.ConnectToDatabase cnxDSN, cnxUSR, cnxPWD

   ' Get the generation/reverse option of the model
   Dim opt
   Set opt = model.GetPackageOptions()
   
   ' Set the reverse engineer mode to direct connection
   opt.ReversedScript = False

   ' Force ODBC Reverse of all objects
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

   ' Start reverse engineering
   model.ReverseDatabase

   ' Set the generation mode to script generation
   opt.GenerateODBC = False
   ' Set the generation path
   opt.GenerationPathName = GenDir

   ' Generate a Crebas.sql file that contains all the objects
   '---------------------------------------------------------

   ' Set the database generation setting
   model.UseSettings sStgFunction, gAllSet
   ' Set the script file short name
   opt.GenerationScriptName = "Crebas.sql"

   ' Start the generation of the Crebas.sql file
   model.GenerateDatabase

   ' Generate a Tables.sql file that contains the tables and views
   '--------------------------------------------------------------

   ' Build an object selection to generate all model tables and views
   Dim obj, sel, sStg, pTrg 
   Set sel = model.CreateSelection

   For each obj in model.Tables
      ' Add current table to selection
      sel.Objects.Add obj
   next
   For each obj in model.Views
      ' Add current view to selection
      sel.Objects.Add obj
   next
     
   ' Set the database generation setting
   model.UseSettings sStgFunction, gTbSet
   ' Set the script file short name
   opt.GenerationScriptName = "Tables.sql"

   ' Start the generation of the Tables.sql file
   model.GenerateDatabase sel

   set sel= nothing

   ' Generate a Triggers.sql file that contains the triggers and stored-procedures
   '------------------------------------------------------------------------------

   ' Build an object selection to generate all model triggers and procedures
   Set sel = model.CreateSelection

   For each obj in model.Tables
      for each pTrg in obj.Triggers
         ' Add current trigger to selection
         sel.Objects.Add pTrg
      next
   next
   For each obj in model.Procedures
      ' Add current procedure to selection
      sel.Objects.Add obj
   next

   ' Set the database generation setting name
   model.UseSettings sStgFunction, gTpSet
   ' Set the generation script name
   opt.GenerationScriptName = "Triggers.sql"

   ' Start the generation of the Triggers.sql file
   model.GenerateDatabase sel

   ' Clean  selection 
   set sel = nothing
   
   model.Close false
   
end sub
