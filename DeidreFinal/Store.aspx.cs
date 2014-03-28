using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using FinalClassLibrary;

namespace DeidreFinal
{
    public partial class Store : System.Web.UI.Page
    {

        SalesList listOfSales;
        decimal priceTotal = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SecurityLevel"] != null && Session["SecurityLevel"].ToString() == "1")
            {
                pnlCheckOut.Visible = false;
                btnFinalCheckOut.Visible = false;
                pnlSuccess.Visible = false;
                txtEmail.Text = GetEmailAddress();

                if (!IsPostBack || Session["cart"] == null)
                {
                    DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                    Session["cart"] = new SalesList();
                    ListViewItem.DataSource = d.ExecuteProcedure("spGetItem");
                    ListViewItem.DataBind();
                }
                listOfSales = (SalesList)Session["cart"];
                RefreshCart();
            }
            else
            {
                Response.Redirect("Home.aspx");
            }

        }
        // Adds the item and the quantity of the item selected to the cart.
        protected void ListViewItem_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                ItemSales sale = new ItemSales();
                try
                {
                    sale.item = ((Label)e.Item.FindControl("lblItemName")).Text;
                    sale.Price = Convert.ToDouble(((Label)e.Item.FindControl("lblItemPrice")).Text);
                    sale.Quantity = Convert.ToInt32(((TextBox)e.Item.FindControl("txtItemQuantity")).Text);
                    listOfSales.Add(sale);
                    RefreshCart();
                    pnlCheckOut.Visible = true;
                    ((TextBox)e.Item.FindControl("txtItemQuantity")).Text = "";
                }
                catch (Exception ex)
                {
                    lblError.Text = "Something went wrong: " + ex.Message;
                }
            }
        }
        protected void RefreshCart()
        {
            priceTotal = 0;
            gvYourCart.DataSource = listOfSales.Sales;
            gvYourCart.DataBind();
        }
        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            pnlListViewItem.Visible = false;
            btnFinalCheckOut.Visible = true;
            lblFinalCheckOut.Text = "If this order is correct 'Click to Submit' to finalize order!";
        }
        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            ClearCart();
            RefreshCart();
            pnlCheckOut.Visible = false;
            pnlListViewItem.Visible = true;
            btnFinalCheckOut.Visible = false;
            lblError.Text = "";
        }
        //Clears the Session 'cart' and creates a new list
        private void ClearCart()
        {
            listOfSales = new SalesList();
            Session["cart"] = listOfSales;
        }
        protected void gvYourCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // add the SubTotalPrice to the running total variables
                priceTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SubTotalPrice"));
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[0].Text = "Totals:";
                // for the Footer, display the running totals
                e.Row.Cells[3].Text = priceTotal.ToString("c");

                e.Row.Cells[1].HorizontalAlign = e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Font.Bold = true;
            }
        }
        private void SendEmailMessage()
        {
            MailMessage message = new MailMessage();
            message.From = new MailAddress("deidre.steenman@robertsoncollege.net");
            message.To.Add(new MailAddress(txtEmail.Text));
            message.Subject = "Your Order from The Art Farm";
            message.Body = "Your order of " + EmailTheSale() + " is being processed and will be sent as soon as possible. Thank you from The Art Farmers";

            SmtpClient client = new SmtpClient();
            client.Host = "smtp.gmail.com";
            client.Port = 587;
            client.EnableSsl = true;
            client.Credentials = new System.Net.NetworkCredential("deidre.steenman@robertsoncollege.net", "robertson1");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Send(message);
        }
        private string EmailTheSale()
        {
            string clientID = (string)Session["ClientID"];
            foreach (ItemSales item in listOfSales.Sales)
            {
                lblItem.Text = item.item;
                lblSubTotalPrice.Text = item.SubTotalPrice.ToString();
                lblQuantity.Text = item.Quantity.ToString();
            }
            return (lblQuantity.Text + " " + lblItem.Text + " Item, for $" + lblSubTotalPrice.Text + " ");
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
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string clientID = (string)Session["ClientID"];
                foreach (ItemSales item in listOfSales.Sales)
                {
                    DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbDeidreFinalAssign;Integrated Security=SSPI");
                    d.AddParam("@ClientID", clientID);
                    d.AddParam("@Item", item.item);
                    d.AddParam("@TotalSale", item.SubTotalPrice.ToString());
                    d.AddParam("@Quantity", item.Quantity.ToString());
                    d.ExecuteProcedure("spItemSalesOrder");
                }

            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong. Please try again later! " + ex.Message;
            }

            pnlCheckOut.Visible = false;
            btnFinalCheckOut.Visible = false;
            pnlSuccess.Visible = true;
            SendEmailMessage();
        }
    }
}
