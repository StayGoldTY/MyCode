using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MVC5.Controllers
{
    public class UsersController : ApiController
    {
        /// <summary>
        /// 12312312
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        [HttpGet]
        public string GetUserByName(string username)
        {
            return username;
        }
        [Route("api/users/{userName}/v2")]
        //restful风格示例
        public string Get(string userName)
        {
            return "Superman";
        }

        public string Post([FromBody] Users value)
        {
            
            return value.UserEmail;
        }
        public class Users
        {
            public int UserID { get; set; }

            public string UserName { get; set; }

            public string UserEmail { get; set; }

            public DateTime Birthday { get; set; }
        }
        [Route("api/users/{id}")]
        public string  Put(int id, [FromBody] Users value)
        {
            return value.UserName;
        }
        [Route("api/users/{id}")]
        // DELETE api/values/5
        public string Delete(int id)
        {
            return "Delete Success";
        }
    }
}
