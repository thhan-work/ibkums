<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- wrap_login -->
<div class="weap_Event_Login">
    <div class="box_login" style="width: auto;">
        <div class="logo_login">
            <h1><img src="${pageContext.request.contextPath}/static/images/logo_login.png" alt="IBK 기업은행" /></h1>
            <span class="title">비밀번호변경</span> </div>
        <div class="boxlogin">
            <div class="text1">90일 이상 변경하지 않으셧습니다. 비밀번호를 변경해주세요.</div>            
            <div class="fieldbox">
	            <form id="changeForm" method="post" action="${pageContext.request.contextPath}/forcechangepassword.ibk">
	                <div class="col1" id="div_idpw">
	                    <input class="password" type="password" name="passwd1" id="passwd1" value="" placeholder="신규비밀번호">
	                    <input class="password" type="password" name="passwd2" id="passwd2" value="" placeholder="신규비밀번호확인">
	                    <input type="hidden" name="passwd" id="passwd" value="" >
	                </div>
	                <div class="col2"><a href="javascript:;" id="btn_event_login"><img src="${pageContext.request.contextPath}/static/images/btn_login.png" alt="로그인" /></a></div>
	            </form>
            </div>
            <div class="copyright">Copyright 2018. IBK(INDUSTRIAL BANK OF KOREA) All rights reserved.</div>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/sha256.js"></script>
        
<script>
$(document).ready(function(){
	$(".weap_Event_Login").parents("section").find("aside").hide();
	
	if('${errorMsg}' != '') showAlert('${errorMsg}');
	
	
	$("#btn_event_login").on("click",function(){
		var passwd1 = $('#passwd1').val();
		if (passwd1.length < 8) {
			showAlert("비밀번호는 최소 8자리 이상 입력하셔야 됩니다.");
			$("#passwd1").focus();
			return;
		}
		
		if (passwd1.match("\\w") == null) {
			showAlert("비밀번호는 영문/숫자/특수문자가 1자 이상 반드시 들어가야 됩니다.");
			$("#passwd1").focus();
			return;
		}
		
		if (passwd1.match("\\d") == null) {
			showAlert("비밀번호는 영문/숫자/특수문자가 1자 이상 반드시 들어가야 됩니다.");
			$("#passwd1").focus();
			return;
		}
		
		if (passwd1.match("[\\`\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\-\\_\\=\\+\\\\\\|\\[\\{\\]\\}\\;\\:\\'\"\\,\\<\\.\\>\\/\\?]") == null) {
			showAlert("비밀번호는 영문/숫자/특수문자가 1자 이상 반드시 들어가야 됩니다.");
			$("#passwd1").focus();
			return;
		}
		
		if ($('#passwd1').val().trim()=="") {
			showAlert("비밀번호를 입력하십시요.");
			$("#passwd1").focus();
			return;
		}
		
		if ($('#passwd2').val().trim()=="") {
			showAlert("비밀번호 확인을 입력하십시요.");
			$("#passwd2").focus();
			return;
		}
		
		if($('#passwd1').val()!=$('#passwd2').val()){
			showAlert("비밀번호와 비밀번호확인이 맞지 않습니다.");
			$("#passwd1").focus();
			return;
		}
		
		 $("#passwd").val(SHA256($("#passwd1").val()));
		 $("#changeForm").submit();
	});
	
    // 엔터키 이벤트 리스너
    $("input[name=event_pwd]").keypress(function (event) {
        if (event.which == 13) {
        	$("#btn_event_login").trigger("click");
        }
    });
	
});

</script>
