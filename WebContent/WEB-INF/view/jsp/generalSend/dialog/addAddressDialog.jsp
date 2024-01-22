<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/js/tabcontent.js"></script>
<!--popup-->
<div class="popup_wrap" id="address-modal" style="display: none;">
  <!-- top -->
  <div class="top">
    <div class="title">주소록에 등록하기</div>
    <div class="btn_close"><a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" id="btn_addaddress_close" alt="닫기" /></a></div>
  </div>
  <!-- //top --> 
  
  <!-- content -->
  <div class="content_pop"> 
    
    <!-- tap box -->
    <div class="wrap_tab mgt14">
      <ul class="tabs big" data-persist="true">
        <li><a href="#address_view_tab1" id="addExistGroup" class="big">기존 그룹에 등록</a></li>
        <li><a href="#address_view_tab2" id="addNewGroup" class="big" style="margin-left:-2px;">새 그룹에 등록</a></li>
      </ul>
      <div class="tabcontents big popup01">
        <!-- tab_기존 그룹에 등록 -->
        <div id="address_view_tab1">
        	<!-- table_view -->
          <div class="tbl_wrap_view mgt15">
            <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
              <caption>
              검색조건 테이블입니다.
              </caption>
              <colgroup>
              <col style="width:140px" />
              <col style="width:auto" />
              </colgroup>
              <tr>
                <th scope="row">그룹선택</th>
               	<td>
               		<select class="big" id="select_groupList" style="width:300px">
						<option>추가할 그룹을 선택하세요</option>
						<option>선택하세요</option>
						<option>선택하세요</option>
			    	</select>
			    </td>
              </tr>
            </table>
          </div>
          <!-- //table_view -->
        </div>
        <!-- //tab_기존 그룹에 등록 --> 
        <!-- tab_새 그룹에 등록 -->
        <div id="address_view_tab2">
        	<!-- table_view -->
          <div class="tbl_wrap_view mgt15">
            <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
              <caption>
              검색조건 테이블입니다.
              </caption>
              <colgroup>
              <col style="width:140px" />
              <col style="width:auto" />
              </colgroup>
              <tr>
                <th scope="row">공유여부</th>
                <td><div class="radio_default">
    <input type="radio" id="radio1" name="shareyn" checked="checked" value="0"/>
    <label for="radio1">공유안함</label>
  </div>
  <div class="radio_default">
    <input type="radio" id="radio2" name="shareyn" value="1" />
    <label for="radio2">공유</label>
  </div></td>
              </tr>
              <tr>
                <th scope="row">그룹명</th>
                <td><input type="text" name="search" id="groupname" value="" placeholder="그룹명 입력" style="width:280px" maxlength="64"></td>
              </tr>
              <tr>
                <th scope="row">그룹설명</th>
                <td><input type="text" name="search" id="groupnote" value="" placeholder="그룹설명 입력" style="width:280px" maxlength="64"></td>
              </tr>
            </table>
          </div>
          <!-- //table_view -->
        </div>
        <!-- //tab_새 그룹에 등록 --> 
        
      </div>
    </div>
    <!-- //tab box --> 

  </div>
  <!-- //content --> 
  
  <!-- footer -->
  <div class="footer_pop"> 
    <!-- button --><a href="javascript:;" class="btn_big blue" id="btn_addAddr_save">등록</a><a href="javascript:;" class="btn_big gray" id="btn_addAddr_cancel">취소</a><!-- //button --> 
  </div>
  <!-- //footer --> 
</div>
<!--//popup-->

<script>
var contactList;

