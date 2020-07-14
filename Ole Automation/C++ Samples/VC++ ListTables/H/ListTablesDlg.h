// ListTablesDlg.h : header file
//

#if !defined(AFX_LISTTABLESDLG_H__2685DA68_C4CB_4191_9E02_EDB61024ED7D__INCLUDED_)
#define AFX_LISTTABLESDLG_H__2685DA68_C4CB_4191_9E02_EDB61024ED7D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CListTablesDlg dialog

class CListTablesDlg : public CDialog
{
// Construction
public:
	~CListTablesDlg();
	CListTablesDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CListTablesDlg)
	enum { IDD = IDD_LISTTABLES_DIALOG };
	CListBox	m_lbTables;
	CComboBox	m_cbModels;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CListTablesDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CListTablesDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnRefresh();
	afx_msg void OnModelChanged();
	afx_msg void OnNewTable();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LISTTABLESDLG_H__2685DA68_C4CB_4191_9E02_EDB61024ED7D__INCLUDED_)
