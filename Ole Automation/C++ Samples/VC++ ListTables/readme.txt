This program shows how to use OLE automation and C++ to control PowerDesigner from outside of PowerDesigner.
This program allows you to select a PDM model, display list of tables and create new tables.
It uses Microsoft Visual Studio 2008 and MFC.

To compile this program, you can use Microsoft Visual Studio 2008 or 2010.
The #import statement imports the PowerDesigner Type Library and creates header files.
The PowerDesigner DLLs pdobj16.dll and shpdm16.dll should be accessible in the include path.
You could also copy these two DLLs in the Src directory.

For object variables type, you should use <Module>::<Class>Ptr.
For example, use PdPDM::TablePtr instead of PdPDM::Table.

For object class ID, you can use <Module>::cls_<Class>.
For exammpe, PdPDM::cls_Table.

For collection variables type, you can use ObjectColPtr or PdCommon::ObjectColPtr.
