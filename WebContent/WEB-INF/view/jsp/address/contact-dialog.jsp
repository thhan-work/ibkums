<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_m" id="popup_wrap" style="display:none">
    <!-- top -->
    <div class="top">
        <div class="title" id="popup_employee_title">등록</div>
        <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_wrap')"><img
                src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기"/></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
        <div class="info mgb10"><span>* 필수항목 표시</span></div>
        <!-- table_view -->
        <div class="tbl_wrap_view">
            <table class="tbl_view01">
                <colgroup>
                <col style="width:150px" />
                <col style="width:325px" />
                <col style="width:150px" />
                <col style="width:325px" />
                </colgroup>
                <tr>
                    <th scope="row">이름</th>
                    <td colspan="3"><input type="text" name="firstName" id="firstName" value="" style="width:745px" maxlength="50"></td>
                    </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td colspan="3"><input type="text" name="eMail1" id="eMail1" value="" style="width:745px" maxlength="32"></td>
                    </tr>
                <tr>
                    <th scope="row">휴대폰번호</th>
                    <td><input type="text" name="mobile" id="mobile" value="" style="width:270px" maxlength="24"></td>
                    <th>FAX번호</th>
                    <td><input type="text" name="homeFax" id="homeFax" value="" style="width:270px" maxlength="24"></td>
                </tr>
                <tr>
                    <th scope="row">소속</th>
                    <td><input type="text" name="department" id="department" value="" style="width:270px" maxlength="32"></td>
                    <th>회사번호</th>
                    <td><input type="text" name="comPhone" id="comPhone" value="" style="width:270px" maxlength="48"></td>
                </tr>
                <tr>
                     <th scope="row">그룹</th>
                     <td colspan="3">
			            <input type="text" name="grpName" id="grpName" value="${address.groupName}" readonly />
                     </td>
                </tr>
                <tr>
                    <th scope="row">생년월일</th>
                    <td colspan="3">
                    	<input type="hidden" name="grpSeq" id="grpSeq" value="${address.grpSeq}"/>
                    	<input type="hidden" name="birthday" id="birthday" />
                    	<input type="hidden" name="emplId" id="emplId" value="${address.emplId}" />
                		<span>
	                		<select name="yyyy" id="yyyy">
	              				<option value="">선택</option>
	              				<c:forEach begin="1920" end="2018" var="item">
	                				<option value="${item}">${item}</option>
	             				</c:forEach>
	           				</select>
           				</span><span class="text1" style="margin-right:5px;">년 </span>  
           				<span>
	           				<select name="mm" id="mm">
	              				<option value="">선택</option>
	              				<c:forEach begin="1" end="12" var="item">
	                				<option value="<fmt:formatNumber value="${item}" pattern="00" />"><fmt:formatNumber value="${item}" pattern="00" /></option>
	              				</c:forEach>
	            			</select>
            			</span><span class="text1" style="margin-right:5px;">월 </span>
            			<span>
	            			<select name="dd" id="dd">
	              				<option value="">선택</option>
	              				<c:forEach begin="1" end="31" var="item">
	                				<option value="<fmt:formatNumber value="${item}" pattern="00" />"><fmt:formatNumber value="${item}" pattern="00" /></option>
	              				</c:forEach>  
	            			</select>
            			</span><span class="text1">일 </span>
                    	<div class="radio_default fn disib mgl10 mgr6" style="margin-top:2px;">
                        	<input type="radio"  id="radio1_r" name="yinyang" value="1"/>
                        	<label for="radio1_r">양력</label>
                  		</div>
                    	<div class="radio_default fn disib" style="margin-top:2px;">
                        	<input type="radio" id="radio2_r" name="yinyang" value="0" />
                        	<label for="radio2_r">음력</label>
                  		</div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">성별</th>
                    <td colspan="3">
                    	<div class="radio_default mgr15">
                        	<input type="radio" id="radio3_r" name="sex" value="1"/>
                        	<label for="radio3_r">남자</label>
                  		</div>
                    	<div class="radio_default">
                        	<input type="radio" id="radio4_r" name="sex" value="0"/>
                        	<label for="radio4_r">여자</label>
                  		</div>
                  	</td>
                    </tr>
                <tr>
                    <th scope="row">직책</th>
                    <td><input type="text" name="title" id="title" value="" style="width:270px" maxlength="50"></td>
                    <th>집전화번호</th>
                    <td><input type="text" name="homePhone" id="homePhone" value="" style="width:270px" maxlength="48"></td>
                </tr>
                <tr>
                    <th scope="row">소개</th>
                    <td colspan="3"><textarea style="width:740px; height:160px" id="remark" name="remark"></textarea>
                    <div class="info2 mgt5">※ 한글 50자, 영숫자 100자까지 입력가능합니다. (<span><span id="byte">0</span>/100</span> byte)</div>
                    </td>
                    </tr>
              </table>
        </div>
        <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:" class="btn_big blue" id="add-btn">등록</a>
        <a href="javascript:;" class="btn_big gray" onclick="popClose('#popup_wrap')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<!--popup-->
