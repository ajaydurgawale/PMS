<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String fname1 = request.getParameter("fname");
	String lname1 = request.getParameter("lname");
	String email1 = request.getParameter("email");
	String phno1 = request.getParameter("phno");
	String uid1 = request.getParameter("uid");
	String address1 = request.getParameter("address");

	PreparedStatement ps2 = null;
	Connection conn = null;
	ResultSet rs = null;
	String query1 = "UPDATE seller SET fname=?,lname=?,email=?,address=?,phno=? WHERE sid=?";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
		ps2 = conn.prepareStatement(query1);
		ps2.setString(1, fname1);
		ps2.setString(2, lname1);
		ps2.setString(3, email1);
		ps2.setString(4, address1);
		ps2.setString(5, phno1);
		ps2.setString(6, uid1);
		int i = ps2.executeUpdate();
		response.sendRedirect("Vendors.jsp");
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