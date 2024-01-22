<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div id="popupAuthEmp" class="modalPopup hide position-top"
	style="width: 550px">
	<div class="modal-header">
		<h1>권한 사용자 등록</h1>
	</div>
	<div class="modal-body">
		<!-- begin Search -->
		<div class="row">
			<div class="search_area search_inner">
				<div class="inline-form search_field pdd-btm-15">
					<div class="mrg-right-10">
						<input class="form-control inline-block" placeholder="직원번호를 입력하세요." id="authEmpId"/>
					</div>
					<button class="btn btn-search btn-sm" onclick="authEmpSearch();">조회</button>
				</div>
			</div>
		</div>
		<!-- end Search  -->

		<!-- begin table -->
		<div>
			<div class="" id="authEmpDiv">
				<table class="table" id="authEmp_table" style="border-bottom:0px solid #c4c4c4; width:100%">
					<colgroup>
						<col width="" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th>부서</th>
							<th>직원명</th>
							<th>직원번호</th>
							<th>직책</th>
						</tr>
					</thead>
					<tbody>
						<tr>
			                <td colspan="12" style="height:50px;">
			                	<div class="nodata"><p>검색 결과가 없습니다.</p></div>
			                </td>
			            </tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- end Table -->
	<div class="modal-footer">
		<button class="btn btn-border-sub1 popupAuthEmp_close">닫기</button>
		<button class="btn btn-bg-main" onclick="authEmpRegistBtn();">등록</button>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		selectAuthEmpGrid();
	});

	// 사용자 검색 조회
	var authEmpGrid = IbkDataTableCheckBox();
	authEmpGrid.perPage = 999999;
	function selectAuthEmpGrid() {
		var param = function (data) {
		    data.perPage = authEmpGrid.perPage;
		    data.currentPage = authEmpGrid.currentPage;
		    data.searchEmplId = $("#authEmpId").val();
	    };
   		authEmpGrid.isPaging = false;
	    authEmpGrid.initDataTable("authEmp_table", "/campaign/authEmpList", param, 
	    		AuthEmpListColumn.columns, AuthEmpListColumn.columnDefs, AuthEmpListColumn.select);

	    generateSlimScroll('#authEmpDiv .dataTables_scrollBody', { height: '280px', size: '6px',alwaysVisible: true}); //alwaysVisible: true  scrollbar 항상 보이게
	}

	// 초기화
	function initAuthEmpSearch() {
		$("#authEmpId").val('');
	}
	
	// 검색
	function authEmpSearch() {
		authEmpGrid.currentPage = 1;
		authEmpGrid.reload();
	}

	// 사용자 등록 버튼
	function authEmpRegistBtn() {
		// 유효성 체크
		var row = authEmpGrid.dataTable.row(".selected").data();
		
		if(!row) {
			sweet.alert('사용자를 선택해주세요.');
			return false;
		}
		
		// 사용자 등록
		authEmpRegistAjax(row.emplId);
	}

	// 사용자 등록
	function authEmpRegistAjax(emplId) {
		//console.log("emplId", emplId);
		$.ajax({
            url: '${pageContext.request.contextPath}/campaign/saveAuthUser',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({emplId: emplId})
        }).done(function (data) {
            if(data.message) {
                sweet.alert(data.message);
                return false;
            }
            sweet.alert("등록이 완료되었습니다.");
            $('#popupAuthEmp').popup('hide');
            $("#searchBtn").click();
        }).fail(function (xhr) {
        	sweet.alert("권한 사용자 등록 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
        });
	}

	// 사용자검색팝업 > 목록보기버튼 이벤트
	$(document).on('click', '#authEmp_table_reset', function () {
		initAuthEmpSearch();
		authEmpSearch();
    });
</script>