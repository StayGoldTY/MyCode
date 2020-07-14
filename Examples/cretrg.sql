/*==============================================================*/
/* Database name:  PROJECT                                      */
/* DBMS name:      Sybase AS Anywhere 6                         */
/* Created on:     07/09/99 11:08:28                            */
/*==============================================================*/



/*  Before delete trigger "TDB_CUSTOMER" for table "PROJ.CUSTOMER"  */
create trigger TDB_CUSTOMER before delete order 1 on PROJ.CUSTOMER
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "PROJ.CUSTOMER" if children still exist in "PROJ.PROJECT"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.PROJECT
                   where  CUSNUM = old_del.CUSNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_CUSTOMER) of table PROJ.PROJECT';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before delete trigger "TDB_DIVISION" for table "ADMIN.DIVISION"  */
create trigger TDB_DIVISION before delete order 1 on ADMIN.DIVISION
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "ADMIN.DIVISION" if children still exist in "PROJ.EMPLOYEE"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.EMPLOYEE
                   where  DIVNUM = old_del.DIVNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_DIVISION) of table ADMIN.EMPLOYEE';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before delete trigger "TDB_EMPLOYEE" for table "PROJ.EMPLOYEE"  */
create trigger TDB_EMPLOYEE before delete order 1 on PROJ.EMPLOYEE
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "PROJ.EMPLOYEE" if children still exist in "PROJ.MEMBER"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.MEMBER
                   where  EMPNUM = old_del.EMPNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_EMPLOYEE) of table PROJ.MEMBER';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
    /*  Cannot delete parent "PROJ.EMPLOYEE" if children still exist in "PROJ.EMPLOYEE"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.EMPLOYEE
                   where  EMP_EMPNUM = old_del.EMPNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_EMPLOYEE) of table PROJ.EMPLOYEE';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
    /*  Cannot delete parent "PROJ.EMPLOYEE" if children still exist in "PROJ.PROJECT"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.PROJECT
                   where  EMPNUM = old_del.EMPNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_EMPLOYEE) of table PROJ.PROJECT';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
    /*  Cannot delete parent "PROJ.EMPLOYEE" if children still exist in "PROJ.USED"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.USED
                   where  EMPNUM = old_del.EMPNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_EMPLOYEE) of table PROJ.USED';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
    /*  Cannot delete parent "PROJ.EMPLOYEE" if children still exist in "PROJ.PARTICIPATE"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.PARTICIPATE
                   where  EMPNUM = old_del.EMPNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_EMPLOYEE) of table PROJ.PARTICIPATE';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before delete trigger "TDB_MATERIAL" for table "PROJ.MATERIAL"  */
create trigger TDB_MATERIAL before delete order 1 on PROJ.MATERIAL
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "PROJ.MATERIAL" if children still exist in "PROJ.USED"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.USED
                   where  MATNUM = old_del.MATNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_MATERIAL) of table PROJ.USED';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
    /*  Cannot delete parent "PROJ.MATERIAL" if children still exist in "PROJ.COMPOSE"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.COMPOSE
                   where  CPD_MATNUM = old_del.MATNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_MATERIAL) of table PROJ.COMPOSE';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
    /*  Cannot delete parent "PROJ.MATERIAL" if children still exist in "PROJ.COMPOSE"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.COMPOSE
                   where  CPN_MATNUM = old_del.MATNUM);
    if found = 1 then
       message 'Error: Trigger(TDB_MATERIAL) of table PROJ.COMPOSE';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before delete trigger "TDB_PROJECT" for table "PROJ.PROJECT"  */
create trigger TDB_PROJECT before delete order 1 on PROJ.PROJECT
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "PROJ.PROJECT" if children still exist in "PROJ.TASK"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.TASK
                   where  PRONUM = old_del.PRONUM);
    if found = 1 then
       message 'Error: Trigger(TDB_PROJECT) of table PROJ.TASK';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before delete trigger "TDB_TASK" for table "PROJ.TASK"  */
