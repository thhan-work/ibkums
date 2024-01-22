<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>

<h3>경조사보내기
</h3>

<!-- content -->
<div id="content">
    <!-- wrap_box_nsend -->
    <div class="wrap_box_nsend2 mgt30">
        <!-- phone -->
        <div class="col1">
            <div class="box_nsend">
                <div class="content">
                    <div class="text_sms" style="height: 230px">
                        <textarea class="sms" id="message"  title="레이블 텍스트" placeholder="내용을 입력하세요" style="font-family:굴림; font-size:16px; width:100%; height:230px; padding-right:5px;"> </textarea>
                        <span class="main-msg" style="position: absolute; left: 12px; top: 0px;"> 
                        	* 고객정보 및 은행 주요정보 송신을 <br>금지합니다.<br> <br>
                        	<font color="red"> <b>  * SMS/MMS 발송은 업무용으로만 <br>사용하시고, 사적으로는 사용하지<br>마세요.</b></font>
                        </span>
                    </div>
                    <div class="byte">0 byte <span>SMS</span></div>
                    <div class="tac mgt19"><a href="javascript:;" class="btn_msave_blue" id="btnMessageSave">메시지저장</a><a href="javascript:;" class="btn_refresh_blue mgl6" id="btnMessageClear">새로쓰기</a><a href="javascript:;" class="btn_scode_blue mgl6" id="specharPreview">특수문자</a></div>
                </div>
                <div class="info mgt22">*SMS/MMS 발송은 업무용으로만 사용하시고,<br>사적으로는 사용하지마세요.</div>
                <div class="snum">발신번호 <input type="text" id="sender" name="search" value="" placeholder="입력하세요" ></div>
				<div class="mgt15"><a href="javascript:;" ><img src="${pageContext.request.contextPath}/static/images/btn_preview.png" alt="미리보기" id="popupPreview" /></a><a href="javascript:;" class="mgl5" id="btn_reserve_send"><img src="${pageContext.request.contextPath}/static/images/btn_rsend.png" alt="예약전송" /></a><a href="javascript:;" class="mgl5"><img src="${pageContext.request.contextPath}/static/images/btn_send.png" id="btn_send" alt="보내기" /></a></div>
				<input type="hidden" id="reserveDate"/>
           	</div>
        </div>
                        <!-- //phone -->
        <!-- 수신번호 -->
	    <div class="col2" id="sms-receiver">
	    	<div class="title">수신번호 (총 <span>0</span>개)</div>
            <!-- table list -->
            <div class="tbl_wrap_list_small mgt16" style="width:268px; height:481px; overflow-y:scroll;">
                <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
                    <caption>
                        테이블
                    </caption>
                    <colgroup>
                        <col style="width:95px;" />
                        <col style="width:" />
                    </colgroup>
                    <tbody class="sms-send-list" id="sms-send-list"></tbody>
                </table>
            </div>
            <!-- //table list -->
            <div class="mgt9"><a href="javascript:;" id="btn-remove" class="btn_default delete small">삭제</a><a href="javascript:;" id="btn-removeAll" class="btn_default delete small mgl6">전체삭제</a></div>
        </div>
        <!-- //수신번호 -->
        <!-- 주소록 -->
        <div class="col3">
            <div class="title">수신인 검색/직급직위 선택</div>
            <div class="box1 mgt16">
                <div class="radio_default">
                    <input type="radio" id="sms-event-r1" name="sms_person" value="all" class="send-all" />
                    <label for="sms-event-r1">전직원에게 발송</label>
                </div>
                <div class="radio_default mgt22">
                    <input type="radio" id="sms-event-r2" name="sms_person" value="area" class="send-area" />
                    <label for="sms-event-r2">지역소속 직원에게 발송</label>
                </div>
                <div class="fl mgt9 mgl22">
                    <select name="sms_bo_area" style="width: 186px">
		                <option value="default" >선택</option>
		                <option value="750" >강동영업본부</option>
		                <option value="751" >충청영업본부</option>
		                <option value="752" >북부영업본부</option>
		                <option value="753" >강남영업본부</option>
		                <option value="754" >서부영업본부</option>
		                <option value="755" >경수영업본부</option>
		                <option value="756" >경인영업본부</option>
		                <option value="757" >부산경남영업본부</option>
		                <option value="758" >호남영업본부</option>
		                <option value="759" >대구경북영업본부</option>
		                <option value="760" >강서영업본부</option>
		                <option value="990" >본부부서</option>
		                <option value="991" >사업본부</option>
		                <option value="992" >해외영업</option>
		              </select>
                    <a href="javascript:;" class="btn_default gray" id="btn_search_area">검색</a>
                </div>
                <div class="radio_default mgt23">
                    <input type="radio" id="sms-event-r3" name="sms_person" value="code" class="send-code" />
                    <label for="sms-event-r3">영업점직원에게 발송</label>
                </div>
                <div class="fl mgt9 mgl22">
                   <input type="text" name="sms_bo_code" id="send-code" value="" placeholder="영업점 코드 입력" style="width: 164px">
                    <a href="javascript:;" class="btn_default gray" id="btn_search_shop">검색</a>
                </div>
            </div>

            <div class="box2" style="display: none;">
               <div>
                    <span class="title01">직급선택</span>
                    <select class="vab0 mgl4" name="EMPL_CLASS" style="width: 197px">
						<option value="default" selected="selected">선택</option>
						<option value="ALL" >전체</option>
						<c:forEach items="${classList}" var="loop">
							<option value="${loop.classCode}" >${loop.className}</option>
						</c:forEach>
		            </select>
                </div>
                <div class="mgt15">
                    <span class="title01">직위선택</span>
		            <select class="vab0 mgl4" name="EMPL_POSITION_NAME" style="width: 197px">
			            <option value="default" selected="selected">선택</option>
			            <option value="ALL" >전체</option>
			            <c:forEach items="${positionList}" var="loop"> 
			            <option value="${loop.positionCallname}">${loop.positionCallname}</option>
			            </c:forEach>
		            </select>
                </div>
                <div class="info mgt19">* ‘영업점직원에게 발송’ 을 선택하셨을 경우<br>&nbsp;&nbsp;직급/직위 적용이 안됩니다</div>
            </div>
        </div>
        <!-- //주소록 -->
    </div>
    <!-- //wrap_box_nsend -->
