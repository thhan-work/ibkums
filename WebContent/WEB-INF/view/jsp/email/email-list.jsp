<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- wrapper -->
	<h3>메일 전송내역 조회
	</h3>
<!-- content -->
<div id="content">
	<div class="info">* 메일 전송내역 조회는 최대 60일까지 가능합니다.</br>* 이메일 주소는 대·소문자 유의하여 조회하시기 바랍니다.</div>
    <!-- Search -->
    <div class="box_search01 mgt40">
      <ul style="width:900px !important;">
        <li>
       		<span class="title02">발송일</span>
           	<span><input type="text" name="search" value="" id="searchStartDt" readonly style="width:75px"></span>
           	<span class="mgl2" style="cursor:pointer;"><input type="hidden" id="searchStartDatePicker"></span>
            <span class="mgl5 mgr5">~</span>
            <span><input type="text" name="search" id="searchEndDt" readonly value="" style="width:75px"></span>
            <span class="mgl2" style="cursor:pointer;"><input type="hidden" id="searchEndDatePicker"></span>
           	<span class="title02 mgl15">조회내용</span>
			<span>
	            <select id="search-word-type">
              		<option value="email">이메일주소</option>
              		<option value="customerId">전행고객번호</option>
	            </select>
       		</span>
       		<span><input type="text" name="search-word" value="" placeholder="입력하세요" id="search-word" style="width:180px"></span>
       		<span class="btn3 fr"><a href="javascript:;" id="search-btn" class="btn_search">조회</a></span> </div>
        </li>
      </ul>
      
   	<!-- //Search -->
   	  	<div class="table_top">
   	  		<span style="color: #014898; font-size: 20px; margin-right: 20px;"> ◎ 본부 대량메일 발송내역 </span>  
   	  		총 <span id="total_cnt">0</span>건
 	   	  	<span class="num"> 
 	          <select id="per-page"> 
	              <option value="10">10</option>
 	              <option value="20">20</option> 
 	              <option value="30">30</option> 
 	          </select> 
	       </span> 
	     </div> 
     <!-- table list -->
        <div class="tbl_wrap_list mgt3" style="overflow-x:auto;min-height:300px;">
          <table class="tbl_list" id="emailCampaign_table" summary="테이블 입니다. 항목으로는 등이 있습니다" >
            <caption>
            테이블
            </caption>
            <colgroup>
	            <col style="width:200px" />
	            <col style="width:200px" />
	            <%-- <col style="width:300px" /> --%>
	            <col style="width:300px" />
	            <col style="width:100px" />
	            <col style="width:100px" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col">전송시간</th>
                <th scope="col">전행고객번호</th>
                <!-- <th scope="col">메일주소</th> -->
                <th scope="col">메일종류</th>
                <th scope="col">성공여부</th>
                <th scope="col">&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="13" style="height:250px">
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
	    
	    
     <!-- table list -->
     	<div>
     		<div class="table_top"> 
     		<span style="color: #014898; font-size: 20px; margin-right: 20px;"> ◎ 고객 스케쥴 메일 발송내역 </span>  
     		 총 <span id="total_cnt2">0</span>건
     	</div>
        <div class="tbl_wrap_list mgt3" style="overflow-x:auto;min-height:350px;">
          <table class="tbl_list" id="emailEcare_table" summary="테이블 입니다. 항목으로는 등이 있습니다" >
            <caption>
            테이블
            </caption>
            <colgroup>
	            <col style="width:200px" />
	            <col style="width:200px" />
	            <%-- <col style="width:300px" /> --%>
	            <col style="width:300px" />
	            <col style="width:100px" />
	            <col style="width:100px" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col">전송시간</th>
                <th scope="col">전행고객번호</th>
                <!-- <th scope="col">메일주소</th> -->
                <th scope="col">메일종류</th>
                <th scope="col">성공여부</th>
                <th scope="col">&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="13" style="height:250px">
                    <div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- //table list -->
          <!-- 페이징 -->
	    <div class="paging" id="pagination2">
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
        src="${pageContext.request.contextPath}/static/js/IbkDatatables3.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatables4.js"></script>
