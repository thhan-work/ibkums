<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h3>${address.groupName}
</h3>
<!-- content -->
<div id="content">
    <div>
        <a href="javascript:;" class="btn_default blue" id="add-btn">사람추가</a>
        <a href="javascript:;" class="btn_default" id="mod-btn">수정</a>
        <a href="javascript:;" class="btn_default delete" id="del-btn">삭제</a>
        <select id="grpMove" name="grpMove">
            <option value="default" selected="selected">그룹이동</option>
            <c:forEach items="${addressList}" var="loop">
                <option value="${loop.grpSeq}">${loop.groupName}</option>
            </c:forEach>
        </select>
        <a href="javascript:;" class="btn_default blue" id="excel-download-btn">엑셀다운로드</a>
        <a href="javascript:;" class="btn_default question fr" id="help-btn">도움말</a>
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
        <table class="tbl_list" id="address_contact_table" summary="주소록 연락처 테이블입니다.">
            <caption>그룹 연락처 테이블</caption>
            <colgroup>
                <col style="width:70px;"/>
                <col style="width:"/>
                <col style="width:"/>
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
                <th scope="col">이름</th>
                <th scope="col">휴대폰번호</th>
                <th scope="col">이메일주소</th>
                <th scope="col">FAX번호</th>
                <th scope="col">소속</th>
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
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="./contact-dialog.jsp" flush="true"/>
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<!-- 도움말 다이얼로그 -->
<jsp:include page="../help/address-help.jsp" flush="true"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkDatatables.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/contact-column.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.filedownload.js"></script>
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
            // 주소록 소유자

            data.emplId = "${address.emplId}";
            data.grpSeq = "${address.grpSeq}";
        };

        // datatables 세팅 모든 파라미터는 필수값
        IbkDataTable.initDataTable("address_contact_table", "${pageContext.request.contextPath}/contactType/contactsList", requestParam, IbkContactColumn.columns, IbkContactColumn.columnDefs);

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

    //사람 추가 버튼 클릭시
    $("#add-btn").on('click', function () {
        /* window.location.href = "${pageContext.request.contextPath}/contact-detail.ibk?type=form&emplId=" + "${address.emplId}"
            + "&grpSeq=" + "${address.grpSeq}"; */
		openRegistDialog();
    });

    // 수정 버튼 클릭 처리
    $(document).on('click', "#mod-btn", function () {
        var count = 0;
        var grpSeq = "";
        var catSeq = "";
        var emplId = "";
        var rowData = new Array();
        var checkbox = $("input[name=catSeq-Ck]:checked");
        var data = null;
        checkbox.each(function (i) {
            var f = checkbox[i].parentNode.parentNode.parentNode;
            data = IbkDataTable.dataTable.row(f).data();
            //console.log(data);
            grpSeq = data.grpSeq;
            emplId = data.emplId;
            catSeq = data.catSeq;
            count++;
        });

        if (count > 1) {
            showAlert("수정할 연락처를 하나만 선택해 주세요");
            return false;
        }
        if (catSeq == "" || catSeq == null) {
            showAlert("수정할 연락처가 선택되지 않았습니다");
            return false;
        }
	    /*
	    window.location.href = "${pageContext.request.contextPath}/contact-detail.ibk?type=modForm&emplId="+emplId
		  +"&grpSeq="+grpSeq+"&catSeq="+catSeq;*/
        openModifyDialog(emplId, grpSeq, catSeq);

    });


    //엑셀다운로드처리
    $(document).on('click', "#excel-download-btn", function () {
        $.fileDownload("${pageContext.request.contextPath}/contact-list-download.ibk", {
            httpMethod: "POST",
            data: {
                emplId: "${address.emplId}"
                , grpSeq: "${address.grpSeq}"
            },
            successCallback: function (url) {
            },
            failCallback: function (responesHtml, url) {
            }
        });
    });

    //삭제 버튼 클릭 처리
    $(document).on('click', "#del-btn", function () {
        var count = 0;
        var catSeq = "";
        var grpSeq = "";
        var emplId = "";
        var rowData = new Array();
        var checkbox = $("input[name=catSeq-Ck]:checked");
        var data = null;

        checkbox.each(function (i) {
            var f = checkbox[i].parentNode.parentNode.parentNode;
            data = IbkDataTable.dataTable.row(f).data();
            catSeq = data.catSeq;
            rowData.push(data);
            count++;
        });
        //console.log(rowData);
        if (count < 1 || catSeq == "" || catSeq == null) {
            showAlert("삭제할 연락처를 선택하지 않았습니다");
            return false;
        }
        var confirmMessage = "총 " + rowData.length + "건 삭제 하시겠습니까?";
        showConfirmForAjax("삭제", confirmMessage, deleteContact, rowData);

    });

    function deleteContact(deleteTarget) {
        //console.log(deleteTarget.length);
        if (deleteTarget.length > 0) {
            $.ajax({
                url: '${pageContext.request.contextPath}/contact',
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

    //그룹이동 셀렉트 박스 감지
    $("#grpMove").change(function () {
        var count = 0;
        var rowData = new Array();
        var checkbox = $("input[name=catSeq-Ck]:checked");
        var data = null;

        checkbox
            .each(function (i) {
                var f = checkbox[i].parentNode.parentNode.parentNode;
                data = IbkDataTable.dataTable.row(f).data();
                rowData.push(data);
                count++;
            });
        //console.log(count);
        if (count < 1) {
            showAlert(
                "이동할 연락처가 선택되지 않았습니다.",
                function () {
                    $(
                        "select[name=grpMove] option[value='default']")
                        .attr("selected", true);
                });
            return false;
        }
        var selectedGroup = $("#grpMove option:selected")
            .text();

        if ($("#grpMove").val() == '${address.grpSeq}') {//default
            showAlert(
                "현재 주소록 입니다.",
                function () {
                    $(
                        "select[name=grpMove] option[value='default']")
                        .prop("selected", true);
                });
            return false;
        }
        if ($("#grpMove").val() == 'default') {
            showAlert(
                "올바른 주소록을 선택해주세요.",
                function () {
                    $("select[name=grpMove] option[value='default']").prop("selected", true);
                });
            return false;
        }
        var confirmMessage = "총 " + rowData.length + "건, "
            + selectedGroup + "그룹으로 이동하시겠습니까?";
        showConfirmForAjax("그룹이동", confirmMessage, moveContact, rowData);
    });

    function moveContact(moveTarget) {
        //console.log(deleteTarget.length);
        if (moveTarget.length > 0) {
            $.ajax({
                url: '${pageContext.request.contextPath}/contacts/'
                    + $("#grpMove").val(),
                type: 'PUT',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify(moveTarget),
                success: function (result) {
                    showAlert(result + "건 이동 되였습니다.");
                    $("select[name=grpMove] option[value='default']").prop("selected", true);
                    IbkDataTable.reload();
                }
            });
        }
    }

    //도움말 버튼 클릭 시
    $("#help-btn").on('click', function () {
        showHelpAlert_person();
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
        /* setTimeout(
                function() {
                    window.location.href = "

        ${pageContext.request.contextPath}/all-address.ibk";
				}, 100); */
    }
</script>
