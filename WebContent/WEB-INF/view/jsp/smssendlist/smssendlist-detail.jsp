<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- article -->
    <h3>
        <c:choose>
            <c:when test="${smssendlist.prcssStusDstic  eq 'C'}">상세보기 > 임시저장</c:when>
            <c:when test="${smssendlist.prcssStusDstic  eq 'N'}">상세보기 > 반려</c:when>
        </c:choose>
    </h3>
    <!-- content -->
    <div id="content">
        <!-- table_view -->
        <div class="tbl_wrap_view">
            <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                <colgroup>
                    <col style="width:140px"/>
                    <col style="width:auto"/>
                </colgroup>
                <tr>
                    <th scope="row">기안명<span class="th_must">*</span></th>
                   <td><input type="text" name="search" maxlength="333" id="request-title" value="${smssendlist.groupNm}"
                               placeholder="기안명을 입력해주시기 바랍니다." style="width:700px"></td>
                </tr>
                <tr>
                    <th scope="row">발송구분<span class="th_must">*</span></th>
                    <td>
                          <div class="row1">
                            <div class="radio_default">
                                <input type="radio" name="request-type" value="marketing"
                                       id="radio1-1"
                                       <c:if test="${smssendlist.sendType eq 'marketing'}"> checked="checked" </c:if>/>
                                <label for="radio1-1">마케팅(고객관리 포함)</label>
                            </div>
                            <div class="radio_default">
                                <input type="radio" name="request-type" value="noMarketing"
                                       id="radio1-2"
                                       <c:if test="${smssendlist.sendType eq 'noMarketing'}"> checked="checked" </c:if>/>
                                <label for="radio1-2">비마케팅(기존계약의 유지 · 관리 등)</label>
                            </div>
                        </div>
                        <div class="row2">
                            <div class="title">개인정보보호법 (제15조,22조)에 의거하여 개인정보 이용 통제 및 금융소비자의 권리 보장을
                                위한 설정으로 민원 등 분쟁이 발생되지 않도록 유의바랍니다.
                            </div>
                        </div>
                        <div class="row2 pdl10">
                            <ul>
                                <li>【공지(비마케팅) 목적의 예시】</li>
                                <li>- 대출 원리금 납입 · 미납, 은행상품 만기 안내</li>
                                <li>- 은행상품의 갱신 안내, 은행상품의 계약 조건 변경 안내(금리 인상 · 인하 등)</li>
                                <li>- 금융거래보호를 위해 통지할 필요가 있는 사항 안내</li>
                                <li>- 법 · 규정 시행 예정 통지</li>
                                <li>- 부가서비스 · 이용혜택 변경 안내</li>
                                <li>- 상품 및 서비스 가입을 위한 필요서류 · 조건, 상세내용 및 진행과정 안내</li>
                                <li>- 민원처리 과정 안내, 완전판매 모니터링 진행</li>
                                <li>- 영업점 이전 · 통합 · 폐쇄 등의 안내</li>
                                <li>- 기타 계약의 유지 · 관리에 필요한 경우 등</li>
                            </ul>
                        </div>
                        <div class="row2">
                            <div class="title">문의 : 정보보호관리팅(8-5410)</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">메세지타입<span class="th_must">*</span></th>
                    <td>
                        <select class="small" id="msg-type">
                            <option value="sms" <c:if test="${smssendlist.msgDstic eq 'SM' || smssendlist.msgDstic eq null}">selected</c:if> >SMS</option>
                            <option value="lms" <c:if test="${smssendlist.msgDstic eq 'LM'}">selected</c:if> >LMS</option>
                            <option value="mms" <c:if test="${smssendlist.msgDstic eq 'MM'}">selected</c:if> >MMS</option>
                        </select>
                        <span class="txt1">*SMS(90byte이내) / LMS(2,000byte이내) / MMS(2,000byte이내+이미지첨부)</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">예상발송건수<span class="th_must">*</span></th>
                    <td>
                        <input id="expect-count" type="text" name="" value="${smssendlist.requestsNumber}" style="width:150px" <c:if test="${cntTarget != 0}"> readonly="readonly" </c:if>>&nbsp;건
                    </td>
                </tr>
                <tr>
                    <th scope="row">대상자 파일</th>
                    <td>
                        <input type="text" id="file-name-input" value="${smssendlist.inst}" placeholder="파일 업로드" style="width:330px" readonly="readonly"> <!-- View 전용 파일명 -->
                        <input type="hidden" id="real-file-name-input" placeholder="파일 업로드" style="width:330px"> <!-- DB처리 파일명 -->
                        <input type="file" id="fileupload" name="file" data-url="${pageContext.request.contextPath}/smsreq/file/customers" style="display:none" placeholder="파일 업로드">
                        <a href="javascript:" id="delete-fileupload-btn" class="btn_default small delete mgl6 vam00" style="display:none;">X</a>
                        <a href="javascript:" class="btn_default gray mgl6 vam00" id="fileupload-btn">선택</a>
                        <a href="${pageContext.request.contextPath}/smsreq/download/sample/general" class="btn_download_blue mgl20">일반 발송 샘플</a>
                        <a href="${pageContext.request.contextPath}/smsreq/download/sample/extra" class="btn_download_blue mgl20">치환형 발송 샘플</a>
                    </td>
                </tr>
                <tr>
                    <th scope="row">메세지 내용<span class="th_must">*</span></th>
                    <td><!-- wrap_box_sms -->
                        <div class="wrap_box_sms">
                            <!-- box_sms -->
                            <div class="wrap_cbtn">
                                <div class="col1" <c:if test="${cntReplaceVal == -1}"> style="display: none" </c:if>>치환변수</div>
                                <div class="col2">
                                    <c:if test="${cntReplaceVal != -1}">
                                        <c:forEach var="idx" begin="0" end="${cntReplaceVal}" step="1">
                                            <a href="javascript:" class="btn_default blue mgr6 mgb6 repl-var" id="${replaceNmList[idx]}">${replaceNmList[idx]}(${replaceNmMaxList[idx]})</a>
                                            <input type="hidden" class="${replaceNmList[idx]}" value='${replaceNmMaxList[idx]}'>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                            <div class="box_sms">
                                <div class="content">
                                    <div class="title_sms" id="msg-title-div" <c:if test="${smssendlist.msgDstic eq 'SM'}"> style="display: none" </c:if>>
                                        <input class="sms" type="text" id="msg-title"
                                               placeholder="제목을 입력해주세요.(60byte)"
                                               <c:if test="${smssendlist.msgDstic ne 'SM'}"> value="${smssendlist.msgCtnt}"</c:if>
                                               style="width:200px">
                                        <input type="hidden" id="asis-msg-title" <c:if test="${smssendlist.msgDstic ne 'SM'}"> value="${smssendlist.msgCtnt}"</c:if>>
                                    </div>
                                    <div 
                                        <c:if test="${smssendlist.msgDstic eq 'SM'}"> class="text_sms2" id="div-texarea" style="width:100%; height:350px;"</c:if>
                                        <c:if test="${smssendlist.msgDstic ne 'SM'}"> class="text_sms" id="div-texarea" style="width:100%; height:310px;"</c:if>
                                    >
                                        <textarea class="sms" id="content-textarea"
                                                  placeholder="내용을 입력하세요"
                                                  style="font-family:굴림; font-size:16px; width:100%; height:100%"><c:if test="${smssendlist.msgDstic eq 'SM'}">${smssendlist.msgCtnt}</c:if><c:if test="${smssendlist.msgDstic ne 'SM'}">${smssendlist.umsMsgCtnt}</c:if></textarea>
                                        <textarea class="sms" id="asis-content-textarea"
                                                  placeholder="내용을 입력하세요"
                                                  style="font-family:굴림; font-size:16px; width:100%; height:100%; display: none;"><c:if test="${smssendlist.msgDstic eq 'SM'}">${smssendlist.msgCtnt}</c:if><c:if test="${smssendlist.msgDstic ne 'SM'}">${smssendlist.umsMsgCtnt}</c:if></textarea>
                                    </div>
                                    <div class="byte"><span id="dis-total-byte">0</span>/<span
                                            id="dis-max-byte"><c:if test="${smssendlist.msgDstic eq 'SM'}"> 90</c:if><c:if test="${smssendlist.msgDstic ne 'SM'}"> 2000</c:if></span>byte
                                    </div>
                                </div>
                                <div class="mgt33"><a href="javascript:"><img
                                        id="special-char-show-img"
                                        src="${pageContext.request.contextPath}/static/images/btn_sms01.png"
                                        alt="특수문자"/></a><a href="javascript:" class="mgl6"><img
                                        id="preview-dialog-show-img"
                                        src="${pageContext.request.contextPath}/static/images/btn_sms02.png"
                                        alt="미리보기"/></a></div>
                            </div>
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
                                <div class="total"> 총 건수<span class="right">정상 : <span class="blue">${cntTarget}</span>건  /  에러 : <span class="red">0</span>건</span></div>
                                <div class="mgt20">
                                    <ul class="disib">
                                        <li class="disib">발신번호<span class="th_must">*</span>
                                                <input type="text" id="send-phonenum" class="mgl5" value="${smssendlist.sndrTelno}"  maxlength="16"
                                                       style="width:100px">
                                        </li>
                                        <div style="display: none;">
	                                        <li class="disib mgl20" id="validation-num-li" <c:if test="${smssendlist.sendType eq 'noMarketing' }">style="display:none !important;"</c:if> >심의필번호
	                                            <input type="text" id="validation-num" class="mgl5" value="${smssendlist.censorId}"
	                                                  style="width:100px; ">
	                                        </li>
                                        </div>
                                    </ul>
                                </div>
                            </div>
                            <!-- //box_list -->
                        </div>
                        <!-- wrap_box_sms --></td>
                </tr>
                <tr <c:if test="${smssendlist.msgDstic eq 'SM'|| smssendlist.msgDstic eq 'LM'}"> style="display: none" </c:if> id="img-tr">
                    <th scope="row">이미지 파일<span class="th_must">*</span></th>
                    <td>
                        <div class="wrap_form" style="border-top:0px; border-bottom:0px; padding-bottom:0px; ">
	                    <ul class="box_ms mgt10">
	                        <li>
	                            <div class="image_box" style="margin-bottom: 0px;" id="select_selectSEQ1" > 
	                            	<img <c:if test="${smssendlist.seq1 != null}"> style="width:100%;height:100%;" src="${pageContext.request.contextPath}/template-img.ibk?seq=${smssendlist.seq1}"  </c:if> />
				            	</div>
	                        </li>
	                        <li>
							    <div class="image_box" style="margin-bottom: 0px;" id="select_selectSEQ2" > 
									<img <c:if test="${smssendlist.seq2 != null}"> style="width:100%;height:100%;" src="${pageContext.request.contextPath}/template-img.ibk?seq=${smssendlist.seq2}"  </c:if> />
								</div>
							</li>
							<li>
								<div class="image_box" style="margin-bottom: 0px;" id="select_selectSEQ3" > 
				            		<img <c:if test="${smssendlist.seq3 != null}"> style="width:100%;height:100%;" src="${pageContext.request.contextPath}/template-img.ibk?seq=${smssendlist.seq3}"  </c:if> />
				            	</div>
	                        </li>
	                    </ul>
                    </div>
                    <div class="ment_sms01" style="margin-top: 0px;">*최소1개, 최대3개 까지 가능합니다.<a href="javascript:" id="img-desc-btn" class="btn_small mgl15">이미지 규격</a></div>
                    </td>
                </tr>
                <tr id="tr_confirm-doc-name" style="display: none;">
                    <th scope="row">예산합의서명</th>
                    <td><input type="text" id="confirm-doc-name" maxlength="50" value="${smssendlist.budgetNm}"
                               placeholder="전략기획부하 승인 된 예산 품의서 명을 입력해주세요." style="width:650px">
                        <div class="row2 mgt10">
                            <ul>
                                <li>【예산합의 대상여부 확인】</li>
                                <li>- 발송비용 200만원 초과여부 : SMS /LMS 단가 * 예상발송건수(연간)</li>
                                <li>- 초과 : 전략기획부, 개인디지털채널부 합의</li>
                                <li class="pdl20">* 합의내용 : 전략기획부 - 예산합의 / 개인디지털채널부 – LMS발송</li>
                                <li>- 200만원 미만인 경우 합의 생략</li>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">발송 희망일<span class="th_must">*</span></th>
                    <td>
                        <div class="row1">
                            <div class="box_text01">합계<span id="total-count">0</span></div>
                            <div class="box_text_arrow"></div>
                            <div class="box_text02">남은건수<span id="remain-count">0</span></div>
                        </div>
                        <div id="dispatch-body"></div>
                        <div class="ment_sms01">*1일 50,000건, 시간당 5,000건 이하를 권장합니다.
                            <span class="btn" style="display: none;"><a href="javascript:" id="dispatch-add-btn"
                                                 class="btn_default gray">+ 희망일 추가</a></span>
                        </div>
                    </td>
                </tr>
                <tr style="display: none;">
                    <th scope="row">결재선 지정<span class="th_must">*</span></th>
                    <td colspan="3">
                        <div class="faq">
                            <ul class="faqBody">
                                <li class="article hide" id="a1">
                                    <p class="q">1차 <a href="#a1" id="articleTarget" style="text-decoration:none">기안부</a><a href="javascript:" id="employee-search-btn" class="btn_default gray mgl10" style="width:38px">검색</a></p>
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
                                <li class="article hide" id="a2" id="articleTarget">
                                    <p class="q">2차 <a href="#a2" style="text-decoration:none">개인디지털채널부</a></p>
                                </li>
                                <li class="article hide" id="a3" id="articleTarget">
                                    <p class="q">3차 <a href="#a3" style="text-decoration:none">IBK고객센터</a></p>
                                </li>
                            </ul>
                        </div>
                      </td>
                </tr>
                <tr>
                    <th scope="row">발송 승인직원<br>
                        등록
                    </th>
                    <td>
                        <div class="row1">발송 승인 대기 단계에서 진행</div>
                        <div class="row1 color_orange">* 승인자 등록에 설정된 승인자의 모든 승인이 완료되면 발송승인자 등록이
                            활성화되며,<br>
                            &nbsp;&nbsp;해당절차(TEST발송)의 승인자의 승인이 완료되어야 발송가능 함.
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
            <a href="javascript:" class="btn_big blue" id="confirm-req-btn">기안 등록</a>
            <a href="javascript:" class="btn_big blue" id="save-temp" >임시저장</a>
            <a href="javascript:" class="btn_big" id="cancel-btn">취소</a>
        </div>
        <!-- //버튼 -->
    </div>
    <!-- //content -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="../common/special-char-dialog.jsp" flush="true"/>
