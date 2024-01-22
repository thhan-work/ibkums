<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery.fileupload.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatables-new.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/message-step-column.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/v2/js/smsReqCommon.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/dataTables.select.min.js"></script>

<!-- begin page-header -->
<div class="page-header">
	등록하기
	<ol class="breadcrumb pull-right"></ol>
</div>
<!-- end page-header -->

<!-- begin Step -->
<div class="row">
	<div class="step-area">
		<div class="step-box active">
			<div>1</div>
			<p>사전협의</p>
		</div>
		<div class="step-box">
			<div>2</div>
			<p>기본정보</p>
		</div>
		<div class="step-box">
			<div>3</div>
			<p>발송대상</p>
		</div>
		<div class="step-box">
			<div>4</div>
			<p>메시지</p>
		</div>
		<div class="step-box">
			<div>5</div>
			<p>승인절차/완료</p>
		</div>
	</div>
</div>
<div class="required-msg">
	<i class="required"></i> 는 필수 정보입니다.
</div>
<!-- end Step -->

<!-- begin 사전협의 -->
<section class="clearfix">
	<form id="frmMsg" name="frmMsg" onSubmit="return false;">
		<!-- 1단계 - 사전협의 -->
		<div class="hide step" id="step1">
			<jsp:include page="./priorConsultation-step.jsp" flush="true" />
		</div>
		<!-- 2단계 - 기본정보 -->
		<div class="hide step" id="step2">
			<jsp:include page="./basicInformation-step.jsp" flush="true" />
		</div>
		<!-- 3단계 - 발송대상/발송일 -->
		<div class="hide step" id="step3">
			<jsp:include page="./sendTarget-step.jsp" flush="true" />
		</div>
		<!-- 4단계 - 메시지 -->
		<div class="hide step" id="step4">
			<jsp:include page="./message-step.jsp" flush="true" />
		</div>
		<!-- 5단계 - 승인절차/완료 -->
		<div class="hide step" id="step5">
			<jsp:include page="./approval-step.jsp" flush="true" />
		</div>
		<div class="row section-left">
			<button type="button" class="btn btn-bg-main pull-right" id="nextBtn" onclick="smsReq.nextStep();" disabled>다음</button>
			<button type="button" class="btn btn-bg-main pull-right hide" id="saveBtn" onclick="smsReq.saveBtn();" disabled>발송요청</button>
			<button type="button" class="btn btn-border-sub2 pull-right hide" id="prevBtn" onclick="smsReq.prevStep();">이전</button>
			<button type="button" class="btn btn-border-main pull-right hide" id="tmpSave" onclick="smsReq.tmpSaveBtn();" disabled>임시저장</button>
		</div>
	</form>
</section>
<!-- end 사전협의 -->

<input type="hidden" id="msgDstic" value="SM"/>
<!-- <input type="hidden" id="orgImageNm1" class="orgImageNmArr" data-seq=""/>
<input type="hidden" id="orgImageNm2" class="orgImageNmArr" data-seq=""/>
<input type="hidden" id="orgImageNm3" class="orgImageNmArr" data-seq=""/> -->
<input type="hidden" id="kkoTmplCd" />
<!-- <input type="hidden" id="rcsMrFileNm" />
<input type="hidden" id="rcsMrFileSeq" /> -->
<input type="hidden" id="targetFileId" />

<!-- 대량문자 발송 메시지 체크리스트 팝업 -->
<jsp:include page="./dialog/sendCheck.jsp" flush="true" />
<!-- 발송대상 등록 팝업 -->
<jsp:include page="./dialog/sendTargetRegist.jsp" flush="true" />
<!-- 승인자 검색 팝업 -->
<jsp:include page="./dialog/userSearch.jsp" flush="true" />

