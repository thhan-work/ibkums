<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>파일 대량 보내기
</h3>
<!-- content -->
      <div id="content">
        <div class="box_info">
          <div class="title">「비대면 은행영업 가이드라인」에 의해 마케팅 목적의 문자발송이 불가합니다.</div>
          <div class="text1 mgt5">IBK메시지센터는 기존계약의 유지관리(여·수신 만기안내 등)를 목적으로 발송이 가능하며 <font color="red" ><B>고객관리(생일축하, 감성메시지 등)는 CRM시스템을 이용해 주시기 바랍니다. <span>(단, 마케팅 목적의 문자는 발송불가)</span></B></font></div>
          <div class="text2 mgt5">정보통신망법 이용촉진 및 정보보호 등에 관한 법률에 따라 "영리목적 광고성 정보" 수신 거부 고객에 대한 마케팅은 3천만원 이하의 과태료 부과 대상
           										  입니다. (관련문서 : 상품 안내장 전송(FAX, E-MAIL 등) 관련 유의사항 통보, 정보보호센터 2013.7.25)
          </div>
        </div>
		 <!-- table_view -->
        <div class="tbl_wrap_view mgt5">
          <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
            <caption>
            검색조건 테이블입니다.
            </caption>
            <colgroup>
            <col style="width:180px" />
            <col style="width:auto" />
            </colgroup>
            <tr>
              <th scope="row">발송종류 선택</th>
              <td><div class="row1">
                  <div class="radio_default">
                    <input type="radio" id="cusType_0" name="cusType" value="0"/>
                    <label for="cusType_0">기존계약 유지관리</label>
                  </div>
                  <div class="radio_default">
                    <input type="radio" id="cusType_1" name="cusType" value="1"/>
                    <label for="cusType_1">마케팅 및 고객관리</label>
                  </div>
                </div>
                <div class="row1 mgb5"><span>· 기존계약 유지관리</span> : 여·수신 만기 안내 등 고객이 안내 받지 못하면 불이익이 있는 경우 선택</div>
                <div class="row1"><span>· 마케팅 및 고객관리</span> : 상품/서비스 권유, 생일 축하메시지, 감성메세지 등(문자 발송 불가)</div></td>
            </tr>
          </table>
        </div>
        <!-- //table_view -->
         <!-- box_info -->
        <div class="box_info_blue mgt10">
          <div class="title">파일 불러오기, 셀 입력 및 편집 도움말</div>
					<ul class="text1 mgt10">
						<li>- 파일은 텍스트 파일과 CSV로 저장한 엑셀 파일이 가능합니다.</li>
						<li>- 파일형식은 콤마(,) 또는 엔터로 구분된 텍스트 형식이어야 합니다.</li>
						<li>- 한번에 보낼수 있는 최대 발송 건수는 1,000건 입니다.</li>
					</ul>
        </div>
        <!-- //box_info --> 
        <!-- table list -->
		<div class="mgt5">
        	<a href="javascript:;" class="btn_default fileopen" id="upload-btn">파일불러오기</a>
        	<a href="${pageContext.request.contextPath}/message/download/sample/bulk" class="btn_default download mgl6">샘플다운로드</a>
        	<a href="javascript:;" id="help-btn" class="btn_default question fr">도움말</a>
        </div>
        <div class="table_top" > 총 <span id="total_cnt">0</span>건
	        <span class="num"  id="per-page">
	            <select id="per-page" style="display:none;">
	                <option value="1000">1000</option>
	            </select>
	        </span>
    	</div>
    	
        <div class="tbl_wrap_list">
          <table class="tbl_list" id="message_upload_table" summary="파일 등록 테이블입니다.">
            <caption>파일 등록 테이블</caption>
            <colgroup>
	         	<col style="width:120px;" />
	            <col style="width:190px;" />
	            <col style="width:500px" />
	            <col style="width:50px" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col">휴대폰번호</th>
                <th scope="col">제목</th>
                <th scope="col">메시지</th>
                <th scope="col">발송타입</th>
              </tr>
            </thead>
          </table>
        </div>
        <!-- //table list --> 
	    <!-- Search -->
                <div class="box_send01 mgt10">
                	<ul>
                    	<li>
                        	<span class="title01">발신인 전화번호</span>
                            <span><input type="text" name="search" value="" id="sender" placeholder="숫자만 입력하세요" style="width:150px"></span>
                        </li>	
                      <li class="mgb6">
                            <span class="title01">예약발송 설정</span>
                            <span class="checkbox_default fn">
                              <input type="checkbox" id="reserveYN1" />
                              <label for="reserveYN1">예약발송</label>
                            </span>          
                            <span>
                            	<select class="small" name="year" disabled></select> 
                            </span>
                            <span class="text1">년</span>
                            <span>
                            	<select class="small" name="month" disabled></select> 
                            </span>
                            <span class="text1">월</span>
                            <span>
                            	<select class="small" name="date" disabled></select> 
                            </span>
                            <span class="text1">일</span>
                            <span>
                            	<select class="small" name="hour" disabled></select> 
                            </span>
                            <span class="text1">시</span>
                            <span>
                            	<select class="small" name="min" disabled></select> 
                            </span>
                            <span class="text1">분</span>
                        </li>
                        <li class="info">*발송 가능시간은 07:30~20:50까지 입니다.</li>
                    </ul>
                    <span class="btn"><a href="javascript:;" id="send-btn"><img src="${pageContext.request.contextPath}/static/images/btn_send_b.png" alt="보내기" /></a></span>
              	</div>
              	<!-- //Search -->
      </div>
      <!-- //content --> 
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="./upload-dialog.jsp" flush="true"/>
<jsp:include page="../help/address-help.jsp" flush="true"/>
<!-- ajax Loding 이미지 -->
<jsp:include page="../common/loading.jsp" flush="true"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/static/js/tabcontent.js"></script>        
<!-- Script -->
<!-- Datatables Column Definition-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datatable-column/massfile-upload-column.js"></script>
<script src="${pageContext.request.contextPath}/static/js/messageUtil.js"></script>
<script>
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
var year  = $("select[name=year]");
var month = $("select[name=month]");
var date  = $("select[name=date]");
var hour  = $("select[name=hour]");
var min   = $("select[name=min]");

