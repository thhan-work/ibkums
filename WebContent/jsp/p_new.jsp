<%@ page language="java" contentType="text/html;charset=utf-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.rmi.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.jdbc.datasource.DataSourceUtils"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%!

	public  StringBuffer var2message(String template , HashMap hash) 
	{
		StringBuffer retBuf = new StringBuffer(template);
		if ( retBuf == null ) return null;
		
		Set cols = hash.keySet() ;
		Iterator itr = cols.iterator() ;
		// 템플릿에 변수가 남아 있는 조건을 추가하여, 불필요한 템플릿 검사 횟수를 줄임.
		while( itr.hasNext()  && retBuf.indexOf("${")!=-1   )
		{
			String Key = itr.next().toString();
//			템플릿 내 $문자와의 혼동을 방지하기 위해 새로운 변수 패턴  ${변수명}을 사용한다.
			String newKey = "${" + Key + "}";		
			String Value = hash.get(Key).toString();
//			System.out.println("key " + Key + " v=" + Value);
			//Convert VarField to VarValue
			int sbIdx = 0;
			int sbCnt = 0;
//			System.out.println( "retBuf=" + retBuf.toString());
			int pos= 0; //변수값에 ${} 변수 포멧을 쓰는 경우. 무한루프가 되는 버그 패치( 2017.02.28 kbcard )
			for (int i = 0 ; (sbIdx = retBuf.indexOf(newKey,pos))!= -1 && i < 4096 ; i++)
			{
				//retBuf.replace(sbIdx, sbIdx + NAME_VAL_SIZE(6), Value);
				retBuf.replace(sbIdx, sbIdx + newKey.length(), Value);
//				System.out.println( "retBuf=" + retBuf.toString());
				pos = sbIdx + Value.length();
				sbCnt++;
			}
			//if (sbCnt==0) return null;
		}
		
		//if (retBuf.indexOf("$VAL")!=-1) return null;
		//if (retBuf.indexOf("${")!=-1) return null;
		
	
		return retBuf;
	}
	
	public HashMap<String, String> jsonToMap(String json){
		HashMap<String,String> map = new HashMap<String,String>(15);
		return (HashMap<String,String>) new Gson().fromJson(json, map.getClass());
	}

%>

<% 
pageContext.setAttribute("cr","\r");
pageContext.setAttribute("crlf","\r\n");
pageContext.setAttribute("lf","\n");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SMS 대량 전송 내역 결재내역 확인</title>

        <link href="sms_c.css" rel="stylesheet" type="text/css" />

        <script language="JavaScript">

            function offer(app_cd) {
                    //var f = document.searchForm;
                var f = document.promotion;    
                f.APPROVAL_CD.value = app_cd;
                
                if(f.APPROVAL_CD.value == 'G'){
                    if(confirm('결재 처리 하시겠습니까?') == true){

						f.action="/jsp/e_new.jsp"
                        f.submit();
                    }
                    else{
                        return ;
                    }
                }
                else{
                    if(confirm('반려 처리 하시겠습니까?') == true){
                        f.action="/jsp/e_new.jsp"
                        f.submit();
                    }
                    else{
                        return ;
                    }
                }
                //alert(f.APPROVAL_CD.value);                
            }
        </script>
    </head>


