<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>고객수신거부관리
</h3>
<!-- content -->
<div id="content">
    <div class="info">* 수신거부 요청 고객등록/검색(전체),삭제,수정등 관리합니다.</div>
    <!-- Search -->
    <div class="box_search01">
      <ul>
        <li>
        	<span>
				<select id="search-word-type">
					<option value="phone">휴대폰번호</option>
					<option value="custName">고객명</option>
					<option value="cutOption">업무구분</option>
					<option value="cutDate">등록일</option>
				</select>
			</span>
			<span id="search-phone"><input type="text" name="search-input-phone" value="" placeholder="입력하세요" id="search-input-phone" style="width:150px"></span>
			<span id="search-input" style="display: none;"><input type="text" name="search-word" value="" placeholder="입력하세요" id="search-word" style="width:150px;"></span>
			<span id="search-date" style="display: none;">
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
					<select class="small searchDate" id="searchEndYear"></select>
				</span>
				<span class="text1">년</span>
				<span>
				    <select class="small searchDate" id="searchEndMonth"></select>
				</span>
				<span class="text1">월</span>
				<span>
				    <select class="small searchDate" id="searchEndDay"></select>
				</span>
				<span class="text1">일</span>
				<span class="mgl2" style="cursor:pointer;">
				    <input type="hidden" id="searchEndDatePicker">
				</span>
			</span>
			<span id="search-select" style="display: none;">
				<select id="search-select-word">
					<option value="">전체</option>
					<option value="all">모든업무</option>
					<option value="ad">광고</option>
					<option value="ca">카드</option>
					<option value="yc">연체</option>
				</select>
			</span>
        </li>
      </ul>
      <span class="btn3"><a href="javascript:;" class="btn_search" id="search-btn">조회</a></span>
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
        <table class="tbl_list" id="data_table">
            <colgroup>
                <col style="width:70px;"/>
                <col style="width:" />
                <col style="width:" />
                <col style="width:" />
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
                <th scope="col">고객명</th>
                <th scope="col">업무구분</th>
                <th scope="col">휴대폰번호</th>
                <th scope="col">등록자</th>
                <th scope="col">등록일</th>
                <th scope="col">비고</th> 
                <th scope="col">수정</th>
            </tr>
            </thead>
			<tbody>
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
        <a href="javascript:" id="create-btn" class="btn_big blue">등록</a>
        <a href="javascript:" id="delete-btn" class="btn_big delete">삭제</a>
    </div>
    <!-- //버튼 -->
</div>
<!-- //content -->
<!-- user detail popup -->
<jsp:include page="smsUnsubscribe-detail.jsp" flush="true"/>
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
<!-- Script -->
<!-- zoom set  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/zoom.js"></script>
<!-- common event handler on list pages  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/smsUnsubscribe-column.js"></script>
<script>
    // target url  세팅(하단 list_stuff.js 에서 참조)
    var deleteTargetUrl = '${pageContext.request.contextPath}/smsUnsubscribe/del/';

    $(document).ready(function () {
        // enter key event
        $("#search-word").keypress(function (event) {
          if (event.which == 13) {
            event.preventDefault();
            $("#search-btn").trigger("click");
          }
        });
        
        $("#search-phone").keypress(function (event) {
            if (event.which == 13) {
              event.preventDefault();
              $("#search-btn").trigger("click");
            }
        });
        
        //휴대폰번호에 숫자만 가능 
    	$("#search-input-phone").keyup(function(event){
    	    var inputVal = $(this).val();
    	    $(this).val(inputVal.replace(/[^0-9]/gi,''));
    	});
      
        
        //#### initDate ######
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
        //#### initDate ######
        
        
        // datatables ajax 에서 사용 할 parameter 세팅
        // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
        var requestParam = function (data) {
            // 필수 변경 불가
            data.perPage = IbkDataTable.perPage;
            // 필수 변경 불가
            data.currentPage = IbkDataTable.currentPage;
            // 여기서 부터는 Custom 하게
            data.searchWordType = $("#search-word-type").val();
            
        	if(data.searchWordType == 'custName'){
        		data.searchWord = $("#search-word").val();
        	}else if(data.searchWordType == 'cutOption'){
        		data.searchWord = $("#search-select-word option:selected").val();
        	}else if(data.searchWordType == 'cutDate'){
        		data.searchToDate = $("#searchStartDatePicker").val().replace(/-/g, '');
        		data.searchFromDate = $("#searchEndDatePicker").val().replace(/-/g, '');
        	}else{
        		data.searchWord = $("#search-input-phone").val();
        	}
        };

        // datatables 세팅 모든 파라미터는 필수값
        console.log(requestParam);
        console.log(IbkContentsColumn.columns);
        console.log(IbkContentsColumn.columnDefs);
        IbkDataTable.initDataTable("data_table", "./smsUnsubscribe", requestParam,IbkContentsColumn.columns, IbkContentsColumn.columnDefs);

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

    // 등록 버튼 클릭 이벤트 리스너 등록
    $("#create-btn").on('click', function () {
    	initEmployeeInfo();
        popOpen("#popup_wrap");
    });

    // datatable 수정 버튼 클릭 이벤트 리스너
    $("#data_table").on('click', '.mod_btn', function () {
        
        $.ajax({
            url: '${pageContext.request.contextPath}/smsUnsubscribe/' + $(this).prop('id').split("_")[1].replace(/-/g, ''),
                type: 'GET',
                success: function (result) {
                	popOpen("#popup_wrap");
                    setSmsUnsubscribeInfo(result);
            	},
    	        error: function (xhr, exception,message,code) {
    		  	      showAlert("수정 요청이 실패하였습니다.<br>실패코드:"+xhr.responseJSON.code);
    		    }
        });
    });

    $("#search-word-type").on('change', function(){
    	
    	var selectType = $("#search-word-type option:selected").val();
    	
    	if(selectType == 'custName'){
    		$("#search-phone").hide();
    		$("#search-select").hide();
    		$("#search-input").show();
    		$("#search-date").hide();
    	}else if(selectType == 'cutOption'){
    		$("#search-phone").hide();
    		$("#search-select").show();
    		$("#search-input").hide();
    		$("#search-date").hide();
    	}else if(selectType == 'cutDate'){
    		$("#search-phone").hide();
    		$("#search-select").hide();
    		$("#search-input").hide();
    		$("#search-date").show();    		
    	}else{
    		$("#search-phone").show();
    		$("#search-select").hide();
    		$("#search-input").hide();
    		$("#search-date").hide();
    	}
    	
    });
    
    function reload(){
        IbkDataTable.currentPage = 1;
        IbkDataTable.reload();
    }

    datagridTrColorChanger("#data_table");
    
    
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
    
</script>
