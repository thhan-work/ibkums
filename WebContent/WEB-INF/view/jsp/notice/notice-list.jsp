<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>공지사항
</h3>
<!-- content -->
<div id="content">
    <div class="info mgb6">* 공지사항을 관리 합니다.</div>
    <div class="info">* 표시여부에 Y인 것만 메시지센터 접속 시 팝업으로 보이고, 여러 개일 경우 모두 보입니다.</div>
    <!-- Search -->
    <div class="box_search01">
        <ul>
            <li>
                <span class="title01">등록일</span>
                <span>
                    <select class="small searchDate" id="searchStartYear"></select>
                </span>
                <span class="text1">년</span>
                <span>
                    <select class="small searchDate" id="searchStartMonth"></select>
                </span>
                <span class="text1">월</span>
                <span>
                    <select class="small searchDate" id="searchStartDay"></select>
                </span>
                <span class="text1">일</span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchStartDatePicker">
                </span>
                <span class="mgl5 mgr5">~</span>
                <span>
                    <select class="small searchDate" id="searchEndYear">
                    </select>
                </span>
                <span class="text1">년</span>
                <span>
                    <select class="small searchDate" id="searchEndMonth">
                    </select>
                </span>
                <span class="text1">월</span>
                <span>
                    <select class="small searchDate" id="searchEndDay">
                    </select>
                </span>
                <span class="text1">일</span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchEndDatePicker">
                </span>
            </li>
            <li>
                <span class="title01">조회내용</span>
                <span>
                    <select style="width:100px;" id="search-word-type">
                        <option value="all" selected>전체</option>
                        <option value="title">제목</option>
                        <option value="writer">작성자</option>
                    </select>
                </span>
                <span>
                    <input type="text" maxlength="80" value="" id="search-word" style="width:465px">
                </span>
            </li>
        </ul>
        <span class="btn2">
            <a href="javascript:" id="search-btn" class="btn_search">조회</a>
        </span>
    </div>
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
        <table class="tbl_list" id="notice_table" summary="공지사항 테이블 입니다.">
            <colgroup>
                <col style="width:70px;"/>
                <col style="width:"/>
                <col style="width:400px"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
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
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">표시기간</th>
                <th scope="col">수정</th>
            </tr>
            </thead>
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
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="notice-detail.jsp" flush="true"/>
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->

<!-- Script -->
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

<!--for summernote-->
<script src="${pageContext.request.contextPath}/static/js/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/static/js/summernote-ko-KR.js"></script>

