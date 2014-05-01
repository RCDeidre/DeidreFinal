<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="Comments.aspx.cs" Inherits="DeidreFinal.Contact" %>
<head runat="server">
    <title>The Art Farm - Comments</title>
    <link href="FinalStyles.css" rel="stylesheet" />
    <style type="text/css">
        #txtInputOne
        {
            width: 337px;
        }
    </style>
</head> <br/>
    <h2>Comments</h2>
   <br/>
  <div id="container">
    <p>
        Deidre Steenman<br/>
        E-mail: deidre.steenman@robertsoncollege.net<br/>or
        deidre.steenman@gmail.com</p>
   </div> 
<form id="form2" runat="server" action="FinalHandler1.ashx" onsubmit="return validateForm()" method="post">
   <div>

<input type="text" id="txtInputOne" runat="server" /><br />
<input id="btnSubmit" type="submit" value="Leave a Comment!"/>  
 </div>
   </form>
<script>
    function validateForm() {
        var txtInput = document.forms["form2"]["txtInputOne"].value;
        if (!txtInput) {
            alert("You didn't comment!");
            return false
        }
    }
</script>
