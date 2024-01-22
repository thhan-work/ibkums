<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>내가 보낸메시지
</h3>
<!-- content -->
<div id="content">
    <div class="info">* 메시지 센터 내 발송한 메시지만 조회 가능합니다.</div>
    <!-- Search -->
    <div class="box_search01">
        <ul>
            <li><span class="title02">발송일</span>
            	<span><input type="text" name="search" value="" id="searchStartDt" readonly style="width:75px"></span>
            	<span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchStartDatePicker">
                </span>
                 <span class="mgl5 mgr5">~</span>
                 <span><input type="text" name="search" id="searchEndDt" readonly value="" style="width:75px"></span>
                 <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchEndDatePicker">
                 </span>
                 <span class="title02 mgl15">전송상태</span> <span>
                  <select id="searchSendStatus">
                    <option value="all" selected>전체</option>
                    <option value="success">정상</option>
                    <option value="wait">결과대기</option>
                    <option value="fail">실패</option>
                    <option value="refuse">수신거부</option>
                  </select>
                  </span>
                  <span class="title02 mgl15">휴대폰번호</span>
                  <span><input type="text" id="searchPhoneNum" name="search" value="" maxlength="11" placeholder="숫자만 입력" style="width:80px"></span>
            </li>
          </ul>
        <span class="btn3">
            <a href="javascript:;" id="search-btn" class="btn_search">조회</a>
        </span>
    </div>
    <!-- //Search -->

    <div class="table_top"> 총 <span id="total_cnt">0</span>건
        <span class="num">
            <select id="per-page">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="30">30</option>
            </select>
        </span>
    </div>

    <!-- table list -->
    <div class="tbl_wrap_list">
        <table class="tbl_list" id="mymessage_table" summary="내가 보낸 메시지 테이블 입니다.">
            <colgroup>
                <col style="width:70px;" />
	            <col style="width:" />
	            <col style="width:" />
	            <col style="width:" />
	            <col style="width:350px" />
	            <col style="width:" />
	            <col style="width:" />
	            <col style="width:" />
	            <col style="width:" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">
                    <div class="checkbox_center">
                        <input type="checkbox" id="select-all"/>
                        <label for="select-all"></label>
                    </div>
                </th>
                <th scope="col">메시지 유형</th>
                <th scope="col">수신자명</th>
                <th scope="col">휴대폰번호</th>
                <th scope="col">메시지 내용</th>
                <th scope="col">발송 일시</th>
                <th scope="col">전송상태</th>
                <th scope="col" style="display:none;">발신번호</th>
                <th scope="col" style="display:none;">제목</th>
            </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="6" style="height:375px">
                	<div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
                </td>
              </tr>
            </tbody>
        </table>
    </div>
    <!-- //table list -->
    <!-- 페이징 -->
    <div class="paging" id="pagination">
    </div>
    <!-- //페이징 -->
    <!-- 버튼 -->
    <div class="btn_wrap01_list">
        <a href="javascript:;" id="delete-btn" class="btn_big delete">삭제</a>
        <a href="javascript:;" id="resend-btn" class="btn_big blue">다시 보내기</a>
    </div>
    <!-- //버튼 -->
</div>
<!-- //content -->
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../mymessage/mymessage-dialog.jsp" flush="true"/>

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
<!-- common event handler on list pages  -->
<%-- <script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script> --%>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/mymessage-column.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/clipboard.js"></script>

