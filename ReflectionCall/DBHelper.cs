using IDBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReflectionCall
{
    class CWDBHelper : IDBHelper1
    {
        public string Name { get { return name; } set { name = value; } }

        public string name = "123";
        public int Age { get; set; }
        public int pubInt = 1;
        private int priInt = 2;
        public void GetWrite()
        {
            Console.WriteLine("DBHelper中的返回"); 
        }

        public void GetWriteMethod()
        {
            Console.WriteLine("GetWriteMethod无参数中的返回");
        }

        public void GetWriteMethod1(int a,string b)
        {
            Console.WriteLine("GetWriteMethod有参数中的返回");
        }
        private void PrivateGetWrite()
        {
            Console.WriteLine("PrivateDBHelper中的返回");
        }

        public CWDBHelper()
        {
            Console.WriteLine("调用无参数构造函数");
        }

        public CWDBHelper(int a)
        {
            Console.WriteLine("调用int类型参数构造函数");
        }

        public CWDBHelper(int a,string b)
        {
            Console.WriteLine("调用int,string类型参数构造函数");
        }

       
    }


    class CWDBHelperGeneric <T,W,K>
    {
        public CWDBHelperGeneric(T a, W b, K c)
        {
            Console.WriteLine("调用带参数的泛型构造函数");
        }

        public CWDBHelperGeneric()
        {
            Console.WriteLine("调用泛型构造函数");
        }

        public void GenericTest<A, B, C>( A a,B b,C c)
        {
            Console.WriteLine(a.ToString() + b.ToString()+ c.ToString()) ;
        }
    }
}
