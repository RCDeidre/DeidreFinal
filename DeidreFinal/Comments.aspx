<%@ Page Title="" Language="C#" MasterPageFile="~/FinalMaster.Master" AutoEventWireup="true" CodeBehind="Comments.aspx.cs" Inherits="DeidreFinal.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    The Art Farm - Comments
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br/>
    <h2>Comments</h2>
   <br/>
  <div id="container">
    <p>
        Deidre Steenman<br/>
        E-mail: deidre.steenman@robertsoncollege.net<br/>or
        deidre.steenman@gmail.com</p>
    <p>
        Address:</p>
    <p>
        Phone:</p>
    <p>
        &nbsp;</p>
    <input type="text" id="txtInput"/>
<input id="btnComment" type="button" value="Leave a Comment!" onclick="onAddText()" />
    <br/>

   <br/>
    </div>
    
</asp:Content>