function showAddAddress(inputContactList) {
	initUI(); // UI 초기화
	
	contactList = inputContactList; // 등록 연락처 리스트

	$("#btn_addaddress_close").off('click').on('click', function () {
       $("#address-modal").dialog("close");
   	});
	  
    $("#btn_addAddr_cancel").off('click').on('click', function () {
        $("#address-modal").dialog("close");
    });
    
    $("#address-modal").dialog({
        modal: true,
        width: "550px",
        open: function () {
          $(this).css('padding', '0px');
        },
      });
    
    // 등록 버튼 이벤트
    $("#btn_addAddr_save").off('click').on('click', function () {
    	var addType = $("#address-modal .tabs li.selected a").prop("id");

    	if(addType == "addExistGroup"){//기존 그룹에 추가
			var grpSeq = $("#address_view_tab1 option:selected").val();

    		// 그룹 등록 + 연락처 등록
   	        $.ajax({
	  	          url: '${pageContext.request.contextPath}/message/address/'+addType,
	  	          type: "POST",
	  	          contentType: "application/json; charset=utf-8",
	  	          dataType: "json",
	  	          data: JSON.stringify({
													"grpSeq" : grpSeq
											      	,"contactList" : contactList	
				  							    }),
	  	          success: function (result) {
	  	            showAlert("등록을 완료 하였습니다.");
	  	          	$(".tapAddress a:first").trigger("click"); //주소록 리스트 초기화
	  	          },
	              error: function (xhr,error,code) {
		              	var errorMsg = code.message == null ? "" : code.message;
		              	var errorCd = xhr.status == null ? "" : xhr.status;
		              	showAlert("요청 중 에러 발생, 에러 메시지=["+errorMsg+"], 에러코드=["+errorCd+"], 관리자에게 문의 바랍니다.");
           	  	  }	
   	        });
   	     	$("#address-modal").dialog("close");
    		
    	}else if(addType == "addNewGroup"){//신규 그룹에 추가
    		
			if (!IbkValidation.validInputBox("groupname")) {
   	          showAlert("그룹명을 입력 하세요", IbkValidation.setFocusById("groupname"));
   	          return false;
   	        }else{
   		  		_byte = checkByteTextarea($("#groupname"));//byte 계산
	  		 	if (_byte > 64) {
	  			   showAlert("그룹명은 최대 64Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)", IbkValidation.setFocusById("groupname"));
	  			   return false;
  		 	  	}
            }
    	
   	        if (!IbkValidation.validInputBox("groupnote")) {
   	            showAlert("그룹설명을 입력 하세요", IbkValidation.setFocusById("groupnote"));
   	            return false;
        	}else{
   		  		_byte = checkByteTextarea($("#groupnote"));//byte 계산
	  		 	if (_byte > 64) {
	  			   showAlert("그룹설명은 최대 64Byte까지 입력 가능합니다.<br>(입력값 : "+_byte+"Byte)", IbkValidation.setFocusById("groupnote"));
	  			   return false;
  		 	  	}
            }

   	        var groupInfo = getGroupInfo();
   	 		console.log(groupInfo);
   	 		// 그룹 등록 + 연락처 등록
   	        $.ajax({
	  	          url: '${pageContext.request.contextPath}/message/address/'+addType,
	  	          type: "POST",
	  	          contentType: "application/json; charset=utf-8",
	  	          dataType: "json",
	  	          data: JSON.stringify({
													"groupName": $("#groupname").val()
									  	       		,"groupNote": $("#groupnote").val()
									  	          	,"groupShareYn":$('input[name="shareyn"]:checked').val()
									  	          	,"contactList" : contactList
											  }),
	  	          success: function (result) {
	  	            showAlert("등록을 완료 하였습니다.");
	  	          	$(".tapAddress a:first").trigger("click"); //주소록 리스트 초기화
	  	          },
	              error: function (xhr,error,code) {
		              	var errorMsg = code.message == null ? "" : code.message;
		              	var errorCd = xhr.status == null ? "" : xhr.status;
		              	showAlert("요청 중 에러 발생, 에러 메시지=["+errorMsg+"], 에러코드=["+errorCd+"], 관리자에게 문의 바랍니다.");
           	      }	
   	        });
   	     	$("#address-modal").dialog("close");
    	}
    });
    
    $(".ui-dialog-titlebar").hide();
}

/* 그룹 추가 정보 얻기 시작  */  
function getGroupInfo() {
  return {
    "groupName": $("#groupname").val(),
    "groupNote": $("#groupnote").val(),
    "groupShareYn":$('input[name="shareyn"]:checked').val()
  };
}

//// UI 초기화
function initUI(){
	$("#groupname").val("");
	$("#groupnote").val("");
	
	initGroupList(); // 등록 가능 그룹 리스트 초기화
	$("#address_view_tab1 option:first").prop("selected","selected");
	
	
	// 	$("#address-modal .tabs li.selected").toggleClass("");
// 	$("#address-modal .tabs li:first").toggleClass("selected");
	$("#address-modal .tabs li:first").trigger("selected");
}
  
//// 등록가능 그룹 리스트 조회
function initGroupList(){
	$.ajax({
		url: '${pageContext.request.contextPath}/message/address/groupList',
		type: "POST",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		data: JSON.stringify({"addressType":"personal"}),
		success: function (result) {
    	  	console.log(result);
    	  	var html = "";
     	  	for(var i=0; i < result.length; i++){
				var groupData = result[i];
				html +=	 '<option value="'+groupData.grpSeq+'">'+groupData.groupName+'</option>'
     	  	}
     	  	
     	  	$("#address_view_tab1 #select_groupList").empty();
     	  	$("#address_view_tab1 #select_groupList").html(html);
		}
	});
};
</script>