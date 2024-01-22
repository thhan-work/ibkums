<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div class="popup_wrap" id="dis-preview-dialog" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">미리보기 팝업</div>
        <div class="btn_close"><a href="javascript:"><img class="preview-dialog-close" src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
        <div class="row2 pdb15">
            <div class="title_row2">MMS 이미지의 경우 통신사에 따라 이미지위치가 변동될 수 있으니 통신사별 테스트 후 이미지위치를 확인하시기 바랍니다.</div>
        </div>
        <!-- box_sms -->
        <div class="box_sms">
            <div class="text_sms2" id="msg-title-div">
                <input class="sms" type="text" id="preview-title" readonly="readonly" 
                       style="width:238px; padding-left: 15px; padding-right: 15px;">
            </div>
            <div class="content">
                <div class="text_sms2">
                    <textarea class="sms" id="preview-content"
                          style="font-family:굴림; font-size:16px; width:216px; height:305px" readonly="readonly"></textarea>
                </div>
            </div>

            <%--<div class="content">--%>
                <%--<div class="text_sms2"><textarea class="sms" id="preview-content" readonly style="width:100%; height:350px"></textarea></div>--%>
            <%--</div>--%>
        </div>
        <!-- //box_sms -->
    </div>
    <!-- //content -->

    <!-- content -->
    <%--<div class="content_pop">--%>
        <%--<!-- box_sms -->--%>
        <%--<div class="box_sms">--%>
            <%--<div class="top_sms" id="preview-title" ></div>--%>
            <%--<div class="content">--%>
                <%--<div class="text_sms2"><textarea class="sms" title="레이블 텍스트" id="preview-content" readonly style="width:100%; height:350px"></textarea></div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<!-- //box_sms -->--%>
        <%--<div class="mgt10 tac">*핸드폰 기기 종류에 따라 내용이 다르게 보일 수 있습니다.</div>--%>
    <%--</div>--%>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:" class="btn_big blue preview-dialog-close" >확인</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
  /**
   * 미리보기 팝업 함수 입니다.
   * @param title
   * @param content
   */
  function showPreviewDialog(title, content) {
    //console.log(title);
    //console.log(content);
    $(".preview-dialog-close").on('click', function () {
      $("#dis-preview-dialog").dialog("close")
    });

    if($("#msg-type").val().toUpperCase() == 'SMS'){
    	$("#preview-title").css({display : "none"})
    }else{
    	$("#preview-title").css({display: "block"});
        if(!title){title = "(제목 없음)"};
        $("#preview-title").val(title);
    }

    if(content){
      // var replaceContent = content.replace("/\n/g", "<br/>");
      $("#preview-content").text(content);
    }


    $("#dis-preview-dialog").dialog({
      modal: true,
      width: "540px",
      open: function () {
        $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
</script>