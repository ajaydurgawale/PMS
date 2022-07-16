<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ReStock</title>
<link rel="stylesheet" href="css/Buy.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(function() {
		$("#header").load("VendorHeader.html");
	});
</script>
</head>
<body>
	<div id="header"></div>
	<div class="active">
		<%@ page import="java.sql.*"%>
		<%@ page import="javax.sql.*"%>
		<%@page import="java.util.Base64"%>
		<%
		HttpSession httpSession = request.getSession();
		String guid = (String) httpSession.getAttribute("currentuser");
		%>
		<div class="filler"></div>
		<%
		int flag = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		ResultSet rs1 = null;
		PreparedStatement ps1 = null;
		java.sql.Connection conn = null;
		String query = "select p.pid,p.image,i.quantity,p.pname,p.manufacturer,p.price from product p,inventory i where p.pid=i.pid and i.sid=?";
		String query1 = "select pid,pname,restockqty from inventory where sid = ?";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "1234");
			ps = conn.prepareStatement(query);
			ps.setString(1, guid);
			rs = ps.executeQuery();
			ps1 = conn.prepareStatement(query1);
			ps1.setString(1, guid);
			rs1 = ps1.executeQuery();
		%>
		<div class="filler2"></div>
		<div class="block">
			<%
			while (rs1.next()) {
				if (rs1.getInt("restockqty") > 0) {
					String pid = rs1.getString("pid");
					String qty = rs1.getString("restockqty");
			%>
			<form action="UpdateInventory.jsp?pid=<%= pid %>&restock=<%=qty %>" method="post">
			<p>
					<b>ID: </b><%=rs1.getString("pid")%> &nbsp &nbsp &nbsp 	
					<b>Product Name: </b><%=rs1.getString("pname")%>  &nbsp &nbsp &nbsp
					<b>Re-stock Qty: </b><%=rs1.getString("restockqty")%>  &nbsp &nbsp &nbsp &nbsp
				<button>Re-stock</button></p>
			</form>

			<%
			}
			}
			while (rs.next()) {
			if (flag == 4) {
			flag = 1;
			%>
		</div>
		<div class="filler2"></div>
		<%
		} else
		flag++;
		byte[] imgData = rs.getBytes("image");
		String encode = Base64.getEncoder().encodeToString(imgData);
		%>
		<div class="row">
			<div class="column">
				<div class="card">
					<form action="UpdateInventory.jsp" method="post">
						<img src="data:image/jpeg;base64,<%=encode%>" width=180 height=200>
						<h1><%=rs.getString("pname")%></h1>
						<p>
							<b>ID: </b><%=rs.getString("pid")%></p>
						<p>
							<b>Manufacturer: </b><%=rs.getString("manufacturer")%></p>
						<p>
							<b>Stock: </b><%=rs.getInt("quantity")%></p>
						<p>
							<b>Price: </b><%=rs.getInt("price")%></p>
						<input type="hidden" name="pid" value="<%=rs.getString("pid")%>">
						<%-- <p><input type="text" name="restock" placeholder="quantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" required></p>
							<p></p>
  							<button>ReStock</button> --%>
					</form>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<%
	} catch (Exception e) {
	out.println("error: " + e);
	} finally {
	try {
		if (rs != null)
			rs.close();
	} catch (Exception e) {
	}
	;
	try {
		if (ps != null)
			ps.close();
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
