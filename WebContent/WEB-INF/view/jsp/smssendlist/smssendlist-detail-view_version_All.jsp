<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <h3>
    	<c:choose>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'I'}">상세보기 > 발송승인중</c:when>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'P'}">상세보기 > 시간경과(관리자문의)</c:when>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'R'}">상세보기 > 발송준비중</c:when>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'Y'}">상세보기 > 발송대기</c:when>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'S'}">상세보기 > 발송중</c:when>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'T'}">상세보기 > 발송중지</c:when>
    		<c:when test="${smssendlist.prcssStusDstic  eq 'D'}">상세보기 > 발송완료</c:when>
    	</c:choose>
    </h3>
    <!-- content -->
    <div id="content">
        <!-- table_view -->
        <div class="tbl_wrap_view">
        	<table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                <colgroup>
                    <col style="width:140px" />
		            <col style="width:335px" />
		            <col style="width:140px" />
		            <col style="width:auto" />
                </colgroup>
                <tr>
                   <th scope="row">기안명</th>
                    <td><input type="text" name="search" maxlength="333" id="request-title" value="${smssendlist.groupNm}"
                               style="width:700px; border: none" readonly="readonly" onfocus="this.blur()"></td>
                </tr>
                <tr>
                    <th scope="row">발송구분</th>
                    <td>
                   		<c:if test="${smssendlist.sendType eq 'marketing'}">
							<input type="text" name="request-type" maxlength="333" id="request-type" value="마케팅(고객관리 포함)"
                               		style="width:700px; border: none" readonly="readonly" onfocus="this.blur()">
						</c:if>
                    	<c:if test="${smssendlist.sendType eq 'noMarketing'}">
							<input type="text" name="request-type" maxlength="333" id="request-type" value="비마케팅(기존계약의 유지 · 관리 등)"
                               		style="width:700px; border: none" readonly="readonly" onfocus="this.blur()">
						</c:if>
                    </td>
                </tr>
                <tr>
                    <th scope="row">메세지타입</th>
                    <td>
						<input type="text" name="msg-type" maxlength="333" id="msg-type" value="${smssendlist.msgDstic}S"
								style="width:700px; border: none" readonly="readonly" onfocus="this.blur()">
                    </td>
                </tr>
                <tr>
                    <th scope="row">예상발송건수</th>
                    <td>
                    	<input id="expect-count" type="text" name="" style="border: none" readonly="readonly" onfocus="this.blur()" >
                    </td>
                </tr>
                <tr>
                    <th scope="row">메세지 내용</th>
                    <td colspan="3" ><!-- wrap_box_sms -->
                        <div class="wrap_box_sms">
                            <!-- box_sms -->
                             <div class="wrap_cbtn">
                                <div class="col1"></div>
                                <div class="col2">
                                </div>
                            </div>
                            <c:choose>
                            	<c:when test="${smssendlist.msgDstic eq 'SM'}">
	                            	<div class="box_sms">
		                                <div class="content">
		                                    <div class="text_sms2" id="div-texarea" style="width:100%">
		                                        <textarea class="sms" id="content-textarea"
		                                                  style="font-family:굴림; font-size:16px; width:100%; height:100%;" readonly="readonly" onfocus="this.blur()">${smssendlist.msgCtnt}</textarea>
		                                    </div>
		                                    <div class="byte"><span id="dis-total-byte">0</span>/<span
		                                            id="dis-max-byte"> 90</span>byte
		                                    </div>
		                                </div>
		                                <div class="mgt33 tac"><a href="javascript:" class="mgl6"><img
		                                        id="preview-dialog-show-img"
		                                        src="${pageContext.request.contextPath}/static/images/btn_sms02.png"
		                                        alt="미리보기"/></a></div>
	                            	</div>
                            	</c:when>
                            	<c:otherwise>
	                            	<div class="box_sms">
		                                <div class="content">
		                                    <div class="title_sms" id="msg-title-div">
		                                        <input class="sms" type="text" id="msg-title"
		                                               style="width:200px" readonly="readonly" onfocus="this.blur()" value="${smssendlist.msgCtnt}">
		                                    </div>
		                                    <div 
												<c:if test="${smssendlist.msgDstic eq 'SM'}"> class="text_sms2" id="div-texarea" style="width:100%; height:350px;"</c:if>
												<c:if test="${smssendlist.msgDstic ne 'SM'}"> class="text_sms" id="div-texarea" style="width:100%; height:310px;"</c:if>
											>
		                                        <textarea class="sms" id="content-textarea"
		                                                  style="font-family:굴림; font-size:16px; width:100%; height:100%" readonly="readonly" onfocus="this.blur()">${smssendlist.umsMsgCtnt}</textarea>
		                                    </div>
		                                    <div class="byte"><span id="dis-total-byte">0</span>/<span
		                                            id="dis-max-byte"><c:if test="${smssendlist.msgDstic eq 'SM'}"> 90</c:if><c:if test="${smssendlist.msgDstic ne 'SM'}"> 2000</c:if></span>byte
		                                    </div>
		                                </div>
		                                <div class="mgt33 tac"><a href="javascript:" class="mgl6"><img
		                                        id="preview-dialog-show-img"
		                                        src="${pageContext.request.contextPath}/static/images/btn_sms02.png"
		                                        alt="미리보기"/></a></div>
	                            	</div>
                            	</c:otherwise>
                            </c:choose>
                            <!-- //box_sms -->
                            <!-- box_list -->
                            <div class="box_list">
                                <!-- scroll -->
                                <div class="scroll">
                                    <!-- table list -->
                                    <div class="tbl_wrap_list_sms">
                                        <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
                                            <thead id="display_head">
                                                <tr>
                                                    <th>고객번호</th>
                                                    <th>고객명</th>
                                                    <th>휴대폰번호</th>
                                                    <c:forEach items="${tableAddHeader}" var="idx" >
                                                        <th>${idx}</th>
                                                    </c:forEach>
                                                </tr>
                                            </thead>
                                            <tbody id="display_body">
                                            <c:if test="${cntTarget == 0}">
                                                <tr>
                                                    <td colspan="13" style="height:375px">
                                                        <div class="nodata"><p>대상자파일을 업로드 해주시기 바랍니다.</p></div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${cntTarget != 0}">
                                                <c:forEach var="idx" items="${targetDataList}">
                                                    <tr>
                                                        <c:forEach var="idxSub" items="${tableHeader}">
                                                            <td>${idx[idxSub]}</td>
                                                        </c:forEach>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- //table list -->
                                </div>
                                <!-- //scroll -->
                                <div class="total"> 총 건수<span class="right" >정상 : <span class="blue" id="tot_count">0</span>건  /  에러 : <span
                                        class="red" id="error_count">0</span>건</span></div>
                                <div class="mgt20">
                                    <ul class="disib">
                                        <li class="disib"><b>발신번호 :</b>
                                            <input type="text" id="send-phonenum"  value="${smssendlist.sndrTelno}" class="mgl5"
                                                   style="width:100px; border:none; padding-bottom:6px; margin-left:-5px !important;" readonly="readonly" onfocus="this.blur()">
                                        </li>
                                       	<c:if test="${smssendlist.sendType eq 'marketing'}">
	                                        <li class="disib mgl20" id="validation-num-li"><span  style="vertical-align: middle; font-weight: bold;">심의필번호  :</span>
	                                            <input type="text" id="validation-num" class="mgl5" value="${smssendlist.censorId}"
	                                                   style="width:90px; border: none" readonly="readonly" onfocus="this.blur()">
	                                        </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                            <!-- //box_list -->
                        </div>
                        <!-- wrap_box_sms --></td>
                </tr>
                <tr>
                    <th scope="row">대상자 파일</th>
                    <td>
                        <input type="text" id="file-name-input"
                               style="width:330px; display: none;" readonly="readonly" onfocus="this.blur()" value="${smssendlist.inst}">
                    </td>
                </tr>
                <tr <c:if test="${smssendlist.msgDstic eq 'SM'|| smssendlist.msgDstic eq 'LM'}"> style="display: none" </c:if> id="img-tr">
                    <th scope="row">이미지 파일</th>
                    <td>
                        <ul class="list01">
                            <li>
                                <input type="text" id="image-fileupload-input1"
                                       style="width:330px; display: none;" readonly="readonly" onfocus="this.blur()" value="${smssendlist.imagePath1}">
                            </li>
                            <li>
                                <input type="text" id="image-fileupload-input2" 
                                       style="width:330px; display: none;" readonly="readonly" onfocus="this.blur()" value="${smssendlist.imagePath2}">
                            </li>
                            <li>
                                <input type="text" id="image-fileupload-input3" 
                                       style="width:330px; display: none;" readonly="readonly" onfocus="this.blur()" value="${smssendlist.imagePath3}">
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr id="tr_confirm-doc-name" style="display: none;">
                    <th scope="row">예산합의서명</th>
                    <td><input type="text" id="confirm-doc-name" maxlength="50"
                              style="width:650px; display: none;" readonly="readonly" onfocus="this.blur()" value="${smssendlist.budgetNm}">
                    </td>
                </tr>
                <tr>
                    <th scope="row">발송 희망일</th>
                    <td>
                        <div class="row1" style="display: none;">
                            <div class="box_text01">합계<span id="total-count">0</span></div>
                            <div class="box_text_arrow"></div>
                            <div class="box_text02">남은건수<span id="remain-count">0</span></div>
                        </div>
                        <div id="dispatch-body"></div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">결재선 지정</th>
                    <td colspan="3">
		              	<div class="faq">
		                    <ul class="faqBody">
		                        <li class="article hide" id="a1">
		                            <p class="q">1차 <a href="#a1" id="articleTarget" >기안부</a></p>
		                            <div class="a" style="display: none;">
		                            <!-- table_view -->
		                                <div class="tbl_wrap_view_sms03" style="width:320px; border-top:1px solid #ffffff; margin-top:4px;">
		                                  <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
		                                    <caption>
		                                    검색조건 테이블입니다.
		                                    </caption>
		                                    <colgroup>
		                                    <col style="width:40px" />
		                                    <col style="width:90px" />
		                                    <col style="width:" />
		                                    </colgroup>
		                                    <tbody id="emp-table">
		                                    </tbody>
		                                  </table>
		                                </div>
		                            <!-- //table_view -->
		                            </div>
		                        </li>
		                        </ul>
		                </div>
		                <div class="faq">
		                    <ul class="faqBody">
		                        <li class="article hide" id="a2" id="articleTarget">
		                            <p class="q">2차 <a href="#a2"  id="articleTarget">개인디지털채널부</a></p>
		                            <div class="a" style="display: none;">
		                            <!-- table_view -->
		                                <div class="tbl_wrap_view_sms03" style="width:320px; border-top:1px solid #ffffff; margin-top:4px;">
		                                  <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
		                                    <caption>
		                                    개인 디지털채널부 테이블입니다.
		                                    </caption>
		                                    <colgroup>
		                                    <col style="width:40px" />
		                                    <col style="width:90px" />
		                                    <col style="width:" />
		                                    </colgroup>
		                                    <tbody id="digital-emp-table">
		                                    </tbody>
		                                  </table>
		                                </div>
		                            <!-- //table_view -->
		                            </div>
		                        </li>
	                        </ul>
                        </div>
                         <div class="faq">
		                    <ul class="faqBody">
		                        <li class="article hide" id="a3" id="articleTarget">
		                            <p class="q">3차 <a href="#a3" id="articleTarget">IBK고객센터</a></p>
		                            <div class="a" style="display: none;">
		                            <!-- table_view -->
		                                <div class="tbl_wrap_view_sms03" style="width:320px; border-top:1px solid #ffffff; margin-top:4px;">
		                                  <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
		                                    <caption>
		                                    고객센터 테이블입니다.
		                                    </caption>
		                                    <colgroup>
		                                    <col style="width:40px" />
		                                    <col style="width:90px" />
		                                    <col style="width:" />
		                                    </colgroup>
		                                    <tbody id="cms-emp-table">
		                                    </tbody>
		                                  </table>
		                                </div>
		                            <!-- //table_view -->
		                            </div>
		                        </li>
		                    </ul>
		                </div>
		              </td>
                </tr>
                <tr>
                    <th scope="row">발송 승인직원<br>
                        등록
                    </th>
                    <td colspan="3">
		              	<div class="faq">
		                    <ul class="faqBody">
		                        <li class="article hide" id="a4"  >
		                            <p class="q"><a href="#a4" id="articleTarget" >발송 승인</a></p>
		                            <div class="a" style="display: none;">
		                            <!-- table_view -->
		                                <div class="tbl_wrap_view_sms03" style="width:430px; border-top:1px solid #ffffff; margin-top:4px;">
		                                  <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
		                                    <caption>
		                                    검색조건 테이블입니다.
		                                    </caption>
		                                    <colgroup>
		                                    <col style="width:40px" />
		                                    <col style="width:60px" />
		                                    <col style="width:90px" />
		                                    <col style="width:" />
		                                    </colgroup>
	                                    	<tbody id="send-emp-table">
		                                    </tbody>
		                                  </table>
		                                </div>
		                            <!-- //table_view -->
		                            </div>
		                        </li>
		                    </ul>
		                </div>
		              </td>
                </tr>
               <c:choose>
    				<c:when test="${smssendlist.modifyReason ne null and smssendlist.modifyReason ne ''}">
		                <tr>
		                	<th scope="row">
		                		<c:choose>
			                		<c:when test="${agreeStatus  eq 'N'}">반려사유</c:when>
			                		<c:otherwise>수정사유</c:otherwise>
		                		</c:choose>
		                	</th>
		                	<td colspan='3'>
		                		<div class="row1">
		                			${smssendlist.modifyReason}
		                		</div>
		                </tr>
    				</c:when>
    				<c:when test="${smssendlist.stopReason ne null and smssendlist.stopReason ne ''}">
    					<tr>
		                	<th scope="row">중지사유</th>
		                	<td colspan='3'>
		                		<div class="row1">
		                			${smssendlist.stopReason}
								</div>
		                </tr>
    				</c:when>
    			</c:choose>
            </table>
        </div>
        
        <!-- //table_view -->
        <!-- 버튼 -->
        <div class="btn_wrap01_detail">
        	<c:if test="${smssendlist.prcssStusDstic  eq 'P'}">
        	<a href="javascript:" class="btn_big gray disable" id="send-btn" title="발송일정이 현재보다 과거이므로 발송승인요청이 불가능합니다. 관리자에게 문의해주세요 (IT채널부 김성민과장)">발송승인 요청</a>
            </c:if>
            <c:if test="${smssendlist.prcssStusDstic  eq 'S'}"> 
            	<c:if test="${USER_CLASS  eq 'A'}"> 
            		<a href="javascript:" class="btn_big" id="stop-send-btn">발송중지</a>
            	</c:if>
            </c:if>
            <c:if test="${smssendlist.prcssStusDstic  eq 'T'}"> 
          		<c:if test="${USER_CLASS  eq 'A'}"> 
            		<a href="javascript:" class="btn_big" id="restart-send-btn">발송재개</a>
           		</c:if>
            </c:if>
        	<a href="javascript:" class="btn_big blue" id="confirm-btn">확인</a>
            <c:if test="${smssendlist.prcssStusDstic  eq 'P'}"> 
        		<a href="javascript:" class="btn_big" id="save-btn" >저장</a>
            </c:if>
            <a href="javascript:" class="btn_big delete" id="cancel-btn">취소</a>
        </div>
        <!-- //버튼 -->
    </div>
    <!-- //content -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="../common/special-char-dialog.jsp" flush="true"/>
