package createOOM;

import org.eclipse.swt.internal.ole.win32.COM;
import com.sybase.stf.powerdesigner.PdCommon.*;
import com.sybase.stf.powerdesigner.PdOOM.*;

/**
 * @author Xiao Wang
 *
 * This Java sample program shows how to use PowerDesigner Java proxies and 
 * OLE automation to create a PowerDesigner OOM model and display the contains of the OOM model.
 */
public class CreateOOM {

   /** PowerDesigner application object */
   private Application pdApp;
   
   private int nbClasses;
   
   /** 
    * Program entry point 
    */
   public static void main(String[] args) {
      // Create an instance of this class
      CreateOOM createOOM = new CreateOOM();
      // Create an OOM and display the result
      createOOM.CreateAndDisplayOOM();
   }

   /**
    *  Create an OOM and display the result 
    */
   public void CreateAndDisplayOOM() {
      int hr = COM.OleInitialize(0);
      try {
         // Get PowerDesigner application instance and start PowerDesigner if necessary
         pdApp = Application.getInstance();
         if (pdApp != null)
         {
            // Create an OOM
            Model newModel;
            newModel = createOOM();
         
            // Show the information of the current OOM
            showOOMInfo();
                 
            // Release PowerDesigner application.  
            // This may close PowerDesigner if PowerDesigner was started by this program.
            // pdApp.Release();
         }
      }
      catch (Exception e) {
	 System.out.println("Cannot create PowerDesigner application object.  Please verify that PowerDesigner is installed.");
      }
      finally {
         if (hr == COM.S_OK)
            COM.OleUninitialize();
      }
   }
      
   /**
    *  Create an OOM for Java
    */
   public Model createOOM() {
      try {
         // Create an OOM model, use Java as the language, create a default class diagram
         // Convert the return object to PdOOM.Model proxy object
         Model newModel = new Model(pdApp.CreateModel(PdOOM_Classes.cls_Model, "|Language=Java|Diagram=ClassDiagram"));
         // set name and code
         newModel.SetName("Customer Management");
         newModel.SetCode("CustomerManagement");

         // Create a customer class.  
         // Use the fully qualified name here to avoid conflict with Java
         com.sybase.stf.powerdesigner.PdOOM.Class newClass1 =
            new com.sybase.stf.powerdesigner.PdOOM.Class(newModel.GetClasses().CreateNew());
         newClass1.SetName("Customer");
         newClass1.SetCode("Customer");
         newClass1.SetComment("Customer class");

         Attribute newAttribute;
         // Create an id attribute
         newAttribute = new Attribute(newClass1.GetAttributes().CreateNew());
         newAttribute.SetName("Id");
         newAttribute.SetCode("id");
         // id is the primary identifier (primary key)
         newAttribute.SetPrimaryIdentifier(true);
         // set the Java data type
         newAttribute.SetDataType("int");

         // Create a name attribute
         newAttribute = new Attribute(newClass1.GetAttributes().CreateNew());
         newAttribute.SetName("Name");
         newAttribute.SetCode("name");
         // set the Java data type
         newAttribute.SetDataType("java.lang.String");

         // Create a phone attribute
         newAttribute = new Attribute(newClass1.GetAttributes().CreateNew());
         newAttribute.SetName("Phone");
         newAttribute.SetCode("phone");
         // set the Java data type
         newAttribute.SetDataType("java.lang.String");

         // Create an email attribute
         newAttribute = new Attribute(newClass1.GetAttributes().CreateNew());
         newAttribute.SetName("Email");
         newAttribute.SetCode("email");
         // set the Java data type
         newAttribute.SetDataType("java.lang.String");

         // Create an SalesOrder class.  
         // Use the fully qualified name here to avoid conflict with Java
         com.sybase.stf.powerdesigner.PdOOM.Class newClass2 =
            new com.sybase.stf.powerdesigner.PdOOM.Class(newModel.GetClasses().CreateNew());
         newClass2.SetName("SalesOrder");
         newClass2.SetCode("SalesOrder");
         newClass2.SetComment("Sales order class");

         // Create an orderId attribute
         newAttribute = new Attribute(newClass2.GetAttributes().CreateNew());
         newAttribute.SetName("Order id");
         newAttribute.SetCode("orderId");
         // id is the primary identifier (primary key)
         newAttribute.SetPrimaryIdentifier(true);
         // set the Java data type
         newAttribute.SetDataType("int");

         // Create an orderDate attribute
         newAttribute = new Attribute(newClass2.GetAttributes().CreateNew());
         newAttribute.SetName("Order date");
         newAttribute.SetCode("orderDate");
         // set the Java data type
         newAttribute.SetDataType("java.util.Date");

         // Create an association
         Association association1 = new Association(newModel.GetAssociations().CreateNew());
         // Set linked classes
         association1.SetObject1(newClass1);
         association1.SetObject2(newClass2);
         // Set role A name and multiplicity
         association1.SetRoleAName("customer");
         association1.SetRoleAMultiplicity("1");
         // Set role B name and multiplicity
         association1.SetRoleBName("orders");
         association1.SetRoleBMultiplicity("0..*");

         // Get the default class diagram
         ClassDiagram newDiagram = new ClassDiagram(newModel.GetDefaultDiagram());

         // show the symbol in the default diagram if it is a class diagram
         newDiagram.AttachObject(newClass1);
         newDiagram.AttachObject(newClass2);
         newDiagram.AttachLinkObject(association1);
         
         return newModel;
	  }
	  catch (Exception e) {
		 e.printStackTrace();
		 return null;
	  }
   }
   
