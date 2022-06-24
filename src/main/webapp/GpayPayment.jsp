<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payments JSP</title>
<link rel="stylesheet" href="css/Payment.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script> 
$(function(){
  $("#header").load("CustomerHeader.html"); 
});
</script>
</head>
<body>
<div id="header"></div>
<div class=active>
	<%
    String totalAmount= request.getParameter("amt");
    %>
    <div class="filler"></div>
	<form action="PlaceOrder.jsp?amt=<%= totalAmount %>" method="post">
	<div class="container">
		<div class="bigcard">
		<h2>Payment using Google Pay</h2>
		<p> Total Amount:  <%= totalAmount %> </p>
		<div class="bigcard2">
		<table>
		<tr>
		 <td><h3>Enter Google Pay UPI</h3></td>
		 <td><input type="text" name="cno" required></td>
		</tr>	
			</table>
			 <input type="submit" value="Make Payment"> 
			</div>
		</div>
	</div>
	</form>
	</div>
</body>
</html>