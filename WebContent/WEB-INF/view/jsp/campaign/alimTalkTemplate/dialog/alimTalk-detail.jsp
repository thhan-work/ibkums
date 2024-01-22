<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	#popupAlimTalkView input  {pointer-events:none} /* #popupAlimTalkView select */
</style>

<!-- 알림톡 템플릿 상세 -->
<div id="popupAlimTalkView" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1>알림톡 템플릿 상세</h1></div>
  <div class="modal-body">
  	<form id="formAlimTalkDetail">
	    <div class="row preview-area clearfix">
	      <div class="preview-left">
	        <div class="template-title">승인완료</div>
	        <div class="pdd-right-10 popupTemplateScroll">
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">템플릿ID</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              ABC_1a234_abc
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">템플릿명</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              회원가입
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">내용</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              RBC샵 첫 구매 이벤트<br/>
	              <br/>
	              5만원 이상 첫 구매 후 응모 시 커피 쿠폰을 지급합니다.
	            </div>
	          </div>	
	
	          <div class="row clearfix button-display mrg-top-10">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">버튼1</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area clearfix">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width150">
	                    <select class="width-100" disabled="disabled">
	                      <option value="">버튼 타입</option>
	                      <option value="web">웹링크</option>
	                      <option value="app">앱링크</option>
	                    </select>
	                  </p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="버튼명을 입력하세요" readonly />
	                  </div>
	                </div>
	              </div>
	              <div class="row ele_area">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width60 pdd-top-5">Mobile</p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="모바일 웹링크를 입력하세요" readonly />
	                  </div>
	                </div>
	              </div>
	              <div class="row ele_area">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width60 pdd-top-5">PC</p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="PC 웹링크를 입력하세요" readonly />
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	
	          <div class="row clearfix button-display mrg-top-10">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">버튼2</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area clearfix">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width150">
	                    <select class="width-100" disabled="disabled">
	                      <option value="">버튼 타입</option>
	                      <option value="web">웹링크</option>
	                      <option value="app">앱링크</option>
	                    </select>
	                  </p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="버튼명을 입력하세요" readonly />
	                  </div>
	                </div>
	              </div>
	              <div class="row ele_area">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width60 pdd-top-5">Mobile</p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="모바일 웹링크를 입력하세요" readonly />
	                  </div>
	                </div>
	              </div>
	              <div class="row ele_area">
	                <div class="search_field inline-form">
	                  <p class="mrg-right-10 width60 pdd-top-5">PC</p>
	                  <div class="ele_area">
	                    <input type="text" class="form-control" value="" placeholder="PC 웹링크를 입력하세요" readonly />
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	
	          <div class="row clearfix mrg-top-10">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">등록일</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              2021-08-24 / 홍길동
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">승인요청일</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              2021-08-24 16:20 / 홍길동
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">승인완료일</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              2021-08-25 16:20
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">사용여부</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              사용
	            </div>
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
	                  <div class="template-richcard-descriptionview" >
	                    <p class="text" data-target="pContentDetail">
	                      RBC샵 첫 구매 이벤트<br/><br/>
	                      5만원 이상 첫 구매 후 응모 시 커피 쿠폰을 지급합니다.
	                    </p>
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
	        </div>
	        <!-- s: 미리보기 종료 -->
	      </div>
	    </div>
  	</form>
  </div>
  <div class="modal-footer">
  <a href="javascript:;" class="btn btn-border-sub1 popupAlimTalkView_close" >닫기</a>
    <a href="javascript:;" class="btn btn-border-main">삭제</a>
    <a href="javascript:;" class="btn btn-border-main" onclick="openUpdateAlimTalk()">수정</a>    
  </div>
</div>