</div>
<!-- //content -->

<%-- <script src="${pageContext.request.contextPath}/static/js/tabcontent.js"></script> --%>
<script src="${pageContext.request.contextPath}/static/js/messageUtil.js"></script>


<!-- alert dialog 와 confirm dilalog 를 사용하기 위해서 필요 -->
<jsp:include page="../generalSend/dialog/messageDialog.jsp" flush="true"/>

<!-- ajax Loding 이미지 -->
<jsp:include page="../common/loading.jsp" flush="true"/>

<!-- 미리보기 팝업 -->
<jsp:include page="../generalSend/dialog/previewDialog.jsp" flush="true"/>
<!-- 특수문자 팝업 -->
<jsp:include page="../generalSend/dialog/specharDialog.jsp" flush="true"/>
<!-- 메세지 저장 팝업 -->
<jsp:include page="../generalSend/dialog/saveMsgDialog.jsp" flush="true"/>
<!-- 예약전송 팝업 -->
<jsp:include page="../generalSend/dialog/reserveDialog.jsp" flush="true"/>

<!-- 수신인 검색 팝업 -->
<jsp:include page="./dialog/searchDialog.jsp" flush="true"/>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatables.js"></script>
<!-- Script -->
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/notice-column.js"></script>
        
<script>
//// ajax Loding 이미지 설정
var flag=true;
$(document).ajaxStart(function () 
{
    flag=true;
    ajaxLoadingTimeout = setTimeout(function () {
        if(flag){
           $('.dimm').show();
        }
    }, 1000)

});

$(document).ajaxStop(function () {
    flag=false;
    clearTimeout(ajaxLoadingTimeout);
    $('.dimm').hide();
});


//// 최초 메시지 안내 문구 출력
$(".main-msg").click(function() {
	$(".main-msg").remove();
	$("#message").trigger("click");
});

//##################################메시지 내용 입력 이벤트@1#########################################
var isFirstMsg = true;
var emplId = '<%=session.getAttribute("EMPL_ID")%>';

////메시지 입력 박스 선택 시 이벤트설정 
$("#message").click(function() {
  $("#message").focus();
});  
  
////메시지 입력 박스 포커스 이벤트
$("#message").focus(function() {
	if(isFirstMsg)
	{
		$("#message").val("");
		$(".main-msg").remove();
		isFirstMsg = false;
	}
});
  
