<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Inventory</title>
</head>
<body>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
String pid=request.getParameter("pid");
String prname=request.getParameter("pname");
String mfname=request.getParameter("mfg");
String price1=request.getParameter("price");
String sid=request.getParameter("vendors");

HttpSession httpSession = request.getSession();
String guid=(String)httpSession.getAttribute("currentuser");
ResultSet rs=null;
Connection conn=null;
PreparedStatement ps=null;
PreparedStatement ps1=null;
String query="insert into inventory(pid,pname,sid,quantity) values (?,?,?,0)";
String query1 = "select pid from inventory where pid=? and sid=?";
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
	ps=conn.prepareStatement(query);
	ps1=conn.prepareStatement(query1);
	ps1.setString(1,pid);
	ps1.setString(2,sid);
	rs = ps1.executeQuery();
	if(!rs.next()){
	ps.setString(1,pid);
	ps.setString(2,prname);
	ps.setString(3,sid);
	ps.executeUpdate();
	}
	response.sendRedirect("ManageProducts.jsp");
}
catch(Exception e)
{
	out.println(e);
}
finally {
	try { if (rs != null) rs.close(); } catch (Exception e) {};
	try { if (ps != null) ps.close(); } catch (Exception e) {};
	try { if (conn != null) conn.close(); } catch (Exception e) {};
}

%>

</body>
</html>
