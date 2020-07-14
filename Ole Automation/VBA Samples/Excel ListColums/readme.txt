This sample shows how to use an Excel macro and form to allow users to select a PDM, table and column criteria 
to create a customized list of columns spreadsheet in Microsoft Excel.

To use the this sample in Excel:
- Launch Excel
- Select Tools>Macro>Visual Basic Editor
- In the project explorer, right click on a project node, select Import File
- Choose the ListColumns.bas file.  A ListColumns module will be created under the project.
- Right click on the project workbook node again, select Import File
- Choose the Criteria.frm file.  A Criteria form will be created under the project.
- In the Tools>References window, add the Sybase PdCommon Type Library and the Sybase PdOOM Type Library.
- Double click on the ListColumns module to show the program code.  This ListColumns procedure is used to open the Criteria form.
- Run the ListColumns macro.

To invoke this macro from a toolbar or menu:
- In Excel, right click on a toolbar.
- Select Customize
- In the Commands tab, click on Macros in the list of categories.
- Drag the Custom menu item or custom button, drop it in a menu or toolbar from where you want to launch the macro.
- Right click on the new menu item or toolbar button.
- Rename the menu item or button if necessary.
- In the popup menu, select Assign Macro.
- Select the ListColumns macro.
- Close the Customize menus and toolbars window.
- Click on the new menu item or button to launch the macro.

Notes:
- When you add the ListColumns module and the Criteria form, they are added inside the project of a workbook.
- If you want to share the same macro, you need to copy the module and form into other projects in the project explorer.
- For more information about Excel macro, please refer to the online help of the Excel Visual Basic Editor.