////메시지 입력 박스 키업 이벤트
  $("#message").keyup(function() {
	  messageByteCheck();
  });

////미리보기 팝업
$("#popupPreview").click(function()  {
	var top = "";
	var message = $("#message").val();
 
	showPreview(top, message);	  
	return false;//현재 사용자가 보고있는 위치 유지
});

////발신번호 숫자입력 체크 이벤트
$("#sender").on("keyup", function(){
	inputPhoneType($(this));
});

////특수문자 팝업
  $("#specharPreview").click(function()  {
	  showSpechar();
 	  return false;//현재 사용자가 보고있는 위치 유지
  });
  
//// 예약전송 팝업
  $("#btn_reserve_send").click(function(){
	  //경조사 보내기는 즉시 발송만 가능 
	  showAlert("경조사 보내기는 즉시전송만 가능합니다.");
	  return false;
	  
	  var result = validateMsgSendInfo();
	  if(result != false){
		  showReserve();
	  }
  });
  
//// SMS 발송
  $("#btn_send").click(function() {
	  var result = validateMsgSendInfo();
	  if(result != false){
		showConfirmSend('메시지를 전송하시겠습니까?',  msgSend, msgSendInfo);
		return false;
	  }
  });


var msgSendInfo;
//// SMS 발송 정보 벨리데이션
function validateMsgSendInfo(){
    
	
    if($('#message').val() != ''){
        if(typeof( $('#message').val() ) != "undefined" ){
        }
    }
    else{
        showAlert('메세지를 입력해 주시기 바랍니다.');
        return false;
    }
	
    if($('#sender').val() != ''){
        if(typeof( $('#sender').val() ) != "undefined" ){
//         	alert("undefined");
// 			addTargetKeyDown();   
        }
    }
    else{
        showAlert('발신번호를 입력해 주시기 바랍니다.');
        return false;
    }
	
    if(typeof( $("input[name=sms_person]:checked").val() ) == "undefined" ){
        showAlert('수신인 종류를 선택해 주시기 바랍니다.');
        return false;
    }    
    
    var sender = $("#sender").val();      
	
    if (_byte > 88) {
    	showAlert("메시지 내용은 88바이트 이상은 전송하실수 없습니다.");
        return false;
    }
  	  
    var addrs = $("#sms-receiver input[name=addrchk]:checked");
    var allSendYn = $("input.send-all").is(":checked");
    
    var sendType = "";
    
    $("input[name=sms_person]").each(function() {
      if($(this).is(":checked")) {
        sendType = $(this).val();
      }
    });
    
    $("#event-send-type").val(sendType);
    
    if (addrs.length > 0 || allSendYn) {
        var receivers = null;
        addrs.each(function(index) {
          var _parent = $(this).parent().parent().parent();
          var _addr = _parent.find('label').text() + ":" + _parent.find('.phone').text();
          if (index == 0) receivers = (_addr + "|");
          else receivers += _addr + "|";
        });
    } else {
      showAlert("받는 사람을 추가 하거나 주소록에서 선택하십시오.");
      return false; 
    }
    $("input#sendCount").val(addrs.length);
    $("input#receivers").val(receivers);
    
//     if($("input#sms-event-r2").is(":checked")) {
//       if($("select[name=EMPL_CLASS]").val() == 'default') {
//     	showAlert("직급을 선택해 주세요.");
//         return false;
//       }
//       if($("select[name=EMPL_POSITION_NAME]").val() == 'default') {
//         showAlert("직위를 선택해 주세요.");
//     	return false;
//       }
//     }
    
    
    
    
    // msgSendInfo 초기화
    msgSendInfo = getMsgSendInfo();
    
    msgSendInfo.sendType = $(".byte").find("span").text();
    msgSendInfo.sendCount = addrs.length;
    msgSendInfo.receivers = receivers;
    msgSendInfo.sender = $("#sender").val();
    msgSendInfo.title =  typeof( $('#messageTitle').val() ) != "undefined" ? $('#messageTitle').val() : null;
    msgSendInfo.message = $("#message").val();
    msgSendInfo.reserveDate = $("#reserveDate").val();
//     msgSendInfo.emplClass = $("select[name=EMPL_CLASS]").val();
//     msgSendInfo.emplPositionName = $("select[name=EMPL_POSITION_NAME]").val();
    msgSendInfo.emplClass = "ALL";
    msgSendInfo.emplPositionName = "ALL";
}


