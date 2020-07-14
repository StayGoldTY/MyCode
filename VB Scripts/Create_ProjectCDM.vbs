'******************************************************************************
'* File:     Create_ProjectCDM.vbs
'* Purpose:  This sample script show how to create a CDM model using VBS
'* Title:    
'* Category: 
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************
'

'
' Model Creation 
'
Output " -> Creating CDM"
CreateModel PDCdm.cls_Model
ActiveModel.Name = "Project_ByScript"
ActiveModel.Code = ActiveModel.Name

Set folder = ActiveDiagram.Parent
'
' Creating Business Rules
'
Dim BTask_date_control 
Set BTask_date_control = ActiveModel.BusinessRules.CreateNew ' Creating Business Rule 
BTask_date_control.Name = "Task_date_control"
BTask_date_control.Type = 1

Dim BParticipate_date_control
Set BParticipate_date_control = ActiveModel.BusinessRules.CreateNew ' Creating Business Rule 
BParticipate_date_control.Name = "Participate_date_control"
BParticipate_date_control.Type = 2

Set BChief_rule = ActiveModel.BusinessRules.CreateNew' Creating Business Rule 
BChief_rule.Name = "Chief_rule"
BChief_rule.Type = 3

Set BActivity_date_control = ActiveModel.BusinessRules.CreateNew' Creating Business Rule 
BActivity_date_control.Name = "Activity_date_control"
BActivity_date_control.Type = 4
'
' End Of Creating Business Rules
'
' Creating Entities
' Creating Entity Activity
'
  Set EActivity = folder.Entities.CreateNew
  EActivity.Name = "Activity"
  EActivity.AttachedRules.Add(BActivity_date_control)
  EActivity.AttachedRules.Add(BChief_rule)
  EActivity.AttachedRules.Add(BParticipate_date_control)
  EActivity.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(EActivity)       ' Create a symbol for Activity...
'
' Creating Entity Customer
'
  Set ECustomer = folder.Entities.CreateNew
  ECustomer.Name = "Customer"
  ECustomer.AttachedRules.Add(BActivity_date_control)
  ECustomer.AttachedRules.Add(BChief_rule)
  ECustomer.AttachedRules.Add(BParticipate_date_control)
  ECustomer.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(ECustomer)       ' Create a symbol for Customer...
'
' Creating Entity Division
'
  Set EDivision = folder.Entities.CreateNew
  EDivision.Name = "Division"
  EDivision.AttachedRules.Add(BActivity_date_control)
  EDivision.AttachedRules.Add(BChief_rule)
  EDivision.AttachedRules.Add(BParticipate_date_control)
  EDivision.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(EDivision)       ' Create a symbol for Division...
'
' Creating Entity Employee
'
  Set EEmployee = folder.Entities.CreateNew
  EEmployee.Name = "Employee"
  EEmployee.AttachedRules.Add(BActivity_date_control)
  EEmployee.AttachedRules.Add(BChief_rule)
  EEmployee.AttachedRules.Add(BParticipate_date_control)
  EEmployee.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(EEmployee)       ' Create a symbol for Employee...
'
' Creating Entity Material
'
  Set EMaterial = folder.Entities.CreateNew
  EMaterial.Name = "Material"
  EMaterial.AttachedRules.Add(BActivity_date_control)
  EMaterial.AttachedRules.Add(BChief_rule)
  EMaterial.AttachedRules.Add(BParticipate_date_control)
  EMaterial.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(EMaterial)       ' Create a symbol for Material...
'
' Creating Entity Participate
'
  Set EParticipate = folder.Entities.CreateNew
  EParticipate.Name = "Participate"
  EParticipate.AttachedRules.Add(BActivity_date_control)
  EParticipate.AttachedRules.Add(BChief_rule)
  EParticipate.AttachedRules.Add(BParticipate_date_control)
  EParticipate.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(EParticipate)       ' Create a symbol for Participate...

'
' Creating Entity Project
'
  Set EProject = folder.Entities.CreateNew
  EProject.Name = "Project"
  EProject.AttachedRules.Add(BActivity_date_control)
  EProject.AttachedRules.Add(BChief_rule)
  EProject.AttachedRules.Add(BParticipate_date_control)
  EProject.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(EProject)       ' Create a symbol for Project...
