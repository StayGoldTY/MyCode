' From Directory to Repository is a script that recursively scan a DOS directory
' and condolidates all documents in the repository

' Initialize global modes
Option explicit

' Enter the directory to scan
Dim path
path = InputBox ("From Directory to Repository allows you to consolidate recursively all documents of a directory. Enter the path of the directory to scan (the workspace file will be stored under this directory):", "From Directory to Repository", "C:\temp")
output "From Directory to Repository"
output "Scanning directory: " + path

' Check the path
Dim fso, folder
Set fso = CreateObject("Scripting.FileSystemObject")
Set folder = Nothing
If fso.FolderExists(path) then
   Set folder = fso.GetFolder(path)
End If   

' Try to scan the path
Dim rootPath
If not folder is Nothing then

   ' Check the repository connection
   Dim repository, connected
   Set repository = RepositoryConnection
   connected = repository.Connected
   If not connected then
      connected = repository.Open()
   End If
   
   If connected then
      ' Begin the recursive scan
      ScanDirectoryToRepository folder, repository
      ' Refresh the repository browser
      repository.Refresh
   Else
      ' Log message
      MsgBox "The repository needs to be connected or default connexion should be operational"
   End If
Else
   ' Log message
   if not path = "" then
      MsgBox "The specified folder path does not exist: " + path
   End If
End If


' The recursive procedure that scan directories and consolidates documents in the repository
Sub ScanDirectoryToRepository (folder, package)

   ' check the parameters
   If folder is Nothing or package is Nothing then
      Exit Sub
   End If
   
   ' Log message in the output
   output "Scanning the directory " + folder.Path
      
   ' Recursive call on sub folders
   Dim subFolder, subPackage
   For Each subFolder in folder.SubFolders
      ' Retrieve or Create repository sub-package
      Dim currChild
      Set subPackage = Nothing
      For Each currChild in package.ChildObjects
         If currChild.IsKindOf(PdRMG.Cls_RepositoryFolder) and currChild.Name = subFolder.name then
            set subPackage = currChild
            Exit For
         End If
      Next
      If subPackage is Nothing then
         Set subPackage = package.CreateFolder(subFolder.name)
      End If
      
      ' Recursive call
      ScanDirectoryToRepository subFolder, subPackage
   Next
   
   ' Create a dictionary to list files
   ' (this is necessary because the file manipulations during the consolidation 
   ' can perturbate the Files VBScript collection)
   Dim dictionary
   Set dictionary = CreateObject("Scripting.Dictionary")
   
   ' Add files in the dictionary
   Dim file, fileObject
   For Each file in folder.Files
      dictionary.Add file.name, file
   Next
   
  ' Loop on files stored in the dictionary
  Dim files, i
  files = dictionary.Items
  For i = 0 To dictionary.Count -1
     ConsolidateDocument files(i), package
  Next
  
   ' Log end message in the output
   output "End of directory " + folder.path
   
End Sub

' The procedure consolidate a document in the repository
Sub ConsolidateDocument (file, package)

   ' check the parameters
   If file is Nothing or package is Nothing then
      Exit Sub
   End If

   ' get the file extension
   Dim ext, pos
   ext = file.name
   pos = InStrRev(ext, ".")
   If pos > 1 then
      ext = Right(file.name, Len(file.name) - pos)
   End If
   ext = LCase(ext)
      
   ' skip backup extensions
   If ext = "cdb" or ext = "pdb" or ext = "oob" or ext = "bpb" or ext = "feb" or ext = "mtb" or ext = "bmr" then
      Exit Sub
   End If
   
  
   ' Log message in the output
   output " Consolidating document " + file.name + " into " + package.name
   
   ' consolidate in the repository
   Dim conflicts, actions
   package.ConsolidateDocument file.path, 2, actions, conflicts
   
   ' log conflicts in the output
   If not conflicts = "" then
      output "The consolidation of the document failed due to following conflicts:"
      output conflicts
   End If
   
End Sub      
