<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Profile</title>
<link rel="stylesheet" href="css/Register.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script> 
$(function(){
  $("#header").load("CustomerHeader.html"); 
});
</script>
</head>
<body>
<div id="header"></div>
<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String uid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
	<div class="filler2"></div>
			<form action="UpdateCustomerProfile.jsp" method="post">
			<div class="container">
				<div class="registerbox">
					<h2>Update Profile </h2>
					<input type="text" name="uid" id="uid" value="<%= uid %>" readonly>
					<input type="password" name="pass1" placeholder="Enter Password" required>
					<input type="submit" value="Update">
				</div>
			</div>
		</form>
			</div>
</body>
</html>
