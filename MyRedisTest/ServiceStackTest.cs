using Redis.Seivice;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace MyRedisTest
{
    class ServiceStackTest
    {
        public static void Show()
        {
            using (RedisStringService service = new RedisStringService() )
            {
                service.Set<string>("ty","123");
                Console.WriteLine(service.Get("ty"));

                service.Append("ty","132");
                Console.WriteLine(service.Get("ty"));

                service.GetAndSetValue("ty", "1224");
                Console.WriteLine(service.Get("ty"));

                service.Set<int>("tty",2,DateTime.Now.AddSeconds(1));
                Thread.Sleep(2100);
                Console.WriteLine(service.Get("tty"));

                service.Set<int>("age", 29);
                Console.WriteLine(service.Incr("age"));
                Console.WriteLine(service.IncrBy("age",3));
                Console.WriteLine(service.Decr("age"));
                Console.WriteLine(service.DecrBy("age", 3));
                Console.ReadKey();
            }

            using (RedisHashService service = new RedisHashService())
            {
                service.SetEntryInHash("tyhash", "1","123");
                service.SetEntryInHash("tyhash", "2", "1234");
                service.SetEntryInHash("tyhash", "3", "12345");
                Console.WriteLine(service.GetHashKeys("tyhash"));
                Console.WriteLine(service.GetValueFromHash("tyhash", "3"));

                Console.ReadKey();
            }
            //set类的集合主要特点是去重复的集合
            using (RedisSetService service = new RedisSetService())
            {
                service.FlushAll();
                service.Add("tySet", "1");
                service.Add("tySet", "12");
                service.Add("tySet", "123");
                service.Add("tySet", "1234");

                service.Add("tySet1", "12");
                service.Add("tySet1", "123");
                service.Add("tySet1", "1234");
                //set集合也进行交叉并补等相关操作
                var result1 = service.GetDifferencesFromSet("tySet", "tySet1");

                Console.WriteLine(service.GetAllItemsFromSet("tySet"));

               
                Console.ReadKey();
            }
            //zset相比set最主要的特点是有序的 
            using (RedisZSetService service = new RedisZSetService())
            {
                service.FlushAll();
                service.Add("tySet", "1");
                service.Add("tySet", "12");
                service.Add("tySet", "123");
                service.Add("tySet", "1234");

                service.Add("tySet1", "12");
                service.Add("tySet1", "123");
                service.Add("tySet1", "1234");

                service.AddItemToSortedSet("tysort","1",1);
                service.AddItemToSortedSet("tysort", "2", 2);
                service.AddItemToSortedSet("tysort", "3", 3);
                var result3 = service.GetAllWithScoresFromSortedSet("tysort");
                Console.ReadKey();
            }

            using (RedisListService service = new RedisListService())
            {
                service.Add("tyList","a");
                service.Add("tyList", "b");
                service.Add("tyList", "c");
                service.Add("tyList", "d");
                service.Add("tyList", "e");

                //可以按照添加顺序自动排序 ，也可以分页查找
                var result1 = service.Get("tyList");
                var result2 = service.Get("tyList",0,3);

                //用List实现栈
                for (int i = 0; i < 5; i++)
                {
                    Console.WriteLine(service.PopItemFromList("tyList"));
                    var result3 = service.Get("tyList");
                }

                //实现队列：生产者，消费者模型 
                service.FlushAll();
                service.RPush("tyList", "a");
                service.RPush("tyList", "b");
                service.RPush("tyList", "c");
                service.RPush("tyList", "d");
                service.RPush("tyList", "e");
                Console.ReadKey();
            }

     
        }

        private static bool IsGoOn = true;//秒杀系统是否继续
        public static void SpeedKillSystem()
        {
            RedisStringService service1 = new RedisStringService();
            service1.Set<int>("Stock",15);
            for (int i = 0; i < 100; i++)
            {
                int k = i;
                Task.Run(() => {
                    using (RedisStringService service = new RedisStringService())
                    { 
                        if (IsGoOn)
                        {
                            long index = service.Decr("Stock");
                            if (index >= 0)
                            {
                                Console.WriteLine($"{k}秒杀成功");
                            }
                            else
                            {
                                IsGoOn = false;
                                Console.WriteLine($"{k}秒杀成功");
                            }
                        }
                        else
                        {

                            Console.WriteLine($"{k}秒杀失败，秒杀系统结束");
                        }
                    }
                });
            }
        }
    }
}
