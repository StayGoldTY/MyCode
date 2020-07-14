using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace WebServiceSudy.Remote
{
    /// 安全问题：
    /// 1 内部使用，不存在
    /// 2 Form  windows身份
    /// 3 加个参数，token 定时更新+沟通
    /// 4 SoapHeader
    /*
        一.通过集成windows身份验证

       通过集成windows方式解决webservice的安全问题是一个很简洁,并且行之有效的解决方案,该方案的优点是比较安全，性能较好，当然因为与windows紧密的结合到了一起,缺点自然也很明显了,第一,不便于移植，第二,要进行相关的配置部署工作(当然我们也可以用代码来操作IIS,只不过比较麻烦,最近一直做自动化部署,所以一讲到配置马上就会联想到怎么去自动部署)

       具体怎么做呢?

       服务器端:配置IIS虚拟目录为集成windows身份验证

       客户端:

       Service1 wr = new Service1(); //web service实例  

       wr.Credentials = new NetworkCredential("administrator","123"); //用户名密码  

       lblTest.Text = wr.Add(2,2).ToString(); //调用Add的 web service方法 

       二.使用 SoapHeader(SOAP 标头)自定义身份验证

           SoapHeader 多数情况下用来传递用户身份验证信息，当然它的作用远不止如此，有待于在实际应用中发掘,体可以实现哪些东西大家有想法可以留言一起交流.

           SoapHeader 使用步骤： 
       (1) 创建继承自 System.Web.WebServices.SoapHeader 的自定义 SoapHeader 类型。 
       (2) 在 WebService 中创建拥有 public 访问权限的自定义 SoapHeader 字段。 
       (3) 在需要使用 SoapHeader 的 WebMethod 上添加 SoapHeaderAttribute 访问特性。SoapHeaderAttribute 构造必须指定 memberName 参数，就是我们在第二步中申明的字段名称。 
       (4) 生成器会自动为客户端生成同名的自定义 SoapHeader 类型，只不过比起我们在 WebService 端创建的要复杂一些。同时还会为代理类型添加一个 soapheaderValue 属性。
        */


    /// <summary>
    /// WebService1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]//标记了WebMethod特性才能在服务器看到
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]//标记了WebMethod特性才能在服务器看到
        public int Puls()
        {
            return 55;
        }

       
    }
}
