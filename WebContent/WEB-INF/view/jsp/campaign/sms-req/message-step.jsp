<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="section-left">
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4">
				<span class="required">메시지 유형</span> <span class="icon-tooltip"
				data-tippy-content="
<p class='pdd-btm-5'>< 메시지 유형 안내 ></p>
<table class='table table-sm'>
<colgroup>
	<col width='80' />
	<col width='*' />
</colgroup>
<thead>
	<tr>
		<th>메시지유형</th>
		<th>설명</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>SMS</td>
		<td class='text-left'>최대 90byte까지 텍스트 메시지 발송</td>
	</tr>
	<tr>
		<td>LMS</td>
		<td class='text-left'>최대 2,000byte까지 텍스트 메시지 발송</td>
	</tr>
	<tr>
		<td>MMS</td>
		<td class='text-left'>최대 2,000byte 텍스트 및 이미지를 추가하여 메시지 발송</td>
	</tr>
	<tr>
		<td>알림톡</td>
		<td class='text-left'>알림톡 템플릿 메시지 발송</td>
	</tr>
	<tr>
		<td>RCS SMS</td>
		<td class='text-left'>최대 100자까지 텍스트 메시지 발송</td>
	</tr>
	<tr>
		<td>RCS LMS</td>
		<td class='text-left'>최대 1,300자까지 텍스트 메시지 발송</td>
	</tr>
	<tr>
		<td>RCS MMS</td>
		<td class='text-left'>최대 1,300자  텍스트 및 이미지를 추가하여 메시지 발송</td>
	</tr>
</tbody>
</table>"><i class="fa fa-info"></i></span>
			</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area">
				<div class="search_field inline-form">
					<div class="inline-block">
						<label class="radio-container">문자 
							<input type="radio" name="chnlType" value="M" onchange="changeChnlType(this)"/>
							<span class="checkmark"></span>
						</label>
						<label class="radio-container">알림톡
							<input type="radio" name="chnlType" value="K" onchange="changeChnlType(this)"/>
							<span class="checkmark"></span>
						</label>
						<label class="radio-container">RCS
							<input type="radio" name="chnlType" value="R" onchange="changeChnlType(this)"/>
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="msgStep">
		<jsp:include page="./message-step-sms.jsp" flush="true" />
	</div>
	<div class="hide msgStep">
		<jsp:include page="./message-step-talk.jsp" flush="true" />
	</div>
	<div class="hide msgStep">
		<jsp:include page="./message-step-rcs.jsp" flush="true" />
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-5">
				<span class="required">SMS 수신동의 체크</span> <span class="icon-tooltip"
					data-tippy-content="사전 수신동의 한 고객에게만 발송하거나 수신동의를 하지 않은 고객에게도 발송을<br/>희망할 경우 전체 전송을 선택하시기 바랍니다."><i
					class="fa fa-info"></i></span>
			</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area">
				<div class="search_field inline-form">
					<div class="inline-block">
						<label class="radio-container">수신동의자만 전송 
							<input type="radio" id="msgAgree" name="msgAgree" value="Y" checked="checked" />
							<span class="checkmark"></span>
						</label>
						<label class="radio-container">전체 전송
							<input type="radio" id="msgAgree" name="msgAgree" value="N" />
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="required pdd-top-4">수신거부적용</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area">
				<div class="search_field inline-form">
					<div class="inline-block">
						<label class="radio-container">미적용
							<input type="radio" id="msgRefusal"  name="msgRefusal" value="N" checked="checked" />
							<span class="checkmark"></span>
						</label>
						<label class="radio-container">적용
							<input type="radio" id="msgRefusal"  name="msgRefusal" value="Y" />
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="required pdd-top-4">발신번호</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area">
				<input type="text" class="form-control mrg-btm-5" id="sndrTelno" name="sndrTelno"  placeholder="발신번호를 입력하세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
			</div>
		</div>
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4">발송가능 건수</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area">
				<div class="search_field inline-form">
					<label class="font-weight-light mrg-right-5">총</label>
					<input class="form-control mrg-right-5 width150" id="sendTotCnt" readonly="readonly" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');"/>
					<label class="font-weight-light mrg-right-10">건 &nbsp;/&nbsp; 남은건수</label>
					<input class="form-control width180" id="sendRestCnt" readonly="readonly" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');"/>
				</div>
			</div>
		</div>
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4 required">발송 희망일</h3>
		</div>
		<div class="reg-right search_field" id="sendCntDiv">
			<div class="">
				<div class="search_field inline-form">
					<input class="form-control date" readonly="readonly" id="sendTargetDt">
				</div>
			</div>
			<div class="pdd-top-10 reservation-send-copy" id="sendTargetInfo">
				<div class="inline-form">
					<select class="width100 hour" id="sendTargetHour"></select>
					<label class="font-weight-light mrg-left-5 mrg-right-10">시</label>
					<select class="width100 minute" id="sendTargetMinute"></select>
					<label class="font-weight-light mrg-left-5 mrg-right-20">분</label>
					<input class="form-control width100" name="eachSendCnt" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					<label class="font-weight-light mrg-left-5 mrg-right-5">건 발송</label>
					<button type="button" class="btn btn-files btn-files-add" id="sendTimeAddBtn" onclick="msgStep.addSendCount(this);"></button>
				</div>
			</div>
			<div class="ele_area mrg-top-5"></div>
		</div>
	</div>