<script>


  $(document).ready(function () {
    enterKeyListener();

    // 날짜 범위를 값을 세팅 해줌
	var initSearchStartDate = moment().startOf('months').format("YYYY-MM-DD");
	var initSearchEdnDate = moment().format("YYYY-MM-DD");
//     $("#searchStartDt").val(initSearchStartDate);
    $("#searchStartDt").val(initSearchStartDate);
    $("#searchEndDt").val(initSearchEdnDate);
    $("#searchStartDatePicker").val(initSearchStartDate);
    $("#searchEndDatePicker").val(initSearchEdnDate);
    
    // datepicker 세팅
    IbkDatepicker.Datepicker("searchStartDatePicker", "${pageContext.request.contextPath}");
    IbkDatepicker.Datepicker("searchEndDatePicker", "${pageContext.request.contextPath}",'', 0);
    // datatables ajax 에서 사용 할 parameter 세팅
    // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
    var requestParam = function (data) {
    // 필수 변경 불가
    data.perPage = IbkDataTable.perPage;
    // 필수 변경 불가
    data.currentPage = IbkDataTable.currentPage;
    // 여기서 부터는 Custom 하게
    data.searchStartDt = $("#searchStartDt").val().replace(/-/g, '');
    data.searchEndDt = $("#searchEndDt").val().replace(/-/g, '');
    data.searchSendStatus = $("#searchSendStatus").val();
    data.searchPhoneNumber = $("#searchPhoneNum").val();
    };
	
 	// datatables 세팅 모든 파라미터는 필수값
    IbkDataTable.initDataTable("mymessage_table", "./mymessage", requestParam,
        IbkMyMessageColumn.columns, IbkMyMessageColumn.columnDefs);
  });


  // 조회 버튼 클릭 이벤트 리스너
  $("#search-btn").on('click', function () {
//     if($("#searchPhoneNum").val() == '') {
//     	if(!IbkValidation.invalidSameDateScope("searchStartDatePicker", "searchEndDatePicker")){
//     	showAlert("핸드폰번호가 없는 경우, 하루만 조회 가능합니다.")
//     	return false;
//     	}
//     }
    if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
      // dialog jsp 가 include 되어 있어야 합니다.
      showAlert("검색 날짜 범위가 잘못 되었습니다.");
      return false;
    }
    if (IbkValidation.invalidSameYYYYMMScope("searchStartDatePicker", "searchEndDatePicker")) {
    	showAlert("동일 월만 조회 가능 합니다.");
        return false;
    }
    
    ///핸드폰번호 유효성 검사 
   if($("#searchPhoneNum").val().length < 10 && $("#searchPhoneNum").val().length > 1 ){
	    if($("#searchPhoneNum").val().substr(0,2) != '01'){
	    	showAlert("유효한 핸드폰번호가 아닙니다.");
	        return false;
	    }
    	showAlert("유효한 핸드폰번호가 아닙니다.(10자리 이상)");
        return false;
    } 
 
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
    
  });
  
  
  //삭제 버튼 클릭시 선택된 항목을 삭제 하는 이벤트 리스너
  // datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
  // $(document).on 을 사용
  $(document).on('click', "#delete-btn", function () {
	var count = 0;
	var deleteTarget = new Array();
	var checkbox = $("input[name=grpSeq-Ck]:checked");
	var data=null;
	checkbox.each(function(i) {
		 var  f=checkbox[i].parentNode.parentNode.parentNode;
	     data = IbkDataTable.dataTable.row(f).data();
	     deleteTarget.push(data);
	     count++;
	});
	
    if (deleteTarget.length < 1) {
      showAlert("선택된 항목이 없습니다.")
    } else {
      var confirmMessage = "총 " + deleteTarget.length + "건 삭제 하시겠습니까?";
      showConfirmForAjax(confirmMessage, deleteMyMessage, deleteTarget);
    }
  });
  
  
  //재전송 버튼 클릭 시 
  $(document).on('click', '#resend-btn', function() {
  	var cetSeq = "";
    var smsSeq = "";
    var mmsSeq = "";
    var count = null;
	var resendTarget = new Array();
	var checkbox = $("input[name=grpSeq-Ck]:checked");
	var data=null;
	checkbox.each(function(i) {
		 var  f=checkbox[i].parentNode.parentNode.parentNode;
	     data = IbkDataTable.dataTable.row(f).data();
	     cetSeq = data.id;
    	if(data.messageType == 'SMS'){
   		  smsSeq += this.value;
   		  smsSeq += ",";
   	    } else {
   		  mmsSeq += this.value;
   		  mmsSeq += ",";
    	} 
	     resendTarget.push(data);
	     count++;
	});
	
    if (resendTarget.length < 1) {
      showAlert("재전송 할 메시지가 선택되지 않았습니다.")
    } else {
      var resendMessage = "총 " + resendTarget.length + "건 재전송 하시겠습니까?";
      showResendForAjax(resendMessage, resendMyMessage, resendTarget);
      
    }
  })
  

  // 페이지당 조회 카운트 변경 이벤트 리스너
  $("#per-page").on('change', function () {
    IbkDataTable.perPage = $(this).val();
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
  });
  
  // 검색 시작일 datepikcer 값 변경 시
  // 검색 시작일 셀렉트 박스 날짜 값을 변경해 주는 이벤트 리스너
  $("#searchStartDatePicker").on('change', function(data){
	  var date = data.target.value;
	  IbkDatepicker.setDateSelectByDate("searchStartDt", date);
  });
  
   $("#searchEndDatePicker").on('change', function(data){
	  var date = data.target.value;
	  IbkDatepicker.setDateSelectByDate("searchEndDt", date);
  });
   
    //숫자만 
	$("#searchPhoneNum").keyup(function(event){
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^0-9]/gi,''));
	});
   
  // 전체 체크박스 클릭 이벤트 리스너
  // datatables 의 모든 셀렉트 박스가 선택 된다.
  $('#select-all').on('click', function () {
    // Get all rows with search applied
    var rows = IbkDataTable.dataTable.rows({'search': 'applied'}).nodes();
    // Check/uncheck checkboxes for all rows in the table
    $('input[type="checkbox"]', rows).prop('checked', this.checked);
  });

  
   $('#mymessage_table tbody tr td').css('cursor', 'pointer');
  
  //클릭 시 복사 이벤트
  $(document).on('click', '#msg_val', function (data) {
    var data = data.target.title;
    clipboard.writeText(data);
    // window.clipboardData.setData("Text", data);
    showAlert("보낸메시지 내용이 복사되었습니다.");
  });
  

  $("#zoom-in-btn").on('click', function () {
    IbkZoom.zoomIn();
  });

  $("#zoom-out-btn").on('click', function () {
    IbkZoom.zoomOut();
  });

  // enter ket 이벤트 리스너
  function enterKeyListener() {
    // enter key event
    $("#search-word").keypress(function (event) {
      if (event.which == 13) {
        event.preventDefault();
        $("#search-btn").trigger("click");
      }
    });
  }
  
  //byte 체크(메시지내용 짤라서 보여주기)
  function getBytes(strValue){
    var totalByte = 0;
    for (var i = 0; i < strValue.length; i++) {
	    if (encodeURI(strValue.charAt(i)).length === 9) {
	       totalByte += 2;
	    } else {
	       totalByte++;
	    }
    }
    return totalByte;
  }
  
  
  //byte 체크(max 짤라내기)
  function getBytesAndMaxLength(strValue, maxByte){
	    var totalByteAndMaxLength = {
	      totalByte: 0,
	      ableLength: 0
	    };
	    var totalByte=0;
	    var ableLength=0;
	    for (var i = 0; i < strValue.length; i++) {
	      if (encodeURI(strValue.charAt(i)).length === 9) {
	        totalByte += 2;
	      } else {
	        totalByte++;
	      }
	      // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
	      if (totalByte <= maxByte) {
	        ableLength = i + 1;
	      }
	    }
	    totalByteAndMaxLength.totalByte = totalByte;
	    totalByteAndMaxLength.ableLength = ableLength;
	    return totalByteAndMaxLength.ableLength;
	  }

  // 삭제 Ajax
  function deleteMyMessage(deleteTarget) {
    if (deleteTarget.length > 0) {
      $.ajax({
        url: '${pageContext.request.contextPath}/mymessage/delete',
        type: 'DELETE',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(deleteTarget),
        success: function (result) {
          showAlert("삭제 하였습니다.");
          IbkDataTable.reload();
        }
      });
    }
  }
  
  //재전송  Ajax
  function resendMyMessage(resendTarget){
	  if(resendTarget.length > 0) {
		  $.ajax({
			  url: '${pageContext.request.contextPath}/mymessage/resend',
			  type:'PUT',
			  contentType: 'application/json; charset=utf-8',
			  dataType : "json",
			  data: JSON.stringify(resendTarget), 
			  success:function(data){
					console.log(data);
					  
					var completeMsg = "요청 되었습니다.";
		            
//	             * Integer ALL_COUNT: (전송을 시도한)전체 메시지 수
//	             * Integer SEND_COUNT: 이통사로 전송한 메시지 수(성공건 아님)
//	             * Integer CUT_COUNT: (기업은행)차단 등록되어 실패한 메시지 수
//	             * Integer EXCEED_COUNT: (기업은행) 허용건수 초과로 실패한 메시지 수
//	             * Integer UNIT_DISCORD_COUNT: (기업은행)업무코드/영업점코드 오류 메시지 수
//	             * Integer ETC_COUNT: 그외 알 수 없는 오류
		            var allCount = data.ALL_COUNT;             
		            var dupCount = data.DUP_COUNT;
		 			var cutCount = data.CUT_COUNT;
		 			var sendCount = data.SEND_COUNT;
		 			var etcCount  = data.ETC_COUNT;
		 			var exceedCount = data.EXCEED_COUNT;
		 			var unitDiscordCount = data.UNIT_DISCORD_COUNT;

		 			var msg  = "";
		 			var flag = false;

		 			msg = msg + "전체 "+allCount+"건중<br>";

		 			if( (allCount - dupCount) > 0){
		 				msg = msg + "중복 " + (allCount - dupCount) + "건<br>";
		 				flag = true;
		 			}

		 			if(cutCount > 0){
		 				if(flag) {
		 					msg = msg + ","
		 				}
		 				msg = msg + "수신거부 " + cutCount + "건<br>";
		 				flag = true;
		 			}

		 			if(exceedCount > 0){
		 				if(flag) {
		 					msg = msg + ","
		 				}
		 				msg = msg + "허용 건수 초과 " + exceedCount + "건<br>";
		 				flag = true;
		 			}

		 			if(unitDiscordCount >0 ){
		 				if(flag) {
		 					msg = msg + ","
		 				}
		 				msg = msg + "미등록 오류 " + unitDiscordCount + "건<br>";
		 				flag = true;
		 			}

		 			if(etcCount >0 ){
		 				if(flag) {
		 					msg = msg + ","
		 				}
		 				msg = msg + " 기타 오류 " + etcCount + "건<br>";
		 				flag = true;
		 			}

		 			if(flag){
		 				msg = msg + "제외 하고<br/>";
		 			}

		 			msg = msg + sendCount+"건이 전송" + completeMsg;
					  
		 			showAlert(msg);
				  IbkDataTable.reload();
				  }
		  });
	  }
  }
  
  $(document).on('click', '.dt-check-box-label', function () {
	    // If checkbox is not checked
	    var $_checkbox = $(this).siblings('input');
	    if ($_checkbox.prop('checked')) {
	        $_checkbox.prop('checked', false);
	        $('#select-all').prop("checked", false);
	    } else {
	        $_checkbox.prop('checked', true);
	        var checkedCount = $(".dt-check-box:checked").length;
	        if (checkedCount === IbkDataTable.perPage) {
	            $('#select-all').prop("checked", true);
	        }
	    }
	});
 
  //datagridTrColorChanger("#mymessage_table");
  
</script>
