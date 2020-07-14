using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;

namespace EF_CodeFirst
{
    class CodeFirstContext:DbContext
    {
        public CodeFirstContext()
           : base("name=conStr")
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }

        public virtual DbSet<School> School { get; set; }
        public virtual DbSet<Student> Student { get; set; }
    }
}
