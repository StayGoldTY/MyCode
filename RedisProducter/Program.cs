using Redis.Seivice;
using ServiceStack.Redis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace RedisProducter
{
    class Program
    {
        static void Main(string[] args)
        {
            //这种写法不能向Redis里面写
            //using (RedisListService service = new RedisListService())
            //{
            //  //  service.FlushAll();
            //    List<string> listint = new List<string>();
            //    for (int i = 0; i < 1000; i++)
            //    {
            //        listint.Add($"任务{i}");
            //    }
            //    ParallelOptions po = new ParallelOptions();
            //    po.MaxDegreeOfParallelism = 10;//可以用ParallelOptions来控制最大的线程数量
            //    Parallel.ForEach(listint, po, i => { Thread.Sleep(100); });
            //}

            //生产者消费者模式。即是类似MQ的处理
            //string path = AppDomain.CurrentDomain.BaseDirectory;
            //string tag = path.Split('/', '\\').Last(s => !string.IsNullOrEmpty(s));
            //Console.WriteLine($"这里是 {tag} 启动了。。");
            //Task.Run(() =>
            //{
            //    int k = 1;
            //    while (true)
            //    {
            //        using (RedisListService service = new RedisListService())
            //        {

            //            service.RPush("ty",  $"{tag}{k}号已经进入链表1");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表2");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表3");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表4");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表5");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表6");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表7");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表8");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表9");
            //            service.RPush("ty",  $"{tag}{k}号已经进入链表0");
            //            Thread.Sleep(100);
            //        }
            //        k++;
            //    }
            //}
            //);

            Show();
            using (RedisListService service = new RedisListService())
            {
                service.FlushAll();
                //订阅后每次publish后都会出发订阅中的 方法
                service.Publish("SubscribeTY","1");
                service.Publish("SubscribeTY", "2");
                service.Publish("SubscribeTY", "4");

                service.Publish("SubscribeTTY", "1");
            }
            

                Console.ReadKey();
        }

        //redis发布---订阅实现：观察者，一个数据源，多个接收者，只要订阅了就可以接收到
        public static void Show()
        {
            Task.Run(() =>
            {
                using (RedisListService service = new RedisListService())
                {
                    service.Subscribe("SubscribeTY", (c, message, iRedisSubscription) =>
                         {
                             Console.WriteLine($"注册{1}{c}:{message}，Dosomething else");
                             if (message.Equals("exit"))
                                 iRedisSubscription.UnSubscribeFromChannels("SubscribeTY");
                         }
                        );
                }
            }
            );

            Task.Run(() =>
            {
                using (RedisListService service = new RedisListService())
                {
                    service.Subscribe("SubscribeTY", (c, message, iRedisSubscription) =>
                     {
                         Console.WriteLine($"注册{2}{c}:{message}，Dosomething else");
                         if (message.Equals("exit"))
                             iRedisSubscription.UnSubscribeFromChannels("SubscribeTY");
                     }
                         );
                }
            }
            );
            Task.Run(() =>
            {
                using (RedisListService service = new RedisListService())
                {
                    service.Subscribe("SubscribeTTY", (c, message, iRedisSubscription) =>
                    {
                        Console.WriteLine($"注册{3}{c}:{message}，Dosomething else");
                        if (message.Equals("exit"))
                            iRedisSubscription.UnSubscribeFromChannels("SubscribeTY");
                    }
                        );
                }
            }
            );
        }




    }

    
}
