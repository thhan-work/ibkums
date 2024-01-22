<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- begin page-header -->
<div class="page-header">
	발송 현황
  	<ol class="breadcrumb pull-right"></ol>
</div>
<!-- end page-header -->

<!-- begin Search -->
<div class="row clearfix">
	<div class="search_area">
		<div class="search_field width-20">
			<label>발송명</label>
        	<div>
          		<input type="text" id="search-draft-name" name="" class="form-control" value="" placeholder="발송명을 입력하세요" />
        	</div>
      	</div>
      	<div class="search_field">
        	<label>메시지 유형</label>
        	<div>
          		<select id="msgType" class="mrg-right-7">
            		<option value="all">전체</option>
            		<option value="message">문자</option>
            		<option value="kakao">알림톡</option>
            		<option value="rcs">RCS</option>
          		</select>
          		<select id="msgTypeDetail" style="width:135px;" disabled>
          			<option value="all">전체</option>
          		</select>
        	</div>
      	</div>
      	<div class="search_field">
        	<label>상태</label>
        	<div>
          		<select id="draft-status" style="width:135px;">
            		<option value="all">전체</option>
            		<option value="C">작성중</option>
            		<option value="I">승인중</option>
            		<option value="Y">승인완료 / 발송대기</option>
            		<option value="S">발송중</option>
            		<option value="T">발송중지</option>
            		<option value="D">발송완료</option>
          		</select>
        	</div>
      	</div>
    </div>
    <div class="search_area">
    	<div class="search_field">
        	<label>등록일 / 발송일</label>
        	<div>
       			<select id="dateSelect">
	          		<option value="regDate">등록일</option>
	          		<option value="sendDate">발송일</option>
	        	</select>
      			<input type="text" class="form-control date-picker" id="searchDate" value="" />
        	</div>
      	</div>
      	<div class="search_field width150">
        	<label>부서</label>
        	<div id="partDiv">
        		<input type="text" id="partInput" name="" class="form-control" value="" style="display:none;" placeholder="부서를 입력하세요" disabled/>
        	</div>
      	</div>
      	<div class="search_field">
        	<label>등록자</label>
        	<div id="regDiv">
        		<input type="text" id="regInput" name="" class="form-control" value="" style="display:none;" placeholder="등록자를 입력하세요" disabled/>
        	</div>
      	</div>
      	<div class="search_field">
        	<button class="btn btn-reset btn-sm" id="resetBtn" onclick="searchReset();">초기화</button>
        	<button class="btn btn-search btn-sm" id="searchBtn">검색</button>
      	</div>
   	</div>
    <div class="pull-right">
      	<span class="search_msg">발송현황 조회는 3개월 전까지 가능합니다.</span>
    </div>
</div>
<!-- end Search  -->

<!-- begin table -->
<div class="row">
	<div class="table-result">
      	총 <strong class="split" id="sendStatus_table_total_cnt">100</strong>
   		<select class="search-limit" id="sendStatus_table_per_page">
      		<option value="10">10개씩 보기</option>
       		<option value="20">20개씩 보기</option>
       		<option value="30">30개씩 보기</option>
   		</select>
   	</div>
    <div class="table-responsive">
      	<table class="table table-hover table-cursor" id="sendStatus_table">
        	<colgroup>
	        	<col width="80" />
	        	<col width="300" />
	        	<col width="150" />
	        	<col width="150" />
	        	<col width="150" />
	        	<col width="150" />
	        	<col width="150" />
	        	<col width="150" />
	        	<col width="150" />
	        	<col width="150" />
        	</colgroup>
        	<thead>
	        	<tr>
         			<th>No.</th>
	          		<th>발송명</th>
	          		<th>메시지 유형</th>
	          		<th>부서</th>
	          		<th>등록자</th>
	          		<th>전체 건수</th>
	          		<th>등록일</th>
	          		<th>발송일</th>
	          		<th>상태</th>
	          		<th>버튼</th>
	        	</tr>
        	</thead>
        	<tbody>
        		<tr>
                	<td colspan="10">
                		<div class="nodata"><p>검색 결과가 없습니다.</p></div>
                	</td>
            	</tr>
        	</tbody>
   		</table>
	</div>
</div>
  
