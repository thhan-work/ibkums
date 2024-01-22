<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>이력 조회
</h3>
<!-- content -->
<div id="content">
    <div class="info">* 대량SMS 발송의뢰, 직원용 SMS 발송, 승인자(협의자), 관리자 화면의 히스토리 조회 화면입니다.</div>
    <!-- Search -->
    <div class="box_search01">
        <ul>
            <li><span class="title01">일자</span>
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
              	<span class="title01">조회화면</span>
                  <span><select id='search-view' style="width:162px;">
                      <option value="all">전체</option>
                      <option value="sms-req">대량보내기(고객대상)</option>
                      <option value="employee">직원용SMS발송 화면</option>
                      <option value="authorizer">승인자(협의자)</option>
                      <option value="admin">관리자</option>
                    </select>
                  </span>
                  <span><select id="search-type" style="width:82px; padding-right:25px !important;">
                      <option value="empl_nm">직원명</option>
                      <option value="part_nm">부서명</option>
                    </select>
                </span>
                  <span><input type="text" id="search-word" name="search" value="" style="width:317px"></span>
              </li>	
         </ul>
         <span class="btn2">
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
        <table class="tbl_list" id="loglist_table" summary="이력조회 테이블 입니다.">
            <colgroup>
                <col style="width:70px;" />
                <col style="width:" />
                <col style="width:" />
                <col style="width:" />
                <col style="width:300px" />
              </colgroup>
            <thead>
                <tr>
                  <th scope="col">번호</th>
                  <th scope="col">일시</th>
                  <th scope="col">직원명</th>
                  <th scope="col">부서명</th>
                  <th scope="col">내용</th>
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
<jsp:include page="../loglist/loglist-dialog.jsp" flush="true"/>

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
        src="${pageContext.request.contextPath}/static/js/datatable-column/loglist-column.js"></script>


<script>

  $(document).ready(function () {
	  
    enterKeyListener();

 	// 시작 셀렉트 박스 범위를 값을 세팅 해줌
    $('#searchStartYear').html(IbkInitData.getYearOptionHtml(0, 10));
    $('#searchStartMonth').html(IbkInitData.getMonthOptionHtml());
    $('#searchStartDay').html(IbkInitData.getDayOptionHtml());
    $('#searchEndYear').html(IbkInitData.getYearOptionHtml(0, 10));
    $('#searchEndMonth').html(IbkInitData.getMonthOptionHtml());
    $('#searchEndDay').html(IbkInitData.getDayOptionHtml());

    // datepicker 세팅
    IbkDatepicker.initDatepicker("searchStartDatePicker", "${pageContext.request.contextPath}");
    IbkDatepicker.initDatepicker("searchEndDatePicker", "${pageContext.request.contextPath}");

    // 검색 시작일 기본값 세팅
    var initSearchStartDate = moment().format("YYYY-MM-DD");
    $("#searchStartDatePicker").val(initSearchStartDate);
    IbkDatepicker.setDateSelectByDatePicker("searchStartDatePicker", "searchStartYear",
        "searchStartMonth", "searchStartDay");

    // 검색 종료일 기본값 세팅
    var initSearchEndDate = moment().add(1, 'month').format("YYYY-MM-DD");
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
    data.searchView = $("#search-view").val();
    data.searchType = $("#search-type").val();
    data.searchWord = $("#search-word").val();
    data.searchStartDt = $("#searchStartDatePicker").val().replace(/-/g, '');
    data.searchEndDt = $("#searchEndDatePicker").val().replace(/-/g, '');
    };

 	// datatables 세팅 모든 파라미터는 필수값
    IbkDataTable.initDataTable("loglist_table", "../loglist", requestParam,
        IbkLogListColumn.columns, IbkLogListColumn.columnDefs);
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
   
  $("#zoom-in-btn").on('click', function () {
    IbkZoom.zoomIn();
  });

  $("#zoom-out-btn").on('click', function () {
    IbkZoom.zoomOut();
  });


  datagridTrColorChanger("#loglist_table");
  
</script>
