'******************************************************************************
'* File:     BuildModelDependencies.vbs
'* Purpose:  This script build a free model containing the interactions 
'*           between active model
'* Title:    Build model dependencies
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc.
'******************************************************************************

Option Explicit

Const sInternal = "<BuildDependancies>"

Const sGeneratedModels = "GeneratedModels"
Const sGenerationOrigins = "GenerationOrigins"
Const sExtendedModelDefinitions = "ExtendedModelDefinitions"
Const sSourceModels = "SourceModels"
Const sUnknown = "Unknown"

Const sOpenModelAlways = "Always"
Const sOpenModelAsk = "Ask"
Const sOpenModelNever = "Never"

Dim WantedTarget, OpenModelOption

' Specify in WantedTarget on what kind of relation you want to browse
' related models (use previously defined constants only)
WantedTarget = sUnknown & sGeneratedModels & sGenerationOrigins & sExtendedModelDefinitions

' specify whether opening closed model is conditionned by a message box
' Always : Always open model, without asking
' Never  : Never open model, without asking (create temp file instead)
' Ask    : Open a message box each time the script needs to open a model
OpenModelOption = sOpenModelAsk

Dim pActiveModel
Set pActiveModel = ActiveModel
If (pActiveModel is Nothing) Then
   MsgBox "Need an active model to execute"
Else
   Dim ModelMap, FreeModel, FreeModelDiagram
   Set ModelMap = CreateObject("Scripting.Dictionary")
   Set FreeModel = CreateModel(PDFrm.cls_Model)
   FreeModel.ModelOptionsText = AllValidOpts()
   Set FreeModelDiagram  = FreeModel.DefaultDiagram
   BuildDependencyFiles pActiveModel
End If

function BuildDependencyFiles(WorkingModel)
'output "BuildDependencyFiles("&WorkingModel.Name&")"
   If (WorkingModel is nothing) Then
      Set BuildDependencyFiles = Nothing
   Else
      Dim MapModelId, MdlFile
      MapModelId = GetExistingModelId(WorkingModel)
      If MapModelId = "" Then
         Dim Trg, LinkedModel, sKindOfTarget, LnkFile, Lnk
         set MdlFile = CreateModelFile(WorkingModel)
         If (WorkingModel.HasCollection("TargetModels")) Then
            For each Trg in WorkingModel.TargetModels
               Set LinkedModel = GetTargetModelObject(Trg)
               sKindOfTarget = KindOfTarget(WorkingModel, LinkedModel)
               If (CanRecurseTargets(sKindOfTarget, LinkedModel, WorkingModel)) Then
                  Set LnkFile = BuildDependencyFiles(LinkedModel)
                  set Lnk = FreeModel.CreateObject(cls_ExtendedDependency)
                  Lnk.InfluentObject = LnkFile
                  Lnk.DependentObject = MdlFile
                  Lnk.Stereotype = sKindOfTarget
                  FreeModelDiagram.AttachLinkObject(Lnk)
               End If
            Next
         End If
      Else
         Set MdlFile = ModelMap.Item(MapModelId)
      End If
      Set BuildDependencyFiles = MdlFile
   End If   
end function

function CreateModelFile(M)
'output "CreateModelFile("&M.Name&")"
   Dim F
   set F = FreeModel.CreateObject(cls_FileObject)
   F.Name = M.Name
   If (M.Comment = sInternal) Then
      F.Code = M.Code
      F.LocationType = 0 ' embedded
      F.Extension = GetExtensionFromModel(M)
      ModelMap.Add BuildFileModelID(F), F
   ElseIf (M.FileName = "") Then
      F.Code = M.Code
      F.LocationType = 0 ' embedded
      F.Extension = GetExtensionFromModel(M)
      ModelMap.Add M.ObjectID, F
   Else
      F.Code = M.ObjectID
      F.LocationType = 2 ' URL first, to specify location
      F.Location = M.FileName 
      F.LocationType = 1 ' External
      ModelMap.Add M.ObjectID, F
   End If
   FreeModelDiagram.AttachObject(F)
   Set CreateModelFile = F
end Function


function GetExtensionFromModel(c)
   Select Case (c.ClassKind)
      Case PdPDM.cls_Model:   GetExtensionFromModel = "PDM"
      Case PdCDM.cls_Model:   GetExtensionFromModel = "CDM"
      Case PdOOM.cls_Model:   GetExtensionFromModel = "OOM"
      Case PdBPM.cls_Model:   GetExtensionFromModel = "BPM"
      Case PdFRM.cls_Model:   GetExtensionFromModel = "FEM"
'      Case cls_GenerationTargetDefinition :   GetExtensionFromModel = GetFileNameExtension(c.FileName)
      Case Else :             GetExtensionFromModel = GetExtensionFromFileName(c.FileName)
   End Select
End Function

Function GetExtensionFromFileName(s)
   Dim p
   p = InStrRev(s, ".")
   If (p <> 0) Then
      GetExtensionFromFileName = Mid(s, p + 1)
   Else
      GetExtensionFromFileName = ""
   End If
End Function