<div class="popup_wrap_m" id="popup_wrap_m" style="display:none">
    <!-- top -->
    <div class="top">
        <div class="title" id="popup_employee_title">수정</div>
        <div class="btn_close"><a href="javascript:;" onclick="popClose('#popup_wrap_m')"><img
                src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기"/></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
        <div class="info mgb10"><span>* 필수항목 표시</span></div>
        <!-- table_view -->
        <div class="tbl_wrap_view">
            <table class="tbl_view01">
                <colgroup>
                <col style="width:150px" />
                <col style="width:325px" />
                <col style="width:150px" />
                <col style="width:325px" />
                </colgroup>
                <tr>
                    <th scope="row">이름</th>
                    <td colspan="3"><input type="text" name="firstName" id="firstName" value="" style="width:745px" maxlength="50"></td>
                    </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td colspan="3"><input type="text" name="eMail1" id="eMail1" value="" style="width:745px" maxlength="32"></td>
                    </tr>
                <tr>
                    <th scope="row">휴대폰번호</th>
                    <td><input type="text" name="mobile" id="mobile" value="" style="width:270px" maxlength="24"></td>
                    <th>FAX번호</th>
                    <td><input type="text" name="homeFax" id="homeFax" value="" style="width:270px" maxlength="24"></td>
                </tr>
                <tr>
                    <th scope="row">소속</th>
                    <td><input type="text" name="department" id="department" value="" style="width:270px" maxlength="32"></td>
                    <th>회사번호</th>
                    <td><input type="text" name="comPhone" id="comPhone" value="" style="width:270px" maxlength="48"></td>
                </tr>
                <tr>
                     <th scope="row">그룹선택</th>
                     <td colspan="3">
			            <input type="text" name="grpName" id="grpName" value="${address.groupName}" readonly />
                     </td>
                </tr>
                <tr>
                    <th scope="row">생년월일</th>
                    <td colspan="3">
                    	<input type="hidden" name="grpSeq" id="grpSeq" value="${address.grpSeq}"/>
                    	<input type="hidden" name="birthday" id="birthday" />
                    	<input type="hidden" name="emplId" id="emplId" value="${address.emplId}" />
                    	<input type="hidden" name="catSeq" id="catSeq" value="" />
                		<span>
	                		<select name="yyyy" id="yyyy">
	              				<option value="default">선택</option>
	              				<c:forEach begin="1920" end="2018" var="item">
	                				<option value="${item}">${item}</option>
	             				</c:forEach>
	           				</select>
           				</span><span class="text1" style="margin-right:5px;">년 </span>  
           				<span>
	           				<select name="mm" id="mm">
	              				<option value="default">선택</option>
	              				<c:forEach begin="1" end="12" var="item">
	                				<option value="<fmt:formatNumber value="${item}" pattern="00" />"><fmt:formatNumber value="${item}" pattern="00" /></option>
	              				</c:forEach>
	            			</select>
            			</span><span class="text1" style="margin-right:5px;">월 </span>
            			<span>
	            			<select name="dd" id="dd">
	              				<option value="default">선택</option>
	              				<c:forEach begin="1" end="31" var="item">
	                				<option value="<fmt:formatNumber value="${item}" pattern="00" />"><fmt:formatNumber value="${item}" pattern="00" /></option>
	              				</c:forEach>  
	            			</select>
            			</span><span class="text1">일 </span>
                    	<div class="radio_default fn disib mgl10 mgr6" style="margin-top:2px;">
                        	<input type="radio"  id="radio1" name="yinyang" value="1"/>
                        	<label for="radio1">양력</label>
                  		</div>
                    	<div class="radio_default fn disib" style="margin-top:2px;">
                        	<input type="radio" id="radio2" name="yinyang" value="0"/>
                        	<label for="radio2">음력</label>
                  		</div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">성별</th>
                    <td colspan="3">
                    	<div class="radio_default mgr15">
                        	<input type="radio" id="radio3" name="sex" value="1"/>
                        	<label for="radio3">남자</label>
                  		</div>
                    	<div class="radio_default">
                        	<input type="radio" id="radio4" name="sex" value="0"/>
                        	<label for="radio4">여자</label>
                  		</div>
                  	</td>
                    </tr>
                <tr>
                    <th scope="row">직책</th>
                    <td><input type="text" name="title" id="title" value="" style="width:270px" maxlength="50"></td>
                    <th>집전화번호</th>
                    <td><input type="text" name="homePhone" id="homePhone" value="" style="width:270px" maxlength="48"></td>
                </tr>
                <tr>
                    <th scope="row">소개</th>
                    <td colspan="3"><textarea style="width:740px; height:160px" id="remark" name="remark"></textarea>
                    <div class="info2 mgt5">※ 한글 50자, 영숫자 100자까지 입력가능합니다. (<span><span id="byte">0</span>/100</span> byte)</div>
                    </td>
                    </tr>
              </table>
        </div>
        <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button -->
        <a href="javascript:" class="btn_big blue" id="modify-btn">수정</a>
        <a href="javascript:;" class="btn_big gray" onclick="popClose('#popup_wrap_m')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<!-- Script -->
