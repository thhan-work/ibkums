<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>SMS발송 진행현황
</h3>
<!-- content -->
<div id="content">
    <div class="info">* 대량SMS 발송의뢰 내역만 조회 가능합니다.</div>
    <!-- Search -->
    <div class="box_search01">
        <ul>
            <li><span class="title01">등록일</span>
            	<span>
                    <select class="small searchDate" id="searchStartYear"></select>
                </span>
                <span class="text1">년</span>
                <span>
                    <select class="small searchDate" id="searchStartMonth"></select>
                </span>
                <span class="text1">월</span>
                <span>
                    <select class="small searchDate" id="searchStartDay"></select>
                </span>
                <span class="text1">일</span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchStartDatePicker">
                </span>
                <span class="mgl5 mgr5">~</span>
                <span>
                    <select class="small searchDate" id="searchEndYear">
                    </select>
                </span>
                <span class="text1">년</span>
                <span>
                    <select class="small searchDate" id="searchEndMonth">
                    </select>
                </span>
                <span class="text1">월</span>
                <span>
                    <select class="small searchDate" id="searchEndDay">
                    </select>
                </span>
                <span class="text1">일</span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchEndDatePicker">
                </span>
             </li>
             <li>
             	<span class="title01">기안상태</span>
                 <span><select id="draft-status" style="width:155px;">
                     <option value="all" selected>전체</option>
                     <option value="C">임시저장</option>
<!--                      <option value="A">결재진행중</option> -->
                     <option value="B">발송승인대기</option>
                     <option value="I">발송승인중</option>
<!--                      <option value="P">시간경과(관리자문의)</option> -->
<!--                      <option value="N">반려</option> -->
                     <option value="R">발송준비중</option>
                     <option value="Y">발송대기</option>
                     <option value="S">발송중</option>
                     <option value="T">발송중지</option>
                     <option value="D">발송완료</option>
                     <option value="E">발송취소</option>
                   </select>
                 </span>
                 <span class="mgl5"><a href="javascript:;" class="btn_help"></a></span>
                 <span class="title01 mgl124">메시지구분</span>
                 <span><select id="search-type" style="width:83px;">
                     <option value="all" selected>전체</option>
                     <option value="sms">SMS</option>
                     <option value="lms">LMS</option>
                     <option value="mms">MMS</option>
                     <option value="kakao">KAKAO</option>
                   </select>
                 </span>
             </li>
             <li>
             	<span class="title01">기안명</span>
                <span>
                	<input type="text" name="search" value="" id="search-draft-name" style="width:481px">
                </span>
             </li>	
         </ul>
         <span class="btn">
         	<a href="javascript:;" class="btn_search" id="search-btn">조회</a></span>
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
        <table class="tbl_list" id="smssendlist_table" summary="SMS발송 진행현황 테이블 입니다.">
            <colgroup>
                <col style="width:70px;" />
                <col style="width:" />
                <col style="width:" />
                <col style="width:350px" />
                <col style="width:" />
                <col style="width:" />
              </colgroup>
            <thead>
            <tr>
                  <th scope="col">번호</th>
                  <th scope="col">등록일</th>
                  <th scope="col">메시지구분</th>
                  <th scope="col">기안명</th>
                  <th scope="col">발송진행건수<br>
                  (발송건수/총건수)</th>
                  <th scope="col">기안상태</th>
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
</div>
<!-- //content -->
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="./smssendlist-dialog.jsp" flush="true"/>

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
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/smssendlist-column.js"></script>


