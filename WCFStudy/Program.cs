using SOPWeb.Model;
using SOPWeb.Remote;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.Text;
using System.Threading.Tasks;

namespace WCFStudy
{
    class Program
    {
        static void Main(string[] args)
        {
            List<ServiceHost> hosts = new List<ServiceHost>()
            {
                new ServiceHost(typeof(MyWcf)),
              //  new ServiceHost(typeof(CalculatorService))
            };
            foreach (var host in hosts)
            {
                //拿到描述之后直接用反射来进行调用即可。
                host.Opening += (s, e) => Console.WriteLine($"{host.GetType().Name} 准备打开");
                host.Opened += (s, e) => Console.WriteLine($"{host.GetType().Name} 已经正常打开");
                host.Open();
            }
            Console.WriteLine("输入任何字符，就停止");
            Console.Read();
            foreach (var host in hosts)
            {
               
                host.Close();
            }
            Console.Read();

            #region MyRegion
            //using (ServiceHost host = new ServiceHost(typeof(MyWcf)))
            //{
            //    #region 程序配置
            //    host.AddServiceEndpoint(typeof(IMyWcf), new WSHttpBinding(), "http://127.0.0.1:9999/calculatorservice");
            //    if (host.Description.Behaviors.Find<ServiceMetadataBehavior>() == null)
            //    {
            //        ServiceMetadataBehavior behavior = new ServiceMetadataBehavior();
            //        behavior.HttpGetEnabled = true;
            //        behavior.HttpGetUrl = new Uri("http://127.0.0.1:9999/calculatorservice/metadata");
            //        host.Description.Behaviors.Add(behavior);
            //    }
            //    #endregion 程序配置
            //    host.Opened += (s, e) =>
            //    {
            //        Console.WriteLine("MathService已经启动，按任意键终止服务！");
            //    };

            //    host.Open();
            //    Console.Read();
            //}

            #endregion
        }
    }
}
