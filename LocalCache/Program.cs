using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LocalCache
{
    class Program
    {
        static void Main(string[] args)
        {
           // LocalCache lc = new LocalCache();
           // Test(LocalCache.dso);
           // Test(LocalCache.dso);
            string a = Console.ReadLine();
            Console.WriteLine(a);
            Console.ReadKey();
        }

        public static int Show(int i)
        {
            Thread.Sleep(500);
           // Console.WriteLine(i.ToString());
            return i;
        }

        public static void Test(Dictionary<string, Object>  dso)
        {
            for (int i = 0; i < 5; i++)
            {
                if(LocalCache.Exist(i.ToString(),i))
                {
                    Console.WriteLine( LocalCache.GetValue(i.ToString(),i));
                }
                else
                {
                    int k = Show(i);

                    LocalCache.Add(i.ToString(),k);
                    Console.WriteLine(k.ToString());
                }

            }
        }

    }
}
