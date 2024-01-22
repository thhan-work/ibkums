<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>

<h3>${title}
</h3>
<!-- content -->
      <div id="content" style="margin-top:0px">
        <!-- table_view -->
        	<form id="addressForm" name="addressForm" method="post" >
            <div class="tbl_wrap_view">
              <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                <caption>
                검색조건 테이블입니다.
                </caption>
                <colgroup>
                <col style="width:150px" />
                <col style="width:325px" />
                <col style="width:150px" />
                <col style="width:325px" />
                </colgroup>
                <tr>
                    <th scope="row">이름</th>
                    <td colspan="3"><input type="text" name="firstName" id="firstName" value="${contact.firstName}" style="width:745px" maxlength="50"></td>
                    </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td colspan="3"><input type="text" name="eMail1" id="eMail1" value="${contact.eMail1}" style="width:745px" maxlength="32"></td>
                    </tr>
                <tr>
                    <th scope="row">휴대폰번호</th>
                    <td><input type="text" name="mobile" id="mobile" value="${contact.mobile}" style="width:270px" maxlength="24"></td>
                    <th>FAX번호</th>
                    <td><input type="text" name="homeFax" id="homeFax" value="${contact.homeFax}" style="width:270px" maxlength="24"></td>
                </tr>
                <tr>
                    <th scope="row">소속</th>
                    <td><input type="text" name="department" id="department" value="${contact.department}" style="width:270px" maxlength="32"></td>
                    <th>회사번호</th>
                    <td><input type="text" name="comPhone" id="comPhone" value="${contact.comPhone}" style="width:270px" maxlength="48"></td>
                </tr>
                <tr>
                     <th scope="row">그룹선택</th>
                     <td colspan="3">
			            <select id="grpSeq" name="grpSeq">
				          <option value="default" selected="selected">그룹을 선택하세요</option>
				          <c:forEach items="${addressList}" var="loop">  
				          		<option value="${loop.grpSeq}" >${loop.groupName}</option>  
			          	  </c:forEach>
			        	</select>
                     </td>
                </tr>
                <tr>
                    <th scope="row">생년월일</th>
                    <td colspan="3">
                    	<input type="hidden" name="birthday" />
                    	<input type="hidden" name="emplId" value="${contact.emplId}" />
                    	<input type="hidden" name="catSeq" value="${contact.catSeq}" />
                		<span>
	                		<select name="yyyy" >
	              				<option value="default">선택</option>
	              				<c:forEach begin="1920" end="2018" var="item">
	                				<option value="${item}">${item}</option>
	             				</c:forEach>
	           				</select>
           				</span><span class="text1" style="margin-right:5px;">년 </span>  
           				<span>
	           				<select name="mm">
	              				<option value="default">선택</option>
	              				<c:forEach begin="1" end="12" var="item">
	                				<option value="<fmt:formatNumber value="${item}" pattern="00" />"><fmt:formatNumber value="${item}" pattern="00" /></option>
	              				</c:forEach>
	            			</select>
            			</span><span class="text1" style="margin-right:5px;">월 </span>
            			<span>
	            			<select name="dd">
	              				<option value="default">선택</option>
	              				<c:forEach begin="1" end="31" var="item">
	                				<option value="<fmt:formatNumber value="${item}" pattern="00" />"><fmt:formatNumber value="${item}" pattern="00" /></option>
	              				</c:forEach>  
	            			</select>
            			</span><span class="text1">일 </span>
                    	<div class="radio_default fn disib mgl10 mgr6" style="margin-top:2px;">
                        	<input type="radio"  id="radio1" name="yinyang" value="1" <c:if test="${contact.yinyang == 1||contact.yinyang == null}">checked="checked"</c:if>/>
                        	<label for="radio1">양력</label>
                  		</div>
                    	<div class="radio_default fn disib" style="margin-top:2px;">
                        	<input type="radio" id="radio2" name="yinyang" value="0" <c:if test="${contact.yinyang == 0}">checked="checked"</c:if> />
                        	<label for="radio2">음력</label>
                  		</div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">성별</th>
                    <td colspan="3">
                    	<div class="radio_default mgr15">
                        	<input type="radio" id="radio3" name="sex" value="1" <c:if test="${contact.sex == 1||contact.sex == null}">checked="checked"</c:if>/>
                        	<label for="radio3">남자</label>
                  		</div>
                    	<div class="radio_default">
                        	<input type="radio" id="radio4" name="sex" value="0" <c:if test="${contact.sex == 0}">checked="checked"</c:if> />
                        	<label for="radio4">여자</label>
                  		</div>
                  	</td>
                    </tr>
                <tr>
                    <th scope="row">직책</th>
                    <td><input type="text" name="title" id="title" value="${contact.title}" style="width:270px" maxlength="50"></td>
                    <th>집전화번호</th>
                    <td><input type="text" name="homePhone" id="homePhone" value="${contact.homePhone}" style="width:270px" maxlength="48"></td>
                </tr>
                <tr>
                    <th scope="row">소개</th>
                    <td colspan="3"><textarea title="레이블 텍스트" style="width:740px; height:160px" id="remark" name="remark">${contact.remark}</textarea>
                    <div class="info2 mgt5">※ 한글 50자, 영숫자 100자까지 입력가능합니다. (<span><span id="byte">0</span>/100</span> byte)</div>
                    </td>
                    </tr>
              </table>
            </div>
            </form>
            <!-- //table_view -->
            <!-- 버튼 -->
            <div class="btn_wrap01_detail mgt25">
            	<a href="#" class="btn_big blue" id="confirm-btn">확인</a>
            	<a href="#" class="btn_big" id="cancel-btn">취소</a>
            </div>
            <!-- //버튼 -->
      </div>
