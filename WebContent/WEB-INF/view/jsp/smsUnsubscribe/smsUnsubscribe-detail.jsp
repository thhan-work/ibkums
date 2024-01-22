<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap" id="popup_wrap" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title" id="popup_employee_title">등록</div>
            <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_wrap')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <div class="info mgb10"><span>* 필수항목 표시</span></div>
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">고객명<span class="th_must">*</span></th>
            <td>
                <input type="text" name="custName" id="custName" value="" placeholder="" style="width:120px" maxlength="20">
          </tr>
          <tr>
            <th scope="row">휴대폰번호<span class="th_must">*</span></th>
            <td><input type="text" name="phone" id="phone" value="" placeholder="" style="width:140px;" maxlength="15"></td>
          </tr>
          <tr>
            <th scope="row">고객번호<br>(주민/사업자)</th>
            <td>
            	<input type="text" name="custBsno" id="custBsno" value="" placeholder="" style="width:140px;" maxlength="13">
            </td>
          </tr>
          <tr>
            <th scope="row">업무구분<span class="th_must">*</span></th>
            <td>
				<select id="cutOption">
					<option value="1111">전체</option>
					<option value="0100">광고</option>
					<option value="0010">카드</option>
					<option value="0001">연체</option>
				</select>
            </td>
          </tr>
          <tr>
            <th scope="row">비고(차단사유)</th>
            <td>
            	<textarea  id="cutMemo" maxlength="50" style="width:280px;"></textarea>
            </td>
          </tr>
        </table>
        <span>* 비고는 한글 50자까지 입력 가능합니다.</span> 
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" id="save_admin_btn" class="btn_big blue">확인</a><a href="javascript:;" class="btn_big gray"  onclick="popClose('#popup_wrap')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->
<!-- user detail popup -->
<script src="${pageContext.request.contextPath}/static/js/messageUtil.js"></script>
<jsp:include page="../common/usersearch-list.jsp" flush="true"/>

<script>
	var popType = "등록";

    function registration_init(){
        popOpen("#popup_wrap");
        $("#custName").focus();
    }

    //중복 저장이 안되도록 기 등록자는 정보 변경
    $("#save_admin_btn").on('click', function(){
        if (!IbkValidation.validInputBox("custName")) {
            showAlert("고객명을 입력해 주세요", IbkValidation.setFocusById("custName"));
            $("#alert-modal").parent().css({'z-index':30000000});
            return false;
        }
		if (!IbkValidation.validInputBox("phone")) {
            showAlert("휴대폰 번호를 입력해 주세요", IbkValidation.setFocusById("phone"));
            $("#alert-modal").parent().css({'z-index':30000000});
            return false;
        }
		
        $.ajax({
            url: '${pageContext.request.contextPath}/smsUnsubscribe/' + $("#phone").val().replace(/-/g, '') +'/count',
                type: 'GET',
                success: function (result) {
                    var smsUnsubscribeInfo = getSmsUnsubscribeInfo();
                   if(result >= 1){
                	   if(popType == "등록"){
                		   showAlert("이미 등록된 휴대폰번호 입니다.<br><br>해당 휴대폰번호는 검색하여 수정하시기 바랍니다.");
                		   return false;
                	   }else{
                		   user_update(smsUnsubscribeInfo);
                	   }
                   }else{
                        user_registration(smsUnsubscribeInfo);
                   }
            }
        });
        
    });

  function getSmsUnsubscribeInfo() {
    return {
      "phone": $("#phone").val().replace(/-/g, ''),
      "custName": $("#custName").val(),
      "custBsno": $("#custBsno").val(),
      "cutMemo": $("#cutMemo").val(),
      "cutOption": $("#cutOption option:selected").val(),
    };
  }
  function setSmsUnsubscribeInfo(result) {
	  popType = "수정";
	  
	  $("#popup_employee_title").text("수정");
	  $("#save_admin_btn").text("수정");
	  $(".th_must").hide();
	  $("#phone").css('background-color','lightgray');
	  $("#phone").prop('readonly', true);
	  
	  $("#phone").val(result.phone);
	  $("#custName").val(result.custName);
	  $("#custBsno").val(result.custBsno);
	  $("#cutMemo").val(result.cutMemo);
	  $("#cutOption").val(result.cutOption);
  }
  
  //초기화
  function initEmployeeInfo() {
	  popType = "등록";
	  
	  $("#popup_employee_title").text("등록");
	  $("#save_admin_btn").text("등록");
	  $(".th_must").show();
	  $("#phone").css('background-color','#ffffff');
	  $("#phone").prop('readonly', false);
	 
	  $("#phone").val("");
	  $("#custName").val("");
	  $("#custBsno").val("");
	  $("#cutMemo").val("");
  }
  
  function user_update(smsUnsubscribeInfo){
	  
	 if(!ValidateSubmit("update")){
		 return false;
	 }
	  
    $.ajax({
      url: '${pageContext.request.contextPath}/smsUnsubscribe/'+ $("#phone").val().replace(/-/g, ''),
      type: "PUT",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(smsUnsubscribeInfo),
      success: function (result) {
   	  	showAlert("정보 " + popType + "을 완료 되었습니다.");	
        popClose('#popup_wrap');
        reload();
      },
      error: function (request, status, error) {
  	      showAlert("정보 " + popType + "에 실패 하였습니다.");
       }
    });
  }
  function user_registration(smsUnsubscribeInfo){
	
	 if(!ValidateSubmit("insert")){
		 return false;
	 }
	  
    $.ajax({
      url: '${pageContext.request.contextPath}/smsUnsubscribe',
      type: "POST",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(smsUnsubscribeInfo),
      success: function (result) {
   	  	  	showAlert("정보 " + popType + "을 완료 되었습니다.");
   	        popClose('#popup_wrap');
   	        reload();
      },
      error: function (request, status, error) {
    	  console.log(request.responseText);
  	      showAlert("정보 " + popType + "에 실패 하였습니다.");
       }
    });
  }


////휴대폰 번호 숫자입력 체크 이벤트
  $("#phone").on("keyup", function(){
  	inputPhoneType($(this));
  });
  
////휴대폰 번호 숫자입력 체크 이벤트
  $("#custBsno").on("keyup", function(){
  	inputPhoneType($(this));
  });
  
  function ValidateSubmit(type){
	  if($("#custName").val().trim() == '') {
		    showAlert("고객명을 입력해 주세요.");
		    $("#custName").focus();
		    return false;
	  }else{
	  }
		  _byte = checkByteTextarea($("#custName"));//byte 계산
	 	 if (_byte > 20) {
		    showAlert("고객명은 최대 20Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)");
		    $("#custName").focus();
		    return false;
	 	 }
	  
	  if(type == "insert"){
		  var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		  if($("#phone").val().trim() == '') {
		    showAlert("휴대폰 번호를 입력해 주세요.");
		    $("#phone").focus();
		    return false;
		  }
		  
		  if(!regExp.test($("#phone").val()) && $("#phone").val().substr(0,3) != "070") {
		    showAlert("휴대폰 번호 형식에 맞지 않습니다.<br>번호를 정확히 입력해 주세요.");
		    $("#phone").focus();
		    return false;
		  }
	  }
	  
	  return true;
  }
  
  function ValidateIPaddress()
  {
   if (/^(25[0-5]|2[0-4][0-9][0-9]?)$/.test()){
      console.log(true);
      return true
   }
    console.log(false);

   return false
  }
  
////전화번호 형식 입력 @jys
  function inputPhoneType(obj){
  	  var inputVal = obj.val();
  	  obj.val(inputVal.replace(/[^0-9-]/gi,''));
  };
</script>