<!-- 발송현황 상세 팝업 -->
<div id="popupShipmentStatus" class="modalPopup hide position-top" style="width: 900px">
	<div class="modal-header">
		<h1>발송 현황 상세</h1>
	</div>
	<div class="modal-body">
    	<div class="row">
      		<h3 id="groupNm"></h3>
    	</div>
    	<!-- begin Tab -->
    	<div class="row">
      		<ul class="tabs-blue">
        		<li class="active"><a href="javascript:void(0);"  data-toggle="tab" data-id="basic">기본정보</a></li>
        		<li class=""><a href="javascript:void(0);"  data-toggle="tab" data-id="history">발송내역</a></li>
      		</ul>
    	</div>
    	<!-- end Tab -->
	
    	<!-- begin Table -->
    	<div class="row popup-tab-blue-content" id="tab-basic">
      		<div class="width-55 inline-block">
        		<div class="popupShipmentStatusScroll">
          			<table class="table table-view">
            			<colgroup>
              				<col width="30%" />
              				<col width="70%" />
            			</colgroup>
            			<tbody>
            				<tr>
              					<th>상태</th>
              					<td class="font-weight-bold" id="prcssStusDstic"></td>
            				</tr>
            				<tr>
              					<th>발송 구분</th>
              					<td id="sendType"></td>
            				</tr>
            				<tr>
              					<th>발송 대상</th>
              					<td id="inst"></td>
            				</tr>
            				<tr>
             			 		<th>부서</th>
              					<td id="partName"></td>
            				</tr>
            				<tr>
              					<th>등록자</th>
              					<td id="emplName"></td>
            				</tr>
            			</tbody>
          			</table>
          			<table class="table table-view mrg-top-20">
            			<colgroup>
              				<col width="30%" />
              				<col width="70%" />
            			</colgroup>
            			<tbody>
            				<tr>
              					<th>메시지 유형</th>
              					<td id="msgDstic"></td>
            				</tr>
            				<tr>
              					<th>발신번호</th>
           						<td id="sndrTelno"></td>
            				</tr>
            				<tr>
              					<th>SMS 수신동의 체크</th>
              					<td id="receiveAgreeCheckYn"></td>
            				</tr>
            				<tr>
              					<th>중복체크</th>
              					<td id="duplicateCheckYn"></td>
            				</tr>
            				<tr>
              					<th>전환발송 보내기</th>
              					<td id="altMsgDiv"></td>
            				</tr>
            			</tbody>
          			</table>
          			<table class="table table-view mrg-top-20">
            			<colgroup>
              				<col width="30%" />
              				<col width="70%" />
            			</colgroup>
            			<tbody>
            				<tr>
              					<th>발송 예약일시</th>
              					<td>
              						<span id="pengagYms"></span><br>
              						<span id="pengagYmsTotCount"></span>
              					</td>
            				</tr>
           					<tr>
              					<th>발송 시작일시</th>
              					<td>
              						<span id="sendStartYms"></span><br>
              						<span id="sendStartYmsTotCount"></span>
              					</td>
            				</tr>
            				<tr>
              					<th>발송 완료일시</th>
              					<td><span id="sendExpireYms"></span></td>
            				</tr>
            			</tbody>
          			</table>
          			<table class="table table-view mrg-top-20">
            			<colgroup>
              				<col width="30%" />
              				<col width="70%" />
            			</colgroup>
            			<tbody>
            				<tr>
              					<th>발송 전체 건수</th>
              					<td id="sendTotalCount">
              						<span id="requestsNumber"></span>
              					</td>
            				</tr>
            				<tr>
              					<th>발송 성공 건수</th>
              					<td>
              						<span id="successCountNumber"></span>
              					</td>
            				</tr>
            				<tr>
              					<th>발송 실패 건수</th>
              					<td>
              						<span id="errorCountNumber"></span>
              					</td>
            				</tr>
            			</tbody>
          			</table>
        		</div>
      		</div>
      		<jsp:include page="../template/preview.jsp" flush="true" />
		</div>
    	<div class="popup-tab-blue-content hide" id="tab-history">
      		<!-- begin Search -->
      		<div class="row">
        		<div class="search_area">
          			<div class="search_field">
            			<label>메시지 유형</label>
            			<div>
              				<select id="popMsgType" class="mrg-right-7">
           						<option value="all">전체</option>
	          					<option value="message">문자</option>
		          				<option value="kakao">알림톡</option>
		          				<option value="rcs">RCS</option>
              				</select>
              				<select id="popMsgTypeDetail" style="width:135px;" disabled>
		          				<option value="all">전체</option>
		        			</select>
            			</div>
          			</div>
          			<div class="search_field">
            			<label>수신번호</label>
            			<div>
              				<input type="text" id="tranPhone" name="tranPhone" class="form-control" value="" placeholder="수신번호를 입력하세요"/>
            			</div>
          			</div>
          			<div class="search_field">
            			<label>결과</label>
            			<div>
              				<select id="popResult">
	               				<option value="all">전체</option>
                				<option value="success">성공</option>
                				<option value="failure">실패</option>
              				</select>
            			</div>
          			</div>
          			<div class="search_field">
            			<button class="btn btn-reset btn-sm" id="popResetBtn" onclick="popSearchReset();">초기화</button>
            			<button class="btn btn-search btn-sm" id="popSearchBtn">검색</button>
          			</div>
        		</div>
      		</div>
      		<!-- end Search  -->

      		<!-- begin table -->
      		<div class="row">
        		<div class="table-result">
       				총 <strong class="split" id="sendHistory_table_total_cnt">0</strong>
          			<select class="search-limit" id="sendHistory_table_per_page">
            			<option value="10">10개씩 보기</option>
       					<option value="20">20개씩 보기</option>
       					<option value="30">30개씩 보기</option>
          			</select>
        		</div>
        		<div class="table-responsive">
          			<table class="table table-hover" id="sendHistory_table">
            			<colgroup>
              				<col width="60" />
              				<col width="140" />
              				<col width="140" />
              				<col width="130" />
              				<col width="100" />
              				<col width="140" />
              				<col width="80" />
              				<col width="80" />
            			</colgroup>
            			<thead>
            				<tr>
              					<th>No.</th>
              					<th>발송일시</th>
              					<th>수신일시</th>
              					<th>수신번호</th>
              					<th>발신번호</th>
              					<th>메시지 유형</th>
              					<th>이통사</th>
              					<th>결과</th>
            				</tr>
            			</thead>
            			<tbody>
            				<tr>
	                			<td colspan="8" style="height:375px">
	                				<div class="nodata"><p>검색 결과가 없습니다.</p></div>
	                			</td>
	            			</tr>
            			</tbody>
          			</table>
        		</div>
      		</div>
    	</div>
	   	<!-- end Table -->
  	</div>
  	<div class="modal-footer">
    	<a href="javascript:;" class="btn btn-border-sub1 popupShipmentStatus_close" >닫기</a>
  	</div>
</div>
<!-- //content -->
<script type="text/javascript"
       	src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatables-new.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatablesPopup-new.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/sendStatus-column.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/mmsSendHistory-column.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/smsSendHistory-column.js"></script>
<script type="text/javascript" 
		src="${pageContext.request.contextPath}/static/v2/js/smsReqCommon.js"></script>