//// 메세지 발송 정보
function getMsgSendInfo(){
	return {
		"uniqueKey" : null
		,"sender" : null
		,"sendType" : null
		,"title" : null
		,"mmsTitle" : null
		,"message" : null
		,"msgByte" : null
		,"sendCount" : null
		,"reserveDate" : null
		,"receivers" : null
		,"msgType" : null
		,"isAd" : null
		,"userAd" : null
		,"cusType" : null
		,"emplClass" : null
		,"emplPositionName" : null
	};	
}

//// 메세지 발송
	function msgSend(msgSendInfo){

	    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		msg = 	    		"msgSendInfo.uniqueKey =" + msgSendInfo.uniqueKey + "\n" +
								"msgSendInfo.sender =" + msgSendInfo.sender + "\n" +
								"msgSendInfo.sendType =" + msgSendInfo.sendType + "\n" +
								"msgSendInfo.title =" + msgSendInfo.title + "\n" +
								"msgSendInfo.mmsTitle =" + msgSendInfo.mmsTitle + "\n" +
								"msgSendInfo.message =" + msgSendInfo.message + "\n" +
								"msgSendInfo.msgByte =" + msgSendInfo.msgByte + "\n" +
								"msgSendInfo.sendCount =" + msgSendInfo.sendCount + "\n" +
								"msgSendInfo.reserveDate =" + msgSendInfo.reserveDate + "\n" +
								"msgSendInfo.receivers =" + msgSendInfo.receivers + "\n" +
								"msgSendInfo.msgType =" + msgSendInfo.msgType + "\n" +
								"msgSendInfo.isAd =" + msgSendInfo.isAd + "\n" +
								"msgSendInfo.userAd =" + msgSendInfo.userAd + "\n" +
								"msgSendInfo.cusType =" + msgSendInfo.cusType + "\n"+
								"msgSendInfo.emplClass =" + msgSendInfo.emplClass + "\n"+
								"msgSendInfo.emplPositionName =" + msgSendInfo.emplPositionName + "\n";
	    console.log(msgSendInfo);
	    
	    var type = $("input[name=sms_person]:checked").val();
	    
		$.ajax({
			  url: '${pageContext.request.contextPath}/eventsend/send/'+type,
			  type: "POST",
			  contentType: "application/json; charset=utf-8",
			  dataType: "json",
			  data : JSON.stringify(msgSendInfo),
			  success: function (data) {
				console.log(data);
				if(data == true)
				{
		 			showAlert("발송이 완료되었습니다.");
		 			//발송 데이터 초기화
		 			initSendInfo();
				}
			  }
		});
	};

//// 초기화
function initSendInfo(){
	messageClear(); // 메시지 초기화
	$("#sender").val(""); // 발신번호 초기화
	
	$("#sms-receiver #sms-send-list").children().remove(); // 수신번호 초기화
	addReceiverCount();//수신번호 총 갯수 초기화
}

//// sms 메세지저장       
  $("#btnMessageSave").click(function() {
    var msg = $("#message").val();
    if(msg.trim() == '') {
   		showAlert("저장할 메세지가 없습니다.");
    	return false;
    }
    showSaveMsg(msg);
    return false;//현재 사용자가 보고있는 위치 유지
  });
  
  
  
//// 메시지 새로쓰기
	$("#btnMessageClear").click(function() {
		showConfirmCancel("메시지를 새로 작성하시겠습니까?", messageClear, "메시지를 삭제하였습니다.");
		return false;//현재 사용자가 보고있는 위치 유지
	});
	
// });
//_READY END


//// 메세지저장 이벤트 처리 함수
function saveMsg(saveMsg_code, saveMsg_msg, saveMsg_title){
	saveMsgInfo = {
							"code" : saveMsg_code,
							"msg" : saveMsg_msg,
							"title" : saveMsg_title
						};

	$.ajax({
	    url: '${pageContext.request.contextPath}/form/'+saveMsg_code+'/save',
	    type: "POST",
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    data: JSON.stringify(saveMsgInfo),
	    success: function (result) {
// 			alert("저장 성공!");
			showAlert("메시지를 저장하였습니다.");
	    }
    });
}

