Option Explicit

' First close existing workspace
Dim workspace
Set workspace = ActiveWorkspace
Output "Saving current workspace to ""%_EXAMPLES%\Temp.SWS"""
workspace.Save "%_EXAMPLES%\Temp.SWS"
workspace.Close
workspace.Name = "Dummy"
workspace.FileName = "Dummy.SWS"

' Then demo creating a folder in collection
Dim folder
Set folder = workspace.Children.CreateNew(PdWsp.cls_WorkspaceFolder)
folder.Name = "My Folder"

' Then demo creating some documents...
Dim doc
Set doc = folder.Children.CreateNew(PdWsp.cls_WorkspaceFile)
doc.Name = "Just a dummy (AutoExec.bat)"  ' note: setting filename below overwrites name too
doc.FileName = "C:\AutoExec.bat"          ' note: if file exists icon is setup correctly too
Set doc = folder.CreateObject(PdWsp.cls_WorkspaceFile)
doc.Name = "Just a dummy (Config.sys)"    ' note: setting filename below overwrites name too
doc.FileName = "C:\Config.sys"            ' note: if file exists icon is setup correctly too
Dim model
Set model = folder.Children.CreateNew(PdWsp.cls_WorkspaceModel)
model.FileName = EvaluateNamedPath("%_EXAMPLES%\demo.oom")
Set model = folder.Children.CreateNew(PdWsp.cls_WorkspaceModel)
model.FileName = EvaluateNamedPath("%_EXAMPLES%\project.pdm")

' Then demo creating a folder by direct CreateObject
Set folder = workspace.CreateObject(PdWsp.cls_WorkspaceFolder)
folder.Name = "My Other Folder"

' Creates some more sub-folders...
Dim subfolder
Set subfolder = folder.Children.CreateNew(PdWsp.cls_WorkspaceFolder)
Set subfolder = folder.Children.CreateNewAt(0, PdWsp.cls_WorkspaceFolder)
Set subfolder = folder.Children.CreateNewAt(0, PdWsp.cls_WorkspaceFolder)

' Then demo creating some documents...
Set doc = workspace.Children.CreateNewAt(0,PdWsp.cls_WorkspaceFile)
doc.Name = "Just another dummy (AutoExec.bat)"  ' note: setting filename below overwrites name too
doc.FileName = "C:\AutoExec.bat"          ' note: if file exists icon is setup correctly too
Set doc = workspace.CreateObject(PdWsp.cls_WorkspaceFile)
doc.Name = "Just another dummy (Config.sys)"    ' note: setting filename below overwrites name too
doc.FileName = "C:\Config.sys"            ' note: if file exists icon is setup correctly too
Set model = workspace.Children.CreateNewAt(0,PdWsp.cls_WorkspaceModel)
model.FileName = EvaluateNamedPath("%_EXAMPLES%\demo.oom")
Set model = workspace.Children.CreateNewAt(0,PdWsp.cls_WorkspaceModel)
model.FileName = EvaluateNamedPath("%_EXAMPLES%\project.pdm")

' Then demo adding document...
subfolder.AddDocument "C:\Config.sys"
subfolder.AddDocument "C:\AutoExec.bat", 0
subfolder.AddDocument "%_EXAMPLES%\demo.oom"
Set model = subfolder.AddDocument("%_EXAMPLES%\project.pdm")
Dim pdm
Set pdm = model.Open
Output "Loaded model: " & pdm.Name
' Demo browsing existing workspace elements (see below)
ShowWorkspaceElements workspace, ""
Set pdm = Nothing
model.Close

' Stop for a while before we restore previous workspace
MsgBox "See the result !"
Output "Restoring current workspace to ""%_EXAMPLES%\Temp.SWS"""
workspace.Load "%_EXAMPLES%\Temp.SWS"

' Demo browsing existing workspace elements
Sub ShowWorkspaceElements(element, indent)
   If Not IsEmpty(element) And IsObject(element) And Not element Is Nothing Then
      If element.IsKindOf(PdWsp.cls_WorkspaceFolder) Then
         If element.IsKindOf(PdWsp.cls_Workspace) Then
            Output indent & " + Workspace: " & element.Name & " (" & element.FileName & ")"
         Else
            Output indent & " + " & element.Name
         End If
         Dim child
         For Each child In element.Children
            ShowWorkspaceElements child, indent & "   "
         Next
      ElseIf element.IsKindOf(PdWsp.cls_WorkspaceModel) Then
         Output indent & " - : " & element.Name & " (Filename: """ & element.FileName & """, Kind: " & element.ModelKind & ", OID: " & element.ModelOid & ", Loaded: " & CStr(Not element.ModelObject Is Nothing) & ")"
      ElseIf element.IsKindOf(PdWsp.cls_WorkspaceFile) Then
         Output indent & " - : " & element.Name & " (" & element.FileName & ")"
      Else
         Output indent & "!?"
      End If
   End If
End Sub
