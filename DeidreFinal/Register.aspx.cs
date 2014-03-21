using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Data;
using System.Data.SqlClient;
using DAL_Project;

namespace DeidreFinal
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtfName.Text = "";
            txtlName.Text = "";
            txtAddress.Text = "";
            txtCity.Text = "";
            ddProvince.Text = "Select one";
            txtPostCode.Text = "";
            txtPhone.Text = "";
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtConfirm.Text = "";
            txtEmail.Text = "";
            ddSecurity.Text = "Please select one...";
            txtSecurityAnswer.Text = "";
            cbxConfirm.Checked = false;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                dal.AddParam("@fName", txtfName.Text);
                dal.AddParam("@lName", txtlName.Text);
                dal.AddParam("@Address", txtAddress.Text);
                dal.AddParam("@City", txtCity.Text);
                dal.AddParam("@PostCode", txtPostCode.Text);
                dal.AddParam("@Province", ddProvince.Text);
                dal.AddParam("@Phone", txtPhone.Text);
                dal.AddParam("@UserName", txtUserName.Text);
                dal.AddParam("@UserPassword", txtPassword.Text);
                dal.AddParam("@Email", txtEmail.Text);
                dal.AddParam("@SecQuest", ddSecurity.Text);
                dal.AddParam("@SecAns", txtSecurityAnswer.Text);
                dal.ExecuteProcedure("spRegisterClientUser");

                /// <summary>
                /// Shows a Message saying that they are registered, 
                /// that they will receive  an e-mail and they will be redirected to the Sign In page
                /// </summary>
                if (cbxConfirm.Checked)
                {
                    SendEmailMessage();
                }

            }
            catch (Exception ex)
            {
                lblStatus.Text = "Send Email Failed. " + ex.Message;
            }
            finally
            {
                pnlRegTitle.Visible = false;
                pnlClientUserReg.Visible = false;
                pnlRegConfirm.Visible = true;
            }
        }

        private void SendEmailMessage()
        {
           MailMessage message = new MailMessage();
            message.From = new MailAddress("deidre.steenman@robertsoncollege.net");
            message.To.Add(new MailAddress(txtEmail.Text));
            message.Subject = "Congratulations, you are Registered.";
            message.Body = "Welcome to The Art Farm!\n Your user name is: " + txtUserName.Text + " \n Your password is: " + txtPassword.Text + "\n\nPlease sign in to continue.";

            SmtpClient client = new SmtpClient();
            client.Host = "smtp.gmail.com";
            client.Port = 587;
            client.EnableSsl = true;
            client.Credentials = new System.Net.NetworkCredential("deidre.steenman@robertsoncollege.net", "robertson1");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Send(message);
        }

        protected void txtPostCode_TextChanged(object sender, EventArgs e)
        {

        }

       
    }
}