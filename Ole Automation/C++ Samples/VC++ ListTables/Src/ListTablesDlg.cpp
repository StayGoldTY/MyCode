// ListTablesDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ListTables.h"
#include "ListTablesDlg.h"

// *** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *** PowerDesigner Access from MSVC
// *** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

// * COM support
#include "COMDEF.H"  // COM base Tables, Smart pointers, ...

// * Import definition of PowerDesigner objects we need (PDM)
#pragma warning (disable : 4146) // (avoids a warning in generated code)
#import  "pdobj16.DLL" inject_statement("#define delete Delete"), rename("GetPackage", "getPackage")
#import  "shpdm16.DLL" inject_statement("#define delete Delete"), rename("GetPackage", "getPackage")
// NOTE:
// - For the two line above to compile properly, the PowerDesigner
//   DLL(s) must be in library search path of the compiler!
//   (Menu "Tool|Options", tab "Directories" add an entry in
//   "Library files" that points to PowerDesigner directory)
// - The inject_statement option on these lines is a work-around of
//   the strange behaviour of #import code generation engine that seems
//   to respect casing of methods as they apear in type-library except
//   for the base object's Delete method that gets renamed to delete!
//   (which produces code that does not compile). Be aware that this
//   is only a work-around of the problem and has the dangerous side
//   effect of hiding explicit calls or overloads to C++ delete operator.
//   Fortunately there seems to be no such use/overload of C++ operator
//   delete in generated code. Yet, if ever you include generated .tlh
//   (or import it else where) you may need to restore normal delete
//   by inserting the following directive rigth after the include/
//   import directive: "#undef delete"
#undef delete

// * Let basic definitions be accesible without C++ namespace prefix.
using namespace PdCommon;

// * Keep a hand on server application in a global pointer
// for the whole duration of the main dialog lifetime.
// (this is to avoid having such a smart pointer defined as
//  member of the class which would require including all COM
//  and imported definition in dialog header! note that this
//  is still rather safe since there can be only one instance
//  of the dialog in the process.)
IApplicationPtr g_pApp;

// *** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *** END.
// *** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CListTablesDlg dialog

CListTablesDlg::CListTablesDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CListTablesDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CListTablesDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CListTablesDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CListTablesDlg)
	DDX_Control(pDX, IDC_LIST_TABLES, m_lbTables);
	DDX_Control(pDX, IDC_CB_PDMMODELS, m_cbModels);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CListTablesDlg, CDialog)
	//{{AFX_MSG_MAP(CListTablesDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(ID_REFRESH, OnRefresh)
	ON_CBN_SELCHANGE(IDC_CB_PDMMODELS, OnModelChanged)
	ON_BN_CLICKED(IDC_NEW_TABLE, OnNewTable)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CListTablesDlg message handlers

BOOL CListTablesDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
   // ******************************************************************
   // *** Initialisation of the dialog
   // ******************************************************************
   OnRefresh();
   // ******************************************************************
   // *** End.
   // ******************************************************************
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CListTablesDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CListTablesDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CListTablesDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

// ******************************************************************
// * * * * * * * * * * * * Additional code  * * * * * * * * * * * * *
// ******************************************************************
//
// NOTE: since the following code uses COM library, the
//   CoInitialize()/CoUninitialize() API must be called
//   before/after this dialog gets displayed.
//   This is done in CListTablesApp::InitInstance.
//
CListTablesDlg::~CListTablesDlg()
{
   // Release our hold on the server application
   g_pApp = NULL;
}

