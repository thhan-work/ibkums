<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<header>
<%--     <div class="session">
        <ul>
            <li class="user"><span><c:out value='${sessionScope.EMPL_NAME}'/></span>님 환영합니다.</li>
            <li class="download"><a href="${pageContext.request.contextPath}/address/download/sample/manual" >매뉴얼 다운로드</a></li>
        </ul>
    </div> --%>
    <nav>
        <div class="logo" id="logo"><h1><c:if test="${fn:contains(sessionScope.USER_CLASS,'A')}"><a href="/"></c:if><img src="${pageContext.request.contextPath}/static/images/logo.png" alt="IBK 기업은행 메시지센터"><c:if test="${fn:contains(sessionScope.USER_CLASS,'A')}"></a></c:if></h1></div>
        <div id="nav" style="margin-right:400px;">
            <ul>
                <li><a href="/allmessage/search.ibk">SMS/MMS</a></li>
                <li><a href="/email/search.ibk">EMAIL</a></li>
                <li><a href="/fax/search.ibk">FAX</a></li>
            </ul>
        </div>
    </nav>
</header>