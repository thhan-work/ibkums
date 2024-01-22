<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 파일업로드 창 시작  -->
<div class="popup_wrap" id="fileUpload-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title" id="title">주소록파일등록</div>
        <div class="btn_close">
            <a href="javascript:;" class="popup-close">
                <img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" />
            </a>
        </div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
        <!-- table_view -->
        <div class="mgt0"><strong> 확장자 xls 또는 csv 파일만 가능합니다.</strong><br><strong>문서암호화해제를 하고 파일을 불러오시기 바랍니다.</strong></div><br>
        <form id="file-form" >
            <input type="file" id="file-input" name="file" value="" onChange="fileChange();" style="display:none;"/>
        </form>
        <div class="tbl_wrap_view">
            <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                <caption>검색조건 테이블입니다.</caption>
                <colgroup>
                    <col style="width:auto" />
                    <col style="width:auto" />
                </colgroup>
                <tr>
                    <td><input type="text" id="file_name" name="file_name" value="" placeholder="업로드할 파일을 선택하세요...." style="width:350px"></td>
                    <td><a href="javascript:;" class="btn_default fileopen" id="file-find-btn">파일 찾기</a></td>
                </tr>
            </table>
        </div>
        <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="#" class="btn_big blue group-add" id="submit">등록</a>
        <a href="#" class="btn_big gray popup-close">취소</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!-- 파일업로드 창 끝  -->

<div class="alert_wrap" id="alert-modal" style="display: none">
    <!-- content -->
    <div class="content_alert" id="alert-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_alert">
        <!-- button -->
        <a href="javascript:;" class="btn_big blue" id="alert-dialog-close">확인</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>

<div class="popup_wrap_s" id="confirm-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">삭제</div>
        <div class="btn_close">
            <a href="javascript:;" class="confirm-dialog-close">
                <img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png"
                     alt="닫기"/>
            </a>
        </div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop" id="confirm-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:;" class="btn_big blue" id="confirm-yes-btn">예</a>
        <a href="javascript:;" class="btn_big gray confirm-dialog-close">아니오</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<!-- 그룹 팝업 시작 -->
<div class="popup_wrap" id="address-modal" style="display: none;">
    <!-- top -->
    <div class="top">
        <div class="title">주소록에 등록하기</div>
        <div class="btn_close"><a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" id="btn_addaddress_close" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">

        <!-- tap box -->
        <div class="wrap_tab mgt14">
            <ul class="tabs big" data-persist="true">
                <li><a href="#address_view_tab1" id="addExistGroup" class="big">기존 그룹에 등록</a></li>
                <li><a href="#address_view_tab2" id="addNewGroup" class="big" style="margin-left:-2px;">새 그룹에 등록</a></li>
            </ul>
            <div class="tabcontents big popup01">
                <!-- tab_기존 그룹에 등록 -->
                <div id="address_view_tab1">
                    <!-- table_view -->
                    <div class="tbl_wrap_view mgt15">
                        <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                            <caption>기존 그룹 등록 테이블입니다.</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tr>
                                <th scope="row">그룹선택</th>
                                <td>
                                    <select class="big" id="select_groupList" style="width:300px">
                                        <option>추가할 그룹을 선택하세요</option>
                                        <option>선택하세요</option>
                                        <option>선택하세요</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!-- //table_view -->
                </div>
                <!-- //tab_기존 그룹에 등록 -->
                <!-- tab_새 그룹에 등록 -->
                <div id="address_view_tab2">
                    <!-- table_view -->
                    <div class="tbl_wrap_view mgt15">
                        <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                            <caption>신규 그룹 등록 테이블입니다.</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tr>
                                <th scope="row">공유여부</th>
                                <td>
                                    <div class="radio_default">
                                        <input type="radio" id="radio1" name="shareyn" checked="checked" value="0"/>
                                        <label for="radio1">공유안함</label>
                                    </div>
                                    <div class="radio_default">
                                        <input type="radio" id="radio2" name="shareyn" value="1" />
                                        <label for="radio2">공유</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">그룹명</th>
                                <td><input type="text" name="search" id="groupname" value="" placeholder="그룹명 입력" style="width:280px"></td>
                            </tr>
                            <tr>
                                <th scope="row">그룹설명</th>
                                <td><input type="text" name="search" id="groupnote" value="" placeholder="그룹설명 입력" style="width:280px"></td>
                            </tr>
                        </table>
                    </div>
                    <!-- //table_view -->
                </div>
                <!-- //tab_새 그룹에 등록 -->

            </div>
        </div>
        <!-- //tab box -->

    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" class="btn_big blue" id="btn_addAddr_save">등록</a><a href="javascript:;" class="btn_big gray" id="btn_addAddr_cancel">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!-- 그룹 팝업 끝  -->
