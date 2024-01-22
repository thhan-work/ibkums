<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap" id="popup_detail" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title" id="popup_employee_title">상세보기</div>
            <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_detail')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <input type="hidden" id="updateKey">
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:160px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">발송시스템명</th>
            <td><input type="text" id="fvia" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">발송일시</th>
            <td><input type="text" id="reqDate" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">이동통신사 처리결과</th>
            <td><input type="text" id="rslt" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">메시지 구분</th>
            <td><input type="text" id="messageType" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">메시지 내용</th>
            <td><textarea type="text" id="msg" style="width:250px;background-color: #eeeeee;" readonly></textarea></td>
          </tr>
          <tr>
            <th scope="row">업무담당부서명</th>
            <td><input type="text" id="bocdNm" style="width:250px;background-color: #eeeeee;" maxlength="20" readonly></td>
          </tr>
          <tr>
            <th scope="row">업무담당자</th>
            <td>
            	<input type="text" id="unitPic" style="width:250px;background-color: #eeeeee;" maxlength="20" readonly>
            </td>
          </tr>
          <tr>
            <th scope="row">업무담당자 연락처</th>
            <td>
            	<input type="text" id="unitPicTelno" style="width:250px;background-color: #eeeeee;" maxlength="55" readonly>
            </td>
          </tr>
          <tr>
            <th scope="row">전행고객번호<br>/관련계좌번호</th>
            <td><input type="text" id="etc3" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">발송전화번호</th>
            <td><input type="text" id="phone" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">통신사</th>
            <td><input type="text" id="telcoInfo" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">통신사응답일시</th>
            <td><input type="text" id="rsltDate" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">업무내용</th>
            <td><input type="text" id="lvia" style="width:250px;background-color: #eeeeee;" readonly></td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <input type="hidden" id="msgkey">
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" id="save_admin_btn" class="btn_big blue">확인(수정)</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>

<script>
   function setJobCodeInfo(popup, result) {
	   //console.log(result);
	   for(var name in result){
		   $('#'+name).val(result[name]);
		   $('#'+name).attr('asisData', result[name]);
	   }
	   
	   //영업점 코드가 0일경우 담당자 정보 수정 가능하게 변경
	   if(result.vsubCode == 0){
			$("#bocdNm").prop('readonly', false);
			$("#bocdNm").css('background-color', 'white');
			$("#unitPic").prop('readonly', false);
			$("#unitPic").css('background-color', 'white');
			$("#unitPicTelno").prop('readonly', false);
			$("#unitPicTelno").css('background-color', 'white');
	   }else{
			$("#bocdNm").prop('readonly', true);
			$("#bocdNm").css('background-color', '#eeeeee');
			$("#unitPic").prop('readonly', true);
			$("#unitPic").css('background-color', '#eeeeee');
			$("#unitPicTelno").prop('readonly', true);
			$("#unitPicTelno").css('background-color', '#eeeeee');
	   }
	   
	   $("#popup_detail").parent().css({'z-index':9000})
	   popOpen(popup);
	  
  }
   
   // 검색 버튼 클릭 이벤트 리스너 등록
   $("#user-search-btn").on('click', confirmUnit);
   
   $("#save_admin_btn").on('click', popOkBtn);
   
   function confirmUnit(){
	   if($("#bocdNm").val() == null || $("#bocdNm").val() == ""){
		   showAlert("업무담당부서명을 입력해 주시기 바랍니다.")
		   return false;
	   }
	   
	   if($("#unitPic").val() == null || $("#unitPic").val() == ""){
		   showAlert("업무담당자명을 입력해 주시기 바랍니다.")
		   return false;
	   }
	   
	   if($("#unitPicTelno").val() == null || $("#unitPicTelno").val() == ""){
		   showAlert("업무담당자 연락처를 입력해 주시기 바랍니다.")
		   return false;
	   }
	   
	   var msg = "<pre>[담당부서명]\t:\t" +  $("#bocdNm").val() + "</pre><br>"
	   			+ "<pre>[담당자명]\t:\t" +  $("#unitPic").val() + "</pre><br>"
	   			+ "<pre>[담당자연락처]\t:\t" +  $("#unitPicTelno").val() + "</pre><br><br>";
	   			
	    setTimeout(function () {
	    	showConfirmForAjax("수정", msg + "업무담당자 정보를 수정하시겠습니까?", updateUnit);
	    }, 100);
   }
   
   function updateUnit(){
	   var updatKet = $("#updateKey").val();
	   
		  $.ajax({
			  url:'${pageContext.request.contextPath}/allmessage/unitUpdate',
			  type:"POST",
	          contentType: "application/json; charset=utf-8",
	          dataType: "json",
			  data : JSON.stringify({
				  bzwkIdnfr : updatKet  // 업무코드
				  ,asisRspblDvsnName : $("#bocdNm").attr("asisData") // 이전 업무담당부서명
				  ,asisRspblPsnName : $("#unitPic").attr("asisData")  // 이전 업무담당자명
				  ,asisRspblPsnTelno : $("#unitPicTelno").attr("asisData") // 이전 업무담당자 연락처
				  ,rspblDvsnName : $("#bocdNm").val() // 업무담당부서명
				  ,rspblPsnName : $("#unitPic").val()  // 업무담당자명
				  ,rspblPsnTelno : $("#unitPicTelno").val() // 업무담당자 연락처
			  },null,'\t'),
			  success:function(result){
					showAlert("업무담당자 정보를 수정하였습니다.");
					popClose('#popup_detail');
					initTable();
			  },error : function (xhr,error,code) {
	            	showAlert("요청 중 에러 발생, 에러 메시지=["+xhr.responseJSON.message+"], 에러코드=["+xhr.responseJSON.code+"], 관리자에게 문의 바랍니다.");
           	  }
		  });
   }
   
   function popOkBtn(){
	   if(checkUpdateData()){
		   showConfirmForAjax2("수정", "담당자 정보가 변경되었습니다.<br>담당자 정보를 수정하시겠습니까?", confirmUnit,null,popClose,'#popup_detail');
	   }else{
			popClose('#popup_detail');
	   }
   }
   
   //휴대폰번호에 숫자만 가능 
	$("#unitPicTelno").keyup(function(event){
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi,''));
	});
   
   function checkUpdateData(){
	   if($("#bocdNm").attr("asisData") != $("#bocdNm").val()){
		   return true;
	   }
	   if($("#unitPic").attr("asisData") != $("#unitPic").val()){
		   return true;
	   }
	   if($("#unitPicTelno").attr("asisData") != $("#unitPicTelno").val()){
		   return true;
	   }
	   
	   return false;
   }
   
</script>