<script>

  $(document).ready(function () {
	  
    enterKeyListener();

 	// 시작 셀렉트 박스 범위를 값을 세팅 해줌
    $('#searchStartYear').html(IbkInitData.getYearOptionHtml(3, 10));
    $('#searchStartMonth').html(IbkInitData.getMonthOptionHtml());
    $('#searchStartDay').html(IbkInitData.getDayOptionHtml());
    $('#searchEndYear').html(IbkInitData.getYearOptionHtml(3, 10));
    $('#searchEndMonth').html(IbkInitData.getMonthOptionHtml());
    $('#searchEndDay').html(IbkInitData.getDayOptionHtml());

    // datepicker 세팅
    IbkDatepicker.initDatepicker("searchStartDatePicker", "${pageContext.request.contextPath}");
    IbkDatepicker.initDatepicker("searchEndDatePicker", "${pageContext.request.contextPath}");

    // 검색 시작일 기본값 세팅
    var initSearchStartDate = moment().add(-1, 'month').format("YYYY-MM-DD");
    $("#searchStartDatePicker").val(initSearchStartDate);
    IbkDatepicker.setDateSelectByDatePicker("searchStartDatePicker", "searchStartYear",
        "searchStartMonth", "searchStartDay");

    // 검색 종료일 기본값 세팅
    var initSearchEndDate = moment().format("YYYY-MM-DD");
    $("#searchEndDatePicker").val(initSearchEndDate);
    IbkDatepicker.setDateSelectByDatePicker("searchEndDatePicker", "searchEndYear",
        "searchEndMonth", "searchEndDay");
    
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
    data.messageType = $("#search-type").val();
    data.draftStatus = $("#draft-status").val();
    data.draftName = $("#search-draft-name").val();
    data.searchStartDt = $("#searchStartDatePicker").val().replace(/-/g, '');
    data.searchEndDt = $("#searchEndDatePicker").val().replace(/-/g, '');
    };
    
 	// datatables 세팅 모든 파라미터는 필수값
    IbkDataTable.initDataTable("smssendlist_table", "./smssendlist", requestParam,
        IbkSmsSendListColumn.columns, IbkSmsSendListColumn.columnDefs);
 	
  });


  // 조회 버튼 클릭 이벤트 리스너
  $("#search-btn").on('click', function () {
    if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
      // dialog jsp 가 include 되어 있어야 합니다.
      showAlert("검색 날짜 범위가 잘못 되었습니다.");
      return false;
    }
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
    
  });
  
  //원물음표(도움말)클릭시
  $(".btn_help").on('click', function(){
	  showAlertHelp();
  })
  
  // 페이지당 조회 카운트 변경 이벤트 리스너
  $("#per-page").on('change', function () {
    IbkDataTable.perPage = $(this).val();
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
  });
  
  //검색 시작일 datepikcer 값 변경 시
  // 검색 시작일 셀렉트 박스 날짜 값을 변경해 주는 이벤트 리스너
  $("#searchStartDatePicker").on('change', function () {
    IbkDatepicker.setDateSelectByDatePicker("searchStartDatePicker", "searchStartYear",
        "searchStartMonth", "searchStartDay");
  });

  // 검색 종료일 datepikcer 값 변경 시
  // 검색 종료 셀렉트 박스 날짜 값을 변경해 주는 이벤트 리스너
  $("#searchEndDatePicker").on('change', function () {
    IbkDatepicker.setDateSelectByDatePicker("searchEndDatePicker", "searchEndYear",
        "searchEndMonth", "searchEndDay");
  });
  
  // 검색 시작일 셀렉트 박스가 변경 되었을 경우 검색 시작 datepiker 값을 변경해주는
  // 이벤트 리스너
  $(".searchDate").on('change', function () {
    IbkDatepicker.setDatePickerByDateSelect("searchEndDatePicker", "searchEndYear",
        "searchEndMonth", "searchEndDay");
    IbkDatepicker.setDatePickerByDateSelect("searchStartDatePicker", "searchStartYear",
        "searchStartMonth", "searchStartDay");
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
   
//   $("#zoom-in-btn").on('click', function () {
//     IbkZoom.zoomIn();
//   });

//   $("#zoom-out-btn").on('click', function () {
//     IbkZoom.zoomOut();
//   });
  
  //테이블안에 셀 클릭시
	$('#smssendlist_table tbody').on('click', 'tr', function() {
		var data = IbkDataTable.dataTable.row(this).data();
		var rCount = data.requestsNumber;
		var utime = Math.floor(rCount/10000)+1;
		
		if(data.prcssStusDstic == 'B'){
// 			showAlert("대상자파일 등록 중입니다. 약 " + utime + "~" +(utime+1)+"분 정도 소요됩니다.");
// 			return false;
		}
		
		if(data.prcssStusDstic == 'C'){ // 임시저장
			/* window.location.href = "${pageContext.request.contextPath}/smssendlist-detail.ibk?id="
	            + data.groupUniqNo; */
		}
		
		if(data.inst == "" || data.inst == null){	//대상자 파일이 없을 경우
    		window.location.href = "${pageContext.request.contextPath}/smssendlist-detail.ibk?id="
	            + data.groupUniqNo;
		}else{
			$.ajax({
			    type:'GET',
			    url:'${pageContext.request.contextPath}/smssendlist/fileDoneCheck/'+ data.groupUniqNo,
			    success: function (result) {
			        if(result <= 0){
			 			showAlert("대상자파일 등록 중입니다.<br>약 " + utime + "~" +(utime+1)+"분 정도 소요됩니다.");
			 			return false;
			        }else{
			    		window.location.href = "${pageContext.request.contextPath}/smssendlist-detail.ibk?id="
				            + data.groupUniqNo;
			        }
			    }
			})
		}
	});
  
  datagridTrColorChanger("#smssendlist_table");
  
</script>
