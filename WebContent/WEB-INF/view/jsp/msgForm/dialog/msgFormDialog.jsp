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
        <div class="title">저장</div>
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


<div class="popup_wrap_s" id="confirm-delete-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">삭제</div>
        <div class="btn_close">
            <a href="javascript:;" class="confirm-delete-dialog-close">
                <img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png"
                     alt="닫기"/>
            </a>
        </div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop" id="confirm-delete-message">
        <!-- Message -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:;" class="btn_big blue" id="confirm-delete-yes-btn">예</a>
        <a href="javascript:;" class="btn_big gray confirm-delete-dialog-close">아니오</a>
        <!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
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
      width: "400px"
    });
    $(".ui-dialog-titlebar").hide();
  }

  function showConfirmSave(message, callback) {
    $("#confirm-message").html(message);

    $(".confirm-dialog-close").on('click', function () {
      $("#confirm-dialog").dialog("close")
    });

    $("#confirm-yes-btn").on('click', function () {
      if (callback) {
           callback();
      }
      $("#confirm-dialog").dialog("close");
      showAlert("개인메시지함에 저장하였습니다.");

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

  function showConfirmDelete(message, callback) {
	    $("#confirm-delete-message").html(message);

	    $(".confirm-delete-dialog-close").on('click', function () {
	      $("#confirm-delete-dialog").dialog("close")
	    });

	    $("#confirm-delete-yes-btn").on('click', function () {
	      if (callback) {
	           callback();
	      }
	      $("#confirm-delete-dialog").dialog("close");
	      showAlert("메시지를 삭제 하였습니다.");

	    });

	    $("#confirm-delete-dialog").dialog({
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