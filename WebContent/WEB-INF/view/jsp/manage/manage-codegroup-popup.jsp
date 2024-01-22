<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_b" id="popup_regist" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">등록</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_regist')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <div class="info mgb10"><span>* 필수항목 표시</span></div>
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">공통그룹코드<span class="th_must">*</span></th>
            <td>
                <input type="text" name="cmmnCd" id="cmmnCd" value="" placeholder="" maxlength="20" style="width:280px;">
            </td>
          </tr>
          <tr>
            <th scope="row">공통그룹코드명<span class="th_must">*</span></th>
            <td><input type="text" name="inst" id="inst" value="" placeholder="" maxlength="20" style="width:280px;"></td>
          </tr>
          <tr>
            <th scope="row">활성여부<span class="th_must">*</span></th>
            <td>
            	<select style="width:100px;" id="useYn">
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
            </td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="#" id="save_codegroup_btn" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  onclick="popClose('#popup_regist')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<!--popup-->
<div class="popup_wrap_b" id="popup_modify" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">수정</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_modify')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <div class="info mgb10"><span>* 필수항목 표시</span></div>
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">공통그룹코드<span class="th_must">*</span></th>
            <td>
                <input type="text" name="cmmnCd" id="cmmnCd" value="" placeholder="" maxlength="20" style="width:280px;background-color: lightgray;" readonly>
            </td>
          </tr>
          <tr>
            <th scope="row">공통그룹코드명<span class="th_must">*</span></th>
            <td><input type="text" name="inst" id="inst" value="" placeholder="" maxlength="20" style="width:280px;"></td>
          </tr>
          <tr>
            <th scope="row">활성여부<span class="th_must">*</span></th>
            <td>
            	<select style="width:100px;" id="useYn">
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
            </td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="#" id="update_codegroup_btn" class="btn_big blue">수정</a><a href="#" class="btn_big gray"  onclick="popClose('#popup_modify')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
    function registration_init(){
        popOpen("#popup_regist");
        resetCodeGroupInfo($("#popup_regist"));
        $("#popup_regist").find("#cmmnCd").focus();
    }
    
    function modification_init(){
        popOpen("#popup_modify");
        resetCodeGroupInfo($("#popup_modify"));
    }
    	 
   	 $("#popup_modify").find("#update_codegroup_btn").on('click', function(){
   		var popup = $("#popup_modify");
 		 var codeGroupInfo = getCodeGroupInfo(popup);
 		 if (codeGroupInfo.cmmnCd == "") {
 			showAlert("그룹코드를 입력하세요.");
         	$("#alert-modal").parent().css({'z-index':10000000});
         	popup.find("#cmmnCd").focus();
         	return;
 		 }
 		 if (codeGroupInfo.inst == "") {
 			showAlert("그룹코드명을 입력하세요.");
         	$("#alert-modal").parent().css({'z-index':10000000});
         	popup.find("#inst").focus();
         	return;
		 }
 		 if (codeGroupInfo.useYn == "") {
 			showAlert("활성여부를 선택하세요.");
         	$("#alert-modal").parent().css({'z-index':10000000});
         	popup.find("#useYn").focus();
         	return;
		 }
 		 
        codeGroupUpdate(codeGroupInfo);
   	 });
       	 
  	 $("#popup_regist").find("#save_codegroup_btn").on('click', function(){
  		 var popup = $("#popup_regist");
  		 var codeGroupInfo = getCodeGroupInfo(popup);
  		 if (codeGroupInfo.cmmnCd == "") {
  			showAlert("그룹코드를 입력하세요.");
          	$("#alert-modal").parent().css({'z-index':10000000});
          	popup.find("#cmmnCd").focus();
          	return;
  		 }
  		 if (codeGroupInfo.inst == "") {
  			showAlert("그룹코드명을 입력하세요.");
          	$("#alert-modal").parent().css({'z-index':10000000});
          	popup.find("#inst").focus();
          	return;
 		 }
  		 if (codeGroupInfo.useYn == "") {
  			showAlert("활성여부를 선택하세요.");
          	$("#alert-modal").parent().css({'z-index':10000000});
          	popup.find("#useYn").focus();
          	return;
		 }
      	 $.ajax({
              url: '${pageContext.request.contextPath}/manage-codegroup/' + popup.find("#cmmnCd").val() +'/count',
                  type: 'GET',
                  success: function (result) {
                     if(result >= 1){
                    	showAlert("해당 공통코드는 이미 존재합니다.");
                      	$("#alert-modal").parent().css({'z-index':10000000});
                     }else{
                    	codeGroupRegistration(codeGroupInfo);
                     }
              }
          });
    });

  function getCodeGroupInfo(popup) {
    return {
      "cmmnCd": popup.find("#cmmnCd").val(),
      "inst": popup.find("#inst").val(),
      "useYn": popup.find("#useYn").val()
    };
  }
  function resetCodeGroupInfo(popup) {
	  popup.find("#cmmnCd").val("");
	  popup.find("#inst").val("");
	  popup.find("#useYn").val("Y");
  }
  
   function setCodeGroupInfo(popup, result) {
	   popup.find("#cmmnCd").val(result.cmmnCd);
	   popup.find("#inst").val(result.inst);
	   popup.find("#useYn").val(result.useYn);
  }
   
  function codeGroupUpdate(codeGroupInfo){
    $.ajax({
      url: '${pageContext.request.contextPath}/manage-codegroup/'+ codeGroupInfo.cmmnCd,
      type: "PUT",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(codeGroupInfo),
      success: function (result) {
        showAlert("정보 수정이 되었습니다.");
        $("#alert-modal").parent().css({'z-index':10000000});
        popClose('#popup_modify');
        IbkDataTable.reload();
      }
    });
  }
  
  function codeGroupRegistration(codeGroupInfo){
    $.ajax({
      url: '${pageContext.request.contextPath}/manage-codegroup',
      type: "POST",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(codeGroupInfo),
      success: function (result) {
        showAlert("정보 등록을 완료 하였습니다.");
        $("#alert-modal").parent().css({'z-index':10000000});
        popClose('#popup_regist');
        IbkDataTable.reload();
      }
    });
  }
</script>