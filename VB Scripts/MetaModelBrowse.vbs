Option Explicit

Function ShowBranch(cls)
   If IsEmpty(cls) or not IsObject(cls) or (cls Is Nothing) Then
      ShowBranch = " + "
   Else
      Dim Indent
      Indent = ShowBranch(cls.ParentClass)
      Output Indent & cls.PublicName
      ShowBranch = "   " & Indent
   End If   
End Function

Sub ShowMetaClassContent(name, MetaClass)
   Output ""
   Output "-------------------------------------------------------------"
   Output name & " belongs to library: " & MetaClass.Parent.PublicName & " (" & MetaClass.Parent.LocalizedName & ")"
   Output "-------------------------------------------------------------"
   Output "PublicName         : " & MetaClass.PublicName
   Output "LocalizedName      : " & MetaClass.LocalizedName
   Output "QualifiedPublicName: " & MetaClass.QualifiedPublicName
   Output "Kind               : " & CStr(MetaClass.Kind)
   Output "Flags              : " & CStr(MetaClass.Flags)
   Output "------------------- A T T R I B U T E S --------------------"
   Dim MetaAttr
   For Each MetaAttr In MetaClass.Attributes
      Output "   " & MetaAttr.PublicName & " (" & MetaAttr.LocalizedName & ") " & CStr(MetaAttr.Type)
   Next
   Output "------------------ C O L L E C T I O N S -------------------"
   Dim MetaColl
   For Each MetaColl In MetaClass.Collections
      Output "   " & MetaColl.PublicName & " (" & MetaColl.LocalizedName & ") " & MetaColl.ContentClass.PublicName & ": " & CStr(MetaColl.ContentKind)
   Next
   Output "-------------------- H I E R A R C H Y ---------------------"
   ShowBranch(MetaClass)
   Output "-------------------------------------------------------------"
   Output ""
   
End Sub

Output "-------------------------------------------------------------"
Output "MetaModel version: " & MetaModel.Version
Output "-------------------------------------------------------------"
ShowMetaClassContent "MetaModel's meta class"    , MetaModel.MetaClass
ShowMetaClassContent "MetaClass's meta class"    , MetaModel.GetMetaClassByPublicName("PdCommon.MetaClass").MetaClass
ShowMetaClassContent "MetaAttribute's meta class", MetaModel.GetMetaClassByKind(PdCommon.cls_MetaAttribute).MetaClass
Output ""
Output "Libraries:"
Dim Library
For Each Library In MetaModel.Libraries
   Output " - """ & Library.LocalizedName & """ (" & Library.PublicName & ") defining " & CStr(Library.Classes.Count) & " classes"
Next

ShowMetaClassContent "Active model meta class", ActiveModel.MetaClass
