<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>::: [IBK] Message Center :::</title>
</head>
<body>
<h1>SSO Authentication </h1>

<h3> 인증하기 </h3>
<b>IBK에서 사용자ID를 받아오는 프로세스로, 해당 페이지는 임시 페이지 </b><br/>
KIUPSMS.EMPLOYEE_INFO 의 EMPL_ID 가 사용자아이디, 현재는 이것으로 통일 <br/>
KIUPSMS.EMPLOYEE_INFO 의 EMPL_CLASS 확실하진 않지만, 우선 사용자별 권한 부여용으로 사용(이후 변경 가능) <br/>

<ul>
    <li><a href="/auth.ibk?emplId=normal">[0 : 일반사용자]로 인증</a></li>
    <li><a href="/auth.ibk?emplId=17489">[0 : 개인사용자]로 인증</a></li>
    <li><a href="/auth.ibk?emplId=employee">[1: 직원용 SMS 발송 등록자]로 인증</a></li>
    <li><a href="/auth.ibk?emplId=authorizer">[2: 승인자] 인증</a></li>
    <li><a href="/auth.ibk?emplId=admin02">[9: 관리자] 로 인증</a></li>
</ul>


    <c:if test="${(sessionScope.EMPL_ID != null)}">
    <h3> session attribute</h3>
    <ul>
        <li> EMPL_ID : <h3><%=session.getAttribute("EMPL_ID")%></h3> </li>
        <li> EMPL_NAME : <h3><%=session.getAttribute("EMPL_NAME")%></h3> </li>
        <li> EMPL_CLASS : <h3><%=session.getAttribute("EMPL_CLASS")%></h3> </li>
        <li> EMPL_BOCODE : <h3><%=session.getAttribute("EMPL_BOCODE")%></h3> </li>
        <li> isLoginPassed(내부 로그인 여부를 판단하는용도) : <h3><%=session.getAttribute("isLoginPassed")%></h3> </li>
    </ul>

<div>
    <h3> Menu</h3>
    <ul>
    	<li> <a href="/address.ibk"> 주소록 </a></li>
        <li> <a href="/admin/employee.ibk"> 직원용 SMS 발송 화면 </a></li>
        <li> <a href="/admin/authorizer.ibk"> 승인자(협의자) 관리 </a></li>
        <li> <a href="/admin/admin.ibk"> 관리자 관리 </a></li>
        <li> <a href="/admin/notice.ibk"> 공지사항 </a></li>
        <li> <a href="/message.ibk"> 일반보내기 </a></li>
        <li> <a href="/eventsend.ibk"> 경조사보내기 </a></li>
        <li> <a href="/form/happy.ibk"> 해피콜문자 </a></li>
        <li> <a href="/form/head.ibk"> 본부양식 </a></li>
        <li> <a href="/form/personal.ibk"> 개인서식함 </a></li>
        <li> <a href="/form/dept.ibk"> 부서서식함 </a></li>
        <li> <a href="/mymessage.ibk"> 내가 보낸 메시지</a></li>
        <li> <a href="/reservedmessage.ibk"> 예약메시지 </a></li>
        <li> <a href="/smssendlist.ibk"> SMS발송 진행현황 </a></li>
        <li> <a href="/confirmlist.ibk"> 결재내역 </a></li>
        <li> <a href="/admin/loglist.ibk"> 이력조회 </a></li>
        <li> <a href="/allmessage.ibk"> 전체메시지 </a></li>
        <li> <a href="/envset.ibk"> 경조사수신설정 </a></li>
        <li> <a href="/smsreq.ibk"> SMS발송 의뢰하기</a></li>
        <li> <a href="/reservationStatus.ibk"> 발송예약 현황보기</a></li>
        <li> <a href="/nevigation.ibk"> 대량SMS 발송의뢰</a></li>
        
        
        <li> <a href="/statistics-channel.ibk"> 채널별통계 </a></li>
        <li> <a href="/statistics-branch.ibk"> 영업점별통계 </a></li>
        <li> <a href="/statistics-vendor.ibk"> 벤더사별통계 </a></li>
        <li> <a href="/statistics-failure.ibk"> 실패유형통계 </a></li>        
        <li> <a href="/statistics-group.ibk"> 그룹발송 </a></li>        
        <li> <a href="/statistics-send.ibk"> 발송현황 </a></li>        
        <li> <a href="/monitor-log.ibk"> 로그조회 </a></li>
        <li> <a href="/monitor-queue.ibk"> 처리현황 </a></li>
        <li> <a href="/monitor-process.ibk"> 프로세스상태현황 </a></li>        
        <li> <a href="/manage-code.ibk"> 공통코드관리 </a></li>
        <li> <a href="/manage-codegroup.ibk"> 공통코드그룹관리 </a></li>
        <li> <a href="/manage-jobcode.ibk"> 업무코드관리 </a></li>
    </ul>
</div>
   </c:if>
</body>
</html>