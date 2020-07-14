using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Runtime.Remoting.Proxies;
using System.Text;
using System.Threading.Tasks;

namespace AOP
{
    /// <summary>
    /// 这种方式真的牛逼，可以对所有的类型都添加前后的代码
    /// 但是实际的应用中很可能是对某一个模块或者所有dll里面的类都进行添加
    /// </summary>
    class RealProxyAOP
    {
        public static void Show1()
        {
            RegUserClass ruc = TransparentProxy.Create<RegUserClass>();
            ruc.RegShow();
        }

        public static void Show()
        {
            
        }
    }

    #region 使用真实代理必备函数
    /// <summary>
    /// 真实代理
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class MyRealProxy<T> : RealProxy
    {
        private T tTarget;
        public MyRealProxy(T target)
            : base(typeof(T))
        {
            this.tTarget = target;
        }

        public override IMessage Invoke(IMessage msg)
        {
            BeforeProceede(msg);

            IMethodCallMessage callMessage = (IMethodCallMessage)msg;
            object returnValue = callMessage.MethodBase.Invoke(this.tTarget, callMessage.Args);

            AfterProceede(msg);

            return new ReturnMessage(returnValue, new object[0], 0, null, callMessage);
        }
        public void BeforeProceede(IMessage msg)
        {
            Console.WriteLine("方法执行前可以加入的逻辑");
        }
        public void AfterProceede(IMessage msg)
        {
            Console.WriteLine("方法执行后可以加入的逻辑");
        }
    }

    /// <summary>
    /// 透明代理
    /// </summary>
    public static class TransparentProxy
    {
        public static T Create<T>()
        {
            T instance = Activator.CreateInstance<T>();
            MyRealProxy<T> realProxy = new MyRealProxy<T>(instance);
            T transparentProxy = (T)realProxy.GetTransparentProxy();
            return transparentProxy;
        }
    }
    #endregion

    #region 定义一个正常的需要被调用的类
    public interface IRegUser
    {
        void RegShow();
    }
    /// <summary>
    /// 必须继承自MarshalByRefObject父类，否则无法生成
    /// </summary>
    //public class RegUserClass : MarshalByRefObject,IRegUser
    //{
    //    public void RegShow()
    //    {
    //        Console.WriteLine("进行时");
    //    }
    //}

    public class ReggUserClassTwo : IRegUser
    {
        public ReggUserClassTwo()
        {
            Console.WriteLine("ReggUserClassTwo构造函数调用");
        }
        public void RegShow()
        {
            throw new NotImplementedException();
        }
    }

    public class RegUserClass : IRegUser
    {
        public RegUserClass(ReggUserClassTwo ruct)
        { 
            
        }
        public virtual void RegShow()
        {
            Console.WriteLine("进行时");
        }
    }

    #endregion
}
