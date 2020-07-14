'******************************************************************************
'* File:     BPM-Activity.vbs
'* Purpose:  Convert a BPM into an OOM model containing activity diagram
'            This script will first tranforms all global objects
'            Then, it will transform objects that can be created under a package.
'            A map of matching BPM/OOM objects is created.
'            Diagram and symbols are then transformed.
'            We use the map to connect the symbols to the correct matching object.
'            A loop on each process and then package will do the same transformation.
'            Internal Shortcuts and links connected to shortcuts are added in the end.
'            External shortcuts are lost.
'* Category:
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************
         

Option Explicit
ValidationMode = false
InteractiveMode = im_Batch

Const Debugging = false 'constant to display debug string

' get the current active model
Dim mdl ' the current model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
   MsgBox "There is no current model"
ElseIf Not mdl.IsKindOf(PdBPM.cls_Model) Then
   MsgBox "The current model is not an Business Process model."
Else
   dim Actmdl 'OOM containg the activity diagram
   Set actmdl = createmodel(pdoom.cls_model, "|Language=Analysis|Diagram=ActivityDiagram")

   ' Create map object
   ' This map will keep correspondence between object
   ' from source (BPM) and target (OOM) model
   '
   Dim Map 'Object map
   Set Map = CreateObject("Scripting.Dictionary")


   ' Handle Global objects first (no symbol)
   '
   ' Business rules
   '
   Dim br 'Business rules
   for each br in mdl.Businessrules
      if not br.isshortcut then
         if Debugging then output "Transform BR " & br.name end if 
         Dim br2
         set br2=actmdl.Businessrules.createnew
         CopyObjectProperties br, br2 '
      
         'specific attribute copy
         br2.type = br.type
         br2.serverexpression = br.serverexpression
         br2.clientexpression = br.clientexpression

         Map.add br, br2 'Fill map with BR
      end if 

   next

   '
   ' Organisation Unit
   '
   Dim ou 'Organization Unit
   for each ou in mdl.OrganizationUnits
      if not ou.isshortcut then 
         if Debugging then output "Transform OU " & ou.name end if 
         Dim ou2
         set ou2=actmdl.OrganizationUnits.createnew
         Map.add ou, ou2 'Fill map with Organization Unit
         CopyObjectProperties ou, ou2
      
         'specific attribute copy
         ou2.stereotype = ou.stereotype

         AttachBR ou, ou2
      end if 
   
   next
   'attach parent once you are sur all OU are created
   for each ou in mdl.OrganizationUnits
         if not ou.parentorganization is nothing then
            findobject(ou).parentorganization = findobject(ou.parentorganization)
         end if
   next
   
   '
   ' Resources
   '
   ' Resources are transformed into Object and Object State
   ' Resources as global object will be transformed and mapped to Object
   ' Resources symbol will then created ObjectState and Objectstate symbol
   ' 
   ' Resources flow will not create any matching object during the global object loop
   ' because we don't know yet at that stage which Objectstate will be used 
   ' as a correspondant for this particular Resource symbol
   ' as Object state is created by Resource symbol (symbol are taken care of after object).
   ' Resource flow symbol will create both the flow object and the flow symbol
   
   Dim r 'Resources
   for each r in mdl.Resources
      if not r.isshortcut then
         if Debugging then output "Transform resource " & r.name end if 
         Dim rr
         set rr=actmdl.Objects.createnew
         Map.add r, rr 'Fill Map with Resources 

         CopyObjectProperties r, rr
         AttachBR r, rr

         'specific attribute copy
         rr.stereotype = "Resource"
         rr.Comment = rtf2ascii(rr.Comment) 
         if not r.stereotype = "" then rr.comment = rr.comment & vbcrlf & "Stereotype " & r.stereotype end if
      end if
   next

   transform mdl, actmdl

   AddShortcut mdl, actmdl

   actmdl.defaultdiagram.openview   
   
End If

