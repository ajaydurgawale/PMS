<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
<link rel="stylesheet" href="css/Users.css">
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
		<%@ page import="java.sql.*"%>
		<%@ page import="javax.sql.*"%>
		<%
		HttpSession httpSession = request.getSession();
		String guid = (String) httpSession.getAttribute("currentuser");
		%>

		<div class="filler"></div>

		<%
		ResultSet rs = null;
		PreparedStatement ps = null;
		java.sql.Connection conn = null;
		String query = "select pid,pname,quantity,price from cart where uid=?";
		int totalAmount = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
			ps = conn.prepareStatement(query);
			ps.setString(1,guid);
			rs = ps.executeQuery();
		%><div class="filler2"></div>
		<table class="tables">
			<tr>
				<th>Product ID</th>
				<th>Name</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Amount</th>
				<th>Action</th>
			</tr>
			<%
			while (rs.next()) {
			%>

			<tr>
				<td><%=rs.getString("pid")%></td>
				<td><%=rs.getString("pname")%></td>
				<td><%=rs.getInt("price")%></td>
				<td><%=rs.getInt("quantity")%></td>
				<td><%=rs.getInt("price")*rs.getInt("quantity")%></td>
				<td>
					<div class="action-btn">
						<a href="DeleteCartProduct.jsp?id=<%=rs.getString("pid") %>">Delete</a>
					</div>
				</td>
			</tr>

			<%
			totalAmount = totalAmount + rs.getInt("price")*rs.getInt("quantity");
			}
			%>
		</table>
		<h3>Total Amount: <%=totalAmount %></h3>
		<div class="button">
		<a href="Payment.jsp?amt=<%= totalAmount %>">Proceed to payment</a> 
		</div>
	</div>
	<%
	} catch (Exception e) {
	out.println("error: " + e);
	} finally {
	try {
		if (rs != null)
			rs.close();
	} catch (Exception e) {
	}
	;
	try {
		if (ps != null)
			ps.close();
	} catch (Exception e) {
	}
	;
	try {
		if (conn != null)
			conn.close();
	} catch (Exception e) {
	}
	;
	}
	%>
</body>
</html>
