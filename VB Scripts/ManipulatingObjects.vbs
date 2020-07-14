' ****************************************************************************
' *
' * This script demonstates generic object manipulation in scripting
' *
' * - Creating a model
' * - Opening a model
' * - Creating Object inside a model
' * - Creating Object inside a package 
' * - Deleting an Object from a model
' * - Retrieving an object in a model
' * - Creating Shortcuts in a model
' * - Creating A Link Object in a model
' * - Manipulating objects in Collections
' * - Displaying Objects in a diagram
' * - Dynamically Extending the metamodel
' * - Manipulating Objects Extended properties
' *
' ****************************************************************************


option explicit



' *****************
' Creating a model
' *****************

' Call the CreateModel global function with following parameters:
'  - The model kind is an Object Oriented Model (PdOOM.Cls_Model)
'  - The Language is enforced to be Analysis
'  - The first diagram will be a class diagram
'  - The language definition (for Analysis) is copied inside the model
'  - The first diagram will not be opened in a window
'  - The new created model will not appear in the workspace
Dim NewModel
set NewModel = CreateModel(PdOOM.Cls_Model, "|Language=Java|Diagram=ClassDiagram|Copy", omf_DontOpenView Or omf_Hidden)
If NewModel is Nothing then
   msgbox "Fail to create UML Model", vbOkOnly, "Error"    ' Display an error message box
Else
   output "The UML model has been successfully created"    ' Display a message in the application output window

   ' Initialize model name and code
   NewModel.Name = "Sample Model"
   NewModel.Code = "Sample"
      
   ' Save the new model in a file
   NewModel.Save "c:\temp\MySampleModel.oom"
   
   ' Close the model
   NewModel.Close
      
   ' Release last reference to the model object to free memory
   Set NewModel = Nothing
End If


' ****************
' Opening a model
' ****************

' Call the OpenModel global function with following parameters:
'  - The model file name
'  - The default diagram will not be opened in a window
'  - The opened model will not appear in the workspace
Dim ExistingModel, FileName
FileName = "c:\temp\MySampleModel.oom"
On Error Resume Next          ' Avoid generic scripting error message like 'Invalid File Name   
Set ExistingModel = OpenModel(FileName, omf_DontOpenView Or omf_Hidden)
On Error Goto 0               ' Restore runtime error detection
If ExistingModel is nothing then
   msgbox "Fail to open UML Model:" + vbCrLf + FileName, vbOkOnly, "Error"    ' Display an error message box
Else
   output "The UML model has been successfully opened"    ' Display a message in the application output window
End If


' *******************************
' Creating Object inside a model
' *******************************
If not ExistingModel is Nothing Then

   ' Call the CreateNew() method on the collection that owns the object
   Dim MyClass
   Set MyClass = ExistingModel.Classes.CreateNew()
   If MyClass is nothing Then
      msgbox "Fail to create a class", vbOkOnly, "Error"    ' Display an error message box
   Else
      output "The class objects has been successfully created"    ' Display a message in the application output window
   
      ' Initialize its name and code using a specific method
      ' that ensures naming conventions (Uppercase or lowercase constraints,
      ' invalid characters...) are respected and that the name and code 
      ' are unique inside the model
      MyClass.SetNameAndCode "Customer", "cust"
      
      ' Initialize other properties directly
      MyClass.Comment = "Created by script"
      MyClass.Stereotype = "MyStereotype"
      MyClass.Final = true
      
      ' Create an attribute inside the class
      Dim MyAttr
      Set MyAttr = MyClass.Attributes.CreateNew()
      If not MyAttr is nothing Then
         output "The class attribute has been successfully created"
         MyAttr.SetNameAndCode "Name", "custName"
         MyAttr.DataType = "String"
         Set MyAttr = Nothing
      End If
      
      ' Reset the variable in order to avoid memory leaks
      Set MyClass = Nothing
      
   End If
End If


' *********************************
' Creating Object inside a package
' *********************************
If not ExistingModel is Nothing Then

   ' Create a package first
   Dim MyPckg
   Set MyPckg = ExistingModel.Packages.CreateNew()
   If not MyPckg is Nothing then
      output "The package has been successfully created"
      MyPckg.SetNameAndCode "All interfaces", "intf"
      
      ' Create an interface object inside the package
      Dim MyIntf
      Set MyIntf = MyPckg.Interfaces.CreateNew()
      If not MyIntf is Nothing then
         output "The interface object has been successfully created inside the package"
         MyIntf.SetNameAndCode "Customer Interface", "custIntf"
         Set MyIntf = Nothing
      End If
      
      Set MyPckg = Nothing
   End If
End If