'-----------------------------------------------------------------------------
' Transform a source Package (BPM) into a target package (OOM)
' Take care of all objects belonging to the package
'-----------------------------------------------------------------------------
Private Sub Transform (srcePack, trgtPack)
   if Debugging then output "=======>" & srcepack.name end if
   CopyObjectProperties srcePack, trgtPack
   
   AttachBR srcePack, trgtPack

   '
   ' Process
   '
   Dim p 'Process
   for each p in srcePack.processes
     if not p.IsShortcut then
         if Debugging then output "Transform Process " & p.name end if 
         Dim aa
         set aa=trgtPack.activities.createnew
         Map.add p, aa 'Fill map with Process/Activity 
         CopyObjectProperties p ,aa

         'specific attribute copy

         if not p.OrganizationUnit is nothing then
            aa.OrganizationUnit = findobject(p.OrganizationUnit)
         end if
         aa.Composite = p.Composite 
         aa.Stereotype = p.Stereotype 
         aa.Duration = p.Duration 
         aa.Timeout = p.Timeout 
         aa.Action = p.Action 
         aa.ActionType = p.ActionType 

         AttachBR p, aa

         'if Process is composite then call transform function on it.
         if p.composite then
            aa.composite = true
            transform p, aa
         end if
     end if
   next

   '
   ' End
   '

   Dim e 'Ends
   for each e in srcePack.processends
      if Debugging then output "Transform End " & e.name end if       
      Dim ee
      set ee=trgtPack.Ends.createnew
      Map.add e, ee 'Fill Map with End 
      CopyObjectProperties e ,ee

      'specific attribute copy
      ee.stereotype = e.stereotype

      AttachBR e, ee
   next

   '
   ' Start
   '
   ' BPM can have several start but OOM Activity can only have one.
   ' One start is randomly selected to stay in OOM
   ' The name of the selected start appears in output window
   ' The name of the lost starts appear in output window
   ' Some links may be lost during this tranformation
   
   Dim s 'Start source
   Dim Pos 'position in loop
   Dim theStart 'Start unique du folder courant
   pos= 0
   for each s in srcePack.processStarts
         Dim ss 'Start target

         if Debugging then output "Transform start " & s.name end if 
         if trgtPack.cancreateobject(cls_start,msg,"Starts") then 
         if pos = 0 then 
            Set theStart = s 
            output "The start info : "& thestart.name & " from " & srcepack.name 
         end if
         set ss=trgtPack.Starts.createnew
         Map.add s, ss 'Fill Map with Start   
         CopyObjectProperties s ,ss

         'specifc attribute copy
         ss.stereotype = s.stereotype

         AttachBR s, ss
      else
         output "Start lost " & s.name 
      end if
      pos = pos + 1
   next

       
   '
   ' decision
   '


   Dim d 'Decision
   for each d in srcePack.processDecisions
      if Debugging then output "Transform decision " & d.name end if       
      Dim dd
      set dd=trgtPack.Decisions.createnew
      Map.add d, dd 'Fill decision Map
      CopyObjectProperties d ,dd

      'specific attribute copy
      dd.Stereotype = d.Stereotype 
      dd.ExpressionAlias = d.ExpressionAlias 
      dd.Expression = d.Expression 

      AttachBR d, dd
   next

   '
   ' Synchronization
   '
   Dim sy 'Synchronization
   for each sy in srcePack.bpmSynchronizations
      if Debugging then output "Transform Synchro " & sy.name end if       
      Dim sy2
      set sy2=trgtPack.Synchronizations.createnew
      Map.add sy, sy2 'Fill Map with Synchronization 
      CopyObjectProperties sy , sy2

      'specific attribute copy
      sy2.Stereotype = sy.Stereotype 
      sy2.Timeout = sy.Timeout 
      
      AttachBR sy, sy2
   next


   '
   ' Flows
   '
   dim msg 'string for error message
   Dim f 'Flows
   for each f in srcePack.Flows
      Dim ff
         if Debugging then output "Transform Flow " & f.name end if       
         set ff = trgtPack.Flows.createnew

         ' when f if a link between a start and another object, 
         ' we replace the start by the selected start that is really displayed 
         ' in the Activity diagram
         
         dim withstart
         withstart = 0
         if f.object1.iskindof(cls_ProcessStart) then 
            withstart = 1
         elseif f.object2.iskindof(cls_ProcessStart) then 
            withstart = 2
         end if

         if withstart = 0 then         
            createflow f, ff, f.object1 ,f.object2
         elseif withstart = 1 then
            createflow f, ff, thestart ,f.object2
         elseif withstart = 2 then
            createflow f, ff, f.object1 ,thestart
         end if
         
        
   next

   '
   ' Flows
   ' Don't create any object for resource flow at that stage
   ' Flow will be created when symbols will be taken care of
   '

   '
   ' Files
   '

   Dim fi 'files
   for each fi in srcePack.Files
      if Debugging then output "Transform Files " & fi.name end if 
      Dim fi2
      set fi2=trgtPack.Files.createnew
      Map.add fi, fi2 'Fill map with Organization Unit
      CopyObjectProperties fi, fi2

      'specific attributes copy
      fi2.Generated = fi.Generated 
      fi2.Location = fi.Location 
      fi2.Content = fi.Content 
      fi2.History = fi.History 
      fi2.LocationType = fi.LocationType 

   next
   
   ' for each package in the current package call the Transform function again.
   
   Dim folder ' running folder
   For Each folder In srcePack.Packages
      if Debugging then output "========> Package " & folder.name
      Dim pp
      set pp = trgtPack.Packages.createnew
      Map.add folder, pp 'Fill Package Map
      transform folder ,pp
   Next

   'Call the symbol transformation function for the current package
   TransformDiag srcePack, TrgtPack

