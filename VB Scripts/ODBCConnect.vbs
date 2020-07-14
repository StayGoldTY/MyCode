'******************************************************************************
'* File:     ODBCConnect.vbs
'* Purpose:  Show how to use an ODBC connection
'             list the non-empty tables
'* Title:    
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit
 
Const CONNECTION = "Data Source=asa7_current;User Id=dba;Password=SQL;"

Dim cnx ' connection object
set cnx = CreateObject("ADODB.Connection")
cnx.Open CONNECTION

Dim rs ' recordset
set rs = cnx.Execute("select table_name,count from systable where creator=user_id() and table_type='BASE' order by table_name")

Output "List of non-empty tables:"
Dim n ' row count
Do Until rs.EOF
   n = rs("count")
   If n <> "0" Then
      Output rs("table_name") & ": " & n
   End If
   rs.MoveNext
Loop

rs.Close
set rs = Nothing
cnx.Close
set cnx = Nothing