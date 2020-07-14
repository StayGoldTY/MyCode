using System;
using System.Security.AccessControl;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using UnitTestProject1.ServiceReference1;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitWCF
    {
        [TestMethod]
        public void TestMethod1()
        {
            using (MyWcfClient myWcfClient = new MyWcfClient())
            {
                var resule = myWcfClient.GetUserList(1);

                 myWcfClient.DoWork();

               
            }
            MyWcfClient myWcfClient1 = null;
            try
            {
                myWcfClient1 = new MyWcfClient();
                 var resule12 = myWcfClient1.GetUserList(1);
                myWcfClient1.Close();
            }
            catch
            {
                myWcfClient1.Abort();
            }

        }
    }
}
