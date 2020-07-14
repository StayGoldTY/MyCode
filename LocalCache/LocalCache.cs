using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Text;
using System.Threading.Tasks;

namespace LocalCache
{
    class LocalCache
    {
      //  MemoryCache mc = new MemoryCache("1");

       public static  Dictionary<string, Object> dso =null;
        public LocalCache()
        {
            dso = new Dictionary<string, object>();
            Console.WriteLine("开始创建缓存");
        }

        public static void Add(string s,object o)
        {
            dso.Add(s,o);
        }

        public static void Upddate(string s, object o)
        {
            dso[s] = o;
        }

        public static bool Exist(string s, object o)
        {
            if (dso.ContainsKey(s))
            {
                return true;
            }
            return false;
        }

        public static object GetValue(string s, object o)
        {
            return dso[s];
        }
    }
}
