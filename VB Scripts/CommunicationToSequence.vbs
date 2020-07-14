' From communication to Sequence is a script that transform a communication siagram in
' sequence diagram

option Explicit

Dim CurrentDiag, dn
set CurrentDiag = activediagram


If (ActiveModel Is Nothing) Then
   MsgBox "There is no current model"
ElseIf Not ActiveModel.IsKindOf(PdOOM.cls_Model) Then
   MsgBox "The current model is not an Object Oriented model."
ElseIf not CurrentDiag.iskindof(cls_CommunicationDiagram) then
   MsgBox "The current diagram is not a Communication Diagram."
Else
  set dn = CurrentDiag.parent.SequenceDiagrams.createnew
  dn.openview
  'dn.name = CurrentDiag.name
  'dn.code = CurrentDiag.code

  transform CurrentDiag, dn
End if

' Transform fo all the necessary transformation from the communication diagram D
' to the Sequence diagram DN

Sub Transform (D, DN)
Dim s

' create a symbol in the Sequence diagram for each actor and 
' Object symbol in communication diagram
for each s in d.symbols
   if s.iskindof (cls_UMLObjectStandardsymbol) then
      dn.attachobject(s.object)
   elseif s.iskindof(cls_Actorsymbol) then
      dn.attachobject(s.object)
   end if
next

' For each instance link symbol in communication diagram, look at their message 
' and attach them to Sequence
Dim m 

' Create map object
' Each message will be store in the map
' the key will be the message number
' Once the message number will be sorted, the map will be used to get back the message.
' This is not working if several message have the same number
' Shortcut of Instance link are not taken care of during transformation

Dim Map 'Object map
Set Map = CreateObject("Scripting.Dictionary")

for each s in d.symbols
   if s.iskindof(cls_InstanceLinkSymbol) then
      if not s.object.isShortcut then
         for each m in s.object.messages
'             output "add in map: Link " & s.object.name & " Message " & m.name & " Number " & m.SequenceNumber
             Map.add m.SequenceNumber, m 
         next
      end if
   end if
next

' Get all the keys from the Map
Dim Key
key = Map.keys

' Create an array that will be sorted later
' transfer the key into the array
dim a()
dim o, i
i = 0
redim a(Map.Count-1)
For i = 0 To Map.Count -1 
      a(i) = Key(i)
Next

' Sort the array
SortArray a 

' Read the sorted array , for each value get back the message and attach it to the diagram
For each o in a
      dn.attachLinkObject(Map.item(o))
Next
   
end sub

' bubble sort
sub SortArray(a)
   dim i,j,t,k
   for i=0 to ubound(a)-1
      for j=i+1 to ubound(a)
         if CompareDotNumber(a(i), a(j)) > 0 then
            t = a(i)
            a(i) = a(j)
            a(j) = t
         end if
      next
   next
end sub


' Compared two strings containing "." 
' return -1 if a < b
function CompareDotNumber(byval a, byval b)
   dim p,q,e,f
   while true
      if a = "" then
         if b = "" then
            CompareDotNumber = 0
         else
            CompareDotNumber = -1
         end if
         exit function
      else
         if b = "" then
            CompareDotNumber = 1
            exit function
         end if
      end if
      p = instr(a, ".")
      q = instr(b, ".")
      if p = 0 then
         e = a
         a = ""
      else
         e = mid(a, 1, p)
         a = mid(a, p+1)
      end if
      if q = 0 then
         f = b
         b = ""
      else
         f = mid(b, 1, q)
         b = mid(b, q+1)
      end if
      if isnumeric(e) and isnumeric(f) then
         e = int(e)
         f = int(f)
      end if
      if e < f then
         CompareDotNumber = -1
         exit function
      else
         if e > f then
            CompareDotNumber = 1
            exit function
         end if
      end if
   wend
end function