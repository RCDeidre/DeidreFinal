<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="DeidreFinal.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
The Art Farm - Admin Main
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblError" runat="server" Font-Size="Large" ForeColor="Red"></asp:Label>
    <h2>The Administration Page</h2>
<br/><br/>
        <asp:Panel ID="pnlClients" runat="server" Height="549px" Width="988px">
        <asp:Panel ID="pnlClientFields" runat="server" Height="235px" Width="846px"><table style="width: 408px">   
          
        <tr>
            <td><asp:Label ID="lblClientID" runat="server" Text="ClientID: "></asp:Label></td>
            <td style="width: 273px"> <asp:TextBox ID="txtClientID" runat="server" CssClass="TxtBox" ReadOnly="True"></asp:TextBox></td> 
        </tr>
        <tr>
            <td><asp:Label ID="lblfName" runat="server" Text="First Name: "></asp:Label></td>
            <td style="width: 273px"><asp:TextBox ID="txtfName" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lbllName" runat="server" Text="Last Name: "></asp:Label> </td>
            <td style="width: 273px"><asp:TextBox ID="txtlName" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblAddress" runat="server" Text="Address: "></asp:Label> </td>
            <td style="width: 273px"><asp:TextBox ID="txtAddress" runat="server" CssClass="TxtBox"></asp:TextBox></td>
         </tr>
        <tr>
            <td><asp:Label ID="lblCity" runat="server" Text="City: "></asp:Label></td>
            <td style="width: 273px"><asp:TextBox ID="txtCity" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblProvince" runat="server" Text="Province: "></asp:Label></td>
            <td style="width: 273px"><asp:TextBox ID="txtProvince" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblPostCode" runat="server" Text="Post Code: "></asp:Label></td>
            <td style="width: 273px"><asp:TextBox ID="txtPostCode" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
            <tr>
            <td><asp:Label ID="lblPhone" runat="server" Text="Phone: "></asp:Label></td>           
            <td style="width: 273px"><asp:TextBox ID="txtPhone" runat="server" CssClass="TxtBox"></asp:TextBox></td>
            </tr>
       </table>
 </asp:Panel>

      <asp:Panel ID="pnlEditDelete" runat="server">
          <table>
                <tr>
                     <td><asp:Button ID="btnEdit" runat="server" Text="Edit Customer" onclick="btnEdit_Click" CausesValidation="False" /></td>
                     <td><asp:Button ID="btnDelete" runat="server" Text="Delete Customer" onclick="btnDelete_Click" CausesValidation="False" /></td>
                 </tr>
         </table>
     </asp:Panel>
   <asp:Label ID="lblIfNotDelete" runat="server" Text="If the Client did not Delete please see Error Page!"></asp:Label>
    <asp:Panel id="pnlEditingClient" runat="server" Width="239px">
            <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" CausesValidation="False" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" onclick="btnClear_Click" CausesValidation="False" />    
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" CausesValidation="False" />
    </asp:Panel> 
     
   
<asp:GridView ID="ClientGridView" runat="server" DataKeyNames="ClientID" 
         onrowcommand="ClientGridView_RowCommand" CssClass="Grids" CellPadding="4" 
            ForeColor="#333333" GridLines="Horizontal" Width="913px" Height="134px" 
                 HorizontalAlign="Left" AllowPaging="True" 
                 onpageindexchanging="ClientGridView_PageIndexChanging" 
                AutoGenerateColumns="False" PageSize="5">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:ButtonField ButtonType="Button" CommandName="Select Client" 
                Text="Select" />
            
            <asp:BoundField DataField="ClientID" HeaderText="ClientID" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:BoundField DataField="Province" HeaderText="Province" />
            <asp:BoundField DataField="PostCode" HeaderText="Postal Code" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" />
                        
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
    </asp:GridView> </asp:Panel>
  <br />
        <br />


</asp:Content>