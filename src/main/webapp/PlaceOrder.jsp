<%@page import="java.util.UUID"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders JSP</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
HttpSession httpSession = request.getSession();
String guid=(String)httpSession.getAttribute("currentuser");
Connection conn=null;
ResultSet rs=null;
ResultSet rs1=null;
PreparedStatement ps=null;
PreparedStatement ps2=null;
PreparedStatement ps1=null;
PreparedStatement ps3=null;
PreparedStatement ps4=null;
PreparedStatement ps5=null;
PreparedStatement ps6=null;

int c;
int amt = Integer.parseInt(request.getParameter("amt"));

String query="select pid,pname,quantity,price from cart where uid=?";
String query2="insert into orders(pid,uid,quantity,price,oid,pname) values(?,?,?,?,?,?)";
String query1="select sid,quantity,pid from inventory where pid=? order by quantity desc";
String query3="update inventory set quantity=? where sid=? and pid=?";
String query4="insert into bills(bid,uid,amt,status) values(?,?,?,?)";
String query5="insert into bill_orders(bid,oid) values(?,?)";
String query6="delete from cart where uid=?";

try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","1234");
	ps=conn.prepareStatement(query);
	ps1=conn.prepareStatement(query1);
	ps2=conn.prepareStatement(query2);
	ps3=conn.prepareStatement(query3);
	ps4=conn.prepareStatement(query4);
	ps5=conn.prepareStatement(query5);
	ps6=conn.prepareStatement(query6);
	ps.setString(1,guid);
	rs=ps.executeQuery();
	
	String bid = UUID.randomUUID().toString().replace("-", "");
	
	while(rs.next())
	{
		c=rs.getInt("quantity");
		
		ps1.setString(1,rs.getString("pid"));
		rs1=ps1.executeQuery();
			
		while(rs1.next()){ 	
			if(c != 0){
				
				if(c <= rs1.getInt("quantity")){
					ps3.setInt(1,rs1.getInt("quantity") - c);
					ps3.setString(2,rs1.getString("sid"));
					ps3.setString(3,rs.getString("pid"));
					c = 0;
				}else{	
					c = c - rs1.getInt("quantity");
					ps3.setInt(1,0);
					ps3.setString(2,rs1.getString("sid"));
					ps3.setString(3,rs.getString("pid"));
				}
				ps3.executeUpdate();
			}else{
				break;
			}	
		}
		
		String oid = UUID.randomUUID().toString().replace("-", "");
		
		ps2.setString(1,rs.getString("pid"));
		ps2.setString(2,guid);
		ps2.setInt(3,rs.getInt("quantity"));
		ps2.setString(4,rs.getString("price"));
		ps2.setString(5,oid);
		ps2.setString(6,rs.getString("pname"));
		ps2.addBatch();
		
		ps5.setString(1, bid);
		ps5.setString(2, oid);
		ps5.addBatch();
		
	}
	
	ps2.executeBatch();
	
	ps4.setString(1,bid);	
	ps4.setString(2,guid);
	ps4.setInt(3,amt);
	ps4.setString(4,"SENT");
	ps4.executeUpdate();
	
	ps5.executeBatch();
	
	ps6.setString(1, guid);
	ps6.executeUpdate();
	response.sendRedirect("CustomerOrders.jsp");
}
catch(Exception E)
{
	out.println(E);
}
finally {
	  	try { if (rs != null) rs.close(); } catch (Exception e) {};
	  	try { if (rs1 != null) rs1.close(); } catch (Exception e) {};
	  	try { if (ps != null) ps.close(); } catch (Exception e) {};
	  	try { if (ps1 != null) ps1.close(); } catch (Exception e) {};
	  	try { if (ps2 != null) ps2.close(); } catch (Exception e) {};
	  	try { if (ps3 != null) ps3.close(); } catch (Exception e) {};
	  	try { if (ps4 != null) ps4.close(); } catch (Exception e) {};
	  	try { if (ps5 != null) ps5.close(); } catch (Exception e) {};
		try { if (conn != null) conn.close(); } catch (Exception e) {};
}
%>
</body>
</html>
