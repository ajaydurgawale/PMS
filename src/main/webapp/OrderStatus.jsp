<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Accept Order</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String bid = request.getParameter("id");
	String status = request.getParameter("status");

	PreparedStatement ps1 = null;
	Connection conn = null;
	ResultSet rs = null;
	String query1 = "update bills set status=? where bid=?";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
		ps1 = conn.prepareStatement(query1);
		ps1.setString(1, status);
		ps1.setString(2, bid);
		
		ps1.executeUpdate();
		response.sendRedirect("AdminOrders.jsp");
	} catch (Exception e) {
		out.println(e);
	} finally {
		try {
			if (rs != null)
		rs.close();
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