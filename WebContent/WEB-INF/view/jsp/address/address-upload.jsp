<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>${title}
</h3>
<!-- content -->
<div id="content">
    <div class="box_info_blue">
        <div class="title">주소록 가져오기, 셀 입력 및 편집 도움말</div>
        <ul class="text1 mgt10">
            <li>- 한번에 최대 1000건까지 주소록에 저장하실 수 있습니다.</li>
            <li>- 확장자 xls 또는 csv 파일만 가능합니다.</li>
            <li>- 1행부터 데이터를 넣어야 합니다.(타이틀명을 넣지 말것!!)</li>
            <li>- 이름, 휴대폰(-을 반드시 포함), 이메일, 팩스, 소속 순서대로 작성하시고 나머지 열은 제거하십시요.</li>
        </ul>
    </div>
    <div class="mgt40">
        <a href="javascript:;" class="btn_default fileopen" id="upload-btn">파일불러오기</a>
        <a href="${pageContext.request.contextPath}/address/download/sample/contact" class="btn_default download mgl6">샘플다운로드</a>
        <a href="javascript:;" class="btn_default question fr" id="help-btn">도움말</a>
    </div>

    <!-- table list -->
    <div class="table_top"> 총 <span id="total_cnt">0</span>건
        <span class="num" id="per-page">
            <select id="per-page" style="display:none;">
                <option value="1000">1000</option>
            </select>
        </span>
    </div>

    <div class="tbl_wrap_list">
        <table class="tbl_list" id="address_upload_table" summary="파일 등록 테이블입니다.">
            <caption>파일 등록 테이블</caption>
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
    <div class="btn_wrap01_list"><a href="#" class="btn_big blue" id="regi-btn">등록하기</a></div>
</div>
<!-- //content -->
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="./upload-dialog.jsp" flush="true"/>
<jsp:include page="../help/address-help.jsp" flush="true"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/tabcontent.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/address-upload-column.js"></script>

<script>
    var editor;
    $(document).ready(function () {
        enterKeyListener();
        // datatables 세팅 모든 파라미터는 필수값-- 맨 밑에 정의함
        IbkDataTable.initDataTable("address_upload_table", IbkAddressUploadColumn.columns, IbkAddressUploadColumn.columnDefs);
    });

    // 전체 체크박스 클릭 이벤트 리스너
    // datatables 의 모든 셀렉트 박스가 선택 된다.
    $('#select-all').on('click', function () {
        // Get all rows with search applied
        var rows = IbkDataTable.dataTable.rows({'search': 'applied'}).nodes();
        // Check/uncheck checkboxes for all rows in the table
        $('input[type="checkbox"]', rows).prop('checked', this.checked);
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

    //도움말 버튼 클릭 시 
    $("#help-btn").on('click', function () {
        showHelpAlert_file();
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

    //파일업로드 버튼 클릭스
    $("#upload-btn").on('click', function () {
        showUploadPopUp(redirectList);
    });

    //등록 버튼 클릭시
    $("#regi-btn").on('click', function () {
        if ($("#total_cnt").text() == null || $("#total_cnt").text().trim() == "" || $("#total_cnt").text().trim() == "0") {
            showAlert("파일을 먼저 등록 해주세요.");
            return false;
        }
        var $rowNode = $('#address_upload_table').find('tbody tr:eq(0)').get(0);
        if (IbkDataTable.dataTable.row($rowNode).data() == null || IbkDataTable.dataTable.row($rowNode).data() == "") {
            showAlert("파일을 먼저 등록 해주세요.");
            return false;
        }

        var uniKey = IbkDataTable.dataTable.row($rowNode).data().catSeq;
        if (uniKey == null || uniKey == "") {
            showAlert("파일을 재등록 해주세요.", redirectList());
            return false;
        }

        showAddAddress(uniKey);
    });

    function redirectList() {
        /* setTimeout(function () {
          window.location.href = "
        ${pageContext.request.contextPath}/upload-address.ibk";
	    }, 100); */
    }


    var IbkDataTable = {
        perPage: 1000,
        currentPage: 1,
        endPage: 0,
        lastPage: 0,
        startPage: 0,
        dataTable: null,

        initDataTable: function (targetId, columns, columnDefs) {
            IbkDataTable.dataTable = $('#' + targetId).DataTable({
                    "processing":
                        true,
                    "dataSrc":
                        "data",
                    "bPaginate":
                        false,
                    "bFilter":
                        false,
                    "bInfo":
                        false,
                    "language":
                        {
                            'loadingRecords': '&nbsp;',
                            'processing': '처리 중입니다.',
                            "emptyTable":
                                "<div style='height:40px;margin-top:25px'>파일 불러오기의 내용이 여기에 표시됩니다.</div>",
                        }
                    ,
                    'columns': columns,
                    'columnDefs': columnDefs,
                    select:
                        {
                            'style': 'multi'
                        }
                }
            );
            // html append event trigger
            $(document).on('click', '.page-btn', function () {
                IbkDataTable.currentPage = $(this).text();
                IbkDataTable.reload();
            });

            $(document).on('click', '#first-page', function () {
                IbkDataTable.currentPage = 1;
                IbkDataTable.reload();
            });

            $(document).on('click', '#pre-page', function () {
// 		      IbkDataTable.currentPage = IbkDataTable.startPage - 1;
                IbkDataTable.currentPage = IbkDataTable.currentPage - 1;
                if (IbkDataTable.currentPage < 1) {
                    IbkDataTable.currentPage = 1;
                }
                IbkDataTable.reload();
            });

            $(document).on('click', '#last-page', function () {
                IbkDataTable.currentPage = IbkDataTable.lastPage;
                IbkDataTable.reload();
            });

            $(document).on('click', '#next-page', function () {
// 		      IbkDataTable.currentPage = IbkDataTable.endPage + 1;
                IbkDataTable.currentPage = IbkDataTable.currentPage + 1;
                if (IbkDataTable.currentPage > IbkDataTable.lastPage) {
                    IbkDataTable.currentPage = IbkDataTable.lastPage;
                }
                IbkDataTable.reload();
            });
        },
        reload: function () {
            IbkDataTable.dataTable.ajax.reload();
        }
    }
</script>
