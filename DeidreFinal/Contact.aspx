<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="DeidreFinal.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Contact
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Deidre Steenman</p>
    <p>
        E-mail: deidre.steenman@robertsoncollege.net</p>
    <p>
        Address:</p>
    <p>
        Phone:</p>
    <p>
        &nbsp;</p>
    <input type="text" id="txtInput"/>
<input id="btnComment" type="button" value="Leave a Comment:!" onclick="onAddText()" />
    <br/>
   <br/>
    <div id="container"></div>
    
</asp:Content>
