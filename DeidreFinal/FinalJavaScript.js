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

//function countE(){
//    var phrase = prompt("Which phrase would you like to examine?");
//    if (typeof(phrase) != "string" ){
//        alert("That is not a valid entry!");
//        return false;}
//    else{
//        var eCount = 0;
//        for(var index = 0; index < phrase.length; index++){
//            if(phrase.charAt(index) == "e" || phrase.charAt(index) == "E")
//                eCount++;
//        }
//    }
//    alert("There are " + eCount + " E's in \"" + phrase + "\".");
//    return true;
//}

//Login Script//

window.onload = function () {
    document.getElementById("ancorLogin").onclick = popup;
    document.getElementById("btnLogin").onclick = pushdown;

};

function popup() {
    document.getElementById("wrapper").style.display = "block";
}

function pushdown() {
    document.getElementById("wrapper").style.display = "none";
}

function login() {
    document.getElementById("subm").style.display = "none";

}

