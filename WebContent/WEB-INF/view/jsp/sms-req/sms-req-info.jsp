<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>SMS발송 의뢰하기
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
                <td><input type="text" name="search" maxlength="333" id="request-title" value=""
                           placeholder="기안명을 입력해주시기 바랍니다." style="width:700px"></td>
            </tr>
            <tr>
                <th scope="row">발송구분<span class="th_must">*</span></th>
                <td>
                    <div class="row1">
                        <div class="radio_default">
                            <input type="radio" name="request-type" value="marketing"
                                   id="radio1-1"
                                   checked="checked"/>
                            <label for="radio1-1">마케팅(고객관리 포함)</label>
                        </div>
                        <div class="radio_default">
                            <input type="radio" name="request-type" value="noMarketing"
                                   id="radio1-2"/>
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
                <th scope="row">중복체크여부<span class="th_must">*</span></th>
                <td>
                    <div class="row1">
                        <div class="radio_default">
                            <input type="radio" name="dupCheck" value="true"
                                   id="dupradio1-1"
                                   checked="checked"/>
                            <label for="dupradio1-1">중복제거</label>
                        </div>
                        <div class="radio_default">
                            <input type="radio" name="dupCheck" value="false"
                                   id="dupradio1-2"/>
                            <label for="dupradio1-2">중복허용</label>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row">메세지타입<span class="th_must">*</span></th>
                <td>
                    <select class="small" id="msg-type">
                        <option value="sms" selected>SMS</option>
                        <option value="lms">LMS</option>
                        <option value="mms">MMS</option>
                    </select>
                    <span class="txt1">*SMS(90byte이내) / LMS(2,000byte이내) / MMS(2,000byte이내+이미지첨부)</span>
                </td>
            </tr>
            <tr>
                <th scope="row">예상발송건수<span class="th_must">*</span></th>
                <td><input id="expect-count" type="text" name="" value="" style="width:150px">&nbsp;건
                </td>
            </tr>
            <tr>
                <th scope="row">대상자 파일</th>
                <td>
                    <input type="text" id="file-name-input" placeholder="파일 업로드" style="width:330px"
                           readonly="readonly"> <!-- View 전용 파일명 -->
                    <input type="hidden" id="real-file-name-input" placeholder="파일 업로드" style="width:330px">
                    <!-- DB처리 파일명 -->
                    <input type="file" id="fileupload" name="file"
                           data-url="${pageContext.request.contextPath}/smsreq/file/customers" style="display:none"
                           placeholder="파일 업로드">
                    <a href="javascript:" id="delete-fileupload-btn" class="btn_default small delete mgl6 vam00"
                       style="display:none;">X</a>
                    <a href="javascript:" class="btn_default gray mgl6 vam00" id="fileupload-btn">선택</a>
                    <a href="${pageContext.request.contextPath}/smsreq/download/sample/general"
                       class="btn_download_blue mgl20">일반 발송 샘플</a>
                    <a href="${pageContext.request.contextPath}/smsreq/download/sample/extra"
                       class="btn_download_blue mgl20">치환형 발송 샘플</a>
                </td>
            </tr>
            <tr>
                <th scope="row">메세지 내용<span class="th_must">*</span></th>
                <td><!-- wrap_box_sms -->
                    <div class="wrap_box_sms">
                        <!-- box_sms -->
                        <div class="wrap_cbtn">
                            <div class="col1" style="display: none;">치환변수</div>
                            <div class="col2">
                            </div>
                        </div>
                        <div class="box_sms">
                            <div class="content">
                                <div class="title_sms" id="msg-title-div" style="display: none">
                                    <input class="sms" type="text" id="msg-title"
                                           placeholder="제목을 입력해주세요.(60byte)"
                                           style="width:200px">
                                </div>
                                <div class="text_sms2" id="div-texarea" style="width:100%">
                                        <textarea class="sms" id="content-textarea"
                                                  placeholder="내용을 입력하세요"
                                                  style="font-family:굴림; font-size:16px; width:100%; height:100%"></textarea>
                                </div>
                                <div class="byte"><span id="dis-total-byte">0</span>/<span
                                        id="dis-max-byte"> 90</span>byte
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
                                        </tr>
                                        </thead>
                                        <tbody id="display_body">
                                        <tr>
                                            <td colspan="13" style="height:375px">
                                                <div class="nodata"><p>대상자파일을 업로드 해주시기 바랍니다.</p></div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- //table list -->
                            </div>
                            <!-- //scroll -->
                            <div class="total"> 총 건수<span class="right">정상 : <span class="blue">0</span>건  /  에러 : <span
                                    class="red">0</span>건</span></div>
                            <div class="mgt20">
                                <ul class="disib">
                                    <li class="disib">발신번호<span class="th_must">*</span>
                                        <input type="text" id="send-phonenum" class="mgl5" maxlength="16"
                                               style="width:100px">
                                    </li>
                                    <div style="display: none;">
                                        <li class="disib mgl20" id="validation-num-li"
                                            style="display: none; font-weight: bold; margin-left: 10px !important; ">
                                            심의필번호
                                            <input type="text" id="validation-num" class="mgl5"
                                                   style="width:100px">
                                        </li>
                                    </div>
                                </ul>
                            </div>
                        </div>
                        <!-- //box_list -->
                    </div>
                    <!-- wrap_box_sms --></td>
            </tr>
            <tr style="display: none" id="img-tr">
                <th scope="row">이미지 파일<span class="th_must">*</span></th>
                <td>
                	<div class="wrap_form" style="border-top:0px; border-bottom:0px; padding-bottom:10px;">
	                    <ul class="box_ms mgt10">
	                        <li>
	                            <div class="image_box" style="margin-bottom: 10px;" id="select_selectSEQ1" > 
				            		
				            	</div>
				            	<input type="hidden" id="selectSEQ1" value="" placeholder="파일 업로드" style="width:330px">
	                            <a href="javascript:" id="delete-selectSEQ1" class="btn_default small delete mgl6 vam00" style="display:none;">X</a>
	                            <a href="javascript:" id="image-file-btn1" class="btn_default gray mgl6 vam00">선택</a>
	                        </li>
	                        <li>
							    <div class="image_box" style="margin-bottom: 10px;" id="select_selectSEQ2" > 
									
								</div>
								<input type="hidden" id="selectSEQ2" value=""  placeholder="파일 업로드" style="width:330px">
							    <a href="javascript:" id="delete-selectSEQ2" class="btn_default small delete mgl6 vam00" style="display:none;">X</a>
							    <a href="javascript:" id="image-file-btn2" class="btn_default gray mgl6 vam00">선택</a>
							</li>
							<li>
								<div class="image_box" style="margin-bottom: 10px;" id="select_selectSEQ3" > 
				            		
				            	</div>
				            	<input type="hidden" id="selectSEQ3" value=""  placeholder="파일 업로드" style="width:330px">
		                        <a href="javascript:" id="delete-selectSEQ3" class="btn_default small delete mgl6 vam00" style="display:none;">X</a>
		                        <a href="javascript:" id="image-file-btn3" class="btn_default gray mgl6 vam00">선택</a>
	                        </li>
	                    </ul>
                    </div>
                    
                    <div class="ment_sms01 mgt5">*최소1개, 최대3개 까지 가능합니다.<a href="javascript:"
                                                                         id="img-desc-btn"
                                                                         class="btn_small mgl15">이미지
                        규격</a></div>
                </td>
            </tr>
            <tr id="tr_confirm-doc-name" style="display: none;">
                <th scope="row">예산합의서명</th>
                <td><input type="text" id="confirm-doc-name" maxlength="50" value=""
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
                                <p class="q">1차 <a href="#a1" id="articleTarget" style="text-decoration:none">기안부</a><a
                                        href="javascript:" id="employee-search-btn" class="btn_default gray mgl10"
                                        style="width:38px">검색</a></p>
                                <div class="a" style="display: none;">
                                    <!-- table_view -->
                                    <div class="tbl_wrap_view_sms03"
                                         style="width:320px; border-top:1px solid #ffffff; margin-top:4px;">
                                        <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
                                            <caption>
                                                검색조건 테이블입니다.
                                            </caption>
                                            <colgroup>
                                                <col style="width:40px"/>
                                                <col style="width:90px"/>
                                                <col style="width:"/>
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
        </table>
    </div>
    <!-- //table_view -->
    <!-- 버튼 -->
    <div class="btn_wrap01_detail"><a href="javascript:" class="btn_big blue" id="confirm-req-btn">기안 등록</a>
    <a href="javascript:" class="btn_big blue" id="save-temp">임시저장</a>
    <a href="javascript:" class="btn_big" id="cancel-btn">취소</a>
    </div>
    <!-- //버튼 -->
