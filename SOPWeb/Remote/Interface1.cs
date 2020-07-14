using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace SOPWeb.Remote
{
    [ServiceContract(CallbackContract =typeof(ICallback))]
    interface Interface1
    {
        [OperationContract(IsOneWay =true)]
        int Plus(int x ,int y );
    }
}
