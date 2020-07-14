/*==============================================================*/
/* Database name:  PROJECT                                      */
/* DBMS name:      Sybase AS Anywhere 6                         */
/* Created on:     07/07/99 16:18:00                            */
/*==============================================================*/


alter table PROJ.EMPLOYEE
   delete foreign key FK_EMPLOYEE_BELONGS_T_DIVISION;

alter table PROJ.TASK
   delete foreign key FK_TASK_BELONGS_T_PROJECT;

alter table PROJ.EMPLOYEE
   delete foreign key FK_EMPLOYEE_CHIEF_EMPLOYEE;

alter table PROJ.COMPOSE
   delete foreign key FK_COMPOSE_COMPOSED__MATERIAL;

alter table PROJ.COMPOSE
   delete foreign key FK_COMPOSE_COMPOSES_MATERIAL;

alter table PROJ.PARTICIPATE
   delete foreign key FK_PARTICIP_IS_DONE_B_TASK;

alter table PROJ.MEMBER
   delete foreign key FK_MEMBER_IS_MEMBER_EMPLOYEE;

alter table PROJ.PROJECT
   delete foreign key FK_PROJECT_IS_RESPON_EMPLOYEE;

alter table PROJ.MEMBER
   delete foreign key FK_MEMBER_MEMBER_TEAM;

alter table PROJ.PROJECT
   delete foreign key FK_PROJECT_SUBCONTRA_CUSTOMER;

alter table PROJ.USED
   delete foreign key FK_USED_USED_MATERIAL;

alter table PROJ.USED
   delete foreign key FK_USED_USES_EMPLOYEE;

alter table PROJ.PARTICIPATE
   delete foreign key FK_PARTICIP_WORKS_ON_EMPLOYEE;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='BELONGS_TO_FK' and T.table_name='TASK') then
   drop index PROJ.TASK.BELONGS_TO_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='BELONGS_TO_FK2' and T.table_name='EMPLOYEE') then
   drop index PROJ.EMPLOYEE.BELONGS_TO_FK2
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='CHIEF_FK' and T.table_name='EMPLOYEE') then
   drop index PROJ.EMPLOYEE.CHIEF_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='COMPOSED_OF_FK' and T.table_name='COMPOSE') then
   drop index PROJ.COMPOSE.COMPOSED_OF_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='COMPOSES_FK' and T.table_name='COMPOSE') then
   drop index PROJ.COMPOSE.COMPOSES_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='IS_DONE_BY_FK' and T.table_name='PARTICIPATE') then
   drop index PROJ.PARTICIPATE.IS_DONE_BY_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='IS_MEMBER_OF_FK' and T.table_name='MEMBER') then
   drop index PROJ.MEMBER.IS_MEMBER_OF_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='IS_RESPONSIBLE_FOR_FK' and T.table_name='PROJECT') then
   drop index PROJ.PROJECT.IS_RESPONSIBLE_FOR_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='MEMBER_FK' and T.table_name='MEMBER') then
   drop index PROJ.MEMBER.MEMBER_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='SUBCONTRACT_FK' and T.table_name='PROJECT') then
   drop index PROJ.PROJECT.SUBCONTRACT_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='USED_FK' and T.table_name='USED') then
   drop index PROJ.USED.USED_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='USES_FK' and T.table_name='USED') then
   drop index PROJ.USED.USES_FK
end if;

if exists(select 1 from sys.sysindex I, sys.systable T
 where I.index_name='WORKS_ON_FK' and T.table_name='PARTICIPATE') then
   drop index PROJ.PARTICIPATE.WORKS_ON_FK
end if;

if exists(select 1 from sys.systable where table_name='COMPOSE' and table_type='BASE') then
    drop table PROJ.COMPOSE
end if;

if exists(select 1 from sys.systable where table_name='CUSTOMER' and table_type='BASE') then
    drop table PROJ.CUSTOMER
end if;

