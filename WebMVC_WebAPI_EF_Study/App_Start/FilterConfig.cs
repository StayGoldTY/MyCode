using System.Web;
using System.Web.Mvc;

namespace WebMVC_WebAPI_EF_Study
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