end sub

'-----------------------------------------------------------------------------
' Create a flow ff as a copy of f except for object 1 and object 2
' when f if a link between a start and another object, 
' we replace the start by the selected start that is really displayed in the Activity diagram
'     o1 is object 1
'     o2 is object 2
'-----------------------------------------------------------------------------

Private Sub createflow (f, ff, o1, o2)
            dim msg
            if ff.cansetattribute("Object1",FindObject(o1),msg) then
               ff.object1 = FindObject(o1) 
               if ff.cansetattribute("Object2",FindObject(o2),msg) then 
                  ff.object2 = FindObject(o2) 
                  Map.add f, ff 'Fill Map with Flow 
                  
                  CopyObjectProperties f , ff
                 
                  'Specific attributes
                  ff.Stereotype = f.Stereotype 
                  ff.ConditionAlias =f.ConditionAlias 
                  ff.ConditionExpression = f.ConditionExpression 
                  ff.ExtendedAttributesText = f.ExtendedAttributesText 
                  ff.FlowType = f.FlowType 

                  AttachBR f, ff
                  Addformat  f, ff
               else
                  output f.name & " error : " & msg
                  ff.delete
               end if
            else 
               output f.name & " error : " & msg
               ff.delete 
            end if
end sub

'-----------------------------------------------------------------------------
' Transform all diagrams for a package
'-----------------------------------------------------------------------------
Private Sub TransformDiag (SrcePack, TrgtPack)
   dim d 'diagram for source package
   dim ExistDiag 'Did we found at least one source diagram to transform

   if Debugging then output "=======> Diagram for " & trgtPack.name end if

   'transformation of each diagram of current package
   ExistDiag = false
   
   for each D in SrcePack.businessprocessdiagrams
      ExistDiag = true
      if Debugging then output "diagram " & d.name end if
      dim dd 'diagram for target package
      set dd = TrgtPack.activitydiagrams.createnew
      CopyObjectProperties D, dd
      Map.add D, dd 'Fill map with diagrams
      dim s ' source symbol
      dim ss 'target symbol
      dim k 'kind of source symbol
      dim temp 'temporary object for parent object for ss

      dim num 'Order state numbering
      num = 0
         
      ' loop to treat object symbol first
      for each s in D.symbols
         ' if symbol is an object symbol find the matching object and create a symbol for it.
         ' For ressource symbol, an object state will be created by attaching the object to the diagram
         
         if s.iskindof(cls_objectsymbol) then 'object symbol
            if ExistObject(s.object) then
                set temp = findobject(s.object)
                if dd.canattachobject(temp) then
                   set ss = dd.attachobject(temp)
                   CopyObjectProperties s.object, ss.object
                   CopySymbolProperties s, ss
                   Map.add s, ss 'Fill map with symbols
                   ' if s is  resource symbol, then change a bit the name of the object state that has been created for it.
                   if s.iskindof(cls_resourcesymbol) then 
                        num = num + 1 
                        ss.object.name = "Object State " & num & " " & ss.object.name
                        ss.object.code = "Object_State_" & num & "_" & ss.object.code
                   end if
                end if
            end if
 
         'swimlane symbols
         elseif s.iskindof(cls_SwimlaneGroupSymbol) then
             if Debugging then output "cas swimalne symbol "  + s.classname + " " + cstr(s.classkind) end if

         ' if s is a rectangle or free text symbol
        elseif s.iskindof(cls_rectanglesymbol) or s.iskindof(cls_TextSymbol) then 'rectangle free symbol or free text
           set ss = dd.Symbols.CreateNew(s.classkind)
           CopySymbolProperties s, ss
           Map.add s, ss 'Fill map with symbols            
         end if 
      next

      ' loop to treat link object symbol and free symbol

      for each s in d.symbols
         'if s is a link object symbol
         if s.iskindof(cls_baselinkobjectsymbol) then ' Link object symbol
            if Debugging then output "Link symbol " & s.objecttype & " " & s.object.name end if 
            
            ' if symbol object already have an equivalent
            if existobject(s.object) then
                ' if both source and destination object have equivalent in new model
                if existobject(s.sourcesymbol) and existobject(s.destinationsymbol) then
                   set temp = findobject(s.object)
                   set ss = dd.attachlinkobject(temp,findobject(s.sourcesymbol),findobject(s.destinationsymbol))
                   CopySymbolProperties s, ss
                   Map.add s, ss 'Fill map with symbols
                end if
            ' if symbol object does not have an equivalent and is a resource flow symbol
            ' then create the flow
            elseif s.iskindof(cls_resourceflowsymbol) then
                if existobject(s.sourcesymbol) and existobject(s.destinationsymbol) then
                    dim ts 'flow object
                    dim sss 'flow symvol
                    dim p 'process equivalent
                    dim ps 'process symbol equivalent
                    dim r 'ressource equivalent
                    dim rs ' ressource symbol equivalent

                    set ts=trgtPack.Flows.createnew
                    
                    'find process and resource back 
                    if s.sourcesymbol.object.iskindof(cls_process) then 
                       set p = findobject(s.sourcesymbol.object)
                       set ps = findobject(s.sourcesymbol)
                       set r = findobject(s.destinationsymbol).object
                       set rs = findobject(s.destinationsymbol)
                    else 
                       set p = findobject(s.destinationsymbol.object)
                       set ps = findobject(s.destinationsymbol)
                       set r = findobject(s.sourcesymbol).object
                       set rs = findobject(s.sourcesymbol)
                    end if
                    
                    
                    'based on CRUD right put resource as destination or not
                    if s.object.updateaccess or s.object.createaccess or s.object.deleteaccess then
                       ' if write access
                       ' arrow toward object state
                       ts.destination = r 
                       ts.source = p
                       set sss = dd.attachlinkobject(ts,ps,rs)
                    else
                       ' else
                       ' arrow toward activity
                       ts.source = r
                       ts.destination = p
                       set sss = dd.attachlinkobject(ts,rs,ps)
                    end if
                    
                    
                    map.add s.object, ts
                    map.add s, sss                   
                    CopySymbolProperties s, sss
                    CopyObjectProperties s.object , ts
                    
 
                    ts.comment = rtf2ascii(ts.comment) & vbcrlf & vbcrlf & "create access : " & s.object.createaccess & vbcrlf & "update access : " & s.object.updateaccess & vbcrlf & "delete access : " & s.object.deleteaccess & vbcrlf & "read access : " & s.object.readaccess  

                    AttachBR s.object, ts


                    AddFormat s.object, ts 

                end if
            end if

         'create other symbols
         elseif not (s.iskindof (cls_SwimlaneGroupSymbol) or s.iskindof(cls_objectsymbol) or s.iskindof(cls_rectanglesymbol) or s.iskindof(cls_textsymbol) )then 'Free symbol
            if Debugging then output "Other symbol " + s.metaclass + " "+s.classname + " " + cstr(s.classkind) end if

            set ss = dd.Symbols.CreateNew(s.classkind)
            CopySymbolProperties s, ss
            Map.add s, ss 'Fill map with symbols
         end if
      next

	  ' put back link behind
   	dd.Completelinks
   next

   if ExistDiag then 
      TrgtPack.defaultDiagram.delete
   end if
