<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap" id="popup_wrap" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title" id="popup_ack_title">등록</div>
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
            <th scope="row">승인자명<span class="th_must">*</span></th>
            <td>
                <input type="hidden" name="emplId" id="emplId">
                <input type="text" name="emplName" id="emplName" value="" placeholder="" style="width:120px"><a href="javascript:;" id="user-search-btn" class="btn_search mgl6">조회</a>
            <p class="mgt6">* 승인자명을 검색해주세요.</p></td>
          </tr>
          <tr>
            <th scope="row">직급<span class="th_must">*</span></th>
            <td><input type="text" name="emplPosition" id="emplPosition" value="" placeholder="" style="width:280px;background-color: lightgray;" readonly></td>
          </tr>
          <tr>
            <th scope="row">부서명<span class="th_must">*</span></th>
            <td>
            	<input type="text" name="partName" id="partName" value="" placeholder="" style="width:280px;background-color: lightgray;" readonly>
            	<input type="hidden" name="boCode" id="boCode" value="">
            </td>
          </tr>
          <tr>
            <th scope="row">결재선 차수 선택<span class="th_must">*</span></th>
            <td>
				<select class="small" id="userLevel">
	              <option value="2">2차</option>
	              <option value="3">3차</option>
	            </select>
            </td>
          </tr>
        </table>
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
<jsp:include page="../common/usersearch-list.jsp" flush="true"/>

<script>
	var popType = "등록";
	
    function registration_init(){
        popOpen("#popup_wrap");
        $("#emplName").focus();
    }

    function search_user(){
        userSearchInit($("#emplName").val());
    }

    // 검색 버튼 클릭 이벤트 리스너 등록
    $("#user-search-btn").on('click', search_user);

    // 엔터키 이벤트 리스너
    $("#emplName").keypress(function (event) {
        if (event.which == 13) {
            event.preventDefault();
            search_user();
        }
    });

    //중복 저장이 안되도록 기 등록자는 정보 변경
    $("#save_admin_btn").on('click', function(){
        if (!IbkValidation.validInputBox("emplId")) {
            showAlert("관리자명을 검색해 주세요", IbkValidation.setFocusById("emplName"));
            $("#alert-modal").parent().css({'z-index':10000000});
            return false;
        }else {
            $.ajax({
                url: '${pageContext.request.contextPath}/user/' + $("#emplId").val() +'/count',
                    type: 'GET',
                    success: function (result) {
                        var employeeInfo = getEmployeeInfo();
                       if(result === 1){
                            user_update(employeeInfo);
                       }else{
                    	   //console.log(employeeInfo);
                            user_registration(employeeInfo);
                       }
                }
            });
        }
    });

  function getEmployeeInfo() {
    return {
        "requestType" : "ack",
        
      	"emplId": $("#emplId").val(),
      	"userLevel": $("#userLevel :selected").val(),
      	"emplName": $("#emplName").val(),
      	"boCode": $("#boCode").val(),
      	"emplPosition": $("#emplPosition").val(),
      	"emplIp": null,
      	"useYn": "N",
        "adminYn": "N",
        "emplYn": "N"
    };
  }
  
  function setEmployeeInfo(result) {
	  popType = "수정";
	  
	  $("#popup_ack_title").text("수정");
	  $("#save_admin_btn").text("수정");
	  $(".th_must").hide();
	  $("#emplName").css('background-color','lightgray');
	  $("#emplName").prop('readonly', true);
	  $("#user-search-btn").hide();
	  $(".mgt6").hide();
	  
      $("#emplId").val(result.emplId);
      $("#emplName").val(result.emplName);
      $("#emplPosition").val(result.emplPosition);
      $('#partName').val(result.partName);
      $("#boCode").val(result.boCode);
      $("#userLevel").val(result.userLevel).prop("selected", true);
  }
  
  //초기화
  function initEmployeeInfo() {
	  popType = "등록";
	  
	  $("#popup_ack_title").text("등록");
	  $("#save_admin_btn").text("등록");
	  $(".th_must").show();
	  $("#emplName").css('background-color','#ffffff');
	  $("#emplName").prop('readonly', false);
	  $("#user-search-btn").show();
	  $(".mgt6").show();
	 
	  $("#emplId").val("");
	  $("#emplName").val("");
	  $("#emplPosition").val("");
	  $('#partName').val("");
	  $("#boCode").val("");
	  $("#userLevel").val('2').prop("selected", true);
  }

  function user_update(employeeInfo){
    $.ajax({
      url: '${pageContext.request.contextPath}/user/'+ $("#emplId").val(),
      type: "PUT",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(employeeInfo),
      success: function (result) {
        showAlert("정보 " + popType + "을 완료 되었습니다.");
        popClose('#popup_wrap');
        reload();
      }
    });
  }
  function user_registration(employeeInfo){
    $.ajax({
      url: '${pageContext.request.contextPath}/user',
      type: "POST",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(employeeInfo),
      success: function (result) {
   	    showAlert("정보 " + popType + "을 완료 되었습니다.");
        popClose('#popup_wrap');
        reload();
      }
    });
  }
</script>