<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/notice-column.js"></script>
<script>

    $(document).ready(function () {

        enterKeyListener();

        // 시작 셀렉트 박스 범위를 값을 세팅 해줌
        $('#searchStartYear').html(IbkInitData.getYearOptionHtml(0, 10));
        $('#searchStartMonth').html(IbkInitData.getMonthOptionHtml());
        $('#searchStartDay').html(IbkInitData.getDayOptionHtml());
        $('#searchEndYear').html(IbkInitData.getYearOptionHtml(0, 10));
        $('#searchEndMonth').html(IbkInitData.getMonthOptionHtml());
        $('#searchEndDay').html(IbkInitData.getDayOptionHtml());

        // datepicker 세팅
        IbkDatepicker.initDatepicker("searchStartDatePicker", "${pageContext.request.contextPath}");
        IbkDatepicker.initDatepicker("searchEndDatePicker", "${pageContext.request.contextPath}");

        // 검색 시작일 기본값 세팅
        var initSearchStartDate = moment().add(-1, 'year').format("YYYY-MM-DD");
        $("#searchStartDatePicker").val(initSearchStartDate);
        IbkDatepicker.setDateSelectByDatePicker("searchStartDatePicker", "searchStartYear",
            "searchStartMonth", "searchStartDay");

        // 검색 종료일 기본값 세팅
        var initSearchEndDate = moment().format("YYYY-MM-DD");
        $("#searchEndDatePicker").val(initSearchEndDate);
        IbkDatepicker.setDateSelectByDatePicker("searchEndDatePicker", "searchEndYear",
            "searchEndMonth", "searchEndDay");

        // datatables ajax 에서 사용 할 parameter 세팅
        // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
        var requestParam = function (data) {
            // 필수 변경 불가
            data.perPage = IbkDataTable.perPage;
            // 필수 변경 불가
            data.currentPage = IbkDataTable.currentPage;
            // 여기서 부터는 Custom 하게
            data.searchWordType = $("#search-word-type").val();
            data.searchWord = $("#search-word").val();
            data.searchStartDt = $("#searchStartDatePicker").val().replace(/-/g, '');
            data.searchEndDt = $("#searchEndDatePicker").val().replace(/-/g, '');
        };
        // datatables 세팅 모든 파라미터는 필수값
        IbkDataTable.initDataTable("notice_table", "../notice", requestParam,
            IbkNoticeColumn.columns, IbkNoticeColumn.columnDefs);
    });

    // 페이지당 조회 카운트 변경 이벤트 리스너
    $("#per-page").on('change', function () {
        IbkDataTable.perPage = $(this).val();
        IbkDataTable.currentPage = 1;
        IbkDataTable.reload();
    });

    $("#create-btn").on('click', function () {
    	// init data
    	$("#dis-start-datepicker").val(moment().format("YYYY-MM-DD"));
        $("#dis-end-datepicker").val(moment().add(7, 'days').format("YYYY-MM-DD"));
        IbkDatepicker.setDateSelectByDatePicker("dis-start-datepicker", "dis-start-year",
            "dis-start-month", "dis-start-day");
        IbkDatepicker.setDateSelectByDatePicker("dis-end-datepicker", "dis-end-year",
            "dis-end-month", "dis-end-day");
        $("#notice-title").val("");
        $("#notice-content").summernote("code", "");
        popOpen("#popup_wrap");
    });

    // 조회 버튼 클릭 이벤트 리스너
    $("#search-btn").on('click', function () {
        if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
            // dialog jsp 가 include 되어 있어야 합니다.
            showAlert("검색 날짜 범위가 잘못 되었습니다.");
            return false;
        }
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

    // datatable 수정 버튼 클릭 이벤트 리스너
    // 수정 화면으로 전환
    $("#notice_table").on('click', '.mod_btn', function () {
    /*         window.location.href = "${pageContext.request.contextPath}/admin/notice-detail.ibk?id="
                + $(this).prop('id').split("-")[1]; */
		var id = $(this).prop('id').split("-")[1];
        // get modify data
		$.ajax({
            url: '${pageContext.request.contextPath}/notice/' + id,
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
				if (result) {
					$("#dis-start-datepicker-m").val(moment(result.startDate, "YYYYMMDD").format("YYYY-MM-DD"))
				    $("#dis-end-datepicker-m").val(moment(result.endDate, "YYYYMMDD").format("YYYY-MM-DD"))
					$("#notice-id-m").val(result.id);
					$("#notice-title-m").val(result.title);
					$("#notice-content-m").summernote("code", result.contents);
					popOpen("#popup_wrap_m");
				}	       
            }
        });
	});

    // 삭제 버튼 클릭시 선택된 항목을 삭제 하는 이벤트 리스너
    // datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
    // $(document).on 을 사용
    $(document).on('click', "#delete-btn", function () {
        var deleteTarget = [];
        ($(".dt-check-box").each(function () {
            if ($(this).prop('checked')) {
                deleteTarget.push($(this).val());
            }
        }));
        if (deleteTarget.length < 1) {
            showAlert("선택된 공지사항이 없습니다.")
        } else {
            var confirmMessage = "총 " + deleteTarget.length + "건 삭제 하시겠습니까?";
            showConfirmForAjax("삭제", confirmMessage, deleteNotice, deleteTarget);
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

    // 검색 시작일 datepikcer 값 변경 시
    // 검색 시작일 셀렉트 박스 날짜 값을 변경해 주는 이벤트 리스너
    $("#searchStartDatePicker").on('change', function () {
        IbkDatepicker.setDateSelectByDatePicker("searchStartDatePicker", "searchStartYear",
            "searchStartMonth", "searchStartDay");
    });

    // 검색 종료일 datepikcer 값 변경 시
    // 검색 종료 셀렉트 박스 날짜 값을 변경해 주는 이벤트 리스너
    $("#searchEndDatePicker").on('change', function () {
        IbkDatepicker.setDateSelectByDatePicker("searchEndDatePicker", "searchEndYear",
            "searchEndMonth", "searchEndDay");
    });

    // 검색 시작일 셀렉트 박스가 변경 되었을 경우 검색 시작 datepiker 값을 변경해주는
    // 이벤트 리스너
    $(".searchDate").on('change', function () {
        IbkDatepicker.setDatePickerByDateSelect("searchEndDatePicker", "searchEndYear",
            "searchEndMonth", "searchEndDay");
        IbkDatepicker.setDatePickerByDateSelect("searchStartDatePicker", "searchStartYear",
            "searchStartMonth", "searchStartDay");
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

    // 삭제 Ajax
    function deleteNotice(deleteTarget) {
        if (deleteTarget.length > 0) {
            $.ajax({
                url: '${pageContext.request.contextPath}/notice/' + deleteTarget,
                type: 'DELETE',
                success: function (result) {
                    showAlert("삭제 하였습니다.");
                    IbkDataTable.reload();
                }
            });
        }
    }
</script>
