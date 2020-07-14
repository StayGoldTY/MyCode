' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
'
' Constants for external VB-Script access to SAP PowerDesigner 16.5.5
'
' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Option Explicit

' *** PdCommon constants
' ==============================================

' - SRepAttrType constants
const PdCommon_SRepCANTSAVE                         = -2147483648
const PdCommon_SRepTYPEMASK                         = -65536
const PdCommon_SRepINFOMASK                         = 65535
const PdCommon_SRepNULL                             = 0
const PdCommon_SRepOID                              = 65536
const PdCommon_SRepSHORT                            = 131072
const PdCommon_SRepINT                              = 196608
const PdCommon_SRepBOOL                             = 262144
const PdCommon_SRepENUM                             = 327680
const PdCommon_SRepBITFIELD                         = 393216
const PdCommon_SRepREAL                             = 458752
const PdCommon_SRepDATE                             = 524288
const PdCommon_SRepCHAR                             = 589824
const PdCommon_SRepTEXT                             = 655360
const PdCommon_SRepBLOB                             = 720896
const PdCommon_SRepOIDLIST                          = 786432
const PdCommon_SRepVALLIST                          = 851968
const PdCommon_SRepPOINT                            = 917504
const PdCommon_SRepRECT                             = 983040
const PdCommon_SRepPTLIST                           = 1048576
const PdCommon_SRepIUNKNOWN                         = -2147418112
const PdCommon_SRepIDISPATCH                        = -2147352576
const PdCommon_SRepIOBJECT                          = -2147287040
const PdCommon_SRepIOBJCOL                          = -2147221504
const PdCommon_SRepISETCOL                          = -2147221503
const PdCommon_SRepIBAGCOL                          = -2147221502
const PdCommon_SRepICOLCOL                          = -2147221500
const PdCommon_SRepDISPID                           = 2097152
const PdCommon_SRepCLSID                            = 4194304
const PdCommon_SRepVARIANT                          = 8388608
const PdCommon_SRepHRESULT                          = 16777216
const PdCommon_SRepICONIDX                          = 33554432

' - ClassDefFlags constants
const PdCommon_SCLSS_ABSTRACT                       = 1
const PdCommon_SCLSS_FOLDER                         = 2
const PdCommon_SCLSS_CUSTOM_IMPL                    = 4
const PdCommon_SCLSS_CUSTOM_IFACE                   = 8
const PdCommon_SCLSS_INTERNAL                       = 16
const PdCommon_SCLSS_LISTABLE                       = 32
const PdCommon_SCLSS_QUERYABLE                      = 64
const PdCommon_SCLSS_GLOBAL                         = 128
const PdCommon_SCLSS_RMGHASTABLE                    = 256
const PdCommon_SCLSS_RMGHASBLOBED                   = 512
const PdCommon_SCLSS_RMGBLOBED                      = 1024
const PdCommon_SCLSS_QRYKIND                        = 2048
const PdCommon_SCLSS_GENERATED                      = 4096
const PdCommon_SCLSS_INSTANTIABLE                   = 8192
const PdCommon_SCLSS_NOSTDOLEWRP                    = 16384
const PdCommon_SCLSS_NOT_OLE                        = 32768
const PdCommon_SCLSS_CARD_MASK                      = 196608
const PdCommon_SCLSS_CARD_FEW                       = 65536
const PdCommon_SCLSS_CARD_SOME                      = 131072
const PdCommon_SCLSS_CARD_LOTS                      = 196608
const PdCommon_SCLSS_RMGLOCKABLE                    = 262144
const PdCommon_SCLSS_EXCLUDABLE                     = 524288
const PdCommon_SCLSS_APIEXPORTS                     = 1048576
const PdCommon_SCLSS_STATIC                         = 2097152
const PdCommon_SCLSS_READONLY                       = 4194304
const PdCommon_SCLSS_SUBOBJECT                      = 8388608
const PdCommon_SCLSS_INTERFACE                      = 16777216
const PdCommon_SCLSS_ENUMERATION                    = 33554432
const PdCommon_SCLSS_RMGROOT                        = 67108864
const PdCommon_SCLSS_STANDARD                       = 0

' - ClassMemberDefFlags constants
const PdCommon_SMEMB_HIDDEN                         = 1
const PdCommon_SMEMB_OVERLOAD                       = 2
const PdCommon_SMEMB_CUSTOM                         = 4
const PdCommon_SMEMB_NOTSAVED                       = 8
const PdCommon_SMEMB_DROPONLOAD                     = 16
const PdCommon_SMEMB_OLEREADONLY                    = 32
const PdCommon_SMEMB_DEPRECATED                     = 64
const PdCommon_SMEMB_SYNONYM                        = 140
const PdCommon_SMEMB_ODATACUSTOM                    = 268
const PdCommon_SMEMB_STANDARD                       = 0
const PdCommon_SMEMB_CALCULATED                     = 12

' - ClassAttrDefFlags constants
const PdCommon_SATTR_READONLY                       = 1
const PdCommon_SATTR_WRITEONLY                      = 2
const PdCommon_SATTR_COLLOBJECT                     = 4
const PdCommon_SATTR_LISTABLE                       = 8
const PdCommon_SATTR_MANDATORY                      = 16
const PdCommon_SATTR_QUERYABLE                      = 32
const PdCommon_SATTR_HIDE                           = 64
const PdCommon_SATTR_HASPATH                        = 128
const PdCommon_SATTR_REFSTRING                      = 256
const PdCommon_SATTR_INDIRECT                       = 512
const PdCommon_SATTR_NODEFAULT                      = 1024
const PdCommon_SATTR_DYNAMICDEF                     = 2048
const PdCommon_SATTR_STRINGSET                      = 4096
const PdCommon_SATTR_COLLFILLED                     = 8192
const PdCommon_SATTR_CUSTVALLIST                    = 16384
const PdCommon_SATTR_STANDARD                       = 0
const PdCommon_SATTR_INVALID                        = 3

' - ClassColDefFlags constants
const PdCommon_SCOLL_SEQUENCED                      = 1
const PdCommon_SCOLL_NAMESPACE                      = 2
const PdCommon_SCOLL_UNIQUENAMES                    = 4
const PdCommon_SCOLL_BROWSABLE                      = 8
const PdCommon_SCOLL_DELETE                         = 16
const PdCommon_SCOLL_COPY                           = 32
const PdCommon_SCOLL_COLLSET                        = 64
const PdCommon_SCOLL_TYPED                          = 128
const PdCommon_SCOLL_CATEGORY                       = 256
const PdCommon_SCOLL_DEPENDENCY                     = 512
const PdCommon_SCOLL_NOSEARCHIN                     = 1024
const PdCommon_SCOLL_COMINVERSE                     = 2048
const PdCommon_SCOLL_MAXONE                         = 4096
const PdCommon_SCOLL_RMGBLOBED                      = 8192
const PdCommon_SCOLL_COPYRLSH                       = 16384
const PdCommon_SCOLL_DEPENDENT                      = 32768
const PdCommon_SCOLL_CROSSSESSION                   = 65536
const PdCommon_SCOLL_SHCTCONTENT                    = 131072
const PdCommon_SCOLL_CROSSPACKAGE                   = 262144
const PdCommon_SCOLL_CALCCUSTIMPL                   = 524288
const PdCommon_SCOLL_FIRSTONCLOSE                   = 1048576
const PdCommon_SCOLL_COLPATH                        = 2097152
const PdCommon_SCOLL_COLUNIQUESET                   = 4194304
const PdCommon_SCOLL_COMPOSITION                    = 48
const PdCommon_SCOLL_AGGREGATION                    = 32
const PdCommon_SCOLL_ASSOCIATION                    = 16
const PdCommon_SCOLL_STANDARD                       = 0

' - ClassMthdDefFlags constants
const PdCommon_SMTHD_EASYRETURN                     = 1
const PdCommon_SMTHD_CONST                          = 2
const PdCommon_SMTHD_INTERNAL                       = 4
const PdCommon_SMTHD_HASTEMPLATE                    = 8
const PdCommon_SMTHD_STANDARD                       = 0

' - SRepAttrCtrlType constants
const PdCommon_SREPATTRCTRL_EDIT                    = 0
const PdCommon_SREPATTRCTRL_STATIC                  = 1
const PdCommon_SREPATTRCTRL_DROPDOWN                = 2
const PdCommon_SREPATTRCTRL_DROPLIST                = 3
const PdCommon_SREPATTRCTRL_LISTBOX                 = 4
const PdCommon_SREPATTRCTRL_CHECKBOX                = 5
const PdCommon_SREPATTRCTRL_RADIO                   = 6
const PdCommon_SREPATTRCTRL_NAME                    = 7
const PdCommon_SREPATTRCTRL_CODE                    = 8
const PdCommon_SREPATTRCTRL_USER                    = 9
const PdCommon_SREPATTRCTRL_DOTS                    = 10
const PdCommon_SREPATTRCTRL_CBXBTN                  = 11
const PdCommon_SREPATTRCTRL_RICHEDIT                = 12
const PdCommon_SREPATTRCTRL_EDITBITMAP              = 13
const PdCommon_SREPATTRCTRL_PROP                    = 14
const PdCommon_SREPATTRCTRL_CREATEADDPROP           = 15
const PdCommon_SREPATTRCTRL_CREATEADD               = 16
const PdCommon_SREPATTRCTRL_CREATEPROP              = 17
const PdCommon_SREPATTRCTRL_CBLBTN                  = 18
const PdCommon_SREPATTRCTRL_ADDPROP                 = 19
const PdCommon_SREPATTRCTRL_ARRAY                   = 20
const PdCommon_SREPATTRCTRL_EDITUSERDEF             = 21
const PdCommon_SREPATTRCTRL_DATE                    = 22
const PdCommon_SREPATTRCTRL_RICHEDITDOTS            = 23
const PdCommon_SREPATTRCTRL_SYNTAX                  = 24
const PdCommon_SREPATTRCTRL_DDADDPROP               = 25
const PdCommon_SREPATTRCTRL_TIME                    = 26

' - ObjectUpToDateStatus constants
const PdCommon_u2d_Unknown                          = 0
const PdCommon_u2d_OK                               = 1
const PdCommon_u2d_KO                               = 2

' - SSymDiagFlags constants
const PdCommon_SDiagAutoAdjust                      = 1
const PdCommon_SDiagAutoLayout                      = 2
const PdCommon_SDiagCopySymbol                      = 4
const PdCommon_SDiagUpdateCustomSymbol              = 8

' - AutoLayoutStyle constants
const PdCommon_al_style_default                     = -1
const PdCommon_al_style_hierarchic                  = 0
const PdCommon_al_style_organic                     = 1
const PdCommon_al_style_orthogonal                  = 2
const PdCommon_al_style_circular                    = 3
const PdCommon_al_style_tree                        = 4
const PdCommon_al_style_snowflake                   = 5
const PdCommon_al_style_basic                       = 6

' - AutoLayoutOrientation constants
const PdCommon_al_orientation_default               = -1
const PdCommon_al_orientation_top_bottom            = 0
const PdCommon_al_orientation_bottom_top            = 1
const PdCommon_al_orientation_left_right            = 2
const PdCommon_al_orientation_right_left            = 3
const PdCommon_al_orientation_radiation             = 4
const PdCommon_al_orientation_cycle                 = 5
const PdCommon_al_orientation_snowflake             = 6
const PdCommon_al_orientation_basic                 = 7

' - LinkArrowValue constants
const PdCommon_arrow_none                           = 0
const PdCommon_arrow_arrow2                         = 1
const PdCommon_arrow_arrow3                         = 2
const PdCommon_arrow_arrow4                         = 3
const PdCommon_arrow_arrow5                         = 4
const PdCommon_arrow_arrow6                         = 5
const PdCommon_arrow_arrow7                         = 6
const PdCommon_arrow_arrow8                         = 7
const PdCommon_arrow_arrow9                         = 8
const PdCommon_arrow_circle1                        = 9
const PdCommon_arrow_circle2                        = 10
const PdCommon_arrow_diamond                        = 12
const PdCommon_arrow_diamond1                       = 13
const PdCommon_arrow_circleplus                     = 14
const PdCommon_arrow_onenull                        = 16
const PdCommon_arrow_mand                           = 17
const PdCommon_arrow_mny                            = 18
const PdCommon_arrow_mnymand                        = 19
const PdCommon_arrow_dept                           = 20
const PdCommon_arrow_manddept                       = 21
const PdCommon_arrow_mnydept                        = 22
const PdCommon_arrow_mnymanddept                    = 23
const PdCommon_arrow_noarrow                        = 24
const PdCommon_arrow_arrow10                        = 25
const PdCommon_arrow_arrow11                        = 26
const PdCommon_arrow_round                          = 27
const PdCommon_arrow_arrowrd1                       = 28
const PdCommon_arrow_arrowrd8                       = 29
const PdCommon_arrow_arrowrd11                      = 30
const PdCommon_arrow_diamond2                       = 31
const PdCommon_arrow_diamond3                       = 32
const PdCommon_arrow_arrow12                        = 33
const PdCommon_arrow_arrow13                        = 34
const PdCommon_arrow_arrow14                        = 35
const PdCommon_arrow_arrow15                        = 36
const PdCommon_arrow_arrow16                        = 37
const PdCommon_arrow_arrow17                        = 38
const PdCommon_arrow_arrow18                        = 39
const PdCommon_arrow_arrow19                        = 40
const PdCommon_arrow_inhr1                          = 41
const PdCommon_arrow_inhr2                          = 42
const PdCommon_arrow_eh_fault                       = 43
const PdCommon_arrow_eh_timer                       = 44
const PdCommon_arrow_eh_msg                         = 45
const PdCommon_arrow_eh_comp                        = 46
const PdCommon_arrow_eh_undef                       = 47
const PdCommon_arrow_asmblink                       = 48
const PdCommon_arrow_arc                            = 49
const PdCommon_arrow_reqrlink                       = 50
const PdCommon_arrow_flow_rect                      = 51
const PdCommon_arrow_oneonly                        = 52
const PdCommon_arrow_zeroone                        = 53
const PdCommon_arrow_mnybark                        = 54

' - GraphicalContraintType constants
const PdCommon_grphcnst_undef                       = 0
const PdCommon_grphcnst_hcenter                     = 1
const PdCommon_grphcnst_vcenter                     = 2
const PdCommon_grphcnst_topalign                    = 4
const PdCommon_grphcnst_bottomalign                 = 8
const PdCommon_grphcnst_leftalign                   = 16
const PdCommon_grphcnst_rightalign                  = 32
const PdCommon_grphcnst_hdistance                   = 64
const PdCommon_grphcnst_vdistance                   = 128
const PdCommon_grphcnst_samewidth                   = 256
const PdCommon_grphcnst_sameheight                  = 512

' - RptTabPosAlignment constants
const PdCommon_RPT_TABPOS_ALIGNMENT_LEFT            = 1
const PdCommon_RPT_TABPOS_ALIGNMENT_CENTER          = 2
const PdCommon_RPT_TABPOS_ALIGNMENT_RIGHT           = 3
const PdCommon_RPT_TABPOS_ALIGNMENT_DEFAULT         = 1

' - RptParaHimetrics constants
const PdCommon_RPT_PARA_BORDER_WIDTH_DEFAULT        = 26
const PdCommon_RPT_PARA_BOX_WIDTH_DEFAULT           = 26
const PdCommon_RPT_PARA_SPTXTBORDER_TOP_DEFAULT     = 35
const PdCommon_RPT_PARA_SPTXTBORDER_BOTTOM_DEFAULT  = 35
const PdCommon_RPT_PARA_SPTXTBORDER_LEFT_DEFAULT    = 141
const PdCommon_RPT_PARA_SPTXTBORDER_RIGHT_DEFAULT   = 141
const PdCommon_RPT_PARA_WORD_LINE_SPACING_FACTOR    = 75
const PdCommon_RPT_PARA_DEFAULT_TABSIZE             = 1270

' - RptTableCellValign constants
const PdCommon_RPTTABLECELL_VALIGN_TOP              = 1
const PdCommon_RPTTABLECELL_VALIGN_CENTER           = 2
const PdCommon_RPTTABLECELL_VALIGN_BOTTOM           = 3
const PdCommon_RPTTABLECELL_VALIGN_DEFAULT          = 1

' - RptTableCellBorder constants
const PdCommon_RPTTABLECELL_BORDER_TOP              = 1
const PdCommon_RPTTABLECELL_BORDER_BOTTOM           = 4
const PdCommon_RPTTABLECELL_BORDER_LEFT             = 8
const PdCommon_RPTTABLECELL_BORDER_RIGHT            = 18
const PdCommon_RPTTABLECELL_BORDER_NONE             = 0
const PdCommon_RPTTABLECELL_BORDER_ALL              = 31
const PdCommon_RPTTABLECELL_BORDER_DEFAULT          = 8

