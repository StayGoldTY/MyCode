using SOPWeb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace SOPWeb.Remote
{
    // 注意: 使用“重构”菜单上的“重命名”命令，可以同时更改代码和配置文件中的接口名“IMyWcf”。
    [ServiceContract] //这些都是必须标记的才能现实
    public interface IMyWcf
    {
        [OperationContract] //这些都是必须标记的才能现实
        void DoWork();

        [OperationContract] //这些都是必须标记的才能现实
        List<Student> GetUserList(int id);
    }
}