'
' Creating Entity Task
'
  Set ETask = folder.Entities.CreateNew
  ETask.Name = "Task"
  ETask.AttachedRules.Add(BActivity_date_control)
  ETask.AttachedRules.Add(BChief_rule)
  ETask.AttachedRules.Add(BParticipate_date_control)
  ETask.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(ETask)       ' Create a symbol for Task...
'
' Creating Entity Team
'
  Set ETeam = folder.Entities.CreateNew
  ETeam.Name = "Team"
  ETeam.AttachedRules.Add(BActivity_date_control)
  ETeam.AttachedRules.Add(BChief_rule)
  ETeam.AttachedRules.Add(BParticipate_date_control)
  ETeam.AttachedRules.Add(BTask_date_control)
Set sym = ActiveDiagram.AttachObject(ETeam)       ' Create a symbol for Team...
'
' Enf Of Creating Entities
'
'
' Creating Domains
'

Set DIdentifier = ActiveModel.Domains.CreateNew' Creating Domain Identifier
DIdentifier.DataType = "N5"
DIdentifier.Name = "Identifier"
DIdentifier.Code =DIdentifier.Name


Set DMoney = ActiveModel.Domains.CreateNew' Creating Domain Money
DMoney.DataType = "MN8,2"
DMoney.Name = "Money"
DMoney.Code =DMoney.Name


Set DName = ActiveModel.Domains.CreateNew' Creating Domain Name
DName.DataType = "A30"
DName.Name = "Name"
DName.Code =DName.Name


Set DPhone = ActiveModel.Domains.CreateNew' Creating Domain Phone
DPhone.DataType = "A12"
DPhone.Name = "Phone"
DPhone.Code =DPhone.Name


Set DShort_description = ActiveModel.Domains.CreateNew' Creating Domain Short_description
DShort_description.DataType = "A80"
DShort_description.Name = "Short_description"
DShort_description.Code =DShort_description.Name

' End Of Creating Domains

' Creating Entities Attributes

Set ACustomer_activity = ECustomer.Attributes.CreateNew  ' Creating Attribute Customer_activity
ACustomer_activity.Name = "Customer_activity"
ACustomer_activity.Code =ACustomer_activity.Name
ACustomer_activity.Domain = DShort_description

Set ACustomer_address = ECustomer.Attributes.CreateNew  ' Creating Attribute Customer_address
ACustomer_address.Name = "Customer_address"
ACustomer_address.Code =ACustomer_address.Name
ACustomer_address.Domain = DShort_description

Set ACustomer_fax = ECustomer.Attributes.CreateNew  ' Creating Attribute Customer_fax
ACustomer_fax.Name = "Customer_fax"
ACustomer_fax.Code =ACustomer_fax.Name
ACustomer_fax.Domain = DPhone

Set ACustomer_name = ECustomer.Attributes.CreateNew  ' Creating Attribute Customer_name
ACustomer_name.Name = "Customer_name"
ACustomer_name.Code =ACustomer_name.Name
ACustomer_name.Domain = DName

Set ACustomer_number = ECustomer.Attributes.CreateNew  ' Creating Attribute Customer_number
ACustomer_number.Name = "Customer_number"
ACustomer_number.Code =ACustomer_number.Name
ACustomer_number.Domain = DIdentifier

Set ACustomer_telephone = ECustomer.Attributes.CreateNew  ' Creating Attribute Customer_telephone
ACustomer_telephone.Name = "Customer_telephone"
ACustomer_telephone.Code =ACustomer_telephone.Name
ACustomer_telephone.Domain = DPhone

Set ADivision_address = EDivision.Attributes.CreateNew  ' Creating Attribute Division_address
ADivision_address.Name = "Division_address"
ADivision_address.Code =ADivision_address.Name
ADivision_address.Domain = DShort_description

Set ADivision_name = EDivision.Attributes.CreateNew  ' Creating Attribute Division_name
ADivision_name.Name = "Division_name"
ADivision_name.Code =ADivision_name.Name
ADivision_name.Domain = DName

Set ADivision_number = EDivision.Attributes.CreateNew  ' Creating Attribute Division_number
ADivision_number.Name = "Division_number"
ADivision_number.Code =ADivision_number.Name
ADivision_number.Domain = DIdentifier

