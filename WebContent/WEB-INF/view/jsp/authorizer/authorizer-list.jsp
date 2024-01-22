<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>승인자(협의자) 관리
</h3>
<!-- content -->
<div id="content">
    <div class="info">* 등록된 승인자만 승인이 가능합니다.</div>
    <!-- Search -->
    <!-- //Search -->

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
                <col style="width:70px;"/>
            <col style="width:" />
            <col style="width:" />
            <col style="width:70px;" />
            <col style="width:" />
            <col style="width:" />
            <col style="width:" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">
                    <div class="checkbox_center">
                        <input type="checkbox" id="select-all"/>
                        <label for="select-all"></label>
                    </div>
                </th>
                <th scope="col">등록일</th>
                <th scope="col">부서명</th>
                <th scope="col">결재선 차수</th>
                <th scope="col">승인자명</th>
                <th scope="col">직원번호</th>
                <th scope="col">수정</th>
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
    <!-- 버튼 -->
    <div class="btn_wrap01_list">
        <a href="javascript:" id="create-btn" class="btn_big blue">등록</a>
        <a href="javascript:" id="delete-btn" class="btn_big delete">삭제</a>
    </div>
    <!-- //버튼 -->
</div>
<!-- //content -->
<!-- user detail popup -->
<jsp:include page="authorizer_detail.jsp" flush="true"/>
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>

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
        src="${pageContext.request.contextPath}/static/js/datatable-column/user-authorizer-column.js"></script>
<script>
    // target url  세팅(하단 list_stuff.js 에서 참조)
    var deleteTargetUrl = '${pageContext.request.contextPath}/user/ack/';

    $(document).ready(function () {

        // datatables ajax 에서 사용 할 parameter 세팅
        // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
        var requestParam = function (data) {
            // 필수 변경 불가
            data.perPage = IbkDataTable.perPage;
            // 필수 변경 불가
            data.currentPage = IbkDataTable.currentPage;
            // 여기서 부터는 Custom 하게
            data.requestType = "ack";
        };

        // datatables 세팅 모든 파라미터는 필수값
        IbkDataTable.initDataTable("data_table", "../user", requestParam,IbkContentsColumn.columns, IbkContentsColumn.columnDefs);

     });

    // 등록 버튼 클릭 이벤트 리스너 등록
    $("#create-btn").on('click', function () {
    	initEmployeeInfo();
        popOpen("#popup_wrap");
    });

    // datatable 수정 버튼 클릭 이벤트 리스너
    $("#data_table").on('click', '.mod_btn', function () {
        popOpen("#popup_wrap");
        $.ajax({
            url: '${pageContext.request.contextPath}/user/' + $(this).prop('id').split("-")[1],
                type: 'GET',
                success: function (result) {
                    setEmployeeInfo(result);
            }
        });
    });
    function reload(){
        IbkDataTable.currentPage = 1;
        IbkDataTable.reload();
    }

    datagridTrColorChanger("#data_table");
</script>