<script>

    function showUploadPopUp(callback) {
        $(".popup-close").on('click', function () {
            if (callback) {
                callback();
            }
            $("#fileUpload-dialog").dialog("close");
        });
        $("#fileUpload-dialog").find("#file-input").val("");
        $("#fileUpload-dialog").find("#file_name").val("");

        $("#fileUpload-dialog").dialog({
            modal: true,
            width: "600px",
            open: function () {
                $(this).css('padding', '0px');
            }
        });

        $(".ui-dialog-titlebar").hide();
    }


    $("#file-find-btn").on('click', function () {
        $("#file-input").click();
    });
    $("#submit").on('click', function () {

        if($('input[type=file]').val()==""){
            showAlert("파일을 선택해주세요.");
            return false;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/upload",
            type: "POST",
            data: new FormData($("#file-form")[0]),
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            success: function (data) {
                IbkDataTable.dataTable.clear();
                IbkDataTable.dataTable.rows.add(data).draw();
                $("#total_cnt").text(data.length);
                // 전체 선택 시킴
                var rows = IbkDataTable.dataTable.rows({'search': 'applied'}).nodes();
                $('input[type="checkbox"]', rows).prop('checked', true);
                $('#select-all').prop('checked', true);
            },
            error: function (data) {
                var jData=JSON.parse(data.responseText);
                showAlert("파일 업로드가 실패했습니다."+"("+jData.message+")");
                // Handle upload error
                // ...
            }
        });
        $("#fileUpload-dialog").dialog("close");
    });
    function fileChange(){
        var fileName = $('input[type=file]').val();
        var clean=fileName.split('\\').pop();
        $("#file_name").val(clean);
    }

    /* 다이얼로그 닫을 시 화면 갱신  시작*/
    function redirectList() {
        /* setTimeout(function () {
          window.location.href = "${pageContext.request.contextPath}/upload-address.ibk";
	    }, 100); */
    }
    function redirectContacts(emplId,grpSeq) {
        /* setTimeout(function () {
          window.location.href = "${pageContext.request.contextPath}/contact-list.ibk?emplId="+emplId+"&grpSeq="+grpSeq;
	    }, 1000); */
    }
    /* 다이얼로그 닫을 시 화면 갱신  끝*/
    /*기존 다이얼로그 시작*/
    function showAlert(message, callback) {
        $("#alert-message").html(message);

        $("#alert-dialog-close").on('click', function () {
            if (callback) {
                callback();
            }
            $("#alert-modal").dialog("close");
        });

        $("#alert-modal").dialog({
            modal: true,
            width: 'auto'
        });
        $(".ui-dialog-titlebar").hide();
    }

    function showConfirmCancel(message, callback) {
        $("#confirm-message").html(message);

        $(".confirm-dialog-close").on('click', function () {
            $("#confirm-dialog").dialog("close")
        });

        $("#confirm-yes-btn").on('click', function () {
            showAlert("취소 하였습니다.", callback);
            $("#confirm-dialog").dialog("close");

        });

        $("#confirm-dialog").dialog({
            modal: true,
            width: "400px",
            open: function () {
                $(this).css('padding', '0px');
            },
        });
        $(".ui-dialog-titlebar").hide();
    }

    function showConfirmForAjax(message, callback, targetObject) {
        $("#confirm-message").html(message);

        $(".confirm-dialog-close").on('click', function () {
            $("#confirm-dialog").dialog("close")
        });

        $("#confirm-yes-btn").on('click', function () {
            callback(targetObject);
            targetObject = [];
            $("#confirm-dialog").dialog("close");
        });

        $("#confirm-dialog").dialog({
            modal: true,
            width: "400px",
            open: function () {
                $(this).css('padding', '0px');
            },
        });
        $(".ui-dialog-titlebar").hide();
    }
    /*기존 다이얼로그 끝 */

    /*그룹 등록 다이얼로그 시작 */
    function showAddAddress(uniqueKey) {
        initUI(); // UI 초기화

        $("#btn_addaddress_close").off('click').on('click', function () {
            $("#address-modal").dialog("close");
        });

        $("#btn_addAddr_cancel").off('click').on('click', function () {
            $("#address-modal").dialog("close");
        });

        $("#address-modal").dialog({
            modal: true,
            width: "550px",
            open: function () {
                $(this).css('padding', '0px');
            },
        });
        /* var rData =IbkDataTable.dataTable.data();
        
        //console.log(rData);
        var rowData = new Array();
        for(var i=0;i<rData.length;i++){
            rowData.push(rData[i]);
        } */
      
        $(".dt-check-box").parent().parent().parent().removeClass("check");
        $(".dt-check-box:checked").parent().parent().parent().addClass("check");
        var rData = IbkDataTable.dataTable.rows(".check").data();
        var rowData = new Array();
        for(var i=0;i<rData.length;i++){
            rowData.push(rData[i]);
        }

        // 등록 버튼 이벤트
        $("#btn_addAddr_save").off('click').on('click', function () {
            var addType = $("#address-modal .tabs li.selected a").prop("id");

            if(addType == "addExistGroup"){//기존 그룹에 추가
                var grpSeq = $("#address_view_tab1 option:selected").val();

                // 그룹 등록 + 연락처 등록
                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/'+addType,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({
                        "grpSeq" : grpSeq
                        ,"contactlist" : rowData
                    }),
                    success: function (result) {
                        showAlert("등록을 완료 하였습니다.");
                        //console.log(result);
                        redirectContacts(result.emplId,result.grpSeq);
                    },
                    error: function (xhr,error,code) {
                        var errorMsg = code.message == null ? "" : code.message;
                        var errorCd = xhr.status == null ? "" : xhr.status;
                        showAlert("요청 중 에러 발생, 에러 메시지=["+errorMsg+"], 에러코드=["+errorCd+"], 관리자에게 문의 바랍니다.");
                    }
                });
                $("#address-modal").dialog("close");

            }else if(addType == "addNewGroup"){//신규 그룹에 추가

                if (!IbkValidation.validInputBox("groupname")) {
                    showAlert("그룹명을 입력 하세요", IbkValidation.setFocusById("groupname"));
                    return false;
                }
                if (!IbkValidation.validInputBox("groupnote")) {
                    showAlert("그룹설명을 입력 하세요", IbkValidation.setFocusById("groupnote"));
                    return false;
                }

                // 그룹 등록 + 연락처 등록
                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/'+addType,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({
                        "groupName": $("#groupname").val()
                        ,"groupNote": $("#groupnote").val()
                        ,"groupShareYn":$('input[name="shareyn"]:checked').val()
                        ,"contactlist" : rowData
                    }),
                    success: function (result) {
                        showAlert("등록을 완료 하였습니다.");
                        //console.log(result);
                        redirectContacts(result.emplId,result.grpSeq);
                    },
                    error: function (xhr,error,code) {
                        var errorMsg = code.message == null ? "" : code.message;
                        var errorCd = xhr.status == null ? "" : xhr.status;
                        showAlert("요청 중 에러 발생, 에러 메시지=["+errorMsg+"], 에러코드=["+errorCd+"], 관리자에게 문의 바랍니다.");
                    }
                });
                $("#address-modal").dialog("close");
            }
        });

        $(".ui-dialog-titlebar").hide();
    }


    //// UI 초기화
    function initUI(){
        $("#groupname").val("");
        $("#groupnote").val("");

        initGroupList(); // 등록 가능 그룹 리스트 초기화
        $("#address_view_tab1 option:first").prop("selected","selected");


        // 	$("#address-modal .tabs li.selected").toggleClass("");
// 	$("#address-modal .tabs li:first").toggleClass("selected");
        $("#address-modal .tabs li:first").trigger("selected");
    }

    //// 등록가능 그룹 리스트 조회
    function initGroupList(){
        $.ajax({
            url: '${pageContext.request.contextPath}/message/address/groupList',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({"addressType":"add"}),
            success: function (result) {
                var html = "";
                for(var i=0; i < result.length; i++){
                    var groupData = result[i];
                    html +=	 '<option value="'+groupData.grpSeq+'">'+groupData.groupName+'</option>'
                }

                $("#address_view_tab1 #select_groupList").empty();
                $("#address_view_tab1 #select_groupList").html(html);
            }
        });
    };
    /* 그룹 등록 다이얼로그 끝*/

</script>