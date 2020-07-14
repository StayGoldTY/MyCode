using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MVC5.Controllers
{
    //[RoutePrefix("api/Values/")] //action就可以去掉这个前缀，让所有的前缀由这个RoutePrefix来指定
    //如果不要某个方法，可以在路由前面价格~ ：[Route("~Route(~api/Values/{id})")]
    public class ValuesController : ApiController
    {

        //在mvc中的webapi是如何找到对应的方法的
        //如果是直接在浏览器中输入地址进行访问，默认是访问get请求。
        //如果名字里不是以Get开头的话，在方法上面加上[HttpGet]特性访问即可
        //其次是安装参数找到最吻合的条件

        // GET api/values
        [Route("api/values/v2")] //特性路由可以满足不是特定的http请求的四种方法，可以支持自定义的uri地址
        public IEnumerable<string> Get3()
        {
            return new string[] { "value1", "value2" };
        }
        [HttpGet]
        public IEnumerable<string> Get1()
        {
            return new string[] { "value2", "value3" };
        }

        // GET api/values/5
        [Route("api/values/{id:int}/v2")] //可以直接对对应的类型进行约束，来让浏览器进行选择到底执行那个方法
        public string Get(int id)
        {
            return "value";
        }

        //[Route("api/values/{name:string?}/v2")]//可以用？来标识可空
        //[Route("api/values/{name:string = 'name'}/v2")]//可以是有默认值的

        [Route("api/values/{name:int}/v2")]
        public string Get12(int name)
        {
            return "value";
        }
        //多参数的路由
        [Route("api/values/{id:int}/name/{name:int}/type/{type:int}")]
        public string Get(int id,int name,int type)
        {
            return "value123";
        }

        // POST api/values
        public void Post([FromBody] string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id,[FromUri] string value)
        {
        }
    }
}