end sub


'-----------------------------------------------------------------------------
' Copy the common properties of a source object into a target object
'-----------------------------------------------------------------------------
Private Sub CopyObjectProperties (S, T)
      if not s.iskindof(cls_flow) and not s.iskindof(cls_resourceflow) and not s.iskindof(cls_fileobject) then
         T.Code = S.Code
         T.Name = S.Name
         T.Description = S.Description
         T.Annotation = S.Annotation      
         T.Comment = S.Comment
         if not s.iskindof(cls_businessprocessdiagram) then
            T.ExtendedAttributesText = S.ExtendedAttributesText
         end if
      elseif s.iskindof(cls_fileobject) then
         T.Name = s.Name
         T.Comment = S.Comment
         T.ExtendedAttributesText = S.ExtendedAttributesText 
      else
         T.Description = S.Description
         T.Annotation = S.Annotation      
         T.Comment = S.Comment
         T.ExtendedAttributesText = S.ExtendedAttributesText 
      end if
         
End Sub

'-----------------------------------------------------------------------------
' copy characteristic of source symbol
' ss source symobl
' ts target symbol
'-----------------------------------------------------------------------------
Sub CopySymbolProperties (SS, TS)
               'From BaseSymbol
               if ss.iskindof(cls_basesymbol) then
                  ts.rect.top = ss.rect.top
                  ts.rect.bottom = ss.rect.bottom
                  ts.rect.left = ss.rect.left
                  ts.rect.right = ss.rect.right
   
                  ts.Flags = ss.flags
   
                  ts.position.x = ss.Position.x
                  ts.position.y = ss.Position.y

                  ts.size.x = ss.size.x
                  ts.size.y = ss.size.y

                  'ts.Format = ss.format
                  ts.Hidden  = ss.hidden
                  ts.Protected = ss.protected
               end if
               if ss.iskindof(cls_solidsymbol) then
                  ts.GradientFillMode = ss.GradientFillMode
                  ts.GradientEndColor = ss.GradientEndColor
                  ts.PictureFillMode = ss.PictureFillMode
                 
               end if
         
               'From StandardSymbol
               if ss.iskindof(cls_standardsymbol) then
                  ts.Shadow = ss.shadow
                  ts.ShadowColor =ss.shadowcolor
                  ts.linecolor = ss.LineColor 
                  ts.DashStyle = ss.dashstyle
                  ts.LineWidth = ss.linewidth
               end if

               'From Polyline symbol
               Dim pt 'list of point
               
               if ss.iskindof(cls_polylinesymbol) then
                  if not ss.iskindof(cls_resourceflowsymbol) then
                     ts.arrowstyle = ss.arrowstyle
                     ts.ListOfPoints.AsText = ss.ListOfPoints.AsText
                  else
                     ' if source symbol is an activity or an activity shortcut just copy list of point 
                     ' if not reverse it
                     if ts.sourcesymbol.object.iskindof(cls_activity)  then
                        ts.ListOfPoints.AsText = ss.ListOfPoints.AsText
                     elseif  ts.sourcesymbol.object.iskindof(cls_shortcut) then 
                        if ts.sourcesymbol.object.targetobject.iskindof(cls_activity)  then
                            ts.ListOfPoints.AsText = ss.ListOfPoints.AsText
                        end if
                     else
                        RevertPoints ss.ListOfPoints,ts.ListOfPoints
                     end if
                     
                  end if
                  ts.cornerstyle = ss.cornerstyle
                  'ts.linkposition = ss.linkposition
                  'ts.linksize= ss.linksize
               end if               

            if ss.iskindof(cls_rectanglesymbol) or ss.iskindof(cls_textsymbol) then          
               ts.text = ss.text
               ts.textStyle = ss.TextStyle
               ts.FontColor = ss.FontColor
               ts.fontname = ss.fontname
            end if

            if ss.iskindof(cls_baselinkobjectsymbol) then
                   ts.fontlist = ss.fontlist
                   ts.CenterTextOffset = ss.CenterTextOffset 
                   ts.SourceTextoffset = ss.SourceTextoffset 
                   ts.destinationTextOffset = ss.destinationTextOffset 
            end if

            if ss.iskindof(cls_solidsymbol) then
                ts.fillcolor = ss.fillcolor
            end if

