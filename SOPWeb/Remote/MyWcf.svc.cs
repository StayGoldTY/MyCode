using SOPWeb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace SOPWeb.Remote
{
    // 注意: 使用“重构”菜单上的“重命名”命令，可以同时更改代码、svc 和配置文件中的类名“MyWcf”。
    // 注意: 为了启动 WCF 测试客户端以测试此服务，请在解决方案资源管理器中选择 MyWcf.svc 或 MyWcf.svc.cs，然后开始调试。
    public class MyWcf : IMyWcf
    {
        public void DoWork()
        {
            Console.WriteLine("123");
        }

        public List<Student> GetUserList(int id)
        {
            return new List<Student>()
            {
                new Student()
                {
                    ID = 123,
                    Name = "123"
                },
                new Student()
                {
                    ID = 123,
                    Name = "123"
                }
            };

        }
    }
}
