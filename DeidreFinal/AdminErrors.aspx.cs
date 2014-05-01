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
    public partial class AdminErrors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ClientID"] == null)
            {
                Response.Redirect("Home.aspx");
            }
            try
            {
                if (!IsPostBack)                
                {
                    BindData();
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong, Please try again later " + ex.Message;
            }
        }
        private void BindData()
        {
            DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
            DataSet ds = new DataSet();
            ErrorGridView.DataSource = d.ExecuteProcedure("spErrorSelect");
            ErrorGridView.DataBind();
        }
        protected void btnDeleteError_Click(object sender, EventArgs e)
        {
            try//TODO
            {
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                dal.AddParam("@ErrorID", txtErrorID.Text);
                dal.ExecuteProcedure("spErrorDelete");
                Clearfields();//Clears all the fields
                BindData();//binds the data
               
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong " + ex.Message;
            }
        }
        private void SetEnabled(bool bEnabled)
        {
            txtErrorID.Enabled = bEnabled;
            txtClientID.Enabled = bEnabled;
            txtErrorTime.Enabled = bEnabled;
            txtItemSaleID.Enabled = bEnabled;
            txtErrorMessage.Enabled = bEnabled;
        }
        private void Clearfields()
        {
            txtErrorID.Text = "";
            txtClientID.Text = "";
            txtItemSaleID.Text = "";
            txtErrorMessage.Text = "";
            txtErrorTime.Text = "";
        }
        private void FillFields(DataSet ds)
        {
            txtErrorID.Text = ds.Tables[0].Rows[0]["ErrorID"].ToString();
            txtClientID.Text = ds.Tables[0].Rows[0]["ClientID"].ToString();
            txtItemSaleID.Text = ds.Tables[0].Rows[0]["ItemSaleID"].ToString();
            txtErrorMessage.Text = ds.Tables[0].Rows[0]["ErrorMessage"].ToString();
            txtErrorTime.Text = ds.Tables[0].Rows[0]["ErrorTime"].ToString();
        }
        protected void ErrorGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            ErrorGridView.SelectedIndex = Convert.ToInt32(e.CommandArgument.ToString());
            int ErrorID = Convert.ToInt32(ErrorGridView.SelectedValue.ToString());

            if (e.CommandName == "Select Error")
            {
                DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                DataSet ds = new DataSet();
                d.ExecuteProcedure("spErrorSelect");
                FillFields(ds);
                SetEnabled(true);

                txtErrorID.Text = ErrorGridView.SelectedRow.Cells[1].Text;
                txtErrorMessage.Text = ErrorGridView.SelectedRow.Cells[2].Text;
                txtClientID.Text = ErrorGridView.SelectedRow.Cells[3].Text;
                txtItemSaleID.Text = ErrorGridView.SelectedRow.Cells[4].Text;
                txtErrorTime.Text = ErrorGridView.SelectedRow.Cells[5].Text;
            }
            BindData();
        }
        //Allows paging
        protected void ErrorGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            ErrorGridView.PageIndex = e.NewPageIndex;

            //ErrorGridView.DataSource = RunSql("spErrorSelect");
            //ErrorGridView.PageIndex = e.NewPageIndex;
            //ErrorGridView.DataBind();
        }
        protected void btnClearError_Click1(object sender, EventArgs e)
        {
            Clearfields();
        }

        protected void ErrorGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}