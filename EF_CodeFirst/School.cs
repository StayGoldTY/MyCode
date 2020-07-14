using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_CodeFirst
{
    class School
    {
        [Key]
        public int SchoolID {get;set;}
        public string SchoolName { get; set; }
        public virtual ICollection<Student> Students { get; set; }
    }
}
