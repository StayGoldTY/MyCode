using Castle.DynamicProxy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace AOP
{
    /// <summary>
    /// 使用Castle\DynamicProxy 实现动态代理
    /// 方法必须是虚方法
    /// </summary>
    public class CastleProxyAOP
    {
        public static void Show()
        {
            ProxyGenerator pg = new ProxyGenerator();
            MyInterceptor mi = new MyInterceptor();
            RegUserClass ruc = pg.CreateClassProxy<RegUserClass>(mi);
            ruc.RegShow();
        }

        public class MyInterceptor : IInterceptor
        {
            public void Intercept(IInvocation invocation)
            {
                PreProceed(invocation);
                invocation.Proceed();
                PostProceed(invocation);
            }
            public void PreProceed(IInvocation invocation)
            {
                Console.WriteLine("方法执行前");
            }

            public void PostProceed(IInvocation invocation)
            {
                Console.WriteLine("方法执行后");
            }
        }
    }
}
