<%-- 
============================================================================
	 RCS Template 결과별 기능 설명
	 - 해당 UI는 RBC 7월 당시 버전
============================================================================
	1. 상태값 설명
		- 등록 : UMS 등록
		- 저장  : 에이전트과 통신, RCS_MSGBASE 데이터 insert 상태
		- 승인요청 중
		- 승인요청 실패
		- 승인요청 성공
		- 반려, 반려(수정)
		- 승인대기(수정)
		
		※ 저장과 등록 정확한 정의 필요 
			
 	2-1. 저장시 상태값 (자동)
 		- insert 경우  : REQ.status = "저장"
 		- update 경우 : REQ.appr_reason = "", REQ.status = "03", appr_result = "저장" 
 	2-2. 저장시 상태값 (수동)
 		- insert 경우  : REQ.status = "저장", appr_result = "저장"
 	
 	3. 승인요청 (자동)	
 		- apprResult가 "승인요청 실패", "반려", "승인"일 경우
 			> appr_reason = "", REQ.status = "03", appr_result = "저장" 값 셋팅
 			> BASE 테이블에서 조회 될경우 승인 => 승인대기(수정), 반려 => 반려(수정) 으로 값 셋팅	> UPDATE.BASE.APPR_RESULT 업데이트
 	4. 템플릿 수정이 가능한가요?
		템플릿 상태에 따라 아래와 같이 수정/삭제 기능을 제공합니다. 
		- 저장 상태: 템플릿 수정/삭제 가능
		- 승인 완료 상태:  템플릿 수정/삭제 가능 
		- 승인 대기 상태: 템플릿 수정/삭제 불가능 
		
	
============================================================================

 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" type="text/css" href="/static/v2/css/customFontTool.css">
<script type="text/javascript" src="/static/v2/js/ie11CustomProperties.js"></script>
<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	.reg-left {width:20%}
	.reg-right {width:80%; float: right;}
	.daterangepicker {z-index:999999}
</style>

