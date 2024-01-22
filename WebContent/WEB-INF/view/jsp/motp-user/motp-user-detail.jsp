<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Datatables Column Definition-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/sha256.js"></script>
        <!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<!--popup-->
<div class="popup_wrap" id="popup_wrap" style="display:none;width:1000px" >
    <!-- top -->
    <div class="top">
            <div class="title" id="popup_title">등록</div>
            <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_wrap')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
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
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr >
            <th scope="row" >로그인ID<span class="th_must">*</span></th>
            <td colspan="3">
                <input type="text" name="login_id" id="login_id" value="" placeholder="" style="width:200px; background-color: lightgray;" readonly><a href="javascript:;" id="id-chk-btn" class="btn_search mgl6">확인</a>
                <span class="th_must mgt6">&nbsp;&nbsp;&nbsp;* ID 중복 확인을 해주세요</span>
            </td>
          </tr>
          <tr>
            <th scope="row">직원ID<span class="th_must">*</span></th>
            <td><input type="text" name="empl_id" id="empl_id" value="" placeholder="" style="width:280px;" ></td>
            <th scope="row">직원명<span class="th_must">*</span></th>
            <td><input type="text" name="empl_name" id="empl_name" value="" placeholder="" style="width:280px;"></td>
          </tr>
          <tr>
          <tr>
           	<th scope="row">부서코드<span class="th_must">*</span></th>
            <td><input type="text" name="bo_code" id="bo_code" value="" placeholder="" style="width:200px; background-color: lightgray;" readonly><a href="javascript:;" id="bo-search-btn" class="btn_search mgl6">조회</a></td>
            <th scope="row">직원연락처</th>
            <td><input type="text" name="mobile" id="mobile" value="" placeholder="" style="width:280px;" ></td>
          </tr>
          <tr>
            <th scope="row">권한수준<span class="th_must">*</span></th>
            <td>
				<select class="small" id="empl_level">
	              <option value="A">관리자</option>
	              <option value="G">경조사</option>
	              <option value="M">발송모니터링</option>
	              <option value="C">발송분배비율</option>
	            </select>
            </td>
            <th scope="row">활성여부</th>
            <td>
            	<select class="small" id="use_yn">
	              <option value="Y">Y</option>
	              <option value="N">N</option>
	            </select>
            </td>
          </tr>
          <tr >
            <th scope="row" >접근IP</th>
            <td>
            	<!-- <input type="text" name="empl_ip" id="empl_ip" value="" placeholder="" style="width:280px;"> -->
            	<textarea name="empl_ip" id="empl_ip" style="width:280px; height:200px;"></textarea>
            </td>
             <th scope="row" class="modifyItem">활성여부변경일시</th>
            <td class="modifyItem"><input type="text" name="use_yn_cn_dt" id="use_yn_cn_dt" value="" style="width:280px; background-color: lightgray;" readonly></td>
          </tr>
          <tr class="modifyItem">
            <th scope="row">등록직원ID</th>
            <td><input type="text" name="reg_id" id="reg_id" value="" style="width:280px; background-color: lightgray;" readonly ></td>
            <th scope="row">등록일시</th>
            <td><input type="text" name="reg_dt" id="reg_dt" value="" style="width:280px; background-color: lightgray;" readonly></td>
          </tr>
          <tr class="modifyItem">
            <th scope="row">로그인일시</th>
            <td><input type="text" name="login_dt" id="login_dt" value="" style="width:280px; background-color: lightgray;" readonly ></td>
            <th scope="row">로그인실패횟수</th>
            <td><input type="text" name="login_fail_cn" id="login_fail_cn" value="" style="width:280px;"></td>
          </tr>
          <tr class="modifyItem">
            <th scope="row">수정일시</th>
            <td><input type="text" name="mod_dt" id="mod_dt" value="" style="width:280px; background-color: lightgray;" readonly ></td>
            <th scope="row">수정직원ID</th>
            <td><input type="text" name="mod_id" id="mod_id" value="" style="width:280px; background-color: lightgray;" readonly ></td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" id="save_btn" class="btn_big blue">확인</a><a href="javascript:;" class="btn_big gray"  onclick="popClose('#popup_wrap')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->
<!-- user detail popup -->

