<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 파일업로드 창 시작  -->
<div class="popup_wrap" id="fileUpload-dialog" style="display: none"> 
		<!-- top -->
		<div class="top">
				<div class="title" id="title">파일선택</div>
				<div class="btn_close">
					<a href="javascript:;" class="popup-close">
						<img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" />
					</a>
				</div>
		</div>
		<!-- //top --> 
		<!-- content -->
		<div class="content_pop">
    	<!-- table_view -->
    	   <div class="box_info_blue mgt0">
    	   	<div class="title">파일 불러오기 도움말</div>          
					<ul class="text1 mgt10">
						<li>* 확장자 xls 또는 csv 파일만 가능합니다</li>
						<li>* 문서암호화해제를 하고 파일을 불러오시기 바랍니다.</li>
						<li>* 순서는 핸드폰번호, 메시지1, 메시지2 입니다.</li>
						<li>* 메시지1, 2는 자동으로 합쳐집니다.</li>
					</ul>
           </div>
    	  <form id="file-form" >
    	  	<input type="file" id="file-input" name="file" value="" onChange="fileChange();" style="display:none;" accept=".xls, .xlsx, .csv"/>
    	  </form>
          <div class="tbl_wrap_view">
            <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
              <caption>검색조건 테이블입니다.</caption>
              <colgroup>
	              <col style="width:auto" />
	              <col style="width:auto" />
              </colgroup>
              <tr>
	                <td><input type="text" id="file_name" name="file_name" value="" placeholder="업로드할 파일을 선택하세요...." style="width:350px"></td>
	                <td><a href="javascript:;" class="btn_default fileopen" id="file-find-btn">파일 찾기</a></td>
              </tr>
            </table>
          </div>
          <!-- //table_view -->
		</div>
		<!-- //content --> 
		
		<!-- footer -->
		<div class="footer_pop"> 
				<!-- button -->
				<a href="#" class="btn_big blue group-add" id="submit">등록</a>
				<a href="#" class="btn_big gray popup-close">취소</a>
				<!-- //button --> 
		</div>
		<!-- //footer --> 
</div>
<!-- 파일업로드 창 끝  -->

<div class="alert_wrap" id="alert-modal" style="display: none">
    <!-- content -->
    <div class="content_alert" id="alert-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_alert">
        <!-- button -->
        <a href="javascript:;" class="btn_big blue" id="alert-dialog-close">확인</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>

<div class="popup_wrap_s" id="confirm-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">보내기</div>
        <div class="btn_close">
            <a href="javascript:;" class="confirm-dialog-close">
                <img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png"
                     alt="닫기"/>
            </a>
        </div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop" id="confirm-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:;" class="btn_big blue" id="confirm-yes-btn">예</a>
        <a href="javascript:;" class="btn_big gray confirm-dialog-close">아니오</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>

/* 추가 팝업 처리 시작 */ 
function showUploadPopUp(callback) {
    $(".popup-close").on('click', function () {
        if (callback) {
          callback();
        }
        $("#fileUpload-dialog").dialog("close");
      });
    $("#fileUpload-dialog").dialog({
      modal: true,
      width: "600px",
      open: function () {
        $(this).css('padding', '0px');
      }
    });

    $(".ui-dialog-titlebar").hide();
  }
/* 추가 팝업 처리 끝 */ 

$("#file-find-btn").on('click', function () {
    	$("#file-input").click();
});
$("#submit").on('click', function () {
	
	if($('input[type=file]').val()==""){
 		showAlert("파일을 선택해주세요.");
 		return false;
 	} 
	$.ajax({
	    url: "${pageContext.request.contextPath}/message/filesendupload",
	    type: "POST",
	    data: new FormData($("#file-form")[0]),
	    enctype: 'multipart/form-data',
	    processData: false,
	    contentType: false,
	    cache: false,
	    success: function (data) {
		     if(data.fileList == null){
			     	var errorMsg = data.errorMsg;
			     	showAlert(errorMsg+"<br>파일 확인 후 다시 진행 해주시기 바랍니다.");
			     	return false;
		     }
			IbkDataTable.dataTable.clear();
			IbkDataTable.dataTable.rows.add(data.fileList).draw();
			$("#total_cnt").text(data.fileList.length);
	    },
	    error: function (data) {
	    	var jData=JSON.parse(data.responseText);
	    	showAlert("파일 업로드가 실패했습니다."+"("+jData.message+")");
	    }
	  }); 
	$("#fileUpload-dialog").dialog("close");
});
function fileChange(){
	var fileName = $('input[type=file]').val();
	var clean=fileName.split('\\').pop();
	console.log(clean);
	$("#file_name").val(clean);
}

/* 다이얼로그 닫을 시 화면 갱신  시작*/  
  function redirectList() {
	    /* setTimeout(function () {
	      window.location.href = "${pageContext.request.contextPath}/filesend.ibk";
	    }, 100); */
  }

  /* 다이얼로그 닫을 시 화면 갱신  끝*/  
/*기존 다이얼로그 시작*/
 function showAlert(message, callback) {
    $("#alert-message").html(message);

    $("#alert-dialog-close").on('click', function () {
      if (callback) {
    	  setTimeout(function () {
    	  	callback();
    	  }, 100);
      }
      $("#alert-modal").dialog("close");
    });

    $("#alert-modal").dialog({
      modal: true,
      width: '400px'
    });
    $(".ui-dialog-titlebar").hide();
  }

  function showConfirmForAjax(message, callback, targetObject) {
    $("#confirm-message").html(message);

    $(".confirm-dialog-close").on('click', function () {
      $("#confirm-dialog").dialog("close")
    });

    $("#confirm-yes-btn").on('click', function () {
      callback(targetObject);
      targetObject = [];
      $("#confirm-dialog").dialog("close");
    });

    $("#confirm-dialog").dialog({
      modal: true,
      width: "400px",
      open: function () {
        $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
/*기존 다이얼로그 끝 */

</script>