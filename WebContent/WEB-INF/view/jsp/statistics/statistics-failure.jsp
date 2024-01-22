<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>실패유형 통계
</h3>
<!-- content -->
<div id="content">
    <!-- Search -->
    <div class="box_search01">
      <ul>
        <li>
			<span class="title02">검색년월</span>
			<span>
				<select class="small searchDate" id="search_year"></select>
			</span>
			<span class="text1">년</span>
			<span>
				<select class="small searchDate" id="search_month"></select>
			</span>
			<span class="text1">월</span>                
			
			
			<span class="title02 mgl15">메시지구분</span>
			<span>
				<select style="width:100px;" id="message_type">
					<option value="" selected>전체</option>
					<option value="SM">SMS</option>
					<option value="LM">LMS</option>
					<option value="MM">MMS</option>
				</select>
			</span>

        	<span class="title02 mgl15">실패코드</span>
			<span>
				<input type="text" maxlength="5" value="" id="failure_code" style="width:120px">
			</span>
        </li>
      </ul>
      <span class="btn3"><a href="#" class="btn_search" id="search-btn">조회</a></span>
    </div>
    
    <!-- table list -->
    <div class="table_top"> 총 <span id="total_cnt">0</span>건
        <a href="#" class="btn_default blue fr" id="excel-btn">엑셀다운</a>
   	</div>
   	
    <!-- //Search -->

    <!-- table list -->
    <div class="tbl_wrap_list">
        <table class="tbl_list" id="failure_statistics_table" summary="실패유형 통계 테이블 입니다.">
            <colgroup>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:400px"/>
                <col style="width:"/>
            </colgroup>
            <thead>
            <tr>                
                <th scope="col">메시지구분</th>
                <th scope="col">실패코드</th>
                <th scope="col">실패내용</th>
                <th scope="col">실패건수</th>
            </tr>
            </thead>
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
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery.filedownload.js"></script>
<!-- Script -->
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/statistics-column.js"></script>
<script>
//datatables ajax 에서 사용 할 parameter 세팅
// 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
var requestParam = function (data) {
    // 필수 변경 불가
    data.perPage = IbkDataTable.perPage;
    // 필수 변경 불가
    data.currentPage = IbkDataTable.currentPage;
    // 여기서 부터는 Custom 하게
    
    data.messageType = $("#message_type").val();
    data.failureCode = $("#failure_code").val();
    data.searchYear = $("#search_year").val();
    data.searchMonth = $("#search_month").val();
};

  $(document).ready(function () {

    enterKeyListener();

    // 시작 셀렉트 박스 범위를 값을 세팅 해줌
    $('#search_year').html(IbkInitData.getYearOptionHtml(0, 10));
    $('#search_month').html(IbkInitData.getMonthOptionHtml());

    // 검색 시작일 기본값 세팅
    var initYear = moment().format("YYYY");
    var initMonth = moment().format("MM");
    $('#search_year').val(initYear);
    $('#search_month').val(initMonth);
    
    // datatables 세팅 모든 파라미터는 필수값
    IbkDataTable.initDataTable("failure_statistics_table", "./statistics-failure", requestParam,
    		IbkFailureStatisticsColumn.columns, IbkFailureStatisticsColumn.columnDefs);
  });

  // 조회 버튼 클릭 이벤트 리스너
  $("#search-btn").on('click', function () {
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
  });

  $("#zoom-in-btn").on('click', function () {
    IbkZoom.zoomIn();
  });

  $("#zoom-out-btn").on('click', function () {
    IbkZoom.zoomOut();
  });
  
  $("#excel-btn").on('click', function () {
	var data = {};
	requestParam(data);
    
    $.fileDownload("./statistics-failure-excel.ibk",{
      httpMethod: "POST",
      data: data,
      successCallback: function (url) {
      },
      failCallback: function(responesHtml, url){
      }
     });
  });

  // enter ket 이벤트 리스너
  function enterKeyListener() {
    // enter key event
    $("#failure_code").keypress(function (event) {
      if (event.which == 13) {
        event.preventDefault();
        $("#search-btn").trigger("click");
      }
    });
  }
</script>
