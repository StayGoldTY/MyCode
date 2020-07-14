using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace SocketService
{
    class Program
    {
        static void Main(string[] args)
        {
            int port = 2018;
            string host = "127.0.0.1";

            IPAddress ip = IPAddress.Parse(host);
            IPEndPoint ipe = new IPEndPoint(ip, port);

            Socket sSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            sSocket.Bind(ipe);
            sSocket.Listen(0);
            Console.WriteLine("监听已经打开，请等待");

            //收到消息  接受一个socket链接
            Socket serverSocket = sSocket.Accept();
            Console.WriteLine("连接已经建立。。。");
            while (true)
            {
                string recStr = "";
                byte[] recByte = new byte[4096];
                int bytes = serverSocket.Receive(recByte, recByte.Length, 0);
                recStr += Encoding.ASCII.GetString(recByte, 0, bytes);
                Console.WriteLine("服务器端获得信息:{0}", recStr);

                if (recStr.Equals("stop"))
                {
                    serverSocket.Close();//关闭该socket对象
                    Console.WriteLine("关闭链接。。。。");
                    break;
                }

                //回发消息
                Console.WriteLine("请输入回发消息。。。。");
                string sendStr = Console.ReadLine(); //"send to client :hello world";
                byte[] sendByte = Encoding.ASCII.GetBytes(sendStr);
                serverSocket.Send(sendByte, sendByte.Length, 0);

            }
            sSocket.Close();//关闭server监听
        }
    }
}
