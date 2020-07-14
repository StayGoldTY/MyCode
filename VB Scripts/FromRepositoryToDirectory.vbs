' From Repository to Directory is a script that recursively scan a repository
' and extract all models and documents to their default location
' Model for which the file is read only are not extracted

' Initialize global modes
Option explicit

' Check the repository connection
Dim repository, connected
Set repository = RepositoryConnection
connected = repository.Connected
If not connected then
   connected = repository.Open()
End If
   
If connected then
   ' Begin the recursive scan
   ScanRepository repository
   ' Refresh the repository browser
   repository.Refresh
Else
   ' Log message
   MsgBox "The repository needs to be connected or default connexion should be operational"
End If


' The recursive procedure that scan folders and extracts models
Sub ScanRepository (folder)

   ' check the parameters
   If folder is Nothing then
      Exit Sub
   End If
   
   ' Log message in the output
   output "Scanning the folder " + folder.Name
      
   ' Recursive call on sub folders
   Dim subObject
   For Each subObject in folder.ChildObjects
      ' recurse or extract repository sub-package
      If subObject.IsKindOf(PdRMG.Cls_RepositoryFolder) then
         ScanRepository subObject
      else
         If subObject.IsKindOf(PdRMG.Cls_RepositoryDocument) or subObject.IsKindOf(PdRMG.Cls_RepositoryModel) then
            output "Extracting " & subObject.name
            subObject.ExtractToFile subObject.ExtractionName, 1
         end if
      End If
   Next

End Sub