<jsp:include page="../common/bosearch-list.jsp" flush="true"/>
<script>
	var popType = "등록";
	var chk_id=false;
	var chk_pw=false;
	
    // ID중복 버튼 클릭 이벤트 리스너 등록
    $("#id-chk-btn").on('click', check_id);
    
	function check_id(){
		if($("#login_id").val()==null||$("#login_id").val().trim()==""){
			   showAlert("ID 입력 후 재 시도 바랍니다.");
        	   document.getElementById("login_id").focus();
        	   return false;
		}
	    $.ajax({
	        url: '${pageContext.request.contextPath}/motpuser/' + $("#login_id").val() +'/count',
	            type: 'GET',
	            success: function (result) {
	               if(result >= 1){
	            	   showAlert("중복된 ID 입니다. ID 재설정 바랍니다.");
	            	   
	            	   document.getElementById("login_id").focus();
	               }else{
	            	   showAlert("사용 가능한 ID 입니다.");	       
	            	   chk_id=true;
	               }
	        }
	    });
	}
    // 엔터키 이벤트 리스너
    $("#login_id").keypress(function (event) {
        if (event.which == 13) {
            event.preventDefault();
            check_id();
        }
    });
	   
    $('#login_id').change(function() {    	
    	chk_id=false;
    });
    
    //등록-수정 버튼 클릭 시작
    $("#save_btn").on('click', function(){
    	isModify = false;
    	
    	if(popType == "수정"){
    		isModify = true;
    	}
    	
    	if(!isModify && !chk_id){
    		showAlert("ID 중복 확인을 해주세요");
     	   	document.getElementById("login_id").focus();
     	   	return false;
    	}
    	
    	if($("#empl_id").val().trim()==""){
    		showAlert("직원ID를 입력 해주세요");
     	   	document.getElementById("empl_id").focus();
     	   	return false;
    	}
    	
    	if($("#empl_name").val().trim()==""){
    		showAlert("직원명를 입력 해주세요");
     	   	document.getElementById("empl_name").focus();
     	   	return false;
    	}
    	
    	if($("#bo_code").val().trim()==""){
    		showAlert("부서 코드를 입력 해주세요");
     	   	document.getElementById("bo_code").focus();
     	   	return false;
    	}

    	if($("#empl_level :selected").val()==""){
    		showAlert("권한 수준을 선택 해주세요");
     	   	document.getElementById("empl_level").focus();
     	   	return false;
    	}

    	if($("#empl_level :selected").val()!="A" && $("#empl_level :selected").val()!="M" &&
    			$("#empl_level :selected").val()!="G"&& $("#empl_level :selected").val()!="C"){
    		showAlert("권한 수준을 다시 선택 해주세요");
   		  	$("#empl_level").val("A").prop("selected", true);
     	   	document.getElementById("empl_level").focus();
     	  	return false;
    	}
    	
    	if($("#use_yn :selected").val()==""){
    		showAlert("활성 여부를 선택 해주세요");
     	   	document.getElementById("use_yn").focus();
     	    return false;
    	}
    	
    	if($("#use_yn :selected").val()!="Y"&&$("#use_yn :selected").val()!="N"){
    		showAlert("활성 여부를 다시 선택 해주세요");
   		  	$("#use_yn").val("Y").prop("selected", true);
     	   	document.getElementById("use_yn").focus();
     	     return false;
    	}
		
    	var loginUserInfo=getLoginUserInfo();
    	if(popType == "수정"){
    		login_user_update(loginUserInfo);
    	}else{
    		login_user_registration(loginUserInfo);
    	}
    });//등록-수정 버튼 클릭  끝

	function getLoginUserInfo() {
	    return {   
	        "login_id": $("#login_id").val(),
	      	"empl_id": $("#empl_id").val(),
	      	"empl_name": $("#empl_name").val(),
	      	"bo_code": $("#bo_code").val(),
	      	"mobile": $("#mobile").val(),
	      	"empl_level": $("#empl_level :selected").val(),
	      	"use_yn": $("#use_yn :selected").val(),
	      	"empl_ip": $("#empl_ip").val(),
	      	"login_fail_cn":	$("#login_fail_cn").val()	      	
	    };
  }  
  
  function setEmployeeInfo(result) {
	  popType = "수정";
	  $(".th_must").hide();	  
	  $("#popup_title").text("수정");
	  $("#save_btn").text("수정");
	  $(".th_must").hide();
	  $("#login_id").css('background-color','lightgray');
	  $("#login_id").prop('readonly', true);
	  $("#id-chk-btn").hide();
	  $(".mgt6").hide();
	  $(".mgb10").hide();	  
	  $(".modifyItem").show();
	  $('#empl_ip').parent().prop("colspan",1);
	  
	  
	  $("#login_id").val(result.LOGIN_ID);
	  $('#empl_id').val(result.EMPL_ID);
	  $("#empl_name").val(result.EMPL_NAME);	  
	  $("#bo_code").val(result.BO_CODE);
	  if(result.MOBILE !=null)$("#mobile").val(result.MOBILE);
	  $("#empl_level").val(result.EMPL_LEVEL).prop("selected", true);
	  $("#use_yn").val(result.USE_YN).prop("selected", true);
	  if(result.EMPL_IP !=null)$("#empl_ip").val(result.EMPL_IP);
	  if(result.USE_YN_CN_DT !=null)$("#use_yn_cn_dt").val(viewDate(result.USE_YN_CN_DT));
	  if(result.REG_ID !=null)$("#reg_id").val(result.REG_ID);
	  if(result.REG_DT !=null)$("#reg_dt").val(viewDate(result.REG_DT));
	  if(result.LOGIN_DT !=null)$("#login_dt").val(viewDate(result.LOGIN_DT));
	  $("#login_fail_cn").val(result.LOGIN_FAIL_CN);
	  if(result.MOD_DT !=null)$("#mod_dt").val(viewDate(result.MOD_DT));
	  if(result.MOD_ID !=null)$("#mod_id").val(result.MOD_ID);
	  
  }
  
  //초기화
  function initEmployeeInfo() {
	  popType = "등록";	  
	  $("#popup_title").text("등록");
	  $("#save_btn").text("등록");
	  
	  $(".th_must").show();
	  
	  chk_id=false;
	  chk_pw=false;
	  
	  $("#login_id").css('background-color','#ffffff');
	  $("#login_id").prop('readonly', false);
	  
	  $("#id-chk-btn").show();
	  $(".mgb10").show();
	  $(".mgt6").show();
	  
	  $(".modifyItem").hide();
	 
	  $("#login_id").val("");
	  $('#empl_id').val("");
	  $("#empl_name").val("");
	  $("#bo_code").val("");
	  $("#mobile").val("");
	  $("#empl_level").val("A").prop("selected", true);
	  $("#use_yn").val("Y").prop("selected", true);
	  $('#empl_ip').val("");
	  $('#empl_ip').parent().prop("colspan",3);

  }
  function login_user_update(loginUserInfo){
	    $.ajax({
	      url: '${pageContext.request.contextPath}/motpuser',
	      type: "PUT",
	      contentType: "application/json; charset=utf-8",
	      dataType: "json",
	      data: JSON.stringify(loginUserInfo),
	      success: function (result) {
	        showAlert("정보 " + popType + "을 완료 되었습니다.");
	        popClose('#popup_wrap');
	        reload();
	      }
	    });
  }
  
  function login_user_registration(loginUserInfo){
	    $.ajax({
	      url: '${pageContext.request.contextPath}/motpuser',
	      type: "POST",
	      contentType: "application/json; charset=utf-8",
	      dataType: "json",
	      data: JSON.stringify(loginUserInfo),
	      success: function (result) {
	   	    showAlert("정보 " + popType + "을 완료 되었습니다.");
	        popClose('#popup_wrap');
	        reload();
	      }
	    });
  }
  
  // 검색 버튼 클릭 이벤트 리스너 등록
  $("#bo-search-btn").on('click', bo_search);
  function bo_search(){
      boSearchInit("");
  }
  
  function viewDate(param){
	  var yyyy=param.substring(0,4);
	  var mm=param.substring(4,6);
	  var dd=param.substring(6,8);
	  var hh=param.substring(8,10);
	  var m=param.substring(10,12);
	  var ss=param.substring(12,14);
	  return yyyy+"-"+mm+"-"+dd+" "+hh+":"+m+":"+ss;
  }
  function restoreDate(param){
	  return param.replace(/-/g,"").replace(/:/g,"").replace(/ /g,"");
  }
</script>

