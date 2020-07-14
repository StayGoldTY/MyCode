; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CListClassesDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "ListClasses.h"

ClassCount=3
Class1=CListClassesApp
Class2=CListClassesDlg
Class3=CAboutDlg

ResourceCount=5
Resource1=IDD_LISTCLASSES_DIALOG (English (U.S.))
Resource2=IDR_MAINFRAME
Resource3=IDD_ABOUTBOX
Resource4=IDD_ABOUTBOX (English (U.S.))
Resource5=IDD_LISTCLASSES_DIALOG

[CLS:CListClassesApp]
Type=0
HeaderFile=..\H\ListClasses.h
ImplementationFile=..\Src\ListClasses.cpp
Filter=N

[CLS:CListClassesDlg]
Type=0
HeaderFile=..\H\ListClassesDlg.h
ImplementationFile=..\Src\ListClassesDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=CListClassesDlg

[CLS:CAboutDlg]
Type=0
HeaderFile=..\H\ListClassesDlg.h
ImplementationFile=..\Src\ListClassesDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=6
Control1=IDC_STATIC,static,1342177283
Control2=IDOK,button,1342373889
Control3=IDC_STATIC,static,1342308480
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308480
Control6=IDC_STATIC,static,1342308480

[DLG:IDD_LISTCLASSES_DIALOG]
Type=1
Class=CListClassesDlg
ControlCount=8
Control1=IDC_STATIC,static,1342308352
Control2=IDC_CB_OOMMODELS,combobox,1344471043
Control3=ID_REFRESH,button,1342373888
Control4=IDC_STATIC,static,1342308352
Control5=IDC_LIST_CLASSES,listbox,1352859907
Control6=IDOK,button,1342373889
Control7=IDCANCEL,button,1342373888
Control8=IDC_NEW_CLASS,button,1342373888

[DLG:IDD_LISTCLASSES_DIALOG (English (U.S.))]
Type=1
Class=CListClassesDlg
ControlCount=7
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_LIST_CLASSES,listbox,1352728835
Control4=IDC_CB_OOMMODELS,combobox,1344340227
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,static,1342308352
Control7=ID_REFRESH,button,1342242816

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=?
ControlCount=6
Control1=IDC_STATIC,static,1342177283
Control2=IDOK,button,1342373889
Control3=IDC_STATIC,static,1342308480
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308480
Control6=IDC_STATIC,static,1342308480