<jsp:include page="../common/preview-dialog.jsp" flush="true"/>
<jsp:include page="../common/smsreq_usersearch-list.jsp" flush="true"/> <!-- 승인자 검색 다이얼로그 수정 @jys -->

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
      $("#confirm-req-btn").hide();
      $("#save-temp").hide();
  }
  var todayYYYYMMDD = moment().format("YYYYMMDD");
  var lastAddedDay = moment().format("YYYYMMDD");
  var lmscontents = $("#content-textarea").val();
  var groupUniqNo = '${smssendlist.groupUniqNo}';
  var requestsNumber = ${smssendlist.requestsNumber};
  var commaReqNum = $.number(requestsNumber);
  
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
    if($('#msg-type').val() == 'sms'){
        $("#content-textarea").val(lmscontents); //메시지내용 세팅
        $('#dis-total-byte').text(IbkByteCheck.getBytes(lmscontents)); //byte 세팅
    }else {
        $("#msg-title").val($('#msg-title').val()); //메시지제목 세팅
        $("#content-textarea").val(lmscontents) //메시지내용 세팅
        $('#dis-total-byte').text(IbkByteCheck.getBytes(lmscontents)); //byte 세팅
    }
    $("#total-count").text(commaReqNum); // 발송희망일 합계 세팅
    $("#validation-num").val("${smssendlist.censorId}"); //심의필 번호 세팅
    //정상건수, 에러건수 세팅도 해줘야함.(db결정되면 등록해야함~!!!!)
    $("#send-phonenum").val("${smssendlist.sndrTelno}"); //발신번호 세팅
    $("#file-name-input").val("${smssendlist.inst}"); //대상자파일 
    $("#confirm-doc-name").val("${smssendlist.budgetNm}"); //예산합의서명 세팅
    
    showConfirmDoc(); // 예산합의서명 노출 여부
    
    $("#fileupload-btn").on("click", function () {
      $("#fileupload").trigger('click');
    });

    $('#fileupload').fileupload({
        dataType: 'json',
        add : function(e, data) {
            var uploadFile = data.files[0];
            var isValid = true;
            console.log(uploadFile.size);
            var sendData=saveReqData();
            if (!(/xls|xlsx|csv|XLS|XLSX|CSV/i).test(uploadFile.name)) {
                alert('xls, xlsx,csv 만 가능합니다!');
                isValid = false;
                return false;
            }
            data.formData = {
                                        'groupUniqNo'   : sendData.groupUniqNo,
                                        'sendType'          : sendData.sendType === 'marketing' ? 'm' : 'g',    
                                        'msgDstic'          : sendData.msgDstic
            };
    
            if (isValid) {
                                data.submit();
            }
        },
        done: function (e, data) {
            console.log(data.files[0].name);
            var result=data.result;
            for(var key in result){
            console.log("key : " + key + ", value : " + result[key]);
            }
            if(result.message==null){
                $("#file-name-input").val(data.files[0].name);  
                console.log(result.realFileName);
                $("#real-file-name-input").val(result.realFileName);
                
                //##초기화
                // 1. 치환변수 문구 숨기기
                $(".wrap_cbtn .col1").hide();
                // 2. 치환변수 버튼 삭제
                $(".wrap_cbtn .col2").empty();
                // 3. 치환변수 헤더 삭제
                $("#display_head tr").children().each(function(idx){
                    if(idx >= 3){
                        $(this).remove();
                    }
                });
                extraFlag=false;
                firstRow=null;
                //##치환변수 테이블 헤더 추가 및 버튼 생성
                if(result.extFieldName != null && result.extFieldName.length > 0){
                    var arrHead = result.extFieldName;
                    var arrMax = result.byteMax;
                    // 1. 치환변수 테이블 헤더 생성
                    var outputHead = "";
                    var outputButton = "";
                    for(idx in arrHead){
                        outputHead += "<th>" + arrHead[idx] + "</th>";
                        
                        outputButton += '<a href="javascript:" class="btn_default blue mgr6 mgb6 repl-var" id="' + arrHead[idx] + '">' + arrHead[idx] + '(' + arrMax[idx] + ')</a>'
                                            + '<input type="hidden" class="' + arrHead[idx] + '" value="' + arrMax[idx]+ '">';
                    }
                    $("#display_head tr").append(outputHead);
                    
                    // 2. 치환변수 버튼 생성
                    $(".wrap_cbtn .col1").show();
                    $(".wrap_cbtn .col2").append(outputButton);
                    
                    //extra 여부 변경
                    extraFlag=true;
                }
                
                if(result.displayList.length>0){
                    var targets=result.displayList;
                    $("#display_body tr").unbind().remove();
                    var indexRow=1;
                    for(key in targets){
                        var map=targets[key];
                    	if(extraFlag && indexRow==1){
                    		firstRow=map;
                    	}
                        var output="";
                        for(key in map){
                            output = output + "<td>" + map[key] + "</td>"
                        }
                        var listElement=$("<tr>").html(output);
                        $("#display_body").append(listElement);
                        indexRow+=1;
                    }
                }
                
                // 정상/에러 건수 셋팅
                $(".total .blue").text($.number(result.totCnt)); //정상 건수
                $(".total .red").text($.number(result.errCnt));                     //에러 건수
                
                //예상발송건수 셋팅
                var expectValue = $(".total .blue").text();
                $("#total-count").text(expectValue);
                $("#expect-count").val(expectValue);
                $("#expect-count").prop("readonly", true);
                remainCount();
                
                showConfirmDoc();
                
                var errMapMsg="총:"+($.number(result.totCnt+result.errCnt))+"건, 정상:"+result.totCnt+"건, 에러:"+result.errCnt+"건";
                if($.number(result.errCnt)>0){
                     for(var key in result.errMap){
                    	 errMapMsg+="<br>";
                         console.log("key : " + key + ", value : " + result.errMap[key]);
                         errMapMsg+=key+"라인: "+ result.errMap[key];
                     }   	 
                }
                showAlert(errMapMsg);
                
            }else{
                showAlert(result.message);
            }
            
        }
    });

    $("#image-file-btn1").on("click", function () {
      $("#image-fileupload1").trigger('click');
    });

    //이미지 파일1 제거 버튼 이벤트
    $("#delete-image-file-btn1").on("click", function () {
        //showConfirmForAjax(title, message, callback, targetObject)
        showConfirmForAjax("등록 파일 제거", "등록된 이미지 파일1( '" + $("#image-fileupload-input1").val() + "' )을 <br>제거 하시겠습니까?", remove_uploadFile, "Img1");
    });
    
    $('#image-fileupload1').fileupload({
      dataType: 'json',
      done: function (e, data) {
        $("#image-fileupload-input1").val(data.files[0].name);
        $("#real-image-fileupload-input1").val(data.files[0].name);
        $("#blob-image-fileupload-input1").val(data.result.fileBLOB);
        $("#delete-image-file-btn1").show();
      }
    });

    $("#image-file-btn2").on("click", function () {
      $("#image-fileupload2").trigger('click');
    });

    //이미지 파일2 제거 버튼 이벤트
    $("#delete-image-file-btn2").on("click", function () {
        //showConfirmForAjax(title, message, callback, targetObject)
        showConfirmForAjax("등록 파일 제거", "등록된 이미지 파일2( '" + $("#image-fileupload-input2").val() + "' )을 <br>제거 하시겠습니까?", remove_uploadFile, "Img2");
    });
    
    $('#image-fileupload2').fileupload({
      dataType: 'json',
      done: function (e, data) {
        $("#image-fileupload-input2").val(data.files[0].name);
        $("#real-image-fileupload-input2").val(data.files[0].name);
        $("#blob-image-fileupload-input2").val(data.result.fileBLOB);
        $("#delete-image-file-btn2").show();
      }
    });

    $("#image-file-btn3").on("click", function () {
      $("#image-fileupload3").trigger('click');
    });
    
    //이미지 파일3 제거 버튼 이벤트
    $("#delete-image-file-btn3").on("click", function () {
        //showConfirmForAjax(title, message, callback, targetObject)
        showConfirmForAjax("등록 파일 제거", "등록된 이미지 파일3( '" + $("#image-fileupload-input3").val() + "' )을 <br>제거 하시겠습니까?", remove_uploadFile, "Img3");
    });
    
    $('#image-fileupload3').fileupload({
      dataType: 'json',
      done: function (e, data) {
        $("#image-fileupload-input3").val(data.files[0].name);
        $("#real-image-fileupload-input3").val(data.files[0].name);
        $("#blob-image-fileupload-input3").val(data.result.fileBLOB);
        $("#delete-image-file-btn3").show();
      }
    });

    $("#send-phonenum").on("keyup", function(){
        inputPhoneType($(this));
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
      
      //이미지 파일 초기화
      if ($(this).val() !== 'mms') {
        $("#image-fileupload-input1").val("");
        $("#real-image-fileupload-input1").val("");
        $("#blob-image-fileupload-input1").val("");
        $("#image-fileupload-input2").val("");
        $("#real-image-fileupload-input2").val("");
        $("#blob-image-fileupload-input2").val("");
        $("#image-fileupload-input3").val("");
        $("#real-image-fileupload-input3").val("");
        $("#blob-image-fileupload-input3").val("");
      }
    });

    selectDateTotalCount(todayYYYYMMDD); // 발송 희망일 셋팅 @jys
    selectDateSaveCount(todayYYYYMMDD);
    
