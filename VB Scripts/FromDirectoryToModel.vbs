' From Directory to Model is a script that recursively scan a DOS directory
' and creates file objects and packages in a free model

' Initialize global modes
Option explicit
ValidationMode = False

' Enter the directory to scan
Dim path
path = InputBox ("From Directory to Model allows you to scan for a directory and creates file objects and packages in a new Free Model. Enter the path of the directory to scan:", "From Directory to Model", "C:\temp")
output "From Directory to Model"
output "Scanning directory: " + path

' Check the path
Dim fso, folder
Set fso = CreateObject("Scripting.FileSystemObject")
Set folder = Nothing
If fso.FolderExists(path) then
   Set folder = fso.GetFolder(path)
End If   

' Try to scan the path
If not folder is Nothing then
   ' Create the Free Model
   Dim model
   set model = CreateModel (PDFrm.Cls_Model)
   If not model is Nothing then
      ' Begin the recursive scan
      ScanDirectoryToModel folder, model
   Else
      ' Log message
      MsgBox "Fail to create a new Free Model"
   End If
Else
   ' Log message
   if not path = "" then
      MsgBox "The specified folder path does not exist: " + path
   End If
End If


' The recursive procedure that scan directories and create files
Sub ScanDirectoryToModel (folder, package)

   ' check the parameters
   If folder is Nothing or package is Nothing then
      Exit Sub
   End If
   
   ' Log message in the output
   output "Scanning the directory " + folder.Path
   
   ' Initialize package name and code
   package.name = folder.name
   package.code = folder.name
   package.RenameObject
   
   ' Recursive call on sub folders
   Dim subFolder, subPackage
   For Each subFolder in folder.SubFolders
   
      ' Create a package object
      Set subPackage = package.Packages.CreateNew
      If not subPackage is Nothing then
         ' Avoid name uniqueness problems
         subPackage.UseParentNamespace = False
         ' Recursive call
         ScanDirectoryToModel subFolder, subPackage
      End If
   
   Next
   
   ' Loop on files
   Dim file, fileObject
   For Each file in folder.Files
   
      ' Create a file object
      Set fileObject = package.Files.CreateNew
      If not fileObject is Nothing then
         ' Log message in the output
         output " File " + file.Name
         ' Initialize file object attributes
         fileObject.Name = file.name
         fileObject.Code = file.name
         fileObject.RenameObject
         fileObject.SetAttributeText "Location", file.path
      End If
      
   Next
   
   ' Log end message in the output
   output "End of directory " + folder.path
   
   ' Display all in default diagram
   Dim diagram
   Set diagram = package.DefaultDiagram
   If not diagram is Nothing then
      diagram.AttachAllObjects
   End If
   
End Sub