' - RptTableCellBorderWidthHimetrics constants
const PdCommon_RPTTABLECELL_BORDERWIDTH_DEFAULT     = 26

' - RptTableRowHeightType constants
const PdCommon_RPTTABLEROW_HEIGHTTYPE_AUTO          = 1
const PdCommon_RPTTABLEROW_HEIGHTTYPE_ATLEAST       = 2
const PdCommon_RPTTABLEROW_HEIGHTTYPE_EXACTLY       = 3
const PdCommon_RPTTABLEROW_HEIGHTTYPE_DEFAULT       = 1

' - RptTableRowAlignment constants
const PdCommon_RPTTABLEROW_ALIGNMENT_LEFT           = 1
const PdCommon_RPTTABLEROW_ALIGNMENT_CENTER         = 2
const PdCommon_RPTTABLEROW_ALIGNMENT_RIGHT          = 3
const PdCommon_RPTTABLEROW_ALIGNMENT_DEFAULT        = 1

' - RptTableRowSpaceHimetrics constants
const PdCommon_RPTTABLEROW_SPBETWEENCELLS_DEFAULT   = 400

' - RptGraphFormat constants
const PdCommon_RPTGRAPH_FORMAT_EMF                  = 1
const PdCommon_RPTGRAPH_FORMAT_BMP                  = 2
const PdCommon_RPTGRAPH_FORMAT_SVG                  = 3

' - RptGraph1Page constants
const PdCommon_RPTGRAPH_1PAGE_PARA                  = 1
const PdCommon_RPTGRAPH_1PAGE_CENTER                = 2

' - RptGraphScanpage constants
const PdCommon_RPTGRAPH_SCANPAGE_UPDOWN             = 1
const PdCommon_RPTGRAPH_SCANPAGE_DOWNUP             = 2

' - RptGraph constants
const PdCommon_RPTGRAPH_ONEPAGE_ZOOM                = 1
const PdCommon_RPTGRAPH_CUSTOM_ZOOM                 = 2
const PdCommon_RPTGRAPH_DIAGLAY_ZOOM                = 3

' - RptOrient constants
const PdCommon_RPTORIENT_PORTRAIT                   = 1
const PdCommon_RPTORIENT_LANDSCAPE                  = 2

' - RptPaper constants
const PdCommon_RPTPAPER_LETTER                      = 1
const PdCommon_RPTPAPER_LETTERSMALL                 = 2
const PdCommon_RPTPAPER_TABLOID                     = 3
const PdCommon_RPTPAPER_LEDGER                      = 4
const PdCommon_RPTPAPER_LEGAL                       = 5
const PdCommon_RPTPAPER_STATEMENT                   = 6
const PdCommon_RPTPAPER_EXECUTIVE                   = 7
const PdCommon_RPTPAPER_A3                          = 8
const PdCommon_RPTPAPER_A4                          = 9
const PdCommon_RPTPAPER_A4SMALL                     = 10
const PdCommon_RPTPAPER_A5                          = 11
const PdCommon_RPTPAPER_B4                          = 12
const PdCommon_RPTPAPER_B5                          = 13
const PdCommon_RPTPAPER_FOLIO                       = 14

' - RptParaBorder constants
const PdCommon_RPT_PARA_BORDER_NONE                 = 0
const PdCommon_RPT_PARA_BORDER_LEFT                 = 1
const PdCommon_RPT_PARA_BORDER_TOP                  = 2
const PdCommon_RPT_PARA_BORDER_RIGHT                = 4
const PdCommon_RPT_PARA_BORDER_BOTTOM               = 8
const PdCommon_RPT_PARA_BORDER_FRAME                = 15
const PdCommon_RPT_PARA_BORDER_MASK                 = 15

' - RptParaAlign constants
const PdCommon_RPT_PARA_ALIGN_LEFT                  = 1
const PdCommon_RPT_PARA_ALIGN_RIGHT                 = 2
const PdCommon_RPT_PARA_ALIGN_CENTERED              = 4
const PdCommon_RPT_PARA_ALIGN_JUSTIFIED             = 8
const PdCommon_RPT_PARA_ALIGN_MASK                  = 15

' - RptParaIndent constants
const PdCommon_RPT_PARA_INDENT_LEFT                 = 1
const PdCommon_RPT_PARA_INDENT_RIGHT                = 2
const PdCommon_RPT_PARA_INDENT_FIRST                = 4
const PdCommon_RPT_PARA_INDENT_MASK                 = 7

' - RptParaSpace constants
const PdCommon_RPT_PARA_SPACE_BEFORE                = 1
const PdCommon_RPT_PARA_SPACE_AFTER                 = 2
const PdCommon_RPT_PARA_SPACE_BETWEEN               = 4
const PdCommon_RPT_PARA_SPACE_MASK                  = 7

' - RptParaFlow constants
const PdCommon_RPT_PARA_FLOW_KEEPLINES              = 1
const PdCommon_RPT_PARA_FLOW_KEEPNEXT               = 2
const PdCommon_RPT_PARA_FLOW_BREAKBEFORE            = 4
const PdCommon_RPT_PARA_FLOW_NOORPHANS              = 8
const PdCommon_RPT_PARA_FLOW_MASK                   = 15

' - RptParaSpType constants
const PdCommon_RPT_PARA_SPTYPE_EXACT                = 1
const PdCommon_RPT_PARA_SPTYPE_MULTIPLE             = 2
const PdCommon_RPT_PARA_SPTYPE_MASK                 = 3

' - ReportWizardOption constants
const PdCommon_RPTW_NONE                            = 0
const PdCommon_RPTW_PRES_HTML                       = 1
const PdCommon_RPTW_PRES_RTF                        = 2
const PdCommon_RPTW_PRES_PRINT                      = 4
const PdCommon_RPTW_INTRO_TEXT                      = 8
const PdCommon_RPTW_INTRO_MODEL_PROPS               = 16
const PdCommon_RPTW_SHORTDESC_DIAGS                 = 32
const PdCommon_RPTW_SHORTDESC_OBJS                  = 64
const PdCommon_RPTW_FULLDESC_DIAGS                  = 128
const PdCommon_RPTW_FULLDESC_OBJS                   = 256
const PdCommon_RPTW_FULLDESC_OBJ_DETAILS            = 512
const PdCommon_RPTW_LIST_BY_DIAG                    = 1024
const PdCommon_RPTW_PKG_WITHOUT                     = 2048
const PdCommon_RPTW_PKG_ONE_PER_PKG                 = 4096
const PdCommon_RPTW_PKG_HIER                        = 8192
const PdCommon_RPTW_END_OPEN_EDITOR                 = 16384
const PdCommon_RPTW_END_GENERATE                    = 32768
const PdCommon_RPTW_PRES_PDF                        = 65536

' - SObjTargetItemNodeStateBits constants
const PdCommon_SObjNodeStateExpanded                = 1
const PdCommon_SObjNodeStateSelected                = 2

' - CommonFunctions constants
const PdCommon_fct_CheckModel                       = 0
const PdCommon_fct_Report                           = 1

' - XRLUpdateModes constants
const PdCommon_xrl_upd_user_defined                 = 0
const PdCommon_xrl_upd_default                      = 1
const PdCommon_xrl_upd_mixed                        = 2
const PdCommon_xrl_upd_updatePath                   = 3

' - MergeActions constants
const PdCommon_mrg_identical                        = 0
const PdCommon_mrg_created                          = 1
const PdCommon_mrg_deleted                          = 2
const PdCommon_mrg_modified                         = 4
const PdCommon_mrg_chldmdfd                         = 8
const PdCommon_mrg_movedfrom                        = 16
const PdCommon_mrg_movedto                          = 32
const PdCommon_mrg_movedfromex                      = 64
const PdCommon_mrg_movedtoex                        = 128
const PdCommon_mrg_insert                           = 256
const PdCommon_mrg_remove                           = 512
const PdCommon_mrg_selected                         = 1024
const PdCommon_mrg_addshct                          = 4096
const PdCommon_mrg_delshct                          = 8192
const PdCommon_mrg_conflict                         = 16384
const PdCommon_mrg_nopreserve                       = 32768
const PdCommon_mrg_equal                            = 65536
const PdCommon_mrg_allchanges                       = 13311

' - DocumentUpToDateStatus constants
const PdCommon_dus_UpToDate                         = 0
const PdCommon_dus_ChangedByMe                      = 1
const PdCommon_dus_NeedCheckIn                      = 3
const PdCommon_dus_NeedFirstCheckIn                 = 2
const PdCommon_dus_ChangedByOther                   = 4
const PdCommon_dus_NeedCheckOut                     = 12
const PdCommon_dus_NeedFirstCheckOut                = 8
const PdCommon_dus_LockedByOther                    = 16
const PdCommon_dus_LockedByMe                       = 32
const PdCommon_dus_Failed                           = -65536

' - PreviewTextFormat constants
const PdCommon_ptf_CompareText                      = 0
const PdCommon_ptf_ActionDescription                = 1
const PdCommon_ptf_ListRTF                          = 2
const PdCommon_ptf_ListXML                          = 3
const PdCommon_ptf_ListCSV                          = 4

' - MergeOptions constants
const PdCommon_mrgopt_NoDialog                      = 0
const PdCommon_mrgopt_Dialog                        = 1
const PdCommon_mrgopt_DialogIfConflict              = 2

' - RslhType constants
const PdCommon_T_ONEONE                             = 0
const PdCommon_T_ONEMNY                             = 1
const PdCommon_T_MNYONE                             = 2
const PdCommon_T_MNYMNY                             = 3
const PdCommon_T_MAXTYP                             = 4

