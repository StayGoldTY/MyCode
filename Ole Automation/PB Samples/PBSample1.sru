//*****************************************************************************
// File:     PBSample1.sru
// Purpose:  This PowerBuilder program shows how to use PowerBuilder to create a PowerDesigner OOM model.
//           You need to copy/paste this code into a PowerBuilder function.
// Title:    Create OOM
// Category: Create OOM
// Company:  Sybase Inc.
// Author:   
// Created:  
// Modified: 
// Version:  1.0
// Comment:  
//*****************************************************************************


// Define PowerDesigner PdOOM constants
// For other constants, see the VBScriptConstants.vbs file
constant long PdOOM_Model     = 403775584 // Model
constant long PdOOM_Class     = 403775587 // Class
constant long PdOOM_Attribute = 403775589 // Attribute
constant long PdOOM_Operation = 403775590 // Operation

// Get the PowerDesigner Application object
OLEObject PD
PD = Create oleobject
if (PD.ConnectToNewObject("PowerDesigner.Application.16.5") <> 0) then
	MessageBox("Error", "Cannot create PowerDesigner Application object.  Please verify that PowerDesigner is well installed.")
	return
end if	

// Create an OOM model
OLEObject model
setNull(model)
model = PD.CreateModel(PdOOM_Model, "|Language=PowerBuilder|Diagram=ClassDiagram")
if IsNull(model) then
	MessageBox("Error", "Cannot create PowerDesigner Object-Oriented Model.  Please verify that PowerDesigner OOM is well installed.")
	return
end if	
model.name = "PowerBuilder for PowerDesigner"
model.code = "PowerBuilder"

// Create a Package
OLEObject pack
pack = model.Packages.CreateNew()
pack.name = "Customers"
pack.code = "Customers"
// Get class diagram
OLEObject diagram
if model.ClassDiagrams.Count > 0 Then	
   diagram = model.ClassDiagrams.Item(0)   
   // Show symbol
   diagram.AttachObject(pack)
end if

// Create a Class
OLEObject cls
cls = pack.Classes.CreateNew()
cls.name = "Customer"
cls.code = "customer"
cls.Stereotype = "userObject"
// Get class diagram
if (pack.ClassDiagrams.Count > 0) then
   diagram = pack.ClassDiagrams.Item(0)
   // Show symbol
   diagram.AttachObject(cls)
end if

// Create an attribute
OLEObject attr
attr = cls.Attributes.CreateNew()
attr.name = "Name"
attr.code = "name"
attr.datatype = "string"

// Create an operation
OLEObject oper
oper = cls.Operations.CreateNew()
oper.name = "getName"
oper.code = "getname"
oper.returntype = "string"
oper.body="return name"

// Release the reference to PowerDesigner Application object
PD.DisconnectObject()

MessageBox("Information", "Successfully created a PowerDesigner Object-Oriented Model for PowerBuilder.")