<script type="text/javascript">
	$(document).ready(function() {
		smsReq.initValid(); // 유효성 초기셋팅
		smsReq.moveStep(smsReq.curStep, true);

		// 발송희망일 오늘 날짜 셋팅
		$("#sendTargetDt").val(dateFunc.getToday("-"));
	});

	var smsReq = smsReq || {};
	smsReq = (function() {
		return {
			groupUniqNo : '${groupUniqNo}',
			curStep: '${curStep}' || 1, // 등록 현재 단계
			isCheckListConfirm: false, // 체크리스트 체크여부
			testSendFlag:false,
			initValid: function() { // 유효성 초기 셋팅
				$("#frmMsg").validate({ 
					rules: { 
						msgType : {required: true}                 // 사전협의-메시지유형
						, sendCnt : {required: true}               // 사전협의-예상발송건수
						, cnsltContent1: {required: true}          // 사전협의-협의내용
						, cnsltContent2: {required: true}          // 사전협의-협의내용
						, cnsltContent3: {required: true}          // 사전협의-협의내용
						, msgTitle: {                              
							required: true,                        
							regexRangelength: [3, 30]              
						}                                          // 기본정보-발송명
						, sndrTelno: {                              
							required: true,                        
							digits: true,
							maxlength: 11
						}                                          // 기본정보-발신번호
						, inputTargetFileNm: {required: true}      // 발송대상 불러오기
						, sendUserFile: {required: true}           // 발송대상등록 파일
						, smsMsgTitle: {
							required: true, 
							maxbytelength: 60
						}                                          // 메시지-문자_메시지제목
						, smsTextarea: {                           
							required: true,                        
							maxbytelength: 90                      
						}                                          // 메시지-문자_메시지내용
						, smsMmsFileNm1: {required: true}          // 메시지-문자_이미지파일1
						, transTalk: {required: true}              // 메시지-알림톡_전환발송
						, talkTransTitle: { 
							required: true, 
							maxbytelength: 60
						}                                          // 메시지-알림톡_대체메시지제목
						, talkTransTextarea: {
							required: true,
							maxbytelength: 2000
						}                                          // 메시지-알림톡_대체메시지내용
						, rcsMsgTitle: {
							required: true,  
							maxlength: 30
						}                                          // 메시지-RCS_메시지제목
						, rcsTextarea: {                           
							required: true,                        
							maxlength: 100                      
						}                                          // 메시지-RCS_메시지내용
						, rcsMmsFileNm: {required: true}           // 메시지-RCS Standalone_이미지파일
						, rcsCrFileNm1: {required: true}           // 메시지-RCS Carousel_이미지파일
						, rcsCrFileNm2: {required: true}           // 메시지-RCS Carousel_이미지파일
						, rcsCrFileNm3: {required: true}           // 메시지-RCS Carousel_이미지파일
						, rcsCrFileNm4: {required: true}           // 메시지-RCS Carousel_이미지파일
						, rcsCrFileNm5: {required: true}           // 메시지-RCS Carousel_이미지파일
						, rcsCrFileNm6: {required: true}           // 메시지-RCS Carousel_이미지파일
						, rcsMsgTitle_CR1: {
							required: true,
							maxlength: 30
						}                                          // 메시지-RCS Carousel_메시지제목
						, rcsMsgTitle_CR2: {
							required: true,
							maxlength: 30
						}                                          // 메시지-RCS Carousel_메시지제목
						, rcsMsgTitle_CR3: {
							required: true,
							maxlength: 30
						}                                          // 메시지-RCS Carousel_메시지제목
						, rcsMsgTitle_CR4: {
							required: true,
							maxlength: 30
						}                                          // 메시지-RCS Carousel_메시지제목
						, rcsMsgTitle_CR5: {
							required: true,
							maxlength: 30
						}                                          // 메시지-RCS Carousel_메시지제목
						, rcsMsgTitle_CR6: {
							required: true,
							maxlength: 30
						}                                          // 메시지-RCS Carousel_메시지제목
						, rcsTextarea_CR1: {maxlength: 1300}       // 메시지-RCS Carousel_메시지내용
						, rcsTextarea_CR2: {maxlength: 1300}       // 메시지-RCS Carousel_메시지내용
						, rcsTextarea_CR3: {maxlength: 1300}       // 메시지-RCS Carousel_메시지내용
						, rcsTextarea_CR4: {maxlength: 1300}       // 메시지-RCS Carousel_메시지내용
						, rcsTextarea_CR5: {maxlength: 1300}       // 메시지-RCS Carousel_메시지내용
						, rcsTextarea_CR6: {maxlength: 1300}       // 메시지-RCS Carousel_메시지내용
				        , transRcs: {required: true}               // 메시지-RCS_전환발송
						, rcsTransTitle: {
							required: true, 
							maxbytelength: 60
						}                                          // 메시지-RCS_대체메시지제목
						, rcsTransTextarea: {                           
							required: true,                        
							maxbytelength: 90                    
						}                                          // 메시지-RCS_대체메시지내용
						, rcsTransMmsFileNm1: {required: true}     // 메시지-RCS_대체이미지파일
						, eachSendCnt: {requiredSendCnt: true}     // 메시지-발송희망일
						, secondApproval: {required: true}         // 승인절차/완료 - 팀원승인
					},
					messages: {
						msgType: {required: "메시지 유형을 선택하세요."}
						, sendCnt: {required: "예상 발송건수를 입력하세요."}
						, cnsltContent1: {required: "협의내용을 입력하세요."}
						, cnsltContent2: {required: "협의내용을 입력하세요."}
						, cnsltContent3: {required: "협의내용을 입력하세요."}
						, msgTitle: {
							required: "발송명을 입력하세요.",
							regexRangelength: "한글, 영문, 숫자, 공백, 특수기호(_),(–)를 사용하여 {0}~{1}자 이내만 입력 가능합니다.",
						}
						, sndrTelno: {
							required: "발신번호를 입력하세요.",
							digits: "'-'없이 숫자만 입력 가능합니다.",
							maxlength: "발신번호는 {0}자이내만 입력 가능합니다."
						}
						, inputTargetFileNm: {required: "대상자를 업로드하세요."}
						, sendUserFile: {required: "대상자를 업로드하세요."}
						, smsMsgTitle: {
							required: "메시지 제목을 입력하세요.",
							maxbytelength: "메시지 제목은 {0}byte이내만 입력 가능합니다."
						}
						, smsTextarea: {
							required: "메시지 내용을 입력하세요.", 
							maxbytelength: "메시지 내용은 {0}byte이내만 입력 가능합니다."
						}
						, smsMmsFileNm1: {required: "이미지 파일을 선택하세요."}
						, transTalk: {required: "전화발송을 선택하세요."}
						, talkTransTitle: {
							required: "대체 메시지 제목을 입력하세요.", 
							maxbytelength: "메시지 제목은 {0}byte이내만 입력 가능합니다." 
						}    
						, talkTransTextarea: {
							required: "대체 메시지 내용을 입력하세요.",
							maxbytelength: "메시지 내용은 {0}byte이내만 입력 가능합니다."
						}
						, rcsMsgTitle: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다."
						}
						, rcsTextarea: {                           
							required: "메시지 내용을 입력하세요.",                        
							maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."                      
						}
						, rcsMmsFileNm: {required: "이미지 파일을 선택하세요."}           
						, rcsCrFileNm1: {required: "이미지 파일을 선택하세요."}
						, rcsCrFileNm2: {required: "이미지 파일을 선택하세요."}
						, rcsCrFileNm3: {required: "이미지 파일을 선택하세요."}
						, rcsCrFileNm4: {required: "이미지 파일을 선택하세요."}
						, rcsCrFileNm5: {required: "이미지 파일을 선택하세요."}
						, rcsCrFileNm6: {required: "이미지 파일을 선택하세요."}
						, rcsMsgTitle_CR1: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다." 
						}
						, rcsMsgTitle_CR2: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다."
						}
						, rcsMsgTitle_CR3: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다."
						}
						, rcsMsgTitle_CR4: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다."
						}
						, rcsMsgTitle_CR5: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다."
						}
						, rcsMsgTitle_CR6: {
							required: "메시지 제목을 입력하세요.",
							maxlength: "메시지 제목은 {0}자이내만 입력 가능합니다."
						}
						, rcsTextarea_CR1: {maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."}                                          
						, rcsTextarea_CR2: {maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."}                                          
						, rcsTextarea_CR3: {maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."}                                          
						, rcsTextarea_CR4: {maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."}                                          
						, rcsTextarea_CR5: {maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."}                                          
						, rcsTextarea_CR6: {maxlength: "메시지 내용은 {0}자이내만 입력 가능합니다."}                                          
						, transRcs: {required: "전화발송을 선택하세요."}                                          
						, rcsTransTitle: {
							required: "대체 메시지 제목을 입력하세요.",
							maxbytelength: "메시지 제목은 {0}byte이내만 입력 가능합니다." 
						}     
						, rcsTransTextarea: {                           
							required: "대체 메시지 내용을 입력하세요.",                        
							maxbytelength: "메시지 내용은 {0}byte이내만 입력 가능합니다."                    
						}
						, rcsTransMmsFileNm1: {required: "이미지 파일을 선택하세요."}    
						, eachSendCnt: {requiredSendCnt: "발송희망건수를 입력하세요."}                   
						, secondApproval: {required: "팀원을 검색하세요."}               
				    },
					submitHandler: function (frm) {
		            },
				});

				// 다음버튼 활성화 제어
				$(document).on('input', ':input', function () {
					smsReq.chkBtnActive(smsReq.curStep);
			    });
			}, 
			initStep: function(step) {
				var tgt = "#step" + step;
				// 라디오, 셀렉트박스 초기화
				$(tgt).find("select").prop("selectedIndex", 0);

				var arr = [];
				$.each( $("input:radio:visible"), function(){
				  	var inputName = this.name;
				  	if( $.inArray( inputName, arr ) < 0 ){
				     	arr.push(inputName); 
				  	}
				});

				arr.forEach(function(item) {
					$("input[name="+ item +"]:first").attr('checked', true);	
				})

				// input, textarea 초기화
				$(tgt).find("input:not([readonly]), textarea").val('');
			},
			moveStep: function(curStep, isDetail) {

				// 단계 CSS 활성화 제어 
				$(".step").each(function(index, item){
					$(".step-box").eq(index).removeClass("active");
					$(item).addClass("hide");
					if(curStep - 1 == index) {
						$(".step-box").eq(index).addClass("active");
						$(item).removeClass("hide");	
					}
				})
				
				// 버튼 노출 제어
				$("#prevBtn").show();
				$("#tmpSave").show();
				$("#nextBtn").show();
				$("#saveBtn").hide();
				if(curStep == 1) {
					$("#prevBtn").hide();
					$("#tmpSave").hide();
				} else if(curStep == 4) {
					msgStepTalk.init();
					msgStepTalk.search();
				} else if(curStep == 5) {
					$("#tmpSave").hide();
					$("#nextBtn").hide();
					$("#saveBtn").show();
					// 1차승인자 셋팅
					$("#firstApproval").val('${emplBoName} / ${emplName}');
					$("#firstApproval").before('<input type="hidden" class="confirm-emp-id" value="${emplId}" data-emplhpno="${emplHpNo}">');
				}

				// 상세 조회
				if(!str.isEmpty(isDetail)) {
					this.setDetailView();
				}

				// 다음버튼 활성화 제어
				this.chkBtnActive(this.curStep);
			},
			prevAction: function() {
				// 초기화
				$("#tmpSave").attr("disabled", false);
				$("#nextBtn").attr("disabled", false);

				// step이동
				this.curStep--;
				this.moveStep(this.curStep);
			},
			prevStep: function() { // 이전 이동
				var _this = this;
				if(this.curStep == 5) {
					sweet.confirm('화면 이동 안내', '테스트 발송 값은 초기화됩니다.<br/>화면을 이동하겠습니까?', 'result', function(isConfirm) {
						if(isConfirm) {
							// 승인자 정보 초기화
							_this.testSendFlag = false;
							$("#testSendInfo").parent().find("input").val('');
							$("#testSendInfo .confirm-emp-id").remove();
							$(".test-send-copy:not(:first)").remove();
							$("#approvalDiv .row input").val('');
							$("#approvalDiv .confirm-emp-id").remove();
							$('.clearBtn').addClass('hide');
							_this.prevAction();
						}
					});
				} else {
					_this.prevAction();
				}
			},
			isValidFirstStep: function() {
				if(!this.isCheckListConfirm) {
					sweet.alert("대량문자 발송 메시지 체크리스트를 확인하세요.");
					return false;
				}

				// 사전협의 완료 체크
				var filterChk = $("input[name^=priorCnsltCh]").filter(function(idx, item) {
				    return $(item).prop("checked");
				})
				if(filterChk.length < 3) {
					sweet.alert("사전협의 완료 체크를 확인하세요.");
					return false;
				}
				return true;
			},
			nextStep: function() {
				// 다음버튼 클릭 시, 유효성 추가
				if(this.curStep == 1) {
					if(!this.isValidFirstStep()) return false;
				}
				
				// 다음 단계
				this.curStep++;

				// 버튼 제어
				$("#tmpSave").attr("disabled", true);
				$("#nextBtn").attr("disabled", true);
				$("#saveBtn").attr("disabled", true);

				// 다음 단계 노출 제어
				this.moveStep(this.curStep);
			},
			// 다음 버튼 활성화 여부 체크
			chkBtnActive: function(stepNum) {
				var isValid = $("#frmMsg").valid();

				if(isValid) {
					if(stepNum == 4) {
						// RCS Carousel시, 탭별 필수값 재체크
						var msgDstic = $("#msgDstic").val();
						if("CR" == msgDstic) {
							var crSlideCnt = Number($("input[name=rcsCRSlide]:checked").val());
							$("div[id^=rcsMmsTab]").slice(0, crSlideCnt).each(function(idx, item) {
								var imgFileNm = $(item).find(".rcsImgFileData").val();
								var title = $(item).find(".previewTitle").val();
								if(str.isEmpty(imgFileNm) || str.isEmpty(title)) isValid = false;
				     		})
						} else if("KM" == msgDstic) {
							var kkoTmplCd = $("#kkoTmplCd").val();
							if(str.isEmpty(kkoTmplCd)) isValid = false;	
						}
	
						// 메시지단계 > 발송 남은건수 체크
						var sendRestCnt = str.uncomma($("#sendRestCnt").val()); 
						if(sendRestCnt > 0) isValid = false;
					} else if(stepNum == 5) {
						isValid = this.testSendFlag;
					}
				}

				// 유효성체크
				$("#saveBtn:visible").attr("disabled", !isValid);
				$("#nextBtn").attr("disabled", !isValid);
				$("#tmpSave").attr("disabled", !isValid);
				
				if(!isValid) {
					return false;
				}
			},
			makeReplcBtn: function() {
				$(".replaceVal").empty();
				var html = "";

				// 최대 byte max값 필요
				if(!$.isEmptyObject(sendTargetRegist.replcBtnObj)) {

					Object.keys(sendTargetRegist.replcBtnObj).forEach(function(item, idx) {
						html += '<button type="button" class="btn btn-bg-main replaceBtn" style="min-width:70px;height:30px;font-size:13px;margin:0 5px 0 0;" onclick="msgStep.changeReplace(\'\${'+ item +'}\', this);">' + item + '(' + sendTargetRegist.replcBtnObj[item] + ')</button>'
					})
				}
				$(".replaceVal").append(html);
			},
			// 저장 이벤트
			saveBtn: function() {
				// 테스트발송 실행여부 체크
				if(!this.testSendFlag) {
					sweet.alert('테스트 발송 클릭 해주세요.');
					return false;
				}
				
				var url = '${pageContext.request.contextPath}/campaign/smsreq';
				smsReq.saveAjax(url, function() {
					sweet.alert('등록 완료되었습니다.', '', 'result', function(isConfirm) {
						location.href = '${pageContext.request.contextPath}/campaign/sendStatus.ibk';	
					});
				});
			},
			// 임시저장 이벤트
			tmpSaveBtn: function() {
				var url = '${pageContext.request.contextPath}/campaign/smsreq/temp';
				smsReq.saveAjax(url, function() {
					sweet.alert('작성중인 정보를 임시저장하였습니다.<br/>발송 현황 메뉴에서 이어서 작성 가능합니다.');
				});
			},
			// 저장 ajax
			saveAjax: function(url, callback) {
				var isValid = $("#frmMsg").valid();
				
				// 필수값 유효성체크
				if(!isValid) {
					return false;
				}

				var smsReqData = this.createReqData();
				console.log("smsReqData", smsReqData);
				
				$.ajax({
		            url: url,
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify(smsReqData)
		        }).done(function (data) {
			        if (callback != undefined) {
						callback();
					}
		        }).fail(function (xhr) {
		        	sweet.alert("캠페인 저장 중 에러 발생[" + xhr.status + "]<br>관리자에게 문의 바랍니다.");
		        });
			},
			createReqData: function() {
				var t21_pengagYms = "99991231235959"; // T21에 들어갈 발송일시 (제일 빠른일시)

		        // 발송예정시간 및 건수를 request param 으로 만드는 작업
		        var sendDateCount = [];
		        var day = str.replace($("#sendTargetDt").val(), "-", "");
		        var totNumber = str.uncomma($("#sendTotCnt").val());
		        $("#sendCntDiv .reservation-send-copy").each(function(i, item){
		            var h = $(item).find(".hour").val();
		            var m = $(item).find(".minute").val();
		            var cnt = $(item).find("input").val();
		            var dateTime = day + h + m + "00";
		            if(!str.isEmpty(cnt)) {
		            	if(t21_pengagYms > dateTime){
		                    t21_pengagYms = dateTime;
		                }
		                
		            	sendDateCount.push({
			            	pengagYms: dateTime,
				            sectionNumber: str.uncomma(cnt),
				            totNumber: totNumber
			            });
		            }
		        })
		        
		        // 예상발송건수 셋팅
		        var requestsNumber = $("#sendCnt").val();
		        if(!str.isEmpty(totNumber)) {
		        	requestsNumber = totNumber;
		        }
		        
				// 승인자
		        var confirmEmp = [];
		        $("#approvalDiv .confirm-emp-id").each(function () {
	                confirmEmp.push({
	                    emplId: $(this).val(),
	                    agreeType: "4",
	                    emplHpNo: $(this).data("emplhpno")
	                });
	            });

		        // SMS/LMS/MMS 메시지 제목, 내용 셋팅
		        var msgTitle = null;
		        var msg = null;
		        var msgDstic = $("#msgDstic").val();
		        if (msgDstic == "SM" || msgDstic == "SR") {
		            msgTitle = $("#msgCont p").text();
		        } else {
		            msgTitle = $("#previewTtile").text();
		            msg = $("#msgCont p").text();
		        }

				// 카드타입 셋팅
		        var cardType = "";
		        if("MR" == msgDstic) {
			        cardType = "Standalone";
		        } else if("CR" == msgDstic) {
		        	cardType = "Carousel";
		        }

		        // 치환변수 셋팅
		        var replaceVariableVal  = "";
		        if (!$.isEmptyObject(sendTargetRegist.replcBtnObj)) {
		            replaceVariableVal  = JSON.stringify(sendTargetRegist.replcBtnObj);
		        }
				
		        // MMS이미지 값 셋팅
		       	var mmsImgList = [];
		        $(".mmsImgFileData").each(function() {
			        var value = $(this).val();
			        var obj = null;
			        if(!str.isEmpty(value)) {
				        obj = {
						        mmsImgId: Number($(this).data("imgSeq")), 
						        imgNm: value, 
						        imgUploadPath: $(this).data("path"),
						        rcsYn: false
						};
				        mmsImgList.push(obj);
			        }
		     	});

				// 선택한 메시지 유형의 Div
		        var checkedIdx = $("input[name=chnlType]:checked").index("input[name=chnlType]");
				var $checkedMsgDiv = $(".msgStep:eq("+ checkedIdx +")");

	     		// 대체메시지 셋팅
		     	var altMsgDiv = "ZZ"; // 미사용(ZZ)
				var altMsgTitle = "";
				var altMsgText = "";
				var altMsgUseYn = $checkedMsgDiv.find(".transUse input:checked").val();
				if("Y" == altMsgUseYn) {
					altMsgDiv = ("MR" == msgDstic || "CR" == msgDstic) ? "MM" : $checkedMsgDiv.find("select[name=transMsgType]").val(); 
					altMsgTitle = $checkedMsgDiv.find(".previewTransTitle").val();
					altMsgText = $checkedMsgDiv.find(".previewTransTextarea").val();
					mmsImgList = [];
					$(".transImgFileData").each(function() {
				        var value = $(this).val();
				        var obj = null;
				        if(!str.isEmpty(value)) {
					        obj = {
							        mmsImgId: Number($(this).data("imgSeq")), 
							        imgNm: value, 
							        imgUploadPath: $(this).data("path"),
							        rcsYn: false
							};
					        mmsImgList.push(obj);
				        }
			     	});
				}
				
				// RCS 추가 셋팅
				var btnInfoList = [];
				var rcsImgList = [];
				if(msgDstic.endsWith("R")) {
			     	// 버튼정보 셋팅
			     	var crSlideCnt = Number($("input[name=rcsCRSlide]:checked").val()) + 1;
			     	var $parentArr = "CR" == msgDstic ? $parentArr = $(".rcsBtnParent").slice(1, crSlideCnt) : $(".rcsBtnParent").slice(0, 1);
					$parentArr.each(function(idx1, item1) {
						var btnArr = [];
						$(item1).find(".rcsBtnEl").each(function(idx2, item2) {
					     	var obj = {
				     			btnAction: $(item2).find("select").val(),
				     			btnNm: $(item2).find("input.previewRcsBtnNm").val()
					     	}
					     	$(item2).find("input:not(.previewRcsBtnNm)").each(function(idx3, item2) {
						     	var key = "info" + (idx3 + 1);
					     		obj[key] = $(item2).val()
					     	});
				     	   btnArr.push(obj);
				     	})
				     	btnInfoList.push(btnArr);
					})

					// RCS MMS 이미지 값 셋팅 
			     	if("CR" == msgDstic) { // 캐러셀 셋팅
			     		$("div[id^=rcsMmsTab]").slice(0, crSlideCnt-1).each(function(idx, item) {
							// 필수값(이미지)로 empty체크
				     		var imgNm = $(item).find(".rcsImgFileData").val();
				     		if(!str.isEmpty(imgNm)) {
				     			rcsImgList.push({
				     				mmsImgId: Number($(item).find(".rcsImgFileData").data("imgSeq")),
				     				imgNm: imgNm,
				     				imgUploadPath: $(item).find(".rcsImgFileData").data("path"),
				     				rcsYn: true,
				     				csTitle: $(item).find(".previewTitle").val(),
				     				csContents: $(item).find(".previewTextarea").val()
				     			})
				     		}
			     		})
			     	} else if("MR" == msgDstic) {
			     		var imgNm = $("#rcsMmsImage .rcsImgFileData").val();
			     		if(!str.isEmpty(imgNm)) {
				     		rcsImgList.push({
				     			mmsImgId: Number($("#rcsMmsImage .rcsImgFileData").data("imgSeq")),
				     			imgUploadPath: $("#rcsMmsImage .rcsImgFileData").data("path"),
			     				imgNm: imgNm,
			     				rcsYn: true
			     			})
			     		}
			     	}
		     	}

		     	// 승인URL발송문자
				var msgDsticNm = msgDstic == 'CR' ? "RCS MMS" : $("#expctMsgType option[value="+ msgDstic +"]").text();
				var confirmMessage =
		           /*  ' 발송업무 : ' + sendTypeName + '\n'
		            + ' 메시지타입 : ' + '${smssendlist.sendType}' + '\n'
		            + ' 총 발송건수 : ' + commaReqNum + '\n'
		            + ' 발송 일정 : ' + sendTime + ' \n'
		            + ' 승인 URL : ' + 'http://203.227.232.128/jsp/p_new.jsp?p='+ groupUniqNo +'&e='; */
		            
		            '위의 메시지내용은 [' 
		            + '${emplBoName}(${emplBocode})'
		            + '${emplName}(${emplId})]'
		            + '님께서 요청하신 대량' + msgDsticNm + '입니다.\n'
		            + '메시지 내용을 확인하신후 아래의 페이지에 접속하여 결재 또는 반려하여 주시기 바랍니다.\n'
		            + '결재를 하셔야 발송이 가능하니 신속히 결재하여 주시기 바랍니다.\n'
		            + '문의 : IT채널부 메시지센터 담당자\n'
		            + '☎ 031-229-2648, 2725\n'
		            + 'http://203.227.232.128/jsp/p_new.jsp?p='+ smsReq.groupUniqNo +'&e='
		            ;
				
		        return {
		            groupUniqNo: this.groupUniqNo                                                           // 그룹고유번호       
		            , groupNm: $("#msgTitle").val()                                                         // 발송명
		            , sendType: $("input[name=sendType]:checked").val()                                     // 발송업무 선택(마케팅/비마케팅)
		            , msgDstic: msgDstic == "CR" ? "MR" : msgDstic                                          // 메시지 타입 (SM/LM/MM/KM/SR/LR/MR)
		            , requestsNumber: requestsNumber                                                             // 예상발송 건수
		            , msgCtnt: msgTitle                                                                     // 메시지 내용 (LMS/MMS는 제목)
		            , umsMsgCtnt: msg                                                                       // UMS메시지 내용 (LMS/MMS는 제목)
		            , sndrTelno: $("#sndrTelno").val()                                                      // 발신번호
		            , inst: $("#inputTargetFileNm").val()                                                   // 실제 대상자 파일명 (T21)
		            , pengagYms: t21_pengagYms                                                              // 발송시간 T21에 대한 대표시간(제일 빠른시간)
		            , sendDateInfo: sendDateCount                                                           // 시간별 발송 건수
		            , confirmEmp: confirmEmp                                                                // 승인자 정보
		            , duplicateCheckYn : $("input[name=dupCheck]:checked").val()                            // 중복여부
		            , imageCount: mmsImgList.filter(function(el) {return el != null}).length                // MMS 이미지 파일 갯수
		            , mmsImgList: mmsImgList                                                                // MMS 이미지 원본명 배열
			        , rcsImgList: rcsImgList                                                                // 캐러셀 정보
		            , replaceVariableVal: replaceVariableVal                                                // T21_INFO 치환변수/MaxByte 값(JSON)
		            , confirmCheck: false                                                                   // 결재자 생략 기안 처리(false)
		            , progressStep: this.curStep                                                            // 단계   
		            , budgetConsultText: $("#cnsltContent1").val()                                          // 예산검토_협의내용   
		            , sendPurpose: $("input[name=sendPurpose]:checked").val()                               // 발송목적              
		            , lawDeliberationYn: $("input[name=lawDeliberationYn]:checked").val()                   // 준법심의여부            
		            , lawDeliberationText: $("#cnsltContent2").val()                                        // 준법심의_협의내용         
		            , relDeptConsultText: $("#cnsltContent3").val()                                         // 유관부서협의_협의내용       
		            , receiveAgreeCheckYn: $("#msgAgree").val()                                             // 수신동의체크 
		            , recvRefusalYn: $("#msgRefusal").val()                                                 // 수신거부적용여부          
			        , kkoTmplCd: $("#kkoTmplCd").val()                                                      // 알림톡템플릿ID
				    , cardType: cardType                                                                    // 카드타입1(Standalone/Carousel)
					, btnInfoList:btnInfoList                                                               // 버튼정보
		        	, altMsgDiv: altMsgDiv                                                                  // 대체메시지 유형
			        , altMsgTitle: altMsgTitle                                                              // 대체 메시지 제목
				    , altMsgText: altMsgText                                                                // 대체메시지 내용
					, confirmMessage: confirmMessage                                                        // 승인URL발송문자
					, targetFileId: $("#targetFileId").val()                                                                      // 대상자파일ID                                                            
		        };
			},
			// 상세 정보 셋팅
			setDetailView: function() {
				var msgDetail = [${msgDetail}]; // 22.08.04 json 포맷 이슈로 수정
 				if(!str.isEmpty(msgDetail)) {
					$("#tmpSave").attr("disabled", false);
					$("#nextBtn").attr("disabled", false);
					var data = msgDetail[0];
					console.log("data", data);
					this.setStep1(data);
					this.setStep2(data);
					this.setStep3(data);
					this.setStep4(data);
				}
			},
			setStep1: function(data) {
				this.isCheckListConfirm = true;
				$("#expctMsgType").val(data.msgDstic);
				$("#sendCnt").val(str.comma(data.requestsNumber));
				sendPriceChk(); // 예상발송비용 계산
				$("input[name=lawDeliberationYn][value="+ data.lawDeliberationYn +"]").prop("checked", true);      // 준법심의여부
				$("#cnsltContent1").val(data.budgetConsultText);                                                   // 협의내용
				$("#cnsltContent2").val(data.lawDeliberationText);
				$("#cnsltContent3").val(data.relDeptConsultText);
				$("input[name=priorCnsltChk]").prop("checked", true);
				$("input[name=sendPurpose][value="+ data.sendPurpose +"]").prop("checked", true).change();         // 발송목적
				var sendPurposeIdx = $("input[name=sendPurpose]:checked").index("input[name=sendPurpose]");
				var $tgt = sendPurposeIdx < 1 ? $(".chkSendPurpose").slice(0,1) : $(".chkSendPurpose").slice(1,2);
				$tgt.find("input").prop("checked", true);
				$("#lastChk").prop("checked", true).change();
			},
			setStep2: function(data) {
				$("input[name=sendType][value="+ data.sendType +"]").prop("checked", true);
				$("#msgTitle").val(data.groupNm).keyup();
			},
			setStep3: function(data) {
				if(!str.isEmpty(data.targetFileId)) {
					$("input[name=dupCheck][value="+ data.duplicateCheckYn +"]").attr("checked", true);
					$("#inputTargetFileNm").val(data.inst);
					$("#targetFileId").val(data.targetFileId);
					sendTargetStep.isFinish = true;
					$("#sendTargetDtl").show();
	
					// 발송대상 상세 조회
					sendTargetRegist.setReplcObj(data.replaceVariableVal);
					sendTargetRegist.callSndTgtDtlGrid();
				}
			},
			setStep4: function(data) {
				var msgDstic = data.msgDstic;
				var chnlType = msgDstic == "KM" ? "K" : msgDstic.substring(1,2);

				// 메시지유형 셋팅
				this.setMsgType(msgDstic);

				if("M" == chnlType) {
					this.setSms(data, msgDstic);
				} else if("K" == chnlType) {
					this.setTalk(data);
				} else {
					this.setRcs(data, msgDstic);
				}
			},
			setSms: function(data, msgDstic) {
				// 메시지 제목 및 내용 셋팅
				this.setMsgTitle(data, $('#smsMsgTitle'));
				this.setMsgContents(data, $('#smsTextarea'));

				// 이미지 셋팅
				if("MM" == msgDstic) {
					this.setSmsImage(data);
				}
				
				// 수신동의체크, 발신처번호, 발송희망일셋팅
				this.setCommon(data);
			},
			setTalk: function(data) {
				// 메시지내용 셋팅
				this.setTalkContents(data);

				// 대체케메시지 셋팅
				this.setTransContents(data);

				// 수신동의체크, 발신처번호, 발송희망일셋팅
				this.setCommon(data);
			},
			setRcs: function(data, msgDstic) {
				// 메시지 제목 및 내용 및 이미지 셋팅
				this.setRcsContents(data);

				// 대체케메시지 셋팅
				this.setTransContents(data);

				// 이미지 셋팅
				var altMsgDiv = data.altMsgDiv;
				if("MM" == altMsgDiv) {
					this.setTransImage(data);
				}

				// 수신동의체크, 발신처번호, 발송희망일셋팅
				this.setCommon(data);
			},
			setMsgType: function(msgDstic) {
				<!-- 2022-12-09 예산검토항목에서 메시지유형 콤보박스에서 빈값 선택 가능하므로 null체크 추가 -->
				if (str.isEmpty(msgDstic)) return;

				var chnlType = msgDstic == "KM" ? "K" : msgDstic.substring(1,2);
				$("input[name=chnlType][value="+ chnlType +"]").prop("checked", true).change();

				if(chnlType == "R") {
					$("#rcsMsgType").val(msgDstic).change();
				} else if(chnlType != "K") {
					$("#smsMsgType").val(msgDstic).change();
				} 
			},
			setMsgTitle: function(data, $tgt) {
				var msgDstic = data.msgDstic;
				var msgCtnt = data.msgCtnt || "";
				if(msgDstic.indexOf("S") == -1) {
					$tgt.val(msgCtnt).keyup();	
				}
			},
			setMsgContents: function(data, $tgt) {
				var msgDstic = data.msgDstic;
				var umsMsgCtnt = data.umsMsgCtnt || "";
				if(msgDstic.indexOf("S") > -1) {
					umsMsgCtnt = data.msgCtnt || "";	
				}
				$tgt.val(umsMsgCtnt).keyup();
			},
			setTalkContents: function(data) {
				$("#kkoTmplCd").val(data.kkoTmplCd);
				//msgStepTalk.talkDtlAjax(data);
				previewFunc.setTalkPreview({
					tmplNm: data.tmplNm,
					tmplMsg: data.tmplMsg,
					btnInfo: data.btnInfo
				});
			},
			setRcsContents: function(data) {
				var msgDstic = data.msgDstic;
				var msgCtnt = data.msgCtnt || "";
				var umsMsgCtnt = data.umsMsgCtnt || "";
				var imgNmArr = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelOptionText), "mediaPaths");             // 이미지명
				var imgSeqArr = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelOptionText), "imgSeqs");               // 이미지시퀀스목록
				var rejectNo = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelMsgText), "footer");                     // 수신거부전화번호
				var serviceType = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelMsgText), "serviceType");             // 서비스타입
				var extraTitle = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelMsgText), "extraTitle");               // 카드제목배열
				var extraDescription = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelMsgText), "extraDescription");   // 카드내용배열
				var buttonArr = previewFunc.converJsonObject(data.channelButtonText);
				var brandId = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelMsgText), "brandId");                     // 브랜드ID 추가
				var slideCount = previewFunc.findKeyValue(previewFunc.converJsonObject(data.channelOptionText), "slideCount") || 0;       // 슬라이드개수 추가
				var rcsMrType = "CM" == serviceType ? "CR" : msgDstic;
				var isCarousel = "CM" == serviceType;

				// 카드 셋팅
				if("MR" == msgDstic) {
					$("#rcsMmsCardSelect").val(rcsMrType).change();
				}

				// 제목, 내용 셋팅
				if("CM" == serviceType) {
					$("input:radio[name='rcsCRSlide']:input[value="+ slideCount +"]").click();
					$("div[id^=rcsMmsTab]").each(function(idx, item) {
						
						if(idx == 0) {
							$(item).find(".previewTitle").val(msgCtnt).trigger("keyup", {sIdx: 0});
							$(item).find(".previewTextarea").val(umsMsgCtnt).trigger("keyup", {sIdx: 0});
						} else {
							$(item).find(".previewTitle").val(extraTitle[idx-1]).trigger("keyup", {sIdx: idx});
							$(item).find(".previewTextarea").val(extraDescription[idx-1]).trigger("keyup", {sIdx: idx});
						}
					})
				} else {
					this.setMsgTitle(data, $('#rcsMsgTitle'));
					this.setMsgContents(data, $('#rcsTextarea'));
				}

				// 버튼 셋팅
				var _this = this;
				if(buttonArr != null && buttonArr.length > 0) {
					buttonArr.forEach(function(item, sIdx) {
						if(item.hasOwnProperty('suggestions')) {
							var actionArr = item.suggestions;
							var actionLen = actionArr.length;
	
							// 버튼 액션 셋팅
							var num = sIdx + 1;
							var $btnParent = "CM" == serviceType ? $("#rcsMmsTab" + num) : $("#SLMR").parent();
							actionArr.forEach(function(item, btnIdx) {
								// 버튼노출 셋팅
								$btnParent.find("input:radio[data-name=rcsBtn]:input[value='"+ actionLen +"']").click();
								
								// 버튼 값 셋팅
								_this.setJsonBtn(item.action, $btnParent.find(".rcsBtnEl").eq(btnIdx), sIdx, btnIdx);
							})
						}
					})
				}

				// 이미지값 셋팅
				if("MR" == msgDstic) {
					this.setRcsImage(imgNmArr, imgSeqArr, isCarousel);
				}
			},
			setJsonBtn: function(action, $tgt, sIdx, btnIdx) {
				var btnType = getRcsBtnType(action);
				var btnNm = action.displayText;
				var type = "";
				var info1 = "";

				// 23.01.02 RCS JSON 버튼 구분값 구하기(postback키값 제거)
				if("urlAction" == btnType) {
					type = "url";
					info1 = action.urlAction.openUrl.url;
				} else {
					type = "tel";
					info1 = action.dialerAction.dialPhoneNumber.phoneNumber;
				}
				$tgt.find("select").val(type).change();
				$tgt.find(".previewRcsBtnNm").val(btnNm).trigger("keyup", {sIdx: sIdx, btnIdx: btnIdx+1});
				$tgt.find("input:not(.previewRcsBtnNm)").val(info1);
			},
			setTransContents: function(data) {
				var transUseYn = data.altMsgDiv == "ZZ" ? "N" : "Y";
				var $tgt = $(".transUse input[value=" + transUseYn + "]");
				$tgt.prop("checked", true);
				msgStep.changeTransMsg($tgt, true);
				
				if("MM" != data.altMsgDiv) {
					$("select[name=transMsgType]").val(data.altMsgDiv);
				}
				$(".previewTransTitle").val(data.altMsgTitle).keyup();
				$(".previewTransTextarea").val(data.altMsgText).keyup();
			},
			setTransImage: function(data) {
				for(var i = 1; i <= data.imageCount; i++) {
					if(i > 1) {
						msgStep.addMmsFile($("#rcsMmsBtnAdd"), 'rcsTransMmsFile');
					}
					rcsTransFileChange($("#rcsTransMmsFile" + i), {
						orgFileName: data['imgNm' + i],
						imgSeq: data['seq' + i]
					}, true);
				}
			},
			setSmsImage: function(data) {
				for(var i = 1; i <= data.imageCount; i++) {
					if(i > 1) {
						msgStep.addMmsFile($("#smsMmsBtnAdd"), 'smsMmsFile');
					}
					messageStepSms.fileChange($("#smsMmsFile" + i), {
						orgFileName: data['imgNm' + i],
						imgSeq: data['seq' + i]
					}, true);
				}
			},
			setRcsImage: function(imgNmArr, imgSeqArr, isCarousel) {
				if(imgNmArr != null && imgNmArr!= "[]") {
					imgNmArr.forEach(function(imgNm, idx) {
						var num = idx + 1;
						var $tgt = isCarousel ? $("#rcsCRFile" + num) : $("#rcsMmsFile");
						if(!str.isEmpty(imgNm)) {
							rcsMmsFileClbk($tgt, {
								filename: imgNm,
								imgSeq: imgSeqArr[idx],
								sIdx: idx
							}, true);
						}
					})
				}
			},
			setCommon: function(data) {
				// 수신동의체크 셋팅
				$("#msgAgree[value=" + data.receiveAgreeCheckYn + "]").prop("checked", true);

				// 수신거부적용여부
				$("#msgRefusal[value=" + data.recvRefusalYn + "]").prop("checked", true);

				// 발신처번호
				$("#sndrTelno").val(data.sndrTelno).keyup();

				// 발송희망일 셋팅
				var sendTotCnt = str.comma(data.requestsNumber);
				$("#sendTotCnt").val(sendTotCnt);
				$("#sendRestCnt").val(sendTotCnt);
				msgStep.sendTimeAjax();
			},
		}
	})();
</script>
