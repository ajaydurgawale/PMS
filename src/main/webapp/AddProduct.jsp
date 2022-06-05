<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AddProduct JSP</title>
</head>
<body>
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%@ page import="java.lang.Object.*" %>
	<%@ page import="java.io.*" %>
	<%
		HttpSession httpSession = request.getSession();
		String guid=(String)httpSession.getAttribute("currentuser");

		String prname=request.getParameter("prname");
		String prid=request.getParameter("prid");
		String mfname=request.getParameter("mfname");
		String price1=request.getParameter("price");
		int price=Integer.parseInt(price1);
		
		InputStream inputStream = null;
		Part filePart = request.getPart("photo");
		if (filePart != null) {
            inputStream = filePart.getInputStream();
        }
		

		String query1="select pid from product where pid=?";
		String query2="insert into product(pid,pname,manufacturer,price,image) values (?,?,?,?,?)";

		ResultSet rs=null;
		Connection conn=null;
		PreparedStatement ps1=null;
		PreparedStatement ps2=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
			ps1=conn.prepareStatement(query1);
			ps1.setString(1,prid);
			rs=ps1.executeQuery();
			if(!rs.next())
			{
				ps2=conn.prepareStatement(query2);
				ps2.setString(1,prid);
				ps2.setString(2,prname);
				ps2.setString(3,mfname);
				ps2.setInt(4,price);
				ps2.setBlob(5,inputStream);
				int i=ps2.executeUpdate();
				response.sendRedirect("Products.jsp");
			}
			else
			{
				response.sendRedirect("AddProductError.html");
			}
	}
	catch(Exception e)
		{
		out.println("error: "+e);
		response.sendRedirect("AddProductError2.html");
		}
	finally {
		    try { if (rs != null) rs.close(); } catch (Exception e) {};
		    try { if (ps1 != null) ps1.close(); } catch (Exception e) {};
		    try { if (ps2 != null) ps2.close(); } catch (Exception e) {};
		    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
%>
</body>
</html>