<!-- RCS 템플릿 수정 -->
<div id="popupTemplate" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1 id="title">RCS 템플릿 수정</h1></div>
  <div class="modal-body">
  	<form id="formRcs" name="form">
  		<input type="hidden" id="seq" name="seq">
  		<!-- <input type="hidden" id="status" name="status">  -->
  		<input type="hidden" id="contentCell" name="contentCell" >
  		<input type="hidden" id="rcsBtnInfo" name="rcsBtnInfo" >
  		<input type="hidden" id="apprResult" name="apprResult" >
  		<input type="hidden" id="status" name="status" >
  		
	    <div class="row preview-area clearfix">
	      <div class="preview-left">
	        <div class="template-title">승인완료 (수정)</div>
	        <div class="pdd-right-10 popupTemplateScroll">
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">템플릿ID</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                  <input type="text" class="form-control" id="msgbaseId" name="msgbaseId" placeholder="자동생성" style="pointer-events:none" readonly>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">템플릿 속성</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                  <label class="radio-container">서술(description)
	                    <input type="radio" name="cardType" data-input="div-template-attr-desc" value="description" checked="checked" />
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">스타일(cell)
	                    <input type="radio" name="cardType" data-input="div-template-attr-cell" value="cell" />
	                    <span class="checkmark"></span>
	                  </label>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">유형</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form" >
	                  <select class="width-100" id="cmbBizServiceDesc" name="cmbBizService">
	                    <option>템플릿 유형을 선택하세요</option>
	                  </select>
	                  
	                  <select class="width-100" id="cmbBizServiceCell" name="cmbBizService">
	                  	<option>템플릿 유형을 선택하세요</option>
	                  </select>
	                  <input type="hidden" id="msgbaseFormId" name="msgbaseFormId">
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">브랜드</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form" >
	                  <select class="width-100" id="brId" name="brId">
	                    <option>브랜드를 선택하세요</option>
	                  </select>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">템플릿명</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                  <div class="ele_area remaining" data-input="msgbaseNm" data-count="msgbaseNm_count" data-text-len="30">
	                    <input type="text" class="form-control" id="msgbaseNm" name="msgbaseNm" value="" placeholder="제목을 입력하세요">
	                    <p class="text-right color-gray"><span id="msgbaseNm_count">0</span>/30자</p>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix mrg-top-10 div-template-attr" id="divTemplateAttrDesc">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">
	                <span class="required" >내용</span>
	              </h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="pdd-top-5 pdd-btm-10">
	                변수로 설정하고자 하는 내용을 {{ }} 표시로 작성해주세요.<br/>
	                변수명은 20자 이내의 한글, 영문, 숫자, 언더바만 가능합니다.<br/>
	                (특수문자, 공란, 줄바꿈 사용불가)<br/>
	                ※ {{description}} 변수명은 사용 불가<br/>
	                ※ 서술(description) 템플릿은 본문 내용을 변수 만으로 구성할 수 없습니다. (변수 이외 문장 필수 입력)<br/>
	                <span class="pdd-left-15">예) 이름과 출금일을 변수설정 : {{이름}}, {{date}}</span><br/>
	                *실제 변수의 최대 길이를 고려해 메시지 내용은 90자 이내로 작성 해주세요. (변수명의 길이는 반영되지 않음)<br/>
	                
	              </div>
	              <div class="ele_area">
	              	<!-- 22.09.20 IBK 회의 결과 치환변수는 수기 작성 -->
	              	<!--<div class="search_field inline-form">
						<div class="mrg-right-10">
							
							 <select class="width-100" id="setVar">
								<option value="">치환변수 선택</option>
								<option value="{{고객명}}">{{고객명}}</option>
								<option value="{{변수1}}">{{변수1}}</option>
								<option value="{{변수2}}">{{변수2}}</option>
								<option value="{{변수3}}">{{변수3}}</option>
								<option value="{{변수4}}">{{변수4}}</option>
								<option value="{{변수5}}">{{변수5}}</option>
							</select> 
						</div>
						<p>
							<button type="button" class="btn btn-inner" onclick="changeReplaceVal();">입력</button>
						</p> 
					</div> -->
	                <div class="search_field width-100">
	                  <div class="ele_area remaining" data-input="msgbaseDesc" data-count="msgbaseDesc_count" data-text-len="90">
	                    <textarea rows="3" class="width-100" id="msgbaseDesc" name="msgbaseDesc" placeholder="내용을 입력하세요"></textarea>
	                    <p class="text-right color-gray"><span id="msgbaseDesc_count">0</span>/90자</p>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix mrg-top-10 div-template-attr hide" id="divTemplateAttrCell">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">
	                <span class="required">내용</span>
	              </h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="pdd-top-5 pdd-btm-10">
	                변수로 설정하고자 하는 내용을 {{ }} 표시로 작성해주세요.<br/>
	                변수명은 20자 이내의 한글, 영문, 숫자, 언더바만 가능합니다.<br/>
				  	(특수문자, 공란, 줄바꿈 사용불가)<br/>
	                ※ {{description}} 변수명은 사용 불가<br/>
	                ※ 스타일(Cell)템플릿은 본문 내용에 변수를 한 개 이상 필수로 입력해야 합니다.<br/>
	                <span class="pdd-left-15">예) 이름과 출금일을 변수설정 : {{이름}}, {{date}}</span><br/>
	              </div>
	              <div class="ele_area cell-copy remaining" data-input="msgbaseCell" data-count="msgbaseCell_count" data-text-len="90">
	                <!-- <div class="search_field inline-form">
	                  <span class="cell-group">
	                    <button class="btn-cel one active" data-value="one"></button>
	                    <button class="btn-cel two" data-value="two"></button>
	                  </span>
	                  <div class="mrg-right-10 div-cell-area div-cell-one">
	                    <input class="form-control width-100 mrg-right-10" id="content_1_1" value=""  />
	                  </div>
	                  <div class="mrg-right-10 hide div-cell-area div-cell-two">
	                    <input class="form-control mrg-right-10" value="" />
	                  </div>
	                  <div class="mrg-right-10 hide div-cell-area div-cell-two">
	                    <input class="form-control mrg-right-10" value="" />
	                  </div>
	                  <label class="check-container mrg-top-3">라인
	                    <input type="checkbox" />
	                    <span class="checkmark"></span>
	                  </label>
	                </div> -->
	              </div>
	              <p class="text-right color-gray"><span id="msgbaseCell_count">0</span>/90자</p>
	              <div class="text-right mrg-top-10">
	              	<button type="button" class="btn btn-inner btnDeleteCell" onclick="deleteCell()">Cell 삭제</button>
	                <button type="button" class="btn btn-inner btnAddCell" onclick="addCell()">Cell 추가</button>
	              </div>
	              <div style="visibility: hidden; line-height: 5px;height:0">
	              	<input id="msgbaseCell" name="msgbaseCell" style="height:0">
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix" id="rcsTmpltBtn">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">버튼 노출</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                  <label class="radio-container">미사용
	                    <input type="radio" name="button-display" value="0" data-name="rcsBtn" data-target="rcsTmpltBtn" checked="checked"/>
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">1개
	                    <input type="radio" name="button-display" value="1" data-name="rcsBtn" data-target="rcsTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">2개
	                    <input type="radio" name="button-display" value="2" data-name="rcsBtn" data-target="rcsTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                </div>
	              </div>
	            </div>
	          </div>
	
			<!--  버튼 노출  -->
	          <section id="div-button-display"></section>
	
	          <div class="row clearfix registerInfo">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">등록일</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              2021-08-24 / 홍길동
	            </div>
	          </div>
	          <!--  반려 사유  -->
	          <div class="row clearfix apprReason"></div>
	          <div class="row text-left">
	            <label class="check-container">정보성 메시지만 보낼 수 있으며, 광고 등 정책에 위배되는 메시지 발송 시 템플릿 사용이 중지될 수 있음을 동의합니다.
	              <input type="checkbox" id="checkAgree" name="checkAgree">
	              <span class="checkmark"></span>
	            </label>
	          </div>
	        </div>
	      </div>
	      <div class="preview-right">
	        <div class="div-msg-preview">
	          <div class="div-msg-preview-header">
	            <h2><i class="fa fa-search pdd-right-5"></i> 미리보기</h2>
	          </div>
	          <div class="div-msg-preview-body preview-height">
	            <div class="emulator_area">
	              <div class="emulator_cont">
	                <div class="emulator_view">
	                  <div class="template-openrichcard-linearlayout">
	                    <div class="template-openrichcard-imageview">
	                      <img src="">
	                    </div>
	                    <div class="template-openrichcard-linearlayout" data-id="pContent">
	                      <div class="template-openrichcard-linearlayout template-openrichcard-linearlayout-horizontal">
	                        <div class="template-openrich-textview textStart">
	                          <p class="text" style="white-space:pre-wrap"></p>
	                        </div>
	                        <div class="template-openrich-textview textEnd">
	                          <p class="text">{{예약일시}}</p>
	                        </div>
	                      </div>
	                      <div class="template-openrichcard-hrview"></div>
	                    </div>
	                    
	                  </div>
	                  <div class="template-openrichcard-suggestion">
	                  <!--  id를 data-id 으로 바꿀걸로 변경 -->
	                    <div data-id="previewBtn1" data-name="previewBtn" value=""></div>
	                  </div>
	                  <div class="template-openrichcard-suggestion" >
	                    <div data-id="previewBtn2" data-name="previewBtn" value=""></div>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
  	</form>
  </div>
  <!-- dialog 버튼 -->
  <div class="modal-footer">
    <a href="javascript:;" class="btn btn-border-sub1 popupTemplate_close" >닫기</a>
    <a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="save()">저장</a>
  </div>