<script>
	
  $(document).ready(function () {
    enterKeyListener();
    var remarkLen=getByteLength($("#remark").val());
    if(remarkLen>0){
    	$("#byte").text(remarkLen);
    }
  });
  
  function openRegistDialog() {
	  // init dialog
	  $("#popup_wrap").find("#firstName").val("");
	  $("#popup_wrap").find("#eMail1").val("");
	  $("#popup_wrap").find("#mobile").val("");
	  $("#popup_wrap").find("#homeFax").val("");
	  $("#popup_wrap").find("#department").val("");
	  $("#popup_wrap").find("#comPhone").val("");
	  
	  $("#popup_wrap").find("#yyyy").val("");
	  $("#popup_wrap").find("#mm").val("");
	  $("#popup_wrap").find("#dd").val("");
	  
	  // yinyang
	  $("#popup_wrap").find("input[name='yinyang'][value='1']").prop("checked", true);
	  // sex
	  $("#popup_wrap").find("input[name='sex'][value='1']").prop("checked", true);
	  
	  $("#popup_wrap").find("#title").val("");
	  $("#popup_wrap").find("#homePhone").val("");
	  $("#popup_wrap").find("#remark").val("");
	  
	  // show dialog
	  popOpen("#popup_wrap");
  }
  
  function openModifyDialog(emplId, grpSeq, catSeq) {
	  
	  $.ajax({
	        url: '${pageContext.request.contextPath}/getContact',
	        type: 'POST',
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        data: JSON.stringify({
	        	emplId: emplId
	        	, grpSeq: grpSeq
	        	, catSeq: catSeq
	        }),
	        success: function (result) {
	            if (result) {
	            	// init dialog
	          	  $("#popup_wrap_m").find("#firstName").val(result.firstName);
	          	  $("#popup_wrap_m").find("#eMail1").val(result.eMail1);
	          	  $("#popup_wrap_m").find("#mobile").val(result.mobile);
	          	  $("#popup_wrap_m").find("#homeFax").val(result.homeFax);
	          	  $("#popup_wrap_m").find("#department").val(result.department);
	          	  $("#popup_wrap_m").find("#comPhone").val(result.comPhone);
	          	  $("#popup_wrap_m").find("#catSeq").val(result.catSeq);
	          	  // yinyang
	          	  $("#popup_wrap_m").find("input[name='yinyang'][value='"+result.yinyang+"']").prop("checked", true);
	          	  // sex
	          	  $("#popup_wrap_m").find("input[name='sex'][value='"+result.sex+"']").prop("checked", true);
	          	  
	          	  $("#popup_wrap_m").find("#title").val(result.title);
	          	  $("#popup_wrap_m").find("#homePhone").val(result.homePhone);
	          	  $("#popup_wrap_m").find("#remark").val(result.remark);
	          	  $("#popup_wrap_m").find("#remark").trigger("keyup");
	          	  // birthday
	          	  var birthday = result.birthday;
	          	  if (birthday.length == 10) {
	          		$("#popup_wrap_m").find("select[name='yyyy'] > option[value='"+birthday.substring(0,4)+"']").prop("selected", true);
	          		$("#popup_wrap_m").find("select[name='mm'] > option[value='"+birthday.substring(5,7)+"']").prop("selected", true);
	          		$("#popup_wrap_m").find("select[name='dd'] > option[value='"+birthday.substring(8,10)+"']").prop("selected", true);
	          	  }
	            }
	        }
	  });	
	  
	  // show dialog
	  popOpen("#popup_wrap_m");
  }
  
  
  $("#popup_wrap").find("#remark").on("keyup", function() {
	    var length = getByteLength($(this).val());
	    if(length > 100) {
	    	showAlert("※ 한글 50자, 영숫자 100자까지 입력가능합니다.");
			var idx = 0;
			for(var i=length; i > 100;idx++){
				$(this).val($(this).val().substr(0,(100-idx)));
				i = getByteLength($(this).val());
			}
			length = getByteLength($(this).val());
	    }

	    $("#popup_wrap").find("#byte").text(length);
  });
  
  $("#popup_wrap_m").find("#remark").on("keyup", function() {
	    var length = getByteLength($(this).val());
	    if(length > 100) {
	    	showAlert("※ 한글 50자, 영숫자 100자까지 입력가능합니다.");
			var idx = 0;
			for(var i=length; i > 100;idx++){
				$(this).val($(this).val().substr(0,(100-idx)));
				i = getByteLength($(this).val());
			}
			length = getByteLength($(this).val());
	    }

	    $("#popup_wrap_m").find("#byte").text(length);
	});
  
