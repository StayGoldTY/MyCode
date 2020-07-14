/*==============================================================*/
/* DBMS name:      Sybase AS Enterprise 12.5                    */
/* Created on:     6/9/2004 4:32:54 PM                          */
/*==============================================================*/


alter table Contact
   drop constraint FK_CONTACT_CUSTOMER_CUSTOMER
go

alter table Customer
   drop constraint FK_CUSTOMER_SALESREP_SALESREP
go

if exists (select 1
            from  sysobjects
            where  id = object_id('Contact')
            and    type = 'U')
   drop table Contact
go

if exists (select 1
            from  sysobjects
            where  id = object_id('Customer')
            and    type = 'U')
   drop table Customer
go

if exists (select 1
            from  sysobjects
            where  id = object_id('Product')
            and    type = 'U')
   drop table Product
go

if exists (select 1
            from  sysobjects
            where  id = object_id('SalesRep')
            and    type = 'U')
   drop table SalesRep
go

/*==============================================================*/
/* Table: Contact                                               */
/*==============================================================*/
create table Contact (
     contact_id           integer                        not null,
     name                 char(40)                       null,
     cust_id              integer                        null,
     constraint PK_CONTACT primary key (contact_id)
)
go

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table Customer (
     cust_id              integer                        not null,
     name                 char(40)                       not null,
     rep_id               integer                        not null,
     constraint PK_CUSTOMER primary key (cust_id)
)
go

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
create table Product (
     id                   integer                        not null,
     name                 char(15)                       null,
     size                 char(18)                       null,
     supplier             char(30)                       null,
     quantity             integer                        null,
     unit_price           numeric(19,4)                  null,
     constraint PK_PRODUCT primary key (id)
)
go

/*==============================================================*/
/* Table: SalesRep                                              */
/*==============================================================*/
create table SalesRep (
     rep_id               integer                        not null,
     name                 char(40)                       not null,
     constraint PK_SALESREP primary key (rep_id)
)
go

alter table Contact
   add constraint FK_CONTACT_CUSTOMER_CUSTOMER foreign key (cust_id)
      references Customer (cust_id)
go

alter table Customer
   add constraint FK_CUSTOMER_SALESREP_SALESREP foreign key (rep_id)
      references SalesRep (rep_id)
go

if exists (select 1
          from sysobjects
          where id = object_id('UpdateProductPrice')
          and type = 'P')
   drop procedure UpdateProductPrice
go


create procedure UpdateProductPrice @rate numeric(19,4) as
begin
   update Product set unit_price = unit_price * (100.0 + @rate)
end
go


