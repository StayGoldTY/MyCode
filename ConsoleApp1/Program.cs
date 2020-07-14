using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.Services;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            ConsoleApp1.WebReference.WebService1 cw = new ConsoleApp1.WebReference.WebService1();
            var a = cw.HelloWorld();
            object o1 = "Some String";

            object o2 = 5;

            string s1 = o1 as string;  //s1="Some String"

            string s2 = o2 as string;  //s2=null
            Console.WriteLine(s2);

            DataSet ds;
            ds = null;

            dog g = new dog();
            Console.WriteLine(g.ToString());

            threeToOne();



            Console.ReadKey();
        }

        //500个数逢三退一算法
        public static string threeToOne()
        {
            int[] arrTest = new int[500];
            //把500个数写道一个数组中去
            for (int i = 1; i < 501; i++)
            {
                arrTest[i-1] = i;
            }
            //先输出测试一下是否所有的数就是1到500
            foreach (var i in arrTest)
            {
                Console.Write(i);
            }

            //再进行对应的逢三退一算法
            //1.退一的操作的其实是每当下标+1能被三整除的时候就用这个下标+1后面的一个数来代替这个数本身的操作
            //for (int i = 0; i < 500; i++)
            //{
            //    %
            //    int a = i + 1;
            //    if (17 % 5 = 0)
            //    { 
                    
            //    }
            //}

            return "";
        }
    }

    class dog
    {
    int a = 0;
    }

    class cat
    { 
        
    }
        
}
