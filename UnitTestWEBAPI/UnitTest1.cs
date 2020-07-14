using System;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.SelfHost;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UnitTestWEBAPI
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            //string url = "/api/users/1";
            //HttpClientHandler httpClientHandler = new HttpClientHandler();
            ////用HttpClient来在后端调用webapi
            //using (var http = new HttpClient(httpClientHandler))
            //{
            //    var result = http.GetAsync(url).Result;
            //}

            //webapi的自宿主---可以把webapi挂到其他地方，不用依赖iis
            HttpSelfHostConfiguration config = new HttpSelfHostConfiguration("https://localhost:44391");
            config.Routes.MapHttpRoute(

                name: "API",

                routeTemplate: "api/{controller}/{id}",
                 
                defaults: new { id = RouteParameter.Optional });

            using (HttpSelfHostServer server = new HttpSelfHostServer(config))

            {

                server.OpenAsync().Wait();

                Console.WriteLine("Web API is started now");

                Console.ReadLine();
            }

        }
    


    }
}
