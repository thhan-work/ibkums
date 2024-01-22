<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="popup_wrap" id="groupAdd-dialog" style="display: none"> 
		<!-- top -->
		<div class="top">
				<div class="title" id="title">그룹추가</div>
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
          <div class="tbl_wrap_view">
            <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
              <caption>검색조건 테이블입니다.</caption>
              <colgroup>
	              <col style="width:140px" />
	              <col style="width:auto" />
              </colgroup>
              <tr>
                	<th scope="row">공유여부</th>
	                <td>
	                		<div class="radio_default">
	    						<input type="radio" id="radio1" name="shareyn" value="0"/>
	    						<label for="radio1">공유안함</label>
	  						</div>
	  						<div class="radio_default">
							    <input type="radio" id="radio2" name="shareyn" value="1"/>
							    <label for="radio2">공유</label>
	  						</div>
	  				</td>
              </tr>
              <tr>
	                <th scope="row">그룹명</th>
	                <td><input type="text" id="groupname" name="groupname" value="" placeholder="그룹명 입력" style="width:280px" maxlength="64"></td>
              </tr>
              <tr>
	                <th scope="row">그룹설명</th>
	                <td><input type="text" id="groupnote" name="groupnote" value="" placeholder="그룹설명 입력" style="width:280px" maxlength="64"></td>
              </tr>
            </table>
          </div>
          <!-- //table_view -->
				<div class="mgt10">* <span class="fwb">Tip.</span> 생성된 그룹에 사람을 추가하실려면 그룹명을 클릭하시면 됩니다.</div>
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
        <div class="title" id="confirm-dialog-title">삭제</div>
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

<script src="${pageContext.request.contextPath}/static/js/messageUtil.js"></script>

<script>

/*기존 다이얼로그 시작*/
 function showAlert(message, callback) {
    $("#alert-message").html(message);

    $("#alert-dialog-close").unbind().on('click', function () {
      if (callback) {
        callback();
      }
      $("#alert-message").html("");
      $("#alert-modal").dialog("close");
    });

    $("#alert-modal").dialog({
      modal: true,
      width: 'auto'
    });
    $(".ui-dialog-titlebar").hide();
  }

  function showConfirmCancel(message, callback) {
    $("#confirm-message").html(message);

    $(".confirm-dialog-close").unbind().on('click', function () {
      $("#confirm-dialog").dialog("close")
    });

    $("#confirm-yes-btn").unbind().on('click', function () {
      showAlert("취소 하였습니다.", callback);
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

  function showConfirmForAjax(message, callback, targetObject, title) {
    $("#confirm-message").html(message);
    if(title !=null &&title !=""){
    	$("#confirm-dialog-title").html("");
        $("#confirm-dialog-title").html(title);	
    }else{
    	$("#confirm-dialog-title").html("");
        $("#confirm-dialog-title").html("삭제");	    	
    }
    
    $(".confirm-dialog-close").unbind().on('click', function () {
      $("#confirm-dialog").dialog("close")
    });

    $("#confirm-yes-btn").unbind().on('click', function () {
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

/* 추가 팝업 처리 시작 */ 
function showAddPopUp(callback) {
	$("#groupname").val("");
    $("#groupnote").val("");
    $('input[name="shareyn"]:input[value="0"]').prop("checked", true);
    
    $(".popup-close").unbind().on('click', function () {
        if (callback) {
          callback();
        }
        $("#groupAdd-dialog").dialog("close");
      });
    $("#groupAdd-dialog").dialog({
      modal: true,
      width: "600px",
      open: function () {
        $(this).css('padding', '0px');
      }
    });
    
    $(".group-add").unbind().on('click', function () {
        if (!IbkValidation.validInputBox("groupname")) {
          showAlert("그룹명을 입력 하세요");
        }else{
  		  	_byte = checkByteTextarea($("#groupname"));//byte 계산
		 	if (_byte > 64) {
			   showAlert("그룹명은 최대 64Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)");
			   $("#groupname").focus();
			   return false;
		 	}
        }
        
        if (!IbkValidation.validInputBox("groupnote")) {
            showAlert("그룹설명을 입력 하세요");
        }else{
  		  	_byte = checkByteTextarea($("#groupnote"));//byte 계산
		 	if (_byte > 64) {
			   showAlert("그룹설명은 최대 64Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)");
			   $("#groupnote").focus();
			   return false;
		 	}
        }
        

        var groupInfo = getGroupInfo();
        $.ajax({
          url: '${pageContext.request.contextPath}/address',
          type: "POST",
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          data: JSON.stringify(groupInfo),
          success: function (result) {
            showAlert("등록을 완료 하였습니다.", callback);
            IbkDataTable.reload();
            $("#groupAdd-dialog").dialog("close");
          }
        });
      });
    
    $(".ui-dialog-titlebar").hide();
  }
/* 추가 팝업 처리 끝 */ 

/* 수정 팝업 처리 시작 */  
function showModPopUp(callback,data) {
	
    $(".popup-close").unbind().on('click', function () {
        if (callback) {
          callback();
        }
        $("#groupAdd-dialog").dialog("close");
      });
    $("#groupAdd-dialog").dialog({
      modal: true,
      width: "600px",
      open: function () {
        $(this).css('padding', '0px');
      }
    });
    
    //넘어온 값으로 셋팅
    $("#title").text("그룹수정");
    $("#submit").text("수정");
    $("#groupname").val(data.groupName);
    $("#groupnote").val(data.groupNote);
    
    if(data.groupShareYn=='1'){
    	$("#radio2").prop("checked", true);
    }else{
    	$("#radio1").prop("checked", true);
    }
    
    $(".group-add").unbind().on('click', function () {
        if (!IbkValidation.validInputBox("groupname")) {
          showAlert("그룹명을 입력 하세요");
        }else{
  		  	_byte = checkByteTextarea($("#groupname"));//byte 계산
		 	if (_byte > 64) {
			   showAlert("그룹명은 최대 64Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)");
			   $("#groupname").focus();
			   return false;
		 	}
        }
        
        if (!IbkValidation.validInputBox("groupnote")) {
            showAlert("그룹설명을 입력 하세요");
         }else{
  		  	_byte = checkByteTextarea($("#groupnote"));//byte 계산
		 	if (_byte > 64) {
			   showAlert("그룹설명은 최대 64Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)");
			   $("#groupnote").focus();
			   return false;
		 	}
        }
        
		data.groupName=$("#groupname").val();
		data.groupNote=$("#groupnote").val();
		data.groupShareYn=$('input[name="shareyn"]:checked').val();

        $.ajax({
          url: '${pageContext.request.contextPath}/address',
          type: "PUT",
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          data: JSON.stringify(data),
          success: function (result) {
            showAlert("수정을 완료 하였습니다.", callback);
            $("#groupAdd-dialog").dialog("close");
            IbkDataTable.reload();
          }
        });
      });
    
    $(".ui-dialog-titlebar").hide();
  } 
/* 수정 팝업 처리 끝 */

/* 그룹 추가 정보 얻기 시작  */  
  function getGroupInfo() {
    return {
      "groupName": $("#groupname").val(),
      "groupNote": $("#groupnote").val(),
      "groupShareYn":$('input[name="shareyn"]:checked').val()
    };
  }
/* 그룹 추가 정보 얻기 끝*/
</script>