void CListTablesDlg::OnModelChanged() 
{
   // First clean any previous content...
   m_lbTables.ResetContent();

   // Check for the server and a selection...
   int nCurSel = m_cbModels.GetCurSel();
   if ((g_pApp != NULL) && (nCurSel >= 0))
   {
      // Server is present and there is a model selected...
      CString sName;
      m_cbModels.GetLBText(nCurSel, sName);

      // Seek for the selected model...
      PdPDM::ModelPtr   pPdmModel;
      ObjectSetPtr      pModels(g_pApp->Models);
      long nModels = pModels->Count;
      for (long n = 0; n < nModels; ++n)
      {
         pPdmModel = pModels->Item(n);
         if ((pPdmModel != NULL) && (sName == (LPCTSTR)pPdmModel->Name))
         { 
            // Found designated model, display list of tables
            PdPDM::TablePtr   pTable;
            for (long nTabl = 0; nTabl < pPdmModel->Tables->GetCount(); ++nTabl)
            {
               if (pTable = pPdmModel->Tables->Item(nTabl))
               {
                  sName =  (LPCTSTR)pTable->Name;
                  sName += TEXT(" (");
                  sName += (LPCTSTR)pTable->Code;
                  sName += TEXT("): ");

                  // Add list of attributes
                  PdPDM::ColumnPtr pColumn;
                  for (long nColn = 0; nColn < pTable->Columns->GetCount(); ++nColn)
                  {
                     if (pColumn = pTable->Columns->Item(nColn))
                     {
                        if (nColn > 0)
                           sName += TEXT(", ");
                        sName += (LPCTSTR)pColumn->Code;
                     }
                  }

                  m_lbTables.AddString(sName);
               }
            }

            // Add Tables defined in first level packages
            PdPDM::PackagePtr pPdmPackage;
            ObjectColPtr      pPackages(pPdmModel->Packages);
            long nPackages = pPackages->Count;
            for (long p = 0; p < nPackages; ++p)
            {
               pPdmPackage = pPackages->Item(p);
               if (pPdmPackage != NULL)
               {
                  for (int nTabl = 0; nTabl < pPdmPackage->Tables->GetCount(); ++nTabl)
                  {
                     if (pTable = pPdmModel->Tables->Item(nTabl))
                     {
                        sName = (LPCTSTR)pPdmPackage->Name;
                        sName += TEXT("::");
                        sName += (LPCTSTR)pTable->Name;
                        sName += TEXT(" (");
                        sName += (LPCTSTR)pPdmPackage->Code;
                        sName += TEXT("::");
                        sName += (LPCTSTR)pTable->Code;
                        sName += TEXT(")");
                        m_lbTables.AddString(sName);
                     }
                  }
               }
            }

            break;
         }
      }
   }
}

void CListTablesDlg::OnRefresh() 
{
   // First see if there is a previous selection that we sould attempt to preserve
   int nCurSel = m_cbModels.GetCurSel();
   CString sCurSel;
   if (nCurSel >= 0)
      m_cbModels.GetLBText(nCurSel, sCurSel);
   
   // Then clean up previous content (if any!)
   m_cbModels.ResetContent();

   // And last (re)fill list of models (if we have a server)...
   if (g_pApp == NULL)
   {
      // Connect to server application root object (take a shortcut in case its already active)
      if (FAILED(g_pApp.GetActiveObject(__uuidof(Application))) || (g_pApp == NULL))
         VERIFY(SUCCEEDED(g_pApp.CreateInstance(__uuidof(Application))) && (g_pApp != NULL));
   }
   if (g_pApp)
   {
      // Check for loaded PDM models in application
      PdPDM::ModelPtr   pPdmModel;
      ObjectSetPtr      pModels(g_pApp->Models);
      long nModels = pModels->Count;
      for (long n = 0; n < nModels; ++n)
      {
         pPdmModel = pModels->Item(n);
         if (pPdmModel)
         {
            // Found an PDM Model, fetch its name as a string.
            CString sName((LPOLESTR)pPdmModel->Name);

            // Add it to the Combo of models
            m_cbModels.AddString(sName);

            // Attempt to reserve selection
            if ((sName == sCurSel) && (m_cbModels.GetCurSel() < 0))
               m_cbModels.SetCurSel(n);
         }
      }

      // Pick first model and display its info...
      if (m_cbModels.GetCount() != 0)
      {
         if (nCurSel >= 0 && nCurSel < m_cbModels.GetCount()) 
            m_cbModels.SetCurSel(nCurSel);
         else
            m_cbModels.SetCurSel(0);
      }
   }

   // Update slave controls any-way
   OnModelChanged();
}

// Create a new Table in the current PDM model
void CListTablesDlg::OnNewTable() 
{
   // Check for the server and a selection...
   int nCurSel = m_cbModels.GetCurSel();
   if ((g_pApp != NULL) && (nCurSel >= 0))
   {
      // Server is present and there is a model selected...
      CString sName;
      m_cbModels.GetLBText(nCurSel, sName);

      // Seek for the selected model...
      PdPDM::ModelPtr   pPdmModel;
      ObjectSetPtr      pModels(g_pApp->Models);
      long nModels = pModels->Count;
      for (long n = 0; n < nModels; ++n)
      {
         pPdmModel = pModels->Item(n);
         if ((pPdmModel != NULL) && (sName == (LPOLESTR)pPdmModel->Name))
         {
            PdPDM::TablePtr pPdmTable;
            pPdmTable = pPdmModel->CreateObject(PdPDM::cls_Table, TEXT(""), -1, TRUE);
         }
      }
   }

   // Update slave controls any-way
   OnModelChanged();
}
