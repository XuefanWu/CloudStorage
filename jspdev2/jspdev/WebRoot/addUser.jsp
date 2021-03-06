<%@ page language="java"  pageEncoding="gbk"%>

<html>
  <head>
  
 <script type="text/javascript">
 
 
 //ASCII
function ctoASC(str){
var result="";
for(var n=0;n<str.length;n++){
//get ASC code for that char, actually this method returns 0-65535 Unicode
var c=str.charCodeAt(n);
if(c<256){
//get the char from the ASC code
result+=String.fromCharCode(c);
}
else if(C>127&&c<2048){
result+=String.fromCharCode((c>>6)|192);
result+=String.fromCharCode((c&63)|128);
}
else{
result+=String.fromCharCode((c>>12)|224);
result+=String.fromCharCode(((c>>6)&63)|128);
result+=String.fromCharCode((c&63)|128);
}
}
var val="";
for(var i=0;i<result.length;i++){
var tval=result.charCodeAt(i);
tval=tval.toString(2);
while(tval.length<8)
tval="0"+tval;
val+=tval;
}
return val;

}

//right 
function dorightrotate(a,num){
return (a>>>num)|(a<<(32-num));
}

//sign not change
function doesrightrotate(a,num){
var result="";
while(a.length<32){
a="0"+a;
}
var len=a.length;
for(var i=0;i<len;i++){
var n=i-num;
while(n<0)
n+=len;
while(n>=len)
n-=len;
result+=a.charAt(n);
}
return parseInt(result,2);
}


//left
function doleftrotate(a,num){
var result="";
while(a.length<32)
a="0"+a;
var len=a.length;
for(var i=0;i<len;i++){
var n=i+num;
while(n<0)
n+=len;
while(n>=len)
n-=len;
result+=a.charAt(n);
}
return parseInt(result,2);
}

//inverse
function dorev(a){
var result="";
while(a.length<32)
a="0"+a;
for(var i=0;i<a.length;i++){
result+=(1-parseInt(a.charAt(i)));
}
return parseInt(result,2);
}


//hex
function tohex(a){
var result="";
if(a<0){
a=-a;
var b=dorev(a.toString(2));
result=(b+1).toString(16);
while (result.length<8)
result="0"+result;
return result.toUpperCase();
}
result=a.toString(16);
while (result.length<8)
result="0"+result;
return result.toUpperCase();
}

//a+b
function add(a,b){
var lowbit=(a&0xFFFF)+(b&0xFFFF);
var higbit=(a>>16)+(b>>16)+(lowbit>>16);
return (lowbit&0xFFFF)|(higbit<<16);
}


