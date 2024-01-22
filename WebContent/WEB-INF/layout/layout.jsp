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
    <link href="${pageContext.request.contextPath}/static/images/favicon.ico" rel="shortcut icon"/>

    <!-- style -->
    <link rel="stylesheet" type="text/css" href="/static/v2/css/common.css" />
    <tiles:insertAttribute name="style"/>
    <!-- //style -->

    <%-- 202205 v1 --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datatables.min.js"></script>
    <%-- 202205 v2 --%>
    <script type="text/javascript" src="/static/v2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="/static/v2/js/buttons.print.min.js"></script>
    <script type="text/javascript" src="/static/v2/js/dataTables.button.js"></script>
    <script type="text/javascript" src="/static/v2/js/jszip.js"></script>
    <script type="text/javascript" src="/static/v2/js/vfs_fonts.js"></script>

    <script type="text/javascript" src="/static/v2/js/jquery.slimscroll.min.js"></script>
    <script type="text/javascript" src="/static/v2/js/common.js"></script>

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
<div class="wrapper">

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
            <div class="contents">
                <tiles:insertAttribute name="content"/>
            </div>
        </article>
        <!-- //article -->
    </section>
    <!-- //section -->
</div>
<!-- //wrapper -->

<div class="footer">
    Copyright 2021 IBK All rights reserved.
</div>
</body>
</html>

