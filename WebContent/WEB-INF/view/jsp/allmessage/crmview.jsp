<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<h3 style="font-size:20px;">발송내역 상세조회</h3>

<div id="content">
    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01" id="resSuccess" >
          <colgroup>
          <col style="width:160px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">발송일시</th>
            <td><input type="text" id="reqDate" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">이동통신사 처리결과</th>
            <td><input type="text" id="rslt" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">메시지 구분</th>
            <td><input type="text" id="messageType" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr id="subject_label">
            <th scope="row">메시지 제목</th>
            <td><input type="text" id="subject" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">메시지 내용</th>
            <td><textarea type="text" id="msg" style="width:750px;background-color: #eeeeee;height:50px;" readonly></textarea></td>
          </tr>          
          <tr>
            <th scope="row">발신전화번호</th>
            <td><input type="text" id="callback" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">통신사</th>
            <td><input type="text" id="telcoInfo" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
            <th scope="row">통신사응답일시</th>
            <td><input type="text" id="rsltDate" style="width:750px;background-color: #eeeeee;" readonly></td>
          </tr>
          <tr>
          	<td colspan="2">
          		<div id="mms_info" style="display:none">
		       	* 이미지와 메세지 내용은 휴대폰 기종에 따라 보이는 순서가 다를 수 있습니다.
		       	</div>
          		<div id="mms_image">        
        		</div>
        	</td>
          </tr>
        </table>
        <table class="tbl_view01" id="resFail" style="display:none" >
        	<tr>
	          	<td colspan="2" style="text-align:center;height:300px;">
	          		<label id="error_message"></label>
	        	</td>
            </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->
</div>

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
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<script>
	function openImageDetail(seq) {
		console.log("openImageDetail:"+seq);
		var image = $("<img style='width:100%;height: calc( 100vh - 250px);'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + seq);
		$("#image_detail").find("#image_view").children().remove();
		$("#image_detail").find("#image_view").append(image);
		popOpen("#image_detail");	
	}

	function imageView(result) {
	   $("#content").find("#mms_image").children().remove();
	   $("#content").find("#mms_info").attr("style", "display:none;");
	   $("#content").find("#mms_info").find("td").attr("colspan", "2");
	   if (result.value.MESSAGETYPE == "MMS") {
		   $("#content").find("#mms_info").attr("style", "display:block;");
		   if (result.value.SEQ1 != undefined && result.value.SEQ1 != "0") {
			   /* var imgSeq1 = $("<img style='width:160px;height:160px;'/>").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.value.SEQ1);
			   imgSeq1.on("click", function() {
				   openImageDetail(result.value.SEQ1);
			   }); */
			   var imgdiv = $("<div style='width:160px;display:inline-block;'/>");
			   var imgSeq1 = $("<img style='width:160px;height:160px;'/>").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.value.SEQ1);
			   var imgLabel1 = $("<span style='width:160px;'/>").text("이미지식별번호 : "+ result.value.SEQ1);
			   imgSeq1.on("click", function() {
				   openImageDetail(result.value.SEQ1);
			   });
			   imgdiv.append(imgSeq1);
			   imgdiv.append(imgLabel1);
			   
			   $("#content").find("#mms_image").append(imgdiv);
		   }
		   
		   if (result.value.SEQ2 != undefined && result.value.SEQ2 != "0") {
			   /* var imgSeq2 = $("<img style='width:160px;height:160px;'/>").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.value.SEQ2);
			   imgSeq2.on("click", function() {
				   openImageDetail(result.value.SEQ2);
			   }); */
			   var imgdiv = $("<div style='width:160px;display:inline-block;'/>");
			   var imgSeq2 = $("<img style='width:160px;height:160px;'/>").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.value.SEQ2);
			   var imgLabel2 = $("<span style='width:160px;'/>").text("이미지식별번호 : "+ result.value.SEQ2);
			   imgSeq2.on("click", function() {
				   openImageDetail(result.value.SEQ2);
			   });
			   imgdiv.append(imgSeq2);
			   imgdiv.append(imgLabel2);
			   $("#content").find("#mms_image").append(imgdiv);
		   }
		   
		   if (result.value.SEQ3 != undefined && result.value.SEQ3 != "0") {
			   /* var imgSeq3 = $("<img style='width:160px;height:160px;'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.value.SEQ3);
			   imgSeq3.on("click", function() {
				   openImageDetail(result.value.SEQ3);
			   }); */
			   var imgdiv = $("<div style='width:160px;display:inline-block;'/>");
			   var imgSeq3 = $("<img style='width:160px;height:160px;'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + result.value.SEQ3);
			   var imgLabel3 = $("<span style='width:160px;'/>").text("이미지식별번호 : "+ result.value.SEQ3);
			   imgSeq3.on("click", function() {
				   openImageDetail(result.value.SEQ3);
			   });
			   imgdiv.append(imgSeq3);
			   imgdiv.append(imgLabel3);
			   $("#content").find("#mms_image").append(imgdiv);
		   }
	   }
	}
$(document).ready(function () {
	var msgKey = "${msgKey}";
	var regDt = "${regDt}";
	var telno = "${telno}";
	$.ajax({
		url: '${pageContext.request.contextPath}/crmview',
		type: "POST",
		//contentType: "application/json; charset=utf-8",
		dataType: "json",
		data: {"msgKey":msgKey,"regDt":regDt,"telno":telno},
		success: function (result) {
			if (result.res.response_code == 0) {
				$("#resSuccess").show();
				$("#resFail").hide();
	   			$("#reqDate").val(result.value.REQDATE);
	   			$("#rslt").val(result.value.RSLT);
	   			$("#messageType").val(result.value.MESSAGETYPE);
	   			$("#subject").val(result.value.SUBJECT);
	   			$("#msg").val(result.value.MSG);
	   			$("#callback").val(result.value.CALLBACK);
	   			$("#telcoInfo").val(result.value.TELCOINFO);
	   			$("#rsltDate").val(result.value.RSLTDATE);
	   			
	   			if (result.value.MESSAGETYPE == "MMS"){
	   				imageView(result);		
	   			}
	   			
	   			if (result.value.MESSAGETYPE == "LMS" || result.value.MESSAGETYPE == "MMS"){
	   			   $("#resSuccess").find("#subject_label").show();
	   		   } else {
	   			   $("#resSuccess").find("#subject_label").hide();
	   		   }
			} else {
				// TODO : ERROR
				$("#resSuccess").hide();
				$("#resFail").show();
				$("#error_message").text(result.res.response_message);
			}
     	}
	});
	
});
   
</script>