' - PdCommon classes identifiers
const PdCommon_AbstractRequirement                  = 1514251199     ' Abstract&#32;Requirement
const PdCommon_AnalysisCategoryTargetItem           = -512108924     ' Analysis&#32;Category
const PdCommon_AnalysisMetaClassTargetItem          = 1469574395     ' Analysis&#32;Metaclass
const PdCommon_ApplicationModule                    = 814660672      ' Application&#32;Module
const PdCommon_ArcSymbol                            = 906510191      ' Arc
const PdCommon_ArrowSymbol                          = 906510188      ' Arrow
const PdCommon_Artifact                             = -1895060813    ' Artifact
const PdCommon_ArtifactFolder                       = 1420673446     ' Artifact&#32;Folder
const PdCommon_AttributeIconSet                     = 533502435      ' Attribute&#32;Icon&#32;Set
const PdCommon_AttributePermissionTargetItem        = 348238138      ' Meta-attribute&#32;Permission
const PdCommon_AttributeValueIcon                   = 857142872      ' Attribute&#32;Value&#32;Icon
const PdCommon_BaseActivity                         = -837026078     ' Activity
const PdCommon_BaseActivitySymbol                   = 1683124768     ' Base&#32;Activity&#32;symbol
const PdCommon_BaseArea                             = 1334298539     ' Area
const PdCommon_BaseAssociationMapping               = 1334298536     ' Association&#32;Map
const PdCommon_BaseCheckNamedClassifier             = 1160911187     ' Check&#32;Named&#32;Classifier
const PdCommon_BaseCheckNamedStructuralFeature      = 1334298382     ' Feature
const PdCommon_BaseClassifierMapping                = 1334298530     ' Mapping
const PdCommon_BaseComposite                        = 1334298537     ' Composite
const PdCommon_BaseCompositeClassifier              = 1334298371     ' Composite&#32;Classifier
const PdCommon_BaseCompositeDataStructure           = 910670482      ' Composite&#32;Data&#32;Structure
const PdCommon_BaseCreationTemplateTargetItem       = -945844258     ' Base&#32;Template
const PdCommon_BaseData                             = 1330837646     ' Data
const PdCommon_BaseDataSource                       = 1334298529     ' Data&#32;Source
const PdCommon_BaseDecision                         = -837026064     ' Decision
const PdCommon_BaseDecisionSymbol                   = -48106552      ' Decision&#32;symbol
const PdCommon_BaseDiagram                          = 906510189      ' Diagram
const PdCommon_BaseDialogView                       = 1436794836     ' Abstract&#32;Base&#32;Dialog&#32;View
const PdCommon_BaseDomain                           = 1334298376     ' Domain
const PdCommon_BaseEditorMetaClassDefinition        = 2107150036     ' Base&#32;Editor&#32;Definition
const PdCommon_BaseEnd                              = -837026073     ' End
const PdCommon_BaseExtensibleDialogView             = 71680324       ' Abstract&#32;Base&#32;Extensible&#32;Dialog&#32;View
const PdCommon_BaseFileObject                       = 2101278114     ' Base&#32;File
const PdCommon_BaseFolder                           = 1334298368     ' Package
const PdCommon_BaseImpactAnalysisObject             = -809379023     ' Base&#32;Impact&#32;Analysis&#32;Object
const PdCommon_BaseKey                              = 1334298377     ' Key
const PdCommon_BaseLinkObject                       = 1334298373     ' Link
const PdCommon_BaseLinkObjectSymbol                 = -1028642001    ' Object&#32;Link&#32;Symbol
const PdCommon_BaseListView                         = 71680323       ' Abstract&#32;Base&#32;List&#32;View
const PdCommon_BaseLogicalConceptualDiagram         = 910670484      ' Conceptual&#32;Diagram
const PdCommon_BaseLogicalDataStructure             = 1503954        ' Data&#32;Structure
const PdCommon_BaseLogicalDomain                    = 910670478      ' Domain
const PdCommon_BaseLogicalEntity                    = 910670474      ' Entity
const PdCommon_BaseLogicalEntitySymbol              = 910670485      ' Entity&#32;Symbol
const PdCommon_BaseLogicalIdentifier                = 910670477      ' Identifier
const PdCommon_BaseLogicalInheritance               = 910670480      ' Inheritance
const PdCommon_BaseLogicalInheritanceLink           = 910670481      ' Inheritance&#32;Link
const PdCommon_BaseLogicalInheritanceLinkSymbol     = 910670489      ' Inheritance&#32;Link&#32;Symbol
const PdCommon_BaseLogicalInheritanceRootLinkSymbol = 910670488      ' Inheritance&#32;Root&#32;Link&#32;Symbol
const PdCommon_BaseLogicalInheritanceSymbol         = 910670487      ' Inheritance&#32;Symbol
const PdCommon_BaseLogicalModel                     = 910670470      ' Conceptual&#32;Data&#32;Model
const PdCommon_BaseLogicalPackage                   = 910670471      ' Package
const PdCommon_BaseLogicalRelationship              = 910670479      ' Relationship
const PdCommon_BaseLogicalRelationshipSymbol        = 910670486      ' Relationship&#32;Symbol
const PdCommon_BaseMappingBehavioralFeatureMapping  = 1334298535     ' Behavioral&#32;Feature&#32;Map
const PdCommon_BaseMatrixDefinition                 = -1468216057    ' Base&#32;Matrix&#32;Definition
const PdCommon_BaseMatrixView                       = -288520905     ' Base&#32;Matrix&#32;Dialog&#32;View
const PdCommon_BaseMetaAttributeMappingTargetItem   = -383578596     ' Base&#32;Meta-attribute&#32;Mapping
const PdCommon_BaseMetaClassDefinition              = -977554111     ' Base&#32;Metaclass&#32;Definition
const PdCommon_BaseMetaclassMappingTargetItem       = 456637319      ' Base&#32;Metaclass&#32;Mapping
const PdCommon_BaseMetaClassTargetItem              = 1834414494     ' Base&#32;Metaclass
const PdCommon_BaseMetaCollectionMappingTargetItem  = 614919141      ' Base&#32;Metacollection&#32;Mapping
const PdCommon_BaseMetaModelMappingTargetItem       = -1968934406    ' Base&#32;Model&#32;Generation
const PdCommon_BaseMetaObjectMappingInformation     = 1907910597     ' Base&#32;Meta-Object&#32;Mapping&#32;Information
const PdCommon_BaseMetaObjectMappingTargetItem      = -71467621      ' Base&#32;Meta-Object&#32;Mapping
const PdCommon_BaseModel                            = 1334298369     ' Model
const PdCommon_BaseModelCreationDescriptor          = 1181051597     ' Model&#32;Creation&#32;Descriptor
const PdCommon_BaseModelOptions                     = 1482472194     ' Model&#32;Options
const PdCommon_BaseModelReport                      = 1482472228     ' Report
const PdCommon_BaseObject                           = 908935648      ' Base&#32;Object
const PdCommon_BaseObjectMapping                    = -483552276     ' Mapping
const PdCommon_BaseOrganizationUnit                 = -837026062     ' Organization&#32;Unit
const PdCommon_BaseOrgnSymbol                       = -409387330     ' Organization&#32;Unit&#32;symbol
const PdCommon_BasePackage                          = 1334298538     ' Package
const PdCommon_BasePackageOptions                   = 1482472193     ' Package&#32;Options
const PdCommon_BasePermissionTargetItem             = 805082743      ' Base&#32;Permission
const PdCommon_BaseRelationshipSymbol               = -1028642002    ' Relationship&#32;Symbol
const PdCommon_BaseReplication                      = 908935663      ' Replication
const PdCommon_BaseReport                           = -1497708335    ' Report&#32;Template
const PdCommon_BaseReportItem                       = -1497708317    ' Item
const PdCommon_BaseReverseObjectMapping             = -968486130     ' Reverse&#32;Mapping
const PdCommon_BaseSpecificSwimlaneSymbol           = 906510213      ' Swimlane
const PdCommon_BaseStart                            = -837026076     ' Start
const PdCommon_BaseStructuralFeatureMapping         = 1334298532     ' Sub-object&#32;mapping
const PdCommon_BaseSwimlaneSymbol                   = -837026037     ' Swimlane&#32;symbol
const PdCommon_BaseSwimpoolSymbol                   = -837026036     ' Swimpool&#32;symbol
const PdCommon_BaseSymbol                           = 906510192      ' Base&#32;Symbol
const PdCommon_BaseSynchronization                  = -837026063     ' Synchronization
const PdCommon_BaseSynchronizationSymbol            = 721310843      ' Synchronization&#32;symbol
const PdCommon_BaseTermObject                       = 887599821      ' Base&#32;Term&#32;Object
const PdCommon_BaseTransformation                   = 328014504      ' Transformation
const PdCommon_BehavioralModel                      = -837026080     ' Base&#32;Object&#32;Oriented&#32;Model
const PdCommon_BehavioralNamedObject                = -837026066     ' Behavioral&#32;Named&#32;Object
const PdCommon_BehavioralPackage                    = -837026079     ' Package
const PdCommon_BehaviouralFeature                   = -2017142861    ' Named&#32;Behavioral&#32;Feature
const PdCommon_BitmapSymbol                         = 906510181      ' Bitmap
const PdCommon_BlankRectangleSymbol                 = 906510216      ' Blank&#32;Rectangle
const PdCommon_BlobedSymbol                         = 906510195      ' Blobbed&#32;Symbol
const PdCommon_BooleanTargetItem                    = 1482472198     ' Bool&#32;Item
const PdCommon_BusinessRule                         = 1334298378     ' Business&#32;Rule
const PdCommon_CalculatedCollectionTargetItem       = 1115407646     ' Calculated&#32;Collection
const PdCommon_CharacterTargetItem                  = 1482472200     ' Char&#32;Item
const PdCommon_CheckModelBaseCategory               = 1482472212     ' Check&#32;Model&#32;Base&#32;Category
const PdCommon_CheckModelBaseItem                   = 1482472215     ' Check&#32;Model&#32;Base&#32;Item
const PdCommon_CheckModelClassCategory              = 1482472213     ' Check&#32;Model&#32;Category
const PdCommon_CheckModelControler                  = 1482472211     ' Check&#32;Model&#32;Controller
const PdCommon_CheckModelItem                       = 75515952       ' Check&#32;Model&#32;Extended&#32;Item
const PdCommon_CheckModelMessage                    = 1482472222     ' Temporary&#32;internal&#32;object
const PdCommon_CheckModelMultiSubClassCategory      = 1482472217     ' Check&#32;Model&#32;Deep&#32;Sub-Objects&#32;Category
const PdCommon_CheckModelSubClassCategory           = 1482472214     ' Check&#32;Model&#32;Sub-Objects&#32;Category
const PdCommon_CheckModelSubSubClassCategory        = 1482472216     ' Check&#32;Model&#32;Sub-Sub-Objects&#32;Category
const PdCommon_CollectionLinkSymbol                 = -1028641983    ' Collection&#32;Link
const PdCommon_CollectionPermissionTargetItem       = -1351892488    ' Metacollection&#32;Permission
const PdCommon_ComparisonAction                     = 1261135356     ' Comparison&#32;Action
const PdCommon_ComparisonHelper                     = 656228256      ' Comparison&#32;Helper
const PdCommon_CompositeSymbol                      = 906510187      ' Composite&#32;Symbol
const PdCommon_CompositeViewSymbol                  = -1028641992    ' Composite&#32;View&#32;Symbol
const PdCommon_CompositionLink                      = 653781896      ' Composition&#32;Link
const PdCommon_ConditionalLink                      = -837026065     ' Condition&#32;Link
const PdCommon_ConstrainedNamedObject               = 1334298379     ' Check
const PdCommon_CriterionTargetItem                  = -1226133366    ' Criterion
const PdCommon_CustomCheckTargetItem                = -1395401481    ' Custom&#32;Check
const PdCommon_CustomDialog                         = 923561628      ' Custom&#32;Dialog
const PdCommon_CustomSymbolTargetItem               = -2084346552    ' Custom&#32;Symbol
const PdCommon_DataContainer                        = 1334298380     ' Container
const PdCommon_DataFormat                           = -2021424335    ' Data&#32;Format
const PdCommon_DatasetQueryTargetItem               = 296561246      ' Dataset&#32;Definition
const PdCommon_DefaultAssociationMapping            = -1816736849    ' Association&#32;Map
const PdCommon_DefaultBehavioralFeatureMapping      = -1558424410    ' Behavioral&#32;Feature&#32;Mapping
const PdCommon_DefaultDataSource                    = -503669014     ' Data&#32;Source
const PdCommon_DefaultObjectMapping                 = -1202793560    ' Mapping
const PdCommon_DefaultReverseObjectMapping          = 1561901562     ' Reverse&#32;Mapping
const PdCommon_DefaultStructuralFeatureMapping      = 613081245      ' Sub-object&#32;mapping
const PdCommon_DependencyMatrix                     = 1436794837     ' Dependency&#32;Matrix
const PdCommon_DependencyMatrixDefinition           = 1467919117     ' Dependency&#32;Matrix&#32;Definition
const PdCommon_DiagramSymbol                        = 1220868382     ' Diagram&#32;Symbol
const PdCommon_EllipseSymbol                        = 906510178      ' Ellipse
const PdCommon_EndSymbol                            = -1311138920    ' End&#32;symbol
const PdCommon_EventHandlerTargetItem               = -818839436     ' Event&#32;Handler
const PdCommon_ExtendedAttributeTargetItem          = 1482472205     ' Extended&#32;Attribute
const PdCommon_ExtendedAttributeTypeTargetItem      = 1482472206     ' Extended&#32;Attribute&#32;Type
const PdCommon_ExtendedBaseCollection               = 214098186      ' Extended&#32;Base&#32;Collection
const PdCommon_ExtendedBaseCollectionTargetItem     = 157587852      ' Extended&#32;Base&#32;Collection&#32;Definition
const PdCommon_ExtendedCollection                   = -1615865319    ' Extended&#32;Collection
const PdCommon_ExtendedCollectionTargetItem         = -713249051     ' Extended&#32;Collection
const PdCommon_ExtendedComposition                  = 349290082      ' Extended&#32;Composition
const PdCommon_ExtendedCompositionTargetItem        = 2030787720     ' Extended&#32;Composition
const PdCommon_ExtendedDependency                   = 1334298390     ' Traceability&#32;Link
const PdCommon_ExtendedDependencySymbol             = -1028641993    ' Traceability&#32;Link&#32;Symbol
const PdCommon_ExtendedLink                         = 868735579      ' Extended&#32;Link
const PdCommon_ExtendedLinkSymbol                   = 1474432416     ' Extended&#32;Link&#32;Symbol
const PdCommon_ExtendedModelDefinition              = 409766595      ' Extension
const PdCommon_ExtendedObject                       = -1963867183    ' Extended&#32;Object
const PdCommon_ExtendedObjectSymbol                 = 1666840185     ' Extended&#32;Object&#32;Symbol
const PdCommon_ExtendedSubObject                    = -428975331     ' Extended&#32;Sub-Object
const PdCommon_ExtensibleObject                     = 1334298381     ' Extensible&#32;Object
const PdCommon_ExternalFileDescriptor               = -842268690     ' External&#32;File&#32;Descriptor
const PdCommon_ExternalModelConnection              = 1572208347     ' External&#32;Model&#32;Connection
const PdCommon_ExternalModelLink                    = 1958642564     ' External&#32;Model&#32;Link
const PdCommon_FileImportMetaAttributeMappingTargetItem= -1351072376    ' File&#32;Import&#32;Meta-attribute&#32;Mapping
const PdCommon_FileImportMetaclassMappingTargetItem = 196269877      ' File&#32;Import&#32;Metaclass&#32;Mapping
const PdCommon_FileImportMetaCollectionMappingTargetItem= 790289795      ' File&#32;Import&#32;Metacollection&#32;Mapping
const PdCommon_FileImportMetaObjectTransformation   = 1153740286     ' File&#32;Import&#32;Meta-Object&#32;Transformation
const PdCommon_FileImportSubSchema                  = -1250091986    ' XML&#32;Import&#32;Schema
const PdCommon_FileImportTargetItem                 = -1024699243    ' XML&#32;Import
const PdCommon_FileObject                           = 1334298391     ' File
const PdCommon_FileObjectBaseSymbol                 = -1342084586    ' Base&#32;File&#32;Symbol
const PdCommon_FileObjectSymbol                     = -1028641994    ' File&#32;Symbol
const PdCommon_FormTargetItem                       = -1582912437    ' Form
const PdCommon_GeneratedFileTargetItem              = 241470658      ' Generated&#32;File
const PdCommon_GenerationCommandTargetItem          = 1141877940     ' Command
const PdCommon_GenerationOptionTargetItem           = -407871765     ' Option
const PdCommon_GenerationTargetDefinition           = 1482472196     ' DBMS
const PdCommon_GenerationTaskTargetItem             = -1249985427    ' Task
const PdCommon_GraphicalConstraint                  = 538244554      ' Graphical&#32;Constraint
const PdCommon_GroupSymbol                          = 906510183      ' Group&#32;Symbol
const PdCommon_IdentifiedObject                     = 908935658      ' Identified&#32;Object
const PdCommon_Instance                             = 1482472249     ' Instance
const PdCommon_IntegerTargetItem                    = 1482472199     ' Int&#32;Item
const PdCommon_IntraModelReport                     = 1482472231     ' Intra-Model&#32;Report
const PdCommon_Keyword                              = -64338965      ' Keyword
const PdCommon_LanguageMetaClassTargetItem          = -595632926     ' Language&#32;Metaclass
const PdCommon_LinguisticVariableInstance           = 803980825      ' Linguistic&#32;variable&#32;instance
const PdCommon_LinkObjectExtensibleSymbol           = 1014469072     ' Object&#32;Link&#32;Extensible&#32;Symbol
const PdCommon_LinkSymbol                           = 906510180      ' Link&#32;Symbol
const PdCommon_LinkSymbolBase                       = 906510197      ' LinkBase&#32;Symbol
const PdCommon_ListOfOptions                        = 1482472192     ' Options&#32;List
const PdCommon_ListReport                           = 373221828      ' List&#32;Report
const PdCommon_ListReportResultSet                  = 722993185      ' List&#32;Report&#32;Result&#32;Set
const PdCommon_ListTargetItem                       = 1482472244     ' List&#32;Item
const PdCommon_MappingClassifier                    = 1334298528     ' Mapping&#32;Classifier
const PdCommon_MapTargetItem                        = 1482472203     ' Map&#32;Item
const PdCommon_MDATransformation                    = -2000337917    ' MDA&#32;Transformation
const PdCommon_MenuTargetItem                       = 1210917474     ' Menu
const PdCommon_MetaAttribute                        = -851469322     ' Meta-attribute
const PdCommon_MetaClass                            = 1860158017     ' Metaclass
const PdCommon_MetaClassTargetItem                  = 2146164857     ' Metaclass
const PdCommon_MetaCollection                       = 167091232      ' Metacollection
const PdCommon_MetaExtensionContainerTargetItem     = -460427878     ' Metaextension&#32;Container
const PdCommon_MetaExtensionTargetItem              = 1128647272     ' Metaextension
const PdCommon_MetafileSymbol                       = 906510182      ' Metafile
const PdCommon_MetaLibrary                          = -898109165     ' Metalibrary
const PdCommon_MetaMember                           = 1689732300     ' Metamember
const PdCommon_MetaModel                            = 1202423933     ' Metamodel
const PdCommon_MethodTargetItem                     = -605608406     ' Method
const PdCommon_MixedFeature                         = 480586035      ' Named&#32;Hybrid&#32;Feature
const PdCommon_ModelCategorySet                     = 583952243      ' Model&#32;Category&#32;Set
const PdCommon_ModelCreationByDiagramTargetItem     = -1608047783    ' Diagram
const PdCommon_ModelCreationByTemplateTargetItem    = -271635661     ' Model&#32;Template
const PdCommon_ModelCreationCategoryTargetItem      = -1101460799    ' Model&#32;Category
const PdCommon_ModelFileDescriptor                  = 715240360      ' Model&#32;File&#32;Descriptor
const PdCommon_ModelLanguage                        = -1851934885    ' Model&#32;Language
const PdCommon_MultiModelReport                     = 1482472232     ' Multi-Model&#32;Report
const PdCommon_NamedClassifier                      = -1814925799    ' Named&#32;Classifier
const PdCommon_NamedLinkMappableObject              = 1674896637     ' Named&#32;Link
const PdCommon_NamedLinkObject                      = 1334298375     ' Named&#32;Link
const PdCommon_NamedObject                          = 1334298374     ' Named&#32;Object
const PdCommon_NamingConvention                     = 1482472195     ' Naming&#32;Conventions
const PdCommon_NoteLinkSymbol                       = -1028641997    ' Note&#32;Link
const PdCommon_NoteSymbol                           = -1028641999    ' Note&#32;Symbol
const PdCommon_ObjectCompositeSymbol                = -1028641996    ' Object&#32;Composite&#32;Symbol
const PdCommon_ObjectExtensibleSymbol               = -1821888358    ' Object&#32;Extensible&#32;Symbol
const PdCommon_ObjectGenerationCommand              = -1843543702    ' Object&#32;Generation&#32;Command
const PdCommon_ObjectGenerationMappingTargetItem    = 1765825787     ' Object&#32;Generation
const PdCommon_ObjectGenerationMetaAttributeMappingTargetItem= 1679774816     ' Object&#32;Generation&#32;Meta-attribute&#32;Mapping
const PdCommon_ObjectGenerationMetaclassMappingTargetItem= 1089160246     ' Object&#32;Generation&#32;Metaclass&#32;Mapping
const PdCommon_ObjectGenerationMetaCollectionMappingTargetItem= 1028844680     ' Object&#32;Generation&#32;Metacollection&#32;Mapping
const PdCommon_ObjectIconSymbol                     = -1028641995    ' Icon&#32;Symbol
const PdCommon_ObjectSelection                      = 1482472245     ' Object&#32;Selection
const PdCommon_ObjectStateVertex                    = -837026077     ' State&#32;Vertex
const PdCommon_ObjectSymbol                         = -1028642003    ' Object&#32;Symbol
const PdCommon_OleSymbol                            = 906510184      ' OLE
const PdCommon_OrderTargetItem                      = -690066112     ' Order&#32;Item
const PdCommon_PackageBaseSymbol                    = -1028641998    ' Package&#32;Symbol
const PdCommon_PackageDiagram                       = 1334298370     ' Diagram
const PdCommon_PermissionMetaClassTargetItem        = 1783847800     ' Permission&#32;Metaclass
const PdCommon_PermissionModuleTargetItem           = -1393388459    ' Module&#32;Permission
const PdCommon_PermissionProfile                    = 507416209      ' Metadata&#32;Permission&#32;Profile
const PdCommon_PersistentSelection                  = 1482472250     ' Persistent&#32;Selection
const PdCommon_PersistentSelectionManager           = -48073737      ' Persistent&#32;selection
const PdCommon_PieSymbol                            = 906510215      ' Pie
const PdCommon_PolygonSymbol                        = 906510185      ' Polygon
const PdCommon_PolylineBase                         = 906510169      ' BasePolyline
const PdCommon_PolylineSymbol                       = 906510176      ' Polyline
const PdCommon_PredefinedSymbol                     = 906510211      ' Predefined&#32;Symbol
const PdCommon_ProfileTargetItem                    = 1177843564     ' Profile
const PdCommon_Progress                             = -991846079     ' Progress
const PdCommon_ProgressDialog                       = -304835468     ' Progress&#32;Dialog
const PdCommon_ProgressStatusBar                    = 1393111087     ' Progress&#32;Status&#32;Bar
const PdCommon_QueryDbmsItem                        = 1174907860     ' Query&#32;Item
const PdCommon_RectangleSymbol                      = 906510177      ' Rectangle
const PdCommon_Replication                          = 908935665      ' Replication
const PdCommon_ReportBaseClass                      = -1497708336    ' Report&#32;Base&#32;Class
const PdCommon_ReportLanguage                       = 1482472247     ' Report&#32;Language
const PdCommon_ReportParagraphContainer             = -1497708333    ' Paragraph&#32;container
const PdCommon_ReportSection                        = 1482472229     ' Report&#32;Section
const PdCommon_ReportSelection                      = -1497708292    ' Report&#32;Selection
const PdCommon_ReportTemplate                       = -1497708298    ' Report&#32;Template&#32;Section
const PdCommon_ReportTitleTargetItem                = -72389149      ' Report&#32;Title&#32;Item
const PdCommon_ResourceFile                         = -1922927662    ' Resource&#32;File
const PdCommon_RoundRectangleSymbol                 = 906510186      ' Round&#32;Rectangle
const PdCommon_RptLanguageStringTargetItem          = -1951170550    ' String&#32;Item
const PdCommon_Settings                             = -760841376     ' Settings
const PdCommon_SharedMetaExtensionTargetItem        = -1581196942    ' Shared&#32;Metaextension
const PdCommon_Shortcut                             = 908935660      ' Shortcut
const PdCommon_ShortcutBase                         = 614657950      ' Base&#32;Shortcut
const PdCommon_SingletonMetaExtensionTargetItem     = -877622719     ' Singleton&#32;Metaextension
const PdCommon_SolidSymbol                          = 906510194      ' Solid&#32;symbol
const PdCommon_SolidTextSymbol                      = 906510210      ' Solid&#32;Text
const PdCommon_SQLQueryTargetItem                   = -1249985426    ' SQL&#32;Query
const PdCommon_StandardLinkSymbol                   = 906510198      ' Standard&#32;Link&#32;Symbol
const PdCommon_StandardSymbol                       = 906510193      ' Standard&#32;symbol
const PdCommon_StartSymbol                          = -1311138921    ' Start&#32;symbol
const PdCommon_StaticObject                         = 491525374      ' Static&#32;Object
const PdCommon_StereotypeTargetItem                 = 1938430477     ' Stereotype
const PdCommon_StringTargetItem                     = 1482472201     ' String&#32;Item
const PdCommon_StructuralFeature                    = 480586034      ' Named&#32;Structural&#32;Feature
const PdCommon_SubReplication                       = 908935664      ' Sub-Replication
const PdCommon_SwimlaneGroupSymbol                  = 906510208      ' Swimlane
const PdCommon_SwimlaneLineSymbol                   = 906510209      ' SwimColn
const PdCommon_SwimlaneSubGroupSymbol               = 906510217      ' Swimlane&#32;Group
const PdCommon_SymbolPen                            = 906510196      ' SymbolPen
const PdCommon_TargetCategory                       = 1482472197     ' Category
const PdCommon_TargetDescriptor                     = -1061245496    ' Target&#32;Descriptor
const PdCommon_TargetModel                          = 908935661      ' Target&#32;model&#32;reference
const PdCommon_TemplateTargetItem                   = 1482472246     ' Template
const PdCommon_TextSymbol                           = 906510179      ' Text
const PdCommon_TextTargetItem                       = 1482472202     ' Text&#32;Item
const PdCommon_TitleSymbol                          = -1028642000    ' Title&#32;Symbol
const PdCommon_TransformationBaseProfileTargetItem  = -1833658343    ' Transformation&#32;Profile
const PdCommon_TransformationSource                 = 575312080      ' Transformation&#32;Source
const PdCommon_TransformationTarget                 = 988894401      ' Transformation&#32;Target
const PdCommon_TransformationTargetItem             = -2085802521    ' Transformation
const PdCommon_TransformationTargetItemProfile      = -891986347     ' Transformation&#32;Profile
const PdCommon_TransientMappableBaseMetaAttribute   = -887848421     ' Base&#32;Meta-attribute
const PdCommon_TransientMappableBaseMetaClass       = 705328324      ' Base&#32;Metaclass
const PdCommon_TransientMappableBaseMetaCollection  = -2041566424    ' Base&#32;Metacollection
const PdCommon_TransientMappableBaseMetaObject      = -1506952595    ' Base&#32;Meta-object
const PdCommon_TransientMappableExternalMetaAttribute= -1442347193    ' External&#32;Meta-attribute
const PdCommon_TransientMappableExternalMetaClass   = 14724077       ' External&#32;Metaclass
const PdCommon_TransientMappableExternalMetaCollection= -1580197771    ' External&#32;Metacollection
const PdCommon_TransientMappableMetaAttribute       = 658494787      ' Meta-attribute
const PdCommon_TransientMappableMetaClass           = -2030730351    ' Metaclass
const PdCommon_TransientMappableMetaCollection      = -2049137923    ' Metacollection
const PdCommon_TransientNamedObject                 = 1482472204     ' Named&#32;Object
const PdCommon_TransientObject                      = 908935659      ' Light&#32;Object
const PdCommon_TransitionSymbol                     = -409387331     ' Transition&#32;symbol
const PdCommon_TreeJunctionLineSymbol               = 906510214      ' Branch
const PdCommon_TypedCategoryTargetItem              = 492651358      ' Typed&#32;Category
const PdCommon_UserProfile                          = 1113180636     ' User&#32;Profile
const PdCommon_XmlNamespaceBase                     = 1565743945     ' XML&#32;Namespace
const PdCommon_XsdDocumentBase                      = 1565743930     ' XSD&#32;Document

