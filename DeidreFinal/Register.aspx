<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DeidreFinal.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
The Art Farm - Register
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlRegTitle" runat="server"><h2>Register Here</h2></asp:Panel> 
    <form runat="server">
    <asp:Panel ID="pnlClientUserReg" runat="server">

       <table id="registTable" >
             <tr>
             <td colspan="2" align="center">
              Client Registration
             </td>
               
             </tr>
             <tr>
                <td>
                <asp:Label ID="lblfName" runat="server" Text="First Name: "></asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtfName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                        ErrorMessage=" First Name Required" ControlToValidate="txtfName">*</asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td>
                    <asp:Label ID="lbllName" runat="server" Text="Last Name: "></asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtlName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                        ErrorMessage="Last Name Required" ControlToValidate="txtlName">*</asp:RequiredFieldValidator>
                </td>
            </tr>
              <tr>
                <td>
                    <asp:Label ID="lblAddress" runat="server" Text="Address: "></asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                        ErrorMessage="Address Required" ControlToValidate="txtAddress">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCity" runat="server" Text="City: "></asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" 
                        ErrorMessage="City Required" ControlToValidate="txtCity">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                <asp:Label ID="lblProvince" runat="server" Text="Province: "></asp:Label>
                </td>
                <td >
                        <asp:DropDownList ID="ddProvince" runat="server" Width="119px" Height="19px">
                            <asp:ListItem Selected="True">Select One</asp:ListItem>
                            <asp:ListItem>AB</asp:ListItem>
                            <asp:ListItem>BC</asp:ListItem>
                            <asp:ListItem>MB</asp:ListItem>
                            <asp:ListItem>NB</asp:ListItem>
                            <asp:ListItem>NS</asp:ListItem>
                            <asp:ListItem>NFL</asp:ListItem>
                            <asp:ListItem>NV</asp:ListItem>
                            <asp:ListItem>NWT</asp:ListItem>
                            <asp:ListItem>ON</asp:ListItem>
                            <asp:ListItem>PEI</asp:ListItem>
                            <asp:ListItem>QC</asp:ListItem>
                            <asp:ListItem>SK</asp:ListItem>
                            <asp:ListItem>YK</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvProvince" runat="server" 
                            ErrorMessage="Province Required" ControlToValidate="ddProvince">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPostCode" runat="server" Text="Postal Code: "></asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtPostCode" runat="server" OnTextChanged="txtPostCode_TextChanged" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" 
                        ErrorMessage="Postal Code Required" ControlToValidate="txtPostCode">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPostCode" runat="server" 
                        ErrorMessage="Incorrect Format" 
                        ValidationExpression="[A-Z]\d[A-Z]\s\d[A-Z]\d" 
                        ControlToValidate="txtPostCode">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                <asp:Label ID="lblPhone" runat="server" Text="Phone: "></asp:Label>
                </td>
                    <td >
                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                            ErrorMessage="Phone Required" ControlToValidate="txtPhone">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revPhone" runat="server" 
                            ControlToValidate="txtPhone" ErrorMessage="Incorrect Format" 
                            ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
           
             <tr>
                <td>
                     <asp:Label ID="lblUserName" runat="server" Text="User Name:"></asp:Label> 
                </td>
                <td >
                    <asp:TextBox ID="txtUserName" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                        ErrorMessage="User Name Required" ControlToValidate="txtUserName">*</asp:RequiredFieldValidator>
                </td>
            </tr>

             <tr>
                <td>
                    <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label> 
                </td>
                <td >
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                        ErrorMessage="Password Required" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                </td>
               </tr>

               <tr>
                <td>
                    <asp:Label ID="lblConPassword" runat="server" Text="Confirm Password:"></asp:Label> </td>
                <td >
                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPW" runat="server" 
                        ErrorMessage="Required password confirmation" 
                        ControlToValidate="txtConfirm">*</asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="cpvConfirmPW" runat="server" 
                        ControlToCompare="txtPassword" ControlToValidate="txtConfirm" 
                        ErrorMessage="Passwords do not match!">*</asp:CompareValidator>

                </td>
                </tr>
                       <tr>
                <td>
                    <asp:Label ID="lblEmail" runat="server" Text=" E-Mail:"></asp:Label>
                    </td>
                <td >
                    <asp:TextBox ID="txtEmail" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                        ErrorMessage="E-mail Required" ControlToValidate="txtEmail">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                        ErrorMessage="Incorrect Format for E-mail" ControlToValidate="txtEmail" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Security Question:</td>
                <td >
                    <asp:DropDownList ID="ddSecurity" runat="server"  
                        Height="25px" Width="160px">
                        <asp:ListItem>Please select one...</asp:ListItem>
                        <asp:ListItem>What was the name of your first pet?</asp:ListItem>
                        <asp:ListItem>What is your Mothers Maiden name?</asp:ListItem>
                        <asp:ListItem>What is your favorite Movie?</asp:ListItem>
                        <asp:ListItem>What is your favorite food?</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvSecQuestion" runat="server" 
                        ErrorMessage="Security Question Required" ControlToValidate="ddSecurity">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td >
                    Security Answer:</td>
                <td >
                        <asp:TextBox ID="txtSecurityAnswer" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSecAnswer" runat="server" 
                            ErrorMessage=" Security Answer Required" 
                            ControlToValidate="txtSecurityAnswer">*</asp:RequiredFieldValidator>
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
                    <asp:Button ID="btnRegister" runat="server"  Text="Register" 
                        onclick="btnRegister_Click" CausesValidation="False" ValidateRequestMode="Enabled" Height="41px" />  
                </td>
                <td>
                   <asp:Button ID="btnReset" runat="server" onclick="btnReset_Click" 
                        Text="Reset" CausesValidation="False" UseSubmitBehavior="False" Height="41px" /> 
                </td>
            </tr>
            </table>
       <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
           HeaderText="Please see the following errors:" />
       <p>
           <asp:Label ID="lblStatus" runat="server" Visible="False"></asp:Label>
       </p> 
       </asp:Panel>
          </form>          
                 <asp:Panel ID="pnlRegConfirm" runat="server"  Visible="False">
                     <h2><asp:Label ID="lblUpdateConfirm" runat="server" 
                         Text="Congratulations! <br><br>You are now Registered! <br><br>Please Log in to continue."></asp:Label></h2>
             </asp:Panel>
                    
             

</asp:Content>
    
