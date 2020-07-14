' From Sequence to Collaboration is a script that transform sequence diagram in
' Collaboration diagram
' Shortcut of message are not taken care of during transformation

option Explicit

Dim CurrentDiag, CD
set CurrentDiag = activediagram

If (ActiveModel Is Nothing) Then
   MsgBox "There is no current model"
ElseIf Not ActiveModel.IsKindOf(PdOOM.cls_Model) Then
   MsgBox "The current model is not an Object Oriented model."
ElseIf not CurrentDiag.iskindof(cls_Sequencediagram) then
   MsgBox "The current diagram is not a Sequence Diagram."
Else
  set CD = CurrentDiag.parent.collaborationdiagrams.createnew
  CD.openview
'  CD.name = CurrentDiag.name
'  CD.code = CurrentDiag.code
   output "Transforming " & CurrentDiag.name & " into " & CD.name
  transform CurrentDiag, CD
End if

' Transform of all the necessary transformation from the Sequence diagram SD
' to the Collaboration diagram CD

Sub Transform (SD, CD)
Dim s, i

' create a symbol in the collaboration diagram for each actor and 
' Object symbol in sequence diagram
for each s in SD.symbols
   if s.iskindof (cls_UMLObjectSequencesymbol) then
      CD.attachobject(s.object)
   elseif s.iskindof(cls_Actorsymbol) then
      CD.attachobject(s.object)
   end if
next

' For each message symbol in sequence diagram, search for a corresponding instancelink 
' in Collaboration diagram. If non is found create one, display it in diagram and add message
' to this instance link
Dim il 'Instance link
for each s in SD.symbols
   if s.iskindof(cls_MessageSymbol) then
      if not s.object.isshortcut then
         if Not BetweenActor (s) then
            if Find(s.object, CD) is nothing then
               set il = CD.parent.instanceLinks.createnew
               il.Object1 = s.object.sender
               il.Object2 = s.object.receiver
               il.messages.insert -1, s.object
               CD.attachLinkobject(il)
            else
               set il = Find(S.object, CD)
               il.messages.insert -1, s.object
           end if   
         end if
      end if
   end if
next

CD.autolayout
   
end sub

' The Find function search for an instance link in diagram DN that correspond
' to the messages 'mess'. The message and the instance link must have the same extremities

Function Find (mess, DN)
   Dim Link 'Instance link
   Dim s 'symbol from Collaboration diagram
   Set Find = nothing
   For each s in DN.symbols
      if s.iskindof(cls_InstanceLinkSymbol) then
         ' For each instance link symbol check if it matches the message extremities
         if s.sourceSymbol.object is mess.receiver then
            if s.destinationSymbol.object is mess.sender then
               Set Find = s.object
'               output "Instance link found for " & mess.name
               exit function
            else 
               Set Find = nothing
'               output "Instance link not found for " & mess.name
            end if
         elseif s.sourceSymbol.object is mess.sender then
            if s.destinationSymbol.object is mess.receiver then
               Set Find = s.object
'               output "Instance link found for " & mess.name
               exit function
            else 
               Set Find = nothing
'               output "Instance link not found for " & mess.name
            end if
         else
            Set Find = nothing
'             output "Instance link not found for " & mess.name
         end if
      end if
   next

'   output "Instance link non trouvé pour " & mess.name
           
End Function

' the function return True if the message is between two actors or one actor and one shortcut of actor

Function BetWeenActor (MessageSymb)

   Dim a,b

   a = false
   b = false
   if MessageSymb.object.receiver.isShortcut then
      if MessageSymb.object.receiver.TargetObject.isKindOf(cls_Actor)  then
         a = true
      end if
   elseif MessageSymb.object.receiver.isKindOf(cls_Actor)  then
      a = true
   end if
   if MessageSymb.object.sender.isShortcut then 
      if MessageSymb.object.sender.TargetObject.isKindOf(cls_Actor)  then
         b = true
      end if 
   elseif MessageSymb.object.sender.isKindOf(cls_Actor)  then
      b = true
   end if


   BetweenActor = a and b

End Function