</div>

<!-- //content -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="../common/special-char-dialog.jsp" flush="true"/>
<jsp:include page="../common/preview-dialog.jsp" flush="true"/>
<jsp:include page="../common/smsreq_usersearch-list.jsp" flush="true"/>
<!-- 승인자 검색 다이얼로그 수정 @jys -->


  
    
    
<!--popup-->
<div id="popup_content" > 
    
    <div class="popup_wrap_c" id="popup_tmplList" style="display:none;">
    	<!-- top -->
	    <div class="top">
	            <div class="title">MMS 템플릿</div>
	            <div class="btn_close"><a style="cursor:pointer;" @click="popTpmlListClose" ><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
	    </div>
	    <!-- //top -->
	   
	    <div class="box_search01">
	        <ul>
	            <li>
	
					<span class="text1">타입</span>
	                <span>
						<select v-model="tmpl_list.searchType" >
							<option value="">전체</option>
							<option value="B">기본제공</option>
							<option value="I">개별작성</option>
							<option value="N">명함</option>
						</select>
					</span>
					&nbsp;
	                <span class="text1">카테고리</span>
	                <span>
						<input type="text" v-model="tmpl_list.searchCategory" maxlength="20" value="" style="width:120px">
					</span>
					&nbsp;
	                <span class="text1">제목</span>
	                <span>
						<input type="text" v-model="tmpl_list.searchTitle" maxlength="40" value="" style="width:120px">
					</span>
	            </li>
	        </ul>
	        <span class="btn3"><a style="cursor:pointer;" class="btn_search" @click="searchTmpl">조회</a></span>
	    </div>
		
		<div class="content_pop" >
		    <div v-if="tmpl_result.totalRecords > 0" class="wrap_form">
		 		<ul class="box_ms mgt10" style="margin-bottom: 70px;">
					<li v-for="f in 4">
						<div v-if="f <= tmpl_result.data.length" >
							<div class="image_box" style="cursor:pointer" @click="selectTmpl(tmpl_result.data[f-1])"><img v-bind:src="viewTmpl(tmpl_result.data[f-1].MMS_IMG_ID)" style="width:100%;height:100%;" /></div>
							<div>
			                	<label><b>식별번호 : </b>{{tmpl_result.data[f-1].MMS_IMG_ID}}</label>
			                </div>
							<div>
								<label><b>카테고리 : </b>{{tmpl_result.data[f-1].IMG_CTGY_NM}}</label>
			                </div>
			                <div>
			                	<label><b>이미지명 : </b>{{tmpl_result.data[f-1].IMG_NM}}</label>
			                </div>
						</div>
		            </li>
		        </ul> 
		        <ul v-if="4 < tmpl_result.data.length" class="box_ms mgt10" style="margin-bottom: 50px;">
		            <li v-for="f in 4">
		            	<div v-if="f+4 <= tmpl_result.data.length" >
			                <div class="image_box" style="cursor:pointer" @click="selectTmpl(tmpl_result.data[f+3])" ><img v-bind:src="viewTmpl(tmpl_result.data[f+3].MMS_IMG_ID)" style="width:100%;height:100%;" /></div>
			                <div>
			                	<label><b>식별번호 : </b>{{tmpl_result.data[f+3].MMS_IMG_ID}}</label>
			                </div>
			                <div>
								<label><b>카테고리 : </b>{{tmpl_result.data[f+3].IMG_CTGY_NM}}</label>
			                </div>
			                <div>
			                	<label><b>이미지명 : </b>{{tmpl_result.data[f+3].IMG_NM}}</label>
			                </div>
						</div>
		            </li>
		        </ul>
		    </div>
		    <div v-if="tmpl_result.totalRecords <= 0"  class="wrap_form" >
				<ul class="box_ms mgt10" style="text-align:center">
					<label >조회 하신 데이터가 없습니다.</label>
		        </ul> 
		    </div>
		</div>
	    <!-- 페이징 -->
		 <div class="paging" style="margin-top: 0px;" >
			<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_first.png' alt='첫 페이지' @click="goTmplPage(1)"/></a>
			<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_previous.png' alt='이전 페이지' @click="goTmplPage(tmpl_result.currentPage == 1? 1:tmpl_result.currentPage-1)" /></a>
	  		<span class='wrap'>
				<a style="cursor:pointer;" v-bind:class="{on:(tmpl_result.startPage+n-1 == tmpl_list.currentPage)}" v-for="n in tmpl_result.endPage - tmpl_result.startPage + 1" @click="goTmplPage(tmpl_result.startPage+n-1)">{{tmpl_result.startPage+n-1}}</a>
			</span>
			<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_next.png' alt='다음 페이지' @click="goTmplPage(tmpl_result.currentPage == tmpl_result.lastPage ? tmpl_result.lastPage:tmpl_result.currentPage+1)" /></a>
			<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_last.png' alt='마지막 페이지' @click="goTmplPage(tmpl_result.lastPage)"/></a>
		</div>
	
	    <!-- footer -->
	    <div class="footer_pop">
	        <!-- button --> <a class="btn_big blue" style="cursor:pointer" @click="registTmplPopup">등록</a> <a style="cursor:pointer;" class="btn_big gray"  @click="popTpmlListClose" >취소</a><!-- //button -->
	    </div>
	    <!-- //footer -->
	
	</div>
	<!--//popup-->
	
	
	<div class="popup_wrap_c" id="popup_regist" style="display:none">
	    <!-- top -->
	    <div class="top">
	            <div class="title">등록</div>
	            <div class="btn_close"><a style="cursor:pointer" @click="popRegistClose" ><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
	    </div>
	    <!-- //top -->
	
	    <!-- content -->
	    <div class="content_pop">
	    <!-- table_view -->
	      <div class="tbl_wrap_view_jobcode">
	        <form name="regist_form" id="regist_form">
	        <table class="tbl_view01">
	          <colgroup>
	          <col style="width:200px" />
	          <col style="width:auto" />
	          </colgroup>
	          <tr>
	            <th scope="row">이미지카테고리<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_regist.IMG_CTGY_NM"  ref="tmpl_regist.IMG_CTGY_NM"  style="width:700px;">
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">이미지명<span class="th_must">*</span></th>
	            <td>
	            	<input type="text" v-model="tmpl_regist.IMG_NM" ref="tmpl_regist.IMG_NM" style="width:700px;">
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">템플릿 타입<span class="th_must">*</span></th>
	            <td>
	                <select v-model="tmpl_regist.IMG_TYPE_CD" >
		                <option value="B">기본제공</option>
		                <option value="I">개별작성</option>
		                <option value="N">명함</option>
		            </select>
	            </td>
	          </tr>
	          
	          <tr>
	            <th scope="row">이미지<span class="th_must">*</span></th>
	            <td>
	            	<div style="height:180px;" > 
	            		<img v-if="tmpl_regist.IMAGE_PATH!=''" v-bind:src="getTmplUploadedImage(tmpl_regist.IMAGE_PATH)" style="height:100%;" />
	            	</div>
	            	
					<input type="text" class="imgPath" v-model="tmpl_regist.IMAGE_PATH" placeholder="파일 업로드" readonly="readonly" style="display:none">
					<input type="file" id="imagefileupload" name="imagefileupload" placeholder="파일 업로드"  @change="imageChoice" >
						
	            </td>            
	          </tr>
	          
	          <tr>
	            <th scope="row">사용여부<span class="th_must">*</span></th>
	            <td>
	                <select v-model="tmpl_regist.USE_YN" >
		                <option value="Y">사용</option>
		                <option value="N">미사용</option>
		            </select>
	            </td>
	          </tr>
	          <tr>
	            <th scope="row">개인화 렌더링 정보</th>
	            <td>
	                <textarea type="text" v-model="tmpl_regist.MMS_USER_DFNT_CON" style="width:700px;"></textarea>
	            </td>            
	          </tr>
	         
	        </table>
	        </form>
	      </div>
	      <!-- //table_view -->
	    </div>
	    <!-- //content -->
	
	    <!-- footer -->
	    <div class="footer_pop">
	        <!-- button --><a style="cursor:pointer" @click="registTmpl" class="btn_big blue">확인</a><a class="btn_big gray" style="cursor:pointer"  @click="popRegistClose" >취소</a><!-- //button -->
	    </div>
	    <!-- //footer -->
	</div>

