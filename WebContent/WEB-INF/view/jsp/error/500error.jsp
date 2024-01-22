<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>::: [IBK] Message Center :::</title>
<link href="./css/default.css" rel="stylesheet" />
</head>

<body>
<!--alert-->
<div class="alert_wrap" style="margin: auto; margin-top: 111px;"> 
  <!-- content -->
  <img src="${pageContext.request.contextPath}/static/images/logo_login.png" alt="IBK 기업은행"  style="width: 154px; margin-bottom: 10px;"/>
  <div class="content_alert" style="border-top: 2px solid #155bb0; border-left: 1px solid #e8e8e8; border-right: 1px solid #e8e8e8; border-bottom: 1px solid #e8e8e8; height:180px;"> 
	<p style="font-size: 13px; padding-bottom: 7px;">
	<b>이용에 불편을 드려 죄송합니다.<br>처리 중 에러가 발생했습니다.
	<br>지속 될 경우 관리자에게 문의 바랍니다.</b>
	<br>
	<br>
	<b>500 Server Error</b>
	</p>
  <div class="footer_alert"> 
    <!-- button --><a href="javascript:;" class="btn_big blue" onclick="history.back(-1)">뒤로가기</a><!-- //button --> 
  </div>
  </div>
  
  
  <!-- //content --> 
  <div class="copyright" style="font-size: 9px;text-align: right;">Copyright 2018. IBK(INDUSTRIAL BANK OF KOREA) All rights reserved.</div>
</div>
<!--//alert-->

</body>
</html>