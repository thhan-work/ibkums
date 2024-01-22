<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div class="popup_wrap" id="saveMsg-modal" style="display: none;"> 
  <!-- top -->
  <div class="top">
    <div class="title">메시지 저장</div>
    <div class="btn_close"><a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" id="btn_saveMsg_close"/></a></div>
  </div>
  <!-- //top --> 
  
  <!-- content -->
  <div class="content_pop"> 
    <!-- Search -->
    <div class="box_search01 small">
      <ul>
        <li>
        <span class="fwb">메시지 제목 :</span>
        <span class="mgl5"><input type="text" id="pop_saveMsg_title" value="" placeholder="" style="width:110px" ></span>
        <span>
          <select id="pop_saveMsg_SelectBox">
            <option value="personal">개인저장 메시지함</option>
            <option value="dept">부서저장 메시지함</option>
          </select>
          </span>
          <span class="fwb">으로 저장</span>
          </li>
      </ul>
    </div>
    <!-- //Search -->
    <div class="mgt10">* 90byte 이상시 mms메세지로 저장됩니다.</div>
  </div>
  <!-- //content --> 
  
  <!-- footer -->
  <div class="footer_pop"> 
    <!-- button --><a href="javascript:;" class="btn_big blue" id="btn_saveMsg_save">등록</a><a href="javascript:;" class="btn_big gray" id="btn_saveMsg_cancel">취소</a><!-- //button --> 
  </div>
  <!-- //footer --> 
</div>
<!--//popup-->

<script>
  function showSaveMsg(msg) {
 	$("#pop_saveMsg_SelectBox option[value=personal]").attr("selected","selected");
 	
 	var inputTitle = $("#messageTitle").val()
 	if(inputTitle != null && inputTitle.length > 50){
 		inputTitle = inputTitle.substr(0,50);
 	}
  	$("#pop_saveMsg_title").val(inputTitle);

  	var saveMsg_msg = msg

	$("#btn_saveMsg_close").off().on('click', function () {
        $("#saveMsg-modal").dialog("close");
    });
    
    $("#btn_saveMsg_cancel").off().on('click', function () {
        $("#saveMsg-modal").dialog("close");
    });
    
    $("#btn_saveMsg_save").off().on('click', function () {
    	var saveMsg_code = $("#pop_saveMsg_SelectBox option:selected").val();
    	var saveMsg_title = $("#pop_saveMsg_title").val();
    	
    	if(saveMsg_title == null || saveMsg_title.trim() == "")
   		{
    		showAlert("메세지 제목을 입력해주세요!");
    		return false;
   		}
    	
        $("#saveMsg-modal").dialog("close");
    	saveMsg(saveMsg_code ,saveMsg_msg, saveMsg_title);
    });
    
    $("#saveMsg-modal").dialog({
        modal: true,
        width: "550px",
        open: function () {
          $(this).css('padding', '0px');
        },
      });
    $(".ui-dialog-titlebar").hide();
  }
  
  $("#pop_saveMsg_SelectBox").on('change', function(){
		titleValidate();
  });
  
  $(document).on('keyup', '#pop_saveMsg_title', function () {
		titleValidate();
  });
  
  function titleValidate(){
	 	var saveType = $("#pop_saveMsg_SelectBox :selected").val()
	  	var maxByte = 50;
	 	
	 	// 제목은 개인사서함 50byte/ 부서사서함 40byte 로 고정
	 	if(saveType == "personal"){
	 		maxByte = 50;	
	 	}else if(saveType == "dept"){
	 		maxByte = 40;
	 	}
	    
	    var strByteInfo = IbkByteCheck.getBytesAndMaxLength($("#pop_saveMsg_title").val(), maxByte);
	    if (strByteInfo.totalByte > maxByte) {
	      showAlert('제목은 '+ maxByte +'byte 까지 입력 가능 합니다.');
	      $("#pop_saveMsg_title").val($("#pop_saveMsg_title").val().substring(0, strByteInfo.ableLength))
	    }
  }
</script>