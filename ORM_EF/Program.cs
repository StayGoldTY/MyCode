using ORM_EF.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ORM_EF
{
    class Program
    {
        static void Main(string[] args)
        {
            //DBFirst
            DS_TCategory dS_TCategory = new DS_TCategory();
            dS_TCategory.CategoryName = "testname";
            dS_TCategory.Description = "testDescription";
            dS_TCategory.QCount = 2;
            dS_TCategory.Show1 = 3;
            TYDBEntities2 tYDBEntities2 = new TYDBEntities2();
            //增加
            tYDBEntities2.DS_TCategory.Add(dS_TCategory);
            tYDBEntities2.Entry<DS_TCategory>(dS_TCategory).State = System.Data.Entity.EntityState.Added;
            tYDBEntities2.SaveChanges();
            //删除
            tYDBEntities2.DS_TCategory.Remove(dS_TCategory);
            tYDBEntities2.Entry<DS_TCategory>(dS_TCategory).State = System.Data.Entity.EntityState.Deleted;
            tYDBEntities2.SaveChanges();

            //查询
            DS_TCategory result = tYDBEntities2.DS_TCategory.FirstOrDefault(u=>u.CategoryID==1);
            DS_TCategory result2 = tYDBEntities2.DS_TCategory.Find(1);//及时查询

            var result3 = tYDBEntities2.DS_TCategory.Where(u=>u.CategoryID>0&&u.CategoryName =="123");//延迟查询

            tYDBEntities2.Entry<DS_TCategory>(dS_TCategory).State = System.Data.Entity.EntityState.Detached;
            tYDBEntities2.SaveChanges();
            //修改
           // tYDBEntities2.Entry<DS_TCategory>(dS_TCategory).State = System.Data.Entity.EntityState.Modified;
            DS_TCategory resulttest = tYDBEntities2.DS_TCategory.FirstOrDefault(u => u.CategoryID == 1);
            resulttest.CategoryName += "test";

            tYDBEntities2.SaveChanges();
          //  var  result =  tYDBEntities2.DS_TCategory.Find(2);
          //  Console.WriteLine(result.CategoryID);

            var dS_TCategoryList = from l in tYDBEntities2.DS_TCategory
                                   where l.CategoryID > 0
                                   select l;




            //ModelFirst
            ModelFIrst modelFIrst = new ModelFIrst();
            ModelFirstTwo modelFirstTwo = new ModelFirstTwo();
            modelFIrst.Name = "modelFIrst1";
            System.TimeSpan a = new TimeSpan();
            modelFirstTwo.ModelFIrst = modelFIrst;
            modelFIrst.Time1 = a;
            tYDBEntities2.ModelFirstTwoes.Add(modelFirstTwo);
            tYDBEntities2.SaveChanges();
            Console.ReadKey();
        }
    }
}
