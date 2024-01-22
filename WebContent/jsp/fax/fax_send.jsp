<%------------------------------------------------------------
 * Title       : 웹단말에서 팩스보내기
 * Description : 
 * Author      : 방승호, 박우영
 * Date        : 2011.10.13
 * version     : V 1.0
--------------------------------------------------------------%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.rmi.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.jdbc.datasource.DataSourceUtils"%>

<%

	String[] ibkOpenIp = new String[] { "203.235.68", "203.235.72", "134.100.", "134.102.", "10.", "20.", "127.0.0.1" ,"192.168.153"};
	//String userIp = request.getRemoteAddr();
	String userIp = request.getHeader("X-Forwarded-For");
	
	boolean ipAuthUser = false;
	
	if (userIp != null) {
		for (int i = 0; i < ibkOpenIp.length; i++) {
			if (userIp.indexOf(ibkOpenIp[i]) > -1) {
				ipAuthUser = true;
			}
		}   
	}
	
	System.out.println("##############################");
	System.out.println("userIp : "+userIp);
	
	String result ="0";

	if(ipAuthUser){
    	StringBuffer query = new StringBuffer();
        
        query.append("INSERT                            \n");
        query.append("  INTO KIUPSMS.SEND_REQ           \n");
        query.append("      (FID,                       \n");
        query.append("       KEY_ID,                    \n");
        query.append("       SUB_ID,                    \n");
        query.append("       FROM_INFO,                 \n");
        query.append("       TO_N,                      \n");
        query.append("       TO_INFO,                   \n");
        query.append("       SUBJ,                      \n");
        query.append("       DOC_NAME,                  \n");
        query.append("       SEND_FLAG,                 \n");
        query.append("       REG_TIME                   \n");
        query.append("      )                           \n");
        query.append("VALUES                            \n");
        query.append("      (KIUPSMS.EM_TRAN_MASTER_PR.NEXTVAL, \n");
        query.append("       ?,                         \n");
        query.append("       ?,                         \n");
        query.append("       ?,                         \n");
        query.append("       ?,                         \n");
        query.append("       ?,                         \n");
        query.append("       ?,                         \n");
        query.append("       ?,                         \n");
        query.append("       'B',                       \n");
        query.append("       ?                          \n");
        query.append("      )                           \n");
    
        Context ctx = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        
        Connection con			= null;
        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(pageContext.getServletContext());
        DataSource ds = (DataSource) wac.getBean("dataSource");
        con = DataSourceUtils.getConnection(ds);
    
        out.println(ds);
        out.println("<br/>");
        out.println(con);
        
        String colname = null;
        int cnt=0;
        
        System.out.println("SUB_PHONE : ["+request.getParameter("SUB_PHONE")+"]");
        System.out.println("BRNO : ["+request.getParameter("BRNO")+"]");
        System.out.println("EMPL_ID : ["+request.getParameter("EMPL_ID")+"]");
        System.out.println("SUBJECT : ["+request.getParameter("SUBJECT")+"]");
        System.out.println("ATTACH_FILE : ["+request.getParameter("ATTACH_FILE")+"]");
        System.out.println("SEND_TIME : ["+request.getParameter("SEND_TIME")+"]");
    
        if ( query != null && !"".equals(query) ) {
        	try {
        		//conMgr = DBConnectionMgr.getInstance();
                //con = conMgr.getConnection();
    
        		pstmt = con.prepareStatement(query.toString());
        		
        		String strKeyID = "FAXH" + Long.toString(System.currentTimeMillis());
        		String strSubID = "H" + request.getParameter("BRNO")+"_"+request.getParameter("EMPL_ID");
    			StringBuffer sbToInfo = new StringBuffer();
    			sbToInfo.append(request.getParameter("SUB_PHONE"));
    			sbToInfo.append("(");
    			sbToInfo.append(request.getParameter("SUB_PHONE"));
    			sbToInfo.append(")");
    			sbToInfo.append("|");
        		
        		pstmt.setString(1,strKeyID);
        		pstmt.setString(2,strSubID);
        		pstmt.setString(3,"15882588");
        		pstmt.setInt(4,1);
        		//수신번호
        		pstmt.setString(5,sbToInfo.toString());
        		//제목
        		pstmt.setString(6,request.getParameter("SUBJECT"));
        		//파일명
        		pstmt.setString(7,request.getParameter("ATTACH_FILE"));
                //발송시간
                pstmt.setString(8,request.getParameter("SEND_TIME"));
                
        		cnt = pstmt.executeUpdate();
    
    			if(cnt == 1){
    				result = "1";
    			}else{
    				result = "0";
    			}
    
    			System.out.println("result : " + result);
        	}
        	catch (Exception e) {
        		e.printStackTrace();
        		System.out.println(e.toString());
        		out.print( e.getMessage() );
        	}
        	finally {
				try {
					if (rs != null) {
						rs.close();
						//rs = null;
					}
					if (pstmt != null) {
						pstmt.close();
						//pstmt = null;
					}
					if (con != null) {
						//con.close();
						//con = null;
//						DataSourceUtils.releaseConnection(conn, dataSource);
						DataSourceUtils.releaseConnection(con, ds);
					}
					
				}
				 catch (Exception e) {
					e.printStackTrace();
				}
        	}
        }
    }
%>

<html>
    <head>
        <title>IBK WEB MAIL</title>
    </head>

    <body>
	<%=result%>
    </body>
</html>

