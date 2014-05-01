using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DeidreFinal
{
    /// <summary>
    /// Summary description for FinalHandler1
    /// </summary>
    public class FinalHandler1 : IHttpHandler
    {
        
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/Ariel";
            context.Response.Write("Your comment was: " + context.Request.Form["txtInputOne"]);
         }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}