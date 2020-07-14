This program shows how to use OLE automation and C++ to control PowerDesigner from outside of PowerDesigner.
This program allows you to select an OOM model, display list of classes and create new classes.
It uses Microsoft Visual Studio 2008 and MFC.

To compile this program, you can use Microsoft Visual Studio 2008 or 2010.
The #import statement imports the PowerDesigner Type Library and creates header files.
The PowerDesigner DLLs pdobj16.dll and shoom16.dll should be accessible in the include path.
You could also copy these two DLLs in the Src directory.

For object variables type, you should use <Module>::<Class>Ptr.
For example, use PdOOM::ClassPtr instead of PdOOM::Class.

For object class ID, you can use <Module>::cls_<Class>.
For exammpe, PdOOM::cls_Class.

For collection variables type, you can use ObjectColPtr or PdCommon::ObjectColPtr.