if exists(select 1 from sys.systable where table_name='DIVISION' and table_type='BASE') then
    drop table ADMIN.DIVISION
end if;

if exists(select 1 from sys.systable where table_name='EMPLOYEE' and table_type='BASE') then
    drop table PROJ.EMPLOYEE
end if;

if exists(select 1 from sys.systable where table_name='MATERIAL' and table_type='BASE') then
    drop table PROJ.MATERIAL
end if;

if exists(select 1 from sys.systable where table_name='MEMBER' and table_type='BASE') then
    drop table PROJ.MEMBER
end if;

if exists(select 1 from sys.systable where table_name='PARTICIPATE' and table_type='BASE') then
    drop table PROJ.PARTICIPATE
end if;

if exists(select 1 from sys.systable where table_name='PROJECT' and table_type='BASE') then
    drop table PROJ.PROJECT
end if;

if exists(select 1 from sys.systable where table_name='TASK' and table_type='BASE') then
    drop table PROJ.TASK
end if;

if exists(select 1 from sys.systable where table_name='TEAM' and table_type='BASE') then
    drop table PROJ.TEAM
end if;

if exists(select 1 from sys.systable where table_name='USED' and table_type='BASE') then
    drop table PROJ.USED
end if;

if exists(select 1 from systypes where name='ID') then
   drop datatype ID
end if;

if exists(select 1 from systypes where name='MONEY') then
   drop datatype MONEY
end if;

if exists(select 1 from systypes where name='NAME') then
   drop datatype NAME
end if;

if exists(select 1 from systypes where name='PHONE') then
   drop datatype PHONE
end if;

if exists(select 1 from systypes where name='SHORT_TEXT') then
   drop datatype SHORT_TEXT
end if;

/*==============================================================*/
/* Domain: ID                                                   */
/*==============================================================*/
create datatype ID numeric(5)
      check (@column is null or (@column >= 1));

/*==============================================================*/
/* Domain: MONEY                                                */
/*==============================================================*/
create datatype MONEY numeric(8,2);

/*==============================================================*/
/* Domain: NAME                                                 */
/*==============================================================*/
create datatype NAME char(30);

/*==============================================================*/
/* Domain: PHONE                                                */
/*==============================================================*/
create datatype PHONE char(12);

/*==============================================================*/
/* Domain: SHORT_TEXT                                           */
/*==============================================================*/
create datatype SHORT_TEXT char(80);

/*==============================================================*/
/* Table : COMPOSE                                              */
/*==============================================================*/
create table PROJ.COMPOSE 
(
    CPD_MATNUM ID not null,
    CPN_MATNUM ID not null,
    primary key (CPD_MATNUM, CPN_MATNUM)
);

comment on table PROJ.COMPOSE is 'Compose';

comment on column PROJ.COMPOSE.CPD_MATNUM is 'Composed Material number';

comment on column PROJ.COMPOSE.CPN_MATNUM is 'Component Material number';

/*==============================================================*/
/* Table : CUSTOMER                                             */
/*==============================================================*/
create table PROJ.CUSTOMER 
(
    CUSNUM ID not null 
          check (CUSNUM >= 1),
    CUSNAME NAME not null,
    CUSADDR SHORT_TEXT not null,
    CUSACT SHORT_TEXT,
    CUSTEL PHONE,
    CUSFAX PHONE,
    primary key (CUSNUM)
);

comment on table PROJ.CUSTOMER is 'Customer';

comment on column PROJ.CUSTOMER.CUSNUM is 'Customer number';

comment on column PROJ.CUSTOMER.CUSNAME is 'Customer name';

comment on column PROJ.CUSTOMER.CUSADDR is 'Customer address';

comment on column PROJ.CUSTOMER.CUSACT is 'Customer activity';

comment on column PROJ.CUSTOMER.CUSTEL is 'Customer telephone';

comment on column PROJ.CUSTOMER.CUSFAX is 'Customer fax';