Set AEmployee_function = EEmployee.Attributes.CreateNew  ' Creating Attribute Employee_function
AEmployee_function.Name = "Employee_function"
AEmployee_function.Code =AEmployee_function.Name
AEmployee_function.Domain = DName

Set AEmployee_number = EEmployee.Attributes.CreateNew  ' Creating Attribute Employee_number
AEmployee_number.Name = "Employee_number"
AEmployee_number.Code =AEmployee_number.Name
AEmployee_number.Domain = DIdentifier

Set AEmployee_salary = EEmployee.Attributes.CreateNew  ' Creating Attribute Employee_salary
AEmployee_salary.Name = "Employee_salary"
AEmployee_salary.Code =AEmployee_salary.Name
AEmployee_salary.Domain = DMoney

Set AEnd_date__act_ = EActivity.Attributes.CreateNew  ' Creating Attribute End_date__act_
AEnd_date__act_.Name = "End_date__act_"
AEnd_date__act_.Code =AEnd_date__act_.Name
AEnd_date__act_.DataType = "A15"

Set AEnd_date__par_ = EParticipate.Attributes.CreateNew  ' Creating Attribute End_date__par_
AEnd_date__par_.Name = "End_date__par_"
AEnd_date__par_.Code =AEnd_date__par_.Name
AEnd_date__par_.DataType = "A15"

Set AFirst_name = EEmployee.Attributes.CreateNew  ' Creating Attribute First_name
AFirst_name.Name = "First_name"
AFirst_name.Code =AFirst_name.Name
AFirst_name.Domain = DName

Set ALast_name = EEmployee.Attributes.CreateNew  ' Creating Attribute Last_name
ALast_name.Name = "Last_name"
ALast_name.Code =ALast_name.Name
ALast_name.Domain = DName

Set AMaterial_name = EMaterial.Attributes.CreateNew  ' Creating Attribute Material_name
AMaterial_name.Name = "Material_name"
AMaterial_name.Code =AMaterial_name.Name
AMaterial_name.Domain = DName

Set AMaterial_number = EMaterial.Attributes.CreateNew  ' Creating Attribute Material_number
AMaterial_number.Name = "Material_number"
AMaterial_number.Code =AMaterial_number.Name
AMaterial_number.Domain = DIdentifier

Set AMaterial_type = EMaterial.Attributes.CreateNew  ' Creating Attribute Material_type
AMaterial_type.Name = "Material_type"
AMaterial_type.Code =AMaterial_type.Name
AMaterial_type.Domain = DName

Set AProject_label = EProject.Attributes.CreateNew  ' Creating Attribute Project_label
AProject_label.Name = "Project_label"
AProject_label.Code =AProject_label.Name
AProject_label.Domain = DShort_description

Set AProject_name = EProject.Attributes.CreateNew  ' Creating Attribute Project_name
AProject_name.Name = "Project_name"
AProject_name.Code =AProject_name.Name
AProject_name.Domain = DName

Set AProject_number = EProject.Attributes.CreateNew  ' Creating Attribute Project_number
AProject_number.Name = "Project_number"
AProject_number.Code =AProject_number.Name
AProject_number.Domain = DIdentifier

Set ASpeciality = ETeam.Attributes.CreateNew  ' Creating Attribute Speciality
ASpeciality.Name = "Speciality"
ASpeciality.Code =ASpeciality.Name
ASpeciality.Domain = DShort_description

Set AStart_date__act_ = EActivity.Attributes.CreateNew  ' Creating Attribute Start_date__act_
AStart_date__act_.Name = "Start_date__act_"
AStart_date__act_.Code =AStart_date__act_.Name
AStart_date__act_.DataType = "A15"

Set AStart_date__par_ = EParticipate.Attributes.CreateNew  ' Creating Attribute Start_date__par_
AStart_date__par_.Name = "Start_date__par_"
AStart_date__par_.Code =AStart_date__par_.Name
AStart_date__par_.DataType = "A15"

Set ATask_cost = ETask.Attributes.CreateNew  ' Creating Attribute Task_cost
ATask_cost.Name = "Task_cost"
ATask_cost.Code =ATask_cost.Name
ATask_cost.Domain = DMoney

Set ATask_name = ETask.Attributes.CreateNew  ' Creating Attribute Task_name
ATask_name.Name = "Task_name"
ATask_name.Code =ATask_name.Name
ATask_name.Domain = DName

