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

    <%-- 202205 v1
    <nav>
        <div class="logo" id="logo"><h1><a href="/"><img src="${pageContext.request.contextPath}/static/images/logo.png" alt="IBK 기업은행 메시지센터"></a></h1></div>
        <div id="nav">
        </div>
    </nav>
    --%>

    <%-- 202205 v2 --%>
    <div class="contents-area">
        <!-- begin header-left -->
        <div class="header-left"><a href="/"><img src="/static/v2/img/logo-top.png"></a></div>
        <!-- // end header-left -->
    </div>
</header>