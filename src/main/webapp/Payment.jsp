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
	$(function() {
		$("#header").load("CustomerHeader.html");
	});
</script>
</head>
<body>
	<div id="header"></div>
	<div class=active>
		<%
		String totalAmount = request.getParameter("amt");
		%>
		<div class="filler"></div>

		<h2>Choose Mode of Payment</h2>
		<p>
			Total Amount:
			<%=totalAmount%>
		</p>
		<div class="button">
			<a href="CreditPayment.jsp?amt=<%= totalAmount %>">Credit Card</a>
		</div>
		<br>
		<div class="button">
			<a href="DebitPayment.jsp?amt=<%= totalAmount %>">Debit Card</a>
		</div>
		<br>
		<div class="button">
			<a href="GpayPayment.jsp?amt=<%= totalAmount %>">Google Pay</a>
		</div>
		<br>
		<div class="button">
			<a href="PhonePePayment.jsp?amt=<%= totalAmount %>">PhonePe</a>
		</div>
	</div>
</body>
</html>