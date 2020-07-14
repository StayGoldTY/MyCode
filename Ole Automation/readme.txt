PowerDesigner OLE Automation Samples

These OLE automation samples show you how to use OLE automation and any language that supports COM to work
with PowerDesigner from outside of PowerDesigner.
You can use, modify, publish or redistribute them without any restriction.

1) OLE Automation Overview
==========================
The PowerDesigner VBScript support allows you to work with the PowerDesigner objects.
The VBScript should be executed inside PowerDesigner.  You cannot use the same VBScript in another program, 
or use another language to work with PowerDesigner objects.

OLE Automation is similar to VBScript.  It also uses COM to create, modify and read objects.
But OLE automation allows you to use any language that supports COM (VBScript, VB, C#, VB. NET, C++, PowerBuilder, 
JavaScript, ...) to work with PowerDesigner objects from outside of PowerDesigner.
To use OLE automation, the PowerDesigner Application object should be registered.

The main differences between using OLE automation and VBScript inside PowerDesigner are:
- Create a PowerDesigner application object first.
- Prefix all the global properties and methods by the PowerDesigner application object.
- In VB and VBA programs, use typed variables (Dim model as PdPDM.Model instead of Dim model).
- In VB and VBA programs, if a function returns an object, the return type of the function should be declared.
- In VB, VBA, VB .NET and C#, you have to add references for the type libraries you want to use (PdCommon, PdPDM, ...).
- In VBA forms (Word, Excel, ...), the event handlers of a form should be named UserForm_<EventName>.
- In some languages, the syntax for class type constant is different.
- Release the PowerDesigner application object before exiting the program.

2) Registering PowerDesigner Application
========================================
To work with the PowerDesigner COM objects defined in each module, the PowerDesigner Application and Type Libraries should be registered.
PowerDesigner automatically register the application and type libraries when you install PowerDesigner.

In some cases, you may need to unregister and register manually (for exemple to have two versions of PowerDesigner working on the same computer).

To register the PowerDesigner Type Libraries manually:
- Go to the PowerDesigner home directory
- Run:
    pdlegacyshell16.exe /RegServer

To unregister the PowerDesigner Type Libraries manually:
- Go to the PowerDesigner home directory
- Run:
    pdlegacyshell116.exe /UnregServer

3) VBA Samples
==============
Folder: VBA Samples

Files:
   * CreateOOM.bas			This sample shows how to use VBA to create an OOM model from outside of PowerDesigner.

   * DeletePrivateAttributes.bas	This sample shows how to use VBA to delete private attributes of classes in the active OOM.
 
   * ListClasses.bas			This sample shows how to use VBA to show classes properties of the active OOM.

   * ListClassifers.bas			This sample shows how to use VBA to show classifers properties of the active OOM.

   * ListProcesses.bas			This sample shows how to use VBA to show processes properties of the active BPM.

   * ListTables.bas			This sample shows how to use VBA to show tables properties of the active PDM.

   * Excel ListColumns			This sample shows how to use an Excel macro and form to allow users to
					select a PDM, table and column criteria to create a customized list of columns
					spreadsheet in Microsoft Excel.

   * Word ListColumns			This sample shows how to use a Word macro and form to allow users to
					select a PDM, table and column criteria to create a customized list of columns
					table in Microsoft Word.

Notes:
The VBA samples work with Microsoft Visual Basic or in an VBA editor (Word macro, Excel macro, ...).

To use the VBA samples in a VBA editor:
- In Word (Excel, ...), select Tools>Macro>Visual Basic Editor
- In the project explorer, right click on a project node, select Import File
- Choose a VBA sample.  A new module will be created under the project.
- Double click on the new module to show the program code.
- In the Tools>References window, add all the Sybase type libraries you need (Sybase PdCommon, Sybase PdOOM, ...)
- In the program file, set focus to the main procedure.
- Run the macro.
- You could also add a form to invoke a Sub procedure and add a main Sub to show the form.

To use the VBA programs in Visual Basic:
- Create a VB project
- Add a form
- Copy/paste the VB program in the source code of the form
- Add a button in the form to invoke the main Sub procedure
- In the Project>References window, add all the Sybase type libraries you need (Sybase PdCommon, Sybase PdOOM, ...)
- Run the program
- Click on the button to invoke the procedure

4) HTML Samples
===============
Folder: HTML Samples

Files:
   * ListClassesVBScript.htm		This sample shows how to use VB Script in a HTML page to invoke PowerDesigner functions.
					This program displays classes properties defined in the active OOM model in the PowerDesigner
					output window.

   * ListClassesJScript.htm		This sample shows how to use JavaScript in a HTML page to invoke PowerDesigner functions.
					This program displays classes properties defined in the active OOM model in the PowerDesigner
					output window.

Notes:
To test these HTML files, you can double click on the file.

5) Visual Basic Samples
=======================
Folder: VB Samples

Subfolders:
   * Sample1				This samples shows how to use a VB program to create a new OOM and display OOM properties.

   * ListColumns			The ListColumns sample shows how to use a VB program to allow users to select a PDM, 
					select table and column criteria then create a customized List of Columns spreadsheet
					in Microsoft Excel.
Notes:
To run these programs, you can use the compiled .EXE files.
To modify the programs or to debug, you need to use Microsoft Visual Basic 6.0.

6) VB .NET Samples
==================
Folder: VB DOTNET Samples

Subfolders:
   * Sample1				This sample shows how to use VB .NET to create a new OOM.

Notes:
To run this program, you can use the compiled .EXE file.
To modify the program or to debug, you need to use Microsoft Visual Studio .NET.

7) C# Samples
=============
Folder: CSharp Samples

Subfolders:
   * Sample1				This sample shows how to use C# to create a new PDM.

Notes:
To run this program, you can use the compiled .EXE file.
To modify the program or to debug, you need to use Microsoft Visual Studio .NET.

8) C++ Samples
==============
Folder: C++ Samples

Subfolders:
   * VC++ ListClasses			This program allows you to select an OOM model, display list of classes and create new classes.

   * VC++ ListTables			This program allows you to select a PDM model, display list of tables and create new tables.

Notes:
To compile these programs, you need to use Microsoft Visual Studio.

9) Java Samples
===============
Folder: Java Samples

Subfolders:
   * Create OOM				This program allows you to create an OOM model using Java.

Notes:
To compile the program, you need to use Eclipse.

10) PowerBuilder Samples
========================
Folder: PB Samples

File:
   * PBSample1.sru			This sample shows how to use PowerBuilder to create a new OOM.

Notes:
To run this program, you need to copy/paste the code into a PowerBuilder function.

11) Constants for Object Types
==============================
* VBScriptConstants.vbs			This file defines all the PowerDesigner modules constants in VB syntax.
					For languages (JavaScript, PB, ...) that cannot access constants defined as enum 
					in the type libraries, you could use these constants.
					You may need to adapt the declaration syntax to your language.
					You can use a subset of the constants. 
					For example, you can use PdOOM_Class instead of PdOOM.cls_Model. 
