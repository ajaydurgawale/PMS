<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy</title>
<link rel="stylesheet" href="css/Buy.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script> 
$(function(){
  $("#header").load("CustomerHeader.html"); 
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
    <form>
    <input type="text" name="pname">
    <input type="submit" value="Search">
    </form>
    <%
    int flag=0;
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	
	String name = request.getParameter("pname");
	String query;
	if(name != null && name.length() > 0){
		query="SELECT p.pname,p.pid,p.manufacturer,p.price,p.image,SUM(i.quantity) AS quantity FROM product p,inventory i WHERE p.pid=i.pid AND p.name LIKE '%" + name + "%' GROUP BY p.pid";
	}else{
		query="SELECT p.pname,p.pid,p.manufacturer,p.price,p.image,SUM(i.quantity) AS quantity FROM product p,inventory i WHERE p.pid=i.pid GROUP BY p.pid";
	}
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
				<div class="block">
				<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%></div><div class="filler2"></div><%
				}
			else
			flag++;
			byte[] imgData = rs.getBytes("image");
			String encode = Base64.getEncoder().encodeToString(imgData);
		%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    				<img src="data:image/jpeg;base64,<%=encode%>" width=180 height=200>
  					<h1><%=rs.getString("pname") %></h1>
  					<p><b>ID: </b><%=rs.getString("pid") %></p>
					<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
					<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
					<p><b>Price: </b><%=rs.getInt("price") %></p>
					<%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="AddToCart.jsp" method="post">
  					<input type="number" name="quantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs.getInt("quantity") %>" required >
  					<p><input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<input type="hidden" name="price" value="<%=rs.getInt("price") %>">
  					<input type="hidden" name="pname" value="<%=rs.getString("pname") %>">
  					</p>
  					<button>Add to Cart</button></form></div>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button>Out Of Stock</button></div>
  					<% 
  						} 
  					%>
  				</div>
  				<%
  				}
				%>
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