<!-- //content --> 
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="./address-dialog.jsp" flush="true"/>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>

<!-- Script -->
<script>
	
  $(document).ready(function () {
    enterKeyListener();
    var grpSeq = '${contact.grpSeq}';
    var grpSelectEl = $("select[name=grpSeq]");
    if(grpSeq!=null &&grpSeq !=""){
    	grpSelectEl.val(grpSeq);	
    }
    if('${type}' == 'mod') {
        grpSelectEl.attr("disabled", true);
	}
    
    if('${contact.birthday}' != '') {
        var birthday = '${contact.birthday}';
        var year = birthday.split("-")[0];
        var month = birthday.split("-")[1];
        var day = birthday.split("-")[2];
        
        $("select[name=yyyy]").val(year);
        $("select[name=mm]").val(month);
        $("select[name=dd]").val(day);
	}
    
    var remarkLen=getByteLength($("#remark").val());
    if(remarkLen>0){
    	$("#byte").text(remarkLen);
    }
  });

  
  $("#searchStartDatePicker").on('change', function(data){
	  var date = data.target.value;
	  IbkDatepicker.setDateSelectByDate("searchStartDt", date);
  });

  $("#remark").on("keyup", function() {
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

    	$("#byte").text(length);
  });
   //취소 버튼 클릭 처리
  $(document).on('click', "#cancel-btn", function () {
	  window.location.href = "${pageContext.request.contextPath}/contact-list.ibk?emplId=${contact.emplId}&grpSeq=${contact.grpSeq}";
  });
  
  // 확인 버튼 클릭 처리
  $(document).on('click', "#confirm-btn", function () {
	    var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})?[0-9]{3,4}?[0-9]{4}$/;
	    /* 	    var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; */
	    var name= $("input#firstName").val().trim();
	    var email = $("input#eMail1").val().trim();
	    var mobile = $("input#mobile").val().trim().replace(/[^0-9]/g,"");
	    var homeFax = $("input#homeFax").val().trim();
	    var comPhone = $("input#comPhone").val().trim();
	    var homePhone = $("input#homePhone").val().trim();	
	    
	    if(name==null||name==""){
	    	showAlert("이름 항목의 값을 입력해주세요.",function(){$("#firstName").focus();});
	    	return false;
	    }
	    if((email == null || email == '') && (mobile == null || mobile == '') && (homeFax == null || homeFax == '')) {
	    	showAlert("휴대폰번호, FAX 번호 중 최소 한가지 이상 입력해 주세요.",function(){$("#mobile").focus();});
	        return false;
	   	}

	    if(mobile != null && mobile != '' && !regExp.test(mobile)) {
	        showAlert("휴대폰번호를 정확히 입력해 주세요.");
	        return false;
	    }
	    
	    if($("select[name=grpSeq]").val() == 'default'||$("select[name=grpSeq]").val() == ''||$("select[name=grpSeq]").val() == null) {
	    	showAlert("그룹을 선택해 주세요.");
	        return false;
	    }
	    var year = $("select[name=yyyy]").val();
	    var month = $("select[name=mm]").val();
	    var day = $("select[name=dd]").val();
	    var birthday=year + "-" + month + "-" + day;
	    if(year!='default' &&month !='default' && day !='default'){
	    	$("input[name=birthday]").val(birthday);      
	    }
	  /*   contactInfo.firstName=name;
	    contactInfo.eMail1=email;
	    contactInfo.mobile=mobile;
	    contactInfo.homeFax=homeFax;
	    contactInfo.department=$("input#department").val().trim();
	    contactInfo.comPhone=comPhone;
	    contactInfo.grpSeq=$("select[name=grpSeq]").val();
	    contactInfo.birthday=birthday;
	    contactInfo.yinyang=$('input[name="yinyang"]:checked').val();
	    contactInfo.sex=$('input[name="sex"]:checked').val();
	    contactInfo.title=$("input#title").val().trim();
	    contactInfo.homePhone=homePhone;
	 	contactInfo.remark=$("#remark").val().trim();
		console.log(contactInfo);
		var confirmMessage = "해당 연락처를 등록 하시겠습니까?";
		showConfirmForAjax(confirmMessage, insertContact, contactInfo); */
		 if('${type}' == 'add') {
			 $("#addressForm").attr("action", "<c:url value='/contact'/>").submit();
		}else{
			 $("select[name=grpSeq]").attr("disabled", false);;
			 $("#addressForm").attr("action", "<c:url value='/contactModify'/>").submit();
		}
	   
  });

  function insertContact(contactInfo) {
	    //console.log(deleteTarget.length);
	    if (contactInfo.length > 0) {
	      $.ajax({
	        url: '${pageContext.request.contextPath}/address-contact-detail.ibk?type=add&emplId=${contact.emplId}',
	        type: 'GET',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(contactInfo),
	        success: function (result) {
	          showAlert("연락처가 등록되었습니다.");
	        }
	      });
	    }
	  }
  
  $("#zoom-in-btn").on('click', function () {
    IbkZoom.zoomIn();
  });

  $("#zoom-out-btn").on('click', function () {
    IbkZoom.zoomOut();
  });

////핸드폰 번호 숫자입력 체크 이벤트
  $("#homePhone").on("keyup", function(){
  	inputPhoneType($(this));
  });
  $("#mobile").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  $("#homeFax").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  $("#comPhone").on("keyup", function(){
	  	inputPhoneType($(this));
  });
  
  // enter ket 이벤트 리스너
  function enterKeyListener() {
    // enter key event
    $("#search-word").keypress(function (event) {
      if (event.which == 13) {
        event.preventDefault();
        $("#search-btn").trigger("click");
      }
    });
  }
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
