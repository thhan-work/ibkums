<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- wrapper -->
	<h3>FAX 전송내역 조회
	</h3>
<!-- content -->
<div id="content">
	<div class="info">* FAX 전송내역 조회는 최근 2년내에 발송된 내역이 조회 가능합니다.(IBK전자팩스에서 발송한 이력은 조회되지 않습니다.)</div>
    <!-- Search -->
    <div class="box_search01 mgt40">
      <ul style="width:900px !important;">
        <li>
       		<span class="title02">발송일</span>
           	<span><input type="text" name="search" value="" id="searchStartDt" readonly style="width:75px"></span>
           	<span class="mgl2" style="cursor:pointer;">
                   <input type="hidden" id="searchStartDatePicker">
               </span>
                <span class="mgl5 mgr5">~</span>
                <span><input type="text" name="search" id="searchEndDt" readonly value="" style="width:75px"></span>
                <span class="mgl2" style="cursor:pointer;">
                   <input type="hidden" id="searchEndDatePicker">
                </span>
                <span class="title02 mgl15">조회내용</span>
			 <span>
	             <select id="search-word-type">
               		<option value="faxNo">FAX번호</option>
               		<option value="sendReq">발신번호</option>
	             </select>
       		 </span>
       		 <span><input type="text" name="search-word" value="" placeholder="입력하세요" id="search-word" style="width:200px"></span>
       		 <span class="btn3 fr"><a href="javascript:;" id="search-btn" class="btn_search">조회</a></span> </div>
      	</li>
      </ul>
      
   	<!-- //Search -->
    	  <div class="table_top">  총 <span id="total_cnt">0</span>건
 	   	  	<span class="num"> 
 	          <select id="per-page"> 
	              <option value="10">10</option>
 	              <option value="20">20</option> 
 	              <option value="30">30</option> 
 	          </select> 
	       </span> 
	     </div> 
     <!-- table list -->
        <div class="tbl_wrap_list" style="overflow-x:auto;min-height:350px;">
          <table class="tbl_list" id="fax_table" summary="테이블 입니다. 항목으로는 등이 있습니다" >
            <caption>
            테이블
            </caption>
            <colgroup>
	            <col style="width:60px" />
	            <col style="width:300px" />
	            <col style="width:250px" />
	            <col style="width:260px" />
	            <col style="width:165px" />
	            <col style="width:165px" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col">번호</th>
                <th scope="col">발송아이디</th>
                <th scope="col">FAX번호</th>
                <th scope="col">전송시간</th>
                <th scope="col">상태</th>
                <th scope="col">결과</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="13" style="height:375px">
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
  <!-- footer
    <footer>copyright</footer>
    <!-- //footer --> 
<!-- //wrapper -->

<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="/WEB-INF/view/jsp/common/dialog.jsp" flush="true"/>

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
        src="${pageContext.request.contextPath}/static/js/datatable-column/fax-column.js"></script>


        
<script>
$(document).ready(function () {
	
	$("body").attr("style", "-ms-overflow-style: scrollbar !important;");
	
	$("#content").parents("section").width("1320px"); // 원본 1220px;
	$("#content").parents("article").width("1200px");  // 1000px
	$("#content").parents("section").find("aside").hide();
	
	//$.ajaxSetup({ async: false });//총 건수 셋팅을 위한 딜레이

    enterKeyListener();

    // 날짜 범위를 값을 세팅 해줌
	var initSearchStartDate = moment().format("YYYY-MM-01");
	var initSearchEndDate = moment().format("YYYY-MM-DD");
	
	$("#searchStartDt").val(initSearchStartDate);
	$("#searchEndDt").val(initSearchEndDate);
	$("#searchStartDatePicker").val(initSearchStartDate);
	$("#searchEndDatePicker").val(initSearchEndDate);
    
    // datepicker 세팅
    IbkDatepicker.Datepicker("searchStartDatePicker", "${pageContext.request.contextPath}");
    IbkDatepicker.Datepicker("searchEndDatePicker", "${pageContext.request.contextPath}",'');
 	
  });


  // 조회 버튼 클릭 이벤트 리스너
  $("#search-btn").on('click', function () {
    if($("#search-word").val() == '') {
    	showAlert("번호는 필수 값입니다.");
    	return false;
    }
    
    if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
      // dialog jsp 가 include 되어 있어야 합니다.
      showAlert("검색 날짜 범위가 잘못 되었습니다.");
      return false;
    }

//     ///핸드폰번호 유효성 검사 
//    if($("#search-word").val().length < 10 && $("#search-word").val().length > 1 ){
// 	    if($("#searchPhoneNum").val().substr(0,2) != '01'){
// 	    	showAlert("유효한 핸드폰번호가 아닙니다.");
// 	        return false;
// 	    }
//     	showAlert("유효한 핸드폰번호가 아닙니다.(10자리 이상)");
//         return false;
//     }
   
   initTable();
  });
 
  
  // 페이지당 조회 카운트 변경 이벤트 리스너
  $("#per-page").on('change', function () {
    IbkDataTable.perPage = $(this).val();
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
  });
  
  //검색 시작일 datepikcer 값 변경 시
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
	$("#search-word").keyup(function(event){
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^0-9]/gi,''));
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


  datagridTrColorChanger("#fax_table");
  
////조회 리스트 출력
  function initTable(){
	 if(IbkDataTable.dataTable == null){
		 // datatables ajax 에서 사용 할 parameter 세팅
	     // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
	     var requestParam = function (data) {
	     // 필수 변경 불가
	     data.perPage = IbkDataTable.perPage;
	     // 필수 변경 불가
	     data.currentPage = IbkDataTable.currentPage;
	     // 여기서 부터는 Custom 하게
	      data.searchWordType = $("#search-word-type").val();
	      data.searchWord = $("#search-word").val();
	      data.searchStartDt = $("#searchStartDatePicker").val().replace(/-/g, '');
	      data.searchEndDt = $("#searchEndDatePicker").val().replace(/-/g, '');
	     };
	     
	  	// datatables 세팅 모든 파라미터는 필수값
	      IbkDataTable.initDataTable("fax_table", "${pageContext.request.contextPath}/fax", requestParam,
	      		IbkFaxColumn.columns, IbkFaxColumn.columnDef, undefined, {"scrollY": "350px"});
	 }else{
		   $(".dataTables_processing").css("z-index","99999");
		   IbkDataTable.currentPage = 1;
		   IbkDataTable.reload();
	 }
  }
</script>

