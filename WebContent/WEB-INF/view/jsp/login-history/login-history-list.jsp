<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>로그인 이력 조회
</h3>
<!-- content -->
<div id="content">
	<!-- Search -->
    <div class="box_search01">
      <ul>
        <li>
			<span class="title02">로그인ID</span>
			<span>
				<input type="text" maxlength="100" value="" id="search-word" style="width:120px">
			</span>
        </li>
      </ul>
      <span class="btn3"><a href="#" class="btn_search" id="search-btn">조회</a></span>
    </div>

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
        <table class="tbl_list" id="data_table" >
            <colgroup>
            <col style="width:" />
            <col style="width:" />
            <col style="width:" />
            <col style="width:" />
            <col style="width:" />
            </colgroup>
            <thead>
            <tr>
            	<th scope="col">번호</th>
                <th scope="col">로그인방법</th>
                <th scope="col">로그인ID</th>
                <th scope="col">로그인일시</th>
                <th scope="col">접속IP</th>
                <th scope="col">로그인결과</th>
            </tr>
            </thead>
			<tbody>
			</tbody>
        </table>
    </div>
    <!-- //table list -->
    <!-- 페이징 -->
    <div class="paging" id="pagination">
    </div>
    <!-- //페이징 -->
</div>
<!-- //content -->


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
<!-- Script -->
<!-- zoom set  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/zoom.js"></script>
<!-- common event handler on list pages  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/login-history-column.js"></script>
<script>

    $(document).ready(function () {

        // datatables ajax 에서 사용 할 parameter 세팅
        // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
        var requestParam = function (data) {
            // 필수 변경 불가
            data.perPage = IbkDataTable.perPage;
            // 필수 변경 불가
            data.currentPage = IbkDataTable.currentPage;
            data.EMP_NO = $("#search-word").val();

        };

        // datatables 세팅 모든 파라미터는 필수값
        IbkDataTable.initDataTable("data_table", "${pageContext.request.contextPath}/admin/login-history-list", requestParam,IbkContentsColumn.columns, IbkContentsColumn.columnDefs);

     });
    
    $("#search-btn").on('click', function () {
   	  IbkDataTable.currentPage = 1;
   	  IbkDataTable.reload();
   	});
    
    $("#search-word").keypress(function (event) {
       if (event.which == 13) {
         event.preventDefault();
         $("#search-btn").trigger("click");
       }
     });
    
    // datatable 수정 버튼 클릭 이벤트 리스너
    function reload(){
        IbkDataTable.currentPage = 1;
        IbkDataTable.reload();
    }

    datagridTrColorChanger("#data_table");
</script>