create trigger TDB_TASK before delete order 1 on PROJ.TASK
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "PROJ.TASK" if children still exist in "PROJ.PARTICIPATE"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.PARTICIPATE
                   where  PRONUM = old_del.PRONUM
                    and   TSKNAME = old_del.TSKNAME);
    if found = 1 then
       message 'Error: Trigger(TDB_TASK) of table PROJ.PARTICIPATE';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before delete trigger "TDB_TEAM" for table "PROJ.TEAM"  */
create trigger TDB_TEAM before delete order 1 on PROJ.TEAM
referencing old as old_del for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot delete parent "PROJ.TEAM" if children still exist in "PROJ.MEMBER"  */
    set found = 0;
    select 1
     into  found
     from  dummy
    where  exists (select 1
                    from  PROJ.MEMBER
                   where  TEANUM = old_del.TEANUM);
    if found = 1 then
       message 'Error: Trigger(TDB_TEAM) of table PROJ.MEMBER';
       message '        Cannot delete parent if children still exist!';
       signal user_defined_exception;
    end if;
end
/

/*  Before insert trigger "TIB_COMPOSE" for table "PROJ.COMPOSE"  */
create trigger TIB_COMPOSE before insert order 1 on PROJ.COMPOSE
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.MATERIAL" must exist when inserting a child in "PROJ.COMPOSE"  */
    if (new_ins.CPD_MATNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MATERIAL
                      where  MATNUM = new_ins.CPD_MATNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_COMPOSE) of table PROJ.COMPOSE';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.MATERIAL" must exist when inserting a child in "PROJ.COMPOSE"  */
    if (new_ins.CPN_MATNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MATERIAL
                      where  MATNUM = new_ins.CPN_MATNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_COMPOSE) of table PROJ.COMPOSE';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before insert trigger "TIB_EMPLOYEE" for table "PROJ.EMPLOYEE"  */
create trigger TIB_EMPLOYEE before insert order 1 on PROJ.EMPLOYEE
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.EMPLOYEE" must exist when inserting a child in "PROJ.EMPLOYEE"  */
    if (new_ins.EMP_EMPNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_ins.EMP_EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_EMPLOYEE) of table PROJ.EMPLOYEE';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "ADMIN.DIVISION" must exist when inserting a child in "PROJ.EMPLOYEE"  */
    if (new_ins.DIVNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  ADMIN.DIVISION
                      where  DIVNUM = new_ins.DIVNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_EMPLOYEE) of table PROJ.EMPLOYEE';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before insert trigger "TIB_MEMBER" for table "PROJ.MEMBER"  */
create trigger TIB_MEMBER before insert order 1 on PROJ.MEMBER
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.TEAM" must exist when inserting a child in "PROJ.MEMBER"  */
    if (new_ins.TEANUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.TEAM
                      where  TEANUM = new_ins.TEANUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_MEMBER) of table PROJ.MEMBER';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.EMPLOYEE" must exist when inserting a child in "PROJ.MEMBER"  */
    if (new_ins.EMPNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_ins.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_MEMBER) of table PROJ.MEMBER';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before insert trigger "TIB_PARTICIPATE" for table "PROJ.PARTICIPATE"  */
create trigger TIB_PARTICIPATE before insert order 1 on PROJ.PARTICIPATE
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.EMPLOYEE" must exist when inserting a child in "PROJ.PARTICIPATE"  */
    if (new_ins.EMPNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_ins.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_PARTICIPATE) of table PROJ.PARTICIPATE';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.TASK" must exist when inserting a child in "PROJ.PARTICIPATE"  */
    if (new_ins.PRONUM is not null and
        new_ins.TSKNAME is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.TASK
                      where  PRONUM = new_ins.PRONUM
                       and   TSKNAME = new_ins.TSKNAME);
       if found <> 1 then
          message 'Error: Trigger(TIB_PARTICIPATE) of table PROJ.PARTICIPATE';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before insert trigger "TIB_PROJECT" for table "PROJ.PROJECT"  */
create trigger TIB_PROJECT before insert order 1 on PROJ.PROJECT
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.CUSTOMER" must exist when inserting a child in "PROJ.PROJECT"  */
    if (new_ins.CUSNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.CUSTOMER
                      where  CUSNUM = new_ins.CUSNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_PROJECT) of table PROJ.PROJECT';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.EMPLOYEE" must exist when inserting a child in "PROJ.PROJECT"  */
    if (new_ins.EMPNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_ins.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_PROJECT) of table PROJ.PROJECT';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before insert trigger "TIB_TASK" for table "PROJ.TASK"  */
