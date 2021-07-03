using FarmSystem.App_Global;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FarmSystem.Controllers
{
    public class UploadController : Controller
    {
        public String UploadFile()
        {
            string imgPath = AppGlobal.uploadPath;
            HttpFileCollectionBase files = Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFileBase file = files[i];
                string fname, returnName;
                if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                {
                    string[] testfiles = file.FileName.Split(new char[] { '\\' });
                    fname = testfiles[testfiles.Length - 1].Replace(' ', '-');
                }
                else
                    fname = file.FileName.Replace(' ', '-');
                returnName = (imgPath + fname);
                fname = Path.Combine(imgPath, fname);
                file.SaveAs(fname);
                return file.FileName.Replace(' ', '-');
            }
            return "";
        }

        public void DeleteFile(string filename, string type)
        {
            try
            {
                if (!string.IsNullOrEmpty(filename))
                {
                    string path = "";
                    switch (type)
                    {
                        case "image": path = AppGlobal.uploadPath; break; 
                    }
                    string file = Path.Combine(path, filename); // lay ra full path cua hinh
                    if (System.IO.File.Exists(file))  // kiem tra xem trong thu muc chua hinh co file hinh can xoa ko
                        System.IO.File.Delete(file);   //neu co, thi xoa hinh
                }
            }
            catch (Exception ex)
            {
            }
        }

    }
}