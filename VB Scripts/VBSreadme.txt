VBS Release Notes for PowerDesigner[TM] 

(c) 1991-2005 Sybase, Inc. and its subsidiaries. All rights reserved.
Updated 2005-12-01

This directory contains some Visual Basic Script.
This file sorts them and gives a short description for each of them.


VBS Samples
===========

General

Command Execution		How to execute a command
Interactive Mode		Demo of the interactive mode
ReadFile			How to read a file
WriteFile			How to write a file
Export_model_To_Excel		How to copy/paste of information into Excel
ODBCConnect			How to establish an ODBC connection

Data manipulation

ManipulatingObjects.vbs 	How to perform a various set of manipulations on objects
create_projectCDM		How to create a complete CDM
Create OOM			How to create an OOM
Delete Private attributes	How to delete private attributes
List Classes			How to list classes in an OOM
List Classifiers		How to list classifiers in an OOM
List Processes			How to list processes in a BPM
List Tables			How to list tables in a PDM
read_models			How to scan a model
AccessRTFDescription		How to access descriptions that are saved in RTF format

MetaModelBrowse			Demonstrate browsing meta model of the current model
WorkspaceBrowse			Demonstrate manipulation of the workspace

Tools
====

prefix				Inserts a 'T_' prefix on Domain code in a PDM
name2code			Copies name into code for tables, columns and views in a PDM
code2name			Copies code into name for tables and columns in a PDM
MeasurePDMcomplexity		Counts objects in a PDM
Convert_class_to_interface	Converts a class into an interface in an OOM
norm_ClassModel			Normalizes class and interface names
BPM-Activity			Converts a BPM into an OOM containing activity diagrams
BPM-CDM				Transfers ressource information from a BPM into a CDM
CreateViews			Creates a view for each table

BuildModelDependencies  	Build a free model describing the dependencies around a model
				The base model is the current model

FromDirectoryToModel		Create a free model that describe the content of the directory
				A file object is created for each file and a package for each subdirectory
FromDirectoryToRepository	Consolidate the content of a directory. 
				A folder is created for each subdirectory.				
FromDirectoryToWorkspace	Create a workspace file based on a repository content
From RepositorytoDirectory	Extract all the models in a repository to their default location

CollaborationToSequence		Transform a collaboration diagram into a sequence diagram
SequenceTocollaboration		Transform a sequence Diagram into a collaboration diagram

GenerateDatabase		Executes database generation methods 
				(generate database, modify database, generate test data)
GenerateDatabaseUsingSelections     Executes database and test data generation using selections defined in project.pdm

GenerateDBwithSetting		How to generate a dabase using settings

ReverseEngineerDatabase		Executes a database reverse from an ODBC data source and a generation from a selection built in the script

CheckModel			Executes check model with a specific check selected

CreatePersistentSelection	Creates a PDM containing some persistent selections