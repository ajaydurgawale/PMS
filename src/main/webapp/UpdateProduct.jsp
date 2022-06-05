<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Product</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String pname = request.getParameter("pname");
	String mfg = request.getParameter("mfg");
	String price = request.getParameter("price");
	String uid1 = request.getParameter("uid");


	PreparedStatement ps2 = null;
	Connection conn = null;
	ResultSet rs = null;
	String query1 = "UPDATE product SET pname=?,mfg=?,price=? WHERE pid=?";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
		ps2 = conn.prepareStatement(query1);
		ps2.setString(1, pname);
		ps2.setString(2, mfg);
		ps2.setString(3, price);
		ps2.setString(4, uid1);
		int i = ps2.executeUpdate();
		response.sendRedirect("ManageProducts.jsp");
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
			if (ps2 != null)
		ps2.close();
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