////핸드폰 번호 숫자입력 체크 이벤트
  $("#popup_wrap").find("#homePhone").on("keyup", function(){
  	inputPhoneType($(this));
  });
  $("#popup_wrap").find("#mobile").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  $("#popup_wrap").find("#homeFax").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  $("#popup_wrap").find("#comPhone").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  
  $("#popup_wrap_m").find("#homePhone").on("keyup", function(){
  	inputPhoneType($(this));
  });
  $("#popup_wrap_m").find("#mobile").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  $("#popup_wrap_m").find("#homeFax").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  $("#popup_wrap_m").find("#comPhone").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  
  // 확인 버튼 클릭 처리
  $("#popup_wrap").find("#add-btn").click(function(){
	  	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})?[0-9]{3,4}?[0-9]{4}$/;
	    /* 	    var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; */
	    var name= $("#popup_wrap").find("#firstName").val().trim();
	    var email = $("#popup_wrap").find("#eMail1").val().trim();
	    var mobile = $("#popup_wrap").find("#mobile").val().trim().replace(/[^0-9]/g,"");
	    var homeFax = $("#popup_wrap").find("#homeFax").val().trim();
	    var comPhone = $("#popup_wrap").find("#comPhone").val().trim();
	    var homePhone = $("#popup_wrap").find("#homePhone").val().trim();	
	    var department = $("#popup_wrap").find("#department").val().trim();	
	    var title = $("#popup_wrap").find("#title").val().trim();	
	    var remark = $("#popup_wrap").find("#remark").val().trim();
	    
	    if(name==null||name==""){
	    	showAlert("이름 항목의 값을 입력해주세요.", function() {
	    		$("#popup_wrap").find("#firstName").focus();
	    	});
	    	return false;
	    }
	    if((email == null || email == '') && (mobile == null || mobile == '') && (homeFax == null || homeFax == '')) {
	    	showAlert("휴대폰번호, FAX 번호 중 최소 한가지 이상 입력해 주세요.", function() {
	    		$("#popup_wrap").find("#mobile").focus();
	    	});
	        return false;
	   	}

	    if(mobile != null && mobile != '' && !regExp.test(mobile)) {
	        showAlert("휴대폰번호를 정확히 입력해 주세요.");
	        return false;
	    }
	    var grpSeq = $("#popup_wrap").find("#grpSeq").val();