' ********************************
' Deleting an Object from a model
' ********************************
If not ExistingModel is Nothing Then

   ' Create another class first
   Dim MyClassToDelete
   Set MyClassToDelete = ExistingModel.Packages.CreateNew()
   If not MyClassToDelete is Nothing then
      output "The second class has been successfully created"
      
      ' Just call Delete method to delete the object
      ' This will remove the object from the collection of model classes
      MyClassToDelete.Delete
      
      ' The object is still alive but it has notified all other
      ' objects of its deletion. It is no more associated with other objects.
      ' Its status is deleted
      If MyClassToDelete.IsDeleted() Then
         output "The second class has been successfully deleted"
      End If
      
      ' The reset of the VbScript variable will release the last
      ' reference to this object abd provoke the physical destruction
      ' and free the memory
      Set MyClassToDelete = Nothing
   End If
End If


' ********************************
' Retrieving an object in a model
' ********************************

' Call a function that is implemented just after in the script
Dim FoundIntf, FoundClass
Set FoundIntf = RetrieveByCode(ExistingModel, PDOOM.Cls_Interface, "custIntf")
Set FoundClass = RetrieveByCode(ExistingModel, PDOOM.Cls_Class, "cust")
If (not FoundIntf is nothing) and (not FoundClass is Nothing) Then
   output "The class and interface objects have been successfully retrieved by their code"
End If

' Implement a method that retrieve an object by code
' The first parameter is the root folder on which the research begins
' The second parameter is the kind of object we are looking for
' The third parameter is the code of the object we are looking for
Function RetrieveByCode(RootObject, ObjectKind, CodeValue)

   ' Test root parameter
   If RootObject is nothing Then
      Exit Function                 ' Root object is not defined
   End If
   If RootObject.IsShortcut() Then
      Exit Function                 ' Root object is a shortcut
   End If
   If not RootObject.IsKindOf(Cls_BaseFolder) Then
      Exit Function                 ' Root object is not a folder
   End If

   ' Loop on all objects in folder
   Dim SubObject
   For Each SubObject in RootObject.Children
      If SubObject.IsKindOf(ObjectKind) and SubObject.Code = CodeValue Then
         Set RetrieveByCode = SubObject         ' Initialize return value
         Set SubObject = Nothing
         Exit Function
      End If
   Next
   Set SubObject = Nothing
   
   ' Recursive call on sub-folders
   Dim SubFolder
   For Each SubFolder in RootObject.CompositeObjects
      If not SubFolder.IsShortcut() Then
         Dim Found
         Set Found = RetrieveByCode(SubFolder, ObjectKind, CodeValue)
         If not Found Is Nothing Then
            Set RetrieveByCode = Found         ' Initialize return parameter
            Set Found = Nothing
            Set SubFolder = Nothing
            Exit Function
         End If
      End If
   Next
   Set SubFolder = Nothing
   
End Function


' *******************************
' Creating Shortcuts in a model
' *******************************

' We want to reuse at the model level the interface defined in the package
' To do that, we need to create a shortcut of the interface at the model level
Dim IntfShct
If not FoundIntf is Nothing and not ExistingModel Is Nothing Then
   ' Call the CreateShortcut() method and specify the model 
   ' for the package where we want to create the shortcut
   Set IntfShct = FoundIntf.CreateShortcut(ExistingModel)
   If not IntfShct is nothing then
      output "The interface shortcut has been successfully created"
   End If   
End If


' **********************************
' Creating A Link Object in a model
' **********************************

Dim MyRealization
If (not ExistingModel Is Nothing) and (not FoundClass Is Nothing) and (not IntfShct is Nothing) Then
   ' We are now going to create a realization link between the class and the interface
   ' The link is an object like others with two mandatory attributes: Object1 and Object2
   ' For oriented links, Object1 is the source and Object2 is the destination
   Set MyRealization = ExistingModel.Realizations.CreateNew()
   If not MyRealization is Nothing then
      output "The realization link has been successfully created"
      ' Initialize both extremities
      Set MyRealization.Object1 = FoundClass
      Set MyRealization.Object2 = IntfShct
      ' Initialize Name and Code
      MyRealization.SetNameAndCode "Realize Main interface", "Main"
   End If
End If


' ************************************
' Manipulating objects in Collections
' ************************************

