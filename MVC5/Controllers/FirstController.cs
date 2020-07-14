using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVC5.Controllers
{
    public class Student
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }

    public class FirstController : Controller
    {
        Student student = new Student {  ID = 1, Name = "ty"   };

        // GET: First
        public ActionResult Index()
        {
            ViewData["test"] = "ty";
            ViewBag.abc = "abc";
            TempData["yigeren"] = "yigeren";
            return View(student);
        }
        /// <summary>
        ///   /First/IndexId/4  id是路由解析出来的，只有id参数可以这样
        ///   /First/IndexId?id=3 url地址传递参数
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>

        public ViewResult IndexId(int id)
        {
            return View();
        }

        public ViewResult IndexName(int iName)
        {
            return View();
        }

        public ViewResult IndexIdNull(int? id)
        {
            return View();
        }

        public string ReturnString(string Name)
        {
            return Name;
        }

        public JsonResult ReturnJsonResult(int id,string name)
        {
            return new JsonResult { 
                Data = new { 
                    Id = id,
                    Name = name
                },
                 JsonRequestBehavior = JsonRequestBehavior.AllowGet
        };
           
        }

    }
}