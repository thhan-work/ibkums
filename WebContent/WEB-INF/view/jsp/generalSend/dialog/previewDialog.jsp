<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <!--popup-->
<div class="popup_wrap"  id="previwe-modal" style="display: none; width: 40000pt;"> 
  <!-- top -->
  <div class="top">
    <div class="title">미리보기 팝업</div>
    <div class="btn_close"><a href="#"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" id="btn_previwe_close" alt="닫기" /></a></div>
  </div>
  <!-- //top --> 
  
  <!-- content -->
  <div class="content_pop">
    <!-- box_sms -->
    <div class="box_sms">
      <div class="text_sms" id="msg-title-div" >
          <input class="sms" type="text" id="top_sms" readonly="readonly" 
                 style="width:238px; padding-left: 15px; padding-right: 15px;">
      </div>
      <div class="content">
	        <div class="text_sms">
	            <textarea class="sms" id="text_sms"
	                  style="font-family:굴림; font-size:16px; width:217px; height:305px" readonly="readonly"></textarea>
	        </div>
      </div>
    </div>
    <!-- //box_sms -->
    <div class="mgt10 tac">*핸드폰 기기 종류에 따라 내용이 다르게 보일 수 있습니다.</div>
  </div>
  <!-- //content --> 
  
  <!-- footer -->
  <div class="footer_pop"> 
    <!-- button --><a href="#" class="btn_big blue" id="btn_previwe_ok">확인</a><!-- //button --> 
  </div>
  <!-- //footer --> 
</div>
<!--//popup-->

<script>
  function showPreview(top, message) {
    $("#top_sms").val(top);
    $("#text_sms").text(message);

    $("#btn_previwe_close").on('click', function () {
        $("#previwe-modal").dialog("close");
    });
    
    $("#btn_previwe_ok").on('click', function () {
        $("#previwe-modal").dialog("close");
    });
    
    $("#previwe-modal").dialog({
        modal: true,
        width: "450px",
        open: function () {
          $(this).css('padding', '0px');
        },
      });
    $(".ui-dialog-titlebar").hide();
  }
  
</script>