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
	String pid = request.getParameter("pid");
	String qty = request.getParameter("qty");
	String sid = request.getParameter("sid");

	PreparedStatement ps1 = null;
	Connection conn = null;
	ResultSet rs = null;
	String query1 = "UPDATE inventory SET restockqty=? where pid=? and sid=?";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
		ps1 = conn.prepareStatement(query1);
		ps1.setString(1, qty);
		ps1.setString(2, pid);
		ps1.setString(3, sid);
		ps1.executeUpdate();

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
			if (ps1 != null)
		ps1.close();
		} catch (Exception e) {
		}
	}
	%>
</body>
</html>