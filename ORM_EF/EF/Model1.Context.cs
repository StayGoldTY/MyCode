﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace ORM_EF.EF
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class TYDBEntities2 : DbContext
    {
        public TYDBEntities2()
            : base("name=TYDBEntities2")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<DS_TCategory> DS_TCategory { get; set; }
        public virtual DbSet<ModelFIrst> ModelFIrsts { get; set; }
        public virtual DbSet<ModelFirstTwo> ModelFirstTwoes { get; set; }
    }
}