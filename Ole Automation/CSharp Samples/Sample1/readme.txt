This program shows how to use OLE automation and a C# program to control PowerDesigner from outside of PowerDesigner.
This program allows you to create a PowerDesigner PDM model. 

To communicate with PowerDesigner, this program creates a PowerDesigner application object using COM.

To run this program, you need to install the .NET Framework.
You can download the .NET Framework from the Microsoft Web site.

This program needs to access the Sybase PdCommon and Sybase PdPDM type libraries.
You need to add these type libraries in the list of library references in Visual Studio:
- Open a project in Visual Studio
- Right click on References
- Select Add Reference
- Click on the COM tab
- Click on the Sybase PdCommon 16.5 Type Library
- Hold the Control key and click on the Sybase PdPDM 16.5 Type Library
- Click on OK
Visual Studio will create the Interop.PdCommon.dll and Interop.PdPDM.dll wrapper DLLs for PowerDesigner 16.