<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">

  var alimTalkInfo;
  $(document).ready(function() {
	  detailDialogId ='popupAlimTalkView';
	  alimFunc.initValid($("#formAlimTalkDetail")); // 유효성 초기셋팅

  });

  function setDetail(data) {
	  $('.modal-header h1').text('알림톡 템플릿  상세' );
	  $('.template-title').text(data.apprResult ||'-').show();
	  
	  $('#' + detailDialogId  +' .popupTemplateScroll').html(''); // 내용 초기화
	  $('div[data-target=pContentDetail]').html(''); // 미리보기 내용 초기화
	  
	  alimTalkInfo = data;

	  commonFunc.addRowHtml('템플릿 ID', data.kkoTmplCd || '-', null);
	  commonFunc.addRowHtml('템플릿명', data.tmplNm || '-', null);
	  commonFunc.addRowHtml('업무코드', data.bizCd || '-', null);
	  commonFunc.addRowHtml('탬플릿코드', data.bizTmplCd || '-', null);
	  commonFunc.addRowHtml('내용', data.tmplMsg, null);
	  $('p[data-target=pContentDetail]').text(data.tmplMsg); // 내용 미리보기

	  var btnInfo = data.btnInfo;
	  if(!str.isEmpty(btnInfo)) {
		  var btnJson = JSON.parse(   "[" + (data.btnInfo || '{}') + "]"   ); // 저장할때 '['와']' 없애고 저장한 부분 떄문에 추가해서 json 형태로 파싱
		  // 버튼 추가
		  alimFunc.addBtnHtml( btnJson , DAILOG_MODE.DETAIL);
		  $('.row.ele_area.exp').hide(); // 버튼 노출 APP일 경우  validation 안내 문구 삭제
		  
	  }

	  //commonFunc.addRowHtml('등록일', data.regYms, data.regUserNm);
	  commonFunc.addRowHtml('승인요청일', data.apprReqYmd, data.apprReqUserNm);
	  commonFunc.addRowHtml('승인완료일', data.apprYmd, null);
	  commonFunc.addRowHtml('사용여부', data.activeYn == 'Y'? '사용':'미사용', null);
	  
	  $('.modal-footer').append('<a href="javascript:;" class="btn btn-border-main" onclick="openUpdateAlimTalk()" >수정</a>');
	  if(data.apprResult.indexOf('승인') == -1) {
		  // 승인일 경우 삭제 불가
		  $('.modal-footer').prepend('<a href="javascript:;" class="btn btn-border-main" onclick="deleteAlimTalk()">삭제</a>');
		  if(data.activeYn =="Y") {
		  	$('.modal-footer').append('<a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="approvalAlimTalk()">승인요청</a>');
		  }
	  }

	  $('.modal-footer').prepend('<a href="javascript:;" class="btn btn-border-sub1 popupAlimTalkView_close" >닫기</a>');
	  
	// 공통 상세화면 초기화
	  commonFunc.changeDetailLayout();

	 // 탬플릿 ID padding 제외
	 //$('.popupTemplateScroll .row.clearfix:first').addClass('no-pdd-top');

	 $('#' + detailDialogId +' select').prop('disabled', true);
	 $('#' + detailDialogId ).popup('show');
  }

  function openUpdateAlimTalk() {
	  $('#' + detailDialogId ).popup('hide');// 상세화면
	   
	  alimTalkInfo.title = DAILOG_MODE.UPDATE;
	  alimFunc.setData(alimTalkInfo);
  }

  function deleteAlimTalk(){
	  sweet.confirm("삭제 안내", "선택한 템플릿을 삭제하시겠습니까?", 'result',  function(isConfirm) {
			if(isConfirm) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/campaign/alimTalkTemplate/remove',
			        type: "POST",
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(alimTalkInfo),
			      }).done(function(result) {
			    	  $('#' + detailDialogId).popup('hide');
			    	  commonFunc.search();
			    	  
				      if(result > 0) {
				    	  sweet.alert("삭제가 완료되었습니다.");
				      }
			      }).fail(function(xhr) {
				      console.error(xhr)
				      sweet.alert("알림톡 탬플릿  삭제 중 오류가 발생하였습니다.");
			      });
			}
		});
  }
  
  function approvalAlimTalk () {
		sweet.confirm("승인요청 안내", "선택한 템플릿을 승인요청하시겠습니까?", 'result',  function(isConfirm) {
			if(isConfirm) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/campaign/alimTalkTemplate/approval',
			        type: "POST",
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(alimTalkInfo),
			        dataType: "json",
			      }).done(function(result) {
			    	  $('#' + detailDialogId).popup('hide');
			    	  commonFunc.search();
			    	  
			    	  if(result > 0) {
			    		  sweet.alert("승인 요청하였습니다.");
				      }
			    	    
			      }).fail(function(xhr) {
				      console.error(xhr)
				      sweet.alert("RCS 탬플릿  승인 요청 중 오류가 발생하였습니다.");
			      });
			}
		});
	}
	
</script>
<!-- // 현재 페이지에 필요한 js -->
