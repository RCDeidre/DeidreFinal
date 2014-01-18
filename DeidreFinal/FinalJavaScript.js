$(document).ready(function () {
      $(".nav li").hover(
   function () {
       $("ul", this).fadeIn();
   },
   function () {
       $("ul", this).fadeOut();
   }
 );
  }
);


//MyPremade
//$(document).ready(function () {

//});
    
function onAddText() {
    var cont = document.getElementById("container");
    var txt = document.getElementById("txtInput").value
    cont.innerHTML += txt + "<br/>";
}