<jsp:include page="../common/preview-dialog.jsp" flush="true"/>

<!-- hidden(상세보기화면 파라미터) -->
<input type="hidden" value="${smssendlist.groupUniqNo}" id="smssendlist-groupUniqNo">
<input type="hidden" value="${smssendlist.prcssStusDstic}" id="smssendlist-prcssStusDstic">

<style>
    .editable-select {
        width: 45px
    }

    .ui-datepicker-trigger {
        margin-left: 10px;
        cursor: pointer; 
    }
</style>

<link href="${pageContext.request.contextPath}/static/css/jquery-editable-select.min.css"
      rel="stylesheet">

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery.iframe.transport.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery.fileupload.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery-editable-select.min.js "></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/sms-req/IbkSmsReqStatus.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/sms-req/IbkSmsReqDispatchInfo.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/sms-req/IbkDispatchHtml.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/sms-req/IbkInsertTextAtCusor.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/sms-req/IbkByteCheck.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<script>
var user_bocode = <%=session.getAttribute("EMPL_BOCODE")%>; // 세션에서 BOCODE 가져오기 @jys
if(user_bocode == null || user_bocode == ""){ // 세션에서 BOCODE 없을 경우 등록 불가능하게 처리 @jys
		showAlert(<%=session.getAttribute("EMPL_NAME")%>+"님의<br>부서코드가 존재하지 않습니다.<br><br>부서코드를 확인 하시고<br>다시 진행 하시기 바랍니다.");
		$("#cancel-btn").hide();
		$("#save-btn").hide();
}
var todayYYYYMMDD = moment().format("YYYYMMDD");
var lastAddedDay = moment().format("YYYYMMDD");
var lmscontents = $("#content-textarea").val();
var groupUniqNo = '${smssendlist.groupUniqNo}';
var requestsNumber = ${smssendlist.requestsNumber};
var commaReqNum = $.number(requestsNumber) + ' 건';
var emplId =  '<%=session.getAttribute("EMPL_ID")%>';
var addCount = 0; 