var _byte = 0;
var alertMms = "SMS";
////메시지 Byte 체크
// addText (현재 문자 + inputText)
function messageByteCheck(addText){
	 if(addText != null)
	 {
		var messageArea = $("#message");
		messageArea.val(messageArea.val().substring(0, startPosition) + addText + messageArea.val().substring(endPosition, messageArea.val().length));
	 }
 	 _byte = checkByteTextarea($("#message"));//byte 계산

 	 if (_byte > 88) {
     } else {
   	 	alertMms = "SMS";
     } 

 	 $(".byte").empty();
 	 $(".byte").html(_byte+" byte <span>"+alertMms+"</span>");

 	 if(_byte > 88) {
  	    showAlert("메시지 내용은 88바이트 이상은 전송하실수 없습니다.");
		var idx = 0;
		for(var i=_byte; i > 88;idx++){
			$("#message").val($("#message").val().substr(0,(88-idx)));
			i = checkByteTextarea($("#message"));
		}
		messageByteCheck();
       	return false;
     }
}
  
//메시지 새로쓰기
function messageClear() {
		$("#messageTitle").val("");
	    $("#message").val("");
	    messageByteCheck();
}
 
//###############################수신번호 목록 @2#####################################################
$(document).ready(function () {
//// 받는사람 삭제
	$("#sms-receiver #btn-remove").click(function() {
  		var addrs = $("#sms-receiver input[name=addrchk]:checked");
	  	if (addrs.length > 0) {
	  		addrs.each(function(){
	  			$(this).parent().parent().parent().remove();
	  		});
	  		
	  		addReceiverCount();//수신번호 총 갯수 갱신
		} else {
			showAlert("선택된 연락처가 없습니다.");
		}
		return false;
	});
	  
//// 받는사람 전체삭제
	$("#sms-receiver #btn-removeAll").click(function() {
		var addrs = $("#sms-receiver input[name=addrchk]");
		if (addrs.length > 0) {
			$("#sms-receiver #sms-send-list").children().remove();
			addReceiverCount();//수신번호 총 갯수 갱신
		} else {
			showAlert("등록된 연락처가 없습니다.");
		}
		phoneNums = new Array();
		return false;
	});
});
// READY END
  
  
  
var checkIdx = 1;
//// 수신번호  추가
function addTarget(inputName, inputPhone) {
  var receiverNum = $("#receiverNum").val();
  var receiverName = "이름없음";
  
  if(inputName != null){receiverName = inputName;}
  if(inputPhone != null){receiverNum = inputPhone;}
  
  setTimeout(function() { 
    var phoneNumArr = new Array();
    $("#sms-send-list tr").each(function(index) {
      phoneNumArr[index] = $(this).find(".phone").text().trim();
    });
    
    var _val = receiverNum.replace(/\-/ig,"");
    
    for(var i = 0; i < phoneNumArr.length; i++) {
      if(phoneNumArr[i] == _val) {
        showAlert("중복되는 핸드폰번호가 있습니다.<br>확인해 주세요.");
        $(this).focus();
        return false;
      }
    } // end for
    
    var _val = receiverNum.replace(/\-/ig,"");
    $("#sms-send-list").append("<tr><td><div class='checkbox_default'><input type='checkbox' class='dt-check-box' name='addrchk' value='' checked='checked'/><label class='dt-check-box-label' for='addrchk'>"+receiverName+"</label></div></td><td class='phone'>"+_val+"</td></tr>");
    
    addReceiverCount();
    $("#sms-receiver #receiverNum").val("");
  }, 50);	
}

//받는 사람 카운터 갱신
function addReceiverCount() {
  var _count = $("#sms-receiver .sms-send-list").children().length;
  $("#sms-receiver .title span").text(_count);
}

//----------------------------- 수신번호 체크박스 이벤트 설정  ----------------------------------------------------------------
//// 전체 체크박스 클릭 이벤트 리스너
//// datatables 의 모든 셀렉트 박스가 선택 된다.
$('#sms-receiver #select-all').on('click', function () {
	var selectAllChecked = $('#sms-receiver #select-all').prop('checked');
	$("#sms-receiver .dt-check-box").each(function(){
		$(this).prop('checked', selectAllChecked);
	});
});

//// 삭제 버튼 클릭시 선택된 항목을 삭제 하는 이벤트 리스너
//// datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
//// $(document).on 을 사용
$(document).on('click', "#delete-btn", function () {
  var deleteTarget = [];
  ($(".dt-check-box").each(function () {
    if ($(this).prop('checked')) {
      deleteTarget.push($(this).val());
    }
  }));
  if (deleteTarget.length < 1) {
    showAlert("선택된 공지사항이 없습니다.")
  } else {
    var confirmMessage = "총 " + deleteTarget.length + "건 삭제 하시겠습니까?";
    showConfirmForAjax(confirmMessage, deleteNotice, deleteTarget);
  }
});


