using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeidreFinal
{
    public partial class Admin : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ClientID"] == null)
            {
                Response.Redirect("Home.aspx");
            }
            pnlClientFields.Visible = false;
            try
            {
                lblIfNotDelete.Visible = false;//is not visible until Delete button is clicked  
                pnlEditingClient.Visible = false;//is not visible until Edit Button is Clicked

                if (!IsPostBack)
                {
                    BindData();//binds data if not a postback 
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong, Please try again later " + ex.Message;//Something goes wrong this label appears
            }
        }
        //Binds the data from the spClientSelect to the GridView
        private void BindData()
        {
            DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
            DataSet ds = new DataSet();
            ClientGridView.DataSource = d.ExecuteProcedure("spClientSelectAll");
            ClientGridView.DataBind();
        }
        //When the Delete button is clicked....
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                dal.AddParam("@ClientID", txtClientID.Text);
                dal.ExecuteProcedure("spClientDelete");
                Clearfields();//Clears all the fields
                BindData();//binds the data
                lblIfNotDelete.Visible = true;//turns this label on
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong " + ex.Message;//if something goes wrong this will fire
            }
        }
        //Makes all the fields enabled to have text inserted
        private void SetEnabled(bool bEnabled)
        {
            txtClientID.Enabled = bEnabled;
            txtfName.Enabled = bEnabled;
            txtlName.Enabled = bEnabled;
            txtAddress.Enabled = bEnabled;
            txtCity.Enabled = bEnabled;
            txtProvince.Enabled = bEnabled;
            txtPostCode.Enabled = bEnabled;
            txtPhone.Enabled = bEnabled;
        }
        //clears all the fields
        private void Clearfields()
        {
            txtClientID.Text = "";
            txtfName.Text = "";
            txtlName.Text = "";
            txtAddress.Text = "";
            txtCity.Text = "";
            txtProvince.Text = "";
            txtPostCode.Text = "";
            txtPhone.Text = "";
        }
        //fills the fields from the database to the text boxes
        private void FillFields(DataSet ds)
        {
            txtClientID.Text = ds.Tables[0].Rows[0]["ClientID"].ToString();
            txtfName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();
            txtlName.Text = ds.Tables[0].Rows[0]["LastName"].ToString();
            txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            txtProvince.Text = ds.Tables[0].Rows[0]["Province"].ToString();
            txtPostCode.Text = ds.Tables[0].Rows[0]["PostCode"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
        }
        //When the Select is clicked, enables the fields to be filled, fills the fields, clears the error label if needed
        protected void ClientGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            ClientGridView.SelectedIndex = Convert.ToInt32(e.CommandArgument.ToString());
            int ClientID = Convert.ToInt32(ClientGridView.SelectedValue.ToString());

            if (e.CommandName == "Select Client")// if the Select Button is clicked on the GridView
            {
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spClientSelect");
                FillFields(ds);//Fills all the fields
                SetEnabled(true);//Enables the fields to be filled
               
                pnlClientFields.Visible = true;//makes all the fields visible
                txtClientID.Text = ClientGridView.SelectedRow.Cells[1].Text;//will input data from the corresponding cell in the database to the textbox
                txtfName.Text = ClientGridView.SelectedRow.Cells[2].Text;//will input data from the corresponding cell in the database to the textbox
                txtlName.Text = ClientGridView.SelectedRow.Cells[3].Text;//will input data from the corresponding cell in the database to the textbox
                txtAddress.Text = ClientGridView.SelectedRow.Cells[4].Text;//will input data from the corresponding cell in the database to the textbox
                txtCity.Text = ClientGridView.SelectedRow.Cells[5].Text;//will input data from the corresponding cell in the database to the textbox
                txtProvince.Text = ClientGridView.SelectedRow.Cells[6].Text;//will input data from the corresponding cell in the database to the textbox
                txtPostCode.Text = ClientGridView.SelectedRow.Cells[7].Text;//will input data from the corresponding cell in the database to the textbox
                txtPhone.Text = ClientGridView.SelectedRow.Cells[8].Text;//will input data from the corresponding cell in the database to the textbox
                lblError.Text = "";//if the lblError was fired will clear the message
            }
            BindData();
        }
        //Allows paging, splitting the data up into smaller groups 
        //so you go to the next page to see the data, 
        //like a book, instead of seeing all the data on one long page
        protected void ClientGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
            ClientGridView.DataSource = dal.ExecuteProcedure("spClientSelect");
            ClientGridView.PageIndex = e.NewPageIndex;
            ClientGridView.DataBind();
        }
        //When clicking on the Clear button, will clear all fields and make the pnlEditingClient visible
        protected void btnClear_Click(object sender, EventArgs e)
        {
            pnlClientFields.Visible = true;
            pnlEditingClient.Visible = true;
            Clearfields();
        }
        //when the edit button is clicked...
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (txtClientID.Text == "")// if no ClientId is in the textbox...
            {
                lblError.Text = "Please select a Client first!";//the label with say this
            }
            else//but if there is a ClientId in the textbox...
            {
                pnlEditDelete.Visible = false;//Off
                pnlEditingClient.Visible = true;//On
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                DataSet ds = new DataSet();
                dal.ExecuteProcedure("spClientSelect");
                pnlClientFields.Visible = true;//On
            }
        }
        //when the Cancel button is clicked...
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlEditDelete.Visible = true;//turns this panel visible
            Clearfields();//Clears all the fields
        }
        //when the Save button is clicked...
        protected void btnSave_Click(object sender, EventArgs e)
        {
            pnlEditDelete.Visible = true;//turns this panel visible
            try
            { //The DAL fires and the fields that have input are saved to the database
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                dal.AddParam("@ClientID", txtClientID.Text);
                dal.AddParam("@fName", txtfName.Text);
                dal.AddParam("@lName", txtlName.Text);
                dal.AddParam("@Address", txtAddress.Text);
                dal.AddParam("@City", txtCity.Text);
                dal.AddParam("@Province", txtProvince.Text);
                dal.AddParam("@PostCode", txtPostCode.Text);
                dal.AddParam("@Phone", txtPhone.Text);
                dal.ExecuteProcedure("spClientUpdate");

                BindData();//binds the data
                Clearfields();//Clears all the fields
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Cosmic Rays affected the data, please try again later! " + ex.Message;//if something goes wrong this will fire
            }

        }
        
        
    
    }
}