<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatatablesPopup-new.js"></script>

<script type="text/javascript" 
		src="${pageContext.request.contextPath}/static/js/IbkDatatables-checkbox.js"></script>
        
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datatable-column/authGrant-column.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datatable-column/authUser-column.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/select.dataTables.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/dataTables.select.min.js"></script>

<style>
	.chkboxAlign {
		padding-left:2.5% !important;
	}
</style>
<!-- begin page-header -->
  <div class="page-header">
    권한 사용자 부여
    <ol class="breadcrumb pull-right"></ol>
  </div>
  <!-- end page-header -->

  <!-- begin Search -->
  <div class="row">
    <div class="search_area">
    <div class="search_field width200">
        <label>직원명</label>
        <div>
          <input type="text" id="searchEmplName" name="" class="form-control" value="" placeholder="직원명을 입력하세요" />
        </div>
      </div>
      <div class="search_field width200">
        <label>직원번호</label>
        <div>
          <input type="text" id="searchEmplId" name="" class="form-control" value="" placeholder="직원번호를 입력하세요" />
        </div>
      </div>
      <div class="search_field">
        <label>등록일 / 권한부여일</label>
        <div>
       		<select id="authDateType">
	          <option value="regYms">등록일</option>
	          <option value="authGrantYms">권한부여일</option>
	        </select>
      		<input type="text" class="form-control date-picker" id="searchDate" value="" />
        </div>
      </div>
      <div class="search_field">
        <button class="btn btn-reset btn-sm" id="resetBtn" onclick="searchReset();">초기화</button>
        <button class="btn btn-search btn-sm" id="searchBtn">검색</button>
      </div>
    </div>
  </div>
  <!-- end Search  -->

	<div class="row clearfix">
	  <div class="pull-right">
	    <button class="btn btn-reset btn-sm" onclick="deleteAuthUser()">사용자삭제</button>
	    <button class="btn btn-reset btn-sm" onclick="callAuthEmpRegistPopup()">사용자등록</button>
	    <button class="btn btn-search btn-sm" onclick="openAuthGrantPopup()" style="width:auto">권한 일괄부여</button>
	  </div>
	</div>
	
  <!-- begin table -->
  <div class="row">
    <div class="table-result">
      총 <strong class="split" id="authUser_table_total_cnt">0</strong>
      <select class="search-limit" id="authUser_table_per_page">
        <option value="10">10개씩 보기</option>
        <option value="20">20개씩 보기</option>
        <option value="30">30개씩 보기</option>
      </select>
    </div>
    <div class="table-responsive">
      <table class="table table-hover table-cursor" id="authUser_table">
        <colgroup>
	        <col width="40" />
	        <col width="80" />
	        <col width="200" />
	        <col width="200" />
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
        		<th class="">
        			<label class="check-container">&nbsp;
                  		<input type="checkbox" id="authUser_table_select_all" name="select_all"/>
                  		<span class="checkmark" ></span>
               		</label>
           	  	</th> 
				<th>No.</th>
				<th>부서</th>
				<th>직원번호</th>
				<th>직원명</th>
				<th>직책</th>
				<th>권한 수</th>
				<th>등록자</th>
				<th>등록일</th>
				<th>권한부여자</th>
				<th>권한부여일</th>
	        </tr>
        </thead>
        <tbody>
        	<tr>
                <td colspan="9">
                	<div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
                </td>
            </tr>
        </tbody>
      </table>
    </div>
  </div>

<!-- 권한 사용자 등록 팝업 -->
<jsp:include page="./dialog/authEmpRegist.jsp" flush="true" />
<!-- 권한 부여 팝업 -->
<jsp:include page="./dialog/authGrant-dialog.jsp" flush="true" />