// 체크 박스 선택시 전체 선택 체크 박스의 체크 여부를 판단하는 이벤트 리스너
// datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
// $(document).on 을 사용
$(document).on('click', '#sms-receiver .dt-check-box-label', function () {
  // If checkbox is not checked
  var $_checkbox = $(this).siblings('input');
  if ($_checkbox.prop('checked')) {
    $_checkbox.prop('checked', false);
    $('#sms-receiver #select-all').prop("checked", false);
  } else {
    $_checkbox.prop('checked', true);
    var checkedCount = $("#sms-receiver .dt-check-box:checked").length;
    if (checkedCount == $("#sms-receiver .dt-check-box").length) {
      $('#sms-receiver #select-all').prop("checked", true);
    }
  }
});

//----------------------------- 수신번호 체크박스 이벤트 설정  End----------------------------------------------------------------

//############################### 수신인 검색/직급직위 선택 @3#####################################################
$(function() {
  	$("select[name=sms_bo_area]").change(function() {
	    $("input#send-code").val("");     
	    $(".send-area").attr("checked", true);
	    emplClass.removeAttr("disabled");         
	    emplPosition.removeAttr("disabled");
	});
  
////영업점 직원 input focus때 직급,직위 select box 비활성화 -------------------------------------------
	var emplClass = $("select[name=EMPL_CLASS]").val("default");
	var emplPosition = $("select[name=EMPL_POSITION_NAME]").val("default");
	var boArea = $("select[name=sms_bo_area]");
	
	$("#send-code").focus(function() {
	  $(".send-code").attr("checked", true);
	  boArea.val("default");
	  emplClass.val("default").attr("disabled", true);        
	  emplPosition.val("default").attr("disabled", true);      
	});
	
	$("input[name=sms_person]").click(function() {
	  emplClass.removeAttr("disabled");         
	  emplPosition.removeAttr("disabled");    
	});
	
	$(".send-code").click(function() {
	  boArea.val("default");  
	  emplClass.val("default").attr("disabled", true);        
	  emplPosition.val("default").attr("disabled", true);      
	});
////_영업점 직원 input focus때 직급,직위 select box 비활성화 -------------------------------------------

//// 직급 선택시
	$("select[name=EMPL_CLASS]").change(function() {
	  $("input#EMPL_CLASS").val($(this).val());	   
	});

//// 직위 선택시
	$("select[name=EMPL_POSITION_NAME]").change(function() {
	  $("input#EMPL_POSITION_NAME").val($(this).val());     
	});

//// 전직원에게 발송 선택시
	$(".send-all").click(function() {
	  if($(this).is(":checked")) {
	    boArea.val("default");
	    $("input#send-code").val("");
	    emplClass.val("default").attr("disabled", true);      
	    emplPosition.attr("disabled", true);      
	  } 
	});

//// 지역소속직원에게 발송 선택시
	$(".send-area").click(function() {
	  $("input#send-code").val("");     
	});

//// 지역소속 직원에게 발송 검색 이벤트
	$("#btn_search_area").click(function() {
	  var type = "area";
	  var smsBoArea = $("select[name=sms_bo_area]").val();
	  if(smsBoArea == 'default') {
	    showAlert("지역을 선택해 주세요.", function() { });
	    return false;
	  }
	  showSearch(type, smsBoArea);
	});


//// 영업점직원에게 발송 검색 이벤트
	$("#btn_search_shop").click(function() {
	  var type = "code";
	  var smsBoCode = $("input[name=sms_bo_code]").val().trim();    
	  if(smsBoCode == '') {
	    showAlert("영업점 코드를 입력해 주세요.", function() { });
	    return false;
	  }
	  showSearch(type, smsBoCode);
	});
});
//################################## 유틸 @0#########################################
$("#zoom-in-btn").on('click', function () {
  IbkZoom.zoomIn();
});

$("#zoom-out-btn").on('click', function () {
IbkZoom.zoomOut();
});


////전화번호 형식 입력 @jys
function inputPhoneType(obj){
  var inputVal = obj.val();
  obj.val(inputVal.replace(/[^0-9-]/gi,''));
};
</script>
