<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatablesInSearch.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/usersearch-column.js"></script>
<!--popup-->
<div class="popup_wrap" id="search_popup_wrap" style="display:none">
  <!-- top -->
  <div class="top">
    <div class="title">직원 검색</div>
    <div class="btn_close"><a href="javascript:" onclick="popClose('#search_popup_wrap')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
  </div>
  <!-- //top -->
  <!-- content -->
  <div class="content_pop">
    <div class="table_top_pop"> <span>
      <select id="employee_search-word-type">
        <option value="empName">직원명</option>
        <option value="emplId">직원번호</option>
        <option value="BoCode">부서코드</option>
      </select>
      </span> <span>
      <input type="text" name="employee_search-word" value="" placeholder="입력하세요" id="employee_search-word" style="width:140px">
      </span> <span><a href="javascript:" id="search_in_search-btn" class="btn_search mgl5">조회</a></span> </div>
      <div style="height:40px"></div>
    <!-- table list -->
    <div class="tbl_wrap_list_pop" id="blank_view">
        <div style="height:200px;text-align:center;margin-top:100px">
            검색 조건에 맞춰서 검색해주세요.
        </div>
    </div>
    <div class="tbl_wrap_list_pop" id="table_view" style="display:none">
      <table class="tbl_list" id="search_data_table" style="width:100%">
        <colgroup>
        <col style="width:50px" />
        <col style="width:" />
        <col style="width:" />
        <col style="width:" />
        </colgroup>
        <thead>
          <tr>
            <th scope="col"></th>
            <th scope="col">이름</th>
            <th scope="col">직위</th>
            <th scope="col">직원번호</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>
    <!-- //table list -->
    <!-- 페이징 -->
    <div class="paging" id="searchpagination" style="display:none">
    </div>
  </div>
  <!-- //content -->

  <!-- footer -->
  <div class="footer_pop">
    <!-- button --><a href="javascript:" id="confirm_in_search-btn"  class="btn_big blue">확인</a><!-- //button -->
  </div>
  <!-- //footer -->
</div>
<!--//popup-->
<script>
    var firsttime = true;
    function userSearchInit(searchEmpName, isScrollPopup){
        if (isScrollPopup) {
          popOpenScroll("#search_popup_wrap");
        }else{
          popOpen("#search_popup_wrap");
        }
        if (searchEmpName != null && searchEmpName == "") {
            $("#employee_search-word-type").val("empName");
        	$("#employee_search-word").val(searchEmpName);	
        } else {
        	$("#employee_search-word-type").val("empName");
        	$("#employee_search-word").val("");
        }
        
        $("#employee_search-word").focus();

        if(firsttime){
            // datatables ajax 에서 사용 할 parameter 세팅
            // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
            var requestParamInSearch = function (data) {
                // 필수 변경 불가
                data.perPage = IbkDataTableInSearch.perPage;
                // 필수 변경 불가
                data.currentPage = IbkDataTableInSearch.currentPage;
                // 여기서 부터는 Custom 하게
                data.searchWordType = $("#employee_search-word-type").val();
                data.searchWord = $("#employee_search-word").val();
            };
            // datatables 세팅 모든 파라미터는 필수값
            IbkDataTableInSearch.initDataTable("search_data_table", "${pageContext.request.contextPath}/employee", requestParamInSearch,IbkContentsColumnInSearch.columns, IbkContentsColumnInSearch.columnDefs);
            datagridTrColorChanger("#search_data_table");

            $("#blank_view").hide();
            $("#table_view").show();
            $("#searchpagination").show();


            var table = $('#search_data_table').DataTable();
            $('#search_data_table tbody').on( 'click', 'tr', function () {
                var $_checkbox = $(this).children().find( "input" );
            	var $_checked = $_checkbox.prop('checked');
            	
                $('.search-dt-check-box').prop("checked", false);
               if ($_checked) {
                    $_checkbox.prop("checked",false);
               }else{
                    $_checkbox.prop("checked",true);
               }
            } );
            
        }else{
            search_employee();
        }
        firsttime = false;
    }

    // 조회 버튼 클릭 이벤트 리스너
    $("#search_in_search-btn").on('click',search_employee);

    // 엔터키 이벤트 리스너
    $("#employee_search-word").keypress(function (event) {
        if (event.which == 13) {
            event.preventDefault();
            search_employee();
        }
    });

    function search_employee(){
        IbkDataTableInSearch.currentPage = 1;
        IbkDataTableInSearch.reload();
    }


    $("#confirm_in_search-btn").on('click',function(){
        var checkedCount = $(".search-dt-check-box:checked").length;
        if(checkedCount === 1){
            var data = IbkDataTableInSearch.dataTable.row($(".search-dt-check-box:checked").val()).data();
            $("#emplId").val(data.emplId);
            $("#emplName").val(data.emplName);
            $("#emplPosition").val(data.emplPosition);
            $("#boCode").val(data.boCode);
            $("#partName").val(data.partName);
            popClose('#search_popup_wrap');
        }else{
            showAlert("검색결과 중 한명을 선택하세요.");
        	$("#alert-modal").parent().css({
        	    'z-index':10000000
        	});
        }
    });


    function checkingEmployee(){
//       $('.search-dt-check-box').prop("checked", false);
    }



</script>