//*****************************************************************************
// File:     Form1.cs
// Purpose:  This program shows how to create a PowerDesigner PDM model using C#.
// Title:    Create PDM model
// Category: Create PDM
// Company:  Sybase Inc.
// Author:   Xiao Wang   
// Created:  
// Modified: 
// Version:  1.0
// Comment:  You need to add the Sybase PdCommon and the Sybase PdPDM type libraries in the type library references.
//           You need to define the contants for the object kinds you need to use.
//*****************************************************************************

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace CSharp_Sample1
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Button Button2;
		internal System.Windows.Forms.Button Button1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
         this.Label1 = new System.Windows.Forms.Label();
         this.Button2 = new System.Windows.Forms.Button();
         this.Button1 = new System.Windows.Forms.Button();
         this.SuspendLayout();
         // 
         // Label1
         // 
         this.Label1.Location = new System.Drawing.Point(16, 16);
         this.Label1.Name = "Label1";
         this.Label1.Size = new System.Drawing.Size(400, 89);
         this.Label1.TabIndex = 5;
         this.Label1.Text = "This program shows how to use C# and OLE automation to create a PowerDesigner PDM" +
            ".";
         // 
         // Button2
         // 
         this.Button2.Location = new System.Drawing.Point(288, 144);
         this.Button2.Name = "Button2";
         this.Button2.Size = new System.Drawing.Size(133, 40);
         this.Button2.TabIndex = 4;
         this.Button2.Text = "Exit";
         this.Button2.Click += new System.EventHandler(this.Button2_Click);
         // 
         // Button1
         // 
         this.Button1.Location = new System.Drawing.Point(144, 144);
         this.Button1.Name = "Button1";
         this.Button1.Size = new System.Drawing.Size(133, 40);
         this.Button1.TabIndex = 3;
         this.Button1.Text = "&Create PDM";
         this.Button1.Click += new System.EventHandler(this.Button1_Click);
         // 
         // Form1
         // 
         this.AutoScale = false;
         this.AutoScaleBaseSize = new System.Drawing.Size(6, 15);
         this.ClientSize = new System.Drawing.Size(432, 200);
         this.Controls.AddRange(new System.Windows.Forms.Control[] {
                                                                      this.Label1,
                                                                      this.Button2,
                                                                      this.Button1});
         this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
         this.MaximizeBox = false;
         this.MinimizeBox = false;
         this.Name = "Form1";
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
         this.Text = "C# for PowerDesigner Sample1";
         this.Load += new System.EventHandler(this.Form1_Load);
         this.ResumeLayout(false);

      }
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void Button1_Click(object sender, System.EventArgs e)
		{
         // Get PowerDesigner Application object
         PdCommon.Application pd;
         try
         {
            pd = new PdCommon.Application();
            if (pd != null)
		      {
               // Create a PDM model with a Physical Diagram
               PdPDM.Model model;
               model = (PdPDM.Model)pd.CreateModel((int)PdPDM.PdPDM_Classes.cls_Model, "|Diagram=PhysicalDiagram", 0);
               if (model != null)
               {
                  model.Name = "Customer Management";
                  model.Code = "CustomerManagement";

                  // Create a class diagram
                  PdPDM.PhysicalDiagram diagram;
                  diagram = (PdPDM.PhysicalDiagram)model.PhysicalDiagrams.Item(0);

                  // Create tables
                  CreateTables(model, diagram);

                  MessageBox.Show("Successfully created a PowerDesigner PDM model.", "C# for PowerDesigner Sample1", MessageBoxButtons.OK, MessageBoxIcon.Information);
               }
               else
               {
                  MessageBox.Show("Cannot create PDM model.", "C# for PowerDesigner Sample1", MessageBoxButtons.OK, MessageBoxIcon.Error);
               }
            }
         }
         catch (Exception ex)
         {
            MessageBox.Show("Cannot create PowerDesigner application object.  Please verify that PowerDesigner is installed and the PowerDesigner application object is registered.", 
                            "C# for PowerDesigner Sample1", MessageBoxButtons.OK, MessageBoxIcon.Error);
         }
      }

      // Create tables
      private void CreateTables(PdPDM.Model model, PdPDM.PhysicalDiagram diagram)
      {
         // Create a table
         PdPDM.Table tbl;
         tbl = (PdPDM.Table)model.CreateObject((int)PdPDM.PdPDM_Classes.cls_Table, "", -1, false);
         tbl.Name = "Customer";
         tbl.Code = "Customer";
         tbl.Comment = "Customer table";
         tbl.Description = "The Customer table stores the customers data.";

         // Create columns
         CreateColumns(tbl);

         // Create a symbol for the table
         diagram.AttachObject(tbl);
      }

      // Create columns
      private void CreateColumns(PdPDM.Table tbl)
      {
         PdPDM.Column coln;
         coln = (PdPDM.Column)tbl.Columns.CreateNew((int)PdPDM.PdPDM_Classes.cls_Column);
         coln.Name = "ID";
         coln.Code = "ID";
         coln.DataType = "integer";
         coln.Primary = true;

         coln = (PdPDM.Column)tbl.Columns.CreateNew((int)PdPDM.PdPDM_Classes.cls_Column);
         coln.Name = "Name";
         coln.Code = "Name";
         coln.DataType = "char(30)";
         coln.Length = 30;

         coln = (PdPDM.Column)tbl.Columns.CreateNew((int)PdPDM.PdPDM_Classes.cls_Column);
         coln.Name = "Phone";
         coln.Code = "Phone";
         coln.DataType = "char(20)";
         coln.Length = 20;

         coln = (PdPDM.Column)tbl.Columns.CreateNew((int)PdPDM.PdPDM_Classes.cls_Column);
         coln.Name = "Email";
         coln.Code = "Email";
         coln.DataType = "char(20)";
         coln.Length = 20;
      }

      private void Form1_Load(object sender, System.EventArgs e)
      {
         // Opening the form
      }

      private void Button2_Click(object sender, System.EventArgs e)
      {
         this.Close();
      }
   }
}
