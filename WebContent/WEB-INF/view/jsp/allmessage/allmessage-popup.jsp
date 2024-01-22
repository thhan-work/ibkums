<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>

<c:if test="${fn:contains(sessionScope.USER_CLASS,'A')}">
<!--popup-->
<div class="popup_wrap_b" id="popup_detail" style="display:none;" >
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
	      <tr id="subject_label" >
            <th scope="row">메시지 제목</th>
            <td><input type="text" id="subject" style="width:350px;background-color: #eeeeee;" readonly></input></td>
          </tr>
          <tr>
            <th scope="row">메시지 내용</th>
            <td><textarea id="msg" style="width:350px;background-color: #eeeeee;height:100px;" readonly></textarea></td>
          </tr>
          <tr>
            <th scope="row">업무담당부서명</th>
            <td><input type="text" id="bocdNm" style="width:350px;background-color: #eeeeee;" maxlength="20" readonly></td>
          </tr>
          <tr>
            <th scope="row">업무담당자</th>
            <td>
            	<input type="text" id="unitPic" style="width:350px;background-color: #eeeeee;" maxlength="20" readonly>
            </td>
          </tr>
          <tr>
            <th scope="row">업무담당자 연락처</th>
            <td>
            	<input type="text" id="unitPicTelno" style="width:350px;background-color: #eeeeee;" maxlength="55" readonly>
            </td>
          </tr>
          <tr>
            <th scope="row">통신사</th>
            <td><input type="text" id="telcoInfo" style="width:350px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">통신사응답일시</th>
            <td><input type="text" id="rsltDate" style="width:350px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">전화응대가이드</th>
            <td><textarea id="csGuide" style="width:350px;background-color: #eeeeee;height:60px;" readonly></textarea></td>
          </tr>
          <tr id="tr_agentRslt">
            <th scope="row">카카오 알림톡<br />발송실패사유</th>
			<td><textarea id="agentRslt" style="width:350px;background-color: #eeeeee;height:35px;" readonly></textarea></td>
          </tr>
          <tr id="tr_refCtnt">
            <th scope="row">카카오 알림톡→문자<br />전환발송사유</th>
            <td><textarea id="refCtnt" style="width:350px;background-color: #eeeeee;height:35px;" readonly></textarea></td>
          </tr>
		  <tr>
          	<td colspan="2">
          		<div id="mms_info">
		       	* 이미지와 메세지 내용은 휴대폰 기종에 따라 보이는 순서가 다를 수 있습니다.
		       	</div>
          		<div id="mms_image">        
        		</div>
        	</td>
          </tr>  
        </table>
        
      </div>

      <!-- //table_view -->
    </div>
    <input type="hidden" id="msgkey">
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" id="save_admin_btn" class="btn_big blue">확인</a>
    </div>
    <!-- //footer -->
</div>
</c:if>

<c:if test="${!fn:contains(sessionScope.USER_CLASS,'A')}">
<div class="popup_wrap_b" id="popup_detail" style="display:none">
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
          <tr id="subject_label">
            <th scope="row">메시지 제목</th>
            <td><input type="text" id="subject" style="width:350px;background-color: #eeeeee;" readonly></input></td>
          </tr>
          <tr>
            <th scope="row">메시지 내용</th>
            <td><textarea id="msg" style="width:350px;background-color: #eeeeee;height:80px;" readonly></textarea></td>
          </tr>
          <tr>
            <th scope="row">통신사</th>
            <td><input type="text" id="telcoInfo" style="width:350px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">통신사응답일시</th>
            <td><input type="text" id="rsltDate" style="width:350px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">전화응대가이드</th>
            <td><textarea id="csGuide" style="width:350px;background-color: #eeeeee;height:80px;" readonly></textarea></td>
          </tr>
          <tr id="tr_agentRslt">
            <th scope="row">카카오 알림톡<br />발송실패사유</th>
			<td><textarea id="agentRslt" style="width:350px;background-color: #eeeeee;height:35px;" readonly></textarea></td>
          </tr>
          <tr id="tr_refCtnt">
            <th scope="row">카카오 알림톡→문자<br />전환발송사유</th>
            <td><textarea id="refCtnt" style="width:350px;background-color: #eeeeee;height:35px;" readonly></textarea></td>
          </tr>
          <tr>
          	<td colspan="2">
          		<div id="mms_info">
		       	* 이미지와 메세지 내용은 휴대폰 기종에 따라 보이는 순서가 다를 수 있습니다.
		       	</div>
          		<div id="mms_image">        
        		</div>
        	</td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <input type="hidden" id="msgkey">
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" id="save_admin_btn" class="btn_big blue">확인</a>
    </div>
    <!-- //footer -->
</div>
</c:if>

<div class="popup_wrap_c" id="image_detail" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title" id="popup_employee_title">이미지상세보기</div>
            <div class="btn_close"><a href="javascript:;" onclick="popClose('#image_detail')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view" style="height: calc( 100vh - 250px);">
      	<div id="image_view"></div>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:popClose('#image_detail');" class="btn_big blue">확인</a>
    </div>
    <!-- //footer -->    
</div>

