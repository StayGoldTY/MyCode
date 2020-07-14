using AOP.UnityWay;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AOP
{
    class Program
    {
        static void Main(string[] args)
        {
            // CastleProxyAOP.Show(); // Castle方式调用的方法要求是virtual类型的
            UnityConfigAOP.Show();
            Console.ReadKey();
        }
    }
}
