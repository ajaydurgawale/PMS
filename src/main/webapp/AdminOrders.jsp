<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<link rel="stylesheet" href="css/Orders.css">
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
    String guid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	
	String query = "select bid,orderdatetime,status,amt,uid from bills";
		try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
		%><div class="filler2"></div>
		<table class="tables">
			<tr>
    			<th>Bill ID</th>
    			<th>Customer</th>
    			<th>Status</th>
    			<th>Amount</th>
    			<th>Order Date and Time</th>
    			<th>Action</th>
  			</tr>
		<%while(rs.next()) 
		{
			%>
	  		
  			<tr>
    			<td><%=rs.getString("bid") %></td>
    			<td><%=rs.getString("uid") %></td>
    			<td><%=rs.getString("status") %></td>
    			<td><%=rs.getInt("amt") %></td>
    			<td><%=rs.getTimestamp("orderdatetime") %></td>
    			<td>
    			<div class="action-btn">
					<a href="AdminBillDetails.jsp?id=<%=rs.getString("bid") %>">Details</a>
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