<%
	String userIp = request.getRemoteAddr();
	
	boolean ipAuthUser = true;

    //자신의 결재여부 체크 결재된 내역이 존재하면 화면상 버튼이 안 보이게 함
    boolean bApprFlag = true;


	if(ipAuthUser){
    	StringBuffer query = new StringBuffer();
       query.append(" SELECT M.*,D.*,P.*,E.* FROM DACOM_DIST.TB_CMC_DRF002M M left join DACOM_DIST.TB_CMC_DRF002D  D on \n");	//		TB_CMC_DRF002M (T21 기안 정보 테이블) / TB_CMC_DRF002D (T21 기안 상세 정보 테이블)
        query.append(" M.GROUP_UNIQ_NO= D.GROUP_UNIQ_NO \n" ) ;
        query.append(" left join kiupsms.part_info P on P.BO_CODE = D.BO_CODE \n" ) ;
        query.append(" left join KIUPSMS.EMPLOYEE_INFO E on (E.EMPL_ID = M.SEND_EMPID OR E.EMPL_ID_OTHER = M.SEND_EMPID ) \n" ) ;
		query.append(" WHERE M.GROUP_UNIQ_NO = ? \n");

    	StringBuffer ctntQuery = new StringBuffer();
        ctntQuery.append(" SELECT * FROM DACOM_DIST.TB_CMC_DRF003D where BATCH_TAGT_UNIQ_NO in  \n");
        ctntQuery.append(" ( SELECT BATCH_TAGT_UNIQ_NO FROM DACOM_DIST.TB_CMC_DRF002M WHERE GROUP_UNIQ_NO = ?) AND ROWNUM < 2 \n");

        StringBuffer apprQuery = new StringBuffer();
        apprQuery.append("SELECT * FROM DACOM_DIST.TB_CMC_DRF001M M");
        apprQuery.append(" left join KIUPSMS.EMPLOYEE_INFO E on (E.EMPL_ID = M.EMPL_ID OR E.EMPL_ID_OTHER = M.EMPL_ID )\n" ) ;
        apprQuery.append(" left join kiupsms.part_info P on P.BO_CODE = E.BO_CODE \n" ) ;
		apprQuery.append(" WHERE M.AGREE_TYPE=4   \n");
		apprQuery.append(" AND  M.GROUP_UNIQ_NO = ? \n");
		apprQuery.append(" ORDER BY part_name, M.EMPL_ID \n");

        StringBuffer sbStmt = new StringBuffer();
        
        int nMsgStartArr[] = new int[100];
		int nMsgEndArr[] = new int[100];
		String sArr[] = new String[100];
		String sMsgArr[] = new String[100];
		boolean bMsg[] = new boolean[100];
        int startIdx = 0;
		int endIdx = 0;
			
	    String sendMessage="";
	    String sendCd = "";
        String approvalCd = "";
        String sendGbCd = "";
			
		PreparedStatement pStmt = null;
        ResultSet rs = null;
        
        Context ctx = null;
        PreparedStatement pstmt = null;
        ResultSet dataRs = null;
        
        PreparedStatement apprPstmt = null;
        ResultSet apprRs = null;
        
        Connection con			= null;
        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(pageContext.getServletContext());
		DataSource ds = (DataSource) wac.getBean("dataSource");
        con = DataSourceUtils.getConnection(ds);
    
        System.out.println("PROMOTION_CD : ["+request.getParameter("p")+"]");
        System.out.println("EMPL_ID      : ["+request.getParameter("e")+"]");
    
		String ctntVars="{}";
        if ( query != null && !"".equals(query) ) {
        	try {
/* 대상자 1에서 가져오는 변수 로 치환 **/
/*
        		pstmt = con.prepareStatement(ctntQuery.toString());
        		pstmt.setString(1,request.getParameter("p"));
        		rs = pstmt.executeQuery();
                pstmt.clearParameters();
                if (rs.next()) {
                    ctntVars = rs.getString("REPLACE_VARIABLE_VAL");
				}
				pstmt.close();
				rs.close();
				pstmt = null;
				rs = null;
*/

        		pstmt = con.prepareStatement(query.toString());
        		pstmt.setString(1,request.getParameter("p"));
        		rs = pstmt.executeQuery();
                pstmt.clearParameters();
    
                if (rs.next()) {
					
					 ctntVars = rs.getString("REPLACE_VARIABLE_VAL");
                    sendCd = rs.getString("PRCSS_STUS_DSTIC");
                    approvalCd = rs.getString("PRCSS_STUS_DSTIC") ;
                    sendGbCd = rs.getString("MSG_DSTIC")+"S";

                    String sTranMsg = rs.getString("MSG_CTNT");
                    if ( sTranMsg == null || sTranMsg.trim().equals("") ) {
						sendMessage = "";
						sTranMsg = "";
					}else {
						sendMessage = var2message(sTranMsg,jsonToMap(ctntVars) ).toString();
					}
                    
					if ( !sendGbCd.equals("SMS") ) {
						String sLmsMsg = rs.getString("UMS_MSG_CTNT");
						if ( sLmsMsg == null || sLmsMsg.trim().equals("") ) {
							sendMessage = "";
						}else {
							sendMessage = var2message(sLmsMsg,jsonToMap(ctntVars)).toString();
						}
					}



					request.setAttribute("sendMessage", sendMessage);

%>

<body TOPMARGIN="0" LEFTMARGIN="0">
<div id="warp">
	<div class="header"><h2>SMS 대량 전송 내역 결재내역 확인</h2></div>
	<div class="board_body"><table  class="bb_tbl" width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr >
            <td class="board_left1">요청부서</td>
            <td class="bl1">|&nbsp;</td>
            <td class="board_right1"> <%=rs.getString("PART_NAME") %>(<%=rs.getString("SEND_BRNCD") %>)</td>
        </tr>
        
        <tr >
            <td class="board_left">요&nbsp;&nbsp;청&nbsp;&nbsp;자</td>
            <td class="bl">|&nbsp;</td>
            <td class="board_right"> <%=rs.getString("EMPL_NAME") %>(<%=rs.getString("SEND_EMPID") %>)</td>
        </tr>

        <tr >
            <td class="board_left">발송목적</td>
            <td class="bl">|&nbsp;</td>
            <td class="board_right"> <%=rs.getString("GROUP_NM") %></td>
        </tr>

        <tr >
            <td class="board_left">종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 류</td>
            <td class="bl">|&nbsp;</td>
            <td class="board_right"> <%=rs.getString("MSG_DSTIC") +"S" %></td>
        </tr>
      <%-- <tr >
        <td class="board_left">결재상태</td>
        <td class="bl">|&nbsp;</td>
        <td class="board_right"> 
        <% if(approvalCd.equals("I")) { %>
            결재대기
        <% }else if (approvalCd.equals("Y")) { %>
            결재완료
        <% }else if (approvalCd.equals("N")) {%>
            반려
        <% }else {%>
            기타(<%=approvalCd%>)
        <% }%>     
        </td>
      </tr> --%>

      <tr >
        <td class="board_left">발송상태</td>
        <td class="bl">|&nbsp;</td>
        <td class="board_right"> 
        <% if(sendCd.equals("C") || sendCd.equals("R") || sendCd.equals("I") || sendCd.equals("G") || sendCd.equals("B")) { %>
            발송전
        <% }else if (sendCd.equals("D")) { %>
            발송완료
        <% }else if (sendCd.equals("S")) {%>
            발송중
        <% }else if (sendCd.equals("N") || sendCd.equals("P")) {%>
            반려/중지
        <% }else {%>
            기타
        <% }%>
        <%-- (<%=sendCd%>) --%>
        </td>
      </tr>
      
    
      <% if (sendGbCd.equals("MMS")){ %>
      <tr >
        <td class="board_left">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 목</td>
        <td class="bl">|&nbsp;</td>
        <td class="board_right"> <%=sTranMsg%>  
        </td>
      </tr>
      <% } %>

      <tr >
        <td class="board_left">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 용</td>
        <td class="bl">|&nbsp;</td>
        <td class="board_right"> <c:out value="${fn:replace(sendMessage,lf,'<br/>')}" escapeXml="false" /> <!--%=sendMessage %--></td>

      </tr>

<%
String pengagYMS = rs.getString("PENGAG_YMS");
%>
      <tr>
        <td class="board_left2">발송시간</td>
        <td class="bl2">|&nbsp;</td>
        <td class="board_right2"><%=pengagYMS.substring(0,4)%>년 <%=pengagYMS.substring(4,6)%>월 <%=pengagYMS.substring(6,8)%>일 <%=pengagYMS.substring(8,10)%>시 <%=pengagYMS.substring(10,12)%>분</td>
      </tr>
    </table>
    </div>

    <p></p>


    <div class="header2">
        <h2> 결재내역 </h2>
	    <div class="board_body">
            <table  class="bb_tbl2" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr >
                    <td class="board_right_1">부서명</td>
                    <td class="board_right_1">직원번호</td>
                    <td class="board_right_1">이름</td>
                    <td class="board_right_1">결재상태</td>
                    <td class="board_right_2">결재시간</td>
                </tr>
        <%
            apprPstmt = con.prepareStatement(apprQuery.toString());
        		
        	apprPstmt.setString(1,request.getParameter("p"));
        		
        	apprRs = apprPstmt.executeQuery();
        	
            while(apprRs.next()){

                if(request.getParameter("e").equals(apprRs.getString("EMPL_ID"))){
//  bApprFlag = 기승인 여부 
                    bApprFlag =  apprRs.getString("AGREE_STATUS").equals("G") || apprRs.getString("AGREE_STATUS").equals("N")  ;
                }
            %>   
                
                <tr >
                    <td class="board_bottom" width="15%"><%= apprRs.getString("PART_NAME") %></td>
                    <td class="board_bottom" width="17%"><%= apprRs.getString("EMPL_ID") %></td>
                    <td class="board_bottom" width="12%"><%= apprRs.getString("EMPL_NAME") %></td>
                    <td class="board_bottom" width="17%">
                    <%
                    String agree_status = apprRs.getString("AGREE_STATUS");
                    if (agree_status.equals("G")) {
                    	out.println("승인");
                    } else if (agree_status.equals("N")) {
                    	out.println("반려");
                    } else if (agree_status.equals("I")) {
                    	out.println("결재대기중");
                    }
                    %>
                    <%-- (<%= agree_status %>) --%>
                    <%
						String CONFIRM_YMS = apprRs.getString("CONFIRM_YMS");
                    	String CONFIRM_YMS_FORMAT = "";
                    	if ( CONFIRM_YMS == null ) {
                    		CONFIRM_YMS_FORMAT = "";
                    	} else {
                    		CONFIRM_YMS_FORMAT = CONFIRM_YMS.substring(0,4) + "년" + CONFIRM_YMS.substring(4,6) + "월" + CONFIRM_YMS.substring(6,8) + "일"
                    							+ CONFIRM_YMS.substring(8,10) + "시" + CONFIRM_YMS.substring(10,12) + "분" ;
                    	}
					%>
                    </td>
                    <td class="board_bottom1" width="39%"><%= CONFIRM_YMS_FORMAT %></td>
                </tr>
            <%  
            }

            %>
            </table>
            <%     
                apprRs.close();
                apprPstmt.close();

                System.out.println("bApprFlag : " + bApprFlag);
            %>
        </div>   

    <div>

            <form id="promotion" name="promotion"  method="post">
                <input type="hidden" id="APPROVAL_CD"  name="APPROVAL_CD" />
                <input type="hidden" id="EMPL_ID"      name="EMPL_ID" value="<%=request.getParameter("e")%>" />
                <input type="hidden" id="PROMOTION_CD" name="PROMOTION_CD" value="<%=request.getParameter("p")%>" />
<!-- 기 승인자가 아니고, 마스터 플래그가 승인 가능한 상태 --->
                <% if(!bApprFlag && approvalCd.equals("I") ) { %>
                    <div class="btn_bottom">
                        <!--input type="text" name="button" id="button" tvalue="결재" /-->
                        <a href="javascript:offer('G')" > <img src="btn.gif" type="image" alt="결재" /></a> 
                    &nbsp;
                        <!--input type="text" name="button" id="button" value="반려" /-->
                        <a href="javascript:offer('N')"> <img src="btn2.gif" type="image" alt="반려" /> </a>
                    </div>
                <% } %>
                <!--<div></div>-->
				<!-- bApprFlag=<%=bApprFlag%>,approvalCd= <%=approvalCd%> -->
            </form>

<%
                }
                
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
					
					if (apprRs != null) {
						apprRs.close();
						//rs = null;
					}
					if (apprPstmt != null) {
						apprPstmt.close();
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

            
        </div>
    </body>
</html>