</div>
<jsp:include page="../template/preview.jsp" flush="true" />
<script type="text/javascript">
	$(document).ready(function() {
		msgStep.makeTimeSelect();
	});

	// 등록하기 공통 함수
	var msgStep = msgStep || {};
	msgStep = (function() {
		return {
			changeReplace: function(val, e) {
				var chnlType = $("input[name=chnlType]:checked").val();
				var $target = $(e).parent().parent().parent().next().find(".previewTextarea");

				if(!str.isEmpty(val)) {
					$target.val($target.val() + val).keyup();
				}
  			},
			setStrLen: function(e, isByte, rObj) {
				var countId = $(e.target).parent().data('count');
				var $count = $('#' + countId);
				var orgStr = $(e.target).val();
				var msgStr = removeReplaceValue(orgStr);
				var replcLength = 0;
				var strLength = 0;
				
				if(isByte) {
					strLength = str.getByteLength(msgStr);
				} else {
					strLength = msgStr.length;
				}

				// 치환변수 문자 길이 
				replcLength = this.getReplcLength(orgStr, rObj);

				var sumLength = strLength + replcLength;
				$count.text(sumLength);
			},
			getReplcLength: function(str, rObj) {
				var sumLength = 0;
				Object.keys(rObj).forEach(function(key){
					var regex = new RegExp("\\\\${"+ key +"}", "g");
					var replcArr = str.match(regex) || [];
					sumLength += replcArr.length * rObj[key];
				})
				return sumLength;
			},
			// 대체 메시지 내용 셋팅
			setTransMsgContents: function() {
				$(".msgStep:visible").find(".previewTransTextarea").val($("#previewContents").text()).keyup();
			},
			// 대체 메시지 유형 셋팅
			setTransMsgType: function(type) {
				var msgDstic = $("#msgDstic").val();
				var chnlType = $("input[name=chnlType]:checked").val();
				var byteLen = str.getByteLength($("#transContents").text());
				var tgtId = chnlType == "R" ? "rcsTransTextarea" : "talkTransTextarea";

				var maxByte = null;
				var msgType = null;
				if(msgDstic == "CR" || msgDstic == "MR") {
					msgType = 'MM';
					maxByte = "2,000";
					$("#" + tgtId).parent().parent().find('.transTitleDiv').show();
				} else {
					if(byteLen > 90 || type == 'LM') {
						msgType = 'LM';
						maxByte = "2,000";
						$("#" + tgtId).parent().parent().find('.transTitleDiv').show();
					} else {
						msgType = 'SM';
						maxByte = "90";
						$("#" + tgtId).parent().parent().find('.transTitleDiv').hide();
						$("#" + tgtId).parent().parent().find('.previewTransTitle').val('').trigger('input');
					}
				}
				
				// 변경된 유효성 셋팅
				$("#" + tgtId + "MaxLen").text(maxByte);
				$("select[name=transMsgType]").val(msgType);
				// 유효성 규칙 변경
				$("#" + tgtId).rules("add", {
					maxbytelength: str.uncomma($("#" + tgtId + "MaxLen").text())
				});
			},
			// 전환발송 노출 제어
			changeTransMsg: function(e, isDetail) {
				if("Y" == $(e).val() && $(e).prop("checked")) {
					if(!isDetail) sweet.alert('채널 발송 실패 시, 선택한 문자 메시지 유형(SMS/LMS/MMS)으로 전환 발송됩니다.');
					$(e).closest('.transUse').next().show();
					$("#isTransMsg").show();
					this.setTransMsgType();
				} else {
					$(e).closest('.transUse').next().hide();
					$("#isTransMsg").hide();
				}
				$("#frmMsg").valid();
			},
			// 전환발송 메시지 유형 변경
			changeTransMsgType: function(e) {
				this.setTransMsgType($(e).val());
			},
			// 미리보기 초기화
			initPreview: function() {
				// 미리보기 - 그외
				$("#previewTtile").text('');
				$("#previewContents").text('');
				$("#previewBody .template-richcard-mediaview").remove();
				$(".template-openrichcard-suggestion").hide();
				$("#transDiv").hide();
				$("#transTtile").text('');
				$("#transContents").text('');
				$("#transBody .template-richcard-mediaview").remove();
				// 슬림 스크롤 제거
				if($("#transDiv .slimScrollDiv").length > 0) {
					destroySlimscroll($("#transBody").parent());	
				}
				// 미리보기 - Carousel
				$("#previewCarousel .template-richcard-mediaview").empty();
				$("#previewCarousel h4").text('');
				$("#previewCarousel p").text('');
				$('input:radio[name=rcsCRSlide]:input[value=3]').click();
				// 미리보기 - 스타일
				$("#previewCell #cellMsgCont").empty();
				$("#previewCell .template-openrichcard-imageview").empty();
			},
			initMsgStep: function() {
				this.initSmsWrite();
				this.initTalkWrite();
				this.initRcsWrite();
				this.initPreview();
			},
			initSmsWrite: function() {
				this.initSendCnt();
				$("#sndrTelno").val('');
				$("#msgAgree[value=Y]").prop("checked", true);
				$("#msgRefusal[value=N]").prop("checked", true);
				$("#smsMsgTitle").val('');
				$("#smsTextarea").val('');
				$("#mmsFileEl .search_field").not(":first").remove();
				$("#mmsFileEl .mmsImgFileData").removeData(['path', 'imgSeq']);
				$("#mmsFileEl .icon-input-del").addClass("hide");
				$("#mmsFileEl .fileSelect").removeClass("hide");
				$("#smsMmsFile1").val('');
				$("#smsMmsFile1").next().val('');
				$("#sendRestCnt").val($("#sendTotCnt").val());

				// 슬림 스크롤 제거
				if($("#previewEtc .slimScrollDiv").length > 0) {
					destroySlimscroll($("#previewBody").parent());	
				}
			},
			initRcsWrite: function() {
				this.initSendCnt();
				$("#sndrTelno").val('');
				$("#msgAgree[value=Y]").prop("checked", true);
				$("#msgRefusal[value=N]").prop("checked", true);
				$("select[name=transMsgType]").val("SM");
				$("input[name=transRcs]").prop("checked", false).change();

				// 대체메시지 초기화
				$("#rcsTransTitle").val('');
				$("#rcsTransTextarea").val('');
				$("#rcsFileEl .search_field").not(":first").remove();
				$("#rcsFileEl .transImgFileData").removeData(['path', 'imgSeq']);
				$("#rcsFileEl .icon-input-del").addClass("hide");
				$("#rcsFileEl .fileSelect").removeClass("hide");
				$("#rcsTransMmsFile1").val('');
				$("#rcsTransMmsFile1").next().val('');

				// RCS Standalone 초기화
				$("#rcsMmsFile").val('');
				$("#rcsMmsFile").next().val('');
				$("#rcsMmsFile").next().removeData(['path', 'imgSeq']);
				$("#rcsMmsFile").parent().find(".icon-input-del").addClass("hide");
				$("#rcsMmsFile").parent().parent().find(".fileSelect").removeClass("hide");

				// RCS Carousel 초기화
				$("input[id^=rcsCRFile]").val('');
				$("input[id^=rcsCRFile]").next().val('');
				$("input[id^=rcsCRFile]").next().removeData(['path', 'imgSeq']);
				$("input[id^=rcsCRFile]").next().next().addClass("hide");
				$("input[id^=rcsCRFile]").parent().parent().find(".fileSelect").removeClass("hide");
				$("input[id^=rcsMsgTitle]").val('');
				$("textarea[id^=rcsTextarea]").val('');
				$("#sendRestCnt").val($("#sendTotCnt").val());
			},
			initTalkWrite: function() {
				this.initSendCnt();
				$("#sndrTelno").val('');
				$("#msgAgree[value=Y]").prop("checked", true);
				$("#msgRefusal[value=N]").prop("checked", true);
				$("select[name=transMsgType]").val("SM");
				$("input[name=transTalk]").prop("checked", false).change();
				$("#talkTransTitle").val('');
				$("#talkTransTextarea").val('');
				$("#sendRestCnt").val($("#sendTotCnt").val());
				$("#kkoTmplCd").val('');
			},
			initSendCnt:function() {
				var $tgt = $("#sendCntDiv .reservation-send-copy");
		    	$tgt.each(function(idx){
		    		if(idx > 0) {
			    		$(this).remove();
		    		}
		    		$(this).find("input").val('');
		       	});
			},
			// 이미지파일 추가/삭제
			addMmsFile: function(e, target) {
				var $addFileEL = $(e).closest(".addFileEl");
				var el = $addFileEL.find(".search_field");
				
				if($(e).hasClass("btn-files-add")) {

					// 이미지는 최대 3개 까지 가능
					if(el.length > 2) {
						return false;
					} 

					// 복사
					var cloneEl = el.eq(0).clone();

					// 복사 el 초기화
					// 22.12.11 label 중복으로 인한 이슈 해결
					var tgtId = $(el).last().find("input[type=file]").attr('id');
					var num = Number(tgtId.match(/\d+/)[0]) + 1;
					$(cloneEl).find("input[type=file]").val('');
					$(cloneEl).find("input[type=file]").attr('name', target + num);
					$(cloneEl).find("input[type=file]").attr("id", target + num);
					$(cloneEl).find("label").attr("for", target + num);
					$(cloneEl).find("input[type=file]").next().attr("id", target + "Nm" + num);
					$(cloneEl).find("input[type=file]").next().attr("name", target + "Nm" + num);
					$(cloneEl).find("input[type=file]").next().val('');
					$(cloneEl).find("input[type=file]").next().next().addClass("hide");
					var btnEl = $(cloneEl).find("button");
					btnEl.removeClass("btn-files-add");
					btnEl.addClass("btn-files-del");
					// 파일선택 액티브
					$(cloneEl).find(".fileSelect").removeClass("hide");
					
					$addFileEL.append(cloneEl);
				} else {
					var $field = $(e).closest(".search_field");
					var type = 'MM';
					if(target.indexOf("Trans") > -1) {
						type = 'TRANS';
					}

					// 이미지 파일 삭제
					var $delTgt = $field.find(".icon-input-del");
					var path = $delTgt.prev().data("path");
					if(!str.isEmpty(path)) msgStep.deleteImgFile($delTgt, type, false);
					
					// 이미지 파일 선택 el 제거
					$field.remove();
				}
			},
			// 이미지 파일 변경시
			mmsFileUploadAjax: function(e, rcsType, callback) {
				var isRcs = rcsType != 'N';
				var $target = $(e);
				var uploadFile = $target[0].files[0];
				var regex = isRcs ? new RegExp('jpg|jpeg|JPG|JPEG|png|PNG', 'i') : new RegExp('jpg|jpeg|JPG|JPEG', 'i');
				var msg = isRcs ? 'jpg, jpeg, png 만 가능합니다!' : 'jpg, jpeg 만 가능합니다!';
				
				var isValid = true;
		        if (!regex.test(uploadFile.name)) {
		            sweet.alert(msg);
		            isValid = false;
		            return false;
		        }

		        var formData = new FormData();  
		        formData.append("fileName", uploadFile);
				formData.append("rcsType", rcsType);

				$.ajax({ 
					url: '${pageContext.request.contextPath}/campaign/smsreq/uploadImage', 
					type: 'POST',
					dataType: 'JSON',
					enctype: 'multipart/form-data',
					data: formData, 
					processData: false, 
					contentType: false, 
					success: function(data){ 
						if (data.result) {
							if(callback != undefined) {
								// TODO 이미지 저장 로직 변경
								//msgStep.insertImageBlobAjax($target, data, isRcs, callback);
								// 콜백 호출
				        		callback($target, data, false);
							}
						} else {
							$target.val('');
							sweet.alert(data.error);
						}
					} 
				});
			},
			// 이미지 파일 초기화
			initImgFile: function(e, type, isChildren) {
				// 파일 초기화
	        	$(e).parent().find('input').val('');
	        	
	        	// 파일정보 초기화
        		$(e).prev().removeData(['path', 'imgSeq']);

        		// 파일삭제 제거
        		$(e).addClass('hide');
        		$(e).closest(".search_field").find(".fileSelect").removeClass('hide');

        		// 미리보기 img 제거
        		var delType = 0;
        		var idx = $(e).closest(".addFileEl").find(".search_field").index($(e).closest(".search_field"));
        		if(type == 'MM') {
        		} else if(type == 'MR') {
	        		idx = 0;
        		} else if(type == 'CR') {
        			delType = 1;
        			idx = $(e).closest(".reg-right").find(".rcsMmsTabCls").index($(e).closest(".rcsMmsTabCls"));
        		} else {
        			delType = 2;
        		}
        		previewFunc.delImgPrevew(delType, idx, isChildren);

				// 유효성 체크
        		smsReq.chkBtnActive(smsReq.curStep);
			},
			// 이미지 파일 삭제
			deleteImgFile: function(e, type, isChildren) {
				var isRcs = (type == 'MR'|| type == 'CR') ? true : false;
				var path = $(e).prev().data("path");
				var imgSeq = $(e).prev().data("imgSeq");

				// 수정/신규 분리 처리
				if(!str.isEmpty(imgSeq) && imgSeq > 0) {
					this.initImgFile(e, type, isChildren);
				} else {
					// 파라미터 값 셋팅
					var param = {
							imgUploadPath: path,
							mmsImgId: imgSeq,
							rcsYn: isRcs	
					}
					
					this.deleteImgFileAjax(e, type, param, isChildren);
				}
			},
			// 이미지 파일 삭제 AJAX
			deleteImgFileAjax: function(e, type, param, isChildren) {
				var _this = this;
				
				$.ajax({
		            url: '${pageContext.request.contextPath}/campaign/smsreq/deleteImgFile',
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify(param)
		        }).done(function (res) {
		        	if("SUCCESS" == res.result) {
		        		_this.initImgFile(e, type, isChildren);
		        	} else {
		        		sweet.alert("이미지 삭제 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다");
		        	}
		        }).fail(function (xhr) {
		        	sweet.alert("이미지 삭제 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
		        });
			},
			// 시간 분 셀렉트박스 셋팅
			makeTimeSelect: function() {
				var hourHtml = "";
				for(var i = 0; i < 24; i++) {
					hourHtml+= "<option value='" + str.pad(i, 2) + "'>" + str.pad(i, 2) + "</option>";
				}
				$("#sendTargetHour").append(hourHtml);

				var minuteHtml = "";
				for(var i = 0; i < 6; i++) {
					var minute = i + "0";
					minuteHtml+= "<option value='" + minute + "'>" + minute + "</option>";
				}
				$("#sendTargetMinute").append(minuteHtml);
			},
			// 발송건수 추가
			addSendCount: function(e) {
				if($(e).hasClass("btn-files-add")) {

					// 복사 EL
					var cloneEl = $("#sendTargetInfo").clone();

					// 복사 EL 초기화
					$(cloneEl).attr("id", "");
					$(cloneEl).find("select").attr("id", "");
					$(cloneEl).find("select").val('00');
					$(cloneEl).find("input").val('');
					$(cloneEl).find("input").attr("id", "");
					var btnEl = $(cloneEl).find("button");
					btnEl.removeClass("btn-files-add");
					btnEl.addClass("btn-files-del");
					
					// 추가
					$(e).parent().parent().after(cloneEl);
				} else {
					$(e).parent().parent().remove();
				}
				
				// 발송 남은 건수 계산
				this.calcRestCnt();
			},
			// 남은건수 계산
			calcRestCnt: function() {
		    	var totCnt = Number(str.uncomma($("#sendTotCnt").val()));
		    	var cntSum = 0;
		    	var $tgt = $("#sendCntDiv .reservation-send-copy");
		    	$tgt.each(function(){
		        	var cntVal = Number(str.uncomma($(this).find("input").val()));
		        	cntSum += cntVal;
		        	
		        	if(totCnt < cntSum) {
		        		$(this).find("input").val('');
		        		cntSum -= cntVal; 	            	
		           	}
		       	});
		        if(totCnt) {
					$("#sendRestCnt").val(str.comma(totCnt - cntSum));
				}
		    },
		    sendTimeAjax: function() {
			    var param = {"groupUniqNo": smsReq.groupUniqNo};
			    
		        $.ajax({
		            url: '${pageContext.request.contextPath}/campaign/smsreq/savecnt2/',
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify(param)
		        }).done(function(data){
			        
		            $.each(data, function(key, value) {
		                $("#sendTargetDt").val(str.getYyyymmddFmt(key, "-"));
		                
		                // 3. 해당일자 시간별 기안자 등록한 건수 셋팅
		                var timeList = value["timeList"];
		                for(var i=0; i < timeList.length; i++){
		                	var time = timeList[i];
		                	var h = time.slice(0,2)
		                	var m = time.slice(2,4);
		                	var cnt = parseInt(value["TOTAL_TIME_"+ timeList[i]]);

		                	if(i > 0) {
		                		msgStep.addSendCount($("#sendTimeAddBtn"));
		                	}
		                	
		                	var $tgt = $("#sendCntDiv .reservation-send-copy");
		                	$($tgt[i]).find(".hour").val(h);
		                	$($tgt[i]).find(".minute").val(m);
		                	$($tgt[i]).find("input").val(str.comma(cnt)).trigger("input");
		                }
		            });

		        }).fail(function(xhr){
		        	sweet.alert("발송희망일 세팅중 오류가 발생했습니다. \n\n (sendTimeAjax())");
		        });
		    }
		}
	})();
	
	// 메시지 유형 변경시
	function changeChnlType(e) {
		// 공통 초기화
		$(".msgStep").each(function(index, item){
			$(item).addClass("hide");
		})
		var idx = $("input[name=chnlType]").index($(e));
		$(".msgStep").eq(idx).removeClass("hide");

		// 초기화
		msgStep.initMsgStep();
		
		// 알림톡 템플릿 조회
		var type = $(e).val();
		if("M" == type) { // 문자
			$(".msgDsticTxt").text("문자 - SMS");
			$("#isTransMsg").hide();
			previewFunc.preivewShowChoice(0);
			$("#smsMsgType").val("SM").change();
		} else if("K" == type) { //알림톡
			msgStepTalk.init();
			msgStepTalk.search();
			// 미리보기
			$(".msgDsticTxt").text("알림톡");
			$("#isTransMsg").show();
			previewFunc.preivewShowChoice(0);
			$("#msgDstic").val('KM');
			<!-- 2022-12-09 사전협의 메시지유형 변경 -->
			$("#expctMsgType").val('KM');
			msgStep.initTalkWrite();
		} else { // RCS
			$(".msgDsticTxt").text("RCS - SMS");
			$("#isTransMsg").show();
			previewFunc.preivewShowChoice(0);
			$("#rcsMsgType").val("SR").change();
		}

		// 슬림 스크롤 제거
		if($("#previewEtc .slimScrollDiv").length > 0) {
			destroySlimscroll($("#previewBody").parent());	
		}
		
	}

	// 메시지 제목입력시, 미리보기 값 셋팅
	$(".previewTitle").on("keyup paste", function(e, data) {
		var value = $(this).val();
		var id = $(this).attr("id");

		if(id.indexOf("CR") > -1) {
			var sIdx = $(".slick-active").index(".slick-slide:not(.slick-cloned)");
			if(data && data.sIdx) sIdx = data.sIdx;
			previewFunc.setPreviewSlideTitle(sIdx, value);
		} else{
			previewFunc.setPreviewTitle(value);	
		}
	})

	// 메시지내용 입력시, 미리보기 값 셋팅
	$(".previewTextarea").on("keyup paste", function(e, data) {
		var value = $(this).val();
		var id = $(this).attr("id");
		
		// input 이벤트 override(치환변수 maxByte값 더하기)
		var isByte = id.indexOf("sms") > -1 ? true : false;
		msgStep.setStrLen(e, isByte, sendTargetRegist.replcBtnObj);

		// 22.12.14 RCS 라인수 유효성추가 진행중
		/* if(id.indexOf("rcs") > -1) {
			validRcsLine($(this));
		} */

		// 미리보기 셋팅
		if(id.indexOf("CR") > -1) {
			// 22.12.14 RCS 라인수 유효성추가 진행중
			// validCarouselCntnt();
			
			var sIdx = $(".slick-active").index(".slick-slide:not(.slick-cloned)");
			if(data && data.sIdx) sIdx = data.sIdx;
			previewFunc.setPreviewSlideContents(sIdx, value);
		} else{
			previewFunc.setPreviewContents(value);
		}
		// 대체메세지 내용 셋팅
		msgStep.setTransMsgContents();
		// 대체메세지 타입 셋팅
		msgStep.setTransMsgType();
	})
	
	// 메시지 제목입력시, 미리보기 값 셋팅
	$(".previewTransTitle").on("keyup paste", function() {
		previewFunc.setPreviewTransTitle($(this).val());
	})

	// 메시지내용 입력시, 미리보기 값 셋팅
	$(".previewTransTextarea").on("keyup paste", function(e) {
		msgStep.setStrLen(e, true, sendTargetRegist.replcBtnObj);
		
		previewFunc.setPreviewTransContents($(this).val());

		// 대체메세지 타입 셋팅
		msgStep.setTransMsgType();
	})
	
	// 버튼명 입력시, 미리보기 값 셋팅
	$('body').on('keyup paste', '.previewRcsBtnNm', function(e, data) {
		var btnIdx = $(".previewRcsBtnNm:visible").index($(this)) + 1;
		if(data) btnIdx = data.btnIdx;
		var value = $(this).val();
		var id = $(this).attr("id");
		
		if(id.indexOf("CR") > -1) {
			var sIdx = $(".slick-active").index(".slick-slide:not(.slick-cloned)");
			if(data && data.sIdx) sIdx = data.sIdx;
			previewFunc.setPreviewSlideBtn(sIdx, btnIdx, value);
		} else{
			previewFunc.setPreviewBtn("previewEtc", btnIdx, value);	
		}
	})
    
	// 건수 입력 시, 이벤트
	$('#sendCntDiv').on('input', 'input[name=eachSendCnt]', function() {
		msgStep.calcRestCnt();
	})
</script>
