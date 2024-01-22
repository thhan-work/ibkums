<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	.modalPopup.position-top {top:200px !important;width: 500px !important}
	.preview-area .preview-form-left{width:25%}
	.preview-area .preview-form-right{width:75%}
	.row.clearfix:first-child {padding-top:10px}
	.form-control[readonly], .form-control[readonly]:hover, .form-control[readonly]:focus {background:none;border:0;} /* 상세보기 readonly 스타일 */
</style>

<!-- 챗붓 템플릿 popup -->
<div id="popupChatbot" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1 id="titleChatbot">발신번호 수정</h1></div>
  <div class="modal-body">
  	<form id="formChatbot" name="form">
  		<input type="hidden" id="chatbotId" name="chatbotId">
	    <div class="row preview-area clearfix">
	      <div class="preview-left">
	        <!-- <div class="template-title">승인완료 (수정)</div>  -->
	        <div class="pdd-right-10 popupChatbotScroll">
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">브랜드ID</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="brandId" name="brId" value="" readonly >
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">브랜드명</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="brandNm" name="brNm" value="" readonly >
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">발신번호명</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="subTitle" name="subTitle" value="" placeholder="발신번호명를 입력하세요." >
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">발신번호</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="subNum" name="subNum" value="" placeholder="발신번호를 입력하세요">
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">대표번호여부</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                	<select class="width-50 valid"  id="mainnumYn" name="mainnumYn">
	                		<option value="">대표번호여부 선택</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">전시상태</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="display" name="display" value="" placeholder="전시상태를 입력하세요">
	                </div>
	              </div>
	            </div>
	          </div>
	          
	           <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">상태</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="status" name="status" value="" placeholder="상태를 입력하세요">
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix registerInfo">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">등록일</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control date width-50 valid" id="regDt" name="regDt" value="" placeholder="등록일을 입력하세요">
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">승인일</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                    <input type="text" class="form-control date width-50 valid" id="apprYmd" name="apprYmd" value="" placeholder="승인일을 입력하세요">
	                </div>
	              </div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
  	</form>
  </div>
  <div class="modal-footer">
    <a href="javascript:;" class="btn btn-border-sub1 popupChatbot_close" >취소</a>
    <a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="saveChatbot()">등록</a>
  </div>
</div>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">

	var chatbotInfo;
	
	 $(document).ready(function() {
		 chatbotFunc.initValid($("#formChatbot")); // 유효성 초기셋팅
		 
		 chatbotFunc.initDialog();
	});

	function setChatbotDialog(data) {
		var modeName = '등록';
		if(data.title == DAILOG_MODE.UPDATE) {
			// 수졍일 경우
			modeName = '수정';
			$('.ele_area.remaining p').show() // count 지우기
			$('input[name=subNum]').attr('readonly', true);
		} else if(data.title == DAILOG_MODE.DETAIL) {
			modeName = '상세';
			chatbotInfo = data;

			$('#mainnumYn').hide();
			$('#popupChatbot #mainnumYn').parent().append('<input type="text" class="form-control date width-50 valid" value="'+ data.mainnumYn +'">')
			
			$('.registerInfo').show();
			
			$('.ele_area.remaining p').hide() // count 지우기
			$('.form-control.date').css({"pointer-events" : "none"}); // date 이벤트 막기
			$('#popupChatbot input').attr('readonly', true);

			$('.required').removeClass().addClass('no-required'); // required css 효과 없애기
		}

		if(data.title != DAILOG_MODE.CREATE) {
			/* 수정/상세일 경우 - 데이터 셋팅 */
			//$('.template-title').text(data.status +'('+ modeName+')').show();
			$('input[name=subTitle]').val(data.subTitle); // 발신번호명
			$('input[name=subNum]').val(data.subNum); // 발신번호
			$('input[name=status]').val(data.status); // 브랜드 명
			$("#mainnumYn").val(data.mainnumYn).prop("selected", true); // 대표전화여부여부
			$('input[name=display]').val(data.display); // 전시상태
			$('input[name=status]').val(data.status); // 브랜드 명
			$('input[name=regDt]').val( moment(data.regDt, 'YYYYMMDDHHmm').format('YYYY-MM-DD') ); // 등록일 
			$('input[name=apprYmd]').val( moment(data.apprYmd, 'YYYYMMDDHHmm').format('YYYY-MM-DD') ); // 승인일
		}
		
		$('#titleChatbot').html('발신번호 ' + modeName );
		// 선택한 브랜드 정보 출력
		$('input[name=brId]').val( $('#brId').val() ); // 발신번호명
		$('input[name=brNm]').val( $('#brNm').val()  ); // 발신번호명
		$('input[name=brId]').attr('readonly', true);
		$('input[name=brNm]').attr('readonly', true);

		$('#popupChatbot').popup('show'); //  수정화면
	}

	function openUpdateChatbot(){
		chatbotInfo.title = DAILOG_MODE.UPDATE;
		chatbotFunc.setData(chatbotInfo);
	}

	 /* 저장 */
	 function saveChatbot() {
		 var isValid = $( "#formChatbot" ).valid();

		 // 유효성체크
		 if(!isValid) {
			 sweet.alert("발신번호 등록에서 체크리스트를 확인하세요");
			 return false;
		}

		$('input[name=chatbotId]').val($('#subNum').val()); // 발신번호와 챗붓ID가 동일함 

		$.ajax({
	        url: '${pageContext.request.contextPath}/campaign/rcsBrand/saveChatbot',
	        type: "POST",
	        data: $("#formChatbot").serialize(),
	        dataType: 'JSON'
	      }).done(function(result) {
	    	  $('#popupChatbot').popup("hide");
	    	  chatbotFunc.search();
	    	  sweet.alert("등록이 완료되었습니다.");
	          
	      }).fail(function(xhr) {
	      	sweet.alert(" RCS 템플릿 등록 중 오류가 발생하였습니다.");
	      });
	  }

	 function deleteChatbot(brId, chatbotId){
		 sweet.confirm("삭제 안내", "선택한 발신번호를 삭제하시겠습니까?", 'result',  function(isConfirm) {
			 if(isConfirm) {
				 $.ajax({
				        url: '${pageContext.request.contextPath}/campaign/rcsBrand/removeChatbot?brId=' + brId+'&chatbotId='+chatbotId,
				        type: "DELETE",
				      }).done(function(result) {
				    	  $('#popupChatbot').popup("hide");
				    	  chatbotFunc.search();
				    	  sweet.alert("삭제가 완료되었습니다.");
				          
				      }).fail(function(xhr) {
				      	sweet.alert(" RCS 브랜드 삭제 중 오류가 발생하였습니다.");
				      });
			 }
		 });
	 };
	 

</script>
<!-- // 현재 페이지에 필요한 js -->