If (not ExistingModel Is Nothing) and (not FoundClass Is Nothing) Then

   ' We are going to create business rule objects andattached them to the class
   
   ' Create first the business rule objects
   Dim Rule1, Rule2
   Set Rule1 = ExistingModel.BusinessRules.CreateNew()
   Set Rule2 = ExistingModel.BusinessRules.CreateNew()
   
   If (not Rule1 is Nothing) And (not Rule2 Is Nothing) Then
      output "Business Rule objects have been successfully created"
      
      ' Initialize rule attributes
      Rule1.SetNameAndCode "Mandatory Name", "mandatoryName"
      Rule1.ServerExpression = "The Name attribute cannot be empty"
      Rule2.SetNameAndCode "Unique Name", "uniqueName"
      Rule2.ServerExpression = "The Name attribute must be unique"
      
      ' Retrieve the first object in the class attributes collection
      Dim FirstAttr, AttrColl
      Set AttrColl = FoundClass.Attributes
      If not AttrColl is Nothing Then
         If not AttrColl.Count = 0 then
            Set FirstAttr = AttrColl.Item(0)
         End If
      End If
      Set AttrColl = Nothing
      
      If not FirstAttr is Nothing Then
         output "First class attribute successfully retrieved from collection"
         
         ' Add Rule1 at end of attached rules collection
         FirstAttr.AttachedRules.Add Rule1
         ' Add Rule2 at the beginning of attached rules collection
         FirstAttr.AttachedRules.Insert 0, Rule2
         ' Move Rule2 at end of collection
         FirstAttr.AttachedRules.Move 1, 0
         ' Remove Rule1 from collection
         FirstAttr.AttachedRules.RemoveAt 0
         
         Set FirstAttr = Nothing
      End If
      
   End If
   
   Set Rule1 = Nothing
   Set Rule2 = Nothing
   
End If


' ********************************
' Displaying Objects in a diagram
' ********************************

If not ExistingModel Is Nothing and not MyRealization Is Nothing Then
   ' Symbols are specific kind of objects that can be manipulated by script
   ' We are now going to display the class, interface and realization in the
   ' main diagram of the model and customize their presentation
   
   ' Retrieve main diagram
   Dim MyDiag
   Set MyDiag = ExistingModel.DefaultDiagram
   If not MyDiag is Nothing and MyDiag.IsKindOf(PdOOM.Cls_ClassDiagram) Then
   
      ' Display the class, interface shortcut and realization link in the diagram
      ' using default positions and display preferences
      Dim MyClassSym, MyIntfSym, MyRlzsSym
      Set MyClassSym = MyDiag.AttachObject(FoundClass)
      Set MyIntfSym  = MyDiag.AttachObject(IntfShct)
      Set MyRlzsSym  = MyDiag.AttachLinkObject(MyRealization, MyClassSym, MyIntfSym)
      If not MyRlzsSym is Nothing Then
         output "Objects have been successfully displayed in diagram"
      End If
      
      ' Another way to do the same is the use of AttachAllObjects() method:
      ' MyDiag.AttachAllObjects
      
      ' Changes class symbol format
      If not MyClassSym is nothing Then
         MyClassSym.BrushStyle = 1                    ' Solid background (no gradient)
         MyClassSym.FillColor = RGB(255, 126, 126)    ' Red background color
         MyClassSym.LineColor = RGB(0, 0, 0)          ' Black line color
         MyClassSym.LineWidth = 2                     ' Double line width
         Dim Fonts
         Fonts = "ClassStereotype " + CStr(RGB(50, 50, 126)) + " Arial,8,I"
         Fonts = Fonts + vbCrLf + "DISPNAME " + CStr(RGB(50, 50, 50)) + " Arial,12,B"
         Fonts = Fonts + vbCrLf + "ClassAttribute " + CStr(RGB(150, 0, 0)) + " Arial,8,N"
         MyClassSym.FontList = Fonts                  ' Change font list
      End If
      
      ' Changes interface symbol position
      If not MyIntfSym is nothing Then
         Dim IntfPos
         Set IntfPos = MyIntfSym.Position
         If not IntfPos is Nothing Then
            IntfPos.x = IntfPos.x + 5000
            IntfPos.y = IntfPos.y + 5000
            MyIntfSym.Position = IntfPos
            Set IntfPos = Nothing
         End If
      End If
      
      ' Changes the link symbol corners
      If not MyRlzsSym is Nothing Then
         Dim CornerList, Point1, Point2
         Set CornerList = MyRlzsSym.ListOfPoints
         Set Point1 = CornerList.Item(0)
         Set Point2 = CornerList.Item(1)
         CornerList.InsertPoint 1, Max(Point1.x, Point2.x), Min(Point1.y, Point2.y)
         Set CornerList = Nothing
         ' Max and Min are functions defined at end of this script
      End If
      
      ' Release the variables
      Set MyDiag = Nothing
      Set MyClassSym = Nothing
      Set MyIntfSym = Nothing
      Set MyRlzsSym = Nothing
      
   End If
