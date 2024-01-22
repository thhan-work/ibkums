<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="row clearfix pdd-top-10">
	<div class="reg-left"></div>
	<div class="reg-right">
		<div class="search_field width-100">
			<select class="width-100" onchange="messageStepSms.changeMsgType(this)" id="smsMsgType">
				<option value="SM">SMS</option>
				<option value="LM">LMS</option>
				<option value="MM">MMS</option>
			</select>
		</div>
	</div>
</div>
<div class="row clearfix hide" id="smsStepTitle">
	<div class="reg-left">
		<h3 class="required pdd-top-4">메시지 제목</h3>
	</div>
	<div class="reg-right">
		<div class="ele_area remaining_byte" data-input="smsMsgTitle"
			data-count="smsMsgTitle_count" data-text-len="60">
			<input type="text" class="form-control previewTitle" id="smsMsgTitle"
				name="smsMsgTitle" placeholder="제목을 입력하세요" />
			<p class="text-right color-gray">
				<span id="smsMsgTitle_count">0</span>/60 byte
			</p>
		</div>
	</div>
</div>
<div class="row clearfix">
	<div class="reg-left">
		<h3 class="pdd-top-4">치환변수 선택</h3>
	</div>
	<div class="reg-right">
		<div class="search_field inline-form replaceVal"></div>
		<div class="mrg-top-5">
			<span class="color-blue">※ 치환변수 값이 예측된 byte보다 클 경우, 메시지 내용이 잘릴 수 있습니다.</span>
		</div>
	</div>
</div>
<div class="row clearfix">
	<div class="reg-left vertical-div">
		<h3 class="required pdd-top-4 vertical-text">메시지 내용</h3>
	</div>
	<div class="reg-right">
		<div>
			<div class="search_field width-100">
				<div class="ele_area" data-input="smsTextarea"
					data-count="smsTextarea_count" data-text-len="90">
					<textarea rows="5" class="width-100 previewTextarea" id="smsTextarea"
						name="smsTextarea" placeholder="내용을 입력하세요"></textarea>
					<p class="text-right color-gray">
						<span id="smsTextarea_count">0</span>/<span id="smsTextareaMaxLen">90</span> byte
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row clearfix hide" id="smsStepImage">
	<div class="reg-left">
		<h3 class="required pdd-top-4">이미지 파일</h3>
	</div>
	<div class="reg-right">
		<div class="ele_area file-copy addFileEl" id="mmsFileEl">
			<div class="search_field inline-form">
				<div class="filebox input-group input-group-icon width-100 mrg-right-10">
					<div class="group-btn">
						<input type="file" name="smsMmsFile1" id="smsMmsFile1" class="file-upload" onchange="msgStep.mmsFileUploadAjax(this, 'N', messageStepSms.fileChange)">
						<input class="form-control inline-block mmsImgFileData" name="smsMmsFileNm1" id="smsMmsFileNm1" placeholder="이미지 파일을 선택하세요" readonly="readonly"/> 
						<a href="javascript:void(0)" class="icon-input-del hide" onclick="msgStep.deleteImgFile(this, 'MM', true)"></a>
					</div>
					<label for="smsMmsFile1" class="btn btn-inner fileSelect">선택</label>
				</div>
				<p>
					<button type="button" class="btn btn-files btn-files-add" onclick="msgStep.addMmsFile(this, 'smsMmsFile')" id="smsMmsBtnAdd"></button>
				</p>
			</div>
		</div>
		<p class="color-blue mrg-top-5">※ 이미지 파일은 3개까지 첨부 가능하며, 순서는 보장되지 않습니다.<br>
		확장자 jpg, jpeg, 최대 1000px X 1000px로 1개당 용량 300KB이하, 총 900KB 이하로 등록하시기 바랍니다.</p>
	</div>
</div>
<script type="text/javascript">
	var messageStepSms = messageStepSms || {};
	messageStepSms = (function() { 
		return {
			changeMsgType: function(e) { // 메시지 유형 변경시
				var msgType = $(e).val();

				$("#smsStepTitle").show();
				$("#smsStepImage").hide();
				$("#smsTextareaMaxLen").text("2,000");
				$(".msgDsticTxt").text("문자 - " + msgType.toUpperCase() + "S");
				$("#msgDstic").val(msgType);
				$("#expctMsgType").val(msgType);
				
				if("SM" == msgType) {
					$("#smsStepTitle").hide();
					$("#smsTextareaMaxLen").text("90");
				} else if("MM" == msgType){
					$("#smsStepImage").show();
				}
				
				// 메시지내용 validate rule변경 
				$('#smsTextarea').rules("add", {
					maxbytelength: str.uncomma($("#smsTextareaMaxLen").text())
				});

				// 초기화(작성, 미리보기)
				msgStep.initSmsWrite();
				msgStep.initPreview();
				
				// 유효성 체크
				$("#frmMsg").valid();
			},
			fileChange: function($target, data, isDetail) { // 이미지 파일 변경시
				// $target > file dom
				
				var imgSeq = data.imgSeq || 0;
				
				// 파일명셋팅
				$target.next().val(data.orgFileName).trigger("input");

				// 파일삭제 기능 활성화
				$target.parent().find('.icon-input-del').removeClass('hide');
				$target.closest('.search_field').find(".fileSelect").addClass('hide');	

				// 미리보기 img 제거
				var idx = $target.closest(".addFileEl").find(".search_field").index($target.closest(".search_field"));
				previewFunc.delImgPrevew(0, idx, false);

				// 미리보기 img 값 셋팅
				var src = "${pageContext.request.contextPath}/template-uploaded-img.ibk?filename=" + data.filename;
				if(isDetail) {
					src = "${pageContext.request.contextPath}/template-img.ibk?seq=" + imgSeq;
				} 
				var html = '<div class="template-richcard-mediaview">';
				html += '<img style="height:200px;" src="'+ src +'">';
				html += '</div>';

				if(idx == 0) {
					$("#previewBody").prepend(html);
				} else {
					$("#previewBody > div:nth-child(" + idx + ")").after(html);	
				}

				// 이미지 파일 정보 값 셋팅
				$target.parent().find(".mmsImgFileData").data("path", data.filename);
				$target.parent().find(".mmsImgFileData").data("imgSeq", imgSeq);
				
				// 스크롤 기능 추가
				var imageLen = $("#previewBody .template-richcard-mediaview").length;
				if(imageLen == 1) generateSlimScroll('#previewEtc .emulator_cont', { height: '530px', size: '3px'});
			}
		}
	})();
</script>