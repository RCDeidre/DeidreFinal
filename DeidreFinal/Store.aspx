<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Store.aspx.cs" Inherits="DeidreFinal.Store" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
The Art Farm - Store
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Store</h2>
    <asp:Label ID="lblError" runat="server"></asp:Label>
        <asp:Panel ID="pnlListViewItem" runat="server">
            <asp:ListView ID="ListViewItem" runat="server" OnItemCommand="ListViewItem_ItemCommand">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>Quantity:
                                <asp:TextBox ID="txtItemQuantity" runat="server" Width="45px"></asp:TextBox></td>
                            <td>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart" CommandName="AddToCart" /></td>
                            <td>Price:<asp:Label ID="lblItemPrice" Text='<%# Eval("ItemPrice") %>' runat="server" /></td>
                            <td>Item:<asp:Label ID="lblItemName" Text='<%# Eval("ItemName") %>' runat="server" /></td>
                        </tr>
                    </table>

                </ItemTemplate>
            </asp:ListView>
        </asp:Panel>
        <br />

        <asp:GridView ID="gvYourCart" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvYourCart_RowDataBound" ShowFooter="True">
            <Columns>
                <asp:BoundField DataField="Item" HeaderText="Item" />
                <asp:BoundField DataField="Price" HeaderText="Price" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="SubTotalPrice" FooterText="Total" HeaderText="SubTotalPrice" />
            </Columns>
        </asp:GridView>
        <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" OnClick="btnClearCart_Click" /><br />
        <br />
        <asp:Panel ID="pnlCheckOut" runat="server">
            <asp:Button ID="btnCheckOut" runat="server" Text="Check Out" OnClick="btnCheckOut_Click" /></asp:Panel>
        <asp:Label ID="lblFinalCheckOut" runat="server" Text=""></asp:Label>
        <br />
        <asp:Button ID="btnFinalCheckOut" runat="server" OnClientClick="this.disabled = true; this.value = 'Submit in progress...';" 
  UseSubmitBehavior="false" 
  OnClick="BtnSubmit_Click" 
  Text="Click to Submit" />
     <asp:Panel ID="pnlSuccess" runat="server">
<h2>Thank you! <br /><br />Your order has been registered and will be processed as soon as possible.<br /><br />
    You will receive an e-mail to confirming your order.</h2>
     </asp:Panel>
    <asp:Textbox ID="txtEmail" runat="server" Visible="False"  ></asp:Textbox> 

    <asp:Panel ID="Panel1" runat="server" Visible="False">
        <asp:Label ID="lblItem" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Label ID="lblSubTotalPrice" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Label ID="lblQuantity" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Xml ID="xmlSale" runat="server">
            <sale>
                <quantity></quantity>
                <Item></Item>
                <subtotalprice></subtotalprice>
            </sale>
        </asp:Xml>

    </asp:Panel>
</asp:Content>
