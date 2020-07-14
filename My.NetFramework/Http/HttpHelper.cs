using My.NetFramework.Log;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace My.NetFramework
{
    public class HttpHelper
    {
        private static Logger logger = new Logger(typeof(HttpHelper));
        /// <summary>
        /// 下载html
        /// http://tool.sufeinet.com/HttpHelper.aspx
        /// HttpWebRequest功能比较丰富，WebClient使用比较简单
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static string DownloadHtml(string url)
        {
            string html = string.Empty;
            try
            {
                //logger.Info($"准备下载{url}");
                //HttpClient
                HttpWebRequest request = HttpWebRequest.Create(url) as HttpWebRequest;//模拟请求

                request.Timeout = 30 * 1000;//设置30s的超时
                request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.146 Safari/537.36";//pc浏览器
                //request.UserAgent = "Ruanmou Crawler";
                //request.UserAgent = "Mozilla / 5.0(iPhone; CPU iPhone OS 7_1_2 like Mac OS X) App leWebKit/ 537.51.2(KHTML, like Gecko) Version / 7.0 Mobile / 11D257 Safari / 9537.53";//移动端浏览器

                request.ContentType = "text/html; charset=utf-8";// "text/html;charset=gbk";// 
                //request.Host = "www.jd.com";//下载列表页会失败
                //request.Host = "list.jd.com";//下载首页各种重定向了

                request.Headers.Add("Cookie", @"cn=0; PCSYCityID=country_2468; ipLoc-djd=1-72-4137-0; areaId=1; __utmz=122270672.1530789088.1.1.utmcsr=jd.com|utmccn=(referral)|utmcmd=referral|utmcct=/allSort.aspx; __jdu=1957366719; __jdc=122270672; __jda=122270672.1957366719.1514372943.1530797595.1531228930.41; __jdv=122270672|direct|-|none|-|1531228929954; shshshfp=791d14b02815ff33778645f7f03b29a7; shshshfpa=efdb8e46-0176-54fa-d171-4f30dc418245-1531228931; shshshfpb=1df7be2ebad154490a065100f177a4b8115c30096607aa4d25af3b06a7; shshshsID=0eef0493cd56e4160ab6889a9393bf17_1_1531228931887; 3AB9D23F7A4B3C9B=H3JLPASCJSTRFFU3TH36OE6N7NCRSZ3VTB5GKZJGEKJA6AN632D32SJPD5724MXMI6TQHGSRNNEDHM6Q56NXE5VN3Q; listck=61b15b6e5bb494c72e8de7ebdd1f83fc; __jdb=122270672.6.1957366719|41.1531228930");

                //request.Headers.Add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                //request.Headers.Add("Accept-Encoding", "gzip, deflate, sdch");
                //request.Headers.Add("Referer", "http://list.yhd.com/c0-0/b/a-s1-v0-p1-price-d0-f0-m1-rt0-pid-mid0-kiphone/");
                request.Method = "GET";
                //Encoding enc = Encoding.GetEncoding("GB2312"); // 如果是乱码就改成 utf-8 / GB2312

                //int sort = 2;//人数
                //string dataString = string.Format("k={0}&n=24&st={1}&iso=0&src=1&v=4093&p={2}&isRecommend=false&city_id=0&from=1&ldw=1361580739", keyword, sort, 1);
                //Encoding encoding = Encoding.UTF8;//根据网站的编码自定义  
                //byte[] postData = encoding.GetBytes(dataString);
                //request.ContentLength = postData.Length;
                //Stream requestStream = request.GetRequestStream();
                //requestStream.Write(postData, 0, postData.Length);

                Encoding enc = Encoding.UTF8;//.GetEncoding("GB2312");
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)//发起请求
                {
                    if (response.StatusCode != HttpStatusCode.OK)
                    {
                        logger.Warn(string.Format("抓取{0}地址返回失败,response.StatusCode为{1}", url, response.StatusCode));
                    }
                    else
                    {
                        try
                        {
                            StreamReader sr = new StreamReader(response.GetResponseStream(), enc);
                            html = sr.ReadToEnd();//读取数据
                            sr.Close();
                        }
                        catch (Exception ex)
                        {
                            logger.Error(string.Format($"DownloadHtml抓取{url}失败"), ex);
                            html = null;
                        }
                    }
                }
            }
            catch (System.Net.WebException ex)
            {
                if (ex.Message.Equals("远程服务器返回错误: (306)。"))
                {
                    logger.Error("远程服务器返回错误: (306)。", ex);
                    html = null;
                }
            }
            catch (Exception ex)
            {
                logger.Error(string.Format("DownloadHtml抓取{0}出现异常", url), ex);
                html = null;
            }
            return html;
        }
    }
}