End If


' ************************************
' Dynamically Extending the metamodel
' ************************************

' During an import of file using script, some properties that do not correspond
' to standard attributes can be imported as extended attributes or extended collections.
' We provide several methods to extend the metamodel dynamically
If not ExistingModel Is Nothing Then

   ' Creating a new extended model definition
   Dim ModelExtension
   Set ModelExtension = ExistingModel.ExtendedModelDefinitions.CreateNew()
   If not ModelExtension is Nothing Then
      output "Model extension successfully created in model"
   
      ' Initialize model extension attributes
      ModelExtension.Name = "Extension for Import of XXX files"
      ModelExtension.Code = "importXXX"
      ModelExtension.Family = "Import"
      
      ' Defines a new Stereotype for the Class metaclass in the profile section
      Dim MySttp
      Set MySttp = ModelExtension.AddMetaExtension(PdOOM.Cls_Class, Cls_StereotypeTargetItem)
      If not MySttp Is Nothing Then
         output "Stereotype extension successfully created in extended model definition"
         
         MySttp.Name = "MyStereotype"
         MySttp.UseAsMetaClass = true   ' The stereotype will behave as a new metaclass (specific list and category in browser)
         
         ' Defines an extended attribute for this stereotype
         Dim MyExa
         Set MyExa = MySttp.AddMetaExtension(Cls_ExtendedAttributeTargetItem)
         If not MyExa is Nothing Then
            output "Extended Attribute successfully created in extended model definition"
            MyExa.Name = "MyAttribute"
            MyExa.Comment = "custom attribute coming from import"
            MyExa.DataType = 10  ' This corresponds to integer
            MyExa.Value = "-1"   ' This is the default value
            Set MyExa = Nothing
         End If
         
         ' Defines an extended collection for this stereotype
         Dim MyExCol
         Set MyExCol = MySttp.AddMetaExtension(Cls_ExtendedCollectionTargetItem)
         If not MyExCol is Nothing Then
            output "Extended collection successfully created in extended model definition"         
            MyExCol.Name = "MyCollection"
            MyExCol.Comment = "custom collection coming from import"
            MyExCol.DestinationClassKind = PdOOM.Cls_class  ' The collection can store only classes
            MyExCol.Destinationstereotype = "MyStereotype"  ' The collection can store only classes with stereotype "MyStereotype"
            
            Set MyExCol = Nothing
         End If
         
         Set MySttp = Nothing
      End If
      
      Set ModelExtension = Nothing
   End If
   
End If

' *****************************************
' Manipulating Objects Extended properties
' *****************************************
If (not ExistingModel Is Nothing) and (not FoundClass Is Nothing) Then
   
   ' Extended properties like attributes and collections
   ' can be defined dynamically and therefore cannot be accessed directly
   ' like standard attributes: FoundClass.MyAttribute does not work!
   ' We provide generic accessors to get or set these extended properties
   
   ' Modify extended attribute on the class
   Dim ExaName 
   ExaName = "importXXX.MyAttribute"  ' attribute name prefixed by extended model definition code
   If FoundClass.HasExtendedAttribute(ExaName) Then
      output "Extended attribute can be accessed"         
      
      FoundClass.SetExtendedAttributeText ExaName, "1024"
      FoundClass.SetExtendedAttribute ExaName, 2048
      
      Dim valAsText, valAsInt
      valAsText = FoundClass.GetExtendedAttributeText(ExaName)
      valAsInt = FoundClass.GetExtendedAttribute(ExaName)
   End If
   
   ' Modify extended collection on the class
   Dim ExColName, ExCol
   ExColName = "importXXX.MyCollection"  ' collection name prefixed by extended model definition code
   Set ExCol = FoundClass.GetExtendedCollection(ExColName)
   If not ExCol is Nothing Then
      output "Extended collection can be accessed"             

      ' The extended collection can be used as a standard collection
      ' for example, we add the class in its own extended collection
      ExCol.Add FoundClass
      
      Set ExCol = Nothing
   End If
   
End If




' Close and Free memory
Set FoundIntf = Nothing
Set FoundClass = Nothing
Set IntfShct = Nothing
Set MyRealization = Nothing
If not ExistingModel is Nothing Then
   output "End of script."
   ExistingModel.Save "c:\temp\MySampleModelAtEnd.oom"
   ExistingModel.Close
   Set ExistingModel = Nothing
End If

' Helper functions
Function Max(x, y)
   if x >= y then
      Max = x
   Else
      Max = y
   End If
End Function

Function Min(x, y)
   if x <= y then
      Min = x
   Else
      Min = y
   End If
End Function
