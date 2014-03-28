<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="DeidreFinal.Password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
The Art Farm - Password
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Change Your Password</h2>
        

     <asp:Textbox ID="txtEmail" runat="server" Visible="False"  ></asp:Textbox> 
   
           <asp:Label ID="lblErrorSignIn" runat="server" Text=""></asp:Label>
         <asp:Panel ID="pnlNotSignedIn" runat="server">
          
     <asp:Panel ID="pnlChangePassword" runat="server" HorizontalAlign="Right" width="447px">
          
             
                 Update Your Password
             
            <br /><br />
                     <asp:Label ID="lblUserName" runat="server" Text="User Name:"></asp:Label> 
               &nbsp;
               
                    <asp:TextBox ID="txtUserName" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                        ErrorMessage="User Name Required" ControlToValidate="txtUserName">*</asp:RequiredFieldValidator>
              <br />
                    <asp:Label ID="lblPassword" runat="server" Text="Old Password:"></asp:Label> 
               &nbsp;
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="Password Required" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                <br />
                    <asp:Label ID="lblNewPassword" runat="server" Text="New Password:"></asp:Label> 
               
                &nbsp;
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                        ErrorMessage="Password Required" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                <br />
                    <asp:Label ID="lblConfirm" runat="server" Text="Confirm New Password:"></asp:Label> 
                 &nbsp;&nbsp;
                 <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                 
                 <asp:RequiredFieldValidator ID="rfvConfirmPW" runat="server" ControlToValidate="txtConfirm" ErrorMessage="Required password confirmation">*</asp:RequiredFieldValidator>
                 <br />
         <asp:CompareValidator ID="cpvConfirmPW" runat="server" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirm" ErrorMessage="Passwords do not match!">*</asp:CompareValidator>
                 <br />
                 <asp:CheckBox ID="cbxConfirm" runat="server" CausesValidation="True" Text="Check if you like a confirmation E-mail?" />
                 <br />
                 <br />
                <asp:Button ID="btnUpdate" runat="server"  
                        Text="Update"  onclick="btnUpdate_Click" /> 
                                         
                 &nbsp;&nbsp;
                 <asp:Button ID="btnReset" runat="server" CausesValidation="False" onclick="btnReset_Click" Text="Reset" UseSubmitBehavior="False" />
                                         
       <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
           HeaderText="Please see the following errors:" Width="440px" />
         </asp:Panel>




       <p>
           <asp:Label ID="lblStatus" runat="server" Visible="False"></asp:Label>
       </p> 
           <asp:Panel ID="pnlPassUpdateConfirm" runat="server" HorizontalAlign="Center" Visible="False">
               <h3>
                   <asp:Label ID="lblUpdateConfirm" runat="server" Text="Congratulations! &lt;br&gt;&lt;br&gt;You have updated your password. &lt;br&gt;&lt;br&gt;Please sign in again to continue."></asp:Label>
               </h3>
           </asp:Panel>
           <p>
               &nbsp;</p>
       </asp:Panel>



  



</asp:Content>
