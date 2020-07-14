using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace MVC5
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            //忽略路由，因为之前的网站都是webform的aspx结尾的后缀，再iis6之前都是根据后最来转发请求的，mvc出现后就没有后最了，但是iis6之前的应用程序还是把所有的mvc请求
            //加上一个.axd后缀来转发。后面到iis7就不需要这样了，遇到了直接忽略，还是走原始流程
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