<script type="text/javascript">
	var sendStatusGrid = IbkDataTableNew();			// 발송현황 dataTable 객체
	var smsSendHistoryGrid = IbkDataTablePopupNew();	// 발송현황상세 > 메시지유형이 'SMS'인 발송내역 dataTable 객체
	var mmsSendHistoryGrid = IbkDataTablePopupNew();	// 발송현황상세 > 메시지유형이 'SMS'이 아닌 발송내역 dataTable 객체
	var msgType = '';	// 발송현황 상세 호출시, 메시지 유형 값을 담기 위한 변수
	
	$(document).ready(function() {
		// 초기값 세팅
		init();

		// 팝업 메인 탭선택
		$(".tabs-blue a[data-toggle='tab']").click(function () {
			// 탭 활성화
			$(this).parents().closest('ul').last().find('li.active').removeClass('active')
		  	$(this).parent().addClass('active');
		  	$('.popup-tab-blue-content').hide();
		  	$('#tab-'+$(this).data('id')).show();
		});

		// 발송현황 상세 > 미리보기 초기값 세팅
		previewInit();
	});

	// 발송현황 상세 > 발송내역 목록보기버튼 이벤트
	$(document).on('click', '#sendHistory_table_reset', function () {
		// 발송내역 검색조건 값 초기화
		popSearchReset();

		// 발송내역 그리드 리로드
		historyGridReload();
	});

	$(document).on('change', '#sendHistory_table_per_page', function () {
		if(msgType == 'SM') {
			smsSendHistoryGrid.perPage = $(this).val();
			smsSendHistoryGrid.currentPage = 1;
			smsSendHistoryGrid.reload();
		} else {
			mmsSendHistoryGrid.perPage = $(this).val();
			mmsSendHistoryGrid.currentPage = 1;
			mmsSendHistoryGrid.reload();
		}
	});
	
	// 초기값 세팅
	function init() {
		roleInit();		// 권한별 메뉴 초기값 세팅
		dateInit();		// 날짜 초기값 세팅
	
		// datatables ajax 에서 사용 할 parameter 세팅
   		// 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
   		var sendStatusRequestParam = function (data) {
   			var searchDate = $("#searchDate").val();
			var dateArr = searchDate.split(" ~ ");
		
    		// 필수 변경 불가
    		data.perPage 			= sendStatusGrid.perPage;
    		// 필수 변경 불가
    		data.currentPage 		= sendStatusGrid.currentPage;
	    	// 여기서 부터는 Custom 하게
		    data.messageType 		= $("#msgType").val();
		    data.messageTypeDetail 	= $("#msgTypeDetail").val();
		    data.draftStatus 		= $("#draft-status").val();
		    data.draftName 			= $("#search-draft-name").val();
		    data.dateType 			= $("#dateSelect option:selected").val();
		    data.searchStartDt 		= str.replace(dateArr[0], "-", "");
	    	data.searchEndDt 		= str.replace(dateArr[1], "-", "");
			data.partNm				= $("#partInput").val();
			data.regNm				= $("#regInput").val();
		};

		// datatables 세팅 모든 파라미터는 필수값
		sendStatusGrid.initDataTable("sendStatus_table", "./smssendlist", sendStatusRequestParam,
				IbkSendStatusListColumn.columns, IbkSendStatusListColumn.columnDefs);
	}

	// 조회 버튼 클릭 이벤트
	$("#searchBtn").click(function () {
		// 기간 유효성 체크
		if(!searchDateValidate()) {
			return false;
		};
	
    	sendStatusGrid.currentPage = 1;
    	sendStatusGrid.reload();
	});

	// 메시지 유형 변경 이벤트
	$("#msgType").change(function() {
		var val = $(this).val();
		var html = '';

		$("#msgTypeDetail").empty();
	
		if(val == "message") {				// 메시지 유형이 '문자'일 때
			html += '<option value="all">전체</option>'
	            + '<option value="SM">SMS</option>'
	            + '<option value="LM">LMS</option>'
	            + '<option value="MM">MMS</option>';
	            
	    	$("#msgTypeDetail").html(html);
	    	$("#msgTypeDetail").attr("disabled", false);
		} else if(val == "kakao") {			// 메시지 유형이 '알림톡'일 때 
			html += '<option value="KM">전체</option>';
			
			$("#msgTypeDetail").html(html);
			$("#msgTypeDetail").attr("disabled", true);
		} else if(val == "rcs") {			// 메시지 유형이 'RCS'일 때
			html += '<option value="all">전체</option>'
	            + '<option value="SR">SMS</option>'
	            + '<option value="LR">LMS</option>'
	            + '<option value="MR">MMS</option>'
			$("#msgTypeDetail").html(html);
	    	$("#msgTypeDetail").attr("disabled", false);
		} else {
			html += '<option value="all">전체</option>';
			
			$("#msgTypeDetail").html(html);
			$("#msgTypeDetail").attr("disabled", true);
		}
	});

	// 발송현황 리스트 내 row 클릭 이벤트 (상세이동 및 등록하기 화면 이동)
	$('#sendStatus_table tbody').on('click', 'td', function() {
		var data = sendStatusGrid.dataTable.row($(this).parent()).data();

		msgType = data.msgDstic;
		
		if($(this).find('button').length > 0) {
			return false;
		}

		// 발송상태값 : C(작성중), A(결재진행중), B(발송승인대기)
		if(data.prcssStusDstic == 'C' 
				|| data.prcssStusDstic == 'A' || data.prcssStusDstic == 'B') {
			sweet.confirm("등록하기 이동 안내","작성중인 발송 내역입니다.<br> 등록하기로 이동하여 작성을 계속하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					location.href = '${pageContext.request.contextPath}/campaign/smsreq.ibk/'+ data.groupUniqNo + '?curStep=' + data.progressStep;
				} else {
					return false;
				}
			});
		} else if(data.prcssStusDstic == 'N') {		// N(반려)
			sweet.confirm("등록하기 이동 안내","반려된 발송 내역입니다.<br> 등록하기로 이동하여 작성을 계속하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					location.href = '${pageContext.request.contextPath}/campaign/smsreq.ibk/'+ data.groupUniqNo + '?curStep=5';
				} else {
					return false;
				}
			});
		} else {
			if(msgType == 'SM') {
				if(smsSendHistoryGrid.dataTable != null) {	// 메시지 유형이 'SMS'인 발송 data 재조회 시 리로드
					// 발송내역 검색조건 초기화 및 리로드
					popSearchReset();
					$("#sendHistory_table_per_page").val('10');
					smsSendHistoryGrid.perPage = 10;
					smsSendHistoryGrid.currentPage = 1;
					smsSendHistoryGrid.reload();	
					
					// 발송현황상세 > 기본정보 ajax 호출
					sendStatusDefInfAjax(data);
					$("#popupShipmentStatus").popup('show');
				} else {	// 메시지 유형이 'SMS'인 발송 data 첫 조회시 ajax 호출
					sendStatusDetailAjax(data);
					$("#popupShipmentStatus").popup('show');
				}	
			} else {
				if(mmsSendHistoryGrid.dataTable != null) {	// 메시지 유형이 'SMS'를 제외한 발송 data 재조회 시 리로드
					// 발송내역 검색조건 초기화 및 리로드
					popSearchReset();
					$("#sendHistory_table_per_page").val('10');
					mmsSendHistoryGrid.perPage = 10;
					mmsSendHistoryGrid.currentPage = 1;
					mmsSendHistoryGrid.reload();	
					
					// 발송현황상세 > 기본정보 ajax 호출
					sendStatusDefInfAjax(data);
					$("#popupShipmentStatus").popup('show');
				} else {	// 메시지 유형이 'SMS'를 제외한 발송 data 첫 조회시 ajax 호출
					sendStatusDetailAjax(data);
					$("#popupShipmentStatus").popup('show');
				}
			}
		}
	});

	// 발송 현황 리스트 내 버튼 클릭 이벤트
	$('#sendStatus_table tbody').on('click', 'button', function() {
		var data = sendStatusGrid.dataTable.row($(this).parent().parent()).data();

		if($(this).val() == 'delete') {
			sweet.confirm("삭제 안내","작성중인 메시지를 삭제하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					$.ajax({
					    type:'GET',
					    url:'${pageContext.request.contextPath}/campaign/deleteSendStatus/'+ data.groupUniqNo,
					    success: function (data) {
					        if(data.result == 'SUCCESS') {
					        	setTimeout(function() {
									sweet.alert('삭제되었습니다.');
				                }, 100);
					        	sendStatusGrid.currentPage = 1;
					           	sendStatusGrid.reload();
							} else {
								sweet.alert('삭제시 오류가 발생했습니다.');
								sendStatusGrid.currentPage = 1;
					            sendStatusGrid.reload();
							}
					    },error : function(e){
					    	sweet.alert('삭제시 오류가 발생했습니다.');
					    	sendStatusGrid.currentPage = 1;
				            sendStatusGrid.reload();
		                }
					});
				}
			});
		} else if($(this).val() == 'T') {	// T(발송중지)
			sweet.confirm("발송 변경 안내","현재 발송 진행중 입니다. 발송을 중지하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					data.prcssStusDstic = 'T';
					sendStatusUpdateAjax(data);
				} else {
					return false;
				}
			});
		} else if($(this).val() == 'E') {	// E(발송취소)
			sweet.confirm("발송 변경 안내","현재 발송 대기중 입니다. 발송을 취소하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					data.prcssStusDstic = 'E';
					sendStatusUpdateAjax(data);
				} else {
					return false;
				}
			});
		} else if($(this).val() == 'S') {	// S(발송중)
			sweet.confirm("발송 변경 안내","발송이 중지된 상태입니다. 발송을 다시 진행하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					data.prcssStusDstic = 'S';
					sendStatusUpdateAjax(data);
				} else {
					return false;
				}
			});
		} else if($(this).val() == 'disuse') {	// 폐기
			sweet.confirm("발송 내역 폐기 안내","발송 내역을 폐기하시겠습니까?", 'result', function(isConfirm) {
				if(isConfirm) {
					$.ajax({
					    type:'GET',
					    url:'${pageContext.request.contextPath}/campaign/deleteSendStatus/'+ data.groupUniqNo,
					    success: function (data) {
					        if(data.result == 'SUCCESS') {
					        	setTimeout(function() {
									sweet.alert('삭제되었습니다.');
				                }, 100);
					        	sendStatusGrid.currentPage = 1;
					           	sendStatusGrid.reload();
							} else {
								sweet.alert('삭제시 오류가 발생했습니다.');
								sendStatusGrid.currentPage = 1;
					            sendStatusGrid.reload();
							}
					    },error : function(e){
					    	sweet.alert('삭제시 오류가 발생했습니다.');
					    	sendStatusGrid.currentPage = 1;
				            sendStatusGrid.reload();
		                }
					});
				} else {
					return false;
				}
			});
		}

		// 검색 결과가 없을 때, 목록 보기 클릭 시 초기화 후 조회
		if($(this).attr('id') == 'sendStatus_table_reset') {
			searchReset();
	
			sendStatusGrid.currentPage = 1;
		    sendStatusGrid.reload();
		}
	});

	// 메시지 유형 변경 이벤트
	$("#popMsgType").change(function() {
		var val = $(this).val();
		var html = '';

		$("#popMsgTypeDetail").empty();
	
		if(val == "message") {				// 메시지 유형이 '문자'일 때
			html += '<option value="all">전체</option>'
	            + '<option value="SM">SMS</option>'
	            + '<option value="LM">LMS</option>'
	            + '<option value="MM">MMS</option>';
	            
	    	$("#popMsgTypeDetail").html(html);
	    	$("#popMsgTypeDetail").attr("disabled", false);
		} else if(val == "kakao") {			// 메시지 유형이 '알림톡'일 때 
			html += '<option value="KM">전체</option>';
			
			$("#popMsgTypeDetail").html(html);
			$("#popMsgTypeDetail").attr("disabled", true);
		} else if(val == "rcs") {			// 메시지 유형이 'RCS'일 때
			html += '<option value="all">전체</option>'
	            + '<option value="SR">SMS</option>'
	            + '<option value="LR">LMS</option>'
	            + '<option value="MR">MMS</option>'

			$("#popMsgTypeDetail").html(html);
	    	$("#popMsgTypeDetail").attr("disabled", false);
		} else {
			html += '<option value="all">전체</option>';
			
			$("#popMsgTypeDetail").html(html);
			$("#popMsgTypeDetail").attr("disabled", true);
		}
	});

	// 발송내역 조회 버튼 클릭 이벤트
	$("#popSearchBtn").click(function () {
		historyGridReload();
	});

	// 발송내역 메시지 타입별 그리드 리로드
	function historyGridReload() {
		if(msgType == 'SM') {
			smsSendHistoryGrid.currentPage = 1;
			smsSendHistoryGrid.reload();
		} else {
			mmsSendHistoryGrid.currentPage = 1;
			mmsSendHistoryGrid.reload();
		}
	};
	// 기간 유효성 체크
	function searchDateValidate() {
		var searchDate 	= $("#searchDate").val();
		var dateArr 	= searchDate.split(" ~ ");
		var startFmtDt 	= str.replace(dateArr[0], "-", "");
		var endFmtDt	= str.replace(dateArr[1], "-", "");
	
		var stYear 	= startFmtDt.substr(0,4);
		var stMonth = startFmtDt.substr(4,2)-1;
		var stDay 	= startFmtDt.substr(6,2);
		var stDate	= new Date(stYear, stMonth, stDay);
	
		var edYear 	= endFmtDt.substr(0,4);
		var edMonth = endFmtDt.substr(4,2)-1;
		var edDay 	= endFmtDt.substr(6,2);
		var edDate	= new Date(edYear, edMonth, edDay); 
	
		var rsltDate = (Date.parse(edDate)-Date.parse(stDate))/(1000*60*60*24);
		
		if(rsltDate > 90) { 
			sweet.alert('조회기간은 최대 3개월입니다.');
			dateInit();
	
			return false;
		}
		return true;
	}

	// 검색 초기화
	function searchReset() {
	   	$("#search-draft-name").val('');	// 발송명 초기화
	   	$("#msgType").val('all');			// 메시지 유형 초기화
	    $("#draft-status").val('all');		// 상태 초기화
	   	$("#dateSelect").val('regDate');	// 등록/발송일자 초기화
	
	   	// 메시지유형 상세 초기화
	   	$("#msgTypeDetail").children('option:not(:first)').remove();
	   	$("#msgTypeDetail").val('all');
	   	$("#msgTypeDetail").attr("disabled", true);
	
	   	$("#partInput").val('');
	   	$("#regInput").val('');
	
	   	// 초기값 세팅
	   	init();
	}

	// 주소록 : 그룹 해당 주소록 리스트 출력
	function getAddressList(obj){
		var objId = obj.prop("id");
		var url = "${pageContext.request.contextPath}/addressCall/" + objId +"/"+ "ddef";
		var regHtml = "";
		$.ajax({
			  url: url,
			  type: "GET",
			  contentType: "application/json; charset=utf-8",
			  dataType: "json",
			  success: function (result) {
				var regList = result;
	
				for(var i=0; i < regList.length; i++) {
					regHtml += '<option value="'+ regList[i].firstName +'">' + regList[i].firstName + '</option>';
				}
				
				$("#regSelect").append(regHtml);
			  }
		});
	}

	// 날짜 초기값 세팅
	function dateInit() {
		moment.locale('ko'); // 한글 셋팅
		var date = new Date();
		var firstDay = dateFunc.getLastWeek();
		var lastDay = dateFunc.getToday();
		$('.date-picker').daterangepicker({
			locale :{
				format: 'YYYY-MM-DD',
				separator: ' ~ ',
				applyLabel: "적용",
				cancelLabel: "닫기"
			},
			"startDate": firstDay,
			"endDate": lastDay,
		});
	}

	// 권한별 메뉴 초기값 세팅
	function roleInit() {
		var userLevel = '${headerInfo.userLevel}';
		var partName = '${headerInfo.partName}';
		var emplName = '${headerInfo.emplName}';
		var partHtml = '';
	
		//userLevel = 'N';	사용자
	
		// 관리자 일 때
		if(userLevel == 'A') {
			$("#partInput").attr("disabled", false); 
			$("#regInput").attr("disabled", false); 
	
			$("#partInput").show();
			$("#regInput").show();
		} else if(userLevel == 'N'){
			$("#partInput").val(partName);
			$("#regInput").val(emplName);
			$("#partInput").show();
			$("#regInput").show();
		}
	}

	//발송현황상세 > 기본정보 ajax
	function sendStatusDefInfAjax(rowData) {
		$.ajax({
		    type:'GET',
		    url:'${pageContext.request.contextPath}/campaign/smssendlist-detail.ibk/' + rowData.groupUniqNo,
		    contentType: "application/json; charset=utf-8",
		  	dataType: "json",
		    success: function (result) {
		        var smssendlist = result.smssendlist;						// 기본정보 data
				var prcssStusDstic = "";									// 발송상태
				var sendType = "";											// 발송구분
				var msgDsticTxt = "";										// 메시지 타입
				var groupUniqNo = smssendlist.groupUniqNo;					// 그룹고유번호	
	
		        var receiveAgreeCheckYn = smssendlist.receiveAgreeCheckYn;	// sms 수신동의 체크
	        	var duplicateCheckYn = smssendlist.duplicateCheckYn;		// 중복체크
		        var altMsgDiv = smssendlist.altMsgDiv;						// 전환발송 보내기
	
		        var requestsNumber = smssendlist.requestsNumber;			// 발송 전체 건수
		        var successCountNumber = smssendlist.successCountNumber;	// 발송 성공 건수
		        var errorCountNumber = smssendlist.errorCountNumber;		// 발송 실패 건수	

		    	// 팝업 메인 탭 active 초기화
				$(".tabs-blue a[data-toggle='tab']").parents().closest('ul').last().find('li.active').removeClass('active');
				$(".tabs-blue").children().first().addClass('active');
				$(".popup-tab-blue-content").hide();
				$("#tab-basic").show();
	
				// 기존 팝업 데이터 초기화 
				$("#smsMsgContent").html('');
				$("#mmsMsgTitle").html('');
				$("#mmsMsgContent").html('');
				$("#reSmsMsgContent").html('');
				$("#reMmsMsgTitle").html('');
				$("#reMmsMsgContent").html('');

				// 발송 완료가 아닐 경우
				if(smssendlist.sendExpireYms == null) {
					var noExpireYmsHtml = '<p>발송된 내역이 없습니다.<br>발송 완료 후 확인 가능합니다.</p>'
			
					$("#sendHistory_table").find(".table-no-search").empty();
					$("#sendHistory_table").find(".table-no-search").html(noExpireYmsHtml);
				}
				
				// 상태값 세팅
		        if(smssendlist.prcssStusDstic == 'C') {
		        	prcssStusDstic = '작성중';
			    } else if(smssendlist.prcssStusDstic == 'B') {
		        	prcssStusDstic = '발송승인대기';
				} else if(smssendlist.prcssStusDstic == 'A') {
		        	prcssStusDstic = '결재진행중';
				} else if(smssendlist.prcssStusDstic == 'I') {
		        	prcssStusDstic = '승인중';
				} else if(smssendlist.prcssStusDstic == 'N') {
		        	prcssStusDstic = '반려';
				} else if(smssendlist.prcssStusDstic == 'Y') {
		        	prcssStusDstic = '발송대기';
				} else if(smssendlist.prcssStusDstic == 'D') {
		        	prcssStusDstic = '발송완료';
				} else if(smssendlist.prcssStusDstic == 'S') {
		        	prcssStusDstic = '발송중';
				} else if(smssendlist.prcssStusDstic == 'T') {
		        	prcssStusDstic = '발송중지';
				} else if(smssendlist.prcssStusDstic == 'R') {
		        	prcssStusDstic = '발송준비중';
				} else if(smssendlist.prcssStusDstic == 'P') {
		        	prcssStusDstic = '시간경과(관리자문의)';
				} else if(smssendlist.prcssStusDstic == 'E') {
		        	prcssStusDstic = '발송취소';
				}
	
		        // 발송 구분값 세팅
		        if(smssendlist.sendType == "marketing") {
		        	sendType = "마케팅(고객관리 포함)";
			    } else if(smssendlist.sendType == "noMarketing") {
		        	sendType = "비마케팅(기존계약의 유지 · 관리 등)";
				}
				
		        // 메시지 타입 세팅
		        if(smssendlist.msgDstic == 'SM') {
		        	msgDsticTxt = 'SMS';
		        	$("#smsMsgContent").html(smssendlist.msgCtnt);
	
		        	$(".smsBasicSend").show();
					$(".mmsBasicSend").hide();
				} else if(smssendlist.msgDstic == 'LM') {
					msgDsticTxt = 'LMS';
		        	$("#mmsMsgTitle").html(smssendlist.msgCtnt);
		        	$("#mmsMsgContent").html(smssendlist.umsMsgCtnt);
	
		        	$(".smsBasicSend").hide();
					$(".mmsBasicSend").show();
				} else if(smssendlist.msgDstic == 'MM') {
					msgDsticTxt = 'MMS';
		        	$("#mmsMsgTitle").html(smssendlist.msgCtnt);
		        	$("#mmsMsgContent").html(smssendlist.umsMsgCtnt);
	
		        	$(".smsBasicSend").hide();
					$(".mmsBasicSend").show();
				} else if(smssendlist.msgDstic == 'KM') {
					msgDsticTxt = '알림톡';
		        	$("#mmsMsgTitle").html(smssendlist.msgCtnt);
		        	$("#mmsMsgContent").html(smssendlist.umsMsgCtnt);
	
		        	$(".smsBasicSend").hide();
					$(".mmsBasicSend").show();
				} else if(smssendlist.msgDstic == 'SR') {
					msgDsticTxt = 'RCS-SMS';
		        	$("#smsMsgContent").html(smssendlist.msgCtnt);
	
		        	$(".smsBasicSend").show();
					$(".mmsBasicSend").hide();
				} else if(smssendlist.msgDstic == 'LR') {
		        	msgDstic = 'RCS-LMS';
		        	$("#mmsMsgTitle").html(smssendlist.msgCtnt);
		        	$("#mmsMsgContent").html(smssendlist.umsMsgCtnt);
	
		        	$(".smsBasicSend").hide();
					$(".mmsBasicSend").show();
				} else if(smssendlist.msgDstic == 'MR') {
					msgDsticTxt = 'RCS-MMS';
		        	$("#mmsMsgTitle").html(smssendlist.msgCtnt);
		        	$("#mmsMsgContent").html(smssendlist.umsMsgCtnt);
	
		        	$(".smsBasicSend").hide();
					$(".mmsBasicSend").show();
				}
		        
		        // 발송 희망일 저장된 시간 값 세팅
		        selectDateSaveCount(groupUniqNo, smssendlist.prcssStusDstic);
	
		        // sms 수신동의 체크
		        if(receiveAgreeCheckYn == 'Y') {
		        	receiveAgreeCheckYn = '수신동의자만 전송';
			    } else {
		        	receiveAgreeCheckYn = '전체 전송';
				}
	
		        // 중복체크
		        if(duplicateCheckYn == 'Y') {
		        	duplicateCheckYn = '중복 제거';
			    } else {
			    	duplicateCheckYn = '중복 허용';
				}
	
		        // 전환발송 보내기
		        if(altMsgDiv == 'ZZ') {
		        	altMsgDiv = '미사용';
		        	
		        	$("#reSmsMsgContent").html("전환발송 미사용 중입니다.");
		        	$(".smsBasicTrans").show();
					$(".mmsBasicTrans").hide();
			    } else {
			    	altMsgDiv = '사용';
			    	
			    	if(smssendlist.msgDstic == 'SM' || smssendlist.msgDstic == 'SR') {
			        	$("#reSmsMsgContent").html(smssendlist.altMsgText);
	
			        	$(".smsBasicTrans").show();
						$(".mmsBasicTrans").hide();
					} else {
						$("#reMmsMsgTitle").html(smssendlist.altMsgTitle);
						$("#reMmsMsgContent").html(smssendlist.altMsgText);
	
			        	$(".smsBasicTrans").hide();
						$(".mmsBasicTrans").show();
					}
			    	
				}
	
		        // 발송상태 구분	 (D:발송완료)
		        if(smssendlist.prcssStusDstic == 'D') {
		        	$("#successCountNumber").html(isEmptyFmtData(successCountNumber, "successCountNumber"));
		        	$("#errorCountNumber").html(isEmptyFmtData(errorCountNumber, "errorCountNumber"));
	
		        	// 발송 완료일시 값 세팅
			        var sendExpireYms = smssendlist.sendExpireYms;
		            var fmtSendExpireYms = "";
		            
			        if(!str.isEmpty(sendExpireYms)) {
				        var YYYY = sendExpireYms.substr(0,4);
			            var mm = sendExpireYms.substr(4,2);
			            var dd = sendExpireYms.substr(6,2);
			            var hh = sendExpireYms.substr(8,2);
			            var mi = sendExpireYms.substr(10,2);
			            fmtSendExpireYms = YYYY + "-" + mm + "-" + dd + " " + hh + ":" + mi;
					}
	
			        isEmptyFmtData(fmtSendExpireYms, "sendExpireYms");
			    } else {
			    	$("#sendStartYms").html("-");
		        	$("#sendExpireYms").html("-");
		        	$("#successCountNumber").html("-");
		        	$("#errorCountNumber").html("-");
				}
	
				// 상세 값 셋팅
		        isEmptyFmtData(prcssStusDstic, "prcssStusDstic");			// 발송상태
		        isEmptyFmtData(sendType, "sendType");						// 발송 구분
				isEmptyFmtData(smssendlist.inst, "inst");					// 발송 대상값
				isEmptyFmtData(smssendlist.groupNm, "groupNm");				// 발송명
				isEmptyFmtData(rowData.partName, "partName");				// 부서
				isEmptyFmtData(rowData.emplName, "emplName");				// 등록자
		        isEmptyFmtData(msgDsticTxt, "msgDstic");					// 메시지 타입
		        isEmptyFmtData(smssendlist.sndrTelno, "sndrTelno");			// 발신번호
		        isEmptyFmtData(receiveAgreeCheckYn, "receiveAgreeCheckYn");	// SMS 수신동의 체크
		        isEmptyFmtData(duplicateCheckYn, "duplicateCheckYn");		// 중복체크
		        isEmptyFmtData(altMsgDiv, "altMsgDiv");						// 전환발송 보내기
		        isEmptyFmtData(requestsNumber, "requestsNumber");			// 발송 전체 건수
	
		        // 미리보기 값 셋팅
		        setPreviewStatus(smssendlist, msgDsticTxt);	
		    }
		});
	}

	// 발송현황상세 > 발송내역 ajax
	function sendStatusHistoryAjax(rowData) {
		var sendHistoryRequestParam = function (data) {
			if(msgType == 'SM') {
				// 필수 변경 불가
		    	data.perPage = smsSendHistoryGrid.perPage || 10;
		    	// 필수 변경 불가
		    	data.currentPage = smsSendHistoryGrid.currentPage;
			} else {
				// 필수 변경 불가
		    	data.perPage = mmsSendHistoryGrid.perPage || 10;
		    	// 필수 변경 불가
		    	data.currentPage = mmsSendHistoryGrid.currentPage;
			}
	    	
		    // 여기서 부터는 Custom 하게
		    data.messageType 		= $("#popMsgType").val();
		    data.messageTypeDetail 	= $("#popMsgTypeDetail").val();
		    data.groupUniqNo 		= rowData.groupUniqNo;
		    data.rowMsgDstic 		= rowData.msgDstic;
		    data.result 			= $("#popResult").val();
		    data.tranPhone			= $("#tranPhone").val();
		};

		
	    // 발송내역 리스트 세팅
		if(rowData.msgDstic == 'SM') {
			smsSendHistoryGrid.initDataTable("sendHistory_table", "./sendHistoryList", sendHistoryRequestParam,
					IbkSmsSendHistoryListColumn.columns, IbkSmsSendHistoryListColumn.columnDefs);
		} else {
			mmsSendHistoryGrid.initDataTable("sendHistory_table", "./sendHistoryList", sendHistoryRequestParam,
				IbkMmsSendHistoryListColumn.columns, IbkMmsSendHistoryListColumn.columnDefs);
		}
	}

	// 발송현황 상세 팝업 호출
	function sendStatusDetailAjax(rowData) {
	    // 상세 > 기본정보 ajax 호출
		sendStatusDefInfAjax(rowData);
		// 상세 > 발송내역 ajax 호출
		sendStatusHistoryAjax(rowData);
	}

	// 미리보기 초기값 세팅
	function previewInit() {
		$("#previewDiv").attr("style", "margin-top: 0px !important");
		$("#previewDiv .div-msg-preview-body").css("height", "522");
	}

	//미리보기 값 셋팅
	function setPreviewStatus(obj, msgDsticTxt) {
		var msgDstic = obj.msgDstic;
		var chnlType = msgDstic == "KM" ? "K" : msgDstic.substring(1,2);
	
		// 공통값 셋팅
		$(".msgDsticTxt").text(msgDsticTxt);
		previewFunc.preivewShowChoice(0);
	
		// 초기화
		$("#previewBody .template-richcard-mediaview").remove();
		$("#transBody .template-richcard-mediaview").remove();
		previewFunc.setPreviewBtnInit("previewEtc");
		$("#isTransMsg").hide();
		$("input[name=previewMsgDsticTxt][value=P]").prop("checked", true).change();
		
		// 슬림 스크롤 제거
		if($("#previewEtc .slimScrollDiv").length > 0) {
			destroySlimscroll($("#previewBody").parent());	
		}
		if($("#transDiv .slimScrollDiv").length > 0) {
			destroySlimscroll($("#transBody").parent());	
		}
		
		// 메시지유형별 값 셋팅
		if("M" == chnlType) {
			setPreviewSms(obj, msgDstic);
		} else if("K" == chnlType) {
			setPreviewTalk(obj);
		} else {
			setPreviewRcs(obj, msgDstic);
		}
	}

	//문자 미리보기 셋팅
	function setPreviewSms(obj, msgDstic) {
		cmmnPreviewCntnt(obj, msgDstic);
	
		// 전환발송 이미지 셋팅
		if("MM" == msgDstic) {
			cmmnPreviewImg(obj, "previewBody");
		}
	}

	// 알림톡 미리보기 셋팅
	function setPreviewTalk(obj) {
		previewFunc.setTalkPreview(obj);
	
		// 전환발송 미리보기 셋팅
		cmmnPreviewTrans(obj);
	}

	// rcs 미리보기 셋팅
	function setPreviewRcs(obj, msgDstic) {
		var msgCtnt = obj.msgCtnt || "";
		var umsMsgCtnt = obj.umsMsgCtnt || "";
		var serviceType = previewFunc.findKeyValue(previewFunc.converJsonObject(obj.channelMsgText), "serviceType");              // 서비스타입
		var buttonArr = previewFunc.converJsonObject(obj.channelButtonText);
		var extraTitle = previewFunc.findKeyValue(previewFunc.converJsonObject(obj.channelMsgText), "extraTitle");               // 카드제목배열
		var extraDescription = previewFunc.findKeyValue(previewFunc.converJsonObject(obj.channelMsgText), "extraDescription");   // 카드내용배열
		var slideCount = previewFunc.findKeyValue(previewFunc.converJsonObject(obj.channelOptionText), "slideCount") || 0;       // 슬라이드개수 추가
		var imgSeqArr = previewFunc.findKeyValue(previewFunc.converJsonObject(obj.channelOptionText), "imgSeqs");               // 이미지시퀀스목록
	
		// 제목, 내용 셋팅
		if("CM" == serviceType) {
			// 
			previewFunc.sliderInit();
			
			// 미리보기 Carousel용 show
			previewFunc.preivewShowChoice(1);
	
			// 미리보기 Carousel 슬라이더 생성
			previewFunc.dynamicPreviewSlider(slideCount);
			
			// 제목, 내용 셋팅
			for(var idx = 0; idx < slideCount; idx++) {
				if(idx == 0) {
					previewFunc.setPreviewSlideTitle(0, msgCtnt);
					previewFunc.setPreviewSlideContents(0, umsMsgCtnt);
				} else {
					previewFunc.setPreviewSlideTitle(idx, extraTitle[idx-1]);
					previewFunc.setPreviewSlideContents(idx, extraDescription[idx-1]);
				}
			}
		} else {
			cmmnPreviewCntnt(obj, msgDstic);
		}
	
		// 버튼정보 셋팅
		var _this = this;
		if(buttonArr != null && buttonArr.length > 0) {
			buttonArr.forEach(function(item, sIdx) {
				if(item.hasOwnProperty('suggestions')) {
					var actionArr = item.suggestions;
					var actionLen = actionArr.length;
	
					// 버튼 액션 셋팅
					actionArr.forEach(function(item, btnIdx) {
						var btnNm = item.displayText;
						if("CM" == serviceType) {
							previewFunc.setPreviewSlideBtn(sIdx, btnIdx, btnNm);
						} else {
							previewFunc.setPreviewBtn("previewEtc", btnIdx, btnNm);	
						}
					})
				}
			})
		}
		
		// 이미지값 셋팅
		if("MR" == msgDstic) {
			cmmnPreviewRcsImg(imgSeqArr, serviceType);
		}
		
		// 전환발송 미리보기 셋팅
		cmmnPreviewTrans(obj);
	
		// 전환발송 이미지 셋팅
		var altMsgDiv = obj.altMsgDiv;
		if("MM" == altMsgDiv) {
			cmmnPreviewImg(obj, "transBody");
		}
	}

	// 미리보기 - 공통 제목, 내용 셋팅
	function cmmnPreviewCntnt(obj, msgDstic) {
		var umsMsgCtnt = obj.umsMsgCtnt || "";
		if(msgDstic.startsWith("S")) {
			umsMsgCtnt = obj.msgCtnt || "";	
		} else {
			var msgCtnt = obj.msgCtnt || "";
			previewFunc.setPreviewTitle(msgCtnt);	
		}
		previewFunc.setPreviewContents(umsMsgCtnt);
	}

	//미리보기 - 공통 이미지 셋팅
	function cmmnPreviewImg(obj, tgtId) {
		for(var i = 1; i <= obj.imageCount; i++) {
			var numIdx = i - 1;
			previewFunc.setPreviewImg(tgtId, numIdx, obj["seq" + i]);
		}
	
		var imageLen = $("#" + tgtId + " .template-richcard-mediaview").length;
		var parentTgtId  = "previewBody" == tgtId ? "previewEtc" : "transDiv";
		if(imageLen > 1) generateSlimScroll('#' + parentTgtId + ' .emulator_cont', { height: '450px', size: '3px'});
	}

	//미리보기 - RCS 이미지 셋팅
	function cmmnPreviewRcsImg(imgSeqArr, serviceType) {
		if(imgSeqArr != null && imgSeqArr!= "[]") {
			imgSeqArr.forEach(function(seq, idx) {
				if(!str.isEmpty(seq)) {
					if("CM" == serviceType) {
						previewFunc.setPreviewCarouselImg(idx, seq);
					} else {
						previewFunc.setPreviewImg("previewBody", idx, seq, "500");
					}
					
				}
			})
		}
	}

	//미리보기 - 공통 전환발송 셋팅
	function cmmnPreviewTrans(obj) {
		$("#isTransMsg").hide();
		if("ZZ" != obj.altMsgDiv) {
			$("#isTransMsg").show();
		}
		
		previewFunc.setPreviewTransTitle(obj.altMsgTitle);
		previewFunc.setPreviewTransContents(obj.altMsgText);
	}

	//발송 예약일, 발송시작일 조회
	function selectDateSaveCount(groupUniqNo, prcssStusDstic){
	    $.ajax({
	        url: '${pageContext.request.contextPath}/campaign/savecnt2/',
	        type: "POST",
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify({
	            "groupUniqNo": groupUniqNo})
	    }).done(function(data){
	        var tot = 0;
	        var index = 0;
	        var pengagHtml = "";
	        var startDsticHtml = "";
	        var sendTotalCount = "";
	        var pengagData = data.pengagData;
	        var startDsticList = data.startDsticList;

	    	// 발송 예약일 셋팅
	        if(!str.isEmpty(pengagData)) {
	        	var pengagYmd = pengagData.pengagYmd;
	            var fmtPengagYmd = fmtDate(pengagYmd);
	            var timeList = pengagData.timeList;
	
	            for(var i=0; i< timeList.length; i++) {
		        	var time = timeList[i];
		        	time = time.slice(0,2) + ":" + time.slice(2, 4);
	
		        	pengagHtml += time + "(" + parseInt(pengagData["TOTAL_TIME_"+ timeList[i]]) + "건)" 
	
					if(i < timeList.length - 1) {
						pengagHtml += ", "
					}
		        }
	
		        $("#pengagYms").html(fmtPengagYmd);
				$("#pengagYmsTotCount").html(pengagHtml);
	        } else {
	        	$("#pengagYms").html("-");
	        }

	    	
	    	if(prcssStusDstic == 'D') {	// D(발송완료)
	    		// 발송 시작일 셋팅
		        if(!str.isEmpty(startDsticList)) {
		        	var startDsticYmd = fmtDate(startDsticList[0].START_YMD);
			        $("#sendStartYms").html(startDsticYmd);
		
			        for(var i=0; i<startDsticList.length; i++) {
						var startHm = startDsticList[i].START_HM;
						startHm = startHm.slice(0,2) + ":" + startHm.slice(2, 4);
		
						startDsticHtml = "";
						startDsticHtml += startHm + "(" + parseInt(startDsticList[i].REQUESTS_NUMBER) + "건)"
		
						if(i < startDsticList.length - 1) {
							startDsticHtml += ", "
						}
			        }
			        
			        $("#sendStartYmsTotCount").html(startDsticHtml);
		        } else {
		        	$("#sendStartYms").html("-");
		        }
			} else {
				$("#sendStartYms").html("-");
			}
	    }).fail(function(xhr){
	    	sweet.alert("발송희망일 세팅중 오류가 발생했습니다. \n\n (selectDateSaveCount())");
	    });
	}

	// 빈값 포맷
	function isEmptyFmtData(data, id) {
		if(data == null || data == "" || data == "undefined") {
			$("#" + id).html("-");
		} else {
			$("#" + id).html(data);
		}
	}

	// 발송내역 검색 초기화
	function popSearchReset() {
		$("#popMsgType").val('all');	// 메시지 유형 초기화
		$("#popResult").val('all');		// 결과 유형 초기화
		$("#tranPhone").val('');		// 수신번호 초기화
	   	
	   	// 메시지유형 상세 초기화
	   	$("#popMsgTypeDetail").children('option:not(:first)').remove();
	   	$("#popMsgTypeDetail").val('all');
	   	$("#popMsgTypeDetail").attr("disabled", true);
	}

	// 발송 상태 변경 ajax
	function sendStatusUpdateAjax(param) {
		var jsonParam = {
			prcssStusDstic : param.prcssStusDstic,
			groupUniqNo : param.groupUniqNo
		}
	
		$.ajax({
	        url: '${pageContext.request.contextPath}/campaign/updateSendStatus',
	        type: "POST",
	        dataType:"json",
	        data: jsonParam,
	        success: function (resultData) {
	        	if(resultData.result == 'SUCCESS') {
	            	sendStatusGrid.currentPage = 1;
	                sendStatusGrid.reload();
	
	                setTimeout(function() {
	                	sweet.alert("변경되었습니다.");    
	                }, 100);
	    		} else {
	    			sweet.alert('변경시 오류가 발생했습니다.');
	    			sendStatusGrid.currentPage = 1;
	                sendStatusGrid.reload();
	    		}
	        },error : function(e){
		    	sweet.alert('변경시 오류가 발생했습니다.');
		    	sendStatusGrid.currentPage = 1;
	            sendStatusGrid.reload();
	        }
		});
	}

	// 날짜 포맷
	function fmtDate(strDate) {
		var YYYY = strDate.substr(0,4);
	    var mm	 = strDate.substr(4,2);
	    var dd	 = strDate.substr(6,2);
	
		return YYYY+"-"+mm+"-"+dd;
	}
</script>
<!-- // 현재 페이지에 필요한 js -->