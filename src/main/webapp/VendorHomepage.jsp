<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" href="css/Homepage.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script> 
$(function(){
  $("#header").load("VendorHeader.html"); 
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
    String guid=(String)httpSession.getAttribute("currentuser");
    %>
    <div class="filler"></div>
    <h2>Welcome <%=guid%></h2>
    <%
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select fname,sid,address,phno,email from seller where sid=?";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps=conn.prepareStatement(query);
		ps.setString(1,guid);
		rs=ps.executeQuery();
		if(rs.next())
		{
		%>
		<div class="filler2"></div>
			<div class="card">
  				<img src="images/vendor.png" class="Avatar" width=264 height=194>
  				<div class="container">
    				<h4><b><%=rs.getString("fname") %></b></h4>
   					<p><b>ID: </b><%=rs.getString("sid") %> </p>
   					<p><b>Address: </b><%=rs.getString("address") %></p>
   					<p><b>Phone: </b><%=rs.getString("phno") %></p>
  				</div>
			</div>
		<%
		}
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
  	  	try { if (rs != null) rs.close(); } catch (Exception e) {};
    	try { if (ps != null) ps.close(); } catch (Exception e) {};
   		try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	%>
</div>
</body>
</html>
