using System;
using System.Security.AccessControl;
using Microsoft.VisualStudio.TestTools.UnitTesting;


namespace UnitTestProject1
{
    [TestClass]
    public class UnitWebservice
    {
        [TestMethod]
        public void TestMethod1()
        {
            using (WebserviceTest.WebService1SoapClient service1SoapClient = new WebserviceTest.WebService1SoapClient())
            {
                var resule =  service1SoapClient.HelloWorld();

                var resule2 = service1SoapClient.Puls();
            }
        }
    }
}
