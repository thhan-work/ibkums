<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script type="text/javascript" src="/static/js/IbkDatatables-template.js"></script>
<script type="text/javascript" src="/static/js/datatable-column/rcsTemplate-column.js"></script>
<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	table {width:100% !important;}
	/* table td ... 처리 */
	table {table-layout: fixed;}
	table .text-overflow {white-space:nowrap; text-overflow:ellipsis; overflow:hidden;}
</style>

<!-- begin page-header -->
<div class="page-header">
	RCS 템플릿
	<ol class="breadcrumb pull-right"></ol>
</div>
<!-- end page-header -->

<!-- begin RCS 템플릿 -->
<!-- begin Search -->
<div class="row clearfix">
	<div class="search_area">
		<div class="search_field">
			<label>템플릿 속성</label>
			<div>
				<select id="cardType" onchange="changeCardType(this)" style="width:130px">
					<option value="">전체</option>
					<option value="description">서술(description)</option>
					<option value="cell">스타일(cell)</option>
				</select>
			</div>
		</div>
		<div class="search_field">
			<label>유형</label>
			<div>
				<select id="cmbBizServiceDesc1" name="bizServiceType">
                   <option value="">전체</option>
                 </select>
                 <select id="cmbBizServiceCell1" name="bizServiceType">
                   <option value="">전체</option>
                 </select>
			</div>
		</div>
		<div class="search_field">
			<label>상태</label>
			<div>
				<select id="statusType" style="width: 105px">
					<option value="">전체</option>
					<option value="저장">저장</option>
					<option value="승인대기">승인대기</option>					
					<!-- <option value="승인요청 중">처리중</option>  -->
					<option value="승인요청 중">승인요청 중</option>
					<option value="반려">반려</option>
					<option value="승인요청 실패">승인요청 실패</option>
					<option value="승인">승인완료</option>
					<!-- <option value="">처리중(삭제)</option>  -->
				</select>
			</div>
		</div>
	</div>
	<div class="search_area">
		<div class="search_field no-mrg-right">
			<label>검색어</label>
			<div class="mrg-right-10">
				<select id="searchWordType">
					<option value="msgbaseNm">템플릿명</option>
					<option value="msgbaseId">템플릿ID</option>
					<option value="regUserNm">등록자</option>
				</select>
			</div>
		</div>
		<div class="search_field width300">
			<input type="text" id="searchWord" class="form-control" placeholder="검색어를 입력하세요" />
		</div>
		<div class="search_field">
			<button class="btn btn-reset btn-sm" onclick="commonFunc.reset()">초기화</button>
			<button class="btn btn-search btn-sm" onclick="commonFunc.search()">검색</button>
		</div>
	</div>
</div>
<!-- end Search  -->

<div class="row clearfix">
  <div class="pull-right">
    <button class="btn btn-create" onclick="openDialog()">등록</button>
  </div>
</div>

<!-- begin table -->
<div class="row">
	<div class="table-result">
		총 <strong class="split" id="dataTable_total_cnt">0</strong> 
		<select
			class="search-limit" id="dataTable_per_page">
			<option value="10">10개씩 보기</option>
			<option value="20">20개씩 보기</option>
			<option value="30">30개씩 보기</option>
		</select>
	</div>
	<div class="table-responsive">
		<table id="dataTable" class="table table-hover table-cursor">
			<colgroup>
				<col width="80" />
				<col width="300" />
				<col width="200" />
				<col width="150" />
				<col width="80" />
				<col width="100" />
				<col width="120" />
				<col width="80" />
				<col width="120" />
				<col width="120" />
			</colgroup>
			<thead>
				<tr>
					<th>No.</th>
					<th>템플릿ID</th>
					<th>템플릿명</th>
					<th>템플릿 속성</th>
					<th>유형</th>
					<th>등록자</th>
					<th><div class="table-header">등록일</div></th>
					<th>상태</th>
					<th>사유</th>
					<th><div class="table-header">승인일</div></th>
					<!-- <th>사용</th> -->
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
<!-- end RCS 템플릿 -->


<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">
	var  ibkDataTableTemplate = IbkDataTableTemplate();

	$(document).ready(function() {
		// datatables ajax 에서 사용 할 parameter 세팅
		// 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
		var requestParam = function(data) {
			// 필수 변경 불가
			data.perPage = ibkDataTableTemplate.perPage;
			// 필수 변경 불가
			data.currentPage = ibkDataTableTemplate.currentPage;
			// 정렬시 사용
			data.orderType = ibkDataTableTemplate.orderType;
			data.orderName = ibkDataTableTemplate.orderName;

			data.cardType = $('#cardType').val();
			data.bizServiceType = $('select[name=bizServiceType]:visible option:selected').val();
			data.statusType = $('#statusType option:selected').val();
			
			data.searchWordType = $('#searchWordType option:selected').val();
			data.searchWord = $('#searchWord').val();
		};

		dataTableGrid = ibkDataTableTemplate;

		ibkDataTableTemplate.initDataTable("dataTable", "./rcsTemplate/list",
				requestParam, IbkRcsTemplateListColumn.columns,
				IbkRcsTemplateListColumn.columnDefs);

		// 초기 정렬 설정
		ibkDataTableTemplate.dataTable.order([ 6, 'desc' ]);

		$('select[name=bizServiceType]').attr("disabled", true);
		$('#cmbBizServiceCell1').hide();

		// 그리드 안 이벤트
		$('#dataTable tbody').on('click','tr', function(e) {
			// 목록보기 초기화
			if(e.target.id.indexOf('dataTable_reset') != -1 ) {
				commonFunc.reset()
				return
			}
			
			var data = ibkDataTableTemplate.dataTable.row($(this)).data();

			data.title = DAILOG_MODE.DETAIL;
			if(data.msgbaseId == null) {
				data.title= DAILOG_MODE.CREATE;	
			} else if(data.apprResult =='반려') {
				data.title= DAILOG_MODE.UPDATE;
			}
			rcsFunc.setData(data);
			
			e.stopImmediatePropagation();
		});
	});

	function changeCardType(e) {
		$('select[name=bizServiceType]').hide();
		$('select[name=bizServiceType]').attr("disabled", false);

		// 기본 서술(description)의 유형을 보여주되, "전체"일 경우엔 disabled 처리함.
		switch(e.value) {
			case CARD_TYPE.DESC :
				$('#cmbBizServiceDesc1').show();			
				break;
			case CARD_TYPE.CELL :
				$('#cmbBizServiceCell1').show();
				break;
			default :
				$('#cmbBizServiceDesc1').show();
				$("#cmbBizServiceDesc1 option:eq(0)").prop("selected", true);
				$('select[name=bizServiceType]').attr("disabled", true);
				break;
		}
	}

	function openDialog() {
		// 등록일 경우
		var data = {};
		data.title = DAILOG_MODE.CREATE;
		rcsFunc.setData(data);
	}

		
</script>
<!-- // 현재 페이지에 필요한 js -->
<jsp:include page="./dialog/rcsTemplate-detail.jsp" flush="true" />
<jsp:include page="./dialog/rcsTemplate-dialog.jsp" flush="true" />

