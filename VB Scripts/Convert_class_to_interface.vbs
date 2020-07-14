'******************************************************************************
'* File:     Convert_Class_to_interface.vbs
'* Purpose:  Convert a Class to Interface
'* Title:    
'* Category: 
'* Version:  
'* Company:  Sybase Inc. 
'******************************************************************************




Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

Const TEMP =  "_temp" 'extension for temporary name/code

'
' get the current active model
'
Dim mdl ' the current model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current Model"
ElseIf Not mdl.IsKindOf(PdOOM.cls_Model) Then
   MsgBox "The current model is not an Object model."
Else
   Dim nb 'Number of object in active selection
   nb = ActiveSelection.Count
   If nb = 0 Then 
       output " No selected objects"
   Else
      Dim Hasclass 'Class existence in active selection
      Hasclass = false
      Dim obj 'object from selection
      For Each obj in ActiveSelection
         If obj.IsKindOf(PdOOM.cls_Class)  Then
            Hasclass = True
            Dim diagram 'the current diagram
            Set diagram = ActiveDiagram
            output "Transforming Class "& obj.Code
            Transform obj, diagram
         End If
      Next
      If not Hasclass Then
         output "No class selected"
      End If
   End If
End If

Private Sub Transform (clss, diag)
   Dim myinterface
   Dim parent
   Set parent = clss.Parent

   ' Don't transform the class if it is an assoc-class
   If not clss.Association is Nothing Then
      Output "Error: Cannot transform an association class"
      Exit Sub
   End If

   ' Don't transform the class if it is non abstract
   If not clss.Abstract Then
      Output "Error: Cannot transform a non abstract class"
      Exit Sub
   End If

   '
   'remove Interface/class with same temporary name
   '

   CleanInt parent, clss

   '
   'create new interface
   '
   Set myinterface = parent.Interfaces.CreateNew
   '
   'set attributes
   '
   myinterface.Code = clss.Code & TEMP
   myinterface.Name = clss.Name & TEMP
   myinterface.Comment = clss.Comment          
   myinterface.Description = clss.Description      
   myinterface.Annotation = clss.Annotation      
   myinterface.ExtendedAttributesText = clss.ExtendedAttributesText 
   myinterface.Stereotype = clss.Stereotype             
   myinterface.Visibility = clss.Visibility             
   myinterface.Generated= clss.Generated

   If not clss.ContainerClassifier is nothing Then
      myinterface.ContainerClassifier  = clss.ContainerClassifier  
   End If 

   myinterface.Header = clss.Header                 
   myinterface.Footer = clss.Footer                 
   myinterface.Imports = clss.Imports               

   '
   'Business rules
   '
   Dim BR
   For Each BR in clss.AttachedRules
      myinterface.AttachedRules.Add(BR)
   Next

   '
   'attributes
   '
   Dim ATT
   For Each ATT in clss.Attributes
      clss.Attributes.Remove(ATT)
      myinterface.Attributes.Add(ATT)
   Next

   '
   'Operations
   '
   Dim O
   For Each O in clss.Operations
      clss.Operations.Remove(O)
      myinterface.Operations.Add(O)
      O.Body = ""
   Next

   '
   'Inner
   '
   Dim I 'Inner classifier
   For Each I in clss.InnerClassifiers
      clss.InnerClassifiers.Remove(I)
      myinterface.InnerClassifiers.Add(I)
   Next


   '
   'Display
   '
   Dim MyInterfaceSymbol
   Set MyInterfaceSymbol = diag.AttachObject(myinterface)

   '
   'association
   '
   Dim A 'Association
   For Each A in clss.Associations
      ' test a enlever une fois que le bug sera corrigé
      If A.IsKindOf(PDOom.cls_Association) Then
      'output "association? "& A.Code
         If A.ClassA is clss Then
            A.ClassA  = myinterface
         ElseIf A.ClassB is clss Then
            A.ClassB  = myinterface
      End If
      'Display not necessary
      'diag.AttachLinkObject(A)
      End If
   Next

   '
   'realization are transformed into Generalization
   '
   Dim R
   Dim G
   For Each R in clss.Realizations
      Set G = parent.Generalizations.CreateNew
	   CopyGeneralizationProperties G, R
      G.ParentObject = R.Interface
      G.ChildObject = myinterface

      'Display
      'TODO remove two last parameters
      Dim S
      If R.Symbols.count >0 Then
         For Each S in R.Symbols
            diag.AttachLinkObject G, myInterfaceSymbol, S.DestinationSymbol
         Next
      End if

      R.Delete

   Next


   '
   'generalization where class is child are lost
   'generalization where class is parent are transformed into realization
   '
   For Each G in clss.ParentGeneralizations
      Set R = parent.Realizations.CreateNew
	   CopyGeneralizationProperties R, G
      R.Class = G.ChildObject
      R.Interface = myinterface

      'Display 
      'TODO remove two last parameters
      If G.Symbols.count >0 Then
         For Each S in G.Symbols
            diag.AttachLinkObject R, S.SourceSymbol, myInterfaceSymbol
         Next
      End if

      G.Delete

   Next

   Dim PD
   Dim CD
   For Each PD in clss.ParentDependencies
      PD.InfluentObject = myinterface
      'Display not necessary
      'diag.AttachLinkObject(PD)
   Next
   For Each CD in clss.ChildDependencies
      CD.DependentObject = myinterface
      'Display not necessary
      'diag.AttachLinkObject(CD)
   Next


   Dim Name
   Dim Code
   Name = clss.Name
   Code = clss.Code
   clss.Delete
   set clss = Nothing ' lose the deleted object reference
   myinterface.Name = Name
   myinterface.Code = Code

End Sub


'-----------------------------------------------------------------------------
' Remove an already exiting interface or class
' that could have the same temporary name or code
'-----------------------------------------------------------------------------
Private Sub CleanInt(Fldr, clss)
   Dim I 'Interface
   For Each I in Fldr.Interfaces
      If I.code = clss.code & TEMP or I.name = clss.name & TEMP Then
         Output "Warning: Interface " & I.code & " has been suppressed"
         I.Delete
      End If
   Next
   Dim C 'Class
   For Each C in Fldr.Classes
      If C.code = clss.code & TEMP or C.name = clss.name & TEMP Then
         Output "Warning: Class " & C.code & " has been suppressed"
         C.Delete
      End If
   Next
End Sub

'-----------------------------------------------------------------------------
'Copy the properties of a generalization/realization on a new one
'-----------------------------------------------------------------------------
Private Sub CopyGeneralizationProperties(G, R)
      G.Code = R.Code
      G.Name = R.Name
      G.Description = R.Description      
      G.Annotation = R.Annotation      
      G.Comment = R.Comment
      G.ExtendedAttributesText = R.ExtendedAttributesText
      G.Stereotype = R.Stereotype             

      'Business rules
      Dim BR
      For Each BR in R.AttachedRules
         G.AttachedRules.Add(BR)
      Next

End Sub
