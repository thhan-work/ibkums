<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_m" id="popup_wrap" style="display:none">
    <!-- top -->
    <div class="top">
        <div class="title" id="popup_employee_title">등록</div>
        <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_wrap')"><img
                src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기"/></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
        <div class="info mgb10"><span>* 필수항목 표시</span></div>
        <!-- table_view -->
        <div class="tbl_wrap_view">
            <table class="tbl_view01">
                <colgroup>
                    <col style="width:150px"/>
                    <col style="width:auto"/>
                </colgroup>
                <tr>
                    <th scope="row">표시기간</th>
                    <td>
                        <span><select class="small search-date" id="dis-start-year"></select></span>
                        <span class="text1">년</span>
                        <span><select class="small search-date" id="dis-start-month"></select></span>
                        <span class="text1">월</span>
                        <span><select class="small search-date" id="dis-start-day"></select></span>
                        <span class="text1">일</span>
                        <span class="mgl2">
                       <input type="hidden" id="dis-start-datepicker">
                    </span>
                        <span class="mgl5 mgr5">~</span>
                        <span><select class="small search-date" id="dis-end-year"></select></span>
                        <span class="text1">년</span>
                        <span><select class="small search-date" id="dis-end-month"></select></span>
                        <span class="text1">월</span>
                        <span><select class="small search-date" id="dis-end-day"></select>
                    </span>
                        <span class="text1">일</span>
                        <span class="mgl2">
                       <input type="hidden" id="dis-end-datepicker">
                    </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">제목</th>
                    <td><span><input type="text" maxlength="80" value="" placeholder="제목을 입력해 주세요" id="notice-title"
                                     style="width:521px"></span></td>
                </tr>
                <tr>
                    <th scope="row">내용</th>
                    <td>
                        <textarea id="notice-content" name="editordata"></textarea>
                    </td>
                </tr>
            </table>
        </div>
        <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:" class="btn_big blue" id="add-btn">등록</a>
        <a href="javascript:;" class="btn_big gray" onclick="popClose('#popup_wrap')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<!--popup-->
