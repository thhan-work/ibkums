<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div class="popup_wrap" id="help-popup" style="display: none;"> 
  <!-- top -->
  <div class="top">
    <div class="title">기안상태 도움말 팝업</div>
    <div class="btn_close"><a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
  </div>
  <!-- //top --> 
  
  <!-- content -->
  <div class="content_pop">
    <ul class="pdl10 mgt10">
      <li>- 임시저장 : 기안자가 결재를 올리지 않고 임시저장 한 상태</li>
      <li>- 결재진행중 : 결재올리기 요청 후 결재 진행 중 상태</li>
      <li>- <b>발송승인대기</b> : 고객센터까지 결재가 완료되어, 기안자가 발송승인요청을 진행 해야하는 상태
      <br>&nbsp; (이 단계를 거치지 않으면 메시지가 발송되지 않음)</li>
      <li>- 발송승인중 : 기안자가 발송승인 요청하여 발송승인직원이 승인을 진행중인 상태</li>
      <li>- 시간경과(관리자문의) : 기안과정에서 발송희망일이 현재시간보다 과거인 상태이며,
      <br>&nbsp; 이 경우 관리자에게 문의해야 함.(관리자: IT채널부 박우영 과장, 김성민 과장)</li>
      <li>- 반려 : 승인자가 반려한 상태</li>
      <li>- 발송준비중 : 대상자 파일에 등록된 대상자를 DB에 입력 중인 상태(모든 승인 완료)</li>
      <li>- 발송대기 : 모든 승인 완료 후 발송희망일에 발송이 될 정상상태</li>
      <li>- 발송중 : 발송일정에 도달하여 발송진행 중 상태</li>
      <li>- 발송중지 : 발송중 상태에서 관리자가 발송중지한 상태</li>
      <li>- 발송완료 : 모든 발송이 완료된 상태</li>
    </ul>
  </div>
  <!-- //content --> 
  
  <!-- footer -->
  <div class="footer_pop"> 
    <!-- button --><a href="javascript:;" class="btn_big">확인</a><!-- //button --> 
  </div>
  <!-- //footer --> 
</div>
<!--//popup-->

<script>
  function showAlertHelp(callback) {
    $(".btn_close").on('click', function () {
      $(".popup_wrap").dialog("close");
    });
    
    $(".btn_big").on('click', function() {
      $(".popup_wrap").dialog("close");
    });

    $(".popup_wrap").dialog({
      modal: true,
      width: "670px",
      open: function() {
    	  $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }

</script>