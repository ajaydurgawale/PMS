<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
<link rel="stylesheet" href="css/Buy.css">
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
	<%@page import="java.util.Base64"%>
	<%
	HttpSession httpSession = request.getSession();
    String uid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select p.pname,p.pid,p.manufacturer,p.price,p.image from product p";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
		<div class="block">
			<div class="button">
				<a href="ManageProducts.jsp">Manage Products</a>
			</div>
			<div class="filler2"></div>
			<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%>
		</div>
		<div class="filler2"></div><%
				}
			else
			flag++;
			byte[] imgData = rs.getBytes("image");
			String encode = Base64.getEncoder().encodeToString(imgData);
		%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    				<img src="data:image/jpeg;base64,<%=encode%>"  width=180 height=200>
  					<h1><%=rs.getString("pname") %></h1>
  					<p><b>ID: </b><%=rs.getString("pid") %></p>
					<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
					<p><b>Price: </b><%=rs.getInt("price") %></p>
  				</div>
  			</div>
  				<%
  				}
				%>
			</div>
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
