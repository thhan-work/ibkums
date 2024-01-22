<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>::: [IBK] Message Center :::</title>
    <link href="${pageContext.request.contextPath}/static/css/jquery-ui.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/datatables.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/images/favicon.ico" rel="shortcut icon"/>
    <link href="${pageContext.request.contextPath}/static/css/summernote-lite.css"
          rel="stylesheet"/>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery.3.3.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery-ui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/datatables.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/moments.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery.number.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery.bpopup-min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/article-hide.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/common/sha256.js"></script>
	<!-- zoom set  -->
	<script type="text/javascript"
	        src="${pageContext.request.contextPath}/static/js/common/zoom.js"></script>
    <script type="text/javascript">
		jQuery.ajaxSetup({cache:false});</script>

	<script>
		$(document).ready(function() {
			setTimeout(function() {
				$.ajax({
			      url: '${pageContext.request.contextPath}/keepSession.ibk',
			      type: 'GET',
			      success: function (result) {
			      }
			    });
			}, 300000);
		});
	</script>

</head>
<body>
<!-- skipNavi -->
<div id="skipNavi">
    <ul>
        <li><a href="#nav">주메뉴 바로가기</a></li>
        <li><a href="#content">본문 바로가기</a></li>
    </ul>
</div>
<!-- //skipNavi -->

<!-- wrapper -->
<div class="wrapper wrapper-v1">

    <!-- header -->
    <tiles:insertAttribute name="header"/>
    <!-- //header -->

    <!-- section -->
    <section>
        <aside>
            <tiles:insertAttribute name="side-menu"/>
        </aside>
        <!-- article -->
        <article>
            <tiles:insertAttribute name="content"/>
        </article>
        <!-- //article -->
    </section>
    <!-- //section -->
</div>
<!-- //wrapper -->
</body>
</html>