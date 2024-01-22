<%-- 
============================================================================
알림톡 (수동)
============================================================================
	* sndPropkey 발급키 :
	* bizCd : 수기로 작성 (22.12.14 IBK 회의에서 확인)
	* bizTmplCd : 수기로 작성 (22.12.14 IBK 회의에서 확인)
			
	1. 버튼타입 : 웹링크(WL),  앱링크(AL)로 구분
		a. 웹링크(WL) 
			- Mobile (필수 O ), Web( 필수 X )
		b 앱링크(AL) : Mobile, Android, IOS 중 2가지 이상 입력 가능
			- url 작성 형식은 "http://", "스킴이름://" 두가지로 구분
			- Mobile, PC : http:// 형식 타입  
			- Android IOS: 스킴이름:// 형식 타입 
			
============================================================================

 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	.template-richcard-descriptionview .text {white-space:pre-wrap;word-break: break-all;max-height: 380px;}
	.inline-form > div {line-height:18px;}

</style>
<!-- 알림톡 템플릿 상세 -->
<div id="popupAlimTalk" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1>알림톡 템플릿 수정</h1></div>
  <div class="modal-body">
  	<form id="formAlimTalk">
  		<!--  MTS 알림톡 사용할 경우 기본값 셋팅  -->
  		<input type="hidden" id="sndPropkey" name="sndPropkey" >
  		<input type="hidden" id="mode" name="mode">
  		<input type="hidden" id="btnInfo" name="btnInfo" >
  		<input type="hidden" id="resndYn" name="resndYn" >
  		<input type="hidden" id="apprResult" name="apprResult" >
  		
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
	                  <!-- <input type="text" class="form-control" id="kkoTmplCd" name="kkoTmplCd" placeholder="탬플릿ID를 입력하세요" >  -->
	                  <div class="ele_area remaining" data-input="kkoTmplCd" data-count="kkoTmplCd_count" data-text-len="30">
		                <input type="text" class="form-control" id="kkoTmplCd" name="kkoTmplCd" value="" placeholder="탬플릿ID을 입력하세요" />
		                <p class="text-right color-gray"><span id="kkoTmplCd_count">0</span>/30자</p>
		              </div>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">업무코드</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area remaining" data-input="bizCd" data-count="bizCd_count" data-text-len="10">
	                <input type="text" class="form-control" id="bizCd" name="bizCd" value="" placeholder="업무코드를 입력하세요" />
	                <p class="text-right color-gray"><span id="bizCd_count">0</span>/10자</p>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">탬플릿코드</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area remaining" data-input="bizTmplCd" data-count="bizTmplCd_count" data-text-len="30">
	                <input type="text" class="form-control" id="bizTmplCd" name="bizTmplCd" value="" placeholder="템플릿 코드를 입력하세요" />
	                <p class="text-right color-gray"><span id="bizTmplCd_count">0</span>/10자</p>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">템플릿명</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area remaining" data-input="tmplNm" data-count="tmplNm_count" data-text-len="30">
	                <input type="text" class="form-control" id="tmplNm" name="tmplNm" value="" placeholder="템플릿명을 입력하세요" />
	                <p class="text-right color-gray"><span id="tmplNm_count">0</span>/30자</p>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">내용</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area remaining" data-input="tmplMsg" data-count="tmplMsg_count" data-text-len="1000">
	                <textarea rows="5" class="width-100" id="tmplMsg" name="tmplMsg" placeholder="내용을 입력하세요"></textarea>
	                <p class="text-right color-gray"><span id="tmplMsg_count">0</span>/1000자</p>
	              </div>
	            </div>
	          </div>
	          <div class="row clearfix" id="alimTmpltBtn">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">버튼 노출</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                  <label class="radio-container">미사용
	                    <input type="radio" name="alimTalk-button-display" value="0" data-name="rcsBtn" data-target="alimTmpltBtn" checked="checked" />
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">1개
	                    <input type="radio" name="alimTalk-button-display" value="1" data-name="rcsBtn" data-target="alimTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">2개
	                    <input type="radio" name="alimTalk-button-display" value="2" data-name="rcsBtn" data-target="alimTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">3개
	                    <input type="radio" name="alimTalk-button-display" value="3" data-name="rcsBtn" data-target="alimTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">4개
	                    <input type="radio" name="alimTalk-button-display" value="4" data-name="rcsBtn" data-target="alimTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                  <label class="radio-container">5개
	                    <input type="radio" name="alimTalk-button-display" value="5" data-name="rcsBtn" data-target="alimTmpltBtn"/>
	                    <span class="checkmark"></span>
	                  </label>
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <!-- <div class="row clearfix button-display mrg-top-10">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4 pdd-left-25 font-weight-light font-size-12">버튼1</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area clearfix">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width150">
	                    <select class="width-100" >
	                      <option value="">버튼 타입</option>
	                      <option value="web">웹링크</option>
	                      <option value="app">앱링크</option>
	                    </select>
	                  </p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="버튼명을 입력하세요"  />
	                  </div>
	                </div>
	              </div>
	              <div class="row ele_area">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width60 pdd-top-5">Mobile</p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="모바일 웹링크를 입력하세요"  />
	                  </div>
	                </div>
	              </div>
	              <div class="row ele_area">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width60 pdd-top-5">PC</p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="PC 웹링크를 입력하세요"  />
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div> 
	
	          -->
	
	          <div class="row clearfix registerInfo">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">등록일</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              2021-08-24 / 홍길동
	            </div>
	          </div>
	          
	          <div class="row clearfix activeYnDiv">
			  	<div class="preview-form-left">
	              <h3 class="pdd-top-4">사용여부</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              
	              <select class="width-50 valid"  id="activeYn" name="activeYn">
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				  </select>
	            </div>
			  </div>
			  
	          <div class="row text-left">
	            <label class="check-container">정보성 메시지만 보낼 수 있으며, 광고 등 정책에 위배되는 메시지 발송 시 템플릿 사용이 중지될 수 있음을 동의합니다.
	              <input type="checkbox" id="checkAgree" name="checkAgree">
	              <span class="checkmark"></span>
	            </label>
	          </div>
	        </div>
	      </div>
	      <div class="preview-right">
	        <!-- s: 미리보기 시작 -->
	        <div class="div-msg-preview">
	          <div class="div-msg-preview-header">
	            <h2><i class="fa fa-search pdd-right-5"></i> 미리보기</h2>
	          </div>
	          <div class="div-msg-preview-body preview-height">
	            <div class="emulator_area">
	              <div class="emulator_cont">
	                <div class="template-richcard-general">
	                  <div class="template-richcard-descriptionview previewScroll">
	                    <p class="text">
	                      안녕하세요. 고객명 <br/>
	                      이벤트 당첨을 축하드립니다.<br/><br/>
	
	                      이벤트명 : 기업은행 썸머 이벤트<br/>
	                      사은품 : 상품명<br/>
	                      배송지 :  배송지주소<br/><br/>
	
	                      감사합니다.
	                    </p>
	                  </div>
	                </div>
	                <div class="template-openrichcard-suggestion">
	                  <div data-id="previewBtn1" data-name="previewBtn" value="">당첨안내 바로가기</div>
	                </div>
	                <div class="template-openrichcard-suggestion">
	                  <div data-id="previewBtn2" data-name="previewBtn" value="">당첨안내 바로가기</div>
	                </div>
	                <div class="template-openrichcard-suggestion">
	                  <div data-id="previewBtn3" data-name="previewBtn" value="">당첨안내 바로가기</div>
	                </div>
	                <div class="template-openrichcard-suggestion">
	                  <div data-id="previewBtn4" data-name="previewBtn" value="">당첨안내 바로가기</div>
	                </div>
	                <div class="template-openrichcard-suggestion">
	                  <div data-id="previewBtn5" data-name="previewBtn" value="">당첨안내 바로가기</div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	        <!-- s: 미리보기 종료 -->
	      </div>
	    </div>
  	</form>
  	
  </div>
  <div class="modal-footer">
    <a href="javascript:;" class="btn btn-border-sub1 popupAlimTalk_close" >닫기</a>
    <a href="javascript:;" class="btn btn-bg-main popupEditAppy" >수정승인 요청</a>
  </div>
