var xmlHttp;
function  showUser(str){
   
    xmlHttp = getXmlHttpObject();
    if (xmlHttp == null) {
        alert("Browser does not support HTTP Request");   
        return ;
   }
   
   var url = "getuser.php";
    url = url+"?q="+str;
    url = url+"$sid="+Math.random();
      alert(url);  
    xmlHttp.onreadystatechange = stateChange();
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

}


    function  stateChange(){
     if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
 document.getElementById("txtHint").innerHTML=xmlHttp.responseText ;
 }    
        
    }
function getXmlHttpObject() {
    
    var xmlHttp = null;
    try {
        //FireFox,Opera8.0+,Safari
        xmlHttp = new  XMLHttpRequest();    
    } catch (e) {
        try {
            xmlHttp = new  ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
             xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }

    }
    return  xmlHttp;
}