<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>업무코드관리
</h3>
<!-- content -->
<div id="content">
    <!-- Search -->
    <div class="box_search01">
      <ul>
        <li>
			<span class="title02">조회조건</span>
			<span>
				<select style="width:100px;" id="search-word-type">
					<option value="system_name" selected>시스템명</option>
					<option value="unit_code">단위상세코드</option>
				</select>
			</span>
			<span>
				<input type="text" maxlength="100" value="" id="search-word" style="width:120px">
			</span>
			
			<span class="title02 mgl15">발송매체</span>
			<span>
				<select style="width:100px;" id="message-type">
					<option value="" selected>전체</option>
					<option value="SMS">SMS</option>
					<option value="LMS">LMS</option>
					<option value="MMS">MMS</option>
				</select>
			</span>
        </li>
      </ul>
      <span class="btn3"><a href="#" class="btn_search" id="search-btn">조회</a></span>
    </div>
    
    <!-- table list -->
    <div class="table_top">
        <a href="#" class="btn_default blue" id="create-btn">등록</a>
        <a href="#" class="btn_default delete" id="delete-btn">삭제</a>
        <a href="#" class="btn_default blue" id="excel-upload-btn">엑셀업로드</a>
        <a href="#" class="btn_default blue" id="excel-download-btn">엑셀다운</a>
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
        <table class="tbl_list" id="job_code_table" summary="영업점별 통계 테이블 입니다.">
            <colgroup>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:350px"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:60px"/>                
            </colgroup>
            <thead>
            <tr>            
            	<th scope="col">
                    <div class="checkbox_center">
                        <input type="checkbox" id="select-all"/>
                        <label for="select-all"></label>
                    </div>
                </th>    
                <th scope="col">시스템명</th>
                <th scope="col">단위상세코드</th>
                <th scope="col">업무내용</th>
                <th scope="col">담당부서</th>
                <th scope="col">담당자</th>
                <th scope="col">발송매체</th>
                <th scope="col">&nbsp;</th>
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

<!-- jobcode popup -->
<jsp:include page="manage-jobcode-popup.jsp" flush="true"/>
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
        src="${pageContext.request.contextPath}/static/js/datatable-column/manage-column.js"></script>
<script>

$(document).ready(function () {

  enterKeyListener();
  
  // datatables ajax 에서 사용 할 parameter 세팅
  // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
  var requestParam = function (data) {
    // 필수 변경 불가
    data.perPage = IbkDataTable.perPage;
    // 필수 변경 불가
    data.currentPage = IbkDataTable.currentPage;
    // 여기서 부터는 Custom 하게
    data.searchWordType = $("#search-word-type").val();
    data.messageType = $("#message-type").val();
    data.searchWord = $("#search-word").val();
    
  };
  // datatables 세팅 모든 파라미터는 필수값
  IbkDataTable.initDataTable("job_code_table", "./manage-jobcode", requestParam,
		  IbkJobCodeColumn.columns, IbkJobCodeColumn.columnDefs);
});

// 페이지당 조회 카운트 변경 이벤트 리스너
$("#per-page").on('change', function () {
  IbkDataTable.perPage = $(this).val();
  IbkDataTable.currentPage = 1;
  IbkDataTable.reload();
});

// 조회 버튼 클릭 이벤트 리스너
$("#search-btn").on('click', function () {
  IbkDataTable.currentPage = 1;
  IbkDataTable.reload();
});

// 전체 체크박스 클릭 이벤트 리스너
// datatables 의 모든 셀렉트 박스가 선택 된다.
$('#select-all').on('click', function () {
  var rows = IbkDataTable.dataTable.rows({'search': 'applied'}).nodes();
  $('input[type="checkbox"]', rows).prop('checked', this.checked);
});

// 삭제 버튼 클릭시 선택된 항목을 삭제 하는 이벤트 리스너
// datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
// $(document).on 을 사용
$(document).on('click', "#delete-btn", function () {
  var deleteTarget = [];
  ($(".dt-check-box").each(function () {
    if ($(this).prop('checked')) {
      deleteTarget.push($(this).val());
    }
  }));
  if (deleteTarget.length < 1) {
    showAlert("선택된 공통코드그룹이 없습니다.")
  } else {
    var confirmMessage = "총 " + deleteTarget.length + "건 삭제 하시겠습니까?";
    showConfirmForAjax("삭제", confirmMessage, deleteJobCode, deleteTarget);
  }
});

// 체크 박스 선택시 전체 선택 체크 박스의 체크 여부를 판단하는 이벤트 리스너
// datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
// $(document).on 을 사용
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

$("#zoom-in-btn").on('click', function () {
  IbkZoom.zoomIn();
});

$("#zoom-out-btn").on('click', function () {
  IbkZoom.zoomOut();
});

//등록 버튼 클릭 이벤트 리스너 등록
$("#create-btn").on('click', function () {
	  registration_init();
});

//등록 버튼 클릭 이벤트 리스너 등록
$("#excel-upload-btn").on('click', function () {
	upload_init();
});

//등록 버튼 클릭 이벤트 리스너 등록
$("#excel-download-btn").on('click', function () {
	
    $.fileDownload("./manage-jobcode-excel.ibk",{
      httpMethod: "POST",
      //data: data,
      successCallback: function (url) {
      },
      failCallback: function(responesHtml, url){
      }
     });
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

// datatable 수정 버튼 클릭 이벤트 리스너
 $("#job_code_table").on('click', '.mod_btn', function () {
	   modification_init();
     $.ajax({
         url: '${pageContext.request.contextPath}/manage-jobcode/' + $(this).prop('id').split("-")[1],
         type: 'GET',
         dataType: 'JSON',
         success: function (result) {
			setJobCodeInfo($("#popup_modify"), result);
         }
     });
 });

// 삭제 Ajax
function deleteJobCode(deleteTarget) {
  if (deleteTarget.length > 0) {
    $.ajax({
      url: '${pageContext.request.contextPath}/manage-jobcode/' + deleteTarget,
      type: 'DELETE',
      success: function (result) {
        showAlert("삭제 하였습니다.");
        IbkDataTable.reload();
      }
    });
  }
}
</script>