' *** PdWSP constants
' ==============================================

' - ERwinActions constants
const PdWSP_erw_none                                = 0
const PdWSP_erw_conceptual                          = 1
const PdWSP_erw_logical                             = 2
const PdWSP_erw_physical                            = 4
const PdWSP_erw_trigger                             = 8
const PdWSP_erw_inforeuse                           = 16
const PdWSP_erw_allimport                           = 7
const PdWSP_erw_all                                 = 31

' - PdWSP classes identifiers
const PdWSP_Workspace                               = -1101704105    ' Workspace
const PdWSP_WorkspaceDocument                       = -1064213327    ' Workspace&#32;Document
const PdWSP_WorkspaceElement                        = 1637063798     ' Workspace&#32;Element
const PdWSP_WorkspaceFile                           = -1574572356    ' Workspace&#32;File
const PdWSP_WorkspaceFolder                         = 1119173128     ' Workspace&#32;Folder
const PdWSP_WorkspaceModel                          = -1262200149    ' Workspace&#32;Model

' *** PdRMG constants
' ==============================================

' - SRmgObjStatus constants
const PdRMG_SRmgStatusNormal                        = 0
const PdRMG_SRmgStatusLocked                        = 1
const PdRMG_SRmgStatusMyLock                        = 3
const PdRMG_SRmgStatusNewLock                       = 7
const PdRMG_SRmgStatusLockMask                      = 7
const PdRMG_SRmgStatusMask                          = 7
const PdRMG_SRmgStatusInvalid                       = -1

' - SRmgLockType constants
const PdRMG_SRmgLockUserDefined                     = 0
const PdRMG_SRmgLockExclusion                       = 1

' - SRmgMergeMode constants
const PdRMG_SRmgMergeReadOnly                       = 0
const PdRMG_SRmgMergeOverwrite                      = 1
const PdRMG_SRmgMergeNoAutoResolve                  = 2
const PdRMG_SRmgMergeFavorLocalChanges              = 3
const PdRMG_SRmgMergeFavorRepositoryChanges         = 4
const PdRMG_SRmgMergeBaseline                       = 5

' - SRmgBranchStatus constants
const PdRMG_SRmgBranchStatusError                   = -1
const PdRMG_SRmgBranchStatusNew                     = 0
const PdRMG_SRmgBranchStatusUpToDate                = 1
const PdRMG_SRmgBranchStatusNoTargetChange          = 2
const PdRMG_SRmgBranchStatusTargetchange            = 3

' - SRmgUserRights constants
const PdRMG_SRmgUserRightConnect                    = 1
const PdRMG_SRmgUserRightFreezeVersions             = 2
const PdRMG_SRmgUserRightLockVersions               = 4
const PdRMG_SRmgUserRightManageBranches             = 8
const PdRMG_SRmgUserRightManageConfigurations       = 16
const PdRMG_SRmgUserRightManageAllDocuments         = 32
const PdRMG_SRmgUserRightManageUsers                = 64
const PdRMG_SRmgUserRightManageRepository           = 128
const PdRMG_SRmgUserRightEditPortalObjects          = 256

' - SRmgPermissions constants
const PdRMG_SRmgPermissionListable                  = 0
const PdRMG_SRmgPermissionRead                      = 10
const PdRMG_SRmgPermissionSubmit                    = 20
const PdRMG_SRmgPermissionWrite                     = 30
const PdRMG_SRmgPermissionFull                      = 40

' - SRmgPasswordError constants
const PdRMG_SRmgPasswordNoError                     = 0
const PdRMG_SRmgPasswordLengthMinError              = 1
const PdRMG_SRmgPasswordLengthMaxError              = 2
const PdRMG_SRmgPasswordLengthError                 = 3
const PdRMG_SRmgPasswordUsernameError               = 4
const PdRMG_SRmgPasswordDuplicateError              = 8
const PdRMG_SRmgPasswordUpperError                  = 16
const PdRMG_SRmgPasswordLowerError                  = 32
const PdRMG_SRmgPasswordDigitError                  = 64
const PdRMG_SRmgPasswordSpecialCharError            = 128
const PdRMG_SRmgPasswordStructureError              = 240
const PdRMG_SRmgPasswordNotificationError           = 256

' - PdRMG classes identifiers
const PdRMG_OtherRepositoryDocument                 = 1265430611     ' Other&#32;Document
const PdRMG_RepositoryBaseFolder                    = -889973334     ' Repository&#32;Base&#32;Folder
const PdRMG_RepositoryBaseObject                    = 1265430544     ' Base&#32;object
const PdRMG_RepositoryBranchFolder                  = 130189701      ' Repository&#32;Branch
const PdRMG_RepositoryChangeList                    = -592942284     ' Change&#32;List
const PdRMG_RepositoryCheckInOptions                = 508494270      ' Check-In&#32;Options
const PdRMG_RepositoryConfiguration                 = 1265430606     ' Configuration
const PdRMG_RepositoryConnection                    = 1265430593     ' Repository&#32;Connection
const PdRMG_RepositoryDocument                      = 1265430597     ' Document
const PdRMG_RepositoryDocumentBase                  = 1265430610     ' Base&#32;Document
const PdRMG_RepositoryFolder                        = 1265430594     ' Repository&#32;Folder
const PdRMG_RepositoryGroup                         = 1265430576     ' Group
const PdRMG_RepositoryModel                         = 1265430595     ' Model
const PdRMG_RepositoryObject                        = 1265430602     ' Repository&#32;Object
const PdRMG_RepositoryPackage                       = 1265430609     ' Package
const PdRMG_RepositoryReport                        = 1265430596     ' Report
const PdRMG_RepositoryUser                          = 1265430560     ' User
const PdRMG_RepositoryUserBase                      = 1265430561     ' Base&#32;User
const PdRMG_StoredObject                            = 1265430592     ' Repository&#32;Base&#32;Object

' *** PdGLM constants
' ==============================================

' - PdGLM classes identifiers
const PdGLM_Category                                = -852534159     ' Category
const PdGLM_CheckController                         = -1113918693    ' Check&#32;Model&#32;Controller
const PdGLM_GlossaryModelOptions                    = 721994823      ' Model&#32;Options
const PdGLM_GlossaryTermsList                       = -1666816918    ' Glossary&#32;Terms&#32;List
const PdGLM_Model                                   = -877220241     ' Glossary&#32;Model
const PdGLM_PackageOptions                          = 1497539319     ' Package&#32;Options
const PdGLM_Synonym                                 = -1666816919    ' Synonym
const PdGLM_Term                                    = -337033521     ' Term

' *** PdPDM constants
' ==============================================

' - SPdoDttpType constants
const PdPDM_CONCEPTUAL                              = 0
const PdPDM_PHYSICAL                                = 1
const PdPDM_ODBC                                    = 2
const PdPDM_HOST                                    = 3

' - GenerationType constants
const PdPDM_GEN_DATABASE                            = 0
const PdPDM_GEN_ALTERDB                             = 2
const PdPDM_GEN_TESTDATA                            = 3

' - PhysicalDataModelFunctions constants
const PdPDM_fct_DatabaseGeneration                  = 10
const PdPDM_fct_DatabaseModification                = 11
const PdPDM_fct_TestDataGeneration                  = 12
const PdPDM_fct_ExtractScript                       = 13

