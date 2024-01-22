<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_b	" id="popup_result" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">결과</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_result')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">프로세스명</th>
            <td>
            	<span id="process_name"></span>
            </td>
          </tr>
          <tr>
            <th scope="row">쉘</th>
            <td>
            	<span id="shell"></span>
            </td>
          </tr>
          <tr>
            <th scope="row">결과</th>
            <td><textarea id="result" style="width:400px;background-color: lightgray;height: 350px;" rows='20' cols='80'>
            </textarea></td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <a href="#" class="btn_big gray"  onclick="popClose('#popup_result')">닫기</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
    function show_result(process_name, shell, result){
        popOpen("#popup_result");        
        $("#popup_result").find("#process_name").html(process_name);
        $("#popup_result").find("#shell").html(shell);
        $("#popup_result").find("#result").val(result);
    }
</script>