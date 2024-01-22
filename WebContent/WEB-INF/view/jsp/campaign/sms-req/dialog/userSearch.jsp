<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div id="popupUserSearch" class="modalPopup hide position-top"
	style="width: 500px">
	<div class="modal-header">
		<h1>승인자 검색</h1>
	</div>
	<div class="modal-body">
		<!-- begin Search -->
		<div class="row">
			<div class="search_area search_inner">
				<div class="inline-form search_field pdd-btm-15">
					<label class="font-weight-light mrg-right-10">팀원 선택</label>
					<div class="mrg-right-10">
						<input class="form-control inline-block" placeholder="이름을 입력하세요" id="approvalNm"/>
					</div>
					<button class="btn btn-search btn-sm" onclick="userSearch();">검색</button>
				</div>
			</div>
		</div>
		<!-- end Search  -->

		<!-- begin table -->
		<div class="">
			<div class="table-result">
				총 <strong class="split" id="userSearch_table_total_cnt">0</strong> 
				<select class="search-limit" id="userSearch_table_per_page">
					<option value="5">5개씩 보기</option>
					<option value="10">10개씩 보기</option>
					<option value="20">20개씩 보기</option>
					<option value="30">30개씩 보기</option>
				</select>
			</div>
			<div class="table-responsive" id="userSearchDiv">
				<table class="table table-hover" id="userSearch_table">
					<colgroup>
						<col width="20px" />
						<col width="90px" />
						<col width="60px" />
						<col width="80px" />
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>부서</th>
							<th>직원번호</th>
							<th>이름</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- end Table -->
	<div class="modal-footer">
		<button class="btn btn-border-sub1 popupUserSearch_close">닫기</button>
		<button class="btn btn-bg-main" onclick="userSearchConfirm();">확인</button>
	</div>
</div>
<style>
	#userSearchDiv .table>tbody>tr:first-child>td {border-top:none}
</style>
<script type="text/javascript">
	$(document).ready(function () {
		// 승인자검색팝업
		getUserSearchAjax();
	});

	// 승인자 검색 조회
	var userSearchGrid = new IbkDataTableNew();
	function getUserSearchAjax() {
		var requestParam = function (data) {
		    data.perPage = userSearchGrid.perPage || 5;
		    data.currentPage = userSearchGrid.currentPage;
		    data.searchWordType = 'empName';
		    data.searchWord = $("#approvalNm").val();
		    data.positionNm = $("#positionNm").val();
	    };
	    userSearchGrid.isPaging = false;
	    userSearchGrid.initDataTable("userSearch_table", "/campaign/smsreq/employee", requestParam, 
				UserSearchColumn.columns, UserSearchColumn.columnDefs, null, {selectMulti: 'single', scrollY: '220px'});

    	generateSlimScroll('#userSearchDiv .dataTables_scrollBody', { height: '220px', size: '6px', alwaysVisible: true});
	}

	//rcs템플릿 초기화
	function initUserSearch() {
		$("#approvalNm").val('');
	}
	
	// 검색
	function userSearch() {
		userSearchGrid.currentPage = 1;
		userSearchGrid.reload();
	}

	// 확인 버튼 클릭
	function userSearchConfirm() {
		var row = userSearchGrid.dataTable.row(".selected").data();
		
		if(!row) {
			sweet.alert('승인자를 선택해주세요.');
			return false;
		}
		
		// 승인자 추가시, 승인자 중복체크 
		var isInvalid = false;
		if($userSrchTgt.hasClass('testSender')) {
			isInvalid = [].some.call($("#testSendInfo .confirm-emp-id"), function(el) {
			    return $(el).val() === row.emplId;
			});
		} else {
			isInvalid = [].some.call($("#approvalDiv .confirm-emp-id"), function(el) {
			    return $(el).val() === row.emplId;
			});
		}
		if(isInvalid) {
			sweet.alert('이미 선택된 승인자입니다.<br>다른 승인자를 선택해주세요.');
			return false;
		}

		// 승인자 값 셋팅
		$userSrchTgt.val(row.partName + " / " + row.emplName).trigger("input");
		$userSrchTgt.parent().find(".confirm-emp-id").remove();
		$userSrchTgt.before('<input type="hidden" class="confirm-emp-id" value="'+ row.emplId +'" data-emplhpno="'+ row.emplHpNo +'">');
		$('#popupUserSearch').popup('hide');
	}

	// 승인자팝업 > 체크박스 단일선택 기능 
	function clickCheck(target) {
	    $("input[name=userSelectChk]").each(function(index, item){
	    	item.checked = false;
	    });
	    target.checked = true;
	}

	// 사용자검색팝업 > 목록보기버튼 이벤트
	$(document).on('click', '#userSearch_table_reset', function () {
		initUserSearch();
		userSearch();
    });
</script>