using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Unity;

namespace AOP.UnityWay
{
    class UnityConfigAOP
    {
        public static void Show()
        {
            IUnityContainer container = new UnityContainer();
            container.RegisterType<IRegUser, RegUserClass>();
            IRegUser regUser = container.Resolve<IRegUser>();
            regUser.RegShow();
        }
    }
}
