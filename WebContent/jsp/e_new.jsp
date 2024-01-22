<%@ page language="java" import="java.util.*, java.io.*, java.lang.*,java.text.*" contentType="text/html;charset=utf-8" %>

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

<html>
    <head>
        <title> SMS 대량 전송 내역 결제 </title>
    </head>
    <body>    
    
    <table> 
<%
	String userIp = request.getRemoteAddr();
	boolean ipAuthUser = true;



	//ROW LOCK을 위해 해당 그룹에 대한 모든 결재선 업데이트 
    StringBuffer query0 = new StringBuffer();
    query0.append(" UPDATE DACOM_DIST.TB_CMC_DRF001M  SET AGREE_STATUS = AGREE_STATUS \n");
	query0.append(" WHERE AGREE_TYPE=4   \n");
	query0.append(" AND  GROUP_UNIQ_NO = ? \n");

	//직원 결재 업데이트 
    StringBuffer query1 = new StringBuffer();
    query1.append(" UPDATE DACOM_DIST.TB_CMC_DRF001M  SET AGREE_STATUS = ? ,CONFIRM_YMS=to_char(sysdate,'yyyymmddHH24MISS') \n");
	query1.append(" WHERE AGREE_TYPE=4   \n");
	query1.append(" AND  GROUP_UNIQ_NO = ? AND EMPL_ID=?\n");

    //결재 상태 조사
    StringBuffer query2 = new StringBuffer();
    query2.append("SELECT 																");
	query2.append("SUM(1) AS CNT,														");
	query2.append("     SUM(DECODE(AGREE_STATUS,'G',1,0)) AS CNT_G, 					");
	query2.append("       SUM(DECODE(AGREE_STATUS,'N',1,0)) AS CNT_N,					");
	query2.append("		MAX(F.PRCSS_STUS_DSTIC) AS ST26									");
    query2.append(" FROM DACOM_DIST.TB_CMC_DRF001M P 									");
	query2.append("left join DACOM_DIST.TB_CMC_DRF002M M on P.GROUP_UNIQ_NO = M.GROUP_UNIQ_NO	");
	query2.append("left join DACOM_DIST.TB_CMC_DRF003M F on M.BATCH_TAGT_UNIQ_NO = F.BATCH_TAGT_UNIQ_NO	");
	query2.append(" WHERE M.GROUP_UNIQ_NO = ?	");

    
    StringBuffer query3 = new StringBuffer();
    query3.append("UPDATE DACOM_DIST.TB_CMC_DRF002M  \n");
	query3.append("   SET PRCSS_STUS_DSTIC   = ?  \n");
	query3.append(" WHERE GROUP_UNIQ_NO  = ? \n");
	
    PreparedStatement pstmt0 = null;    
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;
    PreparedStatement pstmt3 = null;
    Connection con			 = null;
    ResultSet rs1            = null;

    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(pageContext.getServletContext());
	DataSource ds = (DataSource) wac.getBean("dataSource");
	con = DataSourceUtils.getConnection(ds);
    
    int cnt=0;
    int approvalCnt=0;
    String sTmp = "X";
    
    System.out.println("PROMOTION_CD : ["+request.getParameter("PROMOTION_CD")+"]");
    System.out.println("EMPL_ID      : ["+request.getParameter("EMPL_ID")+"]");
    System.out.println("APPROVAL_CD  : ["+request.getParameter("APPROVAL_CD")+"]");

    String sUrl = "/jsp/p_new.jsp?p="+request.getParameter("PROMOTION_CD")+"&e="+request.getParameter("EMPL_ID");
    System.out.println("sUrl : " + sUrl );
   
    if ( query1 != null && !"".equals(query1) ) {
        try {
   		    //conMgr = DBConnectionMgr.getInstance();
            //con = conMgr.getConnection();


            pstmt0 = con.prepareStatement(query0.toString());
            pstmt0.setString(1,request.getParameter("PROMOTION_CD"));
            cnt = pstmt0.executeUpdate();
            pstmt0.clearParameters();
   
            pstmt1 = con.prepareStatement(query1.toString());
               
            pstmt1.setString(1,request.getParameter("APPROVAL_CD"));
            pstmt1.setString(2,request.getParameter("PROMOTION_CD"));
            pstmt1.setString(3,request.getParameter("EMPL_ID"));
            cnt = pstmt1.executeUpdate();
            pstmt1.clearParameters();
            
            pstmt2 = con.prepareStatement(query2.toString());
            pstmt2.setString(1,request.getParameter("PROMOTION_CD"));            
			rs1 = pstmt2.executeQuery();

			if(rs1.next()){
			    if ( rs1.getInt("CNT") ==  rs1.getInt("CNT_G") ) {
			    	sTmp= (rs1.getString("ST26")!=null && rs1.getString("ST26").equals("D")) ?"Y":"R" ;
			    } else if ( 0 <  rs1.getInt("CNT_N") ) {
			    	sTmp="N" ;
			    }
			}
			pstmt2.close();
			rs1.close();

			//1개 이상의 반려, 또는 전체 승인이 된 경우
            if ( sTmp.equals("Y") || sTmp.equals("N") || sTmp.equals("R") ) {
			  pstmt3 = con.prepareStatement(query3.toString());
			  pstmt3.setString(1,sTmp);
			  pstmt3.setString(2,request.getParameter("PROMOTION_CD"));
			  pstmt3.executeUpdate();
			  pstmt3.close();
            }
            if(cnt == 1){
            %>
                <!--정상처리 되었습니다.-->
                <script type="text/javascript">
                    alert('정상처리 되었습니다.');
                    location.href='<%=sUrl%>';
                </script>

            <%
            }
            else{
            %>
                <!--비정상처리 되었습니다.-->
                <script type="text/javascript">
                    alert('비정상처리 되었습니다.');
                    location.href='<%=sUrl%>';
                </script>
            <%         
            
            }
        }
       	catch (Exception e) {
       		e.printStackTrace();
            %> "에러발생 : " 
            <%=e.toString()%>
            <%
       		System.out.println(e.toString());
       		out.print( e.getMessage() );
       	}
   	    finally {
            try {				
				if (pstmt0 != null) {
					pstmt0.close();
				}
				if (pstmt1 != null) {
					pstmt1.close();
				}
				if (pstmt2 != null) {
					pstmt2.close();
				}
				if (pstmt3 != null) {
					pstmt3.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (con != null) {
					DataSourceUtils.releaseConnection(con, ds);
				}
				
			}
			catch (Exception e) {
				e.printStackTrace();
			}
   	    }                         
    } 
   
    %>
    </body>
</html>