' - PdPDM classes identifiers
const PdPDM_AbstractDataType                        = 1269429833     ' Abstract&#32;Data&#32;Type
const PdPDM_AbstractDataTypeAttribute               = 1269429840     ' Abstract&#32;Data&#32;Type&#32;Attribute
const PdPDM_AbstractDataTypeProcedure               = 1269429842     ' Abstract&#32;Data&#32;Type&#32;Procedure
const PdPDM_AttributeMapping                        = 1174907845     ' Attribute&#32;Mapping
const PdPDM_BaseColumn                              = 1619092858     ' Base&#32;Column
const PdPDM_BaseIndex                               = 2033248956     ' Base&#32;Index
const PdPDM_BasePhysicalModel                       = 1269429824     ' Physical&#32;Data&#32;Model
const PdPDM_BasePhysicalModelOptions                = -461698752     ' Model&#32;Options
const PdPDM_BasePhysicalPackage                     = 1269429825     ' Package
const PdPDM_BasePhysicalPackageOptions              = -461698751     ' Package&#32;Options
const PdPDM_BaseProcedure                           = 1174907868     ' Base&#32;Procedure
const PdPDM_BaseTable                               = -1638535590    ' Base&#32;Table
const PdPDM_BaseTrigger                             = -726474939     ' Base&#32;Trigger
const PdPDM_CheckController                         = -840675774     ' Check&#32;Model&#32;Controller
const PdPDM_CheckModelObjectCategory                = -840675773     ' Check&#32;Model&#32;Category
const PdPDM_ClassifierMapping                       = 1269429880     ' Classifier&#32;Map
const PdPDM_Column                                  = 940288577      ' Column
const PdPDM_ColumnMapping                           = 1174907841     ' Column&#32;Mapping
const PdPDM_CostSaving                              = 1357073932     ' Cost&#32;Saving
const PdPDM_CubeDimensionAssociation                = 1269429873     ' Association
const PdPDM_CubeDimensionAssociationSymbol          = -840675786     ' Association&#32;Symbol
const PdPDM_CubeSymbol                              = -840675788     ' Cube&#32;Symbol
const PdPDM_Database                                = 1269429832     ' Database
const PdPDM_DatabasePackage                         = 1174907848     ' Database&#32;Package
const PdPDM_DatabasePackageCursor                   = 1174907864     ' Database&#32;Package&#32;Cursor
const PdPDM_DatabasePackageException                = 1174907865     ' Database&#32;Package&#32;Exception
const PdPDM_DatabasePackageProcedure                = 1174907867     ' Database&#32;Package&#32;Procedure
const PdPDM_DatabasePackageTemplate                 = 143715645      ' Database&#32;Package&#32;Template
const PdPDM_DatabasePackageType                     = 1174907863     ' Database&#32;Package&#32;Type
const PdPDM_DatabasePackageVariable                 = 1174907861     ' Database&#32;Package&#32;Variable
const PdPDM_DataSource                              = 1269429879     ' Data&#32;Source
const PdPDM_DBMS                                    = 1269429831     ' DBMS
const PdPDM_DBMSTrigger                             = -726474938     ' DBMS&#32;Trigger
const PdPDM_DefaultPhysicalOptions                  = 1433731657     ' Default&#32;Physical&#32;Options
const PdPDM_Dimension                               = 1269429876     ' Dimension
const PdPDM_DimensionAttribute                      = 1269429877     ' Attribute
const PdPDM_DimensionHierarchy                      = 1269429878     ' Hierarchy
const PdPDM_DimensionMapping                        = 1174907844     ' Dimension&#32;Mapping
const PdPDM_DimensionSymbol                         = -840675787     ' Dimension&#32;Symbol
const PdPDM_ExternalColumnMapping                   = -710826062     ' External&#32;Column&#32;Mapping
const PdPDM_ExternalTableMapping                    = -598879641     ' External&#32;Table&#32;Mapping
const PdPDM_Fact                                    = 1269429874     ' Fact
const PdPDM_FactAttribute                           = 1492871348     ' Fact&#32;Attribute
const PdPDM_FactAttributeMapping                    = -176860739     ' Fact&#32;Attribute&#32;Mapping
const PdPDM_FactMapping                             = 1174907842     ' Fact&#32;Mapping
const PdPDM_FactMeasure                             = 1269429875     ' Measure
const PdPDM_Group                                   = 1174907850     ' Group
const PdPDM_HorizontalPartitioning                  = 1174907856     ' Horizontal&#32;Partitioning
const PdPDM_Index                                   = 940288578      ' Index
const PdPDM_IndexColumn                             = 940288579      ' Index&#32;Column
const PdPDM_JoinIndex                               = 940288581      ' Join&#32;Index
const PdPDM_JoinIndexReference                      = 940288582      ' Join&#32;Index&#32;Reference
const PdPDM_Key                                     = 940288580      ' Key
const PdPDM_Lifecycle                               = 587337695      ' Lifecycle
const PdPDM_MeasureMapping                          = 1174907843     ' Measure&#32;Mapping
const PdPDM_MeasureRestriction                      = 1265392123     ' Restriction&#32;Link
const PdPDM_Model                                   = -840675807     ' Physical&#32;Data&#32;Model
const PdPDM_ModelOptions                            = -840675776     ' Model&#32;Options
const PdPDM_MultidimensionalDiagram                 = -840675805     ' Multidimensional&#32;Diagram
const PdPDM_Namespace                               = 1174907873     ' Namespace
const PdPDM_Package                                 = -840675806     ' Package
const PdPDM_PackageOptions                          = -840675775     ' Package&#32;Options
const PdPDM_PackageSymbol                           = -840675789     ' Package&#32;Symbol
const PdPDM_Parameter                               = 1174907866     ' Parameter
const PdPDM_Partition                               = 1174907855     ' Partition
const PdPDM_Partitioning                            = 1174907854     ' Partitioning
const PdPDM_Permission                              = 1174907851     ' Permission
const PdPDM_Phase                                   = 646721740      ' Phase
const PdPDM_PhysicalDefault                         = 1174907869     ' Default
const PdPDM_PhysicalDiagram                         = -840675808     ' Physical&#32;Diagram
const PdPDM_PhysicalDomain                          = 1269429830     ' Domain
const PdPDM_Procedure                               = -726474944     ' Procedure
const PdPDM_ProcedureSymbol                         = -840675784     ' Procedure&#32;Symbol
const PdPDM_ProcedureTemplate                       = -726474940     ' Procedure&#32;Template
const PdPDM_Reference                               = 1852601152     ' Reference
const PdPDM_ReferenceJoin                           = 1852601153     ' Reference&#32;Join
const PdPDM_ReferenceSymbol                         = -840675790     ' Reference&#32;Symbol
const PdPDM_ResultColumn                            = 1174907874     ' Result&#32;Column
const PdPDM_Role                                    = 1174907849     ' Role
const PdPDM_Sequence                                = 1269429856     ' Sequence
const PdPDM_Storage                                 = 1269429828     ' Storage
const PdPDM_StructuralFeatureMapping                = 1269429881     ' Structural&#32;Feature&#32;Map
const PdPDM_Synonym                                 = 1174907847     ' Synonym
const PdPDM_Table                                   = 940288576      ' Table
const PdPDM_TableCollapsing                         = 1174907858     ' Table&#32;Collapsing
const PdPDM_TableMapping                            = 1174907840     ' Table&#32;Mapping
const PdPDM_Tablespace                              = 1269429829     ' Tablespace
const PdPDM_TableSymbol                             = -840675792     ' Table&#32;Symbol
const PdPDM_TargetTable                             = 1174907859     ' Target&#32;Table
const PdPDM_TestDataProfile                         = 1269429827     ' Test&#32;Data&#32;Profile
const PdPDM_Transformation                          = 1174907853     ' Transformation
const PdPDM_Trigger                                 = -726474941     ' Trigger
const PdPDM_TriggerItem                             = -726474943     ' Trigger&#32;Item
const PdPDM_TriggerTemplate                         = -726474942     ' Trigger&#32;Template
const PdPDM_User                                    = 1269429826     ' User
const PdPDM_VerticalPartitioning                    = 1174907857     ' Vertical&#32;Partitioning
const PdPDM_View                                    = 1433731648     ' View
const PdPDM_ViewColumn                              = 1433731656     ' View&#32;Column
const PdPDM_ViewIndex                               = 1248314699     ' View&#32;Index
const PdPDM_ViewReference                           = 1269429884     ' View&#32;Reference
const PdPDM_ViewReferenceJoin                       = 1269429885     ' View&#32;Reference&#32;Join
const PdPDM_ViewReferenceSymbol                     = -840675785     ' View&#32;Reference&#32;Symbol
const PdPDM_ViewSymbol                              = -840675791     ' View&#32;Symbol
const PdPDM_WebOperation                            = 1174907871     ' Web&#32;Operation
const PdPDM_WebOperationParameter                   = 1174907872     ' Web&#32;Parameter
const PdPDM_WebService                              = 1174907870     ' Web&#32;Service

' *** PdBPM constants
' ==============================================

' - SBpmOperationType constants
const PdBPM_T_UNDEFINED                             = 0
const PdBPM_T_ONEWAY                                = 1
const PdBPM_T_REQUEST_RESPONSE                      = 2
const PdBPM_T_SOLLICIT_RESPONSE                     = 3
const PdBPM_T_NOTIFY                                = 4

' - SBpmProcessImplementationMode constants
const PdBPM_T_NONE                                  = 0
const PdBPM_T_EXEC_OPER                             = 1
const PdBPM_T_REUSE_PRCS                            = 2
const PdBPM_T_GEN_EVNT                              = 3
const PdBPM_T_LOOP                                  = 4
const PdBPM_T_CATCH_EVNT                            = 13

' - SBpmProcessActionType constants
const PdBPM_T_RECEIVE_MSSG                          = 5
const PdBPM_T_RECEIVE_REPLY                         = 6
const PdBPM_T_REPLY_NORMAL                          = 7
const PdBPM_T_REPLY_FAULT                           = 8
const PdBPM_T_SEND_MSSG                             = 9
const PdBPM_T_SYNC_CALL                             = 10
const PdBPM_T_ASYNC_CALL                            = 11

' - PdBPM classes identifiers
const PdBPM_BaseDataMapping                         = -1699551738    ' Base&#32;Mapping
const PdBPM_BoundaryEventSymbol                     = -764527218     ' Boundary&#32;Event&#32;symbol
const PdBPM_BusinessProcessDiagram                  = -764527248     ' Business&#32;Process&#32;Diagram
const PdBPM_BusinessProcessModelOptions             = -764527247     ' Model&#32;Options
const PdBPM_CheckController                         = -764527217     ' Check&#32;Model&#32;Controller
const PdBPM_ChoreographyDiagram                     = -437425581     ' Choreography&#32;Diagram
const PdBPM_ChoreographyTask                        = -437425579     ' Choreography&#32;Task
const PdBPM_ChoreographyTaskSymbol                  = -437425576     ' Choreography&#32;Task&#32;Symbol
const PdBPM_ConversationDiagram                     = -437425580     ' Conversation&#32;Diagram
const PdBPM_ConversationLink                        = -437425577     ' Conversation&#32;Link
const PdBPM_ConversationLinkSymbol                  = -437425574     ' Conversation&#32;Link&#32;Symbol
const PdBPM_ConversationNode                        = -437425578     ' Conversation&#32;Node
const PdBPM_ConversationNodeSymbol                  = -437425575     ' Conversation&#32;Node&#32;Symbol
const PdBPM_Correlation                             = -721787377     ' Correlation&#32;Key
const PdBPM_Data                                    = -764527136     ' Data
const PdBPM_DataAccess                              = -764527135     ' Data&#32;Access
const PdBPM_DataTransformation                      = -971602166     ' Data&#32;Transformation
const PdBPM_DataTransformationSymbol                = -1687405616    ' Data&#32;Transformation&#32;Symbol
const PdBPM_Decision                                = -764527242     ' Decision
const PdBPM_DecisionSymbol                          = -764527229     ' Decision&#32;symbol
const PdBPM_EmissionDataMapping                     = -897045711     ' Emission&#32;Mapping
const PdBPM_Event                                   = 588211999      ' Event
const PdBPM_FaultMessage                            = -764527131     ' Fault
const PdBPM_Flow                                    = -764527243     ' Flow
const PdBPM_FlowSymbol                              = -764527230     ' Flow&#32;Symbol
const PdBPM_FormatChoreographyDiagramSymbol         = -437425573     ' Message&#32;Format&#32;symbol
const PdBPM_FormatSymbol                            = -764527225     ' Message&#32;Format&#32;symbol
const PdBPM_MessageFlow                             = -764527234     ' Message&#32;Flow
const PdBPM_MessageFlowSymbol                       = -437425571     ' Message&#32;Flow&#32;Symbol
const PdBPM_MessageFormat                           = -764527241     ' Message&#32;Format
const PdBPM_MessagePart                             = 1445396525     ' Message&#32;Part
const PdBPM_Model                                   = 1027358876     ' Business&#32;Process&#32;Model
const PdBPM_Operation                               = -764527132     ' Operation
const PdBPM_OrganizationUnit                        = -764527233     ' Organization&#32;Unit
const PdBPM_OrganizationUnitConversationDiagramSymbol= -437425572     ' Organization&#32;Unit&#32;symbol
const PdBPM_OrganizationUnitSymbol                  = -764527222     ' Organization&#32;Unit&#32;symbol
const PdBPM_Package                                 = 1027358877     ' Package
const PdBPM_PackageOptions                          = -764527246     ' Package&#32;Options
const PdBPM_PackageSymbol                           = -764527232     ' Package&#32;Symbol
const PdBPM_Process                                 = -764527244     ' Process
const PdBPM_ProcessEnd                              = -764527235     ' End
const PdBPM_ProcessHierarchyDiagram                 = -764527264     ' Process&#32;Hierarchy&#32;Diagram
const PdBPM_ProcessLanguage                         = 1900138120     ' Process&#32;Language
const PdBPM_ProcessServiceDiagram                   = 1585827326     ' Process&#32;Service&#32;Diagram
const PdBPM_ProcessStart                            = -764527236     ' Start
const PdBPM_ProcessSymbol                           = -764527231     ' Process&#32;Symbol
const PdBPM_ProcessTreeSymbol                       = -764527220     ' Process&#32;Tree&#32;Symbol
const PdBPM_ReceptionDataMapping                    = 28541421       ' Reception&#32;Mapping
const PdBPM_Resource                                = -764527238     ' Resource
const PdBPM_ResourceFlow                            = -764527237     ' Resource&#32;Flow
const PdBPM_ResourceFlowSymbol                      = -764527224     ' Resource&#32;Flow&#32;Symbol
const PdBPM_ResourceSymbol                          = -764527226     ' Resource&#32;symbol
const PdBPM_RoleAssociation                         = 1706171376     ' Role&#32;Association
const PdBPM_RoleAssociationSymbol                   = -1518490003    ' Role&#32;Association&#32;Symbol
const PdBPM_ServiceInterface                        = -764527133     ' Service&#32;Interface
const PdBPM_ServiceProvider                         = -764527134     ' Service&#32;Provider
const PdBPM_ServiceProviderSymbol                   = -1448858735    ' Service&#32;Provider&#32;Symbol
const PdBPM_SwimlaneSymbol                          = -764527221     ' Organization&#32;Unit&#32;Swimlane&#32;symbol
const PdBPM_SwimpoolSymbol                          = -764527219     ' Swimpool&#32;symbol
const PdBPM_Synchronization                         = -764527239     ' Synchronization
const PdBPM_SynchronizationSymbol                   = -764527227     ' Synchronization&#32;symbol
const PdBPM_Variable                                = 1552591295     ' Variable
const PdBPM_VariableSymbol                          = 1527515119     ' Variable&#32;Symbol
const PdBPM_XmlNamespace                            = -764527116     ' XML&#32;Namespace
const PdBPM_XsdDocument                             = -764527115     ' XSD&#32;Document

' *** PdCDM constants
' ==============================================

' - PdCDM classes identifiers
const PdCDM_Association                             = 2552529        ' Association
const PdCDM_AssociationAttribute                    = 2552531        ' Association&#32;Attribute
const PdCDM_AssociationAttributeMapping             = 1762484106     ' Association&#32;Attribute&#32;Mapping
const PdCDM_AssociationLink                         = 2552530        ' Association&#32;Link
const PdCDM_AssociationLinkSymbol                   = 2552537        ' Association&#32;Link&#32;Symbol
const PdCDM_AssociationMapping                      = 1598651158     ' Association&#32;Mapping
const PdCDM_AssociationSymbol                       = 2552536        ' Association&#32;Symbol
const PdCDM_BaseAttribute                           = 509178227      ' Property
const PdCDM_BaseAttributeMapping                    = 1259005105     ' Base&#32;Attribute&#32;Mapping
const PdCDM_CheckController                         = 509178258      ' Check&#32;Model&#32;controller
const PdCDM_ClassAttributeMapping                   = 1463474306     ' Class&#32;Attribute&#32;Mapping
const PdCDM_ClassMapping                            = 1463474305     ' Class&#32;Mapping
const PdCDM_ConceptualDiagram                       = 509178243      ' Conceptual&#32;Diagram
const PdCDM_DataItem                                = 509178225      ' Data&#32;Item
const PdCDM_DataItemMapping                         = 133254444      ' Data&#32;Item&#32;Mapping
const PdCDM_DataSource                              = -742653554     ' Data&#32;Source
const PdCDM_DataStructureMapping                    = -1956447577    ' Data&#32;Structure&#32;Mapping
const PdCDM_Domain                                  = 509178230      ' Domain
const PdCDM_Entity                                  = 509178226      ' Entity
const PdCDM_EntityAttribute                         = 509178228      ' Entity&#32;Attribute
const PdCDM_EntityAttributeMapping                  = 668521752      ' Entity&#32;Attribute&#32;Mapping
const PdCDM_EntityMapping                           = -1577357646    ' Entity&#32;Mapping
const PdCDM_EntitySymbol                            = 509178245      ' Entity&#32;Symbol
const PdCDM_ExternalAssociationAttributeMapping     = -463925192     ' External&#32;Association&#32;Attribute&#32;Mapping
const PdCDM_ExternalAssociationMapping              = 141699701      ' External&#32;Association&#32;Mapping
const PdCDM_ExternalBaseAttributeMapping            = 1175622953     ' External&#32;Base&#32;Attribute&#32;Mapping
const PdCDM_ExternalDataItemMapping                 = 707323760      ' External&#32;Data&#32;Item&#32;Mapping
const PdCDM_ExternalDataStructureMapping            = -554023604     ' External&#32;Data&#32;Structure&#32;Mapping
const PdCDM_ExternalEntityAttributeMapping          = 826412378      ' External&#32;Entity&#32;Attribute&#32;Mapping
const PdCDM_ExternalEntityMapping                   = -568370400     ' External&#32;Entity&#32;Mapping
const PdCDM_ExternalInheritanceAttributeMapping     = 1463474304     ' External&#32;Inheritance&#32;Attribute&#32;Mapping
const PdCDM_ExternalInheritanceMapping              = -2029124030    ' External&#32;Inheritance&#32;Mapping
const PdCDM_Identifier                              = 509178229      ' Identifier
const PdCDM_Inheritance                             = 509178232      ' Inheritance
const PdCDM_InheritanceAttribute                    = 509178241      ' Inheritance&#32;Attribute
const PdCDM_InheritanceAttributeMapping             = 1657366688     ' Inheritance&#32;Attribute&#32;Mapping
const PdCDM_InheritanceLink                         = 509178240      ' Inheritance&#32;Link
const PdCDM_InheritanceLinkSymbol                   = 509178249      ' Inheritance&#32;Link&#32;Symbol
const PdCDM_InheritanceMapping                      = 1667477366     ' Inheritance&#32;Mapping
const PdCDM_InheritanceRootLinkSymbol               = 509178248      ' Inheritance&#32;Root&#32;Link&#32;Symbol
const PdCDM_InheritanceSymbol                       = 509178247      ' Inheritance&#32;Symbol
const PdCDM_Model                                   = 509178224      ' Conceptual&#32;Data&#32;Model
const PdCDM_ModelOptions                            = 509178256      ' Model&#32;Options
const PdCDM_Package                                 = 1503953        ' Package
const PdCDM_PackageOptions                          = 509178257      ' Package&#32;Options
const PdCDM_PackageSymbol                           = 509178244      ' Package&#32;Symbol
const PdCDM_Relationship                            = 509178231      ' Relationship
const PdCDM_RelationshipSymbol                      = 509178246      ' Relationship&#32;Symbol

' *** PdLDM constants
' ==============================================

