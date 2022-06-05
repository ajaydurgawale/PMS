<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Vendors</title>
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
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String gid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select fname,sid,phno,email from seller";
		try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
		<table class="tables">
			<tr>
    			<th>Vendor ID</th>
    			<th>Name</th>
    			<th>Phone No</th>
    			<th>Email</th>
    			<th>Action</th>
  			</tr>
		<%while(rs.next()) 
		{
			%>
	  		
  			<tr>
    			<td><%=rs.getString("sid") %></td>
    			<td><%=rs.getString("fname") %></td>
    			<td><%=rs.getInt("phno") %></td>
    			<td><%=rs.getString("email") %></td>
    			<td>
					<div class="action-btn">
						<a href="UpdateVendor.html?id=<%=rs.getString("sid") %>">Edit</a> 
						<a href="DeleteVendor.jsp?id=<%=rs.getString("sid") %>" >Delete</a>
					</div>
				</td>
  			</tr>
  			
		<%
	}
		%>
		</table>
		</div>
		<% 
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
</body>
</html>
