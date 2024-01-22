<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>비밀번호 변경
</h3>
<!-- content -->
<div id="content">	
	<form id="changeForm" method="post" action="${pageContext.request.contextPath}/changepassword.ibk">
    <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">비밀번호<span class="th_must">*</span></th>
            <td><input type="password" name="passwd1" id="passwd1" value="" placeholder="" style="width:280px;" ></td>            
          </tr>
          <tr>
          	<th scope="row">비밀번호 확인<span class="th_must">*</span></th>
            <td>
            <input type="password" name="passwd2" id="passwd2" value="" placeholder="" style="width:280px;">
            <input type="hidden" name="passwd" id="passwd">
            </td>
          </tr>
        </table>
    </form>
    <div class="btn_wrap01_list">
        <a href="javascript:" id=save_btn class="btn_big blue">수정</a>
    </div>
    <!-- //버튼 -->
</div>
<jsp:include page="../common/dialog.jsp" flush="true"/>
<!-- //content -->
<script>
$(document).ready(function() {
	if('${errorMsg}' != '') showAlert('${errorMsg}');

	$("#save_btn").on('click', function(){
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
});
</script>