<script>
	function openImageDetail(seq) {
		var image = $("<img style='width:100%;height: calc( 100vh - 250px);'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + seq);
		$("#image_detail").find("#image_view").children().remove();
		$("#image_detail").find("#image_view").append(image);
		popOpen("#image_detail");	
	}

	function setJobCodeInfo(popup, result) {
	   console.log(result);
	   for(var name in result){
		   console.log(name + ":" + $("#"+name).prop("tagName"));
		   if ($("#"+name).prop("tagName") == "TEXTAREA") {
			   $('#'+name).text(result[name]);
			   //$('#'+name).attr('asisData', result[name]);   
		   }else {
			   $('#'+name).val(result[name]);
			   $('#'+name).attr('asisData', result[name]);   
		   }
		   
	   }

		// 카카오알림톡 관련 수정
		if(result.refCtnt && result.refCtnt != '') {
			$("#popup_detail").find('#tr_refCtnt').show();
		} else {
			$("#popup_detail").find('#tr_refCtnt').hide();
		}

		if(result.messageType == 'KAKAO' && result.agentRslt) {
			$("#popup_detail").find('#tr_agentRslt').show();
		} else {
			$("#popup_detail").find('#tr_agentRslt').hide();
		}

	   $("#etc").val(result.etc1 +"\n"+ result.etc3);
	   
	   
	   if (result.messageType == "LMS" || result.messageType == "MMS"){
		   $("#popup_detail").find("#subject_label").show();
	   } else {
		   $("#popup_detail").find("#subject_label").hide();
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
	   
	   $("#popup_detail").find("#mms_image").children().remove();
	   $("#popup_detail").find("#mms_info").attr("style", "display:none;");
	   $("#popup_detail").find("#mms_info").find("td").attr("colspan", "2");
	   if (result.messageType == "MMS") {
		   $("#popup_detail").find("#mms_info").attr("style", "display:block;");
		   if (result.seq1 != undefined && result.seq1 != "0") {
			   var imgdiv = $("<div style='width:160px;display:inline-block;'/>");
			   var imgSeq1 = $("<img style='width:160px;height:160px;'/>").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.seq1);
			   var imgLabel1 = $("<span style='width:160px;'/>").text("이미지식별번호 : "+ result.seq1);
			   imgSeq1.on("click", function() {
				   openImageDetail(result.seq1);
			   });
			   imgdiv.append(imgSeq1);
			   imgdiv.append(imgLabel1);
			   $("#popup_detail").find("#mms_image").append(imgdiv);
		   }
		   
		   if (result.seq2 != undefined && result.seq2 != "0") {
			   var imgdiv = $("<div style='width:160px;display:inline-block;'/>");
			   var imgSeq2 = $("<img style='width:160px;height:160px;'/>").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.seq2);
			   var imgLabel2 = $("<span style='width:160px;'/>").text("이미지식별번호 : "+ result.seq2);
			   imgSeq2.on("click", function() {
				   openImageDetail(result.seq2);
			   });
			   imgdiv.append(imgSeq2);
			   imgdiv.append(imgLabel2);
			   $("#popup_detail").find("#mms_image").append(imgdiv);
		   }
		   
		   if (result.seq3 != undefined && result.seq3 != "0") {
			   var imgdiv = $("<div style='width:160px;display:inline-block;'/>");
			   var imgSeq3 = $("<img style='width:160px;height:160px;'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.seq3);
			   var imgLabel3 = $("<span style='width:160px;'/>").text("이미지식별번호 : "+ result.seq2);
			   imgSeq3.on("click", function() {
				   openImageDetail(result.seq3);
			   });
			   imgdiv.append(imgSeq3);
			   imgdiv.append(imgLabel3);
			   $("#popup_detail").find("#mms_image").append(imgdiv);
		   }
	   }
	   
	   $("#popup_detail").parent().css({'z-index':9000})
	   popOpen1(popup);
	  
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
	   <c:if test="${fn:contains(sessionScope.USER_CLASS,'A')}">
	   if(checkUpdateData()){
		   showConfirmForAjax2("수정", "담당자 정보가 변경되었습니다.<br>담당자 정보를 수정하시겠습니까?", confirmUnit,null,popClose,'#popup_detail');
	   }else{
			popClose('#popup_detail');
	   }
	   </c:if>
	   <c:if test="${!fn:contains(sessionScope.USER_CLASS,'A')}">
		popClose('#popup_detail');
	   </c:if>
   }
   
   //휴대폰번호에 숫자만 가능 
	$("#unitPicTelno").keyup(function(event){
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi,''));
	});
   
   function checkUpdateData(){
	  
	   if( $("#bocdNm").attr("asisData") ){
			var asisBocdNm = $("#bocdNm").attr("asisData");
	   }else{
		   var asisBocdNm = "";
	   } 
		   
	   if( $("#unitPic").attr("asisData") ){
			var asisUnitPic = $("#unitPic").attr("asisData");  
	   }else{
		   var asisUnitPic = "";
	   } 
	   if($("#unitPicTelno").attr("asisData")){
			var asisUnitPicTelno = $("#unitPicTelno").attr("asisData");   
	   }else {
			var asisUnitPicTelno = "";
	   }
	   
	   if((asisBocdNm != $("#bocdNm").val() || asisUnitPic != $("#unitPic").val() || asisUnitPicTelno != $("#unitPicTelno").val()) ){
		   return true;
	   }else {
		   return false;
	   }
	   
   }
   
</script>