//     IbkDispatchHtml.appendTo("dispatch-body", todayYYYYMMDD, "Y");
//     IbkDatepicker.initDatepicker("datepicker-" + todayYYYYMMDD,
//         "${pageContext.request.contextPath}", 0);
//     $("#datepicker-" + todayYYYYMMDD).val(moment(todayYYYYMMDD, 'YYYYMMDD').format('YYYY-MM-DD'));
//     removePassedTime2();
    confirmSelect(groupUniqNo);
   
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
    if($('#emp-table').find('tr').length == 5){
          showAlert("결재선 지정은 최대 5명까지 가능합니다.");
          return false;
    }
	  
    e.preventDefault();
    $("#employee_search-word-type").val('BoCode');
    var isScrollPopup = true;
    userSearchInit(user_bocode, isScrollPopup); // 부서코드 세션에서 받아와서 전달 @jys  
  });

  //
  $("#confirm_in_search-btn").on('click', function () {
    if(!addable){ return false};
    $(".tbl_wrap_view_sms03").css("border-top","1px solid #e0e0e0");
    var empData = IbkDataTableInSearch.dataTable.row(
        $(".search-dt-check-box:checked").val()).data();
    var employyHtml = ''
        + '<tr id="tr-' + empData.emplId + '">'
        + '  <th scope="row" id="default-emp-count">1</th>'
        + '  <td width="90px">' + empData.positionCallname + '</td>'    // 부서명 사이즈 변경 @jys
        + '  <td>' + empData.emplName
        + '     <span class="btn01">'
        + '       <input type="hidden" class="confirm-emp-id" value="' + empData.emplId + '">'
        + '       <input type="hidden" class="confirm-emp-class" value="' + empData.emplClass + '">' // Class 값 추가 @jys
        + '       <a href="javascript:" class="btn_default emp-del-btn" id="' + empData.emplId
        + '">삭제</a>'
        + '</span>'
        + '  </td>'
        + '</tr>';

    // 승인자 추가시 넘버링 오류 수정 @jys
    $("#emp-table #default-emp-count").each(function(){
        $(this).text(parseInt($(this).text()) + 1);
    });
    $("#emp-table").prepend(employyHtml);
  });

  $(document).on('click', '.emp-del-btn', function () {
    $("#tr-" + $(this).attr('id')).remove();
//     if($("#tr-" + $(this).attr('id')).val() == null){
//     $(".tbl_wrap_view_sms03").css("border-top","1px solid #ffffff");
//     }
    // 승인자 삭제시 넘버링 오류 수정 @jys
    $("#emp-table #default-emp-count").each(function(idx){
        
        $(this).text(parseInt(idx+1));
    });
//     $("#default-emp-count").text(parseInt($("#default-emp-count").text()) - 1);
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

  // 결제 올리기 버튼 클릭시 Action ( .off('click') : 연속클릭 동작 제거)
  $("#confirm-req-btn").off('click').on('click', function () {
    IbkDispatchHtml.validateDispatch(false);
    if(!checkValidation()){ // validation!!
        return false;
    }
    
    var smsReqData = saveReqData();
    var sendTime = '';
    var sendTypeName = smsReqData.sendType === 'marketing' ? '마케팅' : '비마케팅';
    var tempDate = '';
    
    $.each(smsReqData.sendDateInfo, function (index, value) {
      var momentTime = moment(value.pengagYms, 'YYYYMMDDHHmm');
      if (tempDate === momentTime.format('YYYY-MM-DD')) {
        sendTime += ', &nbsp;' + momentTime.format('HH:mm');
        sendTime += '&nbsp;(' + value.sectionNumber +")";
      } else {
        if (tempDate !== '') {
          sendTime += '<br>';
        }
        sendTime += momentTime.format('YYYY-MM-DD');
        sendTime += '&nbsp;' + momentTime.format('HH:mm');
        sendTime += '&nbsp;(' + value.sectionNumber +")";
        tempDate = momentTime.format('YYYY-MM-DD');
      }
    });
    
    var confirmBodyMessage = '<div class="content_pop">\n'
        + '    <p class="fwb">기안 내용 요약</p>\n'
        + '    <ul class="pdl10 mgt10">\n'
        + '      <li>- 발송업무 : ' + sendTypeName + '</li>\n'
        + '      <li>- 메시지타입 : ' + smsReqData.msgDstic.toUpperCase() + '</li>\n'
        + '      <li>- 총 발송건수 : ' + $.number(smsReqData.requestsNumber) + '건</li>\n'
        + '      <li>- 발송 일정 : ' + sendTime
        + '      </li>\n'
        + '    </ul>\n'
        + '    <p class="mgt20">기안 승인요청 하시겠습니까?</p>\n'
        + '  </div>';
    showConfirmForAjax('결제 올리기', confirmBodyMessage, saveSmsReq, smsReqData);
  });

  function saveSmsReq(smsReqData){
    $.ajax({
      url: '${pageContext.request.contextPath}/smssendlist/tmpSave',
      type: "POST",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(smsReqData),
    }).done(function(data) {
      showAlert("결재 요청 하였습니다.", redirectList);
    }).fail(function(xhr) {
    	showAlert("결재 요청 중 에러 발생<br><br>에러 메시지<br>["+xhr.responseJSON.message+"]<br>에러코드<br>["+xhr.status+"]<br>관리자에게 문의 바랍니다.<br><br>error<br>"+xhr.responseText);
    });
  }

  // 임시저장 버튼 클릭시 Action
  $("#save-temp").on('click', function () {
    IbkDispatchHtml.validateDispatch(false);
    var smsReqData = saveReqData();
    smsReqData.tempSave = 'tempSave';
    $.ajax({
      url: '${pageContext.request.contextPath}/smssendlist/tmpSave',
      type: "POST",
      contentType: "application/json; charset=utf-8",
      dataType:"json",
      data: JSON.stringify(smsReqData),
    }).done(function(data) {
      showAlert("저장 하였습니다.", redirectList);
    }).fail(function(xhr) {
    	showAlert("저장 중 에러 발생<br><br>에러 메시지<br>["+xhr.responseJSON.message+"]<br>에러코드<br>["+xhr.status+"]<br>관리자에게 문의 바랍니다.<br><br>error<br>"+xhr.responseText);
    });
  });
  
  //validation check!
  function checkValidation(){
      // 기안명 확인
        if($('#request-title').val() == null || $('#request-title').val().replace(/ /gi, '') == ''){
            $('#request-title').focus();
            showAlert("기안명을 입력해 주시기 바랍니다.");
            return false;
        }
        
      //예상 발송 건수 확인
        if($('#expect-count').val() == null || $('#expect-count').val() == '0' || $('#expect-count').val().replace(/ /gi, '') == ''){
            $('#expect-count').focus();
            showAlert("예상발송건수를 입력해주시기 바랍니다.");
            return false;
        }

      // 대상자 업로드 시 예상발송건수와 대상자 정상건수 불일치 체크
      if($("#file-name-input").val() != null && $("#file-name-input").val() != ""){
          var cntTarget = $(".total .blue").text().replace(/,/g,"");
          var cntExpect = $("#expect-count").val().replace(/,/g,"");
          if(cntTarget != cntExpect){
              $("#expect-count").focus();
              showAlert("예상발송건수와 대상자 정상건수가 같지 않습니다.<br>예상발송건수를 확인해 주세요.");
              return false;
          }
      }
      
      //MMS 일 경우 이미지 파일 업로드 확인
        if($("#msg-type").val() == 'mms'){
            if($("#real-image-fileupload-input1").val() == '' && $("#real-image-fileupload-input2").val() == '' && $("#real-image-fileupload-input3").val() == '' ){
                  $("#image-fileupload-input1").focus();
                  showAlert("MMS 발송 이미지 파일을 확인해 주세요.<br><br>* 이미지가 없을 경우 LMS로 발송해 주시기 바랍니다.");
                  return false;
            }
        }
        
      //메시지 제목 및 내용 확인
        if($('#msg-type').val() == 'sms'){
            if($('#content-textarea').val()  == '' || $('#content-textarea').val()  == null || $('#content-textarea').val().replace(/ /gi, '') == ''){
                $('#content-textarea').focus();
                showAlert("메세지 내용을 입력해 주시기 바랍니다.");
                return false;
            }
        }else{
            if($('#msg-title').val() == null || $('#msg-title').val().replace(/ /gi, '') == ''){
                $('#msg-title').focus();
                showAlert("메시지 제목을 입력해 주시기 바랍니다.");
                return false;
            }
            if($('#content-textarea').val() == null || $('#content-textarea').val().replace(/ /gi, '') == ''){
                $('#content-textarea').focus();
                showAlert("메세지 내용을 입력해 주시기 바랍니다.");
                return false;
            }
        }
        
      //발신번호 입력 확인
        if($('#send-phonenum').val() == null  || $('#send-phonenum').val().replace(/ /gi, '') == '' ){
            $('#send-phonenum').focus();
            showAlert("발신번호를 입력해 주시기 바랍니다.");
            return false;
        }

//         if($('#tr_confirm-doc-name').is(":visible")){
//             if($('#confirm-doc-name').val() == null || $('#confirm-doc-name').val() == ''){
//               $('#confirm-doc-name').focus();
//               showAlert('예산합의서명을 입력해 주시기 바랍니다.');
//               return false;
//             }
//         }
      
//       //결재선 지정 확인
//         if($('.confirm-emp-id').length < 1){
//             $('#articleTarget').focus();
//             showAlert('결재선을 지정해 주세요.');
//             return false;
//         }
        
//         var ok = true;
//         $('.article').each(function(){
//             var type = 1;
//             if($(this).prop('id') == 'a1'){
//                 type = 1;
//             }else if($(this).prop('id') == 'a2'){
//                 type = 2;
//             }else if($(this).prop('id') == 'a3'){
//                 type = 3;
//             }
            
//             if(type == 1){
//             	var supervisor=false;
//                 $(this).find(".confirm-emp-class").each(function (index) {
//                     if($(this).val() != 1 && $(this).val() != 2 && $(this).val() != 3 && $(this).val() != 4  && $(this).val() != 5){
//                         $("#articleTarget").focus();
//                         showAlert("결재선을 확인해 주세요.");
//                         ok = false;
//                         return false;
//                     }
//                     if($(this).val() >= 3){
//                     	supervisor=true;
//                     }
//                 });
                
//                 if(!supervisor){
//                     $("#articleTarget").focus();
//                     showAlert("결재선은 최소 팀장급 1명이 포함되어야합니다.<br>결재선을 확인해 주세요.");
//                     ok = false;
//                     return false;
//                 }
//             }
//         });
//         if(!ok){return false;}
//      if($('#emp-table').find('tr').length == 0){
//          showAlert("결재선을 지정해 주시기 바랍니다.");
//          return false;
//      }
        
        // 심의필 번호 확인
//        var mkType = $("input[name=request-type]:checked").val();
          
//        if(mkType == "marketing"){
//            if($("#validation-num").val() == null || $("#validation-num").val().replace(/ /gi, "") == ""){
//                $("#validation-num").focus();
//                showAlert("심의필번호를 확인해 주세요.");
//                return false;
//            }
//        }
        
        //발송희망일 건수 확인
        if($('#remain-count').text() == $('#total-count').text()){
            showAlert("발송희망일의 시간을 선택해 주시기 바랍니다.");
            return false;
        }
        if(!validSendCount()){
            $("#dispatch-body").focus();
              showAlert("발송 희망일의 발송 건수를 확인해 주세요");
              return false;
        }
        
        return true;
  }

  //취소버튼 클릭 시 Action
  $("#cancel-btn").on('click', function () {
    showConfirm("취소", "취소 시 작성중인 기안은 재사용이 불가능 합니다.<br/> 그래도 취소하시겠습니까?", cancelDraft);
  });
  
  function cancelDraft(){
      var groupUniqNo = $("#smssendlist-groupUniqNo").val();
      $.ajax({
          type:'DELETE',
          //url:'${pageContext.request.contextPath}/smssendlist/delete/'+ groupUniqNo,
          url:'${pageContext.request.contextPath}/smssendlist/cancel/'+ groupUniqNo,
          success: function (result) {
              redirectList();
          }
      })
  }
  
  function redirectList() {
    setTimeout(function () {
      window.location.href = "${pageContext.request.contextPath}/smssendlist.ibk";
    }, 100);
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
        var tempSave = ''; //임시저장 여부 
        var t21_pengagYms = "99991231235959"; // T21에 들어갈 발송일시 (제일 빠른일시)
        
        var sendTimeCount = IbkDispatchHtml.getDispatchList();
        
        // 발송예정시간 및 건수를 request param 으로 만드는 작업
        var sendDateCount = [];
        for(var index=0; index < sendTimeCount.length; index++){
            var sendCount = sendTimeCount[index].count;
            var date = $(".dispatch-datepicker").val().replace(/-/g, '');
            var dateTime = date + sendTimeCount[index].time + "00";
            
            if (sendCount > 0) {
              if(t21_pengagYms > dateTime){
                  t21_pengagYms = dateTime;
              }
          	  
              sendDateCount.push({
                  pengagYms: dateTime,
                  totNumber: $("#expect-count").val().replace(/,/g, ''),
                  sectionNumber: sendCount
              });
            }
        }

        // 결제 직원 목록을 request param 으로 만드는 작업
       var confirmEmp = [];
       $(".article").each(function (){
            var type = 1;
            if($(this).prop("id") == "a1"){
                type = 1;   
            }else if($(this).prop("id") == "a2"){
                type = 2;
            }else if($(this).prop("id") == "a3"){
                type = 3;
            }
            
            $(this).find(".confirm-emp-id").each(function (index) {
              confirmEmp.push({
                  emplId : $(this).val()
                  ,agreeType : type
              });
            });
       });
       
        // SMS/LMS/MMS 메시지 제목, 내용 셋팅
        var msgTitle = null;
        var msg = null;
        if($("#msg-type").val() == "sms"){
            msgTitle = $("#content-textarea").val();
        }else{
            msgTitle = $("#msg-title").val();
            msg = $("#content-textarea").val();
        }
        
        // MMS 이미지 파일 갯수 체크
        var imageCount = null;
        if($("#msg-type").val() == "mms"){
            imageCount = 0;
            $(".imgPath").each(function(){
                if($(this).val() != null && $(this).val() != ''){
                    imageCount++;
                } 
            });
        }

    // 치환변수 셋팅
    var replaceVariableVal = "";
    $(".wrap_cbtn .col2 a").each(function(){
        var subVar = $(this).prop("id");
        var max = $("."+subVar).val();
        
        replaceVariableVal += ",\"" + subVar + "\":\"" + max + "\"";
    });
    
    if(replaceVariableVal != null){
        replaceVariableVal = "{" + replaceVariableVal.substring(1, replaceVariableVal.length) + "}";
    }

    // T28 공통부 변경 여부 확인
    var changeHeadDataYn = "N";
    if(changeHeadDataYn == "N" && $("#msg-type").val().toUpperCase() != "${smssendlist.msgDstic}S"){
        changeHeadDataYn = "Y";
    }
    if(changeHeadDataYn == "N" && $("#send-phonenum").val() != "${smssendlist.sndrTelno}"){
        changeHeadDataYn = "Y";
    }
    if(changeHeadDataYn == "N"){
        if($("#msg-type").val().toUpperCase() == "SMS"){
            if(msgTitle != $("#asis-content-textarea").val()){
                changeHeadDataYn = "Y";
            }
        }else{
            if(msgTitle != $("#asis-msg-title").val()){
                changeHeadDataYn = "Y";
            }
            
            if(msg != $("#asis-content-textarea").val()){
                changeHeadDataYn = "Y";
            }
        }
    }
    if(changeHeadDataYn == "N" && $("#msg-type").val().toUpperCase() == "MMS"){
        if($("#real-image-fileupload-input1").val() != "" || $("#real-image-fileupload-input2").val() != "" || $("#real-image-fileupload-input3").val() != ""){
            changeHeadDataYn = "Y";
        }
    }


        return {
          groupCoCd : "IBK", 
          groupNm: $("#request-title").val(),                       //기안제목
          groupUniqNo: $("#smssendlist-groupUniqNo").val(),         //그룹고유번호
          sendType: $("input[name=request-type]:checked").val(),    //발송업무
          msgDstic: $("#msg-type").val(),                           //메시지타입
          requestsNumber: $("#expect-count").val().replace(/,/g, ''),//예상발송건수
          msgCtnt: msgTitle,                                        // 메시지 내용 (LMS/MMS는 제목)
          umsMsgCtnt: msg,                                          //LMS 메시지 내용    
          budgetNm: $("#confirm-doc-name").val(),                   //예산합의서명
          sndrTelno: $("#send-phonenum").val(),                     //발신번호
          censorId: $("#validation-num").val(),                     //심의필번호
          prcssStusDstic: $("#smssendlist-prcssStusDstic").val(),   //기안상태값
          sendDateInfo : sendDateCount,                             //시간별 발송건수
          confirmEmp : confirmEmp,                                  //승인자 정보
          tempSave :tempSave,                                       //임시저장여부
          inst : $('#file-name-input').val(),                       //대상자파일명
          targetFilePath : $('real-file-name-input').val(),         //고유대상자파일명(T21_info)
          pengagYms : t21_pengagYms,                                //발송희망일 첫번째 값
          imageCount : imageCount,                                  //MMS 이미지 파일 갯수
          imagePath1 : $('#real-image-fileupload-input1').val(),    //MMS 이미지 경로1
          imagePath2 : $('#real-image-fileupload-input2').val(),    //MMS 이미지 경로2
          imagePath3 : $('#real-image-fileupload-input3').val()     //MMS 이미지 경로3
          
          ,image1 : $("#blob-image-fileupload-input1").val()            // MMS 이미지 경로 1
          ,image2 : $("#blob-image-fileupload-input2").val()            // MMS 이미지 경로 2
          ,image3 : $("#blob-image-fileupload-input3").val()            // MMS 이미지 경로 3
          
          ,replaceVariableVal : replaceVariableVal                              // T21_INFO 치환변수/MaxByte 값(JSON)
          ,changeHeadDataYn : changeHeadDataYn                          // T28 헤더 변경 여부 (Y:변경, N:동일)
          
        };
      }

  $(document).on('keyup', '#msg-title', function () {
    // 제목은 60byte 로 고정
    var maxByte = 60;
    var strByteInfo = IbkByteCheck.getBytesAndMaxLength($(this).val(), maxByte);
    if (strByteInfo.totalByte > maxByte) {
      showAlert('제목은 60byte 까지 입력 가능 합니다.');
      $(this).val($(this).val().substring(0, strByteInfo.ableLength))
    }
  });

  $(document).on('keyup', '#content-textarea', function () {
    getMsgTextBytes($(this));
  });

  /**
   * 희망일 추가 버튼을 클릭 하면 희망일 입력 block 과 마지막 입력 일자를 갱신 합니다.
   * 추가 희망일의 초기 날짜는 마지막 입력 일자 + 1day dlqslek.
   */
  $(document).on('click', '#dispatch-add-btn', function () {
		var standardMinDate = $(".hasDatepicker").eq(0).prop('id').replace('datepicker-','');
		  
	    var targetDate = moment(lastAddedDay, 'YYYYMMDD').add(1, 'days').format("YYYYMMDD");
	    
	    if(targetDate - standardMinDate > maxDate){
	        showAlert("발송희망일은 최대 " + maxDate + "일을 초과하실 수 없습니다.<br>발송희망일을 다시 선택해 주시기 바랍니다. ")
	        return false;
	    }
	    
	    IbkDispatchHtml.appendTo("dispatch-body", targetDate, 'N');
	    IbkDatepicker.initDatepicker("datepicker-" + targetDate, "${pageContext.request.contextPath}",
	        0);
	    $("#datepicker-" + targetDate).val(moment(targetDate, 'YYYYMMDD').format('YYYY-MM-DD'));
	    selectDateTotalCount(targetDate); // 발송 희망일 셋팅 @jys
	//     removePassedTime();
	//     removePassedTime2(); //희망일 추가 시 날짜 상관없이 현재시간으로 선택지 remove 되는 오류 수정 @jys
	    lastAddedDay = targetDate;
  });
  
  //희망발송 시간에 건수 선택시
//   sel-20181119-1030
  $(document).on('click', '.es-visible', function () {
    var $input = $(this).parent().siblings().first();
    var value = $.number($(this).val());
    setRemainAndAddedAndAbleCount($input, value); 
  });
  
   

//발송 희망일 변경 시 이벤트 @jys
  var maxDate = 7;
  $(document).on('change', '.hasDatepicker', function () {
      var beforeDate = $(this).prop('id').replace('datepicker-','') // 이전 날짜
      var changeDate = $(this).val().replace(/-/gi,''); // 선택한 날짜 (- 제거)
      var eqDate = false; // 동일 날짜 여부 (true: 있음, false: 없음)
      
      
      $(".hasDatepicker").each(function( idx ){
          if($(this).prop('id') !=  ('datepicker-'+beforeDate) && $(this).val().replace(/-/gi,'') == changeDate){ // 동일한 날짜 선택 여부 확인 (자기자신 제외)
              eqDate = true;
          }
          
          if(idx == 0 || lastAddedDay < $(this).val().replace(/-/gi,'')){ // 변경 날짜가 lastAddedDay 보다 클 경우 셋팅
              lastAddedDay = $(this).val().replace(/-/gi,'');
          }
      });
      
      if(eqDate){
          showAlert("이미 선택하신 발송희망일 입니다.")
          beforeDate = beforeDate.substr(0,4) + "-" + beforeDate.substr(4,2) + "-" + beforeDate.substr(6,2);
          $(this).val(beforeDate);
          return false;
      }
      
      // ######발송 희망일 7일 초과 선택 불가 로직 START
      /*   1. 이벤트 위치 확인
  			1-1. 위치가 0이 아닌경우
    	  		2. 이벤트 위치 앞 뒤 날짜 확인
    	  		3. 앞 뒤 날짜 사이 값인지 확인
     				3-1. 사이 값이 아닌 경우 사이값으로 선택 하라는 문구 출력
      				3-2. 사이 값일 경우 패스
      					3-2-1. 선택 값이 0번쨰 값보다 7이상 큰지 확인.
      */
      var dpSize = $(".hasDatepicker").length;
      
      //1. 이벤트 위치 확인
      var selectIdx = $(".hasDatepicker").index($(this));
      //1-1. 위치가 0이 아닌경우
      if(dpSize != 1){
    	  var standardMinDate = $(".hasDatepicker").eq(0).prop('id').replace('datepicker-','');
    	  var standardMaxDate = $(".hasDatepicker").eq(dpSize-1).prop('id').replace('datepicker-','');
          //2-1. 이벤트 위치 앞 날짜 확인
          if(selectIdx != 0){
        	  var standardPreDate = $(".hasDatepicker").eq(selectIdx-1).prop('id').replace('datepicker-','');
        	  
        	  if(standardPreDate > changeDate){
        		  standardPreDate = standardPreDate.substr(0,4) + "-" + standardPreDate.substr(4,2) + "-" + standardPreDate.substr(6,2);
        		  showAlert(standardPreDate + "이후 날짜를 선택해 주시기 바랍니다.");
                  beforeDate = beforeDate.substr(0,4) + "-" + beforeDate.substr(4,2) + "-" + beforeDate.substr(6,2);
                  $(this).val(beforeDate);
        		  return false;
        	  }
          }
         //2-2. 이벤트 위치 뒤 날짜 확인
          if(selectIdx+1 != dpSize){
        	  var standardNextDate = $(".hasDatepicker").eq(selectIdx+1).prop('id').replace('datepicker-','');
        	  
        	  if(standardNextDate < changeDate){
        		  standardNextDate = standardNextDate.substr(0,4) + "-" + standardNextDate.substr(4,2) + "-" + standardNextDate.substr(6,2);
        		  showAlert(standardNextDate + "이전 날짜를 선택해 주시기 바랍니다.");
                  beforeDate = beforeDate.substr(0,4) + "-" + beforeDate.substr(4,2) + "-" + beforeDate.substr(6,2);
                  $(this).val(beforeDate);
        		  return false;
        	  }
          }

    	  if((changeDate - standardMinDate) > maxDate || (standardMaxDate - changeDate) > maxDate){ // 발송 일자는 최대 7일 까지 가능
              showAlert("발송희망일은 최대 " + maxDate + "일을 초과하실 수 없습니다.<br>발송희망일을 다시 선택해 주시기 바랍니다. ")
              beforeDate = beforeDate.substr(0,4) + "-" + beforeDate.substr(4,2) + "-" + beforeDate.substr(6,2);
              $(this).val(beforeDate);
              return false;
    	  }
      }
	  
      // ######발송 희망일 7일 초과 선택 불가 로직 END
      
      if(lastAddedDay < changeDate){ // 변경 날짜가 lastAddedDay 보다 클 경우 셋팅
          lastAddedDay = changeDate;
      }
      
      // 이전 달력 이벤트 제거
      $("#datepicker-" + beforeDate).datepicker("destroy");
      // 선택한 날짜로 모든 view 갱신
      var topObject = $(this).parent().parent();
      setAttrOptionChange(topObject, beforeDate, changeDate); // 발송 희망일 셋팅
      // 달력 이벤트 적용 
      IbkDatepicker.initDatepicker("datepicker-" + changeDate,"${pageContext.request.contextPath}", 0);
      selectDateTotalCount(changeDate); // 발송 희망일 셋팅
//       removePassedTime2(); // 현재시간 기준 입력 가능 이벤트 설정
  });
  
  // 방송 희망일 변경 시 해당 view id, class 날짜 변경 @jys
  function setAttrOptionChange(obj, beforeDate, changeDate){
      obj.prop("id", obj.prop("id").replace(beforeDate, changeDate));
      obj.prop("class", obj.prop("class").replace(beforeDate, changeDate));
      
      obj.children().each(function(){
          $(this).prop("id", $(this).prop("id").replace(beforeDate, changeDate));
          $(this).prop("class", $(this).prop("class").replace(beforeDate, changeDate));
          
          if($(this).children().length > 0){
              setAttrOptionChange($(this), beforeDate, changeDate);
          }
      });
  }

  $(document).on('click', '.delete', function () {
    var dayId = $(this).attr('id').replace('delete-', '');
    $("#div-" + dayId).remove();
    setLastDay() //삭제 시 마지막 발송 일자로 셋팅 @jys
    remainCount();
  });

  $(document).on('click', '.repl-var', function () {
    var text = '\${' + $(this).prop("id") + '}';
    IbkInsertText.setText('content-textarea', text);
    
    getMsgTextBytes($("#content-textarea"));
  });

  $(".special-char").on('click', function () {
    IbkInsertText.setText('content-textarea', $(this).text());
  });

  $(document).on('change', '#msg-type', function () {
    if ($(this).val() === 'sms') {
      $("#dis-max-byte").text("90");
    } else {
      $("#dis-max-byte").text("2000");
    }
    
    getMsgTextBytes($("#content-textarea"));
  });
  
  // 희망발송 시간에 건수 선턱시
  // 라이브러리에서 제공해주는 event 사용
  $(document).on('select.editable-select', '.editable-select', function (e) {
    setRemainAndAddedAndAbleCount($(this), $(this).val());
    ;
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
    showConfirmDoc();
  });

  $(document).on('change', ".added-count", function () {
    var totalCount = parseInt($("#total-count").text());
    var addedCount = 0;
    $(".added-count").each(function (index) {
      addedCount += $(this).val();
    });
    $("#remain-count").text($.number(totalCount - addedCount));
  });

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

  
//발송 희망일 선택 건수 계산 @jys(등록된 건수 초기 설정)
  // 당일 건수 세팅 하는 함수 입니다. @jisoonchoi
  function getDispatchTotalCount(day) {
    // day에 등록된 총 건수 구하기
    var initTotalCnt = $("#today-total-count-" + day).text().replace(/,/,"");
    // 공백을 parseInt 하게 되면 NaN 이 발생 됩니다. @jisoonchoi
    if (!initTotalCnt) {
      initTotalCnt = 0;
    }
    var test = 0;
    $("#dispatch-body-" + day + " .editable-select").each(function (index) {
      test += parseInt($(this).val().replace(/,/g, ''));
    });
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
  
//마지막 발송 일자로 셋팅( 발송 희망일에서 가장 미래의 시간 택 ) @jys
  function setLastDay(){
      lastAddedDay = 0;
      $(".hasDatepicker").each(function(){
          thisDate = $(this).val().replace(/-/gi,'');
          if(lastAddedDay < thisDate){
              lastAddedDay = thisDate;
          }
      });
  }
  
  // 발송 희망일 시간 구간 셋팅 @jys
  var timeList = ["1000", "1030", "1100", "1400", "1430", "1500", "1530", "1600", "1630", "1700"];
//   var total = 0;
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
//                var num = parseInt(data["TOTAL_TIME_"+ timeList[i]]);
                  $("#"+date+"-"+timeList[i]).text($.number(data["TOTAL_TIME_"+timeList[i]]));
                  totalCnt = totalCnt + data["TOTAL_TIME_"+timeList[i]];
              }
              
              $("#today-total-count-" + date).text($.number(totalCnt));
              $("#added-count-" + date).text($.number(totalCnt));
//            total=0;
          }).fail(function(xhr) {
            showAlert("요청 중 오류가 발생 하였습니다.\n\n(selectDateTotalCount())");
          });
  }
  
  function initDateTotalCount(){
	   IbkDispatchHtml.appendTo("dispatch-body", todayYYYYMMDD, "Y");
	   IbkDatepicker.initDatepicker("datepicker-" + todayYYYYMMDD,
	       "${pageContext.request.contextPath}", 0);
	   $("#datepicker-" + todayYYYYMMDD).val(moment(todayYYYYMMDD, 'YYYYMMDD').format('YYYY-MM-DD'));
	   removePassedTime();
  }
  
  
  //발송 희망일 저장된 시간 값 세팅
  function selectDateSaveCount(date){
      $.ajax({
            url: '${pageContext.request.contextPath}/smsreq/savecnt2/',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                "groupUniqNo": groupUniqNo}),
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
                        
                        // 1. 발송희망일 셋팅(일자별)
                        IbkDispatchHtml.appendTo("dispatch-body", key, btnDel);
                        
                        IbkDatepicker.initDatepicker("datepicker-" + key,
                        "${pageContext.request.contextPath}", ((key-todayYYYYMMDD) < 0 ? (key-todayYYYYMMDD) : 0));
                    $("#datepicker-" + key).val(moment(key, 'YYYYMMDD').format('YYYY-MM-DD'));

                    IbkSmsReqDispatchInfo.addDispatchDate(key);
                    IbkSmsReqDispatchInfo.setCount(key, 4, 1000);
                        
                    // 2. 해당일자 시간별 등록된 전체 건수 셋팅
//                         selectDateTotalCount(key);

                    // 3. 해당일자 시간별 기안자 등록한 건수 셋팅
                    	timeList = value["timeList"];
                        for(var i=0; i< timeList.length; i++){
                        	var saveData = timeList[i] + " " + parseInt(value["TOTAL_TIME_"+ timeList[i]]) + "\n";
                        	$("#totalCnt_TextArea").text($("#totalCnt_TextArea").text() + saveData);
                        }
                    
                    // 4. 마지막 일자 셋팅 (희망일 추가 시 마지막일자 다음 날로 셋팅되기 위함)
                        if(lastAddedDay < key){
                            lastAddedDay = key;
                        }
                        index++;
                    })
                    
                    if(index == 0){ // 발송희망일 최소 미등록 시 현재 일자 기본 등록
                   		initDateTotalCount();
                    }
                    
                    //등록가능/전체/등록 건수 셋팅
                    $(".editable-select").each(function(){
                        if($(this).val() != '0'){
                            var $forIdSeperate = $(this);
                            var value = $(this).val();
                            
//                          // --------------------- 총건수 에서 기안에 해당하는 건수 제외 --------------------------------//
//                          // - 기안 수정 시 발송 총 건수에 기안의 등록된 건수가 포함되어 정상적으로 총 건수가 계산되지 않는 이슈 해결
//                          var totalId = $(this).prop("id").replace("sel-", "");   //해당 발송 일시 등록된 건수
//                          var date = totalId.substr(0,8); // 발송일자
//                          var dayTotalObj = $("#"+totalId);   // 발송 일시에 해당하는 총 건수
                            
//                          console.log(totalId + ": 일시 총건수 = " + parseInt(dayTotalObj.text().replace(/,/gi, '')) + " / 일시 기안 건수 = " + parseInt(value.replace(/,/gi, '')));
//                          // 등록된 건수에서 해당 기안에 대한 건수 제외 ( (해당일시 총 건수) - (해당일시 기안등록 건수) )
//                          dayTotalObj.text($.number(parseInt(dayTotalObj.text().replace(/,/gi, '')) - parseInt(value.replace(/,/gi, '')))) ;
                            
//                          var monthTotalCnt = $("#today-total-count-" + date).text().replace(/,/gi, '');  // 해당일자 등록된 발송 총건수 (일시의 모든 합) 
//                          // 등록된 건수 총합에서 해당 기안에 대한 건수 제외 ( (해당일자 총 건수) - (해당일시 기안등록 건수) )
//                          $("#today-total-count-" + date).text($.number(parseInt(monthTotalCnt) - parseInt(value.replace(/,/gi, ''))));
//                          // --------------------- 총건수 에서 기안에 해당하는 건수 제외 --------------------------------//
                            setRemainAndAddedAndAbleCount($forIdSeperate, value);   
                        }
                    });
                    
                    remainCount();  //합계/남은 건수 셋팅
                    IbkDispatchHtml.validateDispatch(false);
                    