Function KindOfTarget(Source, Target)
   Dim s
   For each s in Source.GeneratedModels
      If (s.TargetObject is Target) Then
         KindOfTarget = sGeneratedModels
         Exit Function
      End If
   Next
   For each s in Source.GenerationOrigins
      If (s.TargetObject is Target) Then
         KindOfTarget = sGenerationOrigins
         Exit Function
      End If
   Next
   For each s in Source.ExtendedModelDefinitions
      If (s.TargetObject is Target) Then
         KindOfTarget = sExtendedModelDefinitions
         Exit Function
      End If
   Next
   For each s in Source.SourceModels
      If (s.TargetObject is Target) Then
         KindOfTarget = sSourceModels
         Exit Function
      End If
   Next
   KindOfTarget = sUnknown
End Function

' Get the model from any target model (closed, opened or unknown)
' input t = TargetModel
' output -> corresponding model
Function GetTargetModelObject(t)
'output "GetTargetModelObject("&t.Name&")"
   Select Case (t.Status)
      Case "Closed", "Fermé":
         Select Case (OpenModelOption)
            Case sOpenModelAsk :
               If (MsgBox("GetTargetModelObject: Need to open " + t.TargetModelFileName, vbYesNo) = vbYes) then
                  set GetTargetModelObject = OpenModel(t.TargetModelFileName, omf_DontOpenView)
                  Exit Function
               End If
            Case sOpenModelAlways :
               set GetTargetModelObject = OpenModel(t.TargetModelFileName, omf_DontOpenView)
               Exit Function
         End Select      
      Case "Opened", "Ouvert":
         Set GetTargetModelObject = t.TargetModelObject
         Exit Function
   End Select
   output t.Name & " model is unreachable, create a dummy file"
   Set GetTargetModelObject = CreateModelForClosedTarget(t)
End Function

Function GetTargetModelType(pTarget)
   Select Case (LCase(GetExtensionFromFileName(pTarget.TargetModelFileName)))
      Case "cdm", "mcd" : GetTargetModelType = PdCDM.cls_Model
      Case "pdm", "mpd" : GetTargetModelType = PdPDM.cls_Model
      Case "oom", "moo" : GetTargetModelType = PdOOM.cls_Model
      Case "mpm"        : GetTargetModelType = PdMPM.cls_Model
      Case "bpm", "mtm" : GetTargetModelType = PdBPM.cls_Model
      Case "fem", "mlb" : GetTargetModelType = PdFEM.cls_Model
      Case Else : GetTargetModelType = PdFEM.cls_Model
   End Select
End Function

Function GetExistingModelId(m)
'output "GetExistingModelId("&m.Name&")"
' Gives the ID of a model that has already been passed
' returns empty strings if model is here for first time
   If (ModelMap.Exists(m.ObjectID)) Then
      GetExistingModelId = m.ObjectID
      Exit Function
   End If
   If (ModelMap.Exists(BuildFileModelID(m))) then
      GetExistingModelId = BuildFileModelID(m)
      Exit Function
   End If
   GetExistingModelId = ""
End Function

Function BuildFileModelID(F)
'output "BuildFileModelID("&F.Name&")"
' Build a kind of id for model than won't be opened
' and for which a dummy file has been created
   BuildFileModelID = sInternal&F.Name&F.Code
End Function

Function CreateModelForClosedTarget(pTarget)
'output "CreateModelForClosedTarget("&pTarget.Name&")"
   Dim M, sTargetFile, lTargetType
   lTargetType = GetTargetModelType(pTarget)
   Select Case (lTargetType)
      Case PdPDM.cls_Model:
         sTargetFile = "|DBMS=<Logical Model>"
      Case PDOom.cls_Model: 
         sTargetFile = "|Language=Analysis"
      Case Else : 
         sTargetFile = ""
   End Select
'   Set M = CreateModel(lTargetType, sTargetFile, omf_Hidden)
   Set M = CreateModel(lTargetType, "", omf_Hidden)
   M.Name = pTarget.Name
   M.Code = pTarget.Code
   M.Comment = sInternal
   Set CreateModelForClosedTarget = M
End Function

Function CanRecurseTargets(sKindOfTarget, pLinkedModel, pWorkingModel)
   If (InStr(WantedTarget, sKindOfTarget) = 0) Then
      CanRecurseTargets = false
      Exit Function
   ElseIf (pLinkedModel is pWorkingModel) Then
      CanRecurseTargets = false
      Exit Function
   ElseIf (pLinkedModel.FileName = "") Then
      CanRecurseTargets = false
      Exit Function
   Else
      CanRecurseTargets = true
   End If   
End Function

Function AllValidOpts()
   Dim s
   s = ""
   s = s + vbCrLf + "[ModelOptions\Free model options\ClssNamingOptions\FILO\Name]"
   s = s + vbCrLf + "InvldChar="
   s = s + vbCrLf + "ValidChar="
   s = s + vbCrLf + "AllValid=1"
   s = s + vbCrLf + "[ModelOptions\Free model options\ClssNamingOptions\FILO\Code]"
   s = s + vbCrLf + "InvldChar="
   s = s + vbCrLf + "ValidChar="
   s = s + vbCrLf + "AllValid=1"
   s = s + vbCrLf + "[ModelOptions\Free model options\ClssNamingOptions\DefaultClass\Name]"
   s = s + vbCrLf + "InvldChar="""""
   s = s + vbCrLf + "AllValid=1"
   s = s + vbCrLf + "[ModelOptions\Free model options\ClssNamingOptions\DefaultClass\Code]"
   s = s + vbCrLf + "InvldChar="""""
   s = s + vbCrLf + "AllValid=1"
   AllValidOpts = s
End Function