</div>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">

	var previewId = 'div[data-id=pContent]';

	/* 스타일(cell) 팔레트 색상 - 변경시 costomFontTool.css도 변경할것 */
	var paletteColors = [ "#404040", "#941527", "#b91724", "#bd462d", "#641432"
	    , "#c0537e", "#ac3f68", "#af6d4c", "#967240", "#583029"
	    , "#816d33", "#69692b", "#004326", "#155a10", "#3b7728"
	    , "#46804c", "#1a8b9e", "#1888c0", "#4483cf", "#0a386c"
	    , "#4d65cb", "#6264bb", "#665ba6", "#764f93", "#4e2d56"
	    , "#86487b", "#b85c9f", "#252525"];
	
	 $(document).ready(function() {
		 rcsFunc.initValid($("#formRcs")); // 유효성 초기셋팅
		 getComboBoxList(); // comboBox 유형 세팅
		 rcsFunc.initDialog(CARD_TYPE.DESC);
	});

	 function getComboBoxList() {
		  $.ajax({
	        url: '${pageContext.request.contextPath}/campaign/rcsTemplate/getComboBoxList',
	        type: "GET",
	        contentType: "application/json; charset=utf-8",
	        data: '',
	        success : function(result) {
				  var bizServiceLabel = '선택하시면 템플릿명 및 내용 입력이 가능합니다';
			      var descHtml = '<option value="">' + bizServiceLabel + '</option>';
			      var cellHtml = '<option value="">' + bizServiceLabel + '</option>';
			      var brandHtml = ''; // <option value="">브랜드를 선택하세요</option>
			      var imageUrl= '/static/images/rcs/';
			      // 서술
			      result.descList.forEach(function(row) {
				      descHtml += '<option value="' + row.MSGBASE_FORM_ID + '" data-media="' + imageUrl + row.MEDIA_URL.split('-').pop() + '">' + row.BIZ_SERVICE + '</option>';
				  });

				  // 스타일(cell)
			      result.cellList.forEach(function(row) {
				      cellHtml += '<option value="' + row.MSGBASE_FORM_ID + '" data-media="' + imageUrl + row.MEDIA_URL.split('-').pop() + '">' + row.BIZ_SERVICE + '</option>';
				  });

				  // 브랜드
				  result.brandList.forEach(function(row) {
					  brandHtml += '<option value="' + row.brId + '">' + row.brNm + '</option>';
					});

			   	  // dialog (등록/수정)
			      $('#cmbBizServiceDesc').html(descHtml);
			      $('#cmbBizServiceCell').html(cellHtml);
			      $('#brId').html(brandHtml);

			      // rcsTemplate-list.jsp(조회)
			      $('#cmbBizServiceDesc1').html(descHtml.replace(bizServiceLabel, '전체'));
			      $('#cmbBizServiceCell1').html(cellHtml.replace(bizServiceLabel, '전체'));
		    	    
		      }, 
		   error : function(e) {
	    	  sweet.alert("RCS 탬플릿 유형 조회 중 오류가 발생하였습니다.");
	    	  console.error(e);
	      }
	    });
	}

	/* 유형 변경시 호출 */
	$('select[name=cmbBizService]').on('change', function(){
		// 유형별 이미지 변경
		var _id = '#' + this.id;
		var _value = this.value;
		
		var _cardType =  $("input[name='cardType']:checked").val(); 
		// RCS Biz Center와 동일하게 적용 - 유형 변경시 초기화
		rcsFunc.initDialog(_cardType);
		
		setTimeout(function () {
			// 유형 값 및 화면 재셋팅
			$(_id).val(_value).prop("selected", true);
	    }, 200);

		// 유형의 이미지 셋팅
		var imageUrl = $(_id + " option[value=" + _value + "]").data('media');
		$('#popupTemplate .template-openrichcard-imageview img').attr('src', imageUrl)
		
		$("input#msgbaseFormId").val(_value);
		changeReadmodeInputTag('popupTemplate', false );
	});

	/* 팝업창 띄우기 전 데이터 셋팅  */
	function setDialog(data) {
		var modeName = '등록';
		
		if(data.title == DAILOG_MODE.UPDATE) {
			// 수졍일 경우
			modeName = '수정';			
			
			$('.template-title').text(data.apprResult +'('+ modeName+')').show();
			$('#apprResult').val(data.apprResult);
			$('#status').val(data.status);
			$('#seq').val(data.seq); // 템플릿 seq

			$('#msgbaseId').val(data.msgbaseId); // 템플릿 ID
			$('#brId option[value="'+ data.brId +'"]').prop('selected', true); // 브랜드ID
			$('#msgbaseNm').val(data.msgbaseNm).keyup(); // 템플릿 명

			$('input[name=cardType][value="'+ data.cardType + '"]').prop("checked", true).click(); // 템플릿 속성

			// 수정/상세 선택한 유형 이미지 셋팅
			$('.template-openrichcard-imageview img').attr("src", data.imageUrl);

			var cmbBizServiceId = '';
			if(data.cardType == CARD_TYPE.DESC) {
				// 서술일 경우
			 	cmbBizServiceId = 'cmbBizServiceDesc';
			 	
				$('#cmbBizServiceCell').hide();

				$('#msgbaseDesc').val(data.msgbaseDesc).keyup();
			} else if(data.cardType == CARD_TYPE.CELL) {
				// 스타일(cell) 경우
				cmbBizServiceId = 'cmbBizServiceCell';
				
				$('#cmbBizServiceDesc').hide();
				$('#cmbBizServiceCell').show();

				$('#divTemplateAttrDesc').hide();
				$('#divTemplateAttrCell').show();

				$('p[data-id=p_content_desc]').hide();
			}

			// 유형 값 셋팅
			$('#' + cmbBizServiceId).val(data.msgbaseFormId);
			$('#msgbaseFormId').val(data.msgbaseFormId);
			// 등록일 셋팅
			$('.registerInfo').html('');
			var html = commonFunc.makeRowHtml('등록일', moment(data.regDt, 'YYYYMMDDHHmmsss').format('YYYY-MM-DD HH:mm'), data.regUserNm, null)
			$('.registerInfo').append(html);
			$('.registerInfo').show();

			//  cell 내용, 버튼노출 셋팅
			var fmtStr = data.formattedString;
			if(!str.isEmpty(fmtStr)) {
				fmtStr = fmtStr.replace(/\r\n/gi,"\\r\\n");
				var fmtJson = JSON.parse(fmtStr)
				if(data.cardType == CARD_TYPE.CELL) {
					setDetailJsonCell(fmtJson)
				}
				rcsFunc.addBtnHtml( fmtJson, DAILOG_MODE.UPDATE);
			}

			// 상태별 사유 값 셋팅
			$('.apprReason').html('');
			if(data.apprReason != null ) {
				var html = commonFunc.makeRowHtml( ( data.apprResult.replace('승인요청', '') || '-' ) + ' 사유', (data.apprReason || '-'), null);
				$('.apprReason').append(html);
				$('.apprReason').show();
			}
		}		

		$(".text_items").hide(); // cell > text_items (= text tools) 숨김
		
		$('#title').html('RCS 템플릿 ' + modeName );

		$('#popupTemplate').popup('show');
	}

	// 스타일(cell) 셀정보 세팅
	function setDetailJsonCell(json) {
		//cell 데이터가져오기 데이터샘플
		//{"RCSMessage":{"trafficType":"advertisement","openrichcardMessage":{"card":"open_rich_card","layout":{"width":"284dp","height":"content","widget":"LinearLayout","children":[{"width":"content","height":"content","widget":"ImageView","mediaUrl":"maapfile://LT-200821105056505-g0Go","paddingTop":"16dp","marginBottom":"8dp"},{"width":"match","height":"content","widget":"LinearLayout","children":[{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell1}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell2}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell3}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell4}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell5}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell6}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell7}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell8}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell9}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell10}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell11}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell12}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell13}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell14}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell15}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell16}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell17}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell18}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell19}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell20}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}}],"orientation":"vertical","paddingBottom":"8dp"}],"background":"#ffffff","orientation":"vertical","paddingLeft":"16dp","paddingRight":"16dp"},"suggestions":[],"zoomAllowed":true}}}
		var twoChildrenArr = json.RCSMessage.openrichcardMessage.layout.children[1].children; //2번 칠드런 가져오기(셀내용이 두번째부터 있어서 처음거는패스)
		var index = 0; //실제 셀 로우

		$('div[data-input=msgbaseCell]').html('')
		var rowCnt = twoChildrenArr.length / 2;
		for(var i = 0; i < rowCnt; i++) {
			addCell()
		}
		
		$('button[name=btnCell_'+ index + ']').removeClass('active');

		for(var i = 0; i < twoChildrenArr.length; i++) {
			
			if(i % 2 == 0) {
				// 짝수일 경우 (cell 데이터 셋팅)
				var threeChildrenArr = twoChildrenArr[i].children;
				if(threeChildrenArr != undefined) {
					index = index + 1;
	 				//셀 세팅
	 				setCellStyle(threeChildrenArr[0], index, 1);

	 				if(threeChildrenArr[1] != null ) {
		 				// 2단일 경우
	 					setCellStyle(threeChildrenArr[1], index, 2);
	 				} 
	 			}
			} else {
				// 홀수일 경우  (라인 존재여부 셋팅)
				var visibilityObj = twoChildrenArr[i].visibility;

				if(visibilityObj == "visible") {
					//라인이 존재할 경우
					$("#line_" + index).prop("checked", true);
				} 
				clickLine($("#line_" + index).attr('id'));
			}
		}
	}

	function setCellStyle(dataArr, index, idNum){
		$('button[id=btnCell_'+ index + '_' + idNum + ']').click()
			
		//셀 데이터 값 셋팅
		$("#content_" + index + "_" + idNum).val(dataArr.text).keyup();
		$('p[data-id=p_content_cell_' + index + "_" + idNum +']').val(dataArr.text);
		
		// 스타일(cell) 셋팅
		$("input[name='content_"+ index +"_" + idNum + "_size']:input[value='"+ dataArr.textSize +"']").prop("checked", true)
		if(dataArr.textStyle != null && dataArr.textStyle =="bold") {
			$("#content_"+ index +"_" + idNum + "_bold").prop("checked", true) 
			$("input[name='content_" + index +"_" + idNum + "_bold']").val(dataArr.textStyle);
		}
		$("input[name=content_"+ index +"_" + idNum + "_align]:input[value='"+ dataArr.textAlignment +"']").prop("checked", true)
		
		// 미리보기 클래스명 순서 : text textStart text-size-14dp bold
		var className = 'template-openrich-textview ' + dataArr.textAlignment + ' text-size-' + dataArr.textSize + ' ' +  ( dataArr.textStyle || '');
		$('p[data-id=p_content_cell_' + index + "_" + idNum +']').parent().removeClass().addClass(className);
		
		// 셀 색상 세팅 
		setFontColor(index, idNum, dataArr.textColor);
	}

		
	 /* 저장 */
	 function save() {
		  var isValid = $( "#formRcs" ).valid();

			// 유효성체크
			if(!isValid) {
				$("div[id $= -error]").css('visibility', 'visible'); 
				
				sweet.alert("RCS 템플릿 등록에서 체크리스트를 확인하세요");
				return false;
			} else {
				$("div[id $= -error]").css('visibility', 'hidden');
			}

			/* 버튼 노출 정보 JSON 형태로 셋팅 */
			var btnInfoJson = {};
			$('input[id^=rcsBtn]:not(:hidden), textarea[id^=rcsBtn]:not(:hidden)').each(function(i, item){
				var strArr = item.id.split('_'); // ex ) rcsBtn_rcsTmpltBtn1_4
				btnInfoJson[item.id] = item.value;
				if( strArr[0] == "rcsBtnNm") {
					// select(버튼 액션) 선택 값 추가
					var btnValue = $('#' + item.id).parent().parent().find('select').val();
					btnInfoJson['rcsBtnAction_' + strArr[1]] = btnValue;
				}				
			});
			$('#rcsBtnInfo').val(JSON.stringify(btnInfoJson));

			/* 스타일(cell) param json 형태로 셋팅 */
			var contentCellJson = {};
			// 1) cell row count
			contentCellJson['cellCount'] = $('input[id^=line]').length;
			// 2) line 체크여부 */
			$('input[id^=line]').each(function ( i, item){
				contentCellJson[item.id] = item.checked;
			});
			// 3) 셀 갯수 btn_cell button value*/
			$('button[name^=btnCell]').each(function(i, item){
				if($(item).hasClass('active')) {
					contentCellJson[item.name] = item.value;
				}
				
			});
			/* 4) 내용, 글자 스타일 값 */
			var contentArr = $("#formRcs input[name^=content]").serializeArray();
			for(var i=0; i < contentArr.length; i++) {
				contentCellJson[contentArr[i].name] = contentArr[i].value;
			}

			$('#contentCell').val(JSON.stringify(contentCellJson));

			$.ajax({
		        url: '${pageContext.request.contextPath}/campaign/rcsTemplate/save',
		        type: "POST",
		        data: $("#formRcs").serialize(),
		        dataType: 'JSON'
		      }).done(function(result) {
		    	  
		    	  $('#popupTemplate').popup("hide");
		    	  commonFunc.search();
		    	  sweet.alert("저장이 완료되었습니다.");
		          
		      }).fail(function(xhr) {
		      	sweet.alert(" RCS 템플릿 저장 중 오류가 발생하였습니다.");
		      });
	  }

	 /* 템플릿 속성 변경시 호출 */
	 $("input[name='cardType']:radio").change(function () {
	 	var cardType = this.value;
	 	var previous = cardType == CARD_TYPE.DESC ? CARD_TYPE.CELL : CARD_TYPE.DESC;
	
		sweet.confirm('템플릿 속성 변경 안내', '입력한 데이터가 초기화 됩니다. 템플릿 속성을 변경하시겠습니까??', 'result',  function(isConfirm) {
			
			if(isConfirm) {
				// dialog 전체 초기화 후 선택한 cardType으로 화면 셋팅
				rcsFunc.initDialog(cardType);

				changeReadmodeInputTag('popupTemplate', true)
				
			} else {
				// 닫기일 경우 radio 값 유지
				cardType = previous;
			}

			rcsFunc.initValid($('formRcs'));// 템플릿 속성 확인 후 서술내용, 스타일 내용 둘중 validation 재 설정
			$("input:radio[name ='cardType']:input[value='"+ cardType +"']").prop('checked', true);
		 });
	 
	  });

	 /* 서술 - 치환 변수 선택시 호출*/
	 function changeReplaceVal() {
		var replaceVal = $("#setVar").val();
		var $targetId = $("#msgbaseDesc");
		
		if(!str.isEmpty(replaceVal)) {
			$targetId.val($targetId.val() + replaceVal);
		}
		$targetId.trigger("keyup");
		
	}

	/* 스타일 라인 선택시 호출 */
	function clickLine(targetId) {
		$pTargetId = $('div[data-id=' + targetId + ']'); 
		if ( $('#' + targetId).is(':checked') == true ) {
			$pTargetId.show();
		} else {
			$pTargetId.hide();
		}
	}

	/* 스타일 입력 행 1개 추가 - 입력, 미리보기, 버튼 */
	function addCell() {
		var $cellEl = $('div[data-input=msgbaseCell]').find('.search_field.inline-form');
		var cellIdx = $cellEl.length;

		var html =  '<div class="search_field inline-form  pdd-top-10">'; // cellIdx는 무조건 0부터 시작함
		if(cellIdx == 0) {
			html =  '<div class="search_field inline-form">';
		} 
		    html += '      <span class="cell-group">';
 		    html += '        <button type="button" name="btnCell_' + ( cellIdx + 1 )  + '" id="btnCell_' + ( cellIdx + 1 )  + '_1" class="btn-cel one" data-value="one" value="1"></button>';
		    html += '        <button type="button" name="btnCell_' + ( cellIdx + 1 )  + '" id="btnCell_' + ( cellIdx + 1 )  + '_2" class="btn-cel two active" data-value="two" value="2"></button>'; 
		    html += '      </span>';
		    
		    html += '      <div class="mrg-right-10 div-cell-area">';
		    html += '        <input class="form-control mrg-right-10" value="" id="content_'+ (cellIdx + 1) +'_1" name="content_'+ (cellIdx + 1) +'_1" value="" autocomplete="off"/>';
		    html +=  makeTextItems((cellIdx + 1), 1);
		    html += '      </div>';
		    
		    html += '      <div class="mrg-right-10 div-cell-area">';
		    html += '        <input class="form-control mrg-right-10" value="" id="content_'+ (cellIdx + 1) +'_2" name="content_'+ (cellIdx + 1) +'_2" value="" autocomplete="off"/>';
		    html +=  makeTextItems((cellIdx + 1), 2);
		    html += '      </div>';
		    
		    html += '      <label class="check-container mrg-top-3">라인';
		    html += '        <input type="checkbox" id="line_'+ (cellIdx + 1) +'" onclick="clickLine(this.id)"/>';
		    html += '        <span class="checkmark"></span>';
		    html += '      </label>';
		    
		    html += '</div>';

		$('div[data-input=msgbaseCell]').append(html);

		// 미리 보기 추가
		makePreviewCell(cellIdx);

		// 셀 추가 버튼
		showBtnCell(cellIdx + 1);
	}

	/* 스타일 입력 행 삭제 */
	function deleteCell() {
		var $cellEl = $('div[data-input=msgbaseCell]').find('.search_field.inline-form');
		var cellCnt = $cellEl.length;

		if(cellCnt != 0 ) {
			// 마지막 셀 삭제
			$cellEl.eq(cellCnt - 1).remove();
			// (미리보기) 마지막 셀 삭제
			$('p[data-id^=p_content_cell_'+ cellCnt + ']').remove();
			$('div[data-id^=line_' + cellCnt+ ']').hide();
		}
		// 셀 내용 변경
		changeContentCell();

		showBtnCell(cellCnt - 1);	// 셀 추가/삭제 버튼 출력
	}

	/* 셀 추가/삭제 버튼 보여주는 컨트롤 함수  */
	function showBtnCell(cellCnt) {
		$('.btnAddCell').show();
		$('.btnDeleteCell').show();
		
		switch(cellCnt) {
			case 1:
				$('.btnDeleteCell').hide();
				break;
			case 10:
				$('.btnAddCell').hide();
				break;
			default :
				break;
		}
	}
	
	/* 스타일 content 글자 아이템(굵기,정렬,크기,색상) html */
	function makeTextItems(index, count) {
		//var count = btnCell == 'one' ?  1 : 2;
		var idName = 'content_' +  + index +'_'+ count;
		var html = '';
			// 글자 스타일 - 굵기
		    html += '        <div class="text_items">';
			html += '			<span class="custom_checkbox bold">';
			html += '				<input type="checkbox" id="'+ idName +'_bold">';
			html += '				<label for="'+ idName +'_bold">가</label>';
			html += '				<input type="hidden" name="'+ idName +'_bold" >';
			html += '			</span>';
			// 글자 스타일 - 정렬
			html += '			<span class="custom_radio alignL">';
			html += '				<input type="radio" name="'+ idName +'_align" id="'+ idName +'_alignL" class="fas fa-align-left" value="textStart" ' + (count == 1? 'checked':'') + '> ';
			html += '				<label for="'+ idName +'_alignL"></label>';
			html += '			</span>';
			html += '			<span class="custom_radio alignR">';
			html += '				<input type="radio" name="'+ idName +'_align" id="'+ idName +'_alignR" class="fas fa-align-right" value="textEnd" ' + (count == 2? 'checked':'') + '>';
			html += '				<label for="'+ idName +'_alignR"></label>';
			html += '			</span>';
			// 글자 스타일 - 사이즈
			html += '			<div class="box_radio_size">';
			html += '				<span class="custom_radio sml">';
			html += '					<input type="radio" name="'+ idName +'_size" id="'+ idName +'_size01" value="14dp" checked>';
			html += '					<label for="'+ idName +'_size01">가</label>';
			html += '				</span>';
			html += '				<span class="custom_radio mid">';
			html += '					<input type="radio" name="'+ idName +'_size" id="'+ idName +'_size02" value="16dp">';
			html += '					<label for="'+ idName +'_size02">가</label>';
			html += '				</span>';
			html += '				<span class="custom_radio big">';
			html += '					<input type="radio" name="'+ idName +'_size" id="'+ idName +'_size03" value="18dp">';
			html += '					<label for="'+ idName +'_size03">가</label>';
			html += '				</span>';
			html += '			</div>';
			// 글자 스타일 - color
			html += '			<div class="box_palette" id="'+ idName +'_color">';
			html += '				<span class="btn_color cursor-pointer list00">가</span>';
			html += '			</div>	';
			html += '			<input type="hidden" name="'+ idName +'_color" value="#404040">	';
			html += '		</div>';
		      
		return html;
	}
		
	 /* 서술 미리보기 content 생성 */
	function makePreviewDesc() {
		 var html  = '<div class="template-openrichcard-linearlayout template-openrichcard-linearlayout-horizontal">';
		 	 html += '	<div class="template-openrich-textview textStart">';
		 	 html += '		<p class="text " data-id="p_content_desc" style="white-space:pre-wrap"></p>';
	 	 	 html += '	</div>';
	 	 	 html += '</div>';
	 	 $(previewId).append(html);
	}
	
	 /* 스타일 미리보기 content 생성 */
	function makePreviewCell(index) {
		 var html  = '<div class="template-openrichcard-linearlayout template-openrichcard-linearlayout-horizontal">';
			 html += '	<div class="template-openrich-textview textStart text-size-14dp">';
			 html += '		<p class="text" data-id="p_content_cell_'+ (index +1) + '_1"></p>';
			 html += '	</div>';
			 html += '	<div class="template-openrich-textview textEnd text-size-14dp">';
			 html += '		<p class="text" data-id="p_content_cell_'+ (index +1) + '_2"></p>';
			 html += '	</div>';
		 	 html += '</div>';
		 	 html += '<div class="template-openrichcard-hrview hide" data-id="line_' + (index +1) + '"></div>'; // line
		$(previewId).append(html);
	 }

	 /** 
	 * 글자 색상 팔레트 
	 */
	 $('body').on('click', function(e) {
		 if(e.target.id.indexOf('content') == 0 && e.target.className.indexOf('form-control') == 0) {
			/* 스타일 content 셀 선택시 호출*/
			$('.text_items').hide(); // 글자 아이템(굵기,정렬,크기,색상) 모두 숨김 
			$(e.target).next().show(); // 해당 글자 아이템(굵기,정렬,크기,색상)만 보여줌
		} else if(e.target.id.indexOf('btnCell') == 0) {
			var targetVal = e.target.dataset.value;
			var otherVal = ( targetVal == 'one' ) ? 'two' : 'one';
			// btn-cel 버튼 활성화/비활성화 
			$(e.target).addClass('active');
			$(e.target.parentElement).find('.' + otherVal).removeClass('active')

			var $divCell = $(e.target.parentElement.parentElement);
			var index = $divCell.find('input')[0].id.split('_')[1];
			var pContentArr = $('p[data-id^=p_content_cell_'+ index +']');
			var contentArr = $divCell.find('.div-cell-area');
			
			if(targetVal == 'one') {
				// content 변경
				var contentEl = $(contentArr[1]).find('input[name^=content]')[0];
				$(contentEl).val('')
				$(contentArr[1]).hide();
				// 미리보기 변경 
				$(pContentArr[1]).text('');
				$(pContentArr[1]).parent().hide();
			} else {
				//content 변경
				$(contentArr[1]).show();
				//미리보기 변경
				$(pContentArr[1]).parent().show();
			}
		} else if( e.target.nodeName =='LABEL' || e.target.className =='text_items' 
			 	|| e.target.id.indexOf('align') > 0 || e.target.id.indexOf('bold') > 0 || e.target.id.indexOf('size') > 0 || e.target.className.indexOf('color') > 0 ) {
			 
			 return;
		 } else {
			$(".text_items").hide();
			$('.palette').remove();
		}
	});

	 
	/**
	* 스타일 미리보기
	* 1, 내용, 버튼명 입력할 때 keyup으로 변경 감지 )
	 */
	$('body').on('keyup paste', function(e){
		var targetId = e.target.id;
		
		if(targetId =='msgbaseDesc') {
			// (keyup 1) [미리보기] 서술 입력
			$(".template-openrich-textview.textStart .text").html($('#' + targetId).val())
		} else if (targetId.indexOf('content') == 0 ){
			// (keyup 2) [미리보기] 스타일 입력
			var targetSplit = targetId.split('_');
			$('p[data-id=p_content_cell_' + targetSplit[1] + '_' + targetSplit[2] + ']' ).text(e.target.value); // 미리보기 cell 입력값 셋팅

			changeContentCell(); // 셀 내용 및 갯수 셋팅
			
		} else if(targetId.indexOf('rcsBtnNm') == 0) {
			//(keyup 2) [미리보기] 버튼 노출 내용 입력
			$('div[data-id=previewBtn'+ targetId.slice(-1) +']').parent().show();
			$('div[data-id=previewBtn'+ targetId.slice(-1) +']').text(e.target.value);
		}
	});

	 /* 셀 내용 변경시 내용과 갯수 값 셋팅 */
	function changeContentCell() {
		var value = '';
		$('#popupTemplate .div-cell-area .form-control').each( function(i,item) {
			// 스타일( cell ) 작성 내요 모두 가져오기
			value  += item.value;
		 });
		$('input[id=msgbaseCell]').val(value).keyup();
		var valLen = removeReplaceValue(value).length;
		$('#msgbaseCell_count').text(  ); // 입력 갯수 값 셋팅
	}
		
	/**
	* 2. 버튼 라디오, selectbox change 변경 감지 
	*/
	 $('body').on('change', function(e){
		if( e.target.dataset.name == 'rcsBtn') {
			// (미리보기) 버튼 노출 라디오 선택한 갯수만큼 출력
			$targetPrent = $('#popupTemplate div[data-name=previewBtn]').parent();
			$( $targetPrent[ Number(e.target.value)] ).hide();
			 //$('div[data-id=previewBtn'+ (Number(e.target.value) + 1) +']').text('');
			// $('div[data-name=previewBtn]').text('');
			
		} else if(e.target.localName =='select' && e.target.className != 'hourselect' && e.target.className != 'minuteselect' && (e.target.id == null ||  (e.target.id != null && e.target.id.length == 0) ) ) {
			// (미리보기) 버튼 액션 selectbox 선택시 해당 버튼명 내용 삭제  
			var btnNmId = $(e.target).parent().parent().find('input[id^=rcsBtnNm]').attr('id');
			$('#popupTemplate div[data-id=previewBtn'+ btnNmId.substr(-1) +']').text('');
		}
	});


	// 셀 색상 세팅
	function setFontColor(index, cellIndex, color) {
		var btnColorEl = $("#content_"+ index +"_" + cellIndex + "_color").children()[0];
		
		var colorIndex = paletteColors.indexOf(color);
		var colorClass = (colorIndex < 10 ? 'list0' : 'list' ) + colorIndex;
		// class 형식 btn_color cursor-pointer list00 : text-item 글씨("가") 색상 밑줄 색 변경을 위함.
		$(btnColorEl).removeClass().addClass( 'btn_color cursor-pointer ' + colorClass);

		// 미리보기 셀 색상 변경
		$('p[data-id=p_content_cell_' + index + '_' + cellIndex + ']').css('color', color);

		//form data
		$("input[name='content_" + index +"_" + cellIndex + "_color']").val(color);
	}

	$('body').on('mouseup', function(e) {
		if( $("input[name=cardType]:checked").val() != CARD_TYPE.CELL ) return;
		
		/* 글자 색상 선택 */
		if(e.target.attributes.for != null && e.target.attributes.for.value.indexOf('list') == 0 && $('.palette').parent().attr("class") == 'box_palette') {
			var parentIdArr = $('.palette').parent()[0].id.split('_');
			var color = e.target.dataset.color;
			setFontColor(parentIdArr[1], parentIdArr[2], color)	
		}

		if(e.target.className.indexOf('btn_color') != -1) {
			$('.palette').remove();
			// palette 생성
			var html = "<div class='palette'> <ul>";
			for (var i = 0; i < paletteColors.length; i++) {
				var idName = 'list' + i;
				if(i < 10) {
					idName = 'list0' + i;
				}
				html += "<li><span class='custom_radio palette "+ idName + "'><input type='radio' name='palette' id='"+ idName +"' value='" + paletteColors[i] + "' ><label for='" + idName +"' data-color='" + paletteColors[i] + "'>" + paletteColors[i] +"</label></span></li>";
			}
			
			html += "</ul></div>"
			
			$(e.target.parentElement).append(html)
		}

		var parentElement = e.target.parentElement.parentElement.parentElement;
		if(parentElement == null || (parentElement != null && $(parentElement).find('input')[0] == null) ) return; 
		
		
		var contentId = $( parentElement ).find('input')[0].id;// ex) content_1_1
		var parentClassName = e.target.parentElement.className;
		switch(parentClassName) {
			/* 글자 굵기 */
			case 'custom_checkbox bold':
				var target = $(e.target.parentElement).find('input').not('input[type=hidden]')[0]; //e.target(label) control 하는 input 태그
				var styleValue = ( !target.checked == true ) ? 'bold' : '';
				changePreviewStyle(contentId, -1, styleValue);
				$('input[name=' + target.id + ']').val(styleValue);
				break;
			/* 글자 정렬 */ 
			case 'custom_radio alignL':
				changePreviewStyle(contentId, 1, 'textStart');
				break;
			case 'custom_radio alignR':
				 changePreviewStyle(contentId, 1, 'textEnd');
				break;
			/* 글자 크기 */
			case 'custom_radio sml':
				changePreviewStyle(contentId, 2, 'text-size-14dp');
				break;	
			case 'custom_radio mid' :
				changePreviewStyle(contentId, 2, 'text-size-16dp');
				break;	
			case 'custom_radio big':
				changePreviewStyle(contentId, 2, 'text-size-18dp');
				break;	
			default :
				break;	
		}
		
	});

	/* 미리보기 스타일 변경 (정렬, 크기, 굵기) */
	function changePreviewStyle(targetId, index, className ) {
		 // 미리보기 클래스명 순서 : text textStart(정렬) text-size-14dp(크기) bold(굵기)
		var pTargetId = 'p_content_cell_' + targetId.split('_')[1] + '_' + targetId.split('_')[2];
		
		var $pStyleClass = $('p[data-id=' + pTargetId + ']').parent();
		
		var styleArr = $pStyleClass.attr('class').split(' ');
		if(index > 0) {
			// 정렬, 크기일 경우
			styleArr[index] = className;
		} else {
			// 굵기 경우 
			if(className.length > 0) {
				// style class 추가
				styleArr.push(className)
			} else {
				// 마지막 값 굵기 삭제
				styleArr.pop();
			}
		}
		$pStyleClass.removeClass().addClass( styleArr.join(' ') );
	}
	  

</script>
<!-- // 현재 페이지에 필요한 js -->