/* 	    if($("select[name=grpSeq]").val() == 'default'||$("select[name=grpSeq]").val() == ''||$("select[name=grpSeq]").val() == null) {
	    	showAlert("그룹을 선택해 주세요.");
	        return false;
	    } */
	    var year = $("#popup_wrap").find("select[name=yyyy]").val();
	    var month = $("#popup_wrap").find("select[name=mm]").val();
	    var day = $("#popup_wrap").find("select[name=dd]").val();
	    var birthday=year + "-" + month + "-" + day;
	    if(year!='' && month !='' && day !=''){
	    	$("#popup_wrap").find("input[name=birthday]").val(birthday);      
	    } else {
	    	$("#popup_wrap").find("input[name=birthday]").val("");   
	    }
	  
	  	var contactInfo = {};
	  	contactInfo.firstName=name;
	  	contactInfo.firstName=name;
	    contactInfo.eMail1=email;
	    contactInfo.mobile=mobile;
	    contactInfo.homeFax=homeFax;
	    contactInfo.department=department;
	    contactInfo.comPhone=comPhone;
	    contactInfo.grpSeq=grpSeq;
	    contactInfo.birthday=birthday;
	    contactInfo.yinyang=$('input[name="yinyang"]:checked').val();
	    contactInfo.sex=$('input[name="sex"]:checked').val();
	    contactInfo.title=title;
	    contactInfo.homePhone=homePhone;
	 	contactInfo.remark=$("#remark").val().trim();
	 	contactInfo.emplId="${address.emplId}";
	 	contactInfo.remark=remark;
	 	
	 	showConfirmForAjax("등록", "해당 연락처를 등록 하시겠습니까?", function(contactInfo) {
	 		$.ajax({
		        url: '${pageContext.request.contextPath}/contacta',
		        type: 'POST',
		           contentType: "application/json; charset=utf-8",
		           dataType: "json",
		           data: JSON.stringify(contactInfo),
		           success: function (result) {
		           	  showAlert("연락처가 등록되었습니다.");
		       		  // close dialog
		    	      popClose("#popup_wrap");
		    	      IbkDataTable.reload();
		          }
		    })	
	 	}, contactInfo);
	 	
  });
  
  
//확인 버튼 클릭 처리
  $("#popup_wrap_m").find("#modify-btn").click(function(){
	  	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})?[0-9]{3,4}?[0-9]{4}$/;
	    /* 	    var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; */
	    var name= $("#popup_wrap_m").find("#firstName").val().trim();
	    var email = $("#popup_wrap_m").find("#eMail1").val().trim();
	    var mobile = $("#popup_wrap_m").find("#mobile").val().trim().replace(/[^0-9]/g,"");
	    var homeFax = $("#popup_wrap_m").find("#homeFax").val().trim();
	    var comPhone = $("#popup_wrap_m").find("#comPhone").val().trim();
	    var homePhone = $("#popup_wrap_m").find("#homePhone").val().trim();	
	    var department = $("#popup_wrap_m").find("#department").val().trim();	
	    var title = $("#popup_wrap_m").find("#title").val().trim();	
	    var remark = $("#popup_wrap_m").find("#remark").val().trim();
	    
	    if(name==null||name==""){
	    	showAlert("이름 항목의 값을 입력해주세요.", function() {
	    		$("#popup_wrap_m").find("#firstName").focus();
	    	});
	    	return false;
	    }
	    if((email == null || email == '') && (mobile == null || mobile == '') && (homeFax == null || homeFax == '')) {
	    	showAlert("휴대폰번호, FAX 번호 중 최소 한가지 이상 입력해 주세요.", function() {
	    		$("#popup_wrap_m").find("#mobile").focus();
	    	});
	        return false;
	   	}

	    if(mobile != null && mobile != '' && !regExp.test(mobile)) {
	        showAlert("휴대폰번호를 정확히 입력해 주세요.");
	        return false;
	    }
	    var grpSeq = $("#popup_wrap_m").find("#grpSeq").val();