//                  $('.tar').css('display', 'none');
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
                  var confirmHtml = ''
                      + '<tr id="tr-' + empData[i].emplId + '">'
                      + '  <th scope="row" id="default-emp-count">0</th>'
                      + '  <td width="90px">' + empData[i].positionCallname + '</td>'   // 부서명 사이즈 변경 @jys
                      + '  <td>' + empData[i].emplName
                      + '     <span class="btn01">'
                      + '       <input type="hidden" class="confirm-emp-id" value="' + empData[i].emplId + '">'
                      + '       <input type="hidden" class="confirm-emp-class" value="' + empData[i].emplClass + '">' // Class 값 추가 @jys
                      + '       <a href="javascript:" class="btn_default emp-del-btn" id="' + empData[i].emplId
                      + '">삭제</a>'
                      + '</span>'
                      + '  </td>'
                      + '</tr>';
                 $("#emp-table").prepend(confirmHtml);

                 $("#emp-table #default-emp-count").each(function(){                 
                   $(this).text(parseInt($(this).text()) + 1);    
                 });
              }
              
          },error : function (evt) {
              console.log(evt);
          }
      })
  }
  
//// 등록된 파일 제거
  function remove_uploadFile( fileType ){
        if(fileType == "Subject"){  // 대상자 파일 제거
            $("#file-name-input").val("");
            $("#real-file-name-input").val("del");
            
            $("#delete-fileupload-btn").hide();
        }else if(fileType == "Img1"){   // 이미지 파일1 제거
            $("#image-fileupload-input1").val("");
            $("#real-image-fileupload-input1").val("del");
            $("#blob-image-fileupload-input1").val("");
            
            $("#delete-image-file-btn1").hide();
        }else if(fileType == "Img2"){   // 이미지 파일2 제거
            $("#image-fileupload-input2").val("");
            $("#real-image-fileupload-input2").val("del");
            $("#blob-image-fileupload-input2").val("");
            
            $("#delete-image-file-btn2").hide();
        }else if(fileType == "Img3"){   // 이미지 파일3 제거
            $("#image-fileupload-input3").val("");
            $("#real-image-fileupload-input3").val("del");
            $("#blob-image-fileupload-input3").val("");
            
            $("#delete-image-file-btn3").hide();
        }
  }
  
  
