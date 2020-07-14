using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_CodeFirst
{
    class Program
    {
        static void Main(string[] args)
        {
            CodeFirstContext codeFirstContext = new CodeFirstContext();
            codeFirstContext.Database.CreateIfNotExists();
            Student student = new Student {ID  =3,Name ="test3" };
            TestCollection test = new TestCollection();
            test.Add(student);

            School school = new School { SchoolID = 3, SchoolName = "schooltest3", Students = test._student };
            codeFirstContext.School.Add(school);
            codeFirstContext.SaveChanges();


            //部分查询的LINQ表达方法，以及lambda表达式方法
            var schoolList = from s in codeFirstContext.School
                             where s.SchoolID > 0
                             select new { a = s.SchoolID, b = s.SchoolName };

            var schoolListTwo = codeFirstContext.School.Where(u => u.SchoolID > 0).OrderBy<School,int>( k => k.SchoolID).Skip(1); 

            Console.ReadKey();
        }

    }

    public class TestCollection : ICollection<Student>
    {
        public List<Student> _student = new List<Student>();
        public int Count => throw new NotImplementedException();

        public bool IsReadOnly => throw new NotImplementedException();

        public void Add(Student item)
        {
            _student.Add(item);
        }

        public void Clear()
        {
            throw new NotImplementedException();
        }

        public bool Contains(Student item)
        {
            throw new NotImplementedException();
        }

        public void CopyTo(Student[] array, int arrayIndex)
        {
            throw new NotImplementedException();
        }

        public IEnumerator<Student> GetEnumerator()
        {
            throw new NotImplementedException();
        }

        public bool Remove(Student item)
        {
            throw new NotImplementedException();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            throw new NotImplementedException();
        }
    }

}