' - PdLDM classes identifiers
const PdLDM_CheckController                         = 1630445463     ' Check&#32;Model&#32;controller
const PdLDM_Domain                                  = 1835509509     ' Domain
const PdLDM_Entity                                  = -664074415     ' Entity
const PdLDM_EntityAttribute                         = -513212376     ' Entity&#32;Attribute
const PdLDM_EntitySymbol                            = -2044982537    ' Entity&#32;Symbol
const PdLDM_Identifier                              = 67637410       ' Identifier
const PdLDM_Inheritance                             = 1476159781     ' Inheritance
const PdLDM_InheritanceAttribute                    = -493118225     ' Inheritance&#32;Attribute
const PdLDM_InheritanceLink                         = 420954049      ' Inheritance&#32;Link
const PdLDM_InheritanceLinkSymbol                   = -1159548091    ' Inheritance&#32;Link&#32;Symbol
const PdLDM_InheritanceRootLinkSymbol               = 1754497207     ' Inheritance&#32;Root&#32;Link&#32;Symbol
const PdLDM_InheritanceSymbol                       = 1333911953     ' Inheritance&#32;Symbol
const PdLDM_LogicalAttribute                        = 40656268       ' Attribute
const PdLDM_LogicalDiagram                          = 1283995252     ' Logical&#32;Diagram
const PdLDM_Model                                   = 1598421368     ' Logical&#32;Data&#32;Model
const PdLDM_ModelOptions                            = -937541710     ' Model&#32;Options
const PdLDM_Package                                 = -1242614161    ' Package
const PdLDM_PackageOptions                          = 852970103      ' Package&#32;Options
const PdLDM_PackageSymbol                           = 1556170655     ' Package&#32;Symbol
const PdLDM_Relationship                            = -621676637     ' Relationship
const PdLDM_RelationshipJoin                        = -341206044     ' Relationship&#32;Join
const PdLDM_RelationshipSymbol                      = 1597255554     ' Relationship&#32;Symbol

' *** PdILM constants
' ==============================================

' - ReplicationProcessQueryMode constants
const PdILM_ReplicationProcessQueryUpdate           = 0
const PdILM_ReplicationProcessQueryCreate           = 1
const PdILM_ReplicationProcessQueryUpdateOrCreate   = 2

' - PdILM classes identifiers
const PdILM_Article                                 = 58077370       ' Article
const PdILM_ArticleColumn                           = -1534162047    ' Article&#32;Column
const PdILM_BusinessProcess                         = 444822087      ' Business&#32;Process
const PdILM_BusinessProcessSymbol                   = -209967636     ' Business&#32;Process&#32;Symbol
const PdILM_CheckController                         = 456210364      ' Check&#32;Model&#32;Controller
const PdILM_Connection                              = 1934879962     ' Connection
const PdILM_ControlFlow                             = 1469009182     ' Control&#32;Flow
const PdILM_ControlFlowSymbol                       = 954109787      ' Control&#32;Flow&#32;Symbol
const PdILM_DataAggregation                         = 1561665699     ' Data&#32;Aggregation
const PdILM_DataAggregationSymbol                   = 1406100767     ' Data&#32;Aggregation&#32;Symbol
const PdILM_Database                                = 832786947      ' Database
const PdILM_DatabaseInput                           = -1467809246    ' Database&#32;Input
const PdILM_DatabaseInputSymbol                     = 1852130672     ' Database&#32;Input&#32;Symbol
const PdILM_DatabaseOutput                          = -87623990      ' Database&#32;Output
const PdILM_DatabaseOutputSymbol                    = 1196938593     ' Database&#32;Output&#32;Symbol
const PdILM_DatabaseSymbol                          = -1721233349    ' Database&#32;Symbol
const PdILM_DataCalculator                          = 832788227      ' Data&#32;Calculator
const PdILM_DataCalculatorSymbol                    = 1101223683     ' Data&#32;Calculator&#32;Symbol
const PdILM_DataConnection                          = 399491714      ' Data&#32;Connection
const PdILM_DataConnectionGroup                     = 1219035402     ' Data&#32;Connection&#32;Group
const PdILM_DataConnectionSymbol                    = -805151031     ' Data&#32;Connection&#32;Symbol
const PdILM_DataFilter                              = 1115255386     ' Data&#32;Filter
const PdILM_DataFilterSymbol                        = -743254619     ' Data&#32;Filter&#32;Symbol
const PdILM_DataFlow                                = 1805839199     ' Data&#32;Flow
const PdILM_DataFlowSymbol                          = -1835502198    ' Data&#32;Flow&#32;Symbol
const PdILM_DataInput                               = -362157416     ' Data&#32;Input
const PdILM_DataJoin                                = -210761215     ' Data&#32;Join
const PdILM_DataJoinSymbol                          = 1035363678     ' Data&#32;Join&#32;Symbol
const PdILM_DataLookup                              = -918985910     ' Data&#32;Lookup
const PdILM_DataLookupSymbol                        = 46060848       ' Data&#32;Lookup&#32;Symbol
const PdILM_DataMerge                               = -1599712224    ' Data&#32;Merge
const PdILM_DataMergeSymbol                         = -60488332      ' Data&#32;Merge&#32;Symbol
const PdILM_DataMovementDiagram                     = 1060046219     ' Data&#32;Movement&#32;Diagram
const PdILM_DataMovementModelOptions                = -309832534     ' Model&#32;Options
const PdILM_DataMovementProcess                     = 1561230855     ' Process
const PdILM_DataOutput                              = -1970726624    ' Data&#32;Output
const PdILM_DataProjection                          = 832787987      ' Data&#32;Projection
const PdILM_DataProjectionSymbol                    = 1101223443     ' Data&#32;Projection&#32;Symbol
const PdILM_DataQueryExecution                      = 1616967678     ' Data&#32;Query&#32;Execution
const PdILM_DataQueryExecutionSymbol                = -832055984     ' Data&#32;Query&#32;Execution&#32;Symbol
const PdILM_DataQueryTransform                      = -1497012289    ' Data&#32;Query&#32;Transform
const PdILM_DataQueryTransformSymbol                = -2035710918    ' Data&#32;Query&#32;Transform&#32;Symbol
const PdILM_DataSort                                = -12564272      ' Data&#32;Sort
const PdILM_DataSortSymbol                          = -470670058     ' Data&#32;Sort&#32;Symbol
const PdILM_DataSplit                               = 359259080      ' Data&#32;Split
const PdILM_DataSplitSymbol                         = 1064191438     ' Data&#32;Split&#32;Symbol
const PdILM_DataStore                               = 618586082      ' Data&#32;Store
const PdILM_DataStructureColumn                     = -176683457     ' Data&#32;Structure&#32;Column
const PdILM_DataStructureJoin                       = -727939477     ' Data&#32;Structure&#32;Join
const PdILM_DataStructureSortedColumn               = 522459037      ' Data&#32;Structure&#32;Sorted&#32;Column
const PdILM_DataTransformationAction                = -1404489283    ' Data&#32;Transformation&#32;Action
const PdILM_DataTransformationTask                  = -1940508698    ' Data&#32;Transformation&#32;Task
const PdILM_EventScript                             = 854680705      ' Event&#32;Script
const PdILM_FlatFile                                = 832787267      ' Flat&#32;File
const PdILM_FlatFileInput                           = 832787507      ' Flat&#32;File&#32;Input
const PdILM_FlatFileInputSymbol                     = 1101222963     ' Flat&#32;File&#32;Input&#32;Symbol
const PdILM_FlatFileOutput                          = 832787747      ' Flat&#32;File&#32;Output
const PdILM_FlatFileOutputSymbol                    = 1101223203     ' Flat&#32;File&#32;Output&#32;Symbol
const PdILM_FlatFileSymbol                          = 1109611571     ' Flat&#32;File&#32;Symbol
const PdILM_GenericAction                           = -2113194618    ' Generic&#32;Action
const PdILM_GenericActionSymbol                     = -2113190522    ' Generic&#32;Action&#32;Symbol
const PdILM_GenericDataInput                        = -754640947     ' Generic&#32;Data&#32;Input
const PdILM_GenericDataInputSymbol                  = -754636851     ' Generic&#32;Input&#32;Symbol
const PdILM_GenericDataOutput                       = -441523804     ' Generic&#32;Data&#32;Output
const PdILM_GenericDataOutputSymbol                 = -441564764     ' Generic&#32;Output&#32;Symbol
const PdILM_IlmBaseObjectSymbol                     = -1791570429    ' Base&#32;Object&#32;Symbol
const PdILM_IlmDualIconSymbol                       = -1295716498    ' DMM&#32;Dual&#32;Icon&#32;Symbol
const PdILM_Model                                   = 1064887860     ' Data&#32;Movement&#32;Model
const PdILM_ModelConnector                          = 92353790       ' Model&#32;Connector
const PdILM_Package                                 = 1064887861     ' Package
const PdILM_PackageOptions                          = -446857575     ' Package&#32;Options
const PdILM_PackageSymbol                           = -465940218     ' Package&#32;Symbol
const PdILM_Parameter                               = -155895289     ' Parameter
const PdILM_Procedure                               = 1800483498     ' Procedure
const PdILM_ProcessConnection                       = 34234313       ' Process&#32;Connection
const PdILM_ProcessConnectionSymbol                 = -65329626      ' Process&#32;Connection&#32;Symbol
const PdILM_Publication                             = 14655728       ' Publication
const PdILM_ReplicationProcess                      = 2108098837     ' Replication&#32;Process
const PdILM_ReplicationProcessSymbol                = -314332660     ' Replication&#32;Process&#32;Symbol
const PdILM_ScriptExecution                         = 1710155859     ' Script&#32;Execution
const PdILM_ScriptExecutionSymbol                   = 437372235      ' Script&#32;Execution&#32;Symbol
const PdILM_Server                                  = -667503977     ' Server
const PdILM_ServerSymbol                            = 1293163197     ' Server&#32;Symbol
const PdILM_Subscription                            = 910553142      ' Subscription
const PdILM_TransformationControlFlow               = -47720115      ' Transformation&#32;Control&#32;Flow
const PdILM_TransformationControlFlowDiagram        = -1741510269    ' Transformation&#32;Control&#32;Flow&#32;Diagram
const PdILM_TransformationDecision                  = 1296194321     ' Transformation&#32;Decision
const PdILM_TransformationDecisionSymbol            = -1664415252    ' Transformation&#32;Decision&#32;Symbol
const PdILM_TransformationDiagram                   = 1284705758     ' Data&#32;Transformation&#32;Diagram
const PdILM_TransformationEnd                       = -1850905452    ' Transformation&#32;End
const PdILM_TransformationEndSymbol                 = -1203755604    ' Transformation&#32;End&#32;Symbol
const PdILM_TransformationParameter                 = 1130863799     ' Transformation&#32;Parameter
const PdILM_TransformationProcess                   = -36205129      ' Transformation&#32;Process
const PdILM_TransformationProcessSymbol             = -812523240     ' Transformation&#32;Process&#32;Symbol
const PdILM_TransformationStart                     = -43223059      ' Transformation&#32;Start
const PdILM_TransformationStartSymbol               = -558520996     ' Transformation&#32;Start&#32;Symbol
const PdILM_TransformationStep                      = -246716160     ' Transformation&#32;Step
const PdILM_TransformationSynchronization           = 709719127      ' Transformation&#32;Synchronization
const PdILM_TransformationSynchronizationSymbol     = 2078201241     ' Transformation&#32;Synchronization&#32;Symbol
const PdILM_TransformationTaskExecution             = -1666325058    ' Transformation&#32;Task&#32;Execution
const PdILM_TransformationTaskExecutionSymbol       = 1624253776     ' Transformation&#32;Task&#32;Execution&#32;Symbol
const PdILM_User                                    = 217166885      ' User
const PdILM_WebServiceInput                         = -1184257938    ' Web&#32;Service&#32;Input
const PdILM_WebServiceInputSymbol                   = 1160439228     ' Web&#32;Service&#32;Input&#32;Symbol
const PdILM_XMLDocument                             = -1528148998    ' XML&#32;Document
const PdILM_XMLDocumentSymbol                       = -1789862134    ' XML&#32;Document&#32;Symbol
const PdILM_XMLInput                                = -1183163004    ' XML&#32;Input
const PdILM_XMLInputSymbol                          = -1968323109    ' XML&#32;Input&#32;Symbol
const PdILM_XMLOutput                               = -1281853604    ' XML&#32;Output
const PdILM_XMLOutputSymbol                         = -13322925      ' XML&#32;Output&#32;Symbol

' *** PdFRM constants
' ==============================================

' - PdFRM classes identifiers
const PdFRM_CheckController                         = 83568180       ' Check&#32;Model&#32;Controller
const PdFRM_FreeDiagram                             = 1146686611     ' Free&#32;Diagram
const PdFRM_FreeModelOptions                        = -1602547474    ' Model&#32;Options
const PdFRM_Model                                   = -1546238270    ' Free&#32;Model
const PdFRM_Package                                 = -131458534     ' Package
const PdFRM_PackageOptions                          = -1423160528    ' Package&#32;Options
const PdFRM_PackageSymbol                           = 1109175281     ' Package&#32;Symbol

' *** PdPRJ constants
' ==============================================

' - PdPRJ classes identifiers
const PdPRJ_BaseFramework                           = -1744642673    ' Base&#32;Framework
const PdPRJ_BaseFrameworkCell                       = 1789618940     ' Base&#32;Framework&#32;Cell
const PdPRJ_BaseProjectDocument                     = -1380729304    ' Project&#32;Document
const PdPRJ_CellSymbol                              = 1513443601     ' Cell&#32;Symbol
const PdPRJ_CheckController                         = -1003567705    ' Check&#32;Project&#32;Controller
const PdPRJ_ColumnSymbol                            = 480613900      ' Matrix&#32;Column&#32;Symbol
const PdPRJ_DependencyLink                          = 176569805      ' Dependency&#32;Link
const PdPRJ_DependencyLinkSymbol                    = 65019275       ' Dependency&#32;Link&#32;Symbol
const PdPRJ_DiagramDocument                         = -1255400904    ' Diagram&#32;Document
const PdPRJ_DocumentArtifactSubSymbol               = -663006708     ' Document&#32;Sub-symbol
const PdPRJ_FileDocument                            = 790393492      ' File
const PdPRJ_FileDocumentSymbol                      = -1380642172    ' File&#32;Symbol
const PdPRJ_Framework                               = -593937793     ' Framework
const PdPRJ_FrameworkAction                         = 1325621674     ' Action
const PdPRJ_FrameworkArea                           = -244637375     ' Framework&#32;Area
const PdPRJ_FrameworkCell                           = -216662656     ' Cell
const PdPRJ_FrameworkColumn                         = -1445658889    ' Column
const PdPRJ_FrameworkDiagram                        = 16222942       ' Framework&#32;Diagram
const PdPRJ_FrameworkLink                           = -1149255968    ' Framework&#32;Link
const PdPRJ_FrameworkLinkSymbol                     = 640557101      ' Framework&#32;Link&#32;Symbol
const PdPRJ_FrameworkMatrix                         = 1498861043     ' Framework&#32;Matrix
const PdPRJ_FrameworkMatrixDiagram                  = -1201067134    ' Framework&#32;Matrix&#32;Diagram
const PdPRJ_FrameworkNode                           = -791629120     ' Framework&#32;Node
const PdPRJ_FrameworkNodeSymbol                     = -294708029     ' Framework&#32;Node&#32;Symbol
const PdPRJ_FrameworkRow                            = 407318521      ' Row
const PdPRJ_GraphicalCompositeAreaSymbol            = -1385216663    ' Area&#32;Symbol
const PdPRJ_ListDocument                            = 1139882987     ' List&#32;Document
const PdPRJ_ModelDocument                           = -669176374     ' Model
const PdPRJ_ModelDocumentSymbol                     = 632502658      ' Model&#32;Symbol
const PdPRJ_PackageOptions                          = -2011877371    ' Package&#32;Options
const PdPRJ_Project                                 = -11836104      ' Project
const PdPRJ_ProjectDiagram                          = 1941285099     ' Project&#32;Diagram
const PdPRJ_ProjectFolder                           = -1339017145    ' Folder
const PdPRJ_ProjectModelOptions                     = -13148983      ' Model&#32;Options
const PdPRJ_RowSymbol                               = -1620163989    ' Matrix&#32;Row&#32;Symbol
const PdPRJ_TopLeftMatrixCornerSymbol               = 307562650      ' Top&#32;Left&#32;Matrix&#32;Corner&#32;Symbol

' *** PdEAM constants
' ==============================================

