using My.NetFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyCrawler
{
    class Program
    {
        static void Main(string[] args)
        {
            HttpHelper.DownloadHtml("https://www.jd.com"); 
        }
    }
}
