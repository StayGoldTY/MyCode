using Microsoft.Practices.Unity.Configuration;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Unity;
using Unity.Interception.ContainerIntegration;


namespace AOP
{
    /// <summary>
    /// 使用EntLib\PIAB Unity 实现动态代理
    /// 
    /// </summary>
    class AOPUnityConfig
    {
        public static void Show()
        {
            //配置UnityContainer
            IUnityContainer container = new UnityContainer();
            ExeConfigurationFileMap fileMap = new ExeConfigurationFileMap();
            fileMap.ExeConfigFilename = Path.Combine(AppDomain.CurrentDomain.BaseDirectory + "Unity.config");
            Configuration configuration = ConfigurationManager.OpenMappedExeConfiguration(fileMap, ConfigurationUserLevel.None);
            UnityConfigurationSection configSection = (UnityConfigurationSection)configuration.GetSection(UnityConfigurationSection.SectionName);
            configSection.Configure(container, "aopContainer");

            IRegUser regUser = container.Resolve<IRegUser>();
            regUser.RegShow();

            
        }
    }
}
