<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<h3>
    <c:choose>
        <c:when test="${smssendlist.prcssStusDstic  eq 'A'}">상세보기 > 결재진행중</c:when>
        <c:when test="${smssendlist.prcssStusDstic  eq 'B'}">상세보기 > 발송승인대기</c:when>
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
                <th scope="row">기안명</th>
                <td colspan="3" id="request-title" >${smssendlist.groupNm}</td>
            </tr>
            <tr>
                <th scope="row">발송구분</th>
                <c:if test="${smssendlist.sendType eq 'marketing'}">
                    <td colspan="3" id="request-sendStat">마케팅(고객관리 포함)</td>
                </c:if>
                <c:if test="${smssendlist.sendType eq 'noMarketing'}">
                    <td colspan="3" id="request-sendStat">비마케팅(기존계약의 유지 · 관리 등)</td>
                </c:if>
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
                <th scope="row">예상발송건수</th>
                <td colspan="3" id="expect-count">
                    <input type="hidden" id="asis-expect-count">
                </td>
            </tr>
            <tr>
                <th scope="row">대상자 파일<span class="th_must">*</span></th>
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
                <th scope="row">메세지 내용</th>
                <td colspan="3" ><!-- wrap_box_sms -->
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
                                    <li class="disib"><b>발신번호 :</b>
                                        <input type="text" id="send-phonenum"  value="${smssendlist.sndrTelno}" class="mgl5"  maxlength="16"
                                               style="width:100px; border:none; padding-bottom:6px; margin-left:-5px !important;" readonly="readonly" onfocus="this.blur()">
                                    </li>
                                    <div style="display: none;">
                                        <c:choose>
                                            <c:when test="${smssendlist.sendType eq 'noMarketing'}">
                                                <li class="disib mgl20" id="validation-num-li" style="display:none !important;"><b>심의필번호</b><span class="th_must">*</span>
                                                    <input type="text" id="validation-num" class="mgl5" value=""
                                                           style="width:100px; ">
                                                </li>
                                            </c:when>
                                            <c:when test="${smssendlist.sendType eq 'marketing'}">
                                                <c:if test="${smssendlist.censorId eq null}">
                                                    <li class="disib mgl20" id="validation-num-li" style="display:none !important;"><b>심의필번호</b><span class="th_must">*</span>
                                                        <input type="text" id="validation-num" class="mgl5"
                                                               style="width:100px">
                                                    </li>
                                                </c:if>
                                                <c:if test="${smssendlist.censorId ne null}">
                                                    <li class="disib mgl20" id="validation-num-li" style="display:none !important;"><b>심의필번호</b><span class="th_must">*</span>
                                                        <input type="text" id="validation-num" value="${smssendlist.censorId}" class="mgl5" style="width:100px">
                                                    </li>
                                                </c:if>
                                            </c:when>
                                        </c:choose>
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
                <th scope="row">예산합의서명<span class="th_must">*</span></th>
                <td><input type="text" id="confirm-doc-name" maxlength="50" value="${smssendlist.budgetNm}"
                           placeholder="전략기획부하 승인 된 예산 품의서 명을 입력해주세요." style="width:650px">
                </td>
            </tr>
            <tr>
                <th scope="row">발송 희망일</th>
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
            <tr style="display:none;">
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
                                <p class="q">2차 <a href="#a2"  id="articleTarget" >개인디지털채널부</a></p>
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
                                <p class="q">3차 <a href="#a3" id="articleTarget" >IBK고객센터</a></p>
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
                <th scope="row">발송 요청직원<span class="th_must">*</span><br>
                    등록
                </th>
                <td colspan="3">
                    <div class="faq">
                        <ul class="faqBody">
                            <li class="hide" id="a42"  >
                                <p class="q"><a href="#a42" id="articleTarget2" >발송 요청직원</a><a href="javascript:" id="req-employee-search-btn" class="btn_default gray mgl10"  style="width:38px">검색</a></p>
                                <div class="a" style="">
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
                                            <tbody id="req-send-emp-table">
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
                <th scope="row">발송 승인직원<span class="th_must">*</span><br>
                    등록
                </th>
                <td colspan="3">
                    <div class="faq">
                        <ul class="faqBody">
                            <li class="article hide" id="a4"  >
                                <p class="q"><a href="#a4" id="articleTarget" >발송 승인</a><a href="javascript:" id="employee-search-btn" class="btn_default gray mgl10"  style="width:38px">검색</a>
                                    <span class="ment_sms01" style='font-weight:normal;'> &nbsp; * 최소 1명 ~ 최대 8명까지 가능(본인 포함) </span>
                                </p>
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
            <c:if test="${smssendlist.modifyReason ne null}">
                <tr>
                    <th scope="row">수정사유</th>
                    <td colspan='3'>
                        <div class="row1">
                                ${smssendlist.modifyReason}
                        </div>
                </tr>
            </c:if>
            <c:if test="${smssendlist.stopReason ne null}">
                <tr>
                    <th scope="row">중지사유</th>
                    <td colspan='3'>
                        <div class="row1">
                                ${smssendlist.stopReason}
                        </div>
                </tr>
            </c:if>
        </table>
    </div>
    <!-- //table_view -->
    <!-- 버튼 -->
    <div class="btn_wrap01_detail">
        <c:if test="${smssendlist.prcssStusDstic eq 'B'}">
            <a href="javascript:" class="btn_big blue" id="send-request-btn" >발송승인 요청</a>
        </c:if>
        <a href="javascript:" class="btn_big gray" id="confirm-btn">확인</a>
        <a href="javascript:" class="btn_big" id="save-btn" >저장</a>
        <a href="javascript:" class="btn_big delete" id="cancel-btn">취소</a>
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
        $("#cancel-btn").hide();
        $("#save-btn").hide();
    }
    var todayYYYYMMDD = moment().format("YYYYMMDD");
    var lastAddedDay = moment().format("YYYYMMDD");
    var lmscontents = $("#content-textarea").val();
    var groupUniqNo = '${smssendlist.groupUniqNo}';
    var requestsNumber = ${smssendlist.requestsNumber};
    var commaReqNum = $.number(requestsNumber);
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
        $("#expect-count").text(commaReqNum); //발송건수 세팅
        $("#asis-expect-count").text(commaReqNum); //발송건수 세팅
        if('${smssendlist.msgDstic}' == 'SM'){
            $("#content-textarea").val(lmscontents); //메시지내용 세팅
            //$('#dis-total-byte').text(IbkByteCheck.getBytes(lmscontents)); //byte 세팅
            getMsgTextBytes($("#content-textarea"));
        }else {
            $("#msg-title").val($('#msg-title').val()); //메시지내용 세팅
            $("#content-textarea").val(lmscontents); //메시지내용 세팅
            $('#dis-total-byte').text(IbkByteCheck.getBytes(lmscontents)); //byte 세팅
        }
        $("#total-count").text(commaReqNum); // 발송희망일 합계 세팅
        //정상건수, 에러건수 세팅도 해줘야함.(db결정되면 등록해야함~!!!!)
        $("#validation-num").val("${smssendlist.censorId}"); //심의필 번호 세팅
        $("#send-phonenum").val("${smssendlist.sndrTelno}"); //발신번호 세팅
        $("#file-name-input").val("${smssendlist.inst}"); //대상자파일 세팅
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

                //### 대상자 파일 재업로드시 기존 예상발송 건수 초과 불가능 @jys
                var okCnt = result.totCnt;  //성공건수
                var preSendCnt = $("#asis-expect-count").text().replace(/[^0-9]/g,""); //예상발송건수

                if(parseInt(okCnt) > parseInt(preSendCnt)){
                    showAlert('대상자 건수가 예상발송건수를 초과하였습니다.<br>예상발송건수 보다 적은 건수의 대상자를 등록해 주시기 바랍니다.');
                    return false;
                }

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
//       $("#validation-num-li").attr("style", "display: none !important");
        } else {
            $("#validation-num").val('');
//       $("#validation-num-li").show();
        }
    });
    var openType = 1;
    // 발송요청 직원 검색
    $("#req-employee-search-btn").on('click', function (e) {
    	if($('#req-send-emp-table').find('tr').length == 1){
            showAlert("발송요청직원을 이미 선택하셨습니다.");
            return false;
        }
    	
        e.preventDefault();
        $("#employee_search-word-type").val('BoCode');
        openType = 1;
        var isScrollPopup = true;
        userSearchInit(user_bocode, isScrollPopup);
    });

    //직원 검색시 초기값을 부서명 : 기안부서로 세팅
    $("#employee-search-btn").on('click', function (e) {
        if($('#send-emp-table').find('tr').length == 8){
            showAlert("발송승인 직원은 최대 8명까지 가능합니다.");
            return false;
        }
        openType = 2;
        e.preventDefault();
        $("#employee_search-word-type").val('BoCode');
        var isScrollPopup = true;
        userSearchInit(user_bocode, isScrollPopup); // 부서코드 세션에서 받아와서 전달 @jys
    });


    //발송 승인직원
    /* $("#confirm_in_search-btn").on('click', function () {
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
            + '  <td width="70px">' + empData.positionCallname + '</td>'    // 부서명 사이즈 변경 @jys
            + '  <td width= "90px">' + empData.emplName + '</td>'
            + '  <td width= "200px">' + emplHpNo
            + '     <span class="btn01">'
            + '       <input type="hidden" class="confirm-emp-id" value="' + empData.emplId + '">'
            + '       <input type="hidden" class="sendConfirm-emp-emplHpNo" value="' + empData.emplHpNo + '">' // Class 값 추가 @jys
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
    }); */

    $(document).on('click', '.emp-del-btn', function () {
        $("#send-emp-table #tr-" + $(this).attr('id')).remove();
        // 승인자 삭제시 넘버링 오류 수정 @jys
        $("#send-emp-table #default-emp-count").each(function(idx){
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

    //발송 승인요청 버튼 클릭 시 Action
    $('#send-request-btn').on('click', function(){
        IbkDispatchHtml.validateDispatch(false);
//         if('${smssendlist.sendType}' == 'marketing' ){
//               if($('#validation-num').val() == null || $('#validation-num').val() == ''){
//                   $('#validation-num').focus();
//                   showAlert('심의필 번호를 입력해 주시기 바랍니다.');
//                   return false;
//               }
// 			  if(!isValidDate($('#validation-num').val())){
// 				  showAlert('심의필 번호를 포맷을 확인해주세요.');
//                   return false;
// 			  }
//         }

        //메시지 제목 및 내용 확인
        if($('#msg-type').val() == 'sms'){
            if($('#content-textarea').val()  == '' || $('#content-textarea').val()  == null || $('#content-textarea').val().replace(/ /gi, '') == ''){
                $('#content-textarea').focus();
                showAlert("메세지 내용을 입력해 주시기 바랍니다.");
                return false;
            }
        }else{
            if($('#msg-title').val() == null /* || $('#msg-title').val().replace(/ /gi, '') == '' */){
                $('#msg-title').focus();
                showAlert("메시지 제목을 입력해 주시기 바랍니다.");
                return false;
            }
            if($('#content-textarea').val() == null /* || $('#content-textarea').val().replace(/ /gi, '') == '' */){
                $('#content-textarea').focus();
                showAlert("메세지 내용을 입력해 주시기 바랍니다.");
                return false;
            }
        }

        if($('#tr_confirm-doc-name').is(":visible")){
            if($('#confirm-doc-name').val() == null || $('#confirm-doc-name').val() == ''){
                $('#confirm-doc-name').focus();
                showAlert('예산합의서명을 입력해 주시기 바랍니다.');
                return false;
            }
        }

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


        if($('#file-name-input').val() == null || $('#file-name-input').val() == ''){
            $('#file-name-input').focus();
            showAlert('대상자파일을 등록해 주시기 바랍니다.');
            return false;
        }

        agreeSelect();

        if($('#send-emp-table').find('tr').length < 1 || $('#send-emp-table').find('tr').length > 8){
            showAlert("발송승인 직원은 최소 1명~최대 8명까지 가능합니다.");
            return false;
        }

        showConfirmForAjax("발송승인요청", "발송승인요청을 진행 하시겠습니까?", function(){
            //@@@ jys 2019.01.22 저장 로직 추가
            var smsReqData = saveReqData();
            console.log("smsReqData ::: " + JSON.stringify(smsReqData));
            $.ajax({
                url: '${pageContext.request.contextPath}/smssendlist/save',
                type: "POST",
                async:false,
                contentType: "application/json; charset=utf-8",
                dataType:"json",
                data: JSON.stringify(smsReqData),
            }).done(function(data) {
            }).fail(function(xhr) {
                var errorMsg = xhr.responseJSON.message == null ? "" : xhr.responseJSON.message;
                var errorCd = xhr.responseJSON.code == null ? "" : xhr.responseJSON.code;
                showAlert("저장 요청 중 에러 발생<br><br>에러 메시지<br>["+errorMsg+"]<br>에러코드<br>["+errorCd+"]<br>관리자에게 문의 바랍니다.<br><br>error<br>");
            });

            //발송승인 등록자에게 발송(T41에 insert)
            $.ajax({
                url: '${pageContext.request.contextPath}/smssendlist/testSend',
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType:"json",
                data: JSON.stringify(smsReqData),
            }).done(function(data) {
                showAlert("발송승인 요청 하였습니다.", redirectList);
            }).fail(function(xhr) {
                console.log(xhr);
                console.log(xhr.responseJSON);
                if(xhr.responseJSON != null){
                    var errorMsg = xhr.responseJSON.message == null ? "" : xhr.responseJSON.message;
                    var errorCd = xhr.responseJSON.code == null ? "" : xhr.responseJSON.code;
                }else{
                    var errorCd = xhr.status == null ? "" : xhr.status;
                    var errorMsg = xhr.statusText == null ? "" : xhr.statusText;
                }
                showAlert("발송승인 요청 중 에러 발생<br><br>에러 메시지<br>["+errorMsg+"]<br>에러코드<br>["+errorCd+"]<br>관리자에게 문의 바랍니다.<br><br>error<br>");
            });
        });
    })

    function agreeSelect(){
        $.ajax({
            url:'${pageContext.request.contextPath}/smssendlist/agreeSelect/' + groupUniqNo,
            type:"GET",
            success:function(result){
                if(result == '실패'){
                    showAlert("결재선 지정자 모두 승인완료가 되어야 발송승인요청이 가능합니다.");
                }
            },error : function (evt) {
                console.log(evt);
            }
        })
    }

    //확인 버튼 클릭 시 Action
    $("#confirm-btn").on('click', function(){
        redirectList();
    })

    // 저장 버튼 클릭시 Action
    $("#save-btn").on('click', function () {
        IbkDispatchHtml.validateDispatch(false);
        var smsReqData = saveReqData();
        console.log("smsReqData ::: " + JSON.stringify(smsReqData));

        $.ajax({
            url: '${pageContext.request.contextPath}/smssendlist/save',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType:"json",
            data: JSON.stringify(smsReqData),
        }).done(function(data) {
            showAlert("저장 하였습니다.", redirectList);
        }).fail(function(xhr) {
            showAlert("저장 요청 중 에러 발생<br><br>에러 메시지<br>["+xhr.responseJSON.message+"]<br>에러코드<br>["+xhr.status+"]<br>관리자에게 문의 바랍니다.<br><br>error<br>"+xhr.responseText);
        });
    });

    //취소버튼 클릭 시 Action
    $("#cancel-btn").on('click', function () {
        showConfirm("취소", "취소 시 작성중인 기안은 재사용이 불가능 합니다.<br/> 그래도 취소하시겠습니까?", cancelDraft);
    });

    function cancelDraft(){
        var groupUniqNo = $("#smssendlist-groupUniqNo").val();
        $.ajax({
            /* type:'DELETE',
            url:'${pageContext.request.contextPath}/smssendlist/delete/'+ groupUniqNo, */
            type:'DELETE',
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

            $(this).find(".confirm-emp-id").each(function (index) {
                sendConfirmEmp.push({
                    emplId : $(this).val()
                    ,emplHpNo : $(this).next().val()
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
        var imageCount = 0;
        if('${smssendlist.msgDstic}' == "MM"){
            if('${smssendlist.seq1}' != ""){
            	imageCount += 1;
            }
            if('${smssendlist.seq2}' != ""){
            	imageCount += 1;
            }
            if('${smssendlist.seq3}' != ""){
            	imageCount += 1;
            }
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

        var sendTypeName = $('#request-sendStat').val() === 'marketing' ? '마케팅' : '비마케팅';

        var sendTime = '';
        var tempDate = '';
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

        $.each(sendDateCount, function (index, value) {
            var momentTime = moment(value.pengagYms, 'YYYYMMDDHHmm');
            if (tempDate === momentTime.format('YYYY-MM-DD')) {
                sendTime += ', ' + momentTime.format('HH:mm');
                sendTime += ' (' + value.sectionNumber +")";
            } else {
                if (tempDate !== '') {
                    sendTime += '\n';
                }
                sendTime += momentTime.format('YYYY-MM-DD');
                sendTime += ' ' + momentTime.format('HH:mm');
                sendTime += ' (' + value.sectionNumber +")";
                tempDate = momentTime.format('YYYY-MM-DD');
            }
        });

        var confirmBodyMessage =
           /*  ' 발송업무 : ' + sendTypeName + '\n'
            + ' 메시지타입 : ' + '${smssendlist.sendType}' + '\n'
            + ' 총 발송건수 : ' + commaReqNum + '\n'
            + ' 발송 일정 : ' + sendTime + ' \n'
            + ' 승인 URL : ' + 'http://203.227.232.128/jsp/p_new.jsp?p='+ groupUniqNo +'&e='; */
            
            '위의 메시지내용은 [' 
            + $("#req-send-emp-table").find(".req-emp-partName").val() + '(' + $("#req-send-emp-table").find(".confirm-emp-bocode").val() + ')'
            + $("#req-send-emp-table").find(".req-emp-name").val() +'(' + $("#req-send-emp-table").find(".req-emp-id").val() + ')]'
            + '님께서 요청하신 대량' + '${smssendlist.msgDstic}' + 'S입니다.\n'
            + '메시지 내용을 확인하신후 아래의 페이지에 접속하여 결재 또는 반려하여 주시기 바랍니다.\n'
            + '결재를 하셔야 발송이 가능하니 신속히 결재하여 주시기 바랍니다.\n'
            + '문의 : IT채널부 메시지센터 담당자\n'
            + '☎ 031-229-2648, 2725\n'
            + 'http://203.227.232.128/jsp/p_new.jsp?p='+ groupUniqNo +'&e='
            ;
		
        return {
            groupUniqNo: $("#smssendlist-groupUniqNo").val(), //그룹고유번호
            groupNm: $('#request-title').val(),  //기안명
            sendType: '${smssendlist.sendType}', //발송업무
            msgDstic: $("#msg-type").val(), //메시지타입
            requestsNumber: $("#expect-count").text().replace(/[^0-9]/g, ''), //요청건수
            msgCtnt: msgTitle,    // 메시지 내용 (LMS/MMS는 제목)
            umsMsgCtnt: msg,
            sndrTelno:'${smssendlist.sndrTelno}', //발신번호
            budgetNm: $("#confirm-doc-name").val(), //예산품의명
            censorId: $("#validation-num").val(), //심의필번호
            inst : $('#file-name-input').val(), //대상자 파일명
            targetFilePath : $('#real-file-name-input').val(), // 대상자파일고유명(T21_info)
            sendConfirmEmp : sendConfirmEmp, //발송승인자 리스트
            confirmMessage : confirmBodyMessage,  // 발송승인리스트
            sendDateInfo : sendDateCount,                             //시간별 발송건수
            imageCount : imageCount,                                              // MMS 이미지 파일 갯수
            imagePath1 : $("#real-image-fileupload-input1").val(),            // MMS 이미지 경로 1
            imagePath2 : $("#real-image-fileupload-input2").val(),            // MMS 이미지 경로 2
            imagePath3 : $("#real-image-fileupload-input3").val()         // MMS 이미지 경로 3

            ,image1 : $("#blob-image-fileupload-input1").val()            // MMS 이미지 경로 1
            ,image2 : $("#blob-image-fileupload-input2").val()            // MMS 이미지 경로 2
            ,image3 : $("#blob-image-fileupload-input3").val()            // MMS 이미지 경로 3
			,seq1 : '${smssendlist.seq1}'
			,seq2 : '${smssendlist.seq2}'
			,seq3 : '${smssendlist.seq3}'
			,fileCnt : imageCount
			,sendEmpid:$("#req-send-emp-table").find(".req-emp-id").val()
			,sendBrncd:$("#req-send-emp-table").find(".confirm-emp-bocode").val()
            
            ,replaceVariableVal : replaceVariableVal                              // T21_INFO 치환변수/MaxByte 값(JSON)
            ,changeHeadDataYn : changeHeadDataYn                          // T28 헤더 변경 여부 (Y:변경, N:동일)
            ,targetReplaceVal: '${targetReplaceVal}'

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

    $(document).on('click', '.repl-var', function () {
        var text = '\${' + $(this).prop("id") + '}';
        IbkInsertText.setText('content-textarea', text);

        getMsgTextBytes($("#content-textarea"));
    });

    $(".special-char").on('click', function () {
        IbkInsertText.setText('content-textarea', $(this).text());
    });


    function removePassedTime() {
        var todayYYYYMMDDHHmm = parseInt(moment().format("YYYYMMDDHHmm"));
        $(".daytime-count").each(function () {
            var dayTime = parseInt($(this).attr("id"));
        });
    }

    function removePassedTime2() {
        var todayYYYYMMDDHHmm = parseInt(moment().format("YYYYMMDDHHmm"));
        $(".daytime-count").each(function () {
            var dayTime = parseInt($(this).attr("id"));
            $(this).find('input').attr('disabled', true);
            $(this).find('input').css('background', 'whitesmoke');
        });
    }

    function setCountInTd($input, value) {
        var eventIdSplitArr = $input.attr('id').replace("sel-", '');
        $("javascript:" + eventIdSplitArr).text(value);
        return eventIdSplitArr;
    }

    $(document).on('change', '#msg-type', function () {
        if ($(this).val() === 'sms') {
            $("#dis-max-byte").text("90");
        } else {
            $("#dis-max-byte").text("2000");
        }

        getMsgTextBytes($("#content-textarea"));
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
//       console.log(parseInt(initTotalCnt) + parseInt(test));
        return (parseInt(initTotalCnt) + parseInt(test));
    }

    // 합계 및 남은건수 갱신 @jys(등록된 건수 초기 설정)
    function remainCount() {
        var expectValue = parseInt($("#total-count").text().replace(/,/g, ''));

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
//                           selectDateTotalCount(key);

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

//                            // --------------------- 총건수 에서 기안에 해당하는 건수 제외 --------------------------------//
//                            // - 기안 수정 시 발송 총 건수에 기안의 등록된 건수가 포함되어 정상적으로 총 건수가 계산되지 않는 이슈 해결
//                            var totalId = $(this).prop("id").replace("sel-", "");   //해당 발송 일시 등록된 건수
//                            var date = totalId.substr(0,8); // 발송일자
//                            var dayTotalObj = $("#"+totalId);   // 발송 일시에 해당하는 총 건수

//                            console.log(totalId + ": 일시 총건수 = " + parseInt(dayTotalObj.text().replace(/,/gi, '')) + " / 일시 기안 건수 = " + parseInt(value.replace(/,/gi, '')));
//                            // 등록된 건수에서 해당 기안에 대한 건수 제외 ( (해당일시 총 건수) - (해당일시 기안등록 건수) )
//                            dayTotalObj.text($.number(parseInt(dayTotalObj.text().replace(/,/gi, '')) - parseInt(value.replace(/,/gi, '')))) ;

//                            var monthTotalCnt = $("#today-total-count-" + date).text().replace(/,/gi, '');  // 해당일자 등록된 발송 총건수 (일시의 모든 합)
//                            // 등록된 건수 총합에서 해당 기안에 대한 건수 제외 ( (해당일자 총 건수) - (해당일시 기안등록 건수) )
//                            $("#today-total-count-" + date).text($.number(parseInt(monthTotalCnt) - parseInt(value.replace(/,/gi, ''))));
//                            // --------------------- 총건수 에서 기안에 해당하는 건수 제외 --------------------------------//
                    setRemainAndAddedAndAbleCount($forIdSeperate, value);
                }
            });

            remainCount();  //합계/남은 건수 셋팅
            IbkDispatchHtml.validateDispatch(false);

//                    $('.tar').css('display', 'none');
        }).fail(function(xhr){
            showAlert("발송희망일 세팅중 오류가 발생했습니다. \n\n (selectDateSaveCount())");
        });
    }

    function initDateTotalCount(){
        IbkDispatchHtml.appendTo("dispatch-body", todayYYYYMMDD, "Y");
        IbkDatepicker.initDatepicker("datepicker-" + todayYYYYMMDD,
            "${pageContext.request.contextPath}", 0);
        $("#datepicker-" + todayYYYYMMDD).val(moment(todayYYYYMMDD, 'YYYYMMDD').format('YYYY-MM-DD'));
        removePassedTime();
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
                    var agreeStatus = '승인대기';
                    if(empData[i].agreeStatus == 'G'){
                        agreeStatus = '승인완료';
                    }else if(empData[i].agreeStatus == 'I'){
                        agreeStatus = '승인대기';
                    }else if(empData[i].agreeStatus == 'N'){
                        agreeStatus = '반려';
                    }
                    var confirmHtml = ''
                        + '<tr id="tr-' + empData[i].emplId + '">'
                        + '  <th scope="row" id="default-emp-count">0</th>'
                        + '  <td width="90px">' + empData[i].positionCallname + '</td>'   // 부서명 사이즈 변경 @jys
                        + '  <td width="80px">' + empData[i].emplName
                        + '     <span class="btn01">'
                        + '       <input type="hidden" class="a1-confirm-emp-id" value="' + empData[i].emplId + '">'
                        + '       <input type="hidden" class="a1-confirm-emp-class" value="' + empData[i].emplClass + '">' // Class 값 추가 @jys
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
                    var emplHpNo = empData[i].emplHpNo;
                    if(emplHpNo != null){
                        if (emplHpNo.length == 8) {
                            emplHpNo = emplHpNo.replace(/^([0-9]{4})([0-9]{4})/, "$1-$2");
                        } else if (emplHpNo.length == 12) {
                            emplHpNo = emplHpNo.replace(/(^[0-9]{4})([0-9]{4})([0-9]{4})/, "$1-$2-$3");
                        }
                        emplHpNo = emplHpNo.replace(/(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})/, "$1-$2-$3");
                    }
//                       if(emplId == empData[i].emplId) {
//                           var confirmHtml= ''
//                                 + '<tr id="tr-' + empData[i].emplId + '">'
//                                 + '  <th scope="row" id="default-emp-count">0</th>'
//                                 + '  <td width="70px">' + empData[i].positionCallname + '</td>' // 부서명 사이즈 변경 @jys
//                                 + '  <td width= "90px">' + empData[i].emplName + '</td>'
//                                 + '  <td width= "200px">' + emplHpNo
//                                 + '     <span class="btn01">'
//                                 + '       <input type="hidden" class="confirm-emp-id" value="' + empData[i].emplId + '">' // Class 값 추가 @jys
//                                 + '       <input type="hidden" class="sendConfirm-emp-emplHpNo" value="' + empData[i].emplHpNo + '">'// Class 값 추가 @jys
//                                 + '</span>'
//                                 + '  </td>'
//                                 + '</tr>';
//                       }else {
                    var confirmHtml = ''
                        + '<tr id="tr-' + empData[i].emplId + '">'
                        + '  <th scope="row" id="default-emp-count">0</th>'
                        + '  <td width="70px">' + empData[i].positionCallname + '</td>' // 부서명 사이즈 변경 @jys
                        + '  <td width= "90px">' + empData[i].emplName + '</td>'
                        + '  <td width= "200px">' + emplHpNo
                        + '     <span class="btn01">'
                        + '       <input type="hidden" class="confirm-emp-id" value="' + empData[i].emplId + '">' // Class 값 추가 @jys
                        + '       <input type="hidden" class="sendConfirm-emp-emplHpNo" value="' + empData[i].emplHpNo + '">'// Class 값 추가 @jys
                        + '       <a href="javascript:" class="btn_default emp-del-btn" id="' + empData[i].emplId
                        + '">삭제</a>'
                        + '</span>'
                        + '  </td>'
                        + '</tr>';
//                       }
                    $("#send-emp-table").prepend(confirmHtml);

                    $("#send-emp-table #default-emp-count").each(function(){
                        $(this).text(parseInt($(this).text()) + 1);
                    });
                }
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
                    var agreeStatus = '승인대기';
                    if(empData[i].agreeStatus == 'G'){
                        agreeStatus = '승인완료';
                    }else if(empData[i].agreeStatus == 'I'){
                        agreeStatus = '승인대기';
                    }else if(empData[i].agreeStatus == 'N'){
                        agreeStatus = '반려';
                    }
                    var confirmHtml = ''
                        + '<tr id="tr-' + empData[i].emplId + '">'
                        + '  <th scope="row" id="default-emp-count">0</th>'
                        + '  <td width="90px">' + empData[i].positionCallname + '</td>'   // 부서명 사이즈 변경 @jys
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
                        + '  <td width="90px">' + empData[i].positionCallname + '</td>'
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
                $("#a3" + " #articleTarget").text(title + status);

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
        var requestsNumber = $("#expect-count").text().replace(/,/g, '');
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

    function isValidDate(simNumber){
        var regex_date = /^\d{8}\-\d{4,5}$/;

        if(!regex_date.test(simNumber))
        {
            return false;
        }
        var dateString=simNumber.split("-")[0];
        var year=dateString.substring(0,4);
        var month=dateString.substring(4,6);
        var day=dateString.substring(6,8);
        // Check the ranges of month and year
        if(year < 1000 || year > 3000 || month == 0 || month > 12)
        {
            return false;
        }
        var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
        // Adjust for leap years
        if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        {
            monthLength[1] = 29;
        }

        // Check the range of the day
        return day > 0 && day <= monthLength[month - 1];
    }
</script>