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

<div class="popup_wrap_s" id="send-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">발송</div>
        <div class="btn_close">
            <a href="javascript:;" class="send-dialog-close">
                <img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png"
                     alt="닫기"/>
            </a>
        </div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop" id="send-dialog-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:;" class="btn_big blue" id="send-dialog-yes">예</a>
        <a href="javascript:;" class="btn_big gray send-dialog-close">아니오</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>


<script>
  function showAlert(message, callback) {
    $("#alert-message").html(message);

    $("#alert-dialog-close").off("click").on('click', function () {
      if (callback) {
        callback();
      }
      $("#alert-modal").dialog("close");
    });

    $("#alert-modal").dialog({
      modal: true,
      width: "400px"
    });
    $(".ui-dialog-titlebar").hide();
  }

  function showConfirmCancel(message, callback ,cancelMsg) {
	var cancelMessage = "취소 하였습니다.";
	if(cancelMsg != null)
	{
		cancelMessage = cancelMsg;
	}
		
    $("#confirm-message").html(message);

    $(".confirm-dialog-close").off("click").on('click', function () {
      $("#confirm-dialog").dialog("close")
    });

    $("#confirm-yes-btn").off("click").on('click', function () {
      $("#confirm-dialog").dialog("close");
      if (callback) {
          callback();
        }
      showAlert(cancelMessage);
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


  function showConfirmSend(message, callback, callbackParam) {
	    $("#send-dialog-message").html(message);

	    $(".send-dialog-close").off("click").on('click', function () {
	      $("#send-dialog").dialog("close")
	    });

	    $("#send-dialog-yes").off("click").on('click', function () {
	      if (callback) {
	           callback(callbackParam);
	      }
	      $("#send-dialog").dialog("close");
	    });

	    $("#send-dialog").dialog({
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
</script>