var editor;
  $(document).ready(function () {
    enterKeyListener();
    initSetDate();
    // datatables 세팅 모든 파라미터는 필수값-- 맨 밑에 정의함
   		IbkDataTable.initDataTable("message_upload_table", IbkFileUploadColumn.columns, IbkFileUploadColumn.columnDefs);
   	 $("input[id='cusType_1']:radio").click(function(){
		 showAlert("마케팅 목적의 문자는 발송불가하며\n 고객관리(생일축하, 감성메시지 등)은 CRM시스템을 이용해주시기 바랍니다.");
		 //$("#cusType_0").prop("checked", true);
		 $("#cusType_1").prop("checked", false);

	});
  });

  $("#zoom-in-btn").on('click', function () {
    IbkZoom.zoomIn();
  });

  $("#zoom-out-btn").on('click', function () {
    IbkZoom.zoomOut();
  });

  //도움말 버튼 클릭 시 
  $("#help-btn").on('click', function() {
	  showHelpAlert_file_send();
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
//파일업로드 버튼 클릭시
  $("#upload-btn").on('click', function () {
	  var cusType = $("input[name=cusType]:checked").val();

	  if (cusType == null){
	  	showAlert("발송종류를 선택해주십시요.");
	  	return false;
	  }
	  showUploadPopUp(redirectList);
  });

  //보내기 버튼 클릭 시 --아래 작성
  $(document).on('click', "#send-btn", function () {
		var cusType = $("input[name=cusType]:checked").val();
		
		if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");

			return false;
		}  	  
		var rData =IbkDataTable.dataTable.data();
		var rowData = new Array();
	    if(rData.length == null|| rData.length<1){
	    	showAlert("파일 업로드를 진행해 주세요");
	    	return false;
	    }
	    for(var i=0;i<rData.length;i++){
	    	rowData.push(rData[i]);
	    }
	  
	    var sender = $("#sender").val();      
		if(sender.length < 8 ){
			showAlert("발신번호를 정확히 입력해 주세요.");
			return false;
		}
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})?[0-9]{3,4}?[0-9]{4}$/;               
	    if(!regExp.test(sender) && sender != '15882588') {
	      showAlert("발신번호를 정확히 입력해 주세요.");
	      return false;
	    }
	    
	    var reserve= $("#reserveYN1").prop("checked");
	    var _reservedTime="SYSDATE";
	    var confirmMessage="";
	    
	    var currentTime = getCurrentTime();
	    
	    if(reserve){
			var _reservedTime=getReservedTime();
		    // 예약발송 유효성 체크
		    var length = _reservedTime.length;
		    var time = _reservedTime.substring(length-4, length);

		    if(time < 730 || time > 2050) {
			      showAlert(" 예약발송 가능 시간을 확인해 주세요.");
			      return false;
		    }
		    if(_reservedTime < currentTime ) {
	    		showAlert("예약 시간을 확인해 주세요. <br>현재시간보다 이전에 예약설정 할 수 없습니다.");
	      		return false;
		    }
		    confirmMessage= "총 " + rowData.length + "건, "+year.val()+"년"+month.val()+"월"+date.val()+"일"+hour.val()+"시"+min.val()+"분 시간으로 예약 발송 요청 하시겠습니까?";
	    }else{
		    var length = currentTime.length;
		    var time = currentTime.substring(length-4, length);
		    if(time < 730 || time > 2050) {
			      showAlert("현재 시각 발송이 불가능 합니다. 예약발송을 이용해 주세요. ");
			      return false;
		    }
	    	confirmMessage = "총 " + rowData.length + "건 발송 요청 하시겠습니까?";
	    }
	    
	    var callback=sender;
	    var sendDate=_reservedTime;

	    var sendData=JSON.stringify({
	    					callback: callback,
	    					sendDate: sendDate,
	    					fileList: rowData
	    				},null,'\t');
		showConfirmForAjax(confirmMessage, fileSend, sendData);
	    
	  });

  function fileSend(target) {
	      $.ajax({
		      url: '${pageContext.request.contextPath}/message/filesendrequest',
		      type: 'POST',
	          contentType: "application/json; charset=utf-8",
	          dataType: "json",
	          data:  target,
		      success: function (data) {
					var completeMsg = "요청 되었습니다.";
					//예약 발송 시 
		            if($("#reserveYN1").prop("checked")) { completeMsg = "예약 되었습니다."; }
		            
//	             * Integer ALL_COUNT: (전송을 시도한)전체 메시지 수
//	             * Integer SEND_COUNT: 이통사로 전송한 메시지 수(성공건 아님)
//	             * Integer CUT_COUNT: (기업은행)차단 등록되어 실패한 메시지 수
//	             * Integer EXCEED_COUNT: (기업은행) 허용건수 초과로 실패한 메시지 수
//	             * Integer UNIT_DISCORD_COUNT: (기업은행)업무코드/영업점코드 오류 메시지 수
//	             * Integer ETC_COUNT: 그외 알 수 없는 오류
					var targetCnt = $("#sms-receiver .title span").text();
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

		 			if( (targetCnt - dupCount) > 0){
		 				msg = msg + "중복 " + (targetCnt - dupCount) + "건<br>";
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
					  
		 			msg = msg + "<br><br>* 업로드 파일의 중복 휴대폰번호는 제외된 건수 입니다."
			      showAlert(msg, redirectList);
			      
	        },
	        error: function (jqXHR, exception) {
	  	      showAlert("발송 요청이 실패하였습니다.", redirectList);
	        }
	      });

  }
  
  function redirectList() {
	    /* setTimeout(function () {
	      window.location.href = "${pageContext.request.contextPath}/filesend.ibk";
	    }, 100); */
  }
  
  function getCurrentTime(){
	    var now2   = new Date();
	    var year2  = now2.getFullYear() + "";
	    var month2 = (now2.getMonth() + 1) + "";
	    var date2  = now2.getDate() + "";
	    var hour2  = now2.getHours() + "";
	    var min2   = now2.getMinutes() + "";
	    var currentTime = 
	    	year2 + 
	    	((month2.length == 1)? "0" + month2 : month2) +
	    	((date2.length  == 1)? "0" + date2  : date2) +
	    	((hour2.length  == 1)? "0" + hour2  : hour2) +
	    	((min2.length   == 1)? "0" + min2   : min2);
	    return currentTime;
  }
  function getReservedTime(){
	    var reservedTime = 
	    	year.val() + 
	    	((month.val().length == 1)? "0" + month.val() : month.val()) + 
	    	((date.val().length  == 1)? "0" + date.val()  :  date.val()) + 
	    	((hour.val().length  == 1)? "0" + hour.val()  :  hour.val()) +
	    	((min.val().length   == 1)? "0" + min.val()   :  min.val());
	    return reservedTime;
  }
  var IbkDataTable = {
		  perPage: 1000,
		  currentPage: 1,
		  endPage: 0,
		  lastPage: 0,
		  startPage: 0,
		  dataTable: null,

		  initDataTable: function (targetId,columns, columnDefs) {
		    IbkDataTable.dataTable = $('#' + targetId).DataTable({
		          "processing":
		              true,
		          "dataSrc":
		              "data",
		          "bPaginate":
		              false,
		          "bFilter":
		              false,
		          "bInfo":
		              false,
	              "scrollY":
	            	  "200px",
		          "scrollCollapse": 
		        	  true,
		          "language":
		              {
		                'loadingRecords': '&nbsp;',
		                'processing': '처리 중입니다.',
		                "emptyTable":
		                    "<div style='height:40px;margin-top:25px'>파일 불러오기의 내용이 여기에 표시됩니다.</div>",
		              }
		          ,
		          'columns': columns,
		          'columnDefs': columnDefs,
		          select:
		              {
		                'style':
		                    'multi'
		              }
		      

		        }
		    )
		    ;
		// html append event trigger
		    $(document).on('click', '.page-btn', function () {
		      IbkDataTable.currentPage = $(this).text();
		      IbkDataTable.reload();
		    });

		    $(document).on('click', '#first-page', function () {
		      IbkDataTable.currentPage = 1;
		      IbkDataTable.reload();
		    });

		    $(document).on('click', '#pre-page', function () {
// 		      IbkDataTable.currentPage = IbkDataTable.startPage - 1;
		      IbkDataTable.currentPage = IbkDataTable.currentPage - 1;
		      if (IbkDataTable.currentPage < 1) {
		        IbkDataTable.currentPage = 1;
		      }
		      IbkDataTable.reload();
		    });

		    $(document).on('click', '#last-page', function () {
		      IbkDataTable.currentPage = IbkDataTable.lastPage;
		      IbkDataTable.reload();
		    });

		    $(document).on('click', '#next-page', function () {
// 		      IbkDataTable.currentPage = IbkDataTable.endPage + 1;
		      IbkDataTable.currentPage = IbkDataTable.currentPage + 1;
		      if (IbkDataTable.currentPage > IbkDataTable.lastPage) {
		        IbkDataTable.currentPage = IbkDataTable.lastPage;
		      }
		      IbkDataTable.reload();
		    });
		  },
		  reload: function () {
		    IbkDataTable.dataTable.ajax.reload();
		  }
		}
  
////현재시간으로 셋팅
  function initSetDate(){
  	  // 현재시간 설정.
  	  var now   = new Date();
  	  
  	  year.html(messageInitData.getYearOptionHtml(5, 0));
  	  month.html(messageInitData.getMonthOptionHtml());
  	  date.html(messageInitData.getDayOptionHtml(now.getFullYear(), (now.getMonth() + 1)));
  	  hour.html(messageInitData.getHourOptionHtml());
  	  min.html(messageInitData.getMinOptionHtml());

  	  var yearVal = now.getFullYear();
    	  var monthVal = (""+(now.getMonth() + 1)).length < 2 ? "0"+(now.getMonth() + 1) : (now.getMonth() + 1); //@bora timeString으로 변환함(""추가)
    	  var dateVal = now.getDate() < 10 ? "0"+now.getDate() : now.getDate();
    	  var hourVal = now.getHours() < 10 ? "0"+now.getHours() : now.getHours();
    	  var minVal = now.getMinutes() < 10 ? "0"+now.getMinutes() : now.getMinutes();

  	  year.val(yearVal);
  	  month.val(monthVal);
  	  date.val(dateVal);
  	  hour.val(hourVal);
  	  min.val(minVal);	
  	  
  	  year.change(function(){
  		  changeLastDay();
  	  });

  	  month.change(function(){
  		  changeLastDay();
  	  });
  }
  
  function changeLastDay(){
		// 선택 년,월의 마지막일 보정
		var monthLastDay = ( new Date( year.val(), month.val(), 0) ).getDate();
		var dateVal = $("select[name=date]").val();
		
		if(dateVal > monthLastDay){
			dateVal = '01';
		}
		
		date.empty();
		date.html(messageInitData.getDayOptionHtml(year.val(), month.val()));
		date.val(dateVal);
	}
  
	$("#reserveYN1").change(function() {
		var $_selects = $(this).parent().parent().children().find( "select" );
		if($("#reserveYN1").prop("checked")) { 
			$_selects.removeAttr("disabled");
		}else{
			$_selects.attr("disabled", true); 
		}
	});
	
////발신번호 숫자입력 체크 이벤트
	  $("#sender").on("keyup", function(){
		var cusType = $("input[name=cusType]:checked").val();
		
		if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");
			$("#sender").val("");
			return false;
		}  
	  	inputPhoneType($(this));
	  });
	  
	////전화번호 형식 입력 @jys
	  function inputPhoneType(obj){
	  	  var inputVal = obj.val();
	  	  obj.val(inputVal.replace(/[^0-9]/gi,''));
	  };
</script>
