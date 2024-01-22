<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>톰켓에 배포 하는 거였지....그렇다면 error.jsp1</h1>
<c:out value="${requestScope['javax.servlet.error.exception']}"/>
</body>
</html>
