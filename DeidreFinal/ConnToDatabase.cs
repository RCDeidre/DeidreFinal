using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DeidreFinal
{
    public class ConnToDatabase
    {
        public static SqlConnection conn = new SqlConnection(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
    }
}