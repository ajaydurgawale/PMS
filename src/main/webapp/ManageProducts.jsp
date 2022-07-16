<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
<link rel="stylesheet" href="css/Users.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script> 
$(function(){
  $("#header").load("AdminHeader.html"); 
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
		String gid = (String) httpSession.getAttribute("currentuser");
		%>

		<div class="filler"></div>

		<%
		int flag = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		ResultSet rs1 = null;
		PreparedStatement ps1 = null;
		java.sql.Connection conn = null;
		String query = "select pname,pid,price from product";
		String query1 = "select sid from inventory where pid=?";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
		%><div class="filler2"></div>
		<div class="button"> 
		<a href="AddProduct.html">Add Product</a>
		</div>
		<div class="filler3"></div>
		<table class="tables">
			<tr>
				<th>Product ID</th>
				<th>Name</th>
				<th>Price</th>
				<th>Vendors</th>
				<th>Action</th>
			</tr>
			<%
			while (rs.next()) {
			%>

			<tr>
				<td><%=rs.getString("pid")%></td>
				<td><%=rs.getString("pname")%></td>
				<td><%=rs.getInt("price")%></td>
				<td>
				<select name="vendors">
				<%
				ps1 = conn.prepareStatement(query1);
				ps1.setString(1,rs.getString("pid"));
				rs1 = ps1.executeQuery();
			while (rs1.next()) {
			%>
  					<option><%=rs1.getString("sid")%></option>
				
			<%
			}
			%>
			</select>
				</td>
				<td>
					<div class="action-btn">
						<a href="RestockProduct.jsp?id=<%=rs.getString("pid") %>">Add Stock</a>
					    <a href="AddProductVendor.jsp?id=<%=rs.getString("pid") %>">Add Vendor</a>
						<a href="UpdateProduct.html?id=<%=rs.getString("pid") %>">Edit</a>
						<a href="DeleteProduct.jsp?id=<%=rs.getString("pid") %>">Delete</a>
					</div>
				</td>
			</tr>

			<%
			}
			%>
		</table>
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
		if (rs1 != null)
			rs1.close();
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
		if (ps1 != null)
			ps1.close();
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
