<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <!--popup-->
<div class="popup_wrap" id="file-modal" style="display: none;">
  <!-- top -->
  <div class="top">
    <div class="title">파일선택</div>
    <div class="btn_close"><a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" id="btn_file_close" /></a></div>
  </div>
  <!-- //top --> 
  
  <!-- content -->
  <div class="content_pop">
  	<div class="tar mgb10"><a href="${pageContext.request.contextPath}/message/download/sample/message" class="btn_default">샘플 다운받기</a></div>
    <!-- box -->
    <div class="box_search01 small">
      <ul>
        <li>
        	<span class="mgl5"><input type="text" id="file-name-input" placeholder="파일 업로드" style="width:330px" readonly="readonly"></span>
           	<input type="file" id="fileupload" name="file" data-url="${pageContext.request.contextPath}/message/upload" style="display:none" placeholder="파일 업로드" accept=".xls, .xlsx, .csv">
            <a href="javascript:" class="btn_default gray mgl6 vam00" id="fileupload-btn">찾아보기</a>
        </li>
      </ul>
    </div>
    <!-- //box -->
    <div class="mgt10">* 확장자 xls , xlsx 또는 csv 파일만 가능합니다.</div>
  </div>
  <!-- //content --> 
  
  <!-- footer -->
  <div class="footer_pop"> 
    <!-- button --><a href="javascript:;" class="btn_big blue" id="btn_file_ok">등록</a><a href="javascript:;" class="btn_big gray" id="btn_file_cancel">취소</a><!-- //button --> 
  </div>
  <!-- //footer --> 
</div>
<!--//popup-->

<script>
function showFileUpload() {
		init();
		
		var fileList;
		$("#btn_file_close").off().on('click', function () {
		    $("#file-modal").dialog("close");
		});
		
		$("#btn_file_ok").off('click').on('click', function () {
			if($("#file-name-input").val() == "" || fileList == null){
				showAlert("파일이 등록되지 않았습니다.");
				return false;
			}
			
			$('.dimm').show();
			
			// loading View 출력을 위한 딜레이
			setTimeout(function() { 
				addTargetList(fileList, "file");
				
				$('.dimm').hide();
				$("#file-modal").dialog("close");
			}, 10);
		});
		
		$("#btn_file_cancel").off('click').on('click', function () {
		    $("#file-modal").dialog("close");
		});
		

	    $("#fileupload-btn").off('click').on("click", function () {
	        $("#fileupload").trigger('click');
	      });
		
	    $('#fileupload').fileupload({
	      	dataType: 'json',
	      	done: function (e, data) {
	      	console.log(data);
	      	console.log(data.result.fileList);
	      	console.log(data.result.fileName);
	      	if(data.result.fileList == null){
	      		console.log(data.result.errorMsg);
	      		var errorMsg = data.result.errorMsg;
	      		
	      		showAlert(errorMsg+"<br>파일 확인 후 다시 진행 해주시기 바랍니다.");
// 	      		showAlert("해당 파일에 등록 가능한 연락처가 없습니다.<br>파일 확인 후 다시 진행 해주시기 바랍니다.");
	      		return false;
	      	}
	      	fileList = data.result.fileList;
	        $("#file-name-input").val(data.files[0].name);
	      }
	    });
		
		$("#file-modal").dialog({
		    modal: true,
		    width: "530px",
		    open: function () {
		      $(this).css('padding', '0px');
		    },
		  });
		$(".ui-dialog-titlebar").hide();
}
 
function init(){
	$("#file-name-input").val("");
	$("#fileupload").val("");
}
</script>