create trigger TIB_TASK before insert order 1 on PROJ.TASK
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.PROJECT" must exist when inserting a child in "PROJ.TASK"  */
    if (new_ins.PRONUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.PROJECT
                      where  PRONUM = new_ins.PRONUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_TASK) of table PROJ.TASK';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before insert trigger "TIB_USED" for table "PROJ.USED"  */
create trigger TIB_USED before insert order 1 on PROJ.USED
referencing new as new_ins for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.MATERIAL" must exist when inserting a child in "PROJ.USED"  */
    if (new_ins.MATNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MATERIAL
                      where  MATNUM = new_ins.MATNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_USED) of table PROJ.USED';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.EMPLOYEE" must exist when inserting a child in "PROJ.USED"  */
    if (new_ins.EMPNUM is not null) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_ins.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TIB_USED) of table PROJ.USED';
          message '        Parent code must exist when inserting a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_COMPOSE" for table "PROJ.COMPOSE"  */
create trigger TUB_COMPOSE before update of CPD_MATNUM,
                                          CPN_MATNUM
order 1 on PROJ.COMPOSE
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.MATERIAL" must exist when updating a child in "PROJ.COMPOSE"  */
    if (new_upd.CPD_MATNUM is not null and
        ((old_upd.CPD_MATNUM is null) or
         (new_upd.CPD_MATNUM <> old_upd.CPD_MATNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MATERIAL
                      where  MATNUM = new_upd.CPD_MATNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_COMPOSE) of table PROJ.COMPOSE';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.MATERIAL" must exist when updating a child in "PROJ.COMPOSE"  */
    if (new_upd.CPN_MATNUM is not null and
        ((old_upd.CPN_MATNUM is null) or
         (new_upd.CPN_MATNUM <> old_upd.CPN_MATNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MATERIAL
                      where  MATNUM = new_upd.CPN_MATNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_COMPOSE) of table PROJ.COMPOSE';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_CUSTOMER" for table "PROJ.CUSTOMER"  */
create trigger TUB_CUSTOMER before update of CUSNUM
order 1 on PROJ.CUSTOMER
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot modify parent code in "PROJ.CUSTOMER" if children still exist in "PROJ.PROJECT"  */
    if (new_upd.CUSNUM <> old_upd.CUSNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.PROJECT
                      where  CUSNUM = old_upd.CUSNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_CUSTOMER) of table PROJ.PROJECT';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_DIVISION" for table "ADMIN.DIVISION"  */
create trigger TUB_DIVISION before update of DIVNUM
order 1 on ADMIN.DIVISION
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot modify parent code in "ADMIN.DIVISION" if children still exist in "PROJ.EMPLOYEE"  */
    if (new_upd.DIVNUM <> old_upd.DIVNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  DIVNUM = old_upd.DIVNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_DIVISION) of table ADMIN.EMPLOYEE';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_EMPLOYEE" for table "PROJ.EMPLOYEE"  */
create trigger TUB_EMPLOYEE before update of EMPNUM,
                                          EMP_EMPNUM,
                                          DIVNUM,
                                          EMPFNAM,
                                          EMPLNAM,
                                          EMPFUNC
order 1 on PROJ.EMPLOYEE
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.EMPLOYEE" must exist when updating a child in "PROJ.EMPLOYEE"  */
    if (new_upd.EMP_EMPNUM is not null and
        ((old_upd.EMP_EMPNUM is null) or
         (new_upd.EMP_EMPNUM <> old_upd.EMP_EMPNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_upd.EMP_EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.EMPLOYEE';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "ADMIN.DIVISION" must exist when updating a child in "PROJ.EMPLOYEE"  */
    if (new_upd.DIVNUM is not null and
        ((old_upd.DIVNUM is null) or
         (new_upd.DIVNUM <> old_upd.DIVNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  ADMIN.DIVISION
                      where  DIVNUM = new_upd.DIVNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.EMPLOYEE';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.EMPLOYEE" if children still exist in "PROJ.MEMBER"  */
    if (new_upd.EMPNUM <> old_upd.EMPNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MEMBER
                      where  EMPNUM = old_upd.EMPNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.MEMBER';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.EMPLOYEE" if children still exist in "PROJ.EMPLOYEE"  */
    if (new_upd.EMPNUM <> old_upd.EMPNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMP_EMPNUM = old_upd.EMPNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.EMPLOYEE';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.EMPLOYEE" if children still exist in "PROJ.PROJECT"  */
    if (new_upd.EMPNUM <> old_upd.EMPNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.PROJECT
                      where  EMPNUM = old_upd.EMPNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.PROJECT';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.EMPLOYEE" if children still exist in "PROJ.USED"  */
    if (new_upd.EMPNUM <> old_upd.EMPNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.USED
                      where  EMPNUM = old_upd.EMPNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.USED';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.EMPLOYEE" if children still exist in "PROJ.PARTICIPATE"  */
    if (new_upd.EMPNUM <> old_upd.EMPNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.PARTICIPATE
                      where  EMPNUM = old_upd.EMPNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_EMPLOYEE) of table PROJ.PARTICIPATE';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_MATERIAL" for table "PROJ.MATERIAL"  */
create trigger TUB_MATERIAL before update of MATNUM
order 1 on PROJ.MATERIAL
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot modify parent code in "PROJ.MATERIAL" if children still exist in "PROJ.USED"  */
    if (new_upd.MATNUM <> old_upd.MATNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.USED
                      where  MATNUM = old_upd.MATNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_MATERIAL) of table PROJ.USED';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.MATERIAL" if children still exist in "PROJ.COMPOSE"  */
    if (new_upd.MATNUM <> old_upd.MATNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.COMPOSE
                      where  CPD_MATNUM = old_upd.MATNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_MATERIAL) of table PROJ.COMPOSE';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.MATERIAL" if children still exist in "PROJ.COMPOSE"  */
    if (new_upd.MATNUM <> old_upd.MATNUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.COMPOSE
                      where  CPN_MATNUM = old_upd.MATNUM);
       if found = 1 then
          message 'Error: Trigger(TUB_MATERIAL) of table PROJ.COMPOSE';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_MEMBER" for table "PROJ.MEMBER"  */
create trigger TUB_MEMBER before update of TEANUM,
                                          EMPNUM
order 1 on PROJ.MEMBER
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.TEAM" must exist when updating a child in "PROJ.MEMBER"  */
    if (new_upd.TEANUM is not null and
        ((old_upd.TEANUM is null) or
         (new_upd.TEANUM <> old_upd.TEANUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.TEAM
                      where  TEANUM = new_upd.TEANUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_MEMBER) of table PROJ.MEMBER';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.EMPLOYEE" must exist when updating a child in "PROJ.MEMBER"  */
    if (new_upd.EMPNUM is not null and
        ((old_upd.EMPNUM is null) or
         (new_upd.EMPNUM <> old_upd.EMPNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_upd.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_MEMBER) of table PROJ.MEMBER';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_PARTICIPATE" for table "PROJ.PARTICIPATE"  */
create trigger TUB_PARTICIPATE before update of PRONUM,
                                          TSKNAME,
                                          EMPNUM
order 1 on PROJ.PARTICIPATE
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.EMPLOYEE" must exist when updating a child in "PROJ.PARTICIPATE"  */
    if (new_upd.EMPNUM is not null and
        ((old_upd.EMPNUM is null) or
         (new_upd.EMPNUM <> old_upd.EMPNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_upd.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_PARTICIPATE) of table PROJ.PARTICIPATE';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.TASK" must exist when updating a child in "PROJ.PARTICIPATE"  */
    if (new_upd.PRONUM is not null and
        new_upd.TSKNAME is not null and
        ((old_upd.PRONUM is null and
          old_upd.TSKNAME is null) or
         (new_upd.PRONUM <> old_upd.PRONUM or
          new_upd.TSKNAME <> old_upd.TSKNAME))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.TASK
                      where  PRONUM = new_upd.PRONUM
                       and   TSKNAME = new_upd.TSKNAME);
       if found <> 1 then
          message 'Error: Trigger(TUB_PARTICIPATE) of table PROJ.PARTICIPATE';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_PROJECT" for table "PROJ.PROJECT"  */
create trigger TUB_PROJECT before update of PRONUM,
                                          CUSNUM,
                                          EMPNUM
order 1 on PROJ.PROJECT
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.CUSTOMER" must exist when updating a child in "PROJ.PROJECT"  */
    if (new_upd.CUSNUM is not null and
        ((old_upd.CUSNUM is null) or
         (new_upd.CUSNUM <> old_upd.CUSNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.CUSTOMER
                      where  CUSNUM = new_upd.CUSNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_PROJECT) of table PROJ.PROJECT';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.EMPLOYEE" must exist when updating a child in "PROJ.PROJECT"  */
    if (new_upd.EMPNUM is not null and
        ((old_upd.EMPNUM is null) or
         (new_upd.EMPNUM <> old_upd.EMPNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_upd.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_PROJECT) of table PROJ.PROJECT';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.PROJECT" if children still exist in "PROJ.TASK"  */
    if (new_upd.PRONUM <> old_upd.PRONUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.TASK
                      where  PRONUM = old_upd.PRONUM);
       if found = 1 then
          message 'Error: Trigger(TUB_PROJECT) of table PROJ.TASK';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_TASK" for table "PROJ.TASK"  */
create trigger TUB_TASK before update of PRONUM,
                                          TSKNAME
order 1 on PROJ.TASK
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.PROJECT" must exist when updating a child in "PROJ.TASK"  */
    if (new_upd.PRONUM is not null and
        ((old_upd.PRONUM is null) or
         (new_upd.PRONUM <> old_upd.PRONUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.PROJECT
                      where  PRONUM = new_upd.PRONUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_TASK) of table PROJ.TASK';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Cannot modify parent code in "PROJ.TASK" if children still exist in "PROJ.PARTICIPATE"  */
    if (new_upd.PRONUM <> old_upd.PRONUM or
        new_upd.TSKNAME <> old_upd.TSKNAME ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.PARTICIPATE
                      where  PRONUM = old_upd.PRONUM
                       and   TSKNAME = old_upd.TSKNAME);
       if found = 1 then
          message 'Error: Trigger(TUB_TASK) of table PROJ.PARTICIPATE';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_TEAM" for table "PROJ.TEAM"  */
create trigger TUB_TEAM before update of TEANUM
order 1 on PROJ.TEAM
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Cannot modify parent code in "PROJ.TEAM" if children still exist in "PROJ.MEMBER"  */
    if (new_upd.TEANUM <> old_upd.TEANUM ) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MEMBER
                      where  TEANUM = old_upd.TEANUM);
       if found = 1 then
          message 'Error: Trigger(TUB_TEAM) of table PROJ.MEMBER';
          message '        Cannot modify parent code if children still exist!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/

/*  Before update trigger "TUB_USED" for table "PROJ.USED"  */
create trigger TUB_USED before update of MATNUM,
                                          EMPNUM
order 1 on PROJ.USED
referencing new as new_upd old as old_upd for each row
begin
    declare user_defined_exception exception for SQLSTATE '99999';
    declare found integer;
    /*  Parent "PROJ.MATERIAL" must exist when updating a child in "PROJ.USED"  */
    if (new_upd.MATNUM is not null and
        ((old_upd.MATNUM is null) or
         (new_upd.MATNUM <> old_upd.MATNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.MATERIAL
                      where  MATNUM = new_upd.MATNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_USED) of table PROJ.USED';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
    /*  Parent "PROJ.EMPLOYEE" must exist when updating a child in "PROJ.USED"  */
    if (new_upd.EMPNUM is not null and
        ((old_upd.EMPNUM is null) or
         (new_upd.EMPNUM <> old_upd.EMPNUM))) then
    begin
       set found = 0;
       select 1
        into  found
        from  dummy
       where  exists (select 1
                       from  PROJ.EMPLOYEE
                      where  EMPNUM = new_upd.EMPNUM);
       if found <> 1 then
          message 'Error: Trigger(TUB_USED) of table PROJ.USED';
          message '        Parent must exist when updating a child!';
          signal user_defined_exception;
       end if;
    end
    end if;
end
/