End Sub

'-----------------------------------------------------------------------------
' Attach the BR of the source object to the target object
'-----------------------------------------------------------------------------
Private sub attachBR (objs,objt)
   Dim brs
   Dim brt
   For Each brs in objs.AttachedRules
      set brt = Map.item(brs)
      if not brt is nothing then
          objt.attachedrules.add (brt)
      end if
   next

end sub

'-----------------------------------------------------------------------------
' Find the object in a series of map
'-----------------------------------------------------------------------------
Function FindObject(Object)
   dim search 
   'if Debugging then "Searching " & object.name end if 

   if map.exists(object) then
      set search = Map.item(object)
      Set FindObject = search
   end if

end Function

'-----------------------------------------------------------------------------
' Test if an objects exists in the map
'-----------------------------------------------------------------------------
Function ExistObject(Object)
   if map.exists(object) then
      ExistObject = true
   else
      ExistObject = false
   end if
   if Debugging Then output "exists ? "& object.name & " :" & existobject end if
end Function

'-----------------------------------------------------------------------------
' After all objects have been created create internal shortcuts
'-----------------------------------------------------------------------------
Function AddShortcut(srce, trgt)

Dim p 'object shortcut
Dim f 'packages
Dim d 'diagrams
Dim s 'Symbols
Dim sh 'Shortcut 
Dim ssh ' Symbol shortcut 
Dim s2 ' symbol of flow linked to the process shortcut
DIm ts ' flows
Dim ss2 ' Flow symbol