' - PdEAM classes identifiers
const PdEAM_ApplicationArchitectureDiagram          = 1313600238     ' Application&#32;Architecture&#32;Diagram
const PdEAM_ApplicationConcept                      = 1708965845     ' Application&#32;Concept
const PdEAM_ApplicationLink                         = -221867020     ' Application&#32;Link
const PdEAM_ApplicationLinkSymbol                   = -1023589163    ' Application&#32;Link&#32;Symbol
const PdEAM_ApplicationService                      = 1034546396     ' Application&#32;Service
const PdEAM_ApplicationServiceSymbol                = -1314018491    ' Application&#32;Service&#32;Symbol
const PdEAM_ArchitectureArea                        = 1712643291     ' Architecture&#32;Area
const PdEAM_ArchitectureAreaSymbol                  = -941765911     ' Architecture&#32;Area&#32;Symbol
const PdEAM_BaseProcessSymbol                       = -1864338088    ' Base&#32;Process&#32;Symbol
const PdEAM_BaseService                             = 62984427       ' Base&#32;Service
const PdEAM_BusinessCommunicationDiagram            = -730831028     ' Business&#32;Communication&#32;Diagram
const PdEAM_BusinessConcept                         = -982390413     ' Business&#32;Concept
const PdEAM_BusinessFlow                            = -467309660     ' Business&#32;Flow
const PdEAM_BusinessFlowSymbol                      = -1333371714    ' Business&#32;Flow&#32;Symbol
const PdEAM_BusinessFunction                        = 2136337986     ' Business&#32;Function
const PdEAM_BusinessFunctionSymbol                  = -557052834     ' Business&#32;Function&#32;Symbol
const PdEAM_BusinessService                         = 173053382      ' Business&#32;Service
const PdEAM_BusinessServiceSymbol                   = 442018816      ' Business&#32;Service&#32;Symbol
const PdEAM_CheckController                         = -1946744180    ' Check&#32;Model&#32;Controller
const PdEAM_CityPlanningDiagram                     = 816598417      ' City&#32;Planning&#32;Diagram
const PdEAM_Component                               = -868185973     ' Component
const PdEAM_ComponentSymbol                         = -726568304     ' Component&#32;Symbol
const PdEAM_ConstrainedProcessSymbol                = -519152456     ' Constrained&#32;Process&#32;Symbol
const PdEAM_Contract                                = 94705393       ' Contract
const PdEAM_ContractSymbol                          = -1928154730    ' Contract&#32;Symbol
const PdEAM_Data                                    = -326940068     ' Data
const PdEAM_Database                                = 1450253153     ' Database
const PdEAM_DatabaseSymbol                          = 1248439903     ' Database&#32;Symbol
const PdEAM_DeploymentInstance                      = -608874453     ' Deployment&#32;Instance
const PdEAM_DeploymentInstanceSymbol                = 1588501668     ' Deployment&#32;Instance&#32;Symbol
const PdEAM_Document                                = 2112166684     ' Document
const PdEAM_DocumentObject                          = -1857775242    ' Document&#32;Object
const PdEAM_DocumentSymbol                          = -752122463     ' Document&#32;Symbol
const PdEAM_EnterpriseApplication                   = -798898886     ' Application
const PdEAM_EnterpriseApplicationSymbol             = -350683205     ' Enterprise&#32;Application&#32;Symbol
const PdEAM_EnterpriseArchitectureDiagram           = -1697201342    ' Enterprise&#32;Architecture&#32;Diagram
const PdEAM_EnterpriseArchitectureModelOptions      = 431246144      ' Model&#32;Options
const PdEAM_EnterpriseComposite                     = -1707375718    ' Base&#32;Composite&#32;Object
const PdEAM_ETLJob                                  = 673380732      ' ETL&#32;Job
const PdEAM_ETLJobSymbol                            = 1944927423     ' ETL&#32;Job&#32;Symbol
const PdEAM_Form                                    = 1333827249     ' Form
const PdEAM_FormSymbol                              = -891032850     ' Form&#32;Symbol
const PdEAM_Fulfillment                             = -1238856748    ' Fulfillment
const PdEAM_FulfillmentLinkSymbol                   = 952302843      ' Fulfillment&#32;Link&#32;Symbol
const PdEAM_Goal                                    = -848891443     ' Goal
const PdEAM_GoalSymbol                              = -608831041     ' Goal&#32;Symbol
const PdEAM_HardwareAsset                           = -1722964824    ' Hardware&#32;Asset
const PdEAM_HardwarePlatform                        = -1401597217    ' Hardware&#32;Platform
const PdEAM_HardwareServer                          = 1800760343     ' Hardware&#32;Server
const PdEAM_HardwareServerSymbol                    = 1002371453     ' Hardware&#32;Server&#32;Symbol
const PdEAM_Impact                                  = -1003681353    ' Impact
const PdEAM_ImpactLinkSymbol                        = 1232706896     ' Impact&#32;Link&#32;Symbol
const PdEAM_InfrastructureConcept                   = 2132629500     ' Infrastructure&#32;Concept
const PdEAM_InfrastructureLink                      = 1999962906     ' Infrastructure&#32;Link
const PdEAM_InfrastructureLinkSymbol                = 2027313303     ' Infrastructure&#32;Link&#32;Symbol
const PdEAM_Initiative                              = 1974321394     ' Initiative
const PdEAM_MobileDevice                            = -2073163699    ' Mobile&#32;Device
const PdEAM_MobileDeviceSymbol                      = -1650209273    ' Mobile&#32;Device&#32;Symbol
const PdEAM_Model                                   = 1377159070     ' Enterprise&#32;Architecture&#32;Model
const PdEAM_Network                                 = -1750244528    ' Network
const PdEAM_NetworkNode                             = -180370349     ' Network&#32;Node
const PdEAM_NetworkNodeSymbol                       = 2032302552     ' Network&#32;Node&#32;Symbol
const PdEAM_NetworkSymbol                           = 613923286      ' Network&#32;Symbol
const PdEAM_Operation                               = -995632949     ' Operation
const PdEAM_OrganizationChartDiagram                = -1407297317    ' Organization&#32;Chart
const PdEAM_OrganizationUnit                        = 193466656      ' Organization&#32;Unit
const PdEAM_OrganizationUnitSymbol                  = 20064821       ' Organization&#32;Unit&#32;Symbol
const PdEAM_OrganizationUnitTreeSymbol              = -448617919     ' Organization&#32;Unit&#32;Tree&#32;Symbol
const PdEAM_Package                                 = 1102337857     ' Package
const PdEAM_PackageOptions                          = -1193545408    ' Package&#32;Options
const PdEAM_PackageSymbol                           = -342887712     ' Package&#32;Symbol
const PdEAM_Person                                  = 1715581492     ' Person
const PdEAM_PersonSymbol                            = -1719680705    ' Person&#32;Symbol
const PdEAM_PersonTreeSymbol                        = 380562451      ' Person&#32;Tree&#32;Symbol
const PdEAM_Phase                                   = 1553169700     ' Phase
const PdEAM_Process                                 = -1174562654    ' Process
const PdEAM_ProcessMapDiagram                       = 1974096499     ' Process&#32;Map
const PdEAM_ProcessSymbol                           = -115477451     ' Process&#32;Symbol
const PdEAM_Program                                 = 1953835517     ' Program
const PdEAM_ProgramSymbol                           = -86174548      ' Program&#32;Symbol
const PdEAM_Project                                 = 794489140      ' Project
const PdEAM_ProjectSymbol                           = 524474020      ' Project&#32;Symbol
const PdEAM_ReportDocument                          = -744212340     ' Report&#32;Document
const PdEAM_ReportDocumentSymbol                    = -2124793168    ' Report&#32;Document&#32;Symbol
const PdEAM_Role                                    = 727236437      ' Role
const PdEAM_RoleAssociation                         = 1608864953     ' Role&#32;Association
const PdEAM_RoleAssociationLinkSymbol               = 62178094       ' Role&#32;Association&#32;Link&#32;Symbol
const PdEAM_RolePlayer                              = -1813347699    ' Role&#32;Player
const PdEAM_RoleSymbol                              = -2052824291    ' Role&#32;Symbol
const PdEAM_ServiceOrientedDiagram                  = -1406172896    ' Service&#32;Oriented&#32;Diagram
const PdEAM_Site                                    = -601823687     ' Site
const PdEAM_SiteSymbol                              = -873817510     ' Site&#32;Symbol
const PdEAM_SoftwareServer                          = -233502108     ' Software&#32;Server
const PdEAM_SoftwareServerSymbol                    = 449174637      ' Software&#32;Server&#32;Symbol
const PdEAM_SymbolInitiative                        = -376082016     ' Initiative&#32;Symbol
const PdEAM_System                                  = 298085416      ' System
const PdEAM_SystemSymbol                            = 1517576000     ' System&#32;Symbol
const PdEAM_TechnologyInfrastructureDiagram         = -1226252125    ' Technology&#32;Infrastructure&#32;Diagram
const PdEAM_TimelineDefinition                      = -885192081     ' Timeline&#32;Definition
const PdEAM_TimelineDiagram                         = 792460099      ' Timeline&#32;Diagram
const PdEAM_TimelineSymbol                          = 718484535      ' Timeline&#32;Symbol
const PdEAM_Workstation                             = 376140120      ' Workstation
const PdEAM_WorkstationSymbol                       = -1621851232    ' Workstation&#32;Symbol

' *** PdIAM constants
' ==============================================

' - PdIAM classes identifiers
const PdIAM_AnalysisRule                            = 688512693      ' Analysis&#32;Rule&#32;Set
const PdIAM_CheckController                         = -1507982927    ' Check&#32;Model&#32;Controller
const PdIAM_ImpactAnalysisCategory                  = 1565743944     ' Impact&#32;Analysis&#32;Category
const PdIAM_ImpactAnalysisDiagram                   = 849647794      ' Impact&#32;Analysis&#32;Diagram
const PdIAM_ImpactAnalysisImpactedModel             = -720280294     ' Impact&#32;Analysis&#32;Impacted&#32;Model
const PdIAM_ImpactAnalysisModel                     = -412347194     ' Impact&#32;Analysis&#32;Model
const PdIAM_ImpactAnalysisModelOptions              = -1650684011    ' Model&#32;Options
const PdIAM_ImpactAnalysisObject                    = -1707724454    ' Analysis&#32;Object
const PdIAM_ImpactAnalysisObjectSymbol              = 2089006198     ' Impact&#32;Analysis&#32;Object&#32;Symbol
const PdIAM_ImpactLinkSymbol                        = 2089006199     ' Analysis&#32;Link
const PdIAM_PackageOptions                          = 1083718252     ' Package&#32;Options

' *** PdMTM constants
' ==============================================

' - PdMTM classes identifiers
const PdMTM_Action                                  = 1502785714     ' Action
const PdMTM_Actor                                   = 1502785712     ' Actor
const PdMTM_ActorSwimlaneSymbol                     = -399274532     ' MOT&#32;Actor&#32;Symbol
const PdMTM_ActorSymbol                             = -399274543     ' Actor&#32;Symbol
const PdMTM_BaseAction                              = 1502785728     ' Base&#32;Action
const PdMTM_BaseOperation                           = 1502785725     ' Base&#32;Operation
const PdMTM_BaseOperationSymbol                     = -399274541     ' Base&#32;Operation&#32;Symbol
const PdMTM_BaseOperationTriggering                 = 1502785726     ' Base&#32;Operation&#32;Triggering
const PdMTM_BaseOperationTriggeringSymbol           = -399274537     ' Base&#32;Operation&#32;Triggering&#32;Symbol
const PdMTM_CheckController                         = -1288040896    ' Check&#32;Model&#32;Controller
const PdMTM_ConceptualDiagram                       = -1697282031    ' Conceptual&#32;Diagram
const PdMTM_Data                                    = 1502785723     ' Data
const PdMTM_DataAccess                              = 1502785724     ' Data&#32;Access
const PdMTM_EmissionRule                            = 1502785717     ' Emission&#32;Rule
const PdMTM_EmissionRuleSymbol                      = -399274533     ' Emission&#32;Rule&#32;Symbol
const PdMTM_Event                                   = 1502785715     ' Event
const PdMTM_EventEmission                           = 1502785719     ' Event&#32;Emission
const PdMTM_EventEmissionSymbol                     = -399274538     ' Event&#32;Emission&#32;Symbol
const PdMTM_EventSymbol                             = -399274534     ' Event&#32;Symbol
const PdMTM_Flow                                    = 1502785713     ' Flow
const PdMTM_FlowDiagram                             = -1697282032    ' Flow&#32;Diagram
const PdMTM_FlowSymbol                              = -399274542     ' Flow&#32;Symbol
const PdMTM_FolderOptions                           = 1139743458     ' Merise&#32;Process&#32;Model
const PdMTM_MeriseTreatmentDiagram                  = 1139743456     ' Merise&#32;Process&#32;Diagram
const PdMTM_Model                                   = -1956825472    ' Merise&#32;Process&#32;Model
const PdMTM_ModelOptions                            = 1139743457     ' Merise&#32;Process&#32;Model
const PdMTM_Module                                  = 1502785720     ' Module
const PdMTM_MotSwimlaneSymbol                       = -399274529     ' Actor&#32;Swimlane&#32;Symbol
const PdMTM_Operation                               = 1502785716     ' Operation
const PdMTM_OperationEmission                       = 1502785729     ' Operation&#32;Emission
const PdMTM_OperationEmissionSymbol                 = -399274531     ' Operation&#32;Emission&#32;Symbol
const PdMTM_OperationSymbol                         = -399274540     ' Operation&#32;Symbol
const PdMTM_OperationTriggering                     = 1502785718     ' Operation&#32;Triggering
const PdMTM_OperationTriggeringSymbol               = -399274536     ' Operation&#32;Triggering&#32;Symbol
const PdMTM_OrganizationalDiagram                   = -1697282030    ' Organizational&#32;Diagram
const PdMTM_Package                                 = -1956825471    ' Package
const PdMTM_PackageSymbol                           = -399274544     ' Package&#32;Symbol
const PdMTM_Phase                                   = 1502785722     ' Phase
const PdMTM_PhaseEmission                           = 1502785730     ' Phase&#32;Emission
const PdMTM_PhaseEmissionSymbol                     = -399274530     ' Phase&#32;Emission&#32;Symbol
const PdMTM_PhaseSymbol                             = -399274539     ' Phase&#32;Symbol
const PdMTM_PhaseTriggering                         = 1502785727     ' Phase&#32;Triggering
const PdMTM_PhaseTriggeringSymbol                   = -399274535     ' Phase&#32;Triggering&#32;Symbol
const PdMTM_Task                                    = 1502785721     ' Task

' *** PdOOM constants
' ==============================================