</div>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">

  var rcsInfo;
  var isValid = true;
  $(document).ready(function() {
	  alimFunc.initValid($('#formAlimTalk'));
  });

  function setDialog(data) {
	  var modeName = '등록';
	  $('input[name=mode]').val(DAILOG_MODE.CREATE);

	  if(data.title == DAILOG_MODE.UPDATE) {
		  // 수정일 경우
		  modeName = '수정';
		  $('input[name=mode]').val(DAILOG_MODE.UPDATE);
		  
		  $('.template-title').text( (data.apprResult || '-') +' ('+ modeName+')').show();
		  $('#kkoTmplCd').val(data.kkoTmplCd).attr('readonly', true);
		  $('#bizCd').val(data.bizCd).keyup();
		  $('#bizTmplCd').val(data.bizTmplCd).keyup();
		  $('#tmplNm').val(data.tmplNm).keyup();
		  $('#tmplMsg').val(data.tmplMsg).keyup();
		  $('input[name=mode]').val(data.mode);
		  $('input[name=btnInfo]').val(data.btnInfo);
		  $('input[name=resndYn]').val(data.resndYn);
		  $('input[name=apprResult]').val(data.apprResult);

		  $('#activeYn option[value=' + data.activeYn + ']').attr('selected',true);
		  $('.activeYnDiv').show();

		  var btnInfo = data.btnInfo;
		  if(!str.isEmpty(btnInfo)) {
			  var btnJson = JSON.parse(   "[" + (data.btnInfo || '{}') + "]"   ); // 저장할때 '['와']' 없애고 저장한 부분 떄문에 추가해서 json 형태로 파싱
			  // 버튼 추가
			  alimFunc.addBtnHtml( btnJson , DAILOG_MODE.UPDATE);
		  }
	  }

	  // 탬플릿 ID padding 제외
	  //$('.popupTemplateScroll .row.clearfix:first').addClass('no-pdd-top');
		 
	  $('.modal-header h1').text('알림톡 템플릿 ' + modeName );
	  $('#popupAlimTalk').popup('show');
	  
  }

  function save() {
	  isValid = $( "#formAlimTalk" ).valid();
	  // 유효성체크
	  if(!isValid) {
		  sweet.alert("알림톡 등록에서 체크리스트를 확인하세요");
		  return false;
	  }

	  /* MTS 알림톡 사용할 경우 기본값 셋팅 22.09.22 DB 기본값 설정하여 주석처리 */
	 /*  $('input[name=senderKey]').val('S');
	  $('input[name=senderKeyType]').val('S');
	  $('input[name=templateMessageType]').val('BA');
	  $('input[name=templateEmphasizeType]').val('NONE');
	  $('input[name=securityFlag]').val('N'); */

	  /* 버튼 노출 정보 JSON 형태로 셋팅 */
	  var btnInfoJson = {};
	  $('#popupAlimTalk input[id^=rcsBtn]:not(:hidden), #popupAlimTalk select[id^=rcsBtn]').each(function(i, item){
		  var strArr = item.id.split('_'); // ex ) rcsBtn_alimTmpltBtn1_4
		  btnInfoJson[item.id] = item.value;
	  });
	  $('#btnInfo').val(JSON.stringify(btnInfoJson));

	  $.ajax({
	        url: '${pageContext.request.contextPath}/campaign/alimTalkTemplate/save',
	        type: "POST",
	        data: $("#formAlimTalk").serialize(),
	        dataType: 'JSON'
	      }).done(function(result) {
		      if(result == 99) {
		    	  sweet.alert("이미 존재하는 탬플릿 ID입니다.");
		      } else {
		    	  $('#popupAlimTalk').popup("hide");
		    	  commonFunc.search();
		    	  sweet.alert("저장이 완료되었습니다.");
		      }
		  
	      }).fail(function(xhr) {
	      	sweet.alert("알림톡 저장 중 오류가 발생하였습니다.");
	      });
  }

  /**
  * 미리보기 (내용 , 버튼노출)
  */
  $('body').on('keyup paste', function(e){
	  var targetId = e.target.id;
	  var targetArr = targetId.split('_');

	  var rcsBtnType = $('#rcsBtnType_' + targetArr[1]).val()
	  
	  if(targetId == 'tmplMsg') {
		// (keyup 1) [미리보기] 내용 입력
		$(".template-richcard-descriptionview .text").html($('#' + targetId).val())
	  } else if(targetId.indexOf('rcsBtnNm') == 0) {
		// (keyup 2) [미리보기] 버튼 노출 내용 입력
		$('div[data-id=previewBtn'+ targetId.slice(-1) +']').parent().show();
		$('div[data-id=previewBtn'+ targetId.slice(-1) +']').text(e.target.value);
	  } else if(isValid == false &&  rcsBtnType == ALIM_TALK_BUTTON_TYPE.APP){
		  // 버튼 유형이 APP일 경우 "Mobile, Android, IOS 중 2가지 이상 입력 필수"를 위한 validation 체크
		  $( "#formAlimTalk" ).valid();
	  }
  });
  /**
	* 버튼 노출 라디오, selectbox change 변경 감지 
	*/
	 $('body').on('change', function(e){
		if( e.target.dataset.name == 'rcsBtn') {
			// (미리보기) 버튼 노출 라디오 선택한 갯수만큼 출력
			var $previewEl = $('#popupAlimTalk div[data-name=previewBtn]').parent().not(':hidden');
			var previewElLen = $previewEl.length; // 현재 미리보기 버튼 갯수
			var index = Number(e.target.value); // 사용자가 버튼노출 선택한 갯수
			for(var i = index; index < previewElLen; index++) {
				if(index > previewElLen) {
					$( $previewEl[( i+1 )] ).show();
				} else {
					$( $previewEl[i] ).hide();
				}
			}
		} else if(e.target.name != null && e.target.name.indexOf('rcsBtnType') == 0  && e.target.value != ALIM_TALK_BUTTON_TYPE.CHANEL ) {
			// (미리보기) 버튼 액션 selectbox 선택시 해당 버튼명 내용 삭제  
			var btnNmId = $(e.target).parent().parent().find('input[id^=rcsBtnNm]').attr('id');
			$('#popupAlimTalk div[data-id=previewBtn'+ btnNmId.substr(-1) +']').text('');
		}
	});
  

</script>
<!-- // 현재 페이지에 필요한 js -->