For each d in srce.businessprocessdiagrams

   ' do a loop on symbols and detect internal shortcut symbols
   ' create shortcut for main object first

   for each s in d.symbols
     if s.iskindof(cls_objectsymbol) then
        if s.object.isShortcut then
           set p = s.object
           if not p.external then
               'if s is a symbol of an internal shortcut 
               if map.exists(p.targetobject) then
                  set sh = Findobject(p.targetobject).createshortcut(trgt)
                  if findobject(d).canattachobject(sh) then
                      set ssh = findobject(d).attachobject(sh)
                      CopySymbolProperties s, ssh
                      map.add s, ssh
                   end if
                end if
           end if 
        end if
     end if
   next 

   ' create shortcut for link object attached to shortcut
   
   for each s2 in d.symbols 
      if (s2.iskindof(cls_resourceflowsymbol) or s2.iskindof(cls_flowsymbol)) then
         if not map.exists(s2) then
            if (s2.destinationsymbol.object.isshortcut) then

                'don't take care of the case of the process shortcut linked with Start
                if ((s2.destinationsymbol.object.targetobject.iskindof(cls_process)) and (not s2.sourcesymbol.object.iskindof(cls_processstart) )) then               
                      set ts = trgt.Flows.createnew
                      set ss2 = findobject(d).attachlinkobject(ts, findobject(s2.sourcesymbol), findobject(s2.destinationsymbol))
                      CopySymbolProperties s2, ss2
                      map.add s2, ss2
                      addformat s2.object, ts
                end if
             elseif (s2.sourcesymbol.object.isshortcut) then
                'don't take care of the case of the process shortcut linked with Start

                if (s2.sourcesymbol.object.targetobject.iskindof(cls_process) and not s2.destinationsymbol.object.iskindof(cls_processstart) ) then               

                      set ts = trgt.Flows.createnew
                      ts.destination = findobject(s2.destinationsymbol).object
                      ts.source  = findobject(s2.sourcesymbol).object
                      set ss2 = findobject(d).attachlinkobject(ts, findobject(s2.sourcesymbol), findobject(s2.destinationsymbol))
                      CopySymbolProperties s2, ss2
                      map.add s2, ss2
                      addformat s2.object, ts
                end if

             end if
          end if
      end if

   next

next

'loop on composite processes 

for each p in srce.processes
  if not p.IsShortcut then
      if p.composite then
         addShortcut p, Findobject(p) 
      end if
  end if
next

'loop on packages

For each f in srce.Packages
   addShortcut f, Findobject(f) 
next

end Function

'-----------------------------------------------------------------------------
' Revert list of point for a link symbol
'-----------------------------------------------------------------------------
Function RevertPoints (sourcepoint, targetpoint)

dim n 
dim lpoint
dim ap

set lpoint = newptlist ()

n=0
do while n < sourcepoint.count

   set ap = lpoint.insert (0, sourcepoint.item(n))
   n= n+1
loop
targetpoint.astext = lpoint.astext
end function

'-----------------------------------------------------------------------------
' Add Format information in description of a a link object
'-----------------------------------------------------------------------------
Function AddFormat (f , ff)

if not f.format is nothing then
             
   ff.description = rtf2ascii(ff.description) & vbcrlf & vbcrlf & "Message Format Name/Code : " & f.format.name  & " / " & f.format.code & vbcrlf & f.format.type 
            
   '0 for Embedded, 1 for External and 2 for URL
   if f.format.definitiontype = 0 then
      ff.description = ff.description & vbcrlf & "Embedded" & vbcrlf & f.format.Definition
   elseif f.format.definitiontype = 1 then
       ff.description = ff.description & vbcrlf & "External" & " " & f.format.location
   elseif f.format.definitiontype = 2 then
       ff.description = ff.description & vbcrlf & "URL" & " " & f.format.location
   end if
end if

End function

'-----------------------------------------------------------------------------
' Display class name and name for an object (debugging function)
'-----------------------------------------------------------------------------
Function Disp (obj)
   output obj.classname & "  " & obj.name 
end function
