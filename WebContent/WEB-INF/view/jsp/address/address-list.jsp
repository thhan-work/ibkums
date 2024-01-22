<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>${title}
</h3>
<!-- content -->
      <div id="content">
		<div>
			<a href="javascript:;" class="btn_default blue" 			id="add-btn"		> 그룹추가		</a>
			<a href="javascript:;" class="btn_default" 					id="mod-btn"	> 수정			</a>
        	<a href="javascript:;" class="btn_default delete" 		id="del-btn"		> 삭제			</a>
			<a href="javascript:;" class="btn_default question fr" 	id="help-btn"	> 도움말			</a>
		</div>
        <!-- table list -->
        <div class="table_top"> 총 <span id="total_cnt">0</span>건
	        <span class="num">
	            <select id="per-page">
	                <option value="10">10</option>
	                <option value="20">20</option>
	                <option value="30">30</option>
	            </select>
	        </span>
    	</div>
    	
        <div class="tbl_wrap_list">
          <table class="tbl_list" id="all_address_table" summary="전체 주소록 테이블입니다.">
            <caption>전체주소록 테이블</caption>
            <colgroup>
            <col style="width:70px;" />
            <col style="width:" />
            <col style="width:450px" />
            <col style="width:" />
            <col style="width:" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col">
                	<div class="checkbox_center">
                    	<input type="checkbox" id="select-all" />
                    	<label for="select-all"></label>
                  	</div>
                </th>
                <th scope="col">그룹명(등록인원수)</th>
                <th scope="col">그룹설명</th>
                <th scope="col">소유자</th>
                <th scope="col">개인/공유</th>
              </tr>
            </thead>
          </table>
        </div>
        <!-- //table list --> 
	    <!-- 페이징 -->
	    <div class="paging" id="pagination"></div>
	    <!-- //페이징 -->
      </div>
      <!-- //content --> 
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="./address-dialog.jsp" flush="true"/>
<!-- 도움말 다이얼로그 -->
<jsp:include page="../help/address-help.jsp" flush="true"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkValidation.js">		</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkInitData.js">			</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js">		</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js">	</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatatables.js">		</script>
<!-- Script -->
<!-- Datatables Column Definition-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datatable-column/address-column.js"></script>

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

    };

    // datatables 세팅 모든 파라미터는 필수값
   	IbkDataTable.initDataTable("all_address_table", "${pageContext.request.contextPath}/addressType/${addressType}", requestParam,IbkAddressColumn.columns, IbkAddressColumn.columnDefs);

  });

  // 페이지당 조회 카운트 변경 이벤트 리스너
  $("#per-page").on('change', function () {
    IbkDataTable.perPage = $(this).val();
    IbkDataTable.currentPage = 1;
    IbkDataTable.reload();
  });
  
  // 전체 체크박스 클릭 이벤트 리스너
  // datatables 의 모든 셀렉트 박스가 선택 된다.
  $('#select-all').on('click', function () {
    // Get all rows with search applied
    var rows = IbkDataTable.dataTable.rows({'search': 'applied'}).nodes();
    // Check/uncheck checkboxes for all rows in the table
    $('input[type="checkbox"]', rows).prop('checked', this.checked);
  });
  //그룹 추가 버튼 클릭 시
  $("#add-btn").on('click', function () {
	  showAddPopUp(redirectList);
  });
  
  // 수정 버튼 클릭 처리
  $(document).on('click', "#mod-btn", function () {
		var count = 0;
		var grpSeq = "";
		var emplId = "";
		var rowData = new Array();
		var checkbox = $("input[name=grpSeq-Ck]:checked");
		var data=null;
		checkbox.each(function(i) {
			 var  f=checkbox[i].parentNode.parentNode.parentNode;
		     data = IbkDataTable.dataTable.row(f).data();
		     grpSeq=data.grpSeq;
		     emplId=data.emplId;
		     count++;
		});

	    if (count > 1) {
	      	showAlert("수정할 그룹을 하나만 선택해 주세요");
	      	return false;
	    }
	    if(grpSeq == "" || grpSeq == null){
	    	showAlert("수정할 그룹이 선택되지 않았습니다");
	    	return false;
	    }
	    //로그인 시 세션객체에 EMPL_ID 속성 값 등록
	    if(emplId != '${EMPL_ID}'){
	    	showAlert("그룹명, 그룹설명은 소유자만 수정할 수 있습니다. 주소록 내용 편집은 그룹명을 직접 클릭하세요");
	    	return false;
	    }
	    showModPopUp(redirectList,data);	
	    
	  });
  
  //삭제 버튼 클릭 처리
  $(document).on('click', "#del-btn", function () {
		var count = 0;
		var rowData = new Array();
		var checkbox = $("input[name=grpSeq-Ck]:checked");
		var data=null;
	
		checkbox.each(function(i) {
			 var  f=checkbox[i].parentNode.parentNode.parentNode;
		     data = IbkDataTable.dataTable.row(f).data();
		     //console.log(data);
			 rowData.push(data);
		     count++;
		});
		
	    if (count < 1) {
	      	showAlert("삭제할 그룹을 하나 이상 선택해 주세요");
	      	return false;
	    }
		var confirmMessage = "총 " + rowData.length + "건 삭제 하시겠습니까?";
		showConfirmForAjax(confirmMessage, deleteAddress, rowData);
	    
	  });
  function deleteAddress(deleteTarget) {
	  //console.log(deleteTarget.length);
	    if (deleteTarget.length > 0) {
	      $.ajax({
	        url: '${pageContext.request.contextPath}/address',
	        type: 'DELETE',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(deleteTarget),
	        success: function (result) {
	          showAlert("삭제 하였습니다.");
	          IbkDataTable.reload();
	        }
	      });
	    }
	  }
 
  //도움말 버튼 클릭 시 
  $("#help-btn").on('click', function() {
	  var type = '${title}';
	  if(type == '전체주소록'){
		  showHelpAlert_all();
	  }else {
		  showHelpAlert_person();
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
 

  
  function redirectList() {
	    /* setTimeout(function () {
	      window.location.href = "${pageContext.request.contextPath}/all-address.ibk";
	    }, 100); */
  }
</script>