<div class="popup_wrap_m" id="popup_wrap_m" style="display:none">
    <!-- top -->
    <div class="top">
        <div class="title" id="popup_employee_title">수정</div>
        <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_wrap_m')"><img
                src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기"/></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
        <div class="info mgb10"><span>* 필수항목 표시</span></div>
        <!-- table_view -->
        <div class="tbl_wrap_view">
        	<input type="hidden" id="notice-id-m"/>
            <table class="tbl_view01">
                <colgroup>
                    <col style="width:150px"/>
                    <col style="width:auto"/>
                </colgroup>
                <tr>
                    <th scope="row">표시기간</th>
                    <td>
                        <span><select class="small search-date" id="dis-start-year-m"></select></span>
                        <span class="text1">년</span>
                        <span><select class="small search-date" id="dis-start-month-m"></select></span>
                        <span class="text1">월</span>
                        <span><select class="small search-date" id="dis-start-day-m"></select></span>
                        <span class="text1">일</span>
                        <span class="mgl2">
                       <input type="hidden" id="dis-start-datepicker-m">
                    </span>
                        <span class="mgl5 mgr5">~</span>
                        <span><select class="small search-date" id="dis-end-year-m"></select></span>
                        <span class="text1">년</span>
                        <span><select class="small search-date" id="dis-end-month-m"></select></span>
                        <span class="text1">월</span>
                        <span><select class="small search-date" id="dis-end-day-m"></select>
                    </span>
                        <span class="text1">일</span>
                        <span class="mgl2">
                       <input type="hidden" id="dis-end-datepicker-m">
                    </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">제목</th>
                    <td><span><input type="text" maxlength="80" value="" placeholder="제목을 입력해 주세요" id="notice-title-m"
                                     style="width:521px"></span></td>
                </tr>
                <tr>
                    <th scope="row">내용</th>
                    <td>
                        <textarea id="notice-content-m" name="editordata-m"></textarea>
                    </td>
                </tr>
            </table>
        </div>
        <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:" class="btn_big blue" id="modify-btn">수정</a>
        <a href="javascript:;" class="btn_big gray" onclick="popClose('#popup_wrap_m')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
    $(document).ready(function () {

        $('#notice-content').summernote({
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['paragraph']],
                ['height', ['height']]
            ],
            height: 200,
            lang: 'ko-KR' // default: 'en-US'
        });

        $('#dis-start-year').html(IbkInitData.getYearOptionHtml(10, 0));
        $('#dis-end-year').html(IbkInitData.getYearOptionHtml(10, 0));        
        $('#dis-end-month').html(IbkInitData.getMonthOptionHtml());
        $('#dis-end-day').html(IbkInitData.getDayOptionHtml());
        $('#dis-start-month').html(IbkInitData.getMonthOptionHtml());
        $('#dis-start-day').html(IbkInitData.getDayOptionHtml());

        IbkDatepicker.initDatepicker("dis-start-datepicker", "${pageContext.request.contextPath}");
        IbkDatepicker.initDatepicker("dis-end-datepicker", "${pageContext.request.contextPath}");
        
        $("#dis-start-datepicker").on('change', function () {
            IbkDatepicker.setDateSelectByDatePicker("dis-start-datepicker", "dis-start-year",
                "dis-start-month", "dis-start-day");
        });

        $("#dis-end-datepicker").on('change', function () {
            IbkDatepicker.setDateSelectByDatePicker("dis-end-datepicker", "dis-end-year",
                "dis-end-month", "dis-end-day");
        });
        
        
        $('#notice-content-m').summernote({
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['paragraph']],
                ['height', ['height']]
            ],
            height: 200,
            lang: 'ko-KR' // default: 'en-US'
        });

        $('#dis-start-year-m').html(IbkInitData.getYearOptionHtml(10, 5));
        $('#dis-end-year-m').html(IbkInitData.getYearOptionHtml(10, 5));        
        $('#dis-end-month-m').html(IbkInitData.getMonthOptionHtml());
        $('#dis-end-day-m').html(IbkInitData.getDayOptionHtml());
        $('#dis-start-month-m').html(IbkInitData.getMonthOptionHtml());
        $('#dis-start-day-m').html(IbkInitData.getDayOptionHtml());

        IbkDatepicker.initDatepicker("dis-start-datepicker-m", "${pageContext.request.contextPath}");
        IbkDatepicker.initDatepicker("dis-end-datepicker-m", "${pageContext.request.contextPath}");
        
        $("#dis-start-datepicker-m").on('change', function () {
            IbkDatepicker.setDateSelectByDatePicker("dis-start-datepicker-m", "dis-start-year-m",
                "dis-start-month-m", "dis-start-day-m");
        });

        $("#dis-end-datepicker-m").on('change', function () {
            IbkDatepicker.setDateSelectByDatePicker("dis-end-datepicker-m", "dis-end-year-m",
                "dis-end-month-m", "dis-end-day-m");
        });
        
        
        $(".search-date").on('change', function () {
            IbkDatepicker.setDatePickerByDateSelect("dis-start-datepicker-m", "dis-start-year-m",
                "dis-start-month-m", "dis-start-day-m");
            IbkDatepicker.setDatePickerByDateSelect("dis-end-datepicker-m", "dis-end-year-m",
                "dis-end-month-m", "dis-end-day-m");
            IbkDatepicker.setDatePickerByDateSelect("dis-start-datepicker", "dis-start-year",
                    "dis-start-month", "dis-start-day");
            IbkDatepicker.setDatePickerByDateSelect("dis-end-datepicker", "dis-end-year",
                    "dis-end-month", "dis-end-day");
        });

    });
    
    $("#add-btn").on('click', function () {
    	if (!IbkValidation.validInputBox("notice-title")) {
            showAlert("제목을 입력 하세요", IbkValidation.setFocusById("notice-title"));
            return false;
        }
        if ($('#notice-content').summernote('isEmpty')) {
            showAlert("내용을 입력 하세요");
            return false;
        }
        if (IbkValidation.invalidDateScope("dis-start-datepicker", "dis-end-datepicker")) {
            showAlert("표시기간 범위가 잘못 되었습니다.");
            return false;
        }
        var noticeInfo = getNoticeInfo();

        $.ajax({
            url: '${pageContext.request.contextPath}/notice',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(noticeInfo),
            success: function (result) {
                popClose('#popup_wrap');
                showAlert("등록을 완료 하였습니다.");
                IbkDataTable.reload();
            }
        });
    });

    $("#cancel-btn").on('click', function () {
    	popClose('#popup_wrap');
    });
    
    $("#cancel-btn-m").on('click', function () {
    	popClose('#popup_wrap_m');
    });

    $("#modify-btn").on('click', function () {
        if (!IbkValidation.validInputBox("notice-title-m")) {
            showAlert("제목을 입력 하세요", IbkValidation.setFocusById("notice-title"));
            return false;
        }
        if (!IbkValidation.validInputBox("notice-content-m")) {
            showAlert("내용을 입력 하세요");
            return false;
        }
        if (IbkValidation.invalidDateScope("dis-start-datepicker-m", "dis-end-datepicker-m")) {
            showAlert("표시기간 범위가 잘못 되었습니다.");
            return false;
        }
        var noticeInfo = getNoticeInfoM();

        $.ajax({
            url: '${pageContext.request.contextPath}/notice/' + noticeInfo.id,
            type: "PUT",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(noticeInfo),
            success: function (result) {
            	popClose('#popup_wrap_m');
                showAlert("수정을 완료 하였습니다.");
                IbkDataTable.reload();
            }
        });
    });

    function getNoticeInfo() {
        return {
            "id": $("#notice-id").val(),
            "title": $("#notice-title").val(),
            "contents": $("#notice-content").val(),
            "startDate": $("#dis-start-datepicker").val().replace(/-/g, ''),
            "endDate": $("#dis-end-datepicker").val().replace(/-/g, '')
        };
    }

    function getNoticeInfoM() {
        return {
            "id": $("#notice-id-m").val(),
            "title": $("#notice-title-m").val(),
            "contents": $("#notice-content-m").val(),
            "startDate": $("#dis-start-datepicker-m").val().replace(/-/g, ''),
            "endDate": $("#dis-end-datepicker-m").val().replace(/-/g, '')
        };
    }
    

    

</script>