Set ATeam_number = ETeam.Attributes.CreateNew  ' Creating Attribute Team_number
ATeam_number.Name = "Team_number"
ATeam_number.Code =ATeam_number.Name
ATeam_number.Domain = DIdentifier
' End Of Creating Entities Attributes

' Creating Relationships

Set RBelongs_to = ActiveModel.Relationships.CreateNew  ' Creating Relationship Belongs_to
RBelongs_to.Entity1  = EProject 'Set Parent of Belongs_to to Project
RBelongs_to.Entity2  = ETask 'Set Parent of Belongs_to to Task

Set RBelongs_to = ActiveModel.Relationships.CreateNew  ' Creating Relationship Belongs_to
RBelongs_to.Entity1  = EDivision 'Set Parent of Belongs_to to Division
RBelongs_to.Entity2  = EEmployee 'Set Parent of Belongs_to to Employee

Set RChief = ActiveModel.Relationships.CreateNew  ' Creating Relationship Chief
RChief.Entity1  = EEmployee 'Set Parent of Chief to Employee
RChief.Entity2  = EEmployee 'Set Parent of Chief to Employee

Set RCompose = ActiveModel.Relationships.CreateNew  ' Creating Relationship Compose
RCompose.Entity1  = EMaterial 'Set Parent of Compose to Material
RCompose.Entity2  = EMaterial 'Set Parent of Compose to Material

Set RIs_done_by = ActiveModel.Relationships.CreateNew  ' Creating Relationship Is_done_by
RIs_done_by.Entity1  = ETask 'Set Parent of Is_done_by to Task
RIs_done_by.Entity2  = EParticipate 'Set Parent of Is_done_by to Participate

Set RIs_responsible_for = ActiveModel.Relationships.CreateNew  ' Creating Relationship Is_responsible_for
RIs_responsible_for.Entity1  = EEmployee 'Set Parent of Is_responsible_for to Employee
RIs_responsible_for.Entity2  = EProject 'Set Parent of Is_responsible_for to Project

Set RMember = ActiveModel.Relationships.CreateNew  ' Creating Relationship Member
RMember.Entity1  = ETeam 'Set Parent of Member to Team
RMember.Entity2  = EEmployee 'Set Parent of Member to Employee

Set RSubcontract = ActiveModel.Relationships.CreateNew  ' Creating Relationship Subcontract
RSubcontract.Entity1  = ECustomer 'Set Parent of Subcontract to Customer
RSubcontract.Entity2  = EProject 'Set Parent of Subcontract to Project

Set RUsed = ActiveModel.Relationships.CreateNew  ' Creating Relationship Used
RUsed.Entity1  = EMaterial 'Set Parent of Used to Material
RUsed.Entity2  = EEmployee 'Set Parent of Used to Employee

Set RWorks_on = ActiveModel.Relationships.CreateNew  ' Creating Relationship Works_on
RWorks_on.Entity1  = EEmployee 'Set Parent of Works_on to Employee
RWorks_on.Entity2  = EParticipate 'Set Parent of Works_on to Participate
'Example of assigning cardinalities
RMember.Entity2ToEntity1RoleMaximumCardinality ="1"
RMember.Entity2ToEntity1RoleMinimumCardinality ="1"
RMember.Entity1ToEntity2RoleMaximumCardinality ="n"
RMember.Entity1ToEntity2RoleMinimumCardinality ="1"
RMember.Entity1ToEntity2RoleMandatory = True
RMember.DependentRole = "A"
' End Of Creating Relationships

' Creating Inheritances
Set IActivity = ActiveModel.Inheritances.CreateNew  ' Creating Inheritance Activity
IActivity.name = "Activity"
IActivity.ParentEntity   = EActivity 'Set Parent to Activity
Set FirstLink = ActiveModel.InheritanceLinks.CreateNew
FirstLink.ParentEntity = EActivity
FirstLink.ChildEntity = ETask
FirstLink.Inheritance = IActivity
Set SecondLink = ActiveModel.InheritanceLinks.CreateNew
SecondLink.ParentEntity = EActivity
SecondLink.ChildEntity = EProject
SecondLink.Inheritance = IActivity
' End Of Creating Inheritances

' Create all symbols

ActiveDiagram.AttachAllObjects  'Create symbols for all objects

' Launch Auto-layout

ActiveDiagram.AutoLayout 'launch auto layout
