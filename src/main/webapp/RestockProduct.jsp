<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Vendor to Product</title>
<link rel="stylesheet" href="css/AddProduct.css">
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
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String uid=(String)httpSession.getAttribute("currentuser");
    
    String uid1 = request.getParameter("id");
    %>
	<div class="filler"></div>
	    <%
	ResultSet rs=null;
	PreparedStatement ps=null;
	ResultSet rs1=null;
	PreparedStatement ps1=null;
	java.sql.Connection conn=null;
	String query = "select sid from inventory where pid=?";
	String query1="select p.pname,p.pid,p.manufacturer,p.price,p.image from product p where pid=?";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps=conn.prepareStatement(query);
		ps.setString(1,uid1);
		rs=ps.executeQuery();
		ps1=conn.prepareStatement(query1);
		
		ps1.setString(1,uid1);
		rs1=ps1.executeQuery();
		System.out.println(rs.getFetchSize());
		%>
		<h2>Re-stock product</h2>
		<%
		while(rs1.next())
				{
		%>
		<form action="UpdateStock.jsp" method="post">
			<div class="bigcard">
				<div class="bigcard1">
					<h3>Product Name</h3>
					<input type='text' name='pname' id='pname' value='<%=rs1.getString("pname")%>' readonly>
					<h3>Product ID</h3>
					<input type='text' name='pid' id='pid' value='<%=rs1.getString("pid")%>' readonly>
					<h3>Manufacturer Name</h3>
					<input type='text' name='mfg' id='mfg' value='<%=rs1.getString("manufacturer")%>' readonly>
				</div>
				<div class="bigcard2">
					<h3>Order Quantity</h3>
					<input type="text" name='qty' id="qty" required>
					<h3>Vendor</h3>
					<select name="sid">
					<%
					while (rs.next()) {
					%>
						<option><%=rs.getString("sid")%></option>
					<%
					}
					%>
					</select>
					<p></p>
					<input type="submit" value="Re-stock">
				</div>
			</div>
		</form>
		<%
		}
		%>
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