<script type="text/javascript">
	var authUserGrid = new IbkDataTableCheckBox();
	
	$(document).ready(function() {
		initAuthUser();
	});
	
	function initAuthUser() {
		// 날짜 초기 셋팅
		dateInit();
	
		// 권한 사용자 조회
		selectAuthUserGrid();
	}
	
	// 권한 사용자 조회
	function selectAuthUserGrid() {
		// 파라미터 셋팅
	   	var param = function (data) {
	   		var searchDate = $("#searchDate").val();
			var dateArr = searchDate.split(" ~ ");
	    	data.perPage = authUserGrid.perPage; 
	    	data.currentPage = authUserGrid.currentPage; 
		    data.searchStartDt = (dateArr.length > 1) ? str.replace(dateArr[0], "-", "") : null;
	    	data.searchEndDt = (dateArr.length > 1) ? str.replace(dateArr[1], "-", "") : null;
	    	data.dateType = $("#authDateType").val();
	    	data.searchEmplId = $("#searchEmplId").val(); 
	    	data.emplNm = $("#searchEmplName").val(); 
		};
		
		authUserGrid.initDataTable("authUser_table", "./authUserList", param,
				AuthUserListColumn.columns, AuthUserListColumn.columnDefs, AuthUserListColumn.select);

		// 그리드 안 이벤트 (상세화면)
		$('#authUser_table tbody').on('click','tr', function(e) {
			if(e.target.id.indexOf('_reset') > 0 ) {
				searchReset();
				return
			}
			
			if( $(e.target).closest('td').find('input[type=checkbox]').length > 0 ) return

			var data = authUserGrid.dataTable.row($(this)).data();
			$('#popupAuthGrant #infoEmplId').val(data.emplId);
			$('#popupAuthGrant #mode').val(DAILOG_MODE.DETAIL);
			initGrantDialog();
			
			e.stopImmediatePropagation();
		});
	}
	
	// 조회 버튼 클릭 이벤트
	$("#searchBtn").click(function () {
		authUserGrid.reload();
	});
	
	// 검색 초기화
	function searchReset() {
	   	// 날짜 초기값 세팅
	   	dateInit();
	
	   	$('.search_field select').each(function() {
			// 첫번째 option 선택
			$(this).children('option:eq(0)').prop("selected", true);
		});
		
		$('#searchEmplName').val('');
		$('#searchEmplId').val('');
		$("#searchBtn").trigger('click');
	}
	
	// 날짜 초기값 세팅
	function dateInit() {
		moment.locale('ko'); // 한글 셋팅
		var date = new Date();
		var firstDay = dateFunc.getLastYear(); // 1년전 날짜
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
		//$('#searchDate').val('');
	}
	
	// 사용자 삭제
	function deleteAuthUser() {
		var rowArr = authUserGrid.dataTable.rows('.selected').data();
		var emplIdList = [];     
        for (var i = 0; i < rowArr.length; i++) {
        	emplIdList.push(rowArr[i].emplId);
       	}

		if(!emplIdList.length) {
			sweet.alert('사용자를 선택해주세요.');
			return false;
		}
		
		sweet.confirm("권한 사용자 삭제","선택하신 사용자를 삭제하시겠습니까?", 'result', function(isConfirm) {
			if(isConfirm) {
				deleteAuthUserAjax(emplIdList);
			} else {
				return false;
			}
		});
	}

	// 사용자 삭제 ajax
	function deleteAuthUserAjax(emplIdList) {
		$.ajax({
            url: '${pageContext.request.contextPath}/campaign/deleteAuthUser',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({emplIdList: emplIdList})
        }).done(function (data) {
            if("SUCCESS" == data.result) {
            	sweet.alert("사용자 삭제가 완료되었습니다.");
            	$("#searchBtn").click();
            }
        }).fail(function (xhr) {
        	sweet.alert("권한 사용자 등록 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
        });
	}
	
	// 사용자 등록팝업 호출
	function callAuthEmpRegistPopup() {
		$('#popupAuthEmp').popup('show');
		$("#authEmpId").val('');
		authEmpGrid.reload();
	}

	// 권한 부여 팝업 호출
	function openAuthGrantPopup() {
		$('#popupAuthGrant #mode').val(DAILOG_MODE.CREATE);
		initGrantDialog();
	}

	function initGrantDialog() {
		$('#title').text('권한 일괄부여');
		$('#authUserPop_table, #authUserPop_table_wrapper table').removeClass('no-checkbox');
		$('#authUserPop_table colgroup col').last().show();
		
		var mode = $('#mode').val();
		switch(mode) {
			case DAILOG_MODE.DETAIL:
				$('#title').text('권한 사용자 상세');
				$("#authUserSearchDiv").hide();
				$('#authUserPop_table, #authUserPop_table_wrapper table').addClass('no-checkbox');
				$('#authUserPop_table colgroup col').last().hide();
				break;
			case DAILOG_MODE.CREATE:
				$('#infoEmplId').val(null);
				$("#authUserSearchDiv").show();
				break;
			default :
				break;				
		}
		$('#popupAuthGrant').popup('show');

        <%-- 20221214 검색어 초기화 --%>
        $('#popupAuthGrant #searchWord').val('');
		
		authUserDataTable.reload();
		authMgmtDataTable.reload();

		authUserGrid.reload(); // 권한 사용자 부여 테이블 초기화	
	}
</script>
<!-- // 현재 페이지에 필요한 js -->