/*==============================================================*/
/* Table : DIVISION                                             */
/*==============================================================*/
create table ADMIN.DIVISION 
(
    DIVNUM ID not null 
          check (DIVNUM >= 1),
    DIVNAME NAME not null,
    DIVADDR SHORT_TEXT,
    primary key (DIVNUM)
);

comment on table ADMIN.DIVISION is 'Division';

comment on column ADMIN.DIVISION.DIVNUM is 'Division number';

comment on column ADMIN.DIVISION.DIVNAME is 'Division name';

comment on column ADMIN.DIVISION.DIVADDR is 'Division address';

/*==============================================================*/
/* Table : EMPLOYEE                                             */
/*==============================================================*/
create table PROJ.EMPLOYEE 
(
    EMPNUM ID not null 
          check (EMPNUM >= 1),
    EMP_EMPNUM ID,
    DIVNUM ID not null,
    EMPFNAM NAME,
    EMPLNAM NAME not null,
    EMPFUNC NAME,
    EMPSAL MONEY,
    primary key (EMPNUM),
    unique (EMPLNAM, EMPFNAM, EMPFUNC)
);

comment on table PROJ.EMPLOYEE is 'Employee';

comment on column PROJ.EMPLOYEE.EMPNUM is 'Employee number';

comment on column PROJ.EMPLOYEE.EMP_EMPNUM is 'EMP_Employee number';

comment on column PROJ.EMPLOYEE.DIVNUM is 'Division number';

comment on column PROJ.EMPLOYEE.EMPFNAM is 'First name';

comment on column PROJ.EMPLOYEE.EMPLNAM is 'Last name';

comment on column PROJ.EMPLOYEE.EMPFUNC is 'Employee function';

comment on column PROJ.EMPLOYEE.EMPSAL is 'Employee salary';

/*==============================================================*/
/* Table : MATERIAL                                             */
/*==============================================================*/
create table PROJ.MATERIAL 
(
    MATNUM ID not null 
          check (MATNUM >= 1),
    MATNAME NAME not null,
    MATTYPE NAME not null,
    primary key (MATNUM)
);

comment on table PROJ.MATERIAL is 'Material';

comment on column PROJ.MATERIAL.MATNUM is 'Material number';

comment on column PROJ.MATERIAL.MATNAME is 'Material name';

comment on column PROJ.MATERIAL.MATTYPE is 'Material type';

/*==============================================================*/
/* Table : MEMBER                                               */
/*==============================================================*/
create table PROJ.MEMBER 
(
    TEANUM ID not null,
    EMPNUM ID not null,
    primary key (TEANUM, EMPNUM)
);

comment on table PROJ.MEMBER is 'Member';

comment on column PROJ.MEMBER.TEANUM is 'Team number';

comment on column PROJ.MEMBER.EMPNUM is 'Employee number';

/*==============================================================*/
/* Table : PARTICIPATE                                          */
/*==============================================================*/
create table PROJ.PARTICIPATE 
(
    PRONUM ID not null,
    TSKNAME NAME not null,
    EMPNUM ID not null,
    PARBEG timestamp,
    PAREND timestamp,
    primary key (PRONUM, TSKNAME, EMPNUM)
);

comment on table PROJ.PARTICIPATE is 'Participate';

comment on column PROJ.PARTICIPATE.PRONUM is 'Project number';

comment on column PROJ.PARTICIPATE.TSKNAME is 'Task name';

comment on column PROJ.PARTICIPATE.EMPNUM is 'Employee number';

comment on column PROJ.PARTICIPATE.PARBEG is 'Start date';

comment on column PROJ.PARTICIPATE.PAREND is 'End date';

/*==============================================================*/
/* Table : PROJECT                                              */
/*==============================================================*/
create table PROJ.PROJECT 
(
    PRONUM ID not null 
          check (PRONUM >= 1),
    CUSNUM ID not null,
    EMPNUM ID,
    ACTBEG timestamp,
    ACTEND timestamp,
    PRONAME NAME not null,
    PROLABL SHORT_TEXT,
    primary key (PRONUM)
);

