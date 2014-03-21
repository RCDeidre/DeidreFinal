<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="DeidreFinal.HTML" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
The Art Farm - Password
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Change Your Password</h2>

     <asp:Textbox ID="txtEmail" runat="server" Visible="False"  ></asp:Textbox> 
    <asp:Panel ID="pnlChangePassword" runat="server">
           <asp:Label ID="lblErrorSignIn" runat="server" Text=""></asp:Label>
         <asp:Panel ID="pnlNotSignedIn" runat="server">
          </asp:Panel>
           <table style="width: 512px" >
             <tr>
             <td colspan="2" align="center">
                 Update Your Password</td>
             
             </tr>
           <tr>
                <td>
                     <asp:Label ID="lblUserName" runat="server" Text="User Name:"></asp:Label> 
                </td>
                <td style="width: 272px">
                    <asp:TextBox ID="txtUserName" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                        ErrorMessage="User Name Required" ControlToValidate="txtUserName">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPassword" runat="server" Text="Old Password:"></asp:Label> 
                </td>
                <td style="width: 272px">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="Password Required" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                </td>
               </tr>
             <tr>
                <td>
                    <asp:Label ID="lblNewPassword" runat="server" Text="New Password:"></asp:Label> 
                </td>
                <td style="width: 272px">
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                        ErrorMessage="Password Required" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                </td>
               </tr>

               <tr>
                <td>
                    <asp:Label ID="lblConfirm" runat="server" Text="Confirm New Password:"></asp:Label> </td>
                <td style="width: 272px">
                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPW" runat="server" 
                        ErrorMessage="Required password confirmation" 
                        ControlToValidate="txtConfirm">*</asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="cpvConfirmPW" runat="server" 
                        ControlToCompare="txtNewPassword" ControlToValidate="txtConfirm" 
                        ErrorMessage="Passwords do not match!">*</asp:CompareValidator>
                </td>
                </tr>
                <tr>
                <td colspan="2">
                    <asp:CheckBox ID="cbxConfirm" runat="server" 
                        Text="   Check if you like a confirmation E-mail?" 
                        CausesValidation="True" />
                </td>
            </tr>
            <tr>
                <td >
                    <asp:Button ID="btnUpdate" runat="server"  Text="Update" onclick="btnUpdate_Click"  />  
                </td>
                <td  style="width: 272px"> <asp:Button ID="btnReset" runat="server"  
                        Text="Reset" CausesValidation="False" UseSubmitBehavior="False"  onclick="btnReset_Click" /> 
                  </td>
            </tr>
           </table>
            
       <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
           HeaderText="Please see the following errors:" Width="305px" />
       <p>
           <asp:Label ID="lblStatus" runat="server" Visible="False"></asp:Label>
       </p> 
       </asp:Panel>



</asp:Content>
