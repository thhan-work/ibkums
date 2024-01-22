<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>예약 메시지
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
                  <span class="title02 mgl15">휴대폰번호</span>
                  <span><input type="text" id="searchPhoneNum" name="search" value="" maxlength="11" placeholder="숫자만 입력" style="width:100px"></span>
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
        <table class="tbl_list" id="reservedmessage_table" summary="예약 메시지 테이블 입니다.">
            <colgroup>
            <col style="width:70px;" />
            <col style="width:" />
            <col style="width:" />
            <col style="width:" />
            <col style="width:400px" />
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
                <th scope="col">예약 일시</th>
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
        <a href="javascript:;" id="cancel-btn" class="btn_big gray">예약 취소</a>
    </div>
    <!-- //버튼 -->
</div>
<!-- //content -->
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../reservedmessage/reservedmessage-dialog.jsp" flush="true"/>

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
        src="${pageContext.request.contextPath}/static/js/datatable-column/reservedmessage-column.js"></script>
<script>

  $(document).ready(function () {
    enterKeyListener();
 
    // 날짜 범위를 값을 세팅 해줌
	var initSearchStartDate = moment().format("YYYY-MM-DD");
	var initSearchEdnDate = moment().add(6, "months").endOf('months').format("YYYY-MM-DD");

	$("#searchStartDt").val(initSearchStartDate);
    $("#searchEndDt").val(initSearchEdnDate);
    $("#searchStartDatePicker").val(initSearchStartDate);
    $("#searchEndDatePicker").val(initSearchEdnDate);
    
    // datepicker 세팅
    IbkDatepicker.Datepicker("searchStartDatePicker", "${pageContext.request.contextPath}",0,'');
    IbkDatepicker.Datepicker("searchEndDatePicker", "${pageContext.request.contextPath}");
    
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
     data.searchPhoneNumber = $("#searchPhoneNum").val();
   };
   
	// datatables 세팅 모든 파라미터는 필수값
   IbkDataTable.initDataTable("reservedmessage_table", "./reservedmessage", requestParam,
   		IbkReservedMessageColumn.columns, IbkReservedMessageColumn.columnDefs);
  });


  // 조회 버튼 클릭 이벤트 리스너
  $("#search-btn").on('click', function () {
    if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
      // dialog jsp 가 include 되어 있어야 합니다.
      showAlert("검색 날짜 범위가 잘못 되었습니다.");
      return false;
    }
     
    //핸드폰번호 유효성 검사 
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
   
 //페이지당 조회 카운트 변경 이벤트 리스너
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
    
   //휴대폰번호에 숫자만 가능 
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
   
 
  }); //조회버튼 이벤트 끝
  
  


  //메시지내용 클릭 시 복사 이벤트(IE에서만 가능함)
  $(document).on('click', '#msg_val', function(data){
	  var data =data.target.title;
	  window.clipboardData.setData("Text", data);
	  showAlert("보낸메시지 내용이 \n복사되었습니다.");
  }) 
  
  
  // 삭제 버튼 클릭시 선택된 항목을 삭제 하는 이벤트 리스너
  // datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
  // $(document).on 을 사용
  $(document).on('click', "#cancel-btn", function () {
	var count = 0;
	var cancelTarget = new Array();
	var checkbox = $("input[name=grpSeq-Ck]:checked");
	var data=null;
	checkbox.each(function(i) {
		 var  f=checkbox[i].parentNode.parentNode.parentNode;
	     data = IbkDataTable.dataTable.row(f).data();
	     cancelTarget.push(data);
	     count++;
	});
	
    if (cancelTarget.length < 1) {
      showAlert("선택된 예약 메시지가 없습니다.")
    } else {
      var confirmMessage = "총 " + cancelTarget.length + "건 예약 취소 하시겠습니까?";
      showConfirmForAjax(confirmMessage, cancelReservedMessage, cancelTarget);
    }
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
  
  // 예약취소 Ajax
  function cancelReservedMessage(cancelTarget) {
    if (cancelTarget.length > 0) {
      $.ajax({
        url: '${pageContext.request.contextPath}/reservedmessage/cancel',
        type: 'DELETE',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(cancelTarget),
        success: function (result) {
          showAlert("취소 하였습니다.");
          IbkDataTable.reload();
        }
      });
    }
  }
  
  datagridTrColorChanger("#reservedmessage_table");
  
</script>
