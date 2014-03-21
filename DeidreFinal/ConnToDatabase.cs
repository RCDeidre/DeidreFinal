using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace DeidreFinal
{
    public static class ConnToDatabase
    {
        static string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        public static DAL_Project.DAL dal = new DAL_Project.DAL(connString);
    }
}
