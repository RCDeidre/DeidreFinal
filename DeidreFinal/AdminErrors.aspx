<%@ Page Language="C#"MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="AdminErrors.aspx.cs" Inherits="DeidreFinal.AdminErrors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
The Art Farm - Admin Errors
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Errors</h2>

<asp:Label ID="lblError" runat="server" Font-Size="Large" ForeColor="Red"></asp:Label>
<asp:Panel ID="pnlError" runat="server" Height="237px" Width="1028px">

        <br/>  
         <table style="width: 343px">
             <tr>
                 <td>
                     <asp:Label ID="lblErrorID" runat="server" Text="ErrorID: "></asp:Label>
                 </td>
                 <td>
                     <asp:TextBox ID="txtErrorID" runat="server" CssClass="TxtBox" ></asp:TextBox>
                 </td>
             </tr>
             <tr>
                 <td>
                     <asp:Label ID="lblClientID" runat="server" Text="ClientID: "></asp:Label>
                 </td>
                 <td>
                     <asp:TextBox ID="txtClientID" runat="server" CssClass="TxtBox"></asp:TextBox>
                 </td>
             </tr>
              <tr>
                 <td>
                     <asp:Label ID="lblItemSaleID" runat="server" Text="FleeceItemSaleID: "></asp:Label>
                 </td>
                 <td>
                     <asp:TextBox ID="txtItemSaleID" runat="server" CssClass="TxtBox"></asp:TextBox>
                 </td>
             </tr>
             <tr>
                 <td>
                     <asp:Label ID="lblErrorMessage" runat="server" Text="Error Message: "></asp:Label>
                 </td>
                 <td>
                     <asp:TextBox ID="txtErrorMessage" runat="server" CssClass="TxtBox"></asp:TextBox>
                 </td>
             </tr>
             <tr>
                 <td>
                     <asp:Label ID="lblErrorTime" runat="server" Text="Error Time: "></asp:Label>
                 </td>
                 <td>
                     <asp:TextBox ID="txtErrorTime" runat="server" CssClass="TxtBox"></asp:TextBox>
                 </td>
             </tr>
         </table>
    <br />
            <asp:Panel ID="pnlEditError" runat="server" Width="239px">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnDeleteError" runat="server" Text="Delete Error" onclick="btnDeleteError_Click" CausesValidation="False" />
                                           </td>
                        <td>
                            <asp:Button ID="btnClearError" runat="server" Text="Clear" onclick="btnClearError_Click1" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
         </asp:Panel>
         <asp:GridView ID="ErrorGridView" runat="server" CellPadding="4" CssClass="Grids" 
             DataKeyNames="ErrorID" ForeColor="#333333" GridLines="Horizontal" 
              onrowcommand="ErrorGridView_RowCommand" 
             HorizontalAlign="Left" AllowPaging="True"  onpageindexchanging="ErrorGridView_PageIndexChanging" OnSelectedIndexChanged="ErrorGridView_SelectedIndexChanged">
             <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
             <Columns><asp:ButtonField ButtonType="Button" CommandName="Select Error" Text="Select" />
             </Columns>
             <EditRowStyle BackColor="#999999" />
             <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
             <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" Wrap="False" />
             <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
             <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
             <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
             <SortedAscendingCellStyle BackColor="#E9E7E2" />
             <SortedAscendingHeaderStyle BackColor="#506C8C" />
             <SortedDescendingCellStyle BackColor="#FFFDF8" />
             <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
         </asp:GridView>
     </asp:Panel>
    
</asp:Content>
