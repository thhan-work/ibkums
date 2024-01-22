<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	.modalPopup.position-top {top:200px !important;width: 500px !important}
	.row.clearfix:first-child {padding-top:10px}
	.form-control[readonly], .form-control[readonly]:hover, .form-control[readonly]:focus {background:none;border:0;} /* 상세보기 readonly 스타일 */
</style>

<!-- RCS Brand 템플릿 수정 -->
<div id="popupBrand" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1 id="title">RCS 브랜드 수정</h1></div>
  <div class="modal-body">
  	<form id="formBrand" name="form">
	    <div class="row preview-area clearfix">
	      <div class="preview-left">
	        <!-- <div class="template-title">승인완료 (수정)</div>  -->
	        <div class="pdd-right-10 popupBrandScroll">
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">브랜드ID</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control" id="brId" name="brId" value="" placeholder="브랜드ID를 입력하세요." >
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
	                  <div class="ele_area remaining" data-input="brNm" data-count="brNm_count" data-text-len="20">
	                    <input type="text" class="form-control" id="brNm" name="brNm" value="" placeholder="브랜드명을 입력하세요">
	                    <p class="text-right color-gray"><span id="brNm_count">0</span>/20자</p>
	                  </div>
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
                    	<input type="text" class="form-control" id="status" name="status" value="" placeholder="상태을 입력하세요">
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">사용여부</h3>
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
	                	<select class="width-50 valid"  id="useYn" name="useYn">
	                		<option value="">사용여부 선택</option>
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
	                </div>
	              </div>
	            </div>
	          </div>
	          
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="required pdd-top-4">요청일</h3> <!-- 애는 일시 -->
	            </div>
	            <div class="preview-form-right">
	              <div class="ele_area">
	                <div class="search_field inline-form">
                    	<input type="text" class="form-control date width-50 valid" id="apprReqYmd" name="apprReqYmd" value="" placeholder="요청일을 입력하세요">
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
	    </div>
  	</form>
  </div>
  <div class="modal-footer">
    <a href="javascript:;" class="btn btn-border-sub1 popupBrand_close" >취소</a>
    <a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="saveBrand()">등록</a>
  </div>
</div>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">

	var brandInfo;
	
	 $(document).ready(function() {
		 brandFunc.initValid($("#formBrand")); // 유효성 초기셋팅
		 
		 brandFunc.initDialog();
	});


	function setDialog(data) {
		var modeName = '등록';
		if(data.title == DAILOG_MODE.UPDATE) {
			// 수졍일 경우
			modeName = '수정';
			$('.ele_area.remaining p').show() // count 지우기
			$('input[name=brId]').attr('readonly', true);
		} else if(data.title == DAILOG_MODE.DETAIL) {
			modeName = '상세';
			brandInfo = data;

			$('#useYn').hide();
			$('#popupBrand #useYn').parent().append('<input type="text" class="form-control date width-50 valid" value="' + (data.useYn == 'Y' ? '사용' : ' 미사용') + '" />')
			
			
			$('.ele_area.remaining p').hide() // count 지우기
			$('.form-control.date').css({"pointer-events" : "none"}); // date 이벤트 막기
			$('#popupBrand input').attr('readonly', true);
			
			$('.required').removeClass().addClass('no-required'); // required css 효과 없애기
		}

		if(data.title != DAILOG_MODE.CREATE) {
			// 수정/상세일 경우 - 데이터 셋팅
			$('.template-title').text(data.status +'('+ modeName+')').show();
			$('input[name=brId]').val(data.brId); // 브랜드 ID
			$('input[name=brNm]').val(data.brNm); // 브랜드 명
			$('input[name=status]').val(data.status); // 브랜드 명
			$("#useYn").val(data.useYn).prop("selected", true); // 사용여부
			$('input[name=apprReqYmd]').val( moment(data.apprReqYmd, 'YYYYMMDDHHmm').format('YYYY-MM-DD') ); // 요청일 
			$('input[name=apprYmd]').val( moment(data.apprYmd, 'YYYYMMDDHHmm').format('YYYY-MM-DD') ); // 승인일
		}
		
		$('#title').html('RCS 브랜드 ' + modeName );

		$('#popupBrand').popup('show'); //  수정화면
	}

	function openUpdate(){
		brandInfo.title = DAILOG_MODE.UPDATE;
		brandFunc.setData(brandInfo);
	}

	 /* 저장 */
	 function saveBrand() {
		 var isValid = $( "#formBrand" ).valid();

		 // 유효성체크
		 if(!isValid) {
			 sweet.alert("RCS 브랜드 등록에서 체크리스트를 확인하세요");
			 return false;
		} 

		$.ajax({
	        url: '${pageContext.request.contextPath}/campaign/rcsBrand/save',
	        type: "POST",
	        data: $("#formBrand").serialize(),
	        dataType: 'JSON'
	      }).done(function(result) {
	    	  $('#popupBrand').popup("hide");
	    	  commonFunc.search();
	    	  sweet.alert("등록이 완료되었습니다.");
	          
	      }).fail(function(xhr) {
	      	sweet.alert(" RCS 템플릿 등록 중 오류가 발생하였습니다.");
	      });
	  }

	 function deleteBrand(brId){
		 sweet.confirm("삭제 안내", "선택한 브랜드을 삭제하시겠습니까?", 'result',  function(isConfirm) {
			 if(isConfirm) {
				 $.ajax({
				        url: '${pageContext.request.contextPath}/campaign/rcsBrand/remove?brId=' + brId,
				        type: "DELETE",
				      }).done(function(result) {
				    	  $('#popupBrand').popup("hide");
				    	  commonFunc.search();
				    	  sweet.alert("삭제가 완료되었습니다.");
				          
				      }).fail(function(xhr) {
				      	sweet.alert(" RCS 브랜드 삭제 중 오류가 발생하였습니다.");
				      });
				 }
		 });
	 }
	 

</script>
<!-- // 현재 페이지에 필요한 js -->

