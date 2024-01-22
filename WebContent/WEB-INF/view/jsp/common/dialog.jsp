<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="alert_wrap" id="alert-modal" style="display: none">
    <!-- content -->
    <div class="content_alert" id="alert-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_alert">
        <!-- button -->
        <a href="javascript:" class="btn_big blue" id="alert-dialog-close">확인</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>

<div class="popup_wrap_s" id="confirm-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title" id="confirm-dialog-title">삭제</div>
        <div class="btn_close">
            <a href="javascript:" class="confirm-dialog-close">
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
        <a href="javascript:" class="btn_big blue" id="confirm-yes-btn">예</a>
        <a href="javascript:" class="btn_big gray confirm-dialog-close">아니오</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->


<div class="popup_wrap_s" id="no-cancel-confirm-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title" id="no-cancel-confirm-title"></div>
        <div class="btn_close">
            <a href="javascript:" class="no-cancel-confirm-dialog-close">
                <img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png"
                     alt="닫기"/>
            </a>
        </div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop" id="no-cancel-confirm-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:" class="btn_big blue no-cancel-confirm-dialog-close">확인</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
    var z_index = 20000000;

    function showAlert(message, callback) {
        $("#alert-message").html(message);

        $("#alert-dialog-close").on('click', function () {
            if (callback) {
                callback();
            }
            $("#alert-modal").dialog("close");
        });

        $("#alert-modal").dialog({
            modal: true
        });

        $(".ui-dialog-titlebar").hide();
        $("#alert-modal").parent().css({'z-index': z_index++});
    }

    function showConfirmNoCancelBtn(title, message) {
        $("#no-cancel-confirm-title").text(title);
        $("#no-cancel-confirm-message").html(message);

        $(".no-cancel-confirm-dialog-close").on('click', function () {
            $("#no-cancel-confirm-dialog").dialog("close")
        });

        $("#no-cancel-confirm-dialog").dialog({
            modal: true,
            width: "400px",
            open: function () {
                $(this).css('padding', '0px');
            },
        });
        $(".ui-dialog-titlebar").hide();
        $("#no-cancel-confirm-dialog").parent().css({'z-index': z_index++});
    }

    function showConfirm(title, message, callback) {
        $("#confirm-dialog-title").text(title);
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
        $("#confirm-dialog").parent().css({'z-index': z_index++});
    }

    function showConfirmForAjax(title, message, callback, targetObject) {
        $("#confirm-dialog-title").text(title);
        $("#confirm-message").html(message);

        $(".confirm-dialog-close").off('click').on('click', function () {
            $("#confirm-dialog").dialog("close")
        });

        $("#confirm-yes-btn").off('click').on('click', function () {
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
        $("#confirm-dialog").parent().css({'z-index': z_index++});
    }


    function showConfirmForAjax2(title, message, callback, targetObject, noCallback, noTargetObject) {
        $("#confirm-dialog-title").text(title);
        $("#confirm-message").html(message);

        $(".confirm-dialog-close").off('click').on('click', function () {
            noCallback(noTargetObject);
            noTargetObject = [];
            $("#confirm-dialog").dialog("close")
        });

        $("#confirm-yes-btn").off('click').on('click', function () {
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
        $("#confirm-dialog").parent().css({'z-index': z_index++});
    }

</script>