</div>
<!-- popup -->




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

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
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
    //그룹고유번호 채번
    var app;
    var groupUniqNo = '${groupUniqNo}';
    var extraFlag = false;
    var firstRow = null;
    var user_bocode = <%=session.getAttribute("EMPL_BOCODE")%>; // 세션에서 BOCODE 가져오기 @jys
    if (user_bocode == null || user_bocode == "") { // 세션에서 BOCODE 없을 경우 등록 불가능하게 처리 @jys
        showAlert(<%=session.getAttribute("EMPL_NAME")%>+"님의<br>부서코드가 존재하지 않습니다.<br><br>부서코드를 확인 하시고<br>다시 진행 하시기 바랍니다.");
        $("#confirm-req-btn").hide();
        $("#save-temp").hide();
    }

    var todayYYYYMMDD = moment().format("YYYYMMDD");
    var lastAddedDay = moment().format("YYYYMMDD");
    $(document).ready(function () {
    	app = new Vue ({
       		el : '#popup_content',
       		data : {
       			tmpl_list: {
       				searchType:"",
       				searchCategory: "",
       				searchTitle: "",
       				searchUseYn:"Y",
    				perPage:8,
    				currentPage:1
    			},
    			tmpl_result: {
    				totalRecords: 0,
    				startPage:1,
    				endPage:1,
    				lastPage:1
    			},
    			tmpl_select: {
    				selectSEQ1:"",
    				selectSEQ2:"",
    				selectSEQ3:""
    			},
    			tmpl_regist:{
    				IMG_CTGY_NM:"",
    				IMG_NM:"",
    				IMG_TYPE_CD:"B",
       				USE_YN:"Y",
       				MMS_USER_DFNT_CON:"",
       				IMAGE_PATH:"",
       				EMN:"",
       				DVCD:""
       			}
       		},
       		methods : {
       			searchTmpl: function() {
       				var _inst = this;
       				$.ajax({						
    					url: '${pageContext.request.contextPath}/template-list',
    					type: 'POST',
    					data: _inst.tmpl_list,
    					dataType: 'JSON',
    					success: function (result) {
    						_inst.tmpl_result = result;
    						_inst.tmpl_list.currentPage = result.currentPage;
    					}
    				});
    				_inst.goTmplPage(1);
       			},
       			goTmplPage: function(pageNo) {
    				var _inst = this;
    				_inst.tmpl_list.currentPage = pageNo;
    				$.ajax({						
    					url: '${pageContext.request.contextPath}/template-list',
    					type: 'POST',
    					data: _inst.tmpl_list,
    					dataType: 'JSON',
    					success: function (result) {
    						_inst.tmpl_result = result;		
    						_inst.tmpl_list.currentPage = result.currentPage;
    					}
    				});
    			},
    			viewTmpl: function(item){
    				return "${pageContext.request.contextPath}/template-img.ibk?seq=" + item;
    			},
    			selectTmpl: function(item){
    				var _inst = this;
    				
    				_inst.tmpl_select[_inst.tmpl_select.paramName]=item.MMS_IMG_ID;
    				
    				$("#"+_inst.tmpl_select.paramName).val(item.MMS_IMG_ID);
					$("#delete-"+_inst.tmpl_select.paramName).show();
					
					var image = $("<img/>")
					.css({"width":"100%","height":"100%"})
					.attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + item.MMS_IMG_ID);
					
					$("#select_"+_inst.tmpl_select.paramName).children().remove();
					$("#select_"+_inst.tmpl_select.paramName).append(image);
					
    				_inst.popTpmlListClose();
    			},
    			registTmplPopup: function(){
    				this.tmpl_regist = {
    						IMG_CTGY_NM:"",
    						IMG_NM:"",
    						IMG_TYPE_CD:"B",
    		   				USE_YN:"Y",
    		   				MMS_USER_DFNT_CON:"",
    		   				IMAGE_PATH:"",
    		   				EMN:'${EMPL_ID}',
    		   				DVCD:'${EMPL_BOCODE}'
    					};
    				popOpen("#popup_regist");
    			},
    			registTmpl: function() {
    				var _inst = this;
    				var categoryLen = _inst.getByteLen(_inst.tmpl_regist.IMG_CTGY_NM);
    				var nameLen = _inst.getByteLen(_inst.tmpl_regist.IMG_NM);
    				if (_inst.tmpl_regist.IMG_CTGY_NM == "") {
    					alert("이미지카테고리는 필수입력 항목입니다.");
    					_inst.$refs["tmpl_regist.IMG_CTGY_NM"].focus();
    					return;
    				}
    				
    				if (categoryLen > 20 ) {
    					alert("이미지카테고리는 한글기준 최대 10자 입니다.");
    					_inst.$refs["tmpl_regist.IMG_CTGY_NM"].focus();
    					return;
    				}
    				
    				if (_inst.tmpl_regist.IMG_NM == "") {
    					alert("이미지명은 필수입력 항목입니다.");
    					_inst.$refs["tmpl_regist.IMG_NM"].focus();
    					return;
    				}
    				
    				if (nameLen > 100 ) {
    					alert("이미지명은 한글기준 최대 50자 입니다.");
    					_inst.$refs["tmpl_regist.IMG_NM"].focus();
    					return;
    				}
    			
    				if (_inst.tmpl_regist.IMAGE_PATH == "") {
    					alert("이미지파일은 필수 항목입니다.");
    					return;
    				}
    				
    				$.ajax({						
    					url: '${pageContext.request.contextPath}/template-regist.ibk',
    					type: 'POST',
    					data: _inst.tmpl_regist,
    					dataType: 'JSON',
    					success: function (result) {
    						_inst.tmpl_regist={
    								IMG_CTGY_NM:"",
    								IMG_NM:"",
    								IMG_TYPE_CD:"B",
    				   				USE_YN:"Y",
    				   				MMS_USER_DFNT_CON:"",
    				   				IMAGE_PATH:""
    						};
    						alert("등록이 완료되었습니다."); 
    						_inst.popRegistClose();
    						_inst.searchTmpl();
    					}
    				});
    			},
    			getTmplUploadedImage: function(item){
    				return "${pageContext.request.contextPath}/template-uploaded-img.ibk?filename=" + item;
    			},
    			popTpmlListClose: function() {
    				var _inst = this;
    				popClose("#popup_tmplList");
    				_inst.tmpl_list= {
    						searchType:"",
               				searchCategory: "",
               				searchTitle: "",
               				searchUseYn:"Y",
            				perPage:8,
            				currentPage:1
            		};
    				_inst.searchTmpl();
    			},
    			imageChoice: function() {
    				var _inst = this;
    				
    				var formData = new FormData();  
    				formData.append("fileName", $("#popup_regist").find("input[name=imagefileupload]")[0].files[0]); 
    				
    				$.ajax({ 
    					url: '${pageContext.request.contextPath}/template-regist-image.ibk', 
    					type: 'POST',
    					dataType: 'JSON',
    					enctype: 'multipart/form-data',
    					data: formData, 
    					processData: false, 
    					contentType: false, 
    					success: function(data){ 
    						_inst.tmpl_regist.IMAGE_PATH=data.filename;
    					} 
    				});
    			},
    			getByteLen: function(value) {
    				var j_len = 0;
    				var j_char = '';
    				for(var i=0; i<value.length; i++) {
    					j_len += this.getBytes(value.charAt(i));
    				}
    				return j_len;
    			},
    			getBytes: function(value) {
    				if(escape(value).length > 4) {
    					return 2;
    				} else if(value != '\r') {
    					return 1;
    				}
    				return 0;
    			},
    			popRegistClose: function() {
    				$("#popup_regist").find("input[name=imagefileupload]").val("");
    				popClose("#popup_regist");
    			},
    			popTmplListOpen: function(paramName) {
    				var _inst = this;
    				popOpen("#popup_tmplList");
    				_inst.tmpl_select.paramName = paramName;
    				_inst.searchTmpl();
    			}
       		},
    		created : function() {
    			
    		}
       	});
    	
        $("#send-phonenum").on("keyup", function () {
            inputPhoneType($(this));
        });

        $('#fileupload').fileupload({
            dataType: 'json',
            add: function (e, data) {
                var uploadFile = data.files[0];
                var isValid = true;
                console.log(uploadFile.size);
                var sendData = createReqData();
                if (!(/xls|xlsx|csv|XLS|XLSX|CSV/i).test(uploadFile.name)) {
                    showAlert('xls, xlsx,csv 만 가능합니다!');
                    isValid = false;
                    return false;
                }
                data.formData = {
                    'groupUniqNo': sendData.groupUniqNo,
                    'sendType': sendData.sendType === 'marketing' ? 'm' : 'g',
                    'msgDstic': sendData.msgDstic,
                    'dupCheck': sendData.dupCheck
                };

                if (isValid) {
                    data.submit();
                }
            },
            done: function (e, data) {
                console.log(data.files[0].name);
                var result = data.result;
                for (var key in result) {
                    console.log("key : " + key + ", value : " + result[key]);
                }
                if (result.message == null) {
                    $("#file-name-input").val(data.files[0].name);
                    console.log(result.realFileName);
                    $("#real-file-name-input").val(result.realFileName);

                    //##초기화
                    // 1. 치환변수 문구 숨기기
                    $(".wrap_cbtn .col1").hide();
                    // 2. 치환변수 버튼 삭제
                    $(".wrap_cbtn .col2").empty();
                    // 3. 치환변수 헤더 삭제
                    $("#display_head tr").children().each(function (idx) {
                        if (idx >= 3) {
                            $(this).remove();
                        }
                    });
                    extraFlag = false;
                    firstRow = null;
                    //##치환변수 테이블 헤더 추가 및 버튼 생성
                    if (result.extFieldName != null && result.extFieldName.length > 0) {
                        var arrHead = result.extFieldName;
                        var arrMax = result.byteMax;
                        // 1. 치환변수 테이블 헤더 생성
                        var outputHead = "";
                        var outputButton = "";
                        for (idx in arrHead) {
                            outputHead += "<th>" + arrHead[idx] + "</th>";

                            outputButton += '<a href="javascript:" class="btn_default blue mgr6 mgb6 repl-var" id="' + arrHead[idx] + '">' + arrHead[idx] + '(' + arrMax[idx] + ')</a>'
                                + '<input type="hidden" class="' + arrHead[idx] + '" value="' + arrMax[idx] + '">';
                        }
                        $("#display_head tr").append(outputHead);

                        // 2. 치환변수 버튼 생성
                        $(".wrap_cbtn .col1").show();
                        $(".wrap_cbtn .col2").append(outputButton);

                        //extra 여부 변경
                        extraFlag = true;
                    }

                    if (result.displayList.length > 0) {
                        var targets = result.displayList;
                        $("#display_body tr").unbind().remove();
                        var indexRow = 1;
                        for (key in targets) {

                            var map = targets[key];
                            if (extraFlag && indexRow == 1) {
                                firstRow = map;
                            }
                            var output = "";
                            for (key in map) {
                                output = output + "<td>" + map[key] + "</td>"
                            }
                            var listElement = $("<tr>").html(output);
                            $("#display_body").append(listElement);
                            indexRow += 1;
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

                    showConfirmDoc(); // 예산합의서명 노출 여부

                    var errMapMsg = "총:" + ($.number(result.totCnt + result.errCnt)) + "건, 정상:" + result.totCnt + "건, 에러:" + result.errCnt + "건";
                    if ($.number(result.errCnt) > 0) {
                        for (var key in result.errMap) {
                            errMapMsg += "<br>";
                            console.log("key : " + key + ", value : " + result.errMap[key]);
                            errMapMsg += key + "라인: " + result.errMap[key];
                        }
                    }
                    showAlert(errMapMsg);
                } else {
                    showAlert(result.message);
                }

            }
        });

        $("#image-file-btn1").on("click", function () {
            //$("#image-fileupload1").trigger('click');
        	//popOpen("#popup_tmplList");
        	app.popTmplListOpen("selectSEQ1");
        	
        });

        //이미지 파일1 제거 버튼 이벤트
        $("#delete-selectSEQ1").on("click", function () {
            //showConfirmForAjax(title, message, callback, targetObject)
            showConfirmForAjax("등록 파일 제거", "등록된 이미지 파일을 제거 하시겠습니까?", remove_uploadFile, "Img1");
        });

        $("#image-file-btn2").on("click", function () {
        	app.popTmplListOpen("selectSEQ2");
        });

        //이미지 파일2 제거 버튼 이벤트
        $("#delete-selectSEQ2").on("click", function () {
            //showConfirmForAjax(title, message, callback, targetObject)
            showConfirmForAjax("등록 파일 제거", "등록된 이미지 파일을 제거 하시겠습니까?", remove_uploadFile, "Img2");
        });

        $("#image-file-btn3").on("click", function () {
        	app.popTmplListOpen("selectSEQ3");
        });

        //이미지 파일3 제거 버튼 이벤트
        $("#delete-selectSEQ3").on("click", function () {
            //showConfirmForAjax(title, message, callback, targetObject)
            showConfirmForAjax("등록 파일 제거", "등록된 이미지 파일을 제거 하시겠습니까?", remove_uploadFile, "Img3");
        });

        $("#fileupload-btn").on("click", function () {
            $("#fileupload").trigger('click');
        });

        //대상자 파일 제거 버튼 이벤트
        $("#delete-fileupload-btn").on("click", function () {
            //showConfirmForAjax(title, message, callback, targetObject)
            showConfirmForAjax("등록 파일 제거", "등록된 대상자 파일( '" + $("#file-name-input").val() + "' )을 <br>제거 하시겠습니까?", remove_uploadFile, "Subject");
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

        IbkDispatchHtml.appendTo("dispatch-body", todayYYYYMMDD, "Y");
        IbkDatepicker.initDatepicker("datepicker-" + todayYYYYMMDD,
            "${pageContext.request.contextPath}", 0);
        $("#datepicker-" + todayYYYYMMDD).val(moment(todayYYYYMMDD, 'YYYYMMDD').format('YYYY-MM-DD'));
        selectDateTotalCount(todayYYYYMMDD); // 발송 희망일 셋팅 @jys
        removePassedTime();

        IbkSmsReqDispatchInfo.addDispatchDate(todayYYYYMMDD);
        IbkSmsReqDispatchInfo.setCount(todayYYYYMMDD, 4, 1000);

        
    });

    $("input[name=request-type]").on('change', function () {
        if ($(this).val() === 'noMarketing') {
//       $("#validation-num").val('');
//       $("#validation-num-li").attr("style", "display: none !important");
        } else {
//       $("#validation-num-li").show();
        }
    });

    // 직원 검색시 초기값을 부서명 : 기안부서로 세팅
    $("#employee-search-btn").on('click', function (e) {
        if ($('#emp-table').find('tr').length == 5) {
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
        if (!addable) {
            return false
        }
        ;
        $(".tbl_wrap_view_sms03").css("border-top", "1px solid #e0e0e0");

        var empData = IbkDataTableInSearch.dataTable.row(
            $(".search-dt-check-box:checked").val()).data();
        console.log(empData);
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
        $("#emp-table #default-emp-count").each(function () {
            $(this).text(parseInt($(this).text()) + 1);
        });
        $("#emp-table").prepend(employyHtml);
    });

    $(document).on('click', '.emp-del-btn', function () {
        $("#tr-" + $(this).attr('id')).remove();
        // 승인자 삭제시 넘버링 오류 수정 @jys
        $("#emp-table #default-emp-count").each(function (idx) {
            $(this).text(parseInt(idx + 1));
        });
//     $("#default-emp-count").text(parseInt($("#default-emp-count").text()) - 1);
    });

    $("#special-char-show-img").on('click', function () {
        showSpecailCharDialog();
    });

    $("#preview-dialog-show-img").on('click', function () {
        var message = $("#content-textarea").val();
        if (extraFlag && firstRow != null) {
            $(".wrap_cbtn .col2 a").each(function () {
                //치환변수명
                var subVar = $(this).prop("id");
                //사용된 치환변수 갯수 확인
                var checkText = new RegExp("[$]\{+" + subVar + "\}", "g");
                var cntMatch = message.match(checkText);

                if (cntMatch != null) {
                    for (cnt = 0; cnt < cntMatch.length; cnt++) {
                        message = message.replace(cntMatch[cnt], firstRow[subVar]);
                    }

                }
            });
        }
        showPreviewDialog($("#msg-title").val(), message);
    });

    $("#img-desc-btn").on('click', function () {
        showConfirmNoCancelBtn("이미지 규격", "해상 : 640 * 480 <br/> 최대 크기 : 1MB(3개 합)");
    });

    $(document).on('click', '.es-input', function () {
        $(this).val('');
    });

    // 결제 올리기 버튼 클릭시 Action
    $("#confirm-req-btn").off('click').on('click', function () {
        IbkDispatchHtml.validateDispatch(false);

        if (!checkSaveValidation()) {
            return false;
        } // 벨리데이션 @jys

        var smsReqData = createReqData();
        var sendTypeName = smsReqData.sendType === 'marketing' ? '마케팅' : '비마케팅';
        var sendTime = '';

        var tempDate = '';
        $.each(smsReqData.sendDateInfo, function (index, value) {
            var momentTime = moment(value.pengagYms, 'YYYYMMDDHHmm');
            if (tempDate === momentTime.format('YYYY-MM-DD')) {
                sendTime += ', &nbsp;' + momentTime.format('HH:mm');
                sendTime += '&nbsp;(' + value.sectionNumber + ")";
            } else {
                if (tempDate !== '') {
                    sendTime += '<br>';
                }
                sendTime += momentTime.format('YYYY-MM-DD');
                sendTime += '&nbsp;' + momentTime.format('HH:mm');
                sendTime += '&nbsp;(' + value.sectionNumber + ")";
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
            + '    <p class="mgt20">기안을 등록 하시겠습니까?</p>\n'
            + '  </div>';
        showConfirmForAjax('기안 등록', confirmBodyMessage, saveSmsReq, smsReqData);
    });

    function saveSmsReq(paramData) {
        $.ajax({
            url: '${pageContext.request.contextPath}/smsreq',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(paramData),
        }).done(function (data) {
            showAlert("기안을 등록 하였습니다.", moveSaveOk);
        }).fail(function (xhr) {
            showAlert("기안등록 요청 중 에러 발생<br><br>에러 메시지<br>[" + xhr.responseJSON.message + "]<br>에러코드<br>[" + xhr.status + "]<br>관리자에게 문의 바랍니다.<br><br>error<br>" + xhr.responseText);
        });
    }

    // 임시저장 버튼 클릭시 Action
    $("#save-temp").off('click').on('click', function () {
        if (!checkSaveValidation("temp")) {
            return false;
        } // 벨리데이션 @jys

        var smsReqData = createReqData();

        $.ajax({
            url: '${pageContext.request.contextPath}/smsreq/temp',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(smsReqData),
        }).done(function (data) {
            showAlert("저장 하였습니다.", moveSaveOk);
        }).fail(function (xhr) {
            showAlert("저장 요청 중 에러 발생<br><br>에러 메시지<br>[" + xhr.responseJSON.message + "]<br>에러코드<br>[" + xhr.status + "]<br>관리자에게 문의 바랍니다.<br><br>error<br>" + xhr.responseText);
        });
    });

    $("#cancel-btn").on('click', function () {
        showConfirm("취소", "취소시 작성중인 기안의 내용이 모두 사집니다. 취소하시겠습니까?", reloadWindow);
    });

    function reloadWindow() {
        location.reload();
    }

    function validSendCount() {
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

    // back-end 처리위한 데이터 파싱 수정 @jys
    function createReqData() {
        var t21_pengagYms = "99991231235959"; // T21에 들어갈 발송일시 (제일 빠른일시)

        var sendTimeCount = IbkDispatchHtml.getDispatchList();

        // 발송예정시간 및 건수를 request param 으로 만드는 작업
        var sendDateCount = [];
        for (var index = 0; index < sendTimeCount.length; index++) {
            var sendCount = sendTimeCount[index].count;
            var date = $(".dispatch-datepicker").val().replace(/-/g, '');
            var dateTime = date + sendTimeCount[index].time + "00";

            if (sendCount > 0) {
                if (t21_pengagYms > dateTime) {
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
        $(".article").each(function () {
            var type = 1;
            if ($(this).prop("id") == "a1") {
                type = 1;
            } else if ($(this).prop("id") == "a2") {
                type = 2;
            } else if ($(this).prop("id") == "a3") {
                type = 3;
            }

            $(this).find(".confirm-emp-id").each(function (index) {
                confirmEmp.push({
                    emplId: $(this).val()
                    , agreeType: type
                });
            });
        });

        // SMS/LMS/MMS 메시지 제목, 내용 셋팅
        var msgTitle = null;
        var msg = null;
        if ($("#msg-type").val() == "sms") {
            msgTitle = $("#content-textarea").val();
        } else {
            msgTitle = $("#msg-title").val();
            msg = $("#content-textarea").val();
        }

        // MMS 이미지 파일 갯수 체크
        var imageCount = null;
        if ($("#msg-type").val() == "mms") {
            imageCount = 0;
            /* $(".imgPath").each(function () {
                if ($(this).val() != null && $(this).val() != '') {
                    imageCount++;
                }
            }); */
            if($("#selectSEQ1").val() != null && $("#selectSEQ1").val() != ''){
            	imageCount++;
            }
            if($("#selectSEQ2").val() != null && $("#selectSEQ2").val() != ''){
            	imageCount++;
            }
            if($("#selectSEQ3").val() != null && $("#selectSEQ3").val() != ''){
            	imageCount++;
            }
        }

        // 치환변수 셋팅
        var replaceVariableVal = "";
        $(".wrap_cbtn .col2 a").each(function () {
            var subVar = $(this).prop("id");
            var max = $("." + subVar).val();

            replaceVariableVal += ",\"" + subVar + "\":\"" + max + "\"";
        });

        if (replaceVariableVal != null) {
            replaceVariableVal = "{" + replaceVariableVal.substring(1, replaceVariableVal.length) + "}";
        }

        //@data jys
        return {
            groupUniqNo: groupUniqNo                                              // 그룹고유번호       

            , groupNm: $("#request-title").val()                                   // 기안명
            , sendType: $("input[name=request-type]:checked").val()        // 발송업무 선택
            , msgDstic: $("#msg-type").val()                                       // 메시지 타입 (SMS/LMS/MMS)
            , requestsNumber: $("#expect-count").val().replace(/,/g, '')       // 예상발송 건수
            , msgCtnt: msgTitle                                                            // 메시지 내용 (LMS/MMS는 제목)
            , umsMsgCtnt: msg                                                          // UMS메시지 내용 (LMS/MMS는 제목)
            , budgetNm: $("#confirm-doc-name").val()                           // 예산합의서명
            , sndrTelno: $("#send-phonenum").val().replace(/-/gi, "")      // 발신번호
            , censorId: $("#validation-num").val()                                 // 심의필번호
            , inst: $("#file-name-input").val()                                        // 실제 대상자 파일명 (T21)
            , targetFilePath: $("#real-file-name-input").val()                 // 대상자 파일명 (T21_INFO)
            , pengagYms: t21_pengagYms                                         // 발송시간 T21에 대한 대표시간(제일 빠른시간)
            , sendDateInfo: sendDateCount                                     // 시간별 발송 건수
            , confirmEmp: confirmEmp                                                  // 승인자 정보
            , dupCheck : $("input[name=dupCheck]:checked").val()

            , imageCount: imageCount                                              // MMS 이미지 파일 갯수
            , imagePath1: $("#real-image-fileupload-input1").val()            // MMS 이미지 경로 1
            , imagePath2: $("#real-image-fileupload-input2").val()            // MMS 이미지 경로 2
            , imagePath3: $("#real-image-fileupload-input3").val()            // MMS 이미지 경로 3

            , image1: $("#blob-image-fileupload-input1").val()            // MMS 이미지 경로 1
            , image2: $("#blob-image-fileupload-input2").val()            // MMS 이미지 경로 2
            , image3: $("#blob-image-fileupload-input3").val()            // MMS 이미지 경로 3
			
            , seq1: $("#selectSEQ1").val()									// MMS 템플릿 SEQ1
            , seq2: $("#selectSEQ2").val()									// MMS 템플릿 SEQ2
            , seq3: $("#selectSEQ3").val()									// MMS 템플릿 SEQ3
            
            , replaceVariableVal: replaceVariableVal                              // T21_INFO 치환변수/MaxByte 값(JSON)

            , confirmCheck: false                              // 결재자 생략 기안 처리(false)
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
     * 회망일 추가 버튼을 클릭 하면 회망일 입력 block 과 마지막 입력 일자를 갱신 합니다.
     * 추가 희망일의 초기 날짜는 마지막 입력 일자 + 1day dlqslek.
     */
    $(document).on('click', '#dispatch-add-btn', function () {
        var standardMinDate = $(".hasDatepicker").eq(0).prop('id').replace('datepicker-', '');

        var targetDate = moment(lastAddedDay, 'YYYYMMDD').add(1, 'days').format("YYYYMMDD");

        if (targetDate - standardMinDate > maxDate) {
            showAlert("발송희망일은 최대 " + maxDate + "일을 초과하실 수 없습니다.<br>발송희망일을 다시 선택해 주시기 바랍니다. ")
            return false;
        }

//     IbkDispatchHtml.appendTo("dispatch-body", targetDate, 'N');
        IbkDatepicker.initDatepicker("datepicker-" + targetDate, "${pageContext.request.contextPath}",
            0);
        $("#datepicker-" + targetDate).val(moment(targetDate, 'YYYYMMDD').format('YYYY-MM-DD'));
        selectDateTotalCount(targetDate); // 발송 희망일 셋팅 @jys
        removePassedTime(); //희망일 추가 시 날짜 상관없이 현재시간으로 선택지 remove 되는 오류 수정 @jys
        lastAddedDay = targetDate;
    });

    // 희망발송 시간에 건수 선턱시
    // 라이브러리에서 제공해주는 event 사용
    $(document).on('select.editable-select', '.editable-select', function (e) {
        setRemainAndAddedAndAbleCount($(this), $(this).val());
        ;
    });

    // 발송 희망일 변경 시 이벤트 @jys
    var maxDate = 7;
    $(document).on('change', '.hasDatepicker', function () {
        var beforeDate = $(this).prop('id').replace('datepicker-', '') // 이전 날짜
        var changeDate = $(this).val().replace(/-/gi, ''); // 선택한 날짜 (- 제거)
        var eqDate = false; // 동일 날짜 여부 (true: 있음, false: 없음)


        $(".hasDatepicker").each(function (idx) {
            if ($(this).prop('id') != ('datepicker-' + beforeDate) && $(this).val().replace(/-/gi, '') == changeDate) { // 동일한 날짜 선택 여부 확인 (자기자신 제외)
                eqDate = true;
            }

            if (idx == 0 || lastAddedDay < $(this).val().replace(/-/gi, '')) { // 변경 날짜가 lastAddedDay 보다 클 경우 셋팅
                lastAddedDay = $(this).val().replace(/-/gi, '');
            }
        });

        if (eqDate) {
            showAlert("이미 선택하신 발송희망일 입니다.")
            beforeDate = beforeDate.substr(0, 4) + "-" + beforeDate.substr(4, 2) + "-" + beforeDate.substr(6, 2);
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
        if (dpSize != 1) {
            var standardMinDate = $(".hasDatepicker").eq(0).prop('id').replace('datepicker-', '');
            var standardMaxDate = $(".hasDatepicker").eq(dpSize - 1).prop('id').replace('datepicker-', '');
            //2-1. 이벤트 위치 앞 날짜 확인
            if (selectIdx != 0) {
                var standardPreDate = $(".hasDatepicker").eq(selectIdx - 1).prop('id').replace('datepicker-', '');

                if (standardPreDate > changeDate) {
                    standardPreDate = standardPreDate.substr(0, 4) + "-" + standardPreDate.substr(4, 2) + "-" + standardPreDate.substr(6, 2);
                    showAlert(standardPreDate + "이후 날짜를 선택해 주시기 바랍니다.");
                    beforeDate = beforeDate.substr(0, 4) + "-" + beforeDate.substr(4, 2) + "-" + beforeDate.substr(6, 2);
                    $(this).val(beforeDate);
                    return false;
                }
            }
            //2-2. 이벤트 위치 뒤 날짜 확인
            if (selectIdx + 1 != dpSize) {
                var standardNextDate = $(".hasDatepicker").eq(selectIdx + 1).prop('id').replace('datepicker-', '');

                if (standardNextDate < changeDate) {
                    standardNextDate = standardNextDate.substr(0, 4) + "-" + standardNextDate.substr(4, 2) + "-" + standardNextDate.substr(6, 2);
                    showAlert(standardNextDate + "이전 날짜를 선택해 주시기 바랍니다.");
                    beforeDate = beforeDate.substr(0, 4) + "-" + beforeDate.substr(4, 2) + "-" + beforeDate.substr(6, 2);
                    $(this).val(beforeDate);
                    return false;
                }
            }

            if ((changeDate - standardMinDate) > maxDate || (standardMaxDate - changeDate) > maxDate) { // 발송 일자는 최대 7일 까지 가능
                showAlert("발송희망일은 최대 " + maxDate + "일을 초과하실 수 없습니다.<br>발송희망일을 다시 선택해 주시기 바랍니다. ")
                beforeDate = beforeDate.substr(0, 4) + "-" + beforeDate.substr(4, 2) + "-" + beforeDate.substr(6, 2);
                $(this).val(beforeDate);
                return false;
            }
        }

        // ######발송 희망일 7일 초과 선택 불가 로직 END

        if (lastAddedDay < changeDate) { // 변경 날짜가 lastAddedDay 보다 클 경우 셋팅
            lastAddedDay = changeDate;
        }

        // 이전 달력 이벤트 제거
        $("#datepicker-" + beforeDate).datepicker("destroy");
        // 선택한 날짜로 모든 view 갱신
        var topObject = $(this).parent().parent();
        setAttrOptionChange(topObject, beforeDate, changeDate); // 발송 희망일 셋팅
        // 달력 이벤트 적용 
        IbkDatepicker.initDatepicker("datepicker-" + changeDate, "${pageContext.request.contextPath}", 0);
        selectDateTotalCount(changeDate); // 발송 희망일 셋팅
        removePassedTime(); // 현재시간 기준 입력 가능 이벤트 설정
    });

    // 방송 희망일 변경 시 해당 view id, class 날짜 변경 @jys
    function setAttrOptionChange(obj, beforeDate, changeDate) {
        obj.prop("id", obj.prop("id").replace(beforeDate, changeDate));
        obj.prop("class", obj.prop("class").replace(beforeDate, changeDate));

        obj.children().each(function () {
            $(this).prop("id", $(this).prop("id").replace(beforeDate, changeDate));
            $(this).prop("class", $(this).prop("class").replace(beforeDate, changeDate));

            if ($(this).children().length > 0) {
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
        getMsgTextBytes($("#content-textarea"));
    });

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
            } else {
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
        var initTotalCnt = $("#today-total-count-" + day).text().replace(/,/, "");
        // 공백을 parseInt 하게 되면 NaN 이 발생 됩니다. @jisoonchoi
        if (!initTotalCnt) {
            initTotalCnt = 0;
        }
        console.log(parseInt(initTotalCnt) + parseInt(test));
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

    ////마지막 발송 일자로 셋팅( 발송 희망일에서 가장 미래의 시간 택 ) @jys
    function setLastDay() {
        lastAddedDay = 0;
        $(".hasDatepicker").each(function () {
            thisDate = $(this).val().replace(/-/gi, '');
            if (lastAddedDay < thisDate) {
                lastAddedDay = thisDate;
            }
        });
    }


    // 발송 희망일 시간 구간 셋팅 @jys
    var timeList = ["1000", "1030", "1100", "1400", "1430", "1500", "1530", "1600", "1630", "1700"];

    //// 발송 희망일 시간별 건수 조회 @jys
    function selectDateTotalCount(date) {
        $.ajax({
            url: '${pageContext.request.contextPath}/smsreq/totalcnt/',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                "date": date
                , "timeList": timeList
            }),
        }).done(function (data) {
//            console.log(data);
            var totalCnt = 0;
            for (var i = 0; i < timeList.length; i++) {
                $("#" + date + "-" + timeList[i]).text($.number(data["TOTAL_TIME_" + timeList[i]]));
                totalCnt = totalCnt + data["TOTAL_TIME_" + timeList[i]];
            }

            $("#today-total-count-" + date).text($.number(totalCnt));
            $("#added-count-" + date).text($.number(totalCnt));

        }).fail(function (xhr) {
            showAlert("요청 중 오류가 발생 하였습니다.\n\n(selectDateTotalCount())");
        });
    }


    //// 전화번호 형식 입력 @jys
    function inputPhoneType(obj) {
        var inputVal = obj.val();
        obj.val(inputVal.replace(/[^0-9-]/gi, ''));
//    var regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
//    alert(regExp.test(inputVal));
    };


    ////결재 올리기, 임시저장 벨리데이션 @jys
    // type : null (결재올리기), temp (임시저장)
    function checkSaveValidation(type) {

        // 기안명 확인 
        if (type == null || type == "temp") {
            if ($("#request-title").val() == null || $("#request-title").val().replace(/ /gi, "") == "") {
                $("#request-title").focus();
                showAlert("기안명을 확인해 주세요.");
                return false;
            }
        }

        // 예상발송건수 확인
        if (type == null) {
            if ($("#expect-count").val() == null || $("#expect-count").val().replace(/ /gi, "") == "") {
                $("#expect-count").focus();
                showAlert("예상발송건수를 확인해 주세요.");
                return false;
            }
        }

        // 대상자 업로드 시 예상발송건수와 대상자 정상건수 불일치 체크
        if (type == null) {
            if ($("#file-name-input").val() != null && $("#file-name-input").val() != "") {
                var cntTarget = $(".total .blue").text().replace(/,/g, "");
                var cntExpect = $("#expect-count").val().replace(/,/g, "");
                if (cntTarget != cntExpect) {
                    $("#expect-count").focus();
                    showAlert("예상발송건수와 대상자 정상건수가 같지 않습니다.<br>예상발송건수를 확인해 주세요.");
                    return false;
                }
            }
        }

        var remainCnt = $("#remain-count").text().replace(/,/g, '')
        
        if ( remainCnt != 0 ) {
            $("#total-count").focus();
            showAlert("예상발송건수와 발송 희망일 건수가 같지 않습니다.<br>발송 희망일 건수를 확인해 주세요.");
            return false;
        }
        
        // 메세지 제목 및 내용 확인
        if (type == null) {
            var msgType = $("#msg-type").val();

            if (msgType == "lms" || msgType == "mms") {
                if ($("#msg-title").val() == null /* || $("#msg-title").val().replace(/ /gi, "") == "" */) {
                    $("#msg-title").focus();
                    showAlert("메세지 제목을 확인해 주세요.");
                    return false;
                }
            }

            if ($("#content-textarea").val() == null /* || $("#content-textarea").val().replace(/ /gi, "") == "" */) {
                $("#content-textarea").focus();
                showAlert("메세지 내용을 확인해 주세요.");
                return false;
            }
        }

        // 발신번호 확인
        if (type == null) {
            if ($("#send-phonenum").val() == null || $("#send-phonenum").val().replace(/ /gi, "") == "") {
                $("#send-phonenum").focus();
                showAlert("발신번호를 확인해 주세요.");
                return false;
            }
        }

        // 예산합의서명 확인
// 	  if(type == null){
// 		if($('#tr_confirm-doc-name').is(":visible")){
//             if($('#confirm-doc-name').val() == null || $('#confirm-doc-name').val() == ''){
//               $('#confirm-doc-name').focus();
//               showAlert('예산합의서명을 입력해 주시기 바랍니다.');
//               return false;
//             }
//        	}
// 	  }

        // 심의필 번호 확인
//    if(type == null){
//        var mkType = $("input[name=request-type]:checked").val();

//        if(mkType == "marketing"){
//            if($("#validation-num").val() == null || $("#validation-num").val().replace(/ /gi, "") == ""){
//                $("#validation-num").focus();
//                showAlert("심의필번호를 확인해 주세요.");
//                return false;
//            }
//        }
//    }

        //MMS 일 경우 이미지 파일 업로드 확인
        if ($("#msg-type").val() == 'mms') {
            if ($("#image-fileupload-input1").val() == '' && $("#image-fileupload-input2").val() == '' && $("#image-fileupload-input3").val() == '') {
                $("#image-fileupload-input1").focus();
                showAlert("MMS 발송 이미지 파일을 확인해 주세요.<br><br>* 이미지가 없을 경우 LMS로 발송해 주시기 바랍니다.");
                return false;
            }
        }

        if (type == null) {
            // 발송 희망일 건수 확인
            if (!validSendCount()) {
                $("#dispatch-body").focus();
                showAlert("발송 희망일의 발송 건수를 확인해 주세요");
                return false;
            }
            // 결재선 지정
//           if($(".confirm-emp-id").length < 1){
//               $("#articleTarget").focus();
//               showAlert("결재선을 지정해 주세요.");
//               return false;
//           }

            // CLASS 1~4 승인자가 등록되었는지 확인
//           var ok = true;
//           $(".article").each(function (){
//             var type = 1;
//             if($(this).prop("id") == "a1"){
//                 type = 1;   
//             }else if($(this).prop("id") == "a2"){
//                 type = 2;
//             }else if($(this).prop("id") == "a3"){
//                 type = 3;
//             }

//             if(type == 1){
//             	var supervisor=false;
//                 $(this).find(".confirm-emp-class").each(function (index) {

//                 	if($(this).val() != 1 && $(this).val() != 2 && $(this).val() != 3 && $(this).val() != 4  && $(this).val() != 5){
//                         $("#articleTarget").focus();
//                         showAlert("결재선을 확인해 주세요.<br>(EMPL_CLASS 값이 1~5가 아닌 정보가 있습니다.)");
//                         ok = false;
//                         return false;
//                     }

//                     if($(this).val() >= 3){
//                     	supervisor=true;
//                     }
//                 });

//                 if(!ok){return false;}

//                 if(!supervisor){
//                     $("#articleTarget").focus();
//                     showAlert("결재선은 최소 팀장급 1명이 포함되어야합니다.<br>결재선을 확인해 주세요.");
//                     ok = false;
//                     return false;
//                 }
//             }
//           });

//           if(!ok){return false;}
        }

        return true;
    }


    // 저장 완료 시 리스트 페이지로 이동 @jys
    function moveSaveOk() {
        window.location.href = "${pageContext.request.contextPath}/smssendlist.ibk";
    }


    ////등록된 파일 제거
    function remove_uploadFile(fileType) {
        if (fileType == "Subject") {  // 대상자 파일 제거
            $("#file-name-input").val("");
            $("#real-file-name-input").val("del");

            $("#delete-fileupload-btn").hide();
        } else if (fileType == "Img1") {   // 이미지 파일1 제거
            $("#selectSEQ1").val("");
            $("#select_selectSEQ1").children().remove();
        	app.tmpl_select.selectSEQ1 = "";

            $("#delete-selectSEQ1").hide();
        } else if (fileType == "Img2") {   // 이미지 파일2 제거
        	$("#selectSEQ2").val("");
        	$("#select_selectSEQ2").children().remove();
        	app.tmpl_select.selectSEQ2 = "";
        	
            $("#delete-selectSEQ2").hide();
        } else if (fileType == "Img3") {   // 이미지 파일3 제거
        	$("#selectSEQ3").val("");
        	$("#select_selectSEQ3").children().remove();
        	app.tmpl_select.selectSEQ3 = "";
        	
            $("#delete-selectSEQ3").hide();
        }
    }


    //// 문자내용 byte 계산
    function getMsgTextBytes(obj) {
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
        if (strByteInfo.totalByte > maxByte) {
            showAlert(msgType + "는 " + maxByte + 'byte 까지 입력 가능 합니다.');
            obj.val(msg.substring(0, strByteInfo.ableLength));
            msg = obj.val();
        }
        $("#dis-total-byte").text(parseInt(IbkByteCheck.getBytes(msg)) + getSubVarBytes());
    }

    ////치환변수 Byte 계산
    function getSubVarBytes() {
        var subVarBytes = 0;
        $(".wrap_cbtn .col2 a").each(function () {
            var text = $("#content-textarea").text();

            //치환변수명
            var subVar = $(this).prop("id");

            //사용된 치환변수 갯수 확인
            var checkText = new RegExp("[$]\{+" + subVar + "\}", "g");
            var cntMatch = text.match(checkText);

            if (cntMatch != null) {
                var max = $("." + subVar).val();        //치환변수 최대 값
                var cnt = cntMatch.length;            // 치환변수 사용 갯수

                //치환변수 Byte 더하기
                subVarBytes += (parseInt(max) * cnt);
            }
        });

        return subVarBytes;
    }


    ////예산합의서명 발송 건수 200만원 이상일 경우
    function showConfirmDoc() {
        //### 예산합의서명 발송 건수 200만원 이상일 경우 필수 값으로 체크
        var msgType = $("#msg-type").val().substr(0, 2).toUpperCase();
        var requestsNumber = $("#expect-count").val().replace(/,/g, '');
        if (msgType == "SM") {
            var price = "${KT_SM}";
            price = price == "" ? "9" : price // default
        } else if (msgType == "LM") {
            var price = "${KT_LM}";
            price = price == "" ? "30" : price // default
        } else if (msgType == "MM") {
            var price = "${KT_MM}";
            price = price == "" ? "100" : price // default
        }

        if (price == null || price == "") {
            showAlert("설정된 단가 정보가 없습니다.<br>단가 정보를 확인해 주시기 바랍니다.");
        }

        var sendPrice = (parseFloat(price) * parseFloat(requestsNumber));

        if (sendPrice >= 2000000) {
//             $('#tr_confirm-doc-name').show();
        } else {
//             $('#tr_confirm-doc-name').hide();
        }
    }
    
    

</script>