//
function encrypt(pwd){
//var pwd=document.getElementById("pwd").value;
/*if(pwd.length<8||pwd.length>16){
alert("The password should be a 8-16 character word!");
return;
}*/
pwd=ctoASC(pwd);
var mesglen=pwd.length;
mesglen=mesglen.toString(2);
var h=new Array(0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c,0x1f83d9ab, 0x5be0cd19);
var k=new Array(0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2);
pwd=pwd+"1";
while(pwd.length%512!=448){
pwd=pwd+"0";
}
while(mesglen.length<64){
mesglen="0"+mesglen;
}
pwd=pwd+mesglen;
var chunks=new Array(pwd.length/512);
for(var i=0;i<chunks.length;i++){
var w=new Array(64);
chunks[i]=pwd.substring(512*i,512*i+512);
for(var j=0;j<16;j++){
w[j]=parseInt(chunks[i].substring(32*j,32*j+32),2);
}
for(var j=16;j<64;j++){
var s0=dorightrotate(w[j-15],7)^dorightrotate(w[j-15],18)^(w[j-15]>>>3);
var s1=dorightrotate(w[j-2],17)^dorightrotate(w[j-2],19)^(w[j-2]>>>10);
w[j]=add(w[j-16],add(s0,add(w[j-7],s1)));
}
var a=h[0];
var b=h[1];
var c=h[2];
var d=h[3];
var e=h[4];
var f=h[5];
var g=h[6];
var hh=h[7];
}
for(var i=0;i<64;i++){
s0=dorightrotate(a,2)^dorightrotate(a,13)^dorightrotate(a,22);
var maj=(a&b)^(a&c)^(b&c);
var t2=add(s0,maj);
s1=dorightrotate(e,6)^dorightrotate(e,11)^dorightrotate(e,25);
var ch=(e&f)^((~e)&g);
var t1=add(hh,add(s1,add(ch,add(k[i],w[i]))));
hh=g;
g=f;
f=e;
e=add(d,t1);
d=c;
c=b;
b=a;
a=add(t1,t2);
}
h[0]=add(h[0],a);
h[1]=add(h[1],b);
h[2]=add(h[2],c);
h[3]=add(h[3],d);
h[4]=add(h[4],e);
h[5]=add(h[5],f);
h[6]=add(h[6],g);
h[7]=add(h[7],hh);
var result="";
for(var i=0;i<8;i++){
//alert(i+":"+tohex(h[i])+" initial:\n"+h[i]+" "+h[i].toString(2));
result+=tohex(h[i]);
}
//alert("This result:"+result);
var finalresult=tohex(h[0])+tohex(h[1])+tohex(h[2])+tohex(h[3])+tohex(h[4])+tohex(h[5])+tohex(h[6])+tohex(h[7]);
return finalresult;
}
 
 
 

  function Juge(form1)
{
   if(form1.name.value=="")
   {
    window.alert("Please enter your name��"); 
    form1.name.focus(); 
    return (false); 
   }
   if(form1.pwd.value =="")
   	{
   		window.alert("Please enter your password");
   		form1.pwd.focus();
   		return (false);
   	}
   	
   	if(form1.pwd.value.length <8 ||form1.pwd.value.length>16 )
   	{
   		window.alert("Password too short/long ");
   		form1.pwd.focus();
   		return (false);
   	}
  if (form1.pwd.value != form1.pwd1.value) 
     { 
       window.alert("password dosen't match��"); 
       form1.pwd1.focus(); 
       return (false); 
     }
     form1.pwd.value = encrypt(form1.pwd.value);
   if(form1.age.value=="")
   {
    window.alert("Please enter your age"); 
    form1.age.focus(); 
    return (false); 
   }
   if(form1.age.value!="")
   {
   	if(isNaN(form1.age.value))
		{
			alert("age cannot be a char!");
    		return false;
		}
	}
   
   if(form1.address.value=="")
   {
    window.alert("Please enter your address"); 
    form1.address.focus(); 
    return (false); 
   }
   
  
}

</script>
  
    <title>Add User</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  </head> 
  
  
  <body background="img/white.jpg">
  
  
 
  &nbsp;&nbsp;&nbsp;&nbsp; 
    <P></P><form name="form1" method="post" action="/jspDev/servlet/addUser_Servlet" onsubmit="return Juge(form1);">
      <table width="263" height="272" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="86"><div align="center">Name</div></td>
          <td width="178"><input name="name" type="text" id="name" size="15"></td>
        </tr>
        <tr>
          <td><div align="center">Password</div></td>
          <td><input name="pwd" type="text" id="pwd" size="15"></td>
        </tr>
        <tr>
          <td><div align="center">Confirm password</div></td>
          <td><input name="pwd1" type="text" id="pwd1" size="15"></td>
        </tr>
        <tr>
          <td><div align="center">Age</div></td>
          <td><input name="age" type="text" id="age" size="5"></td>
        </tr>
        <tr>
          <td><div align="center">Sex</div></td>
          <td><input name="sex" type="radio" value="male" checked>
          male
            <input type="radio" name="sex" value="female">
          female</td>
        </tr>
        <tr>
          <td><div align="center">Address</div></td>
          <td><input name="address" type="text" id="address"></td>
        </tr>
        <tr>
          <td colspan="2"><div align="center">
            <input type="submit" name="Submit" value="Confirm">
            &nbsp;&nbsp;
            <input type="reset" name="Submit2" value="Redo">
          </div></td>
        </tr>
      </table>
        </form>
    <p><br>
        </p>
  </body>
</html>


