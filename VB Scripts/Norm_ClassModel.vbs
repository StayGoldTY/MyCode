'******************************************************************************
'* File:     Norm_ClassModel.vbs
'* Description
'     Normalize Classes and Interfaces names. Class name must begin with a C and
'     interface name must begin with a I. 
'     It also checks the prefixe of the attributs according to the data type.
'
'  PD objects and methods used
'     CreateSelection (method see BaseModel)
'     ObjectSelection (object)
'     ClassKind (property)
'* Title:    
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit
'
'-----------------------------------------------------------------------------
' Main
'-----------------------------------------------------------------------------

Dim sel1 'as ObjectSelection
Dim obj  'as NamedObject (abstract)
Dim cFirstChar 'as Char

' Verify that the active model and diagram are correct
if (activemodel.ClassKind <> PdOOM.cls_model) or (activediagram.ClassKind <>cls_ClassDiagram) then
   err.raise vbObjectError+1 , "Script Error", "The active model is not an OOM or the active diagram is not a Class diagram"
end if


set sel1 = activemodel.createselection
sel1.addobjects activemodel,cls_Class,0,1 'add all classes (no shortcut, all packages)
sel1.addobjects activemodel,cls_Interface,0,1 'add all interfaces (no shortcut, all packages)


for each obj in sel1.objects
   cFirstChar = UCase(Left(obj.name,1))

   Select Case obj.ClassKind 
      case cls_Class       CheckPrefix "C" , obj
      case cls_Interface   CheckPrefix "I" , obj
   end select
   ValidateAttributs
next

'-----------------------------------------------------------------------------
' ValidateAttributs
'
'  For every attributs in a class or interface, it calls the
'  CheckPrefix function
'
'-----------------------------------------------------------------------------
sub ValidateAttributs()
Dim member 'as Attribute
   for each member in obj.attributes
      Select Case member.DataType      
         case "int"     CheckPrefix "n", member
         case "long"    CheckPrefix "n", member
         case "short"   CheckPrefix "n", member
         case "boolean" CheckPrefix "b", member
         case "float"   CheckPrefix "f", member
         case "double"  CheckPrefix "f", member
         case "String"  CheckPrefix "sz", member
         case "char"    CheckPrefix "c", member
      end select
   next
end sub


'-----------------------------------------------------------------------------
' CheckPrefix
'
'  Compare the 1st letter of the attribut name and the expected prefix
'  and if they are different, it adds the prefixe
'
'  Parameters
'     szPrefix : char (expected prefixe)
'     pObj  : object passed by Reference (object to check)
'
'  Note: we cannot pass the name by reference, the structure
'  of the PD objects doesn't allow that.
'
'-----------------------------------------------------------------------------
sub CheckPrefix(Byval szPrefix, ByRef pObj)
   cFirstChar = Left(pObj.Name,1)
   if cFirstChar<>szPrefix then
      pObj.Name = szPrefix & pObj.Name
   end if
end sub