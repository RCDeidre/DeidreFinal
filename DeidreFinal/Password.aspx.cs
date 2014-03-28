using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace DeidreFinal
{
    public partial class Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtEmail.Text = GetEmailAddress();
        }

        private string GetEmailAddress()
        {
            DataSet ds = new DataSet();
            string clientId = (string)Session["ClientID"];
            DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
            d.AddParam("@ClientID", clientId);
            ds = d.ExecuteProcedure("spGetEmail");
            return ds.Tables[0].Rows[0]["Email"].ToString();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                d.AddParam("@UserName", txtUserName.Text);
                d.AddParam("@UserPassword", txtPassword.Text);
                d.AddParam("@NewPassword", txtNewPassword.Text);
                d.ExecuteProcedure("spUserPasswordUpdate");

                /// Shows a Message saying that the password has been updated and 
                /// that they will receive an e-mail. 
                /// </summary>
                if (cbxConfirm.Checked)//only if the cbxConfirm is checked will it send an e-mail confirming Password update
                {
                    SendEmailMessage(); //uses this method to send an e-mail confirming Password update
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Send Email Failed. " + ex.Message;//if there is an error the label will display it
            }
            finally
            {
                pnlChangePassword.Visible = false;//panel changes so you can't see it
                pnlPassUpdateConfirm.Visible = true;//panel changes so you can see it
                Session.Abandon();//abandons the Session
                Panel p1 = (Panel)Master.FindControl("pnlSignedIn");//Finds the pnlSignedOut on the MasterPage
                p1.Visible = true;//panel changes so you can see it
                Panel p2 = (Panel)Master.FindControl("pnlSignedOut");//Finds the  pnlSignedIn on the MasterPage 
                p2.Visible = false;//panel changes so you can't see it
            }
        }

        private void SendEmailMessage()
        {
            MailMessage message = new MailMessage();
            message.From = new MailAddress("deidre.steenman@robertsoncollege.net");
            message.To.Add(new MailAddress(txtEmail.Text));
            message.Subject = "Congratulations, you are Updated.";
            message.Body = "You have successfully updated your Password.\n Your user name is: " + txtUserName.Text + " \n Your new password is: " + txtNewPassword.Text + "\n\nPlease sign in to continue.";

            SmtpClient client = new SmtpClient();
            client.Host = "smtp.gmail.com";
            client.Port = 587;
            client.EnableSsl = true;
            client.Credentials = new System.Net.NetworkCredential("deidre.steenman@robertsoncollege.net", "robertson1");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Send(message);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirm.Text = "";
            cbxConfirm.Checked = false;
            txtEmail.Text = "";
        }
    }
}