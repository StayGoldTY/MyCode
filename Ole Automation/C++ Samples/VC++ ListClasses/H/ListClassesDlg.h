// ListClassesDlg.h : header file
//

#if !defined(AFX_LISTCLASSESDLG_H__2685DA68_C4CB_4191_9E02_EDB61024ED7D__INCLUDED_)
#define AFX_LISTCLASSESDLG_H__2685DA68_C4CB_4191_9E02_EDB61024ED7D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CListClassesDlg dialog

class CListClassesDlg : public CDialog
{
// Construction
public:
	~CListClassesDlg();
	CListClassesDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CListClassesDlg)
	enum { IDD = IDD_LISTCLASSES_DIALOG };
	CListBox	m_lbClasses;
	CComboBox	m_cbModels;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CListClassesDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CListClassesDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnRefresh();
	afx_msg void OnModelChanged();
	afx_msg void OnNewClass();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LISTCLASSESDLG_H__2685DA68_C4CB_4191_9E02_EDB61024ED7D__INCLUDED_)