comment on table PROJ.PROJECT is 'Project';

comment on column PROJ.PROJECT.PRONUM is 'Project number';

comment on column PROJ.PROJECT.CUSNUM is 'Customer number';

comment on column PROJ.PROJECT.EMPNUM is 'Employee number';

comment on column PROJ.PROJECT.ACTBEG is 'Start date';

comment on column PROJ.PROJECT.ACTEND is 'End date';

comment on column PROJ.PROJECT.PRONAME is 'Project name';

comment on column PROJ.PROJECT.PROLABL is 'Project label';

/*==============================================================*/
/* Table : TASK                                                 */
/*==============================================================*/
create table PROJ.TASK 
(
    PRONUM ID not null,
    TSKNAME NAME not null,
    ACTBEG timestamp,
    ACTEND timestamp,
    TSKCOST MONEY not null,
    primary key (PRONUM, TSKNAME)
);

comment on table PROJ.TASK is 'Task';

comment on column PROJ.TASK.PRONUM is 'Project number';

comment on column PROJ.TASK.TSKNAME is 'Task name';

comment on column PROJ.TASK.ACTBEG is 'Start date';

comment on column PROJ.TASK.ACTEND is 'End date';

comment on column PROJ.TASK.TSKCOST is 'Task cost';

/*==============================================================*/
/* Table : TEAM                                                 */
/*==============================================================*/
create table PROJ.TEAM 
(
    TEANUM ID not null 
          check (TEANUM >= 1),
    TEASPE SHORT_TEXT,
    primary key (TEANUM)
);

comment on table PROJ.TEAM is 'Team';

comment on column PROJ.TEAM.TEANUM is 'Team number';

comment on column PROJ.TEAM.TEASPE is 'Speciality';

/*==============================================================*/
/* Table : USED                                                 */
/*==============================================================*/
create table PROJ.USED 
(
    MATNUM ID not null,
    EMPNUM ID not null,
    primary key (MATNUM, EMPNUM)
);

comment on table PROJ.USED is 'Used';

comment on column PROJ.USED.MATNUM is 'Material number';

comment on column PROJ.USED.EMPNUM is 'Employee number';

/*==============================================================*/
/* Index: BELONGS_TO_FK                                         */
/*==============================================================*/
create index BELONGS_TO_FK on PROJ.TASK (
PRONUM ASC
);

/*==============================================================*/
/* Index: BELONGS_TO_FK2                                        */
/*==============================================================*/
create index BELONGS_TO_FK2 on PROJ.EMPLOYEE (
DIVNUM ASC
);

/*==============================================================*/
/* Index: CHIEF_FK                                              */
/*==============================================================*/
create index CHIEF_FK on PROJ.EMPLOYEE (
EMP_EMPNUM ASC
);

/*==============================================================*/
/* Index: COMPOSED_OF_FK                                        */
/*==============================================================*/
create index COMPOSED_OF_FK on PROJ.COMPOSE (
CPN_MATNUM ASC
);

/*==============================================================*/
/* Index: COMPOSES_FK                                           */
/*==============================================================*/
create index COMPOSES_FK on PROJ.COMPOSE (
CPD_MATNUM ASC
);

/*==============================================================*/
/* Index: IS_DONE_BY_FK                                         */
/*==============================================================*/
create index IS_DONE_BY_FK on PROJ.PARTICIPATE (
PRONUM ASC, TSKNAME ASC
);

/*==============================================================*/
/* Index: IS_MEMBER_OF_FK                                       */
/*==============================================================*/
create index IS_MEMBER_OF_FK on PROJ.MEMBER (
EMPNUM ASC
);

/*==============================================================*/
/* Index: IS_RESPONSIBLE_FOR_FK                                 */
/*==============================================================*/
create index IS_RESPONSIBLE_FOR_FK on PROJ.PROJECT (
EMPNUM ASC
);

