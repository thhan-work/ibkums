<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- wrap_login -->
<div id="content">
	<div class="weap_Event_Login">
	    <div class="box_login">
	        <div class="logo_login">
	            <h1><img src="${pageContext.request.contextPath}/static/images/logo_login.png" alt="IBK 기업은행" /></h1>
	            <span class="title">메시지센터</span> </div>
	        <div class="boxlogin">
	            <div class="title">경조사 보내기 로그인 (MOTP)</div>
	            <div class="text1">경조사 보내기 서비스 이용을 위해 로그인을 해주세요.</div>           
	            <div class="fieldbox">
		            <form id="eventForm" method="post" action="${pageContext.request.contextPath}/motp_eventsend.ibk">
		                <div class="col1" id="div_motp">
		                    <input class="id" type="text" name="motp_id" value="${motpId}" placeholder="MOTP ID">
		                    <input class="password" type="password" name="motp_no" value="" placeholder="MOTP 번호">
		                    <input type="hidden" name="login_method" value="motp" >
		                </div>
		                <div class="col2"><a href="javascript:;" id="btn_event_login"><img src="${pageContext.request.contextPath}/static/images/btn_login.png" alt="로그인" /></a></div>
		            </form>
	            </div>
	            <div class="copyright">Copyright 2018. IBK(INDUSTRIAL BANK OF KOREA) All rights reserved.</div>
	        </div>
	        <div class="text1" style="padding-left:10px;font-size:14px;color: blue;font-weight:bold">경조사 메시지 전송 원칙</div>
	        <div class="mgt3" style="padding-left:13px;width: 900px;">· 경조사 메시지는 知캠프의 기은사랑방>임직원경조사 코너 이용이 원칙입니다.</div>
	        <div class="mgt3" style="padding-left:13px;width: 900px;">· 공유일 및 주말에 발생한 경조사만 본점 당직실에서 일괄 발송합니다.</div>
	        <div class="mgt3" style="padding-left:13px;width: 900px;">· 개별부점 및 직원의 사용이 불가합니다.</div>
	    </div>
	</div>
</div>
<!-- //wrap_login -->

<script src="${pageContext.request.contextPath}/static/js/tabcontent.js"></script>
<script src="${pageContext.request.contextPath}/static/js/messageUtil.js"></script>


<!-- alert dialog 와 confirm dilalog 를 사용하기 위해서 필요 -->
<jsp:include page="../generalSend/dialog/messageDialog.jsp" flush="true"/>

<!-- ajax Loding 이미지 -->
<jsp:include page="../common/loading.jsp" flush="true"/>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatables.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/sha256.js"></script>
        
<script>
$(document).ready(function(){
	if('${errorMsg}' != '') showAlert('${errorMsg}');
	
	$("#btn_event_login").on("click",function(){
// 		var enPw = btoa(unescape(encodeURIComponent($(".password").val())))

		if($("input[name=motp_id]").val().trim() == ''){
	      showAlert("MOTP아이디를 입력해주세요.", function() { });
	      return false;
	    }
	    
	    if($("input[name=motp_no]").val().trim() == ''){
	      showAlert("MOTP번호를 입력해주세요.", function() { });
	      return false;
	    }
	    $("#eventForm").submit();
	});
	
    // 엔터키 이벤트 리스너
    $("input[name=event_pwd]").keypress(function (event) {
        if (event.which == 13) {
        	$("#btn_event_login").trigger("click");
        }
    });
	
});

</script>