var extraFlag=false;
var firstRow=null;
var extraArray='${replaceVariableVal}';
if(extraArray!=null &&extraArray!=""){
	  extraArray=JSON.parse(extraArray);
	  firstRow='${targetReplaceVal}';
	  if(firstRow !=null && firstRow!=""){
		  firstRow=JSON.parse(firstRow);
	  }
}
if(firstRow !=null && firstRow!=""&&Object.keys(firstRow).length>3){
	  extraFlag=true;
}
$(document).ready(function () {
	//입력 값 세팅
	$("#request-title").val("${smssendlist.groupNm}"); //기안명 세팅
	$("#expect-count").val(commaReqNum); //발송건수 세팅
	if('${smssendlist.msgDstic}' == 'SM'){
		$("#content-textarea").val(lmscontents); //메시지내용 세팅
		$('#dis-total-byte').text(IbkByteCheck.getBytes(lmscontents)); //byte 세팅
	}else {
		$("#msg-title").val($('#msg-title').val()); //메시지내용 세팅
		$("#content-textarea").val(lmscontents); //메시지내용 세팅
		$('#dis-total-byte').text(IbkByteCheck.getBytes(lmscontents)); //byte 세팅
	}
	$("#validation-num").val("${smssendlist.censorId}"); //심의필 번호 세팅
	//정상건수, 에러건수 세팅도 해줘야함.(db결정되면 등록해야함~!!!!)
	$("#send-phonenum").val("${smssendlist.sndrTelno}"); //발신번호 세팅
	$("#file-name-input").val("${smssendlist.inst}"); //대상자파일 세팅
	$("#confirm-doc-name").val("${smssendlist.budgetNm}"); //예산합의서명 세팅
	
	showConfirmDoc(); // 예산합의서명 노출 여부
	
  $("#fileupload-btn").on("click", function () {
    $("#fileupload").trigger('click');
  });

  $('#fileupload').fileupload({
    dataType: 'json',
    done: function (e, data) {
      $("#file-name-input").val(data.files[0].name);
    }
  });

  $("#image-file-btn1").on("click", function () {
    $("#image-fileupload1").trigger('click');
  });

  $('#image-fileupload1').fileupload({
    dataType: 'json',
    done: function (e, data) {
      $("#image-fileupload-input1").val(data.files[0].name);
    }
  });

  $("#image-file-btn2").on("click", function () {
    $("#image-fileupload2").trigger('click');
  });

  $('#image-fileupload2').fileupload({
    dataType: 'json',
    done: function (e, data) {
      $("#image-fileupload-input2").val(data.files[0].name);
    }
  });

  $("#image-file-btn3").on("click", function () {
    $("#image-fileupload3").trigger('click');
  });

  $('#image-fileupload3').fileupload({
    dataType: 'json',
    done: function (e, data) {
      $("#image-fileupload-input3").val(data.files[0].name);
    }
  });

  $("#msg-type").on('change', function () {
    if ($(this).val() === 'mms') {
      $("#img-tr").show()
    } else {
      $("#img-tr").hide();
    }

    if ($(this).val() === 'sms') {
      $("#msg-title").val('');
      $("#msg-title-div").hide();
      $("#div-texarea").css({width: "100%", height: "350px"});
      $("#content-text-area-div").attr("class", "text_sms2");
    } else {
      $("#msg-title").val('');
      $("#msg-title-div").show();
      $("#div-texarea").css({width: "100%", height: "310px"});
      $("#content-text-area-div").attr("class", "text_sms");
    }
  });

     selectDateSaveCount(todayYYYYMMDD);
	 removePassedTime();
	 confirmSelect(groupUniqNo);
	 sendConfirmSelect(groupUniqNo);
	 digitalConfirmSelect(groupUniqNo);
	 cmsConfirmSelect(groupUniqNo);
	 IbkSmsReqDispatchInfo.addDispatchDate(todayYYYYMMDD);
	 IbkSmsReqDispatchInfo.setCount(todayYYYYMMDD, 4, 1000);

});