/* 	    if($("select[name=grpSeq]").val() == 'default'||$("select[name=grpSeq]").val() == ''||$("select[name=grpSeq]").val() == null) {
	    	showAlert("그룹을 선택해 주세요.");
	        return false;
	    } */
	    var year = $("#popup_wrap_m").find("select[name=yyyy]").val();
	    var month = $("#popup_wrap_m").find("select[name=mm]").val();
	    var day = $("#popup_wrap_m").find("select[name=dd]").val();
	    var birthday=year + "-" + month + "-" + day;
	    if(year!='' && month !='' && day !=''){
	    	$("#popup_wrap_m").find("input[name=birthday]").val(birthday);      
	    } else {
	    	$("#popup_wrap_m").find("input[name=birthday]").val("");   
	    }
	  
	  	var contactInfo = {};
	  	contactInfo.firstName=name;
	  	contactInfo.firstName=name;
	    contactInfo.eMail1=email;
	    contactInfo.mobile=mobile;
	    contactInfo.homeFax=homeFax;
	    contactInfo.department=department;
	    contactInfo.comPhone=comPhone;
	    contactInfo.grpSeq=grpSeq;
	    contactInfo.birthday=birthday;
	    contactInfo.yinyang=$("#popup_wrap_m").find('input[name="yinyang"]:checked').val();
	    contactInfo.sex=$("#popup_wrap_m").find('input[name="sex"]:checked').val();
	    contactInfo.title=title;
	    contactInfo.homePhone=homePhone;
	 	contactInfo.remark=$("#popup_wrap_m").find("#remark").val().trim();
	 	contactInfo.catSeq=$("#popup_wrap_m").find("#catSeq").val().trim();
	 	contactInfo.emplId="${address.emplId}";
	 	contactInfo.remark=remark;
	 	
	 	showConfirmForAjax("수정", "해당 연락처를 수정 하시겠습니까?", function(contactInfo) {
	 		$.ajax({
		        url: '${pageContext.request.contextPath}/contactModifya',
		        type: 'POST',
		           contentType: "application/json; charset=utf-8",
		           dataType: "json",
		           data: JSON.stringify(contactInfo),
		           success: function (result) {
		           	  showAlert("연락처가 수정되었습니다.");
		       		  // close dialog
		    	      popClose("#popup_wrap_m");
		    	      IbkDataTable.reload();
		          }
		    })	
	 	}, contactInfo);
	 	
  });
  
  //소개 글자 길이 계산-asis function
  function getByteLength(str){
	  var resultSize = 0;
	  if(str == null) return 0;
	  
	  for(var i=0; i<str.length; i++) {
	    var c = escape(str.charAt(i));
	    
	    if(c.length == 1) {
	      resultSize ++;
	    } else if(c.indexOf("%u") != -1) {
	      resultSize += 2;
	    } else if(c.indexOf("%") != -1) {
	      resultSize += c.length/3;
	    }
	  }
	  return resultSize;
	}	

  function redirectList() {
	    /* setTimeout(function () {
	      window.location.href = "${pageContext.request.contextPath}/all-address.ibk";
	    }, 100); */
  }
  
////전화번호 형식 입력 @jys
  function inputPhoneType(obj){
  	  var inputVal = obj.val();
  	  obj.val(inputVal.replace(/[^0-9-]/gi,''));
  };
</script>
