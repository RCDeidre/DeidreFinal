using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;


namespace DeidreFinal
{
    public partial class FinalMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookieClientID = Request.Cookies["StaySignedInClientID"];//Gets the cookie
            HttpCookie cookieSecurity = Request.Cookies["StaySignedInSecurityLevel"];
            pnlSignedOut.Visible = false;
            pnlSignedIn.Visible = false;
            lbnAdmin.Visible = false;
            lbnStore.Visible = false;
            lbnMembers.Visible = false;
            /* If the cookie is not expired and the Session is empty
             * puts the value of the cookie into the Session*/
            if (cookieSecurity != null && Session["SecurityLevel"] == null)
            {
                Session["SecurityLevel"] = cookieSecurity.Value;
            }
            if (cookieClientID != null && Session["ClientID"] == null)
            {
                Session["ClientID"] = cookieClientID.Value;
            }

            if (Session["ClientID"] != null)
            {
               

                pnlSignedOut.Visible = true;
                

                if (Session["SecurityLevel"] != null && Session["SecurityLevel"].ToString() == "2")
                {
                    lbnAdmin.Visible = true;
                    lbnMembers.Visible = false;
                    lbnStore.Visible = false;
                }
            }

        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
               Session["SignedIn"] = "User";
               DataSet ds = new DataSet();
               DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
               d.AddParam("@UserName", txtUserName.Text);//@UserName will compare value txtUserName.Text
               d.AddParam("@Password", txtPassword.Text);//@Password will compare value txtPassword.Text
               ds = d.ExecuteProcedure("spSignIn");
               lbnStore.Visible = true;
               lbnMembers.Visible = true;

               if (ds.Tables[0].Rows.Count > 0)
               {
                   Session["ClientID"] = ds.Tables[0].Rows[0]["ClientID"].ToString();
                   Session["SecurityLevel"] = ds.Tables[0].Rows[0]["SecurityLevel"].ToString();
                   Session["UserName"] = ds.Tables[0].Rows[0]["UserName"].ToString();
                   Session["Password"] = ds.Tables[0].Rows[0]["UserPassword"].ToString();
                                      

                   if (Session["SecurityLevel"].ToString() == "2")
                   {
                       
                       lbnAdmin.Visible = true;
                       ancorLogin.Visible = false;
                       lbnStore.Visible = false;
                       lbnMembers.Visible = false;
                   }

                   if (chxStaySignedIn.Checked)
                   {
                       HttpCookie myCookieAdm = new HttpCookie("StaySignedInClientID");
                       myCookieAdm.Value = Session["ClientID"].ToString();
                       myCookieAdm.Expires = DateTime.Now.AddDays(2);
                       Response.Cookies.Add(myCookieAdm);

                       HttpCookie myCookieReg = new HttpCookie("StaySignedInSecurityLevel");
                       myCookieReg.Value = Session["SecurityLevel"].ToString();
                       myCookieReg.Expires = DateTime.Now.AddDays(2);
                       Response.Cookies.Add(myCookieReg);
                   }
               }

               else
               {
                   lblErrorSignIn.Text = "INCORRECT USERNAME AND PASSWORD!";
               }
               lblYouAre.Text = "Welcome " + txtUserName.Text;
               pnlSignedOut.Visible = true;
               
            }
        

        protected void ancorLogin_Click(object sender, EventArgs e)
        {
            pnlSignedIn.Visible = true;
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            pnlSignedIn.Visible = true;
            pnlSignedOut.Visible = false;
            lbnAdmin.Visible = false;
            Response.Redirect("Home.aspx");

            HttpCookie cookieAdm = Request.Cookies["StaySignedInAdm"];
            HttpCookie cookieReg = Request.Cookies["StaySignedInReg"];
            if (cookieAdm != null)
            {
                cookieAdm.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookieAdm);
            }
            if (cookieReg != null)
            {
                cookieReg.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookieReg);
            }
        }

        protected void lbnMembers_Click(object sender, EventArgs e)
        {
            if (Session["ClientID"] != null)
            {
                Response.Redirect("YourPlace.aspx");
            }
            else
            {
                lblNotSignedIn.Text = "You needed to be signed in to access the Members Page!";
            }
        }
               
   }
        

}


