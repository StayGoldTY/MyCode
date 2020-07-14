This sample shows how to use a Word macro and form to allow users to select a PDM, table and column criteria 
to create a customized list of columns table in Microsoft Word.

To use the this sample in Word:
- Launch Word
- Select Tools>Macro>Visual Basic Editor
- In the project explorer, right click on a project node, select Import File
- Choose the ListColumns.bas file.  A ListColumns module will be created under the project.
- Right click on the project node again, select Import File
- Choose the Criteria.frm file.  A Criteria form will be created under the project.
- In the Tools>References window, add the Sybase PdCommon Type Library and the Sybase PdOOM Type Library.
- Double click on the ListColumns module to show the program code.  This ListColumns procedure is used to open the Criteria form.
- Run the ListColumns macro.

To invoke this macro from a toolbar or menu:
- In Word, right click on a toolbar.
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
- When you add the ListColumns module and the Criteria form, they are added inside a project.
- If you want to share the same macro, you need to import them in the Normal project.
- If you want to use this macro only for the current document, you need to import them in the current document project.
- For more information about Word macro, please refer to the online help of the Word Visual Basic Editor.