   /**
    *  Display information about the currnt OOM
    */
   public void showOOMInfo() {
      try {
         // Get the current OOM model
         if (!pdApp.GetActiveModel().isNull())
         {
            if (pdApp.GetActiveModel().IsKindOf(PdOOM_Classes.cls_Model))
            {
               // Convert the active model to an OOM model proxy object
               Model aModel = new Model(pdApp.GetActiveModel());

               // Initialize the number of classes
               nbClasses = 0;
                              
               // Display a message in PowerDesigner outut window
               pdApp.Output("Display the list of classes in the system output window.");
               
               // Show classes and packages defined under the model
               // Convert model proxy object to package proxy object
			   showPackageInfo(new com.sybase.stf.powerdesigner.PdOOM.Package(aModel));
			   
		       System.out.println("There are " + nbClasses + " class(es) in this model.");
			   
            }
            else
            {
               System.out.println("The current model is not an OOM model.");
            }
         }
         else
         {
            System.out.println("There is no active model opened in PowerDesigner.");
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   /**
    *  Display information about an OOM package
    */
   public void showPackageInfo(com.sybase.stf.powerdesigner.PdOOM.Package aPackage) {
      if (!aPackage.isNull() && !aPackage.IsShortcut())
      {
         // Display the number of classes and packages in the system output window
         System.out.println("The " + aPackage.GetObjectType() + " '" + aPackage.GetCode() + "' contains " + aPackage.GetClasses().GetCount() + " class(es), " + aPackage.GetPackages().GetCount() + " package(s).");

         // Use the fully qualified name here to avoid conflict with Java
         com.sybase.stf.powerdesigner.PdOOM.Class aClass;
         for (int n = 0; n < aPackage.GetClasses().GetCount(); n++)
         {
            nbClasses++;
            if (nbClasses < 100)
            {
               // display class info
               aClass = new com.sybase.stf.powerdesigner.PdOOM.Class(aPackage.GetClasses().Item(n));
               showClassInfo(aClass);
            }
            else
            {
               if (nbClasses == 100)            	
                  System.out.println("...");
               break;
            }
         }

         // display classes of subpackages         
         com.sybase.stf.powerdesigner.PdOOM.Package subPackage;
         for (int nPackage = 0; nPackage < aPackage.GetPackages().GetCount(); nPackage++)
         {
            subPackage = new com.sybase.stf.powerdesigner.PdOOM.Package(aPackage.GetPackages().Item(nPackage));
            showPackageInfo(subPackage);
         }
      }
   }
   
   /**
    *  Display information about a class
    */
   public void showClassInfo(com.sybase.stf.powerdesigner.PdOOM.Class aClass) {
      try {
         if (!aClass.isNull() && !aClass.IsShortcut())
         {
            System.out.println("Class No." + nbClasses + ": " + aClass.GetCode() + ", " + aClass.GetAttributes().GetCount() + " attribute(s), " + aClass.GetOperations().GetCount() + " operation(s)");
         }
      }
      catch (Exception e) {
	 e.printStackTrace();
      }
   }
}