<!-- Script -->
<!-- common event handler on list pages  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/emailCampaign-column.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/emailEcare-column.js"></script>

        
<script>
$(document).ready(function () {
	
	$("body").attr("style", "-ms-overflow-style: scrollbar !important;");
	
	$("#content").parents("section").width("1320px"); // 원본 1220px;
	$("#content").parents("article").width("1200px");  // 1000px
	$("#content").parents("section").find("aside").hide();
	
	//$.ajaxSetup({ async: false });//총 건수 셋팅을 위한 딜레이

    enterKeyListener();
  });

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

  // 조회 버튼 클릭 이벤트 리스너
  $("#search-btn").on('click', function () {
    if($("#search-word").val() == '') {
    	showAlert("조회 조건은 필수 값입니다.");
    	return false;
    }

    if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
        // dialog jsp 가 include 되어 있어야 합니다.
        showAlert("검색 날짜 범위가 잘못 되었습니다.");
        return false;
    }
    
    var diffDate = IbkValidation.invalidDateDiff("searchStartDatePicker", "searchEndDatePicker"); 
    if (diffDate > 60) {
    	showAlert("검색 날짜는 최대 60일까지 조회 가능 합니다.<br><br>[선택일수:"+diffDate+"]");
        return false;
    }
    
   	initCampaignTable();
    initEcareTable();
  });
 
  
  // 페이지당 조회 카운트 변경 이벤트 리스너
  $("#per-page").on('change', function () {
	   	initCampaignTable();
	    initEcareTable();
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


  datagridTrColorChanger("#allmessage_table");
  
////조회 리스트 출력
  function initCampaignTable(){
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
	      IbkDataTable.initDataTable("emailCampaign_table", "${pageContext.request.contextPath}/email/emarketing", requestParam,
    		  IbkEmailCampaignColumn.columns, IbkEmailCampaignColumn.columnDefs, undefined, {"scrollY": "250px"});
	  	
	 }else{
		   $(".dataTables_processing").css("z-index","99999");
		   IbkDataTable.perPage = $("#per-page").val(); 
		   IbkDataTable.currentPage = 1;
		   IbkDataTable.reload();
	 }
  }
  
////조회 리스트 출력
  function initEcareTable(){
	 if(IbkDataTable4.dataTable == null){
		 // datatables ajax 에서 사용 할 parameter 세팅
	     // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
	     var requestParam = function (data) {
	     // 필수 변경 불가
	     data.perPage = IbkDataTable4.perPage;
	     // 필수 변경 불가
	     data.currentPage = IbkDataTable4.currentPage;
	     // 여기서 부터는 Custom 하게
	      data.searchWordType = $("#search-word-type").val();
	      data.searchWord = $("#search-word").val();
	      data.searchStartDt = $("#searchStartDatePicker").val().replace(/-/g, '');
	      data.searchEndDt = $("#searchEndDatePicker").val().replace(/-/g, '');
	     };
	     
		  	// datatables 세팅 모든 파라미터는 필수값
	      IbkDataTable4.initDataTable("emailEcare_table", "${pageContext.request.contextPath}/email/ecare", requestParam,
	      		IbkEmailEcareColumn.columns, IbkEmailEcareColumn.columnDefs, {"scrollY": "250px"});
	 }else{
		$(".dataTables_processing").css("z-index","99999");
		IbkDataTable4.perPage = $("#per-page").val(); 
		IbkDataTable4.currentPage = 1;
		IbkDataTable4.reload();
	 }
  }
  
  // datatable 수정 버튼 클릭 이벤트 리스너
  $("#emailEcare_table").on('click', '.resend_btn', function () {
	  var slot1 = $(this).prop('id').split("-")[1];
	  showConfirmForAjax('재발송', "선택하신 해외송금알림 메일이 재발송 됩니다. 발송하시겠습니까 ?", mailReSend, slot1);
  });
  
  function mailReSend(slot1){
      $.ajax({
          url: '${pageContext.request.contextPath}/email',
          type: 'PUT',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
		  data: JSON.stringify({slot1: slot1}), 
          success: function (result) {
        	  if(result > 0){
					showAlert("메일 재발송을 성공하였습니다.");
        	  }else{
        		  	showAlert("메일 재발송 중 오류가 발생하였습니다.<br>담당자에게 문의하여 주시기 바랍니다.<br><br>## Error Message ##<br>[해당 slot1 데이터가 존재하지 않습니다.]");
        	  }
          },
		  error : function(request,status,error){
				var errorInfo = JSON.parse(request.responseText);
			  	showAlert("메일 재발송 중 오류가 발생하였습니다.<br><br>## Error Message ##<br>["+ errorInfo["code"] +"] "+errorInfo["message"]);
         }
      });
  }
  
</script>

