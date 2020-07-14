﻿using Redis.Seivice;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace RedisConsumer
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory;
            string tag = path.Split('/', '\\').Last(s => !string.IsNullOrEmpty(s));
            Console.WriteLine($"这里是 {tag} 启动了。。");
            using (RedisListService service = new RedisListService())
            {
                Action act = new Action(()=>
                {
                    while (true)
                    {
                        var result = service.BlockingPopItemFromLists(new string[] {"ty" }, TimeSpan.FromHours(3));
                        Thread.Sleep(100);
                        Console.WriteLine($"这里是 {tag} 队列获取的消息 {result.Id},{result.Item}");
                    }
                }
                );
                act.EndInvoke(act.BeginInvoke(null, null));
            }
            Console.ReadKey();
        }
    }
}
