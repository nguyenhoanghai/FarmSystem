using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FarmSystem.App_Global
{
    public static class AppGlobal
    {
        private static string _connectionstring;
        public static string Connectionstring
        {
            get
            {
                if (string.IsNullOrEmpty(_connectionstring))
                {
                    _connectionstring = Helper.GPRO_Helper.Instance.GetEntityConnectString();
                }
                return _connectionstring;
            }
        }

        private static SqlConnection _sqlConnection;
        public static SqlConnection sqlConnection
        {
            get
            {
                if (_sqlConnection == null)
                {
                    _sqlConnection = GPRO.Core.Hai.DatabaseConnection.Instance.Connect(HttpContext.Current.Server.MapPath("~/Config_XML") + "\\DATA.XML"); //Helper.GPRO_Helper.Instance.GetEntityConnectString();
                }
                return _sqlConnection;
            }
        }

        private static string _uploadPath;
        public static string uploadPath
        {
            get
            {
                if (_uploadPath == null)
                {
                    _uploadPath = HttpContext.Current.Server.MapPath("~/Upload") ;  
                }
                return _uploadPath;
            }
        }

         
    }
}