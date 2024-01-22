<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- wrap_login -->
<div class="weap_Event_Login">
    <div class="box_login" style="width: auto;">
        <div class="logo_login">
            <h1><img src="${pageContext.request.contextPath}/static/images/logo_login.png" alt="IBK 기업은행" /></h1>
            <span class="title">메시지센터</span> </div>
        <div class="boxlogin">
            <div class="title">LOGIN</div>
            <div class="text1">서비스 이용을 위해 로그인을 해주세요.</div>
            <div class="fieldbox">
	            <form id="allmsgForm" method="post" action="${pageContext.request.contextPath}/login.ibk">
	                <div class="col1" id="div_idpw">
	                    <input class="id" type="text" name="event_id" value="${inputId}" placeholder="아이디">
	                    <input class="password" type="password" name="event_pwd" value="" placeholder="비밀번호">
	                    <input type="hidden" name="event_pw" value="" >
						<input type="hidden" name="login_method" value="idpw" >	                    
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
// 		var enPw = btoa(unescape(encodeURIComponent($(".password").val())))
	    if($("input[name=event_id]").val().trim() == ''){
	      showAlert("아이디를 입력해주세요.", function() { });
	      return false;
	    }
	    
	    if($("input[name=event_pwd]").val().trim() == ''){
	      showAlert("비밀번호를 입력해주세요.", function() { });
	      return false;
	    }
	    var pwd=$("input[name=event_pwd]").val();
	    $("input[name=event_pw]").val(SHA256(pwd));
	    $("#allmsgForm").submit();
	});
	
    // 엔터키 이벤트 리스너
    $("input[name=event_pwd]").keypress(function (event) {
        if (event.which == 13) {
        	$("#btn_event_login").trigger("click");
        }
    });
	
});

</script>
