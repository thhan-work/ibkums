<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script type="text/javascript" src="/static/js/IbkDatatables-template.js"></script>
<script type="text/javascript" src="/static/js/datatable-column/rcsBrand-column.js"></script>
<script type="text/javascript" src="/static/js/datatable-column/rcsBrandChatbot-column.js"></script>
<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	.second-title {color:#333333;font-weight:600;}
	/* .table-hover>tbody>tr.active:hover>td{background-color:#eef7ff !important}  브랜드 선택값 스타일  */
	.table{width:100% !important}
</style>
<!-- begin page-header -->
<div class="page-header">
	RCS 브랜드/발신번호
	<ol class="breadcrumb pull-right"></ol>
</div>
<!-- end page-header -->

<!-- begin RCS 브랜드 -->
<!-- begin Search -->
<div class="row clearfix">
	<div class="search_area">
		<div class="search_field no-mrg-right">
			<label>검색어</label>
			<div class="mrg-right-10">
				<select class="width100" id="searchWordType">
					<option value="brNm">브랜드명</option>
					<option value="subTitle">발신번호명</option>
					<option value="callNum">발신번호</option>
				</select>
			</div>
		</div>
		<div class="search_field width300">
			<input type="text" id="searchWord" class="form-control" placeholder="검색어를 입력하세요" />
		</div>
		<div class="search_field">
			<button class="btn btn-reset btn-sm" onclick="reset()">초기화</button>
			<button class="btn btn-search btn-sm" onclick="search()">검색</button>
		</div>
	</div>
</div>
<!-- end Search  -->

<div class="row clearfix">
	<div class="pull-left second-title font-size-16">
		RCS 브랜드
	</div>
	<!-- <div class="pull-right">
		<button class="btn btn-create" onclick="openDialog('brand')">등록</button>
	</div> -->
</div>

<!-- begin table -->
<div class="row">
	<div class="table-result">
		총 <strong class="split" id="rcsBrandTable_total_cnt">0</strong> 
		<select
			class="search-limit" id="rcsBrandTable_per_page">
			<option value="10">10개씩 보기</option>
			<option value="20">20개씩 보기</option>
		</select>
	</div>
	<div class="table-responsive">
		<table id="rcsBrandTable" class="table table-hover table-cursor">
			<colgroup>
				<col width="80" />
				<col width="200" />
				<col width="200" />
				<col width="80" />
				<col width="80" />
				<col width="120" />
				<col width="120" />
				<!-- <col width="50" />  -->
			</colgroup>
			<thead>
				<tr>
					<th>No.</th>
					<th>브랜드ID</th>
					<th>브랜드명</th>
					<th>상태</th>
					<th>사용여부</th>
					<th><div class="table-header">요청일</div></th>
					<th><div class="table-header">승인일</div></th>
					<!-- <th>상세</th> --> <!-- 22.09.22 리스트와 상세목록  차이가 없어 제외 -->
				</tr>
			</thead>
			<!-- <tbody id="dataGrid"></tbody> -->
		</table>
	</div>
	<!-- <div class="text-center">
		<ul class="twbsPagination"></ul>
	</div> -->
</div>
<!-- end table -->
<!-- end RCS 브랜드 -->

<div class="row clearfix">
	<div class="pull-left second-title font-size-16">
		발신번호
	</div>
	<!-- <div class="pull-right">
		<button class="btn btn-create" onclick="openDialog('chatbot')">등록</button>
	</div> -->
</div>

<!-- begin table -->
<div class="row">
	<div class="table-result">
		총 <strong class="split" id="chatbotTable_total_cnt">0</strong> 
		<select
			class="search-limit" id="chatbotTable_per_page">
			<option value="10">10개씩 보기</option>
			<option value="20">20개씩 보기</option>
		</select>
	</div>
	<div class="table-responsive">
		<input type="hidden" id="brId" name="brId" >
		<input type="hidden" id="brNm" name="brNm" >
		<table id="chatbotTable" class="table table-hover table-cursor">
			<colgroup>
				<col width="50" />
				<col width="150" />
				<col width="150" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
				<!-- <col width="50" />  -->
			</colgroup>
			<thead>
				<tr>
					<th>No.</th>
					<th>발신번호명</th>
					<th>발신번호</th>
					<th>대표번호여부</th>
					<th>전시상태</th>
					<th>상태</th>
					<th><div class="table-header">등록일</div></th>
					<th><div class="table-header">승인일</div></th>
					<th>등록자</th>
					<!-- <th>상세</th> --> <!-- 22.09.22 리스트와 상세목록  차이가 없어 제외 -->
				</tr>
			</thead>
			<!-- <tbody id="dataGrid"></tbody> -->
		</table>
	</div>
	<!-- <div class="text-center">
		<ul class="twbsPagination"></ul>
	</div> -->
</div>
<!-- end table -->
<!-- end RCS 챗붓(발신번호) -->

<div class="row clearfix">
	<div class="pull-left second-title font-size-13" style="color:red">
		*RCS BIZ CENTER에 등록된 브랜드/발신번호만 조회 가능합니다.
	</div>
</div>

<jsp:include page="./dialog/rcsBrand-dialog.jsp" flush="true" />
<jsp:include page="./dialog/rcsBrandChatbot-dialog.jsp" flush="true" />

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">

	var ibkDataTableRcsBrand = IbkDataTableTemplate();
	var ibkDataTableChatbot = IbkDataTableTemplate();

	$(document).ready(function() {
		// datatables ajax 에서 사용 할 parameter 세팅
		// 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
		/* RCS 브랜드 관리 */
		var requestParam = function(data) {
			// 필수 변경 불가
			data.perPage = ibkDataTableRcsBrand.perPage;
			// 필수 변경 불가
			data.currentPage = ibkDataTableRcsBrand.currentPage;

			data.searchWordType = $('#searchWordType option:selected').val();
			data.searchWord = $('#searchWord').val();
		};

		dataTableGrid = ibkDataTableRcsBrand;

		// RCS 브랜드 조회
		ibkDataTableRcsBrand.initDataTable("rcsBrandTable", "./rcsBrand/list",
				requestParam, IbkRcsBrandListColumn.columns,
				IbkRcsBrandListColumn.columnDefs);
		// 초기 정렬 설정
		//ibkDataTableRcsBrand.dataTable.order([ 5, 'desc' ]);

		// 페이징과 순번처리
		commonFunc.initTable();

		/* 챗북(발신번호)  */
		var requestParam2 = function(data) {
			// 필수 변경 불가
			data.perPage = ibkDataTableChatbot.perPage;
			// 필수 변경 불가
			data.currentPage = ibkDataTableChatbot.currentPage;
			data.searchWordType = $('#searchWordType option:selected').val();
			data.searchWord = $('#searchWord').val();
			
			data.brId = $('#brId').val();
		};
		// 챗붓(발신번호) 조회
		ibkDataTableChatbot.initDataTable("chatbotTable", "./rcsBrand/chatbot",
				requestParam2, IbkRcsBrandChatbotListColumn.columns,
				IbkRcsBrandChatbotListColumn.columnDefs);
		
		// 초기 정렬 설정
		//ibkDataTableChatbot.dataTable.order([ 6, 'desc' ]);
		
		// 브랜드 그리드 안 이벤트 - 브랜드의 해당된 챗북(발신번호) 조회
		$('#rcsBrandTable tbody').on('click','tr', function(e) {
			// 목록보기 초기화
			if(e.target.id.indexOf('_reset') > 0 ) {
				reset();
				return
			}

			$('#rcsBrandTable tbody tr').removeClass()
			
			var data = ibkDataTableRcsBrand.dataTable.row($(this)).data();
			if(data != null) {
				$('#brId').val(data.brId);
				$('#brNm').val(data.brNm);
			}
			
			//선택한 브랜드의 챗북(발신번호) 조회
			chatbotFunc.search();

			// 선택한 브랜드의 스타일 표시
			$(e.currentTarget).addClass('active')
			
			e.stopImmediatePropagation();
		});
		
		search();
		
	});
	function search(){
		ibkDataTableRcsBrand.reload();
		searchChatbot()
	}

	function reset() {
		commonFunc.reset()
		searchChatbot()
	}

	function searchChatbot() {
		setTimeout( function(){
			var dataTableCnt = ibkDataTableRcsBrand.dataTable.rows().count(); // RCS 브랜드 데이터 갯수 확인
			if(dataTableCnt > 0) {
				// 데이터 존개함 - 최초 챗붓(발신번호)는 브랜드 첫번째의 챗붓(발샌번호) 조회
				var brandFirstRow = $('#rcsBrandTable tbody tr')[0];
				$(brandFirstRow).click();
			} else {
				// 데이터 존재안함-키값 NULL 처리
				$('#brId').val(null);
				chatbotFunc.search();
			}
			
			// 값 없는 테이블 간격 조절
			$('.table-no-search').removeClass('pdd-btm-100 pdd-top-100').addClass('pdd-btm-50 pdd-top-50');
		},500)
	}
	
	// 상세화면 
	function openDetail(e, type) {
		//if(e.className.indexOf('btn') == 0) return;
		var tr = $(e.parentElement.parentElement);
		var data; 
		if(type =='brand') {
			data = ibkDataTableRcsBrand.dataTable.row(tr).data();
			data.title = DAILOG_MODE.DETAIL;
			brandFunc.setData(data);
			tr.addClass('active');
		} else {
			data = ibkDataTableChatbot.dataTable.row(tr).data();
			data.title = DAILOG_MODE.DETAIL;
			chatbotFunc.setData(data);
		}
	}

	function openDialog(type) {
		var data = {};
		data.title = DAILOG_MODE.CREATE;
		if(type == 'brand') {
			brandFunc.setData(data);
		} else {
			chatbotFunc.setData(data);
		}
	}

</script>
<!-- // 현재 페이지에 필요한 js -->

