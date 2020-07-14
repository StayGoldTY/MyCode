'******************************************************************************
'* File:     List Metamodel Resources.vbs
'* Purpose:  This VB Script shows you how to display metamodel resources: 
'*           Languages, Extended Model Definitions, Model templates, Report templates and Diagrams.
'* Title:    Show Metamodels resources in output window
'* Category: Show Metamodels resources
'* Company:  Sybase Inc.
'* Author:   
'* Created:  
'* Modified: 
'* Version:  1.0
'* Comment:  
'******************************************************************************

option explicit

Dim module, diagramClass, language, extension, message, library, template, canDiagramBeDefaultInitialDiagram
Output
Output "Metamodels resources:"
Output

' For each metamodel
For Each module in MetaModel.Modules

   ' Write metamodel header
   message = module.Code
   If Not module.Name = "" Then
      message = message & " - " & module.Name
   End If
   Set library = module.Library
   If Not library Is Nothing Then
      message = message & " (" & library.PublicName & ")"
   End If
   If module.IsLoaded Then
      message = message + ", Loaded"
   Else
      message = message + ", Not loaded"
   End If
   Output "-----------------------------------------------------------------------------------"
   Output message  
   Output "-----------------------------------------------------------------------------------"
   
   ' List of diagrams
   If Not module.DiagramClasses.Count = 0 Then
      Output "   Diagrams:"
      ' NOTE: Take care that not all values from <module.DiagramClasses> can be accepted by <module.DefaultDiagram>
      For Each diagramClass in module.DiagramClasses
         message = "      - " + diagramClass.PublicName + " (" + diagramClass.LocalizedName + ")"
         If diagramClass.GetExtendedData("DIAGDEFINIT") = "false" Then
            message = message + ", Not allowed as default initial diagram"
         End If
         Output message
      Next
      If Not module.DefaultDiagram is Nothing Then 
         Output "   User defined default initial diagram: " + module.DefaultDiagram.PublicName
      End If
      Output
   End If
   
   ' List of Languages
   If module.HasTargetLanguage And Not module.Languages.Count = 0 Then
      Output "   " & module.LanguagesCaption & " (" & module.LanguagesClass.PublicName & ") from " + module.LanguagesDirectory + ":"
      For Each language in module.Languages
         If language.Family = "" And language.SubFamily = "" Then
            Output "      - " + language.Name
         Else
            Output "      - " + language.Name + " (" + language.Family + " - " + language.SubFamily + ")"
         End If
      Next
      If Not module.DefaultLanguage is Nothing Then 
         Output "      Default initial " + module.LanguagesCaption + ": " + module.DefaultLanguage.Name
      End If
      Output
   End If
   
   ' List of Extended Model Definitions
   If Not module.Extensions.Count = 0 Then
      Output "   Extended Model Definitions from " + module.ExtensionsDirectory + ":"
      For Each extension in module.Extensions
         If extension.Family = "" And extension.SubFamily = "" Then
            Output "      - " & extension.Name
         Else
            Output "      - " & extension.Name & " (" & extension.Family & " - " & extension.SubFamily & ")"
         End If
      Next
      Output
   End If

   ' List of Report templates
   If Not module.ReportTemplates.Count = 0 Then
      Output "   Report templates from " + module.ReportTemplatesDirectory + ":"
      For Each template in module.ReportTemplates
         Output "      - " & template.Name + ", " + template.Filename
      Next
      Output
   End If

   ' List of Model Templates
   If Not module.ModelTemplates.Count = 0 Then
      Output "   Model templates from " + module.UserModelTemplatesDirectory + ":"
      For Each template in module.ModelTemplates
         Output "      - " & template.Name + ", " + template.FileName
      Next
      Output
   End If

   Output
Next
