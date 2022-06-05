<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payments JSP</title>
<link rel="stylesheet" href="css/Payment.css">
</head>
<body>
<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
	String guid=(String)httpSession.getAttribute("currentuser");
	
    String pid= request.getParameter("pid");
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	String pname = request.getParameter("pname");
	int price = Integer.parseInt(request.getParameter("price"));
	
	String query="insert into cart(pid,pname,quantity,price,uid) values (?,?,?,?,?)";
	String query1="select pid from cart where pid=? and uid=?";
	String query2="update cart SET quantity=? where pid=? and uid=?";
	
	ResultSet rs=null;
	Connection conn=null;
	PreparedStatement ps=null;
	PreparedStatement ps1=null;
	PreparedStatement ps2=null;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps1=conn.prepareStatement(query1);
		ps1.setString(1,pid);
		ps1.setString(2,guid);
		rs = ps1.executeQuery();
		if(!rs.next()){
		ps=conn.prepareStatement(query);
		ps.setString(1,pid);
		ps.setString(2,pname);
		ps.setInt(3,quantity);
		ps.setInt(4,price);
		ps.setString(5,guid);
		ps.executeUpdate();
		}else{
			ps2=conn.prepareStatement(query2);
			ps2.setInt(1,quantity);
			ps2.setString(2,pid);
			ps2.setString(3,guid);
			ps2.executeUpdate();
		}
		response.sendRedirect("Buy.jsp");
	}catch(Exception e)
	{
		System.out.println(e);
	}
finally {
	try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (ps1 != null) ps1.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	
    %>
</body>
</html>