<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="java.net.URLDecoder"%>

<%@page import="com.initech.eam.nls.CookieManager"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>::: [IBK] Message Center :::</title>
</head>
<body>
<script type="text/javascript">
try {
    <%-- 220523 v2 로컬일 경우 바로 일반 로그인 페이지로 이동 --%>
    <c:set var="PROFILES">
        <spring:eval expression="@environment.getActiveProfiles()"/>
    </c:set>
    var profiles = '<c:out value="${PROFILES}"/>';
    if(profiles != 'odinue_local') {
        var nexessObj = new ActiveXObject("IniNXClient.NClient.1");
    } else {
        self.location.replace("/login.ibk");
    }
}catch(e){
	var r = confirm("SSO(업무인증) Client 프로그램이 설치되어 있지 않습니다.\n프로그램 수동 설치 화면으로 이동하시겠습니까?\n확인: 수동 설치화면, 취소:메시지센터 로그인화면 이동");
	if (r == true) {
		self.location.replace("http://sso.ibk.co.kr/nls3/NCInstall.html");
	} else {
		self.location.replace("/motp_login.ibk");
	}
	
}
</script>

<!-- NC클라이언트 오브젝트 ID-->
<OBJECT ID="NEXESS_API" CLASSID="CLSID:D4F62B67-8BA3-4A8D-94F6-777A015DB612"  width=0 height=0></OBJECT>

<script language="javascript">

	//SSO Ticket 추출 및 APP_ID 접근 이력 업데이트
	var ticket = NEXESS_API.GetTicketAppWithEnc("CMCCMC001"); 
	//NC 클라이언트에서 인증 정보를 가져옴
	//응답코드 성공: 인증티켓, 실패: 2: 로그인 전 상태, 3: 중복 로그인, 4: 권한이 없음
	var response=false;
	if(ticket.length==1){
		if(ticket==2 ){
			response=confirm("업무인증 시스템에 로그인 되어 있지 않습니다.\n업무인증 로그인 화면으로 이동하시겠습니까?\n확인: 업무인증 로그인화면, 취소:메시지센터 로그인화면 이동");
		}else if(ticket==3 ){
			response=confirm("업무인증 로그인 정보가 유효하지 않습니다.\n업무인증 로그인 화면으로 이동하시겠습니까?\n확인: 업무인증 로그인화면, 취소:메시지센터 로그인화면 이동");
		}else if(ticket==4 ){
			response=confirm("SSO 연동 로그인 권한이 없습니다.\n업무인증 로그인 화면으로 이동하시겠습니까?\n확인: 업무인증 로그인화면, 취소:메시지센터 로그인화면 이동");
		}else {
		}
		if (response == true) {
			NEXESS_API.OpenLogin("www.ibk.co.kr",ticket);
			noConfirmClose();
		} else {
			self.location.replace("/motp_login.ibk");
		}

		//로그인 상태가 아니므로 인증창 호출후 해당 주소로 이동
	//	noConfirmClose();

	}else{
		
		while(ticket.indexOf("+") != -1) {
			ticket= ticket.replace("+", "%2b");
		}

		self.location.replace("/sso.ibk?ticket=" + escape(ticket));
		//인증티켓 유효성 검증 및 SSOID 획득 페이지로 이동

	}
	
function noConfirmClose(){
	top.window.open('about:blank','_self').close();
	top.window.opener=self;
	top.self.close();
}
</script>


</body>

</html>
