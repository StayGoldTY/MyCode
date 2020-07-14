// ListTables.h : main header file for the LISTTABLES application
//

#if !defined(AFX_LISTTABLES_H__6D0ACCC9_B6CF_43B4_9B62_F0AC211E458F__INCLUDED_)
#define AFX_LISTTABLES_H__6D0ACCC9_B6CF_43B4_9B62_F0AC211E458F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CListTablesApp:
// See ListTables.cpp for the implementation of this class
//

class CListTablesApp : public CWinApp
{
public:
	CListTablesApp();
  ~CListTablesApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CListTablesApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CListTablesApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LISTTABBLES_H__6D0ACCC9_B6CF_43B4_9B62_F0AC211E458F__INCLUDED_)