/*==============================================================*/
/* Index: MEMBER_FK                                             */
/*==============================================================*/
create index MEMBER_FK on PROJ.MEMBER (
TEANUM ASC
);

/*==============================================================*/
/* Index: SUBCONTRACT_FK                                        */
/*==============================================================*/
create index SUBCONTRACT_FK on PROJ.PROJECT (
CUSNUM ASC
);

/*==============================================================*/
/* Index: USED_FK                                               */
/*==============================================================*/
create index USED_FK on PROJ.USED (
MATNUM ASC
);

/*==============================================================*/
/* Index: USES_FK                                               */
/*==============================================================*/
create index USES_FK on PROJ.USED (
EMPNUM ASC
);

/*==============================================================*/
/* Index: WORKS_ON_FK                                           */
/*==============================================================*/
create index WORKS_ON_FK on PROJ.PARTICIPATE (
EMPNUM ASC
);

alter table PROJ.EMPLOYEE
   add foreign key FK_EMPLOYEE_BELONGS_T_DIVISION (DIVNUM)
      references ADMIN.DIVISION (DIVNUM)
      on update restrict
      on delete restrict;

alter table PROJ.TASK
   add foreign key FK_TASK_BELONGS_T_PROJECT (PRONUM)
      references PROJ.PROJECT (PRONUM)
      on update restrict
      on delete restrict;

alter table PROJ.EMPLOYEE
   add foreign key FK_EMPLOYEE_CHIEF_EMPLOYEE (EMP_EMPNUM)
      references PROJ.EMPLOYEE (EMPNUM)
      on update restrict
      on delete restrict;

alter table PROJ.COMPOSE
   add foreign key FK_COMPOSE_COMPOSED__MATERIAL (CPN_MATNUM)
      references PROJ.MATERIAL (MATNUM)
      on update restrict
      on delete restrict;

alter table PROJ.COMPOSE
   add foreign key FK_COMPOSE_COMPOSES_MATERIAL (CPD_MATNUM)
      references PROJ.MATERIAL (MATNUM)
      on update restrict
      on delete restrict;

alter table PROJ.PARTICIPATE
   add foreign key FK_PARTICIP_IS_DONE_B_TASK (PRONUM, TSKNAME)
      references PROJ.TASK (PRONUM, TSKNAME)
      on update restrict
      on delete restrict;

alter table PROJ.MEMBER
   add foreign key FK_MEMBER_IS_MEMBER_EMPLOYEE (EMPNUM)
      references PROJ.EMPLOYEE (EMPNUM)
      on update restrict
      on delete restrict;

alter table PROJ.PROJECT
   add foreign key FK_PROJECT_IS_RESPON_EMPLOYEE (EMPNUM)
      references PROJ.EMPLOYEE (EMPNUM)
      on update restrict
      on delete restrict;

alter table PROJ.MEMBER
   add foreign key FK_MEMBER_MEMBER_TEAM (TEANUM)
      references PROJ.TEAM (TEANUM)
      on update restrict
      on delete restrict;

alter table PROJ.PROJECT
   add foreign key FK_PROJECT_SUBCONTRA_CUSTOMER (CUSNUM)
      references PROJ.CUSTOMER (CUSNUM)
      on update restrict
      on delete restrict;

alter table PROJ.USED
   add foreign key FK_USED_USED_MATERIAL (MATNUM)
      references PROJ.MATERIAL (MATNUM)
      on update restrict
      on delete restrict;

alter table PROJ.USED
   add foreign key FK_USED_USES_EMPLOYEE (EMPNUM)
      references PROJ.EMPLOYEE (EMPNUM)
      on update restrict
      on delete restrict;

alter table PROJ.PARTICIPATE
   add foreign key FK_PARTICIP_WORKS_ON_EMPLOYEE (EMPNUM)
      references PROJ.EMPLOYEE (EMPNUM)
      on update restrict
      on delete restrict;

