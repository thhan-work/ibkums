<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatatables-template.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datatable-column/alimTalkTemplate-column.js"></script>

  <!-- begin page-header -->
  <div class="page-header">
    알림톡 템플릿
    <ol class="breadcrumb pull-right"></ol>
  </div>
  <!-- end page-header -->

  <!-- begin Search -->
  <div class="row">
    <div class="search_area">
      <div class="search_field">
        <label>상태</label>
        <div>
          <select id="statusType">
            <option value="">전체</option>
            <option value="저장">저장</option>
            <!-- <option value="">승인대기</option> -->
            <!-- <option value="">처리중</option> -->
            <!-- <option value="">반려</option> -->
            <option value="승인완료">승인완료</option>
            <!-- <option value="">처리중(삭제)</option> -->
          </select>
        </div>
      </div>
      <div class="search_field no-mrg-right">
        <label>검색어</label>
        <div class="mrg-right-10">
          <select id="searchWordType">
            <option value=tmplNm>템플릿명</option>
            <option value="kkoTmplCd">템플릿ID</option>
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

<!--  수동일 경우 등록도 필요할 꺼같음. -->  
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
          <col width="200" />
          <col width="200" />
          <col width="100" />
          <col width="100" />
          <col width="100" />
          <col width="100" />
          <col width="80" />
        </colgroup>
        <thead>
	        <tr>
	          <th>No.</th>
	          <th>템플릿ID</th>
	          <th>템플릿명</th>
	          <th>등록자</th>
	          <th><div class="table-header">등록일</div></th>
	          <th>상태</th>
	          <th><div class="table-header">승인일</div></th>
	          <th>사용</th>
	        </tr>
        </thead>
        <!-- <tbody>
        <tr data-popup="popupTemplate">
          <td>1</td>
          <td class="text-left">ABC_1a234_abc</td>
          <td>템플릿명입니다</td>
          <td>홍길동</td>
          <td>2021-09-07</td>
          <td>저장</td>
          <td>-</td>
          <td>-</td>
        </tr>
        <tr data-popup="popupTemplateView">
          <td>2</td>
          <td class="text-left">ABC_1a234_abc</td>
          <td>템플릿명입니다</td>
          <td>홍길동</td>
          <td>2021-09-07</td>
          <td>저장</td>
          <td>-</td>
          <td>사용</td>
        </tr>
        </tbody>  -->
      </table>
    </div>
    <!--  <div class="text-center">
      <ul class="twbsPagination"></ul>
    </div>  -->
  </div>
  <!-- end table -->
<!-- end 알림톡 템플릿 -->



<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">
  var  ibkDataTableTemplate = IbkDataTableTemplate();
 
  $(document).ready(function() {
	  dataTableGrid = ibkDataTableTemplate;
	  
	  var requestParam = function(data) {
		  // 필수 변경 불가
			data.perPage = ibkDataTableTemplate.perPage;
			// 필수 변경 불가
			data.currentPage = ibkDataTableTemplate.currentPage;

			data.statusType = $('#statusType option:selected').val();
			
			data.searchWordType = $('#searchWordType option:selected').val();
			data.searchWord = $('#searchWord').val();

			// 정렬시 사용
			data.orderType = ibkDataTableTemplate.orderType;
			data.orderName = ibkDataTableTemplate.orderName;
			
		};

		ibkDataTableTemplate.initDataTable("dataTable", "./alimTalkTemplate/list",
			requestParam, IbkAlimTalkTemplateListColumn.columns,
			IbkAlimTalkTemplateListColumn.columnDefs);
		// 초기 정렬 설정
		ibkDataTableTemplate.dataTable.order([ 4, 'desc' ]);

		// 그리드 안 이벤트
		$('#dataTable tbody').on('click','tr', function(e) {
			// 목록보기 초기화
			if(e.target.id.indexOf('dataTable_reset') != -1 ) {
				commonFunc.reset();
				return
			}
			
			var data = ibkDataTableTemplate.dataTable.row($(this)).data();
			
			data.title = DAILOG_MODE.DETAIL;
			if(data.kkoTmplCd == null) {
				data.title= DAILOG_MODE.CREATE;	
			}
			alimFunc.setData(data);
			
			e.stopImmediatePropagation();
		});
  });

	function openDialog() {
		// 등록일 경우
		var data = {};
		data.title = DAILOG_MODE.CREATE;
		alimFunc.setData(data);
	}


</script>
<!-- // 현재 페이지에 필요한 js -->

<jsp:include page="./dialog/alimTalk-detail.jsp" flush="true" />
<jsp:include page="./dialog/alimTalk-dialog.jsp" flush="true" />