' - PdOOM classes identifiers
const PdOOM_Action                                  = 403777284      ' Action
const PdOOM_ActivationSymbol                        = 432142930      ' Activation&#32;Symbol
const PdOOM_Activity                                = -837026074     ' Activity
const PdOOM_ActivityDiagram                         = 403776512      ' Activity&#32;Diagram
const PdOOM_ActivityFlow                            = -837026047     ' Flow
const PdOOM_ActivityParameter                       = -837026044     ' Activity&#32;Parameter
const PdOOM_ActivityParameterSymbol                 = -837026040     ' Activity&#32;Parameter&#32;symbol
const PdOOM_ActivitySymbol                          = 1683124784     ' Activity&#32;symbol
const PdOOM_Actor                                   = 403775745      ' Actor
const PdOOM_ActorSequenceSymbol                     = 432142931      ' Actor&#32;Symbol
const PdOOM_ActorSymbol                             = 432142912      ' Actor&#32;Symbol
const PdOOM_Annotation                              = 403775633      ' Annotation
const PdOOM_AssemblyConnector                       = 403775611      ' Assembly&#32;Connector
const PdOOM_Association                             = 403775594      ' Association
const PdOOM_AssociationClassLink                    = 403775605      ' Association-Class&#32;link
const PdOOM_AssociationClassLinkSymbol              = 403775606      ' Association-Class&#32;link&#32;Symbol
const PdOOM_AssociationMapping                      = 403777541      ' Association&#32;Mapping
const PdOOM_AssociationSymbol                       = 432142886      ' Association&#32;symbol
const PdOOM_Attribute                               = 403775589      ' Attribute
const PdOOM_AttributeMapping                        = 403777538      ' Attribute&#32;Mapping
const PdOOM_AttributeValue                          = 403777809      ' Attribute&#32;Value
const PdOOM_BaseAssociation                         = 403775602      ' Base&#32;association
const PdOOM_BaseInteractionFragment                 = 1026430518     ' Base&#32;Interaction&#32;Fragment
const PdOOM_BaseInteractionFragmentSymbol           = 1782319564     ' Base&#32;Interaction&#32;Fragment&#32;Symbol
const PdOOM_BaseNode                                = -837026046     ' Base&#32;Node
const PdOOM_BaseUMLDiagram                          = 403775604      ' Object&#32;Diagram
const PdOOM_CheckController                         = 1629059761     ' Check&#32;Model&#32;Controller
const PdOOM_Class                                   = 403775587      ' Class
const PdOOM_ClassDiagram                            = 403775586      ' Class&#32;Diagram
const PdOOM_Classifier                              = 403775595      ' Class&#47;Interface
const PdOOM_ClassifierSymbol                        = 432142880      ' Classifier&#32;Symbol
const PdOOM_ClassMapping                            = 403777537      ' Class&#32;Mapping
const PdOOM_ClassSymbol                             = 432142881      ' Class&#32;symbol
const PdOOM_CmpiSymbol                              = 1034279642     ' Component&#32;Instance&#32;Symbol
const PdOOM_CollaborationInstanceLinkSymbol         = 403776770      ' Instance&#32;Link&#32;symbol
const PdOOM_CollaborationMessageSymbol              = 403776771      ' Communication&#32;Message&#32;Symbol
const PdOOM_ColumnMapping                           = 795163082      ' Column&#32;Mapping
const PdOOM_CommunicationDiagram                    = 403776768      ' Communication&#32;Diagram
const PdOOM_Component                               = 403776257      ' Component
const PdOOM_ComponentDiagram                        = 403776256      ' Component&#32;Diagram
const PdOOM_ComponentInstance                       = 403777026      ' Component&#32;Instance
const PdOOM_ComponentInterfaceSymbol                = 432142945      ' Component&#32;Interface&#32;Symbol
const PdOOM_ComponentSymbol                         = 432142944      ' Component&#32;Symbol
const PdOOM_CompositeDiagram                        = 403777818      ' Composite&#32;Structure&#32;Diagram
const PdOOM_ConnectorSymbol                         = 432142899      ' Connector&#32;symbol
const PdOOM_DataSource                              = 403777536      ' Data&#32;Source
const PdOOM_Decision                                = -837026070     ' Decision
const PdOOM_DelegationConnector                     = 403775612      ' Delegation&#32;Connector
const PdOOM_Dependency                              = 403775593      ' Dependency
const PdOOM_DependencySymbol                        = 432142884      ' Dependency&#32;symbol
const PdOOM_DeploymentDiagram                       = 403777024      ' Deployment&#32;Diagram
const PdOOM_Domain                                  = 403775599      ' Domain
const PdOOM_End                                     = -837026071     ' End
const PdOOM_Event                                   = 403777283      ' Event
const PdOOM_FlowLink                                = -837026048     ' FlowLink
const PdOOM_FlowMappingParameter                    = -837026045     ' Flow&#32;Mapping
const PdOOM_FlowSymbol                              = -837026041     ' Flow&#32;symbol
const PdOOM_Generalization                          = 403775591      ' Generalization
const PdOOM_GeneralizationSymbol                    = 432142883      ' Generalization&#32;symbol
const PdOOM_Identifier                              = 403775600      ' Identifier
const PdOOM_InnerCollectionSymbol                   = 403775609      ' Inner&#32;Link&#32;Symbol
const PdOOM_InnerLink                               = 403775607      ' Inner&#32;Link
const PdOOM_InnerLinkSymbol                         = 403775608      ' Inner&#32;Link&#32;Symbol
const PdOOM_InputActivityParameter                  = -837026043     ' Input&#32;Parameter
const PdOOM_InstanceLink                            = 403777808      ' Instance&#32;Link
const PdOOM_InstanceLinkSymbol                      = 403777794      ' Instance&#32;Link&#32;Symbol
const PdOOM_InteractionActivity                     = -168517888     ' Interaction&#32;Activity
const PdOOM_InteractionActivitySymbol               = -168517887     ' Interaction&#32;Activity&#32;Symbol
const PdOOM_InteractionFragment                     = -168517650     ' Interaction&#32;Fragment
const PdOOM_InteractionFragmentSymbol               = -1656172164    ' Interaction&#32;Fragment&#32;Symbol
const PdOOM_InteractionOverviewDiagram              = 403777840      ' Interaction&#32;Overview&#32;Diagram
const PdOOM_InteractionReference                    = -641212436     ' Interaction&#32;Reference
const PdOOM_InteractionReferenceSymbol              = -587458952     ' Interaction&#32;Reference&#32;Symbol
const PdOOM_InteractionSymbol                       = 1782319566     ' Interaction&#32;Symbol
const PdOOM_Interface                               = 403775588      ' Interface
const PdOOM_InterfaceSymbol                         = 432142882      ' Interface&#32;Symbol
const PdOOM_JunctionPoint                           = 403777282      ' Junction&#32;Point
const PdOOM_JunctionPointSymbol                     = -1538569448    ' Junction&#32;Point&#32;Symbol
const PdOOM_LifelineSymbol                          = 432142932      ' Lifeline&#32;Symbol
const PdOOM_Message                                 = 403776002      ' Message
const PdOOM_MessageSymbol                           = 432142929      ' Message&#32;Symbol
const PdOOM_Model                                   = 403775584      ' Object-Oriented&#32;Model
const PdOOM_ModelOptions                            = 432142896      ' Model&#32;Options
const PdOOM_Node                                    = 403777025      ' Node
const PdOOM_NodeAssociation                         = 403777027      ' Node&#32;Association
const PdOOM_NodeAssociationSymbol                   = 1034279643     ' Node&#32;Association&#32;Symbol
const PdOOM_NodeSymbol                              = 1034279641     ' Node&#32;Symbol
const PdOOM_ObjectDiagram                           = 403777792      ' Object&#32;Diagram
const PdOOM_ObjectLanguage                          = 403775596      ' Object&#32;Language
const PdOOM_ObjectNode                              = -837026075     ' Object&#32;Node
const PdOOM_ObjectNodeSymbol                        = 432142938      ' Object&#32;Node&#32;symbol
const PdOOM_Operation                               = 403775590      ' Operation
const PdOOM_OperationMapping                        = 403777540      ' Operation&#32;Mapping
const PdOOM_OrganizationUnit                        = -837026067     ' Organization&#32;Unit
const PdOOM_OutputActivityParameter                 = -837026042     ' Output&#32;Parameter
const PdOOM_Package                                 = 403775585      ' Package
const PdOOM_PackageOptions                          = 432142897      ' Package&#32;Options
const PdOOM_PackageSymbol                           = 432142887      ' Package&#32;Symbol
const PdOOM_Parameter                               = 403775597      ' Parameter
const PdOOM_Part                                    = 403775616      ' Part
const PdOOM_PartSymbol                              = 432142900      ' Part&#32;Symbol
const PdOOM_Port                                    = 403775615      ' Port
const PdOOM_PortSymbol                              = 432142889      ' Port&#32;Symbol
const PdOOM_Realization                             = 403775592      ' Realization
const PdOOM_RequireLink                             = 403775610      ' Require&#32;Link
const PdOOM_RequireLinkSymbol                       = 432142898      ' Require&#32;link&#32;symbol
const PdOOM_SequenceDiagram                         = 403776000      ' Sequence&#32;Diagram
const PdOOM_Start                                   = -837026072     ' Start
const PdOOM_State                                   = 403777281      ' State
const PdOOM_StatechartDiagram                       = 403777280      ' Statechart&#32;Diagram
const PdOOM_StateSymbol                             = -1875572238    ' State&#32;Symbol
const PdOOM_SubRegionLineSymbol                     = 1782319565     ' Fragment&#32;Region&#32;Line&#32;Symbol
const PdOOM_SwimlaneSymbol                          = -409387329     ' Organization&#32;Unit&#32;Swimlane&#32;symbol
const PdOOM_Synchronization                         = -837026069     ' Synchronization
const PdOOM_TableMapping                            = 361464264      ' Table&#32;Mapping
const PdOOM_Transition                              = -837026068     ' Transition
const PdOOM_TypeParameter                           = 403775613      ' Type&#32;Parameter
const PdOOM_TypeParameterValue                      = 403775614      ' Type&#32;Parameter&#32;Value
const PdOOM_UMLLinkBase                             = 403775601      ' Link
const PdOOM_UMLObject                               = 403776001      ' Object
const PdOOM_UMLObjectSequenceSymbol                 = 432142928      ' Object&#32;Symbol
const PdOOM_UMLObjectStandardSymbol                 = 403777793      ' Object&#32;Symbol
const PdOOM_UMLPackageDiagram                       = 403777824      ' Package&#32;Diagram
const PdOOM_UseCase                                 = 403775746      ' Use&#32;Case
const PdOOM_UseCaseAssociation                      = 403775603      ' Use&#32;Case&#32;Association
const PdOOM_UseCaseAssociationSymbol                = 432142914      ' Association&#32;symbol
const PdOOM_UseCaseDiagram                          = 403775744      ' Use&#32;Case&#32;Diagram
const PdOOM_UseCaseSymbol                           = 432142913      ' Use&#32;Case&#32;Symbol
const PdOOM_Variable                                = -837026039     ' Variable
const PdOOM_VariableSymbol                          = -837026038     ' Variable&#32;symbol

' *** PdRQM constants
' ==============================================

' - PdRQM classes identifiers
const PdRQM_BaseUser                                = 1381085757     ' Group&#32;or&#32;User
const PdRQM_CheckController                         = 1785042945     ' Check&#32;Model&#32;Controller
const PdRQM_GlossaryTerm                            = -1467628579    ' Glossary&#32;Term
const PdRQM_Model                                   = -625336822     ' Requirements&#32;Model
const PdRQM_Package                                 = -1343370458    ' Package
const PdRQM_PackageOptions                          = -1396707864    ' Package&#32;Options
const PdRQM_Requirement                             = 369643992      ' Requirement
const PdRQM_RequirementGroup                        = -276755616     ' Group
const PdRQM_RequirementsDocumentView                = -1806455055    ' Requirements&#32;Document&#32;View
const PdRQM_RequirementsModelOptions                = 836612073      ' Model&#32;Options
const PdRQM_RequirementUser                         = -910844761     ' User
const PdRQM_TraceabilityLink                        = -1360306385    ' Traceability&#32;Link
const PdRQM_TraceabilityMatrixView                  = 2005010396     ' Traceability&#32;Matrix&#32;View
const PdRQM_UserAllocation                          = 2068051792     ' User&#32;Allocation
const PdRQM_UserAllocationMatrixView                = 1639627673     ' User&#32;Allocation&#32;Matrix&#32;View

' *** PdXSM constants
' ==============================================

' - PdXSM classes identifiers
const PdXSM_AnnotatedComponent                      = -221771106     ' Annotated&#32;Component
const PdXSM_Annotation                              = 1817312038     ' Annotation
const PdXSM_AnnotationItem                          = -385461681     ' Annotation&#32;Item
const PdXSM_Any                                     = -1321848219    ' Any
const PdXSM_AnyAttribute                            = 1503559158     ' Any&#32;Attribute
const PdXSM_AnySymbol                               = 1076121602     ' Any&#32;Symbol
const PdXSM_AppInfo                                 = -595293267     ' AppInfo
const PdXSM_Attribute                               = 892726792      ' Attribute
const PdXSM_AttributeBase                           = -1455312004    ' Attribute
const PdXSM_AttributeGroup                          = -2001218417    ' Attribute&#32;Group
const PdXSM_AttributeMapping                        = -1764773882    ' Attribute&#32;Mapping
const PdXSM_CheckController                         = 1076141584     ' Check&#32;Model&#32;Controller
const PdXSM_CheckModelComponentCategory             = 1799711028     ' Object&#32;Check&#32;Category
const PdXSM_ClassAttributeMapping                   = -1288045126    ' Class&#32;Attribute&#32;Mapping
const PdXSM_ClassifierMapping                       = -1778548793    ' Mapping
const PdXSM_ClassMapping                            = 1547363386     ' Class&#32;Mapping
const PdXSM_ComplexContent                          = -1395632010    ' Complex&#32;Content
const PdXSM_ComplexType                             = 10560975       ' Complex&#32;Type
const PdXSM_ComplexTypeMapping                      = 218249007      ' Complex&#32;Type&#32;Mapping
const PdXSM_ComplexTypeSymbol                       = 1076121601     ' Complex&#32;Type&#32;Symbol
const PdXSM_Component                               = -153920592     ' Component
const PdXSM_Content                                 = -1820208138    ' Content
const PdXSM_DataSource                              = -554403524     ' Data&#32;Source
const PdXSM_Derivation                              = -163279830     ' Derivation
const PdXSM_Documentation                           = -298958725     ' Documentation
const PdXSM_Element                                 = 785050749      ' Element
const PdXSM_ElementMapping                          = 944997997      ' Element&#32;Mapping
const PdXSM_ElementSymbol                           = 1076121600     ' Element&#32;Symbol
const PdXSM_Entity                                  = -327522189     ' Entity
const PdXSM_EnumerationFacet                        = 749697229      ' Enumeration&#32;Facet
const PdXSM_Extension                               = 938842786      ' Extension
const PdXSM_External                                = 505019194      ' External
const PdXSM_ExternalAttributeMapping                = 1288451580     ' External&#32;Attribute&#32;Mapping
const PdXSM_ExternalComplexTypeMapping              = -1337651449    ' External&#32;Complex&#32;Type&#32;Mapping
const PdXSM_ExternalElementMapping                  = 1562596349     ' External&#32;Element&#32;Mapping
const PdXSM_Facet                                   = -1729783271    ' Facet
const PdXSM_Field                                   = -1895930966    ' Field
const PdXSM_FolderOptions                           = 1076141582     ' Package&#32;Options
const PdXSM_FractionDigitsFacet                     = -581762444     ' Fraction&#32;Digits&#32;Facet
const PdXSM_Group                                   = 1399871302     ' Group
const PdXSM_GroupParticle                           = -2116443308    ' Group&#32;Particle
const PdXSM_GroupParticleSymbol                     = 1076121604     ' Group&#32;Particle&#32;Symbol
const PdXSM_IdentityConstraint                      = 1814413810     ' Identity&#32;Constraint
const PdXSM_Import                                  = -497783667     ' Import
const PdXSM_Include                                 = -1968789711    ' Include
const PdXSM_ItemGroupSymbol                         = 1076121603     ' Group&#32;Symbol
const PdXSM_Key                                     = 1519882861     ' Key
const PdXSM_KeyRef                                  = 1348751289     ' Keyref
const PdXSM_LengthFacet                             = -180573133     ' Length&#32;Facet
const PdXSM_MaxExclusiveFacet                       = 1765657858     ' Maximum&#32;Exclusive&#32;Facet
const PdXSM_MaxInclusiveFacet                       = 1655485961     ' Maximum&#32;Inclusive&#32;Facet
const PdXSM_MaxLengthFacet                          = -1620030626    ' Maximum&#32;Length&#32;Facet
const PdXSM_MinExclusiveFacet                       = -2132689310    ' Minimum&#32;Exclusive&#32;Facet
const PdXSM_MinInclusiveFacet                       = -1566735878    ' Minimum&#32;Inclusive&#32;Facet
const PdXSM_MinLengthFacet                          = 297680932      ' Minimum&#32;Length&#32;Facet
const PdXSM_Model                                   = 43953932       ' XML&#32;Model
const PdXSM_ModelOptions                            = 1076141581     ' Model&#32;Options
const PdXSM_Notation                                = -2002425948    ' Notation
const PdXSM_NumericFacet                            = 1122985732     ' Numeric&#32;Facet
const PdXSM_Particle                                = 923967085      ' Particle
const PdXSM_PatternFacet                            = -897133336     ' Pattern&#32;Facet
const PdXSM_Redefine                                = 1739994411     ' Redefine
const PdXSM_Restriction                             = 1657518990     ' Restriction
const PdXSM_SchemaLanguage                          = 1076141583     ' XML&#32;Language
const PdXSM_Selector                                = -2111597264    ' Selector
const PdXSM_SimpleContent                           = -1197151245    ' Simple&#32;Content
const PdXSM_SimpleType                              = -1551176593    ' Simple&#32;Type
const PdXSM_SimpleTypeList                          = 2036502012     ' Simple&#32;Type&#32;List
const PdXSM_SimpleTypeSymbol                        = 1076121605     ' Simple&#32;Type&#32;Symbol
const PdXSM_SimpleTypeUnion                         = -210305271     ' Simple&#32;Type&#32;Union
const PdXSM_TableColumnMapping                      = -1727910078    ' Table&#32;Column&#32;Mapping
const PdXSM_TableMapping                            = 564147537      ' Table&#32;Mapping
const PdXSM_TotalDigitFacet                         = -647944425     ' Total&#32;Digit&#32;Facet
const PdXSM_Type                                    = 724312178      ' Type
const PdXSM_Unique                                  = -1151089516    ' Unique
const PdXSM_WhitespaceFacet                         = 1254648357     ' Whitespace&#32;Facet
const PdXSM_XMLDiagram                              = 1076141580     ' XML&#32;Model&#32;Diagram
const PdXSM_XmlNamespace                            = -1203112182    ' Namespace