//// 문자내용 byte 계산
  function getMsgTextBytes(obj){
      var maxByte = 0;
      var msgType = $("#msg-type").val();
      if (msgType === 'sms') {
        maxByte = 90;
      } else {
        maxByte = 2000;
      }
      
      //치환변수 max 값 계산을 위한 처리
      var msg = obj.val();
      msg = msg.replace(/[$]\{.+?\}/g, "");
      
      var strByteInfo = IbkByteCheck.getBytesAndMaxLength(msg, maxByte);
      var subVarByte = getSubVarBytes();
      if ((parseInt(strByteInfo.totalByte) + parseInt(subVarByte)) > maxByte) {
        showAlert(msgType + "는 " + maxByte + 'byte 까지 입력 가능 합니다.');
        obj.val(msg.substring(0, strByteInfo.ableLength));
        msg = obj.val();
      }
      $("#dis-total-byte").text(parseInt(IbkByteCheck.getBytes(msg)) + subVarByte);
  }

////치환변수 Byte 계산
  function getSubVarBytes(){
      var subVarBytes = 0;
      $(".wrap_cbtn .col2 a").each(function(){
          var text = $("#content-textarea").text();
          
          //치환변수명
          var subVar = $(this).prop("id");

          //사용된 치환변수 갯수 확인
          var checkText = new RegExp("[$]\{+"+subVar+"\}","g");
          var cntMatch = text.match(checkText);
          
          if(cntMatch != null){
              var max = $("."+subVar).val();        //치환변수 최대 값
              var cnt = cntMatch.length;            // 치환변수 사용 갯수

              //치환변수 Byte 더하기
              subVarBytes += (parseInt(max) * cnt);
          }
      });
      
      return subVarBytes;
  }
  
////전화번호 형식 입력 @jys
  function inputPhoneType(obj){
      var inputVal = obj.val();
      obj.val(inputVal.replace(/[^0-9-]/gi,''));
  };
  
  
  
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

      if(price == null || price == ""){
      	showAlert("설정된 단가 정보가 없습니다.<br>단가 정보를 확인해 주시기 바랍니다.");
      }
      
      var sendPrice = (parseFloat(price) * parseFloat(requestsNumber));
      
      if(sendPrice >= 2000000){
//             $('#tr_confirm-doc-name').show();
      }else{
//             $('#tr_confirm-doc-name').hide();
      }
}

</script>