$("input[name=request-type]").on('change', function () {
  if ($(this).val() === 'noMarketing') {
    $("#validation-num").val('');
    $("#validation-num-li").attr("style", "display: none !important");
  } else {
    $("#validation-num").val('');
    $("#validation-num-li").show();
  }
});

//직원 검색시 초기값을 부서명 : 기안부서로 세팅
$("#employee-search-btn").on('click', function (e) {
  e.preventDefault();
  $("#employee_search-word-type").val('BoCode');
  var isScrollPopup = true;
  userSearchInit(user_bocode, isScrollPopup); // 부서코드 세션에서 받아와서 전달 @jys  
});


//발송 승인직원
$("#confirm_in_search-btn").on('click', function () {
		if(!addable){ return false};
		$(".tbl_wrap_view_sms03").css("border-top","1px solid #e0e0e0");
	    var empData = IbkDataTableInSearch.dataTable.row(
	        $(".search-dt-check-box:checked").val()).data();
	    var emplHpNo = empData.emplHpNo;
	    if(emplHpNo != null){
	    	 if (emplHpNo.length == 8) {
	    		 emplHpNo = emplHpNo.replace(/^([0-9]{4})([0-9]{4})/, "$1-$2");
	    	 } else if (emplHpNo.length == 12) {
	    		 emplHpNo = emplHpNo.replace(/(^[0-9]{4})([0-9]{4})([0-9]{4})/, "$1-$2-$3");
	    	 }
	    	 emplHpNo = emplHpNo.replace(/(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})/, "$1-$2-$3");
	     }
	    var employyHtml = ''
	        + '<tr id="tr-' + empData.emplId + '">'
	        + '  <th scope="row" id="default-emp-count">1</th>'
	        + '  <td width="70px">' + empData.positionCallname + '</td>'	// 부서명 사이즈 변경 @jys
	        + '  <td width= "90px">' + empData.emplName + '</td>'
	        + '  <td width= "200px">' + empData.emplHpNo
	        + '     <span class="btn01">'
	        + '       <input type="hidden" class="sendConfirm-emp-id" value="' + empData.emplId + '">'
	        + '       <input type="hidden" class="sendConfirm-emp-class" value="' + empData.emplClass + '">' // Class 값 추가 @jys
	        + '       <a href="javascript:" class="btn_default emp-del-btn" id="' + empData.emplId
	        + '">삭제</a>'
	        + '</span>'
	        + '  </td>'
	        + '</tr>';

	 // 승인자 추가시 넘버링 오류 수정 @jys
	    $("#send-emp-table #default-emp-count").each(function(){
	    	$(this).text(parseInt($(this).text()) + 1);
	    });
	    $("#send-emp-table").prepend(employyHtml);
});

    $(document).on('click', '.emp-del-btn', function () {
	    $("#tr-" + $(this).attr('id')).remove();
	 	// 승인자 삭제시 넘버링 오류 수정 @jys
	    $("#emp-table #default-emp-count").each(function(idx){
	    	$(this).text(parseInt(idx+1));
	    });
	  });

	  $("#special-char-show-img").on('click', function () {
	    showSpecailCharDialog();
	  });

	  $("#preview-dialog-show-img").on('click', function () {
		var message=$("#content-textarea").val();
		if(extraFlag && firstRow !=null){
			for(key in extraArray){
				var checkText = new RegExp("[$]\{+"+key+"\}","g");
	            var cntMatch = message.match(checkText);
	            if(cntMatch != null){
   					for(cnt=0;cnt<cntMatch.length;cnt++){
   	            		message=message.replace(cntMatch[cnt],firstRow[key]);
   	            	}
	            }
			}
		}
		showPreviewDialog($("#msg-title").val(), message);
	  });

	  $("#img-desc-btn").on('click', function () {
	    showConfirmNoCancelBtn("이미지 규격", "해상 : 640 * 480 <br/> 최대 크기 : 장당300KB <br/>(3개 합 : 1MB 미만)");
	  });

	  $(document).on('click', '.es-input', function () {
	    $(this).val('');
	  });

	  //확인 버튼 클릭 시 Action 
	  $("#confirm-btn").on('click', function(){
		  redirectList();
	  })

	  // 저장 버튼 클릭시 Action
	  $("#save-btn").on('click', function () {
	    var smsReqData = saveReqData();
	    $.ajax({
	      url: '${pageContext.request.contextPath}/smssendlist/save',
	      type: "POST",
	      contentType: "application/json; charset=utf-8",
	      dataType:"json",
	      data: JSON.stringify(smsReqData),
	    }).done(function(data) {
	      showAlert("저장 하였습니다.", redirectList);
	    }).fail(function(xhr) {
	      showAlert("저장 할 수 없습니다.");
	    });
	  });

	  //취소버튼 클릭 시 Action
	  $("#cancel-btn").on('click', function () {
	    showConfirm("취소", "취소 시 작성중인 기안의 내용이 모두 사집니다.<br/> 그래도 취소하시겠습니까?", cancelDraft);
	  });
	  
	  function cancelDraft(){
		  var groupUniqNo = $("#smssendlist-groupUniqNo").val();
		  $.ajax({
			  type:'DELETE',
			  url:'${pageContext.request.contextPath}/smssendlist/delete/'+ groupUniqNo,
	          success: function (result) {
	            redirectList();
	          }
		  })
	  }
	  
	  //발송중지 클릭 시 Action
	  $("#stop-send-btn").on('click', function () {
		  showConfirmForAjax("발송중지", "현재 발송 중인 기안의 문자 발송이 중단됩니다.<br/><br/> 정말 발송을 중지하시겠습니까?", stopSending);
	  });
	  
	  //발송중지 이벤트
	  function stopSending(){
		  var groupUniqNo = $("#smssendlist-groupUniqNo").val();
		  $.ajax({
			  type:'POST',
			  url:'${pageContext.request.contextPath}/smssendlist/stopsend/'+ groupUniqNo,
	          success: function (result) {
	        	showAlert("발송중지를 완료하였습니다.", redirectList);
	          }
		  })
	  }
	  
	  //발송재개 클릭 시 Action
	  $("#restart-send-btn").on('click', function () {
		  showConfirmForAjax("발송재개", "중단된 기안이 발송됩니다.<br/><br/> 정말 발송을 재개하시겠습니까?", restartSending);
	  });
	  
	  //발송재개 이벤트
	  function restartSending(){
		  var groupUniqNo = $("#smssendlist-groupUniqNo").val();
		  $.ajax({
			  type:'POST',
			  url:'${pageContext.request.contextPath}/smssendlist/restartsend/'+ groupUniqNo,
	          success: function (result) {
        	    showAlert("발송재개를 완료되었습니다.", redirectList);
	          }
		  })
	  }
	  
	  
	  function redirectList() {
	    /* setTimeout(function () {
	      window.location.href = "${pageContext.request.contextPath}/smssendlist.ibk";
	    }, 100); */
	  }

	  function reloadWindow(){
	    location.reload();
	  }

	  function validSendCount(){
		    var totalCount = parseInt($("#total-count").text().replace(/,/g, ''))
		    if (totalCount < 1) {
		      return false;
		    }

		    var remainCount = parseInt($("#remain-count").text().replace(/,/g, ''));
			
		    if (remainCount > 0) {
		        return false;
			}
		    
		    if (totalCount === remainCount) {
		      return false;
		    }
			
		    return true;
	  }
	  
	  
	  function saveReqData(){
		   
		   // 발송 직원 목록을 request param 으로 만드는 작업
		   var sendConfirmEmp = [];
		   $(".article").each(function (){
			    var type = 1;
			    if($(this).prop("id") == "a1"){
			    	type = 1;	
			    }else if($(this).prop("id") == "a2"){
			    	type = 2;
			    }else if($(this).prop("id") == "a3"){
			    	type = 3;
			    }else if($(this).prop("id") == "a4"){
			    	type = 4;
			    }
			    
			    $(this).find(".sendConfirm-emp-id").each(function (index) {
			    	sendConfirmEmp.push({
					  emplId : $(this).val()
					  ,agreeType : type
				  });
				});
		   });
		   
			// SMS/LMS/MMS 메시지 제목, 내용 셋팅
		    var msgTitle = null;
		    var msg = null;
		    var msgDstic = null;
		    if('${smssendlist.msgDstic}' == "SM"){
		    	msgTitle = $("#content-textarea").val();
		    	msgDstic = '${smssendlist.msgDstic}'
		    }else{
		    	msgTitle = $("#msg-title").val();
		    	msg = $("#content-textarea").val();
		    	msgDstic = '${smssendlist.msgDstic}'
		    }

		    
		    return {
		   	  groupUniqNo: $("#smssendlist-groupUniqNo").val(),
		   	  sendType: '${smssendlist.sendType}',
		      msgCtnt: msgTitle,	// 메시지 내용 (LMS/MMS는 제목)
		      umsMsgCtnt: msg,	
		      budgetNm: $("#confirm-doc-name").val(),
		      censorId: $("#validation-num").val(),
	 	      sendConfirmEmp : sendConfirmEmp
		    };
		  }

	  

	  $(document).on('click', '.repl-var', function () {
	    var text = '\${' + $(this).text() + '}';
	    IbkInsertText.setText('content-textarea', text);
	  });

	  $(".special-char").on('click', function () {
	    IbkInsertText.setText('content-textarea', $(this).text());
	  });

	  $(document).on('keydown', '.editable-select', function (event) {
			if (event.which == 13) {
			    var $forIdSeperate = $(this);
			    var value = $.number(($(this).val()));
			    $(this).val(value);
			    setRemainAndAddedAndAbleCount($forIdSeperate, value);
			    $(this).blur();
		    }
		  });	  

	  $(document).on('change', '.editable-select', function () {
		    var $forIdSeperate = $(this);
		    var value = $.number(($(this).val()));
		    $(this).val(value);
		    setRemainAndAddedAndAbleCount($forIdSeperate, value);
		  });

		  $(document).on('change', "#expect-count", function () {
		    var expectValue = $(this).val();
		    $("#total-count").text($.number(expectValue));
		    $(this).val($.number(expectValue));
		    remainCount();
		  });

		  $(document).on('change', ".added-count", function () {
		    var totalCount = parseInt($("#total-count").text());
		    var addedCount = 0;
		    $(".added-count").each(function (index) {
		      addedCount += $(this).val();
		    });
		    $("#remain-count").text($.number(totalCount - addedCount));
		  });

		////현재시간 비교하여 시간별 발송 건수 체크
		  function removePassedTime() {
		    var todayYYYYMMDDHHmm = parseInt(moment().format("YYYYMMDDHHmm"));
		    $(".daytime-count").each(function () {
		      var dayTime = parseInt($(this).attr("id"));
		      if (todayYYYYMMDDHHmm > dayTime) {
		        $(this).find("input").hide();
		      }else{
		   	  	$(this).find("input").show();
		      }
		    });
		  }

		  function setCountInTd($input, value) {
		    var eventIdSplitArr = $input.attr('id').replace("sel-", '');
		    $("javascript:" + eventIdSplitArr).text(value);
		    return eventIdSplitArr;
		  }

		  // 발송 희망일 선택 건수 계산 @jys(등록된 건수 초기 설정)
		  // 당일 건수 세팅 하는 함수 입니다. @jisoonchoi
		  function getDispatchTotalCount(day) {
			// day에 등록된 총 건수 구하기
			var initTotalCnt = $("#today-total-count-" + day).text().replace(/,/,"");
			// 공백을 parseInt 하게 되면 NaN 이 발생 됩니다. @jisoonchoi
		    if (!initTotalCnt) {
		      initTotalCnt = 0;
		    }
			var test = 0;
		    $("#dispatch-body-" + day + " .uneditable-select").each(function (index) {
		      test += parseInt($(this).val().replace(/,/g, ''));
		    });
//		     console.log(parseInt(initTotalCnt) + parseInt(test));
		    return (parseInt(initTotalCnt) + parseInt(test));
		  }

		  // 합계 및 남은건수 갱신 @jys(등록된 건수 초기 설정)
		  function remainCount() {
		    var expectValue = $("#total-count").text().replace(/,/g, '');
		    
		    // day에 등록된 총 건수 구하기
		    var todayTotalCount = 0;
		    $(".today-total-count").each(function (index) {
		    	todayTotalCount += parseInt($(this).text().replace(/,/g, ''));
		    });
		    
		    var addedCount = 0;
		    $(".added-count").each(function (index) {
		    	addedCount += parseInt($(this).text().replace(/,/g, ''));
		    });

		    $("#remain-count").text($.number(expectValue - (addedCount - todayTotalCount)));
		  }

		  function setRemainAndAddedAndAbleCount($forIdSeperate, value) {
		    var seperateId = setCountInTd($forIdSeperate, value);
		    var dayId = seperateId.split("-")[0];
		    var addedCount = getDispatchTotalCount(dayId);
		    $("#added-count-" + dayId).text($.number(addedCount));
		    // 50000 건이 하루 권장 이라 하드코딩 으로 함.
		    $("#able-count-" + dayId).text($.number(50000 - addedCount));
		    $("#added-count-input-" + dayId).val(addedCount);
		    remainCount();
		  }

		////마지막 발송 일자로 셋팅( 발송 희망일에서 가장 미래의 시간 택 ) @jys
		  function setLastDay(){
			  lastAddedDay = 0;
			  $(".hasDatepicker").each(function(){
				  thisDate = $(this).val().replace(/-/gi,'');
				  if(lastAddedDay < thisDate){
					  lastAddedDay = (thisDate < todayYYYYMMDD) ? (todayYYYYMMDD-1) : thisDate;
				  }
			  });
		  }
	  
	  // 발송 희망일 시간 구간 셋팅 @jys
	  var timeList = ["1000", "1030", "1100", "1400", "1430", "1500", "1530", "1600", "1630", "1700"];
	  var total = 0;
	  // 발송 희망일 시간별 건수 조회 @jys
	  function selectDateTotalCount(date){
		    $.ajax({
		        url: '${pageContext.request.contextPath}/smsreq/totalcnt/',
		        type: "POST",
		        async : false, // 남은건수 정상체크를 위한 딜레이 추가        // (2. 해당일자 시간별 등록된 전체 건수) 와 (3. 해당일자 시간별 기안자 등록한 건수)가 동시에 셋팅하기 시작하여 정상적으로 카운트 되지 않음.
		        contentType: "application/json; charset=utf-8",
		        data: JSON.stringify({"date":date, "timeList":timeList}),
		      }).done(function(data) {
		    	  var totalCnt = 0;
		    	  for(var i=0; i < timeList.length; i++){
		    		  $("#"+date+"-"+timeList[i]).text($.number(data["TOTAL_TIME_"+timeList[i]]));
		    		  totalCnt = totalCnt + data["TOTAL_TIME_"+timeList[i]];
		    	  }
		    	  
		    	  $("#today-total-count-" + date).text($.number(totalCnt));
		    	  $("#added-count-" + date).text($.number(totalCnt));
		    	  
		      }).fail(function(xhr) {
		        showAlert("요청 중 오류가 발생 하였습니다.\n\n(selectDateTotalCount())");
		      });
	  }
	  
	  
	  //발송 희망일 저장된 시간 값 세팅
	  function selectDateSaveCount(date){
		  $.ajax({
		        url: '${pageContext.request.contextPath}/smsreq/savecnt/',
		        type: "POST",
		        contentType: "application/json; charset=utf-8",
		        data: JSON.stringify({
		        	"groupUniqNo": groupUniqNo,
		            "timeList":timeList}),
		        }).done(function(data){
		        		console.log(data);
		        		
	        			var tot = 0;
	        			var index = 0;
		        		$.each(data, function(key, value){
		        			var YYYY = key.substr(0,4);
		        			var mm=key.substr(4,2);
		        			var dd=key.substr(6,2);
		        			var YYYYMMDD = YYYY+"-"+mm+"-"+dd;
		        			var btnDel = 'N';
		        			if(index == 0){btnDel = 'Y'};
		        			
		        			// 1. 발송희망일 셋팅(일자별) _VIEW 전용
		        			IbkDispatchHtml.appendTo_View("dispatch-body", key, btnDel);
							
		        			$("#datepicker-"+key).css("border","none");
		        			$("#datepicker-"+key).css("font-weight","bold");
		        			$("#datepicker-"+key).prop("readonly", true);
		        			
		        			$("#datepicker-" + key).val(YYYYMMDD);
		        			
	        		        // 2. 해당일자 시간별 등록된 전체 건수 셋팅
	   	        			selectDateTotalCount(key);
	   	        			
	   	        			// 3. 해당일자 시간별 기안자 등록한 건수 셋팅 
		        			for(var i=0; i< timeList.length; i++){
		        				var inputTarget = $("#sel-" + key + "-" + timeList[i]);
		        				var inputNum = value["TOTAL_TIME_"+ timeList[i]];

		        				inputTarget.val($.number(inputNum));
		        			}
	        		        
							// 4. 마지막 일자 셋팅 (희망일 추가 시 마지막일자 다음 날로 셋팅되기 위함)
		        			if(lastAddedDay < key){
			        			lastAddedDay = key;
		        			}
		        			index++;
			        	})
		        	
	       		        $(".uneditable-select").each(function(){
		        			if($(this).val() != '0'){
		        				var $forIdSeperate = $(this);
		        			    var value = $(this).val();
		        			    
//	 	        			    // --------------------- 총건수 에서 기안에 해당하는 건수 제외 --------------------------------//
//	 	        			    // - 기안 수정 시 발송 총 건수에 기안의 등록된 건수가 포함되어 정상적으로 총 건수가 계산되지 않는 이슈 해결
//	 	        				var totalId = $(this).prop("id").replace("sel-", "");	//해당 발송 일시 등록된 건수
//	 	        				var date = totalId.substr(0,8);	// 발송일자
//	 	        				var dayTotalObj = $("#"+totalId);	// 발송 일시에 해당하는 총 건수
		        			    
//	 	        				console.log(totalId + ": 일시 총건수 = " + parseInt(dayTotalObj.text().replace(/,/gi, '')) + " / 일시 기안 건수 = " + parseInt(value.replace(/,/gi, '')));
//	 	        			    // 등록된 건수에서 해당 기안에 대한 건수 제외 ( (해당일시 총 건수) - (해당일시 기안등록 건수) )
//	 	        			    dayTotalObj.text($.number(parseInt(dayTotalObj.text().replace(/,/gi, '')) - parseInt(value.replace(/,/gi, '')))) ;
		        				
//	 	        			    var monthTotalCnt = $("#today-total-count-" + date).text().replace(/,/gi, '');	// 해당일자 등록된 발송 총건수 (일시의 모든 합) 
//	 	        				// 등록된 건수 총합에서 해당 기안에 대한 건수 제외 ( (해당일자 총 건수) - (해당일시 기안등록 건수) )
//	 	        				$("#today-total-count-" + date).text($.number(parseInt(monthTotalCnt) - parseInt(value.replace(/,/gi, ''))));
//	 	        				// --------------------- 총건수 에서 기안에 해당하는 건수 제외 --------------------------------//
		        				
		        			    setRemainAndAddedAndAbleCount($forIdSeperate, value);	//등록가능/전체/등록 건수 셋팅
		        			}
	       		        });
			        	
						remainCount();	//합계/남은 건수 셋팅
			        	$('.tar').css('display', 'none');	//삭제버튼 히든
		    }).fail(function(xhr){
		    	showAlert("발송희망일 세팅중 오류가 발생했습니다. \n\n (selectDateSaveCount())");
		    });
	  }
	  
	  //결재선 지정 select 뷰잉
	  function confirmSelect(groupUniqNo){
			  $.ajax({
			  url:'${pageContext.request.contextPath}/smssendlist/confirmSelect/' + groupUniqNo,
			  type:"GET",
			  success:function(empData){
				  if(empData.length > 0){
				  $('.tbl_wrap_view_sms03').css('border-top','1px solid #e0e0e0');
				  }
				  for(var i=0; i<empData.length; i++){
					  var agreeStatus = '승인 대기';
					  if(empData[i].agreeStatus == 'G'){
						  agreeStatus = '승인 완료';
					  }else if(empData[i].agreeStatus == 'I'){
						  agreeStatus = '승인 대기';
					  }else if(empData[i].agreeStatus == 'N'){
						  agreeStatus = '반려';
					  }
					  var confirmHtml = ''
					      + '<tr id="tr-' + empData[i].emplId + '">'
					      + '  <th scope="row" id="default-emp-count">0</th>'
					      + '  <td width="90px">' + empData[i].positionCallname + '</td>'	// 부서명 사이즈 변경 @jys
					      + '  <td width="80px">' + empData[i].emplName
					      + '     <span class="btn01">'
					      + '       <input type="hidden" class="confirm-emp-id" value="' + empData[i].emplId + '">'
					      + '       <input type="hidden" class="confirm-emp-class" value="' + empData[i].emplClass + '">' // Class 값 추가 @jys
					      + '</span>'
					      + '  </td>'
					      + '  <td width="80px">' + agreeStatus + '</td>'
					      + '  <input type="hidden" class="a1-confirm-emp-agreeStatus" value="' + empData[i].agreeStatus + '">' // Class 값 추가 @jys
					      + '</tr>';
				     $("#emp-table").prepend(confirmHtml);

			         $("#emp-table #default-emp-count").each(function(){	    		 
			      	   $(this).text(parseInt($(this).text()) + 1);	  
			         });
				  }
				  
				//2. 승인자별 승인 상태 셋팅
	       	  		var status = "I";
	       	  		$(".a1-confirm-emp-agreeStatus").each(function(){
	       	  			if($(this).val() == "N"){ //반려
	       	  				status = "N";
	       	  				return false;
                    	}else if($(this).val() == "G"){ //승인완료
	       	  				status = "G";
                        	return false;
                    	}else{  //승인대기
	       	  				status = "I";
	       	  			}
	       	  		});
	       	  		if(status == "G"){
	       	  			status = "(승인 완료)";
	       	  		}else if(status == "I"){
	       	  			status = "(승인 대기)";
	       	  		}else if(status == "N"){
	       	  			status = "(반려)";
	       	  		}
	       	  		
	       	  		var title = $("#a1"+" #articleTarget").text() + " ";
	       	  		$("#a1"+" #articleTarget").text(title + status);
	       	  		
			  },error : function (evt) {
				  console.log(evt);
			  }
		  })
	  }
	  
	  
	//발송 승인직원 등록  본인 select 뷰잉
	  function sendConfirmSelect(groupUniqNo){
			  $.ajax({
			  url:'${pageContext.request.contextPath}/smssendlist/sendConfirmSelect/' + groupUniqNo,
			  type:"GET",
			  success:function(empData){
				  if(empData.length > 0){
				  $('.tbl_wrap_view_sms03').css('border-top','1px solid #e0e0e0');
				  }
				  for(var i=0; i<empData.length; i++){
					  var agreeStatus = '승인 대기';
					  if(empData[i].agreeStatus == 'G'){
						  agreeStatus = '승인 완료';
					  }else if(empData[i].agreeStatus == 'I'){
						  agreeStatus = '승인 대기';
					  }else if(empData[i].agreeStatus == 'N'){
						  agreeStatus = '반려';
					  }
					  var emplHpNo = empData[i].emplHpNo;
					  if(emplHpNo != null){
					    	 if (emplHpNo.length == 8) {
					    		 emplHpNo = emplHpNo.replace(/^([0-9]{4})([0-9]{4})/, "$1-$2");
					    	 } else if (emplHpNo.length == 12) {
					    		 emplHpNo = emplHpNo.replace(/(^[0-9]{4})([0-9]{4})([0-9]{4})/, "$1-$2-$3");
					    	 }
					    	 emplHpNo = emplHpNo.replace(/(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})/, "$1-$2-$3");
					     }
					  var confirmHtml = ''
					        + '<tr id="tr-' + empData[i].emplId + '">'
					        + '  <th scope="row" id="default-emp-count">0</th>'
					        + '  <td width="70px">' + empData[i].positionCallname + '</td>'	// 부서명 사이즈 변경 @jys
					        + '  <td width= "90px">' + empData[i].emplName + '</td>'
					        + '  <td width= "200px">' + emplHpNo
					        + '     <span class="btn01">'
					        + '       <input type="hidden" class="sendConfirm-emp-class" value="' + empData[i].emplClass + '">' // Class 값 추가 @jys
					        + '       <input type="hidden" class="sendConfirm-emp-emplHpNo" value="' + empData[i].emplHpNo + '">'// Class 값 추가 @jys
					        + '</span>'
					        + '  </td>'
					        + '  <td width="80px">' + agreeStatus + '</td>'
					        + '  <input type="hidden" class="a4-confirm-emp-agreeStatus" value="' + empData[i].agreeStatus + '">' // Class 값 추가 @jys
					        + '</tr>';
				     $("#send-emp-table").prepend(confirmHtml);
	
			         $("#send-emp-table #default-emp-count").each(function(){	    		 
			      	   $(this).text(parseInt($(this).text()) + 1);	  
			         });
				  }
				  
				//2. 승인자별 승인 상태 셋팅
	       	  		var status = "I";
	       	  		$(".a4-confirm-emp-agreeStatus").each(function(){
	       	  			if($(this).val() == "N"){ //반려
	       	  				status = "N";
	       	  				return false;
	       	  			}else if($(this).val() == "I"){ //승인대기
	       	  				status = "I";
	       	  				return false;
	       	  			}else{	//승인완료
	       	  				status = "G";
	       	  			}
	       	  		});
	       	  		if(status == "G"){
	       	  			status = "(승인 완료)";
	       	  		}else if(status == "I"){
	       	  			status = "(승인 대기)";
	       	  		}else if(status == "N"){
	       	  			status = "(반려)";
	       	  		}
	       	  		
	       	  		var title = $("#a4"+" #articleTarget").text() + " ";
	       	  		$("#a4"+" #articleTarget").text(title + status);
	       	  		
	       	  		
			  },error : function (evt) {
				  console.log(evt);
			  }
		  })
	  }
	
	//결재선 2차 select 뷰잉
	  function digitalConfirmSelect(groupUniqNo){
			  $.ajax({
			  url:'${pageContext.request.contextPath}/smssendlist/digitalConfirmSelect/' + groupUniqNo,
			  type:"GET",
			  success:function(empData){
				  if(empData.length > 0){
				  $('.tbl_wrap_view_sms03').css('border-top','1px solid #e0e0e0');
				  }
				  for(var i=0; i<empData.length; i++){
					  var agreeStatus = '승인 대기';
					  if(empData[i].agreeStatus == 'G'){
						  agreeStatus = '승인 완료';
					  }else if(empData[i].agreeStatus == 'I'){
						  agreeStatus = '승인 대기';
					  }else if(empData[i].agreeStatus == 'N'){
						  agreeStatus = '반려';
					  }
					  var confirmHtml = ''
						  + '<tr id="tr-' + empData[i].emplId + '">'
					      + '  <th scope="row" id="default-emp-count">0</th>'
					      + '  <td width="90px">' + empData[i].positionCallname + '</td>'	// 부서명 사이즈 변경 @jys
					      + '  <td width="80px">' + empData[i].emplName
					      + '  </td>'
					      + '  <td width="80px">' + agreeStatus + '</td>'
					      + '  <input type="hidden" class="a2-confirm-emp-agreeStatus" value="' + empData[i].agreeStatus + '">' // Class 값 추가 @jys
					      + '</tr>';
				     $("#digital-emp-table").prepend(confirmHtml);
			         $("#digital-emp-table #default-emp-count").each(function(){	    		 
			      	   $(this).text(parseInt($(this).text()) + 1);	  
			         });
				  }
				  
				//2. 승인자별 승인 상태 셋팅
	       	  		var status = "I";
	       	  		$(".a2-confirm-emp-agreeStatus").each(function(){
	       	  			if($(this).val() == "N"){ //반려
	       	  				status = "N";
	       	  				return false;
                        }else if($(this).val() == "G"){ //승인완료
	       	  				status = "G";
                            return false;
                        }else{  //승인대기
	       	  				status = "I";
	       	  			}
	       	  		});
	       	  		if(status == "G"){
	       	  			status = "(승인 완료)";
	       	  		}else if(status == "I"){
	       	  			status = "(승인 대기)";
	       	  		}else if(status == "N"){
	       	  			status = "(반려)";
	       	  		}
	       	  		
	       	  		var title = $("#a2"+" #articleTarget").text() + " ";
	       	  		$("#a2"+" #articleTarget").text(title + status);
			  },error : function (evt) {
				  console.log(evt);
			  }
		  })
	  }
	
	
	//결재선 3차 select 뷰잉
	  function cmsConfirmSelect(groupUniqNo){
			  $.ajax({
			  url:'${pageContext.request.contextPath}/smssendlist/cmsConfirmSelect/' + groupUniqNo,
			  type:"GET",
			  success:function(empData){
				  if(empData.length > 0){
				  $('.tbl_wrap_view_sms03').css('border-top','1px solid #e0e0e0');
				  }
				  for(var i=0; i<empData.length; i++){
					  var agreeStatus = '승인 대기';
					  if(empData[i].agreeStatus == 'G'){
						  agreeStatus = '승인 완료';
					  }else if(empData[i].agreeStatus == 'I'){
						  agreeStatus = '승인 대기';
					  }else if(empData[i].agreeStatus == 'N'){
						  agreeStatus = '반려';
					  }
					  var confirmHtml = ''
						  + '<tr id="tr-' + empData[i].emplId + '">'
					      + '  <th scope="row" id="default-emp-count">0</th>'
					      + '  <td width="90px">' + empData[i].positionCallname + '</td>'	// 부서명 사이즈 변경 @jys
					      + '  <td width="80px">' + empData[i].emplName
					      + '  </td>'
					      + '  <td width="80px">' + agreeStatus + '</td>'
					      + '  <input type="hidden" class="a3-confirm-emp-agreeStatus" value="' + empData[i].agreeStatus + '">' // Class 값 추가 @jys
					      + '</tr>';
				     $("#cms-emp-table").prepend(confirmHtml);
	
			         $("#cms-emp-table #default-emp-count").each(function(){	    		 
			      	   $(this).text(parseInt($(this).text()) + 1);	  
			         });
				  }
				  
				//2. 승인자별 승인 상태 셋팅
	       	  		var status = "I";
	       	  		$(".a3-confirm-emp-agreeStatus").each(function(){
	       	  			if($(this).val() == "N"){ //반려
	       	  				status = "N";
	       	  				return false;
                        }else if($(this).val() == "G"){ //승인완료
	       	  				status = "G";
                            return false;
                        }else{  //승인대기
	       	  				status = "I";
	       	  			}
	       	  		});
	       	  		if(status == "G"){
	       	  			status = "(승인 완료)";
	       	  		}else if(status == "I"){
	       	  			status = "(승인 대기)";
	       	  		}else if(status == "N"){
	       	  			status = "(반려)";
	       	  		}
	       	  		
	       	  		var title = $("#a3"+" #articleTarget").text() + " ";
	       	  		$("#a3"+" #articleTarget").text(title + status);
			  },error : function (evt) {
				  console.log(evt);
			  }
		  })
	  }
	  
	  
	  
	  
	  
////예산합의서명 발송 건수 200만원 이상일 경우
  function showConfirmDoc(){
	  //### 예산합의서명 발송 건수 200만원 이상일 경우 필수 값으로 체크
	  var msgType = $("#msg-type").val().substr(0,2).toUpperCase();
	  var requestsNumber = $("#expect-count").val().replace(/,/g, '');
      if(msgType == "SM"){
          var price =  "${KT_SM}";
          price = price == "" ? "9" : price // default
        }else if(msgType == "LM"){
          var price =  "${KT_LM}";
          price = price == "" ? "30" : price // default
        }else if(msgType == "MM"){
      	  var price =  "${KT_MM}";
      	  price = price == "" ? "100" : price // default
        }
	  
	  var sendPrice = (parseFloat(price) * parseFloat(requestsNumber));
	  
	  if(sendPrice >= 2000000){
		  	$('#tr_confirm-doc-name').show();
	  }else{
		  	$('#tr_confirm-doc-name').hide();
	  }
}

</script> 