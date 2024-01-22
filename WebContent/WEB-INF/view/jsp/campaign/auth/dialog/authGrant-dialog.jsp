<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
	.modalPopup .wrap_box_nsend .col3:first-child {width:57%}
	.modalPopup .wrap_box_nsend .col3:last-child {width:40%}
	/*.modalPopup .wrap_box_nsend .col3 {padding:0 15px}*/
	
	/* 기존 css 덮어쓰기 */
	.btn-bg-main{color:#fff !important}
	
	/* 사용자 선택 - checkbox*/
	.checkbox_default label {padding : 0 0 0 23px !important;line-height: 14px !important;padding-left: 23px !important;vertical-align: middle !important;}
	input[type="checkbox"] + label:before, input[type="radio"] + label:before {color:#333; border:0px solid #333}
	/* 사용자 선택 - checkbox thead-tr-checked */
	.tbl_list tr.selected {background-color:#e2e7eb !important}
	
	.table>tbody>tr:first-child>td {border-top:none}
	.table thead th:first-child, .table tbody td:first-child {display: revert}
	.table.no-checkbox thead th:first-child, .table.no-checkbox tbody td:first-child {display: none}
	
	.tbl_wrap_list_small2 .tbl_list thead th {border-bottom: none}
	
	#popupAuthGrant .btn-reset{display:none}
	#popupAuthGrant .dataTables_empty{border:none}
	#popupAuthGrant .wrap_box_nsend{height:530px; }
	
    
</style>

<!-- 주소록 관련 v1 css -->
<link rel="stylesheet" type="text/css" href="/static/css/default.css">
<!-- Datatable checkbox -->
<script type="text/javascript" src="/static/js/IbkDatatables-checkbox.js"></script>
<!-- selectbox -->
<script type="text/javascript" src="/static/js/dataTables.select.min.js"></script>
<link rel="stylesheet" type="text/css" href="/static/css/select.dataTables.min.css">

<div id="popupAuthGrant" class="modalPopup hide position-top" style="width: 900px">
	<div class="modal-header"><h1 id="title">권한 부여</h1></div>
	<div class="modal-body">
		<input type="hidden" id="infoEmplId" name="infoEmplId">
		<input type="hidden" id="mode">
	  <!-- wrap_box_nsend -->
	  <div class="wrap_box_nsend mgt20">
	    <!--  begin  사용자 선택 -->
	    <div class="col3 mgr20">
            <div class="clearfix">
            	<div class="title pull-left" style="height:30px;">권한 사용자</div>
            	<div id="authUserSearchDiv">
            		<a href="javascript:;" class="btn_default gray small mgl9 pull-right" id="authUsersearchBtn">검색</a>
            		<input class="small pull-right" id="searchWord" name="searchWord" type="text" name="" value="" placeholder="직원번호를 입력하세요" style="width:58%; height:30px">	
            	</div>
            </div>
            <div class="wrap_tab mgt10">
	            <div class="">
	              	<!-- table list -->
			        <div class="" style="" id="authUserPopDiv">
				        <table class="table" id="authUserPop_table" style="border-bottom:0px solid #c4c4c4; width:100%">
					        <colgroup>
								<col width="10%" />
								<col width="25%" />
								<col width="20%" />
								<col width="25%" />
								<col width="20%" />
					        </colgroup>
					        <thead>
					            <tr>
						            <th class=""> 
					               		<label class="check-container">&nbsp;
					                   		<input type="checkbox" id="authUserPop_table_select_all" name="select_all"/>
					                   		<span class="checkmark" ></span>
					                	</label>
				                	</th>
									<th>부서</th>						            	
									<th>직원번호</th>		
									<th>직원명</th>				            	
					            	<th>직책</th>
				              	</tr>
				            </thead>
				        </table> 
			        </div>
	              <!-- //table list -->
	            </div>
			</div>
	    </div>
	    <!--  end  사용자 선택 -->
	    
	    <!--  begin  권한 선택 -->
	    <div class="col3" >
	    	<div class="title" style="height:30px;">권한</div> <!--  권한 선택 -->
	    	<div class="wrap_tab mgt10">
        		<div>
		            <!-- <div class="">
		              <input class="small" id="searchAuthWord" type="text" name="" value="" placeholder="권한명을 입력하세요" style="width:50%;height:30px"><a href="javascript:;" class="btn_default gray small mgl9" id="btn_addrSearch">검색</a>
		            </div> -->
		            
		            <!-- table list -->
			        <div class="" id="authMgmtDiv"> <!-- mgt15 -->
				        <table class="table" id="authMgmt_table" style="border-bottom:0px solid #c4c4c4; width:100%">
					        <colgroup>
								<col width="10%" />
								<col width="40%" />
								<col width="50%" />
							</colgroup>
							<thead>
								<tr>
									<th class=""> 
					               		<label class="check-container">&nbsp;
					                   		<input type="checkbox" id="authMgmt_table_select_all" name="select_all"/>
					                   		<span class="checkmark" ></span>
					                	</label>
				                	</th>
									<th>권한ID</th>
									<th>권한명</th>
								</tr>
							</thead>
				        </table>
			        </div>
		              <!-- //table list -->
	            </div>
	    	</div>
	    </div>
	    <!--  begin  권한 선택 -->
	  </div>
	  <!-- //wrap_box_nsend -->
	  
	</div>

	<div class="modal-footer">
	   <a href="javascript:;" class="btn btn-border-sub1 popupAuthGrant_close" >닫기</a>
   	   <a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="grantBtn()">부여</a>
    </div>
</div>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">
	var authUserDataTable = new IbkDataTableCheckBox();
	var authMgmtDataTable = new IbkDataTableCheckBox();

	$(document).ready(function() {
		/* 사용자 선택 - 주소록  조회 */
		initAuthUserPop();

		/* 권한 선택 - 권한 생성 테이블 조회  */
		initAuthMgmtPop();
	});

	/* 권한 사용자 */
	function initAuthUserPop() {
		// 파라미터 셋팅
		var requestAuthUserParam = function(data) {
			data.perPage = authUserDataTable.perPage;
			data.currentPage = authUserDataTable.currentPage;
			data.searchEmplId = $("#searchWord").val();
			data.infoEmplId = $('#infoEmplId').val();
		};

		authUserDataTable.isPaging = false;
		authUserDataTable.initDataTable("authUserPop_table", "./authUserList",
				requestAuthUserParam, IbkAuthUserListColumn.columns,
				IbkAuthUserListColumn.columnDefs, 
				IbkAuthUserListColumn.select, function() {
					var mode = $('#popupAuthGrant #mode').val();
					if(mode == DAILOG_MODE.DETAIL) {
						setTimeout(function() {
							authUserDataTable.dataTable.rows(0).select();
						}, 100)
						
					}
				});
		
		generateSlimScroll('#authUserPopDiv .dataTables_scrollBody', { height: '441px', size: '6px',alwaysVisible: true}); //alwaysVisible: true  scrollbar 항상 보이게
	}

	// 권한사용자 > 검색 클릭 이벤트
	$("#authUsersearchBtn").click(function () {
		authUserDataTable.reload();
	});

	/* 권한 */
	function initAuthMgmtPop() {
		// 파라미터 셋팅
		var requestParam = function(data) {
			data.infoEmplId = $('#infoEmplId').val();
		};
		authMgmtDataTable.isPaging = false;
		authMgmtDataTable.initDataTable("authMgmt_table", "./authList",
				requestParam, IbkAuthMgmtListColumn.columns,
				IbkAuthMgmtListColumn.columnDefs, 
				IbkAuthMgmtListColumn.select, function(data) {
					if(data != null) {

						setTimeout(function() {
							$("#authMgmt_table tbody tr").each(function(idx, item) {
								if("Y" == data[idx].authGrantYn) {
									authMgmtDataTable.dataTable.rows(idx).select();
								}
							});
							// select all 체크
							updateDataTableSelectAllCtrl(authMgmtDataTable.dataTable);
						}, 100)
					}
				});

		generateSlimScroll('#authMgmtDiv .dataTables_scrollBody', { height: '441px', size: '6px',alwaysVisible: true}); //alwaysVisible: true  scrollbar 항상 보이게
	}

	// 부여 버튼이벤트
	function grantBtn() {
		// 체크된 권한 및 사용자 값
		var authArr = authMgmtDataTable.dataTable.select().rows('.selected').data();
		var userArr = authUserDataTable.dataTable.select().rows('.selected').data();

		// 상세 조회시 분기 처리
		var infoEmplId = $('#infoEmplId').val();
		var authSrc = '${pageContext.request.contextPath}/campaign/groupEmplAuthGrant';
		if(!str.isEmpty(infoEmplId)) {
			authSrc = '${pageContext.request.contextPath}/campaign/oneEmplAuthGrant';
			userArr.push({emplId : infoEmplId});
		}

		// 유효성 체크
		if(!userArr.length) {
			sweet.alert("사용자를 선택해주세요.");
			return false;
		}

		if(!authArr.length) {
			sweet.alert("권한을 선택해주세요.");
			return false;
		}

		// 파라미터 값 셋팅
		var authIdList = new Array();
		var emplIdList = new Array();
		for(var i=0; i<authArr.length; i++) {
			var authId = authArr[i].authId;
			authIdList.push(authId);
		}
		
		for(var i=0; i<userArr.length; i++) {
			var emplId = userArr[i].emplId;
			emplIdList.push(emplId);
		}

		var param = {
				authIdList: authIdList,
				emplIdList: emplIdList
		}

		// 부여
		grantAjax(param, authSrc);
	}

	// 권한부여ajax
	function grantAjax(param, authSrc) {
		$.ajax({
	        url: authSrc,
	        type: "POST",
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(param)
		}).done(function(data) {
			if("SUCCESS" == data.result) {
				sweet.alert("등록이 완료되었습니다.");
				$('#popupAuthGrant').popup("hide");
				authUserGrid.reload();	
			} else {
				sweet.alert("권한 부여 중 오류가 발생하였습니다.");	
			}
		}).fail(function(xhr) {
	      	sweet.alert("권한 부여 중 오류가 발생하였습니다.");
		});
	}
</script>