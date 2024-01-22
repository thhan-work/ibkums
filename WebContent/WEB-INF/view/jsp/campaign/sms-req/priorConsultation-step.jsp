<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="section-left">
	<!-- begin 예산 검토-->
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="required">예산 검토</h3>
			<p>유관부서와 예산 협의</p>
		</div>
		<div class="reg-right">
			<div class="pdd-btm-10">
				<strong>예상 발송비용</strong>
			</div>
			<div class="ele_area">
				<div class="search_field mrg-right-5 mrg-btm-5">
					<label>메시지 유형</label>
					<div class="width150">
						<select class="width-100 requiredStep1" id="expctMsgType" name="expctMsgType" onchange="changeExpctMsgType(this);">
							<option value="">메시지 유형 선택</option>
							<option value="SM">SMS</option>
							<option value="LM">LMS</option>
							<option value="MM">MMS</option>
							<option value="KM">알림톡</option>
							<option value="SR">RCS SMS</option>
							<option value="LR">RCS LMS</option>
							<option value="MR">RCS MMS</option>
						</select>
					</div>
				</div>
				<span class="mrg-right-5">X</span>
				<div class="search_field mrg-right-5">
					<label for="sendCnt">예상 발송건수</label>
					<div class="width120">
						<input type="text" id="sendCnt" name="sendCnt" class="form-control requiredStep1" placeholder="입력하세요" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');"/>
					</div>
				</div>
				<span class="mrg-right-5">=</span>
				<div class="search_field">
					<label>예상 발송비용</label>
					<div class="width150">
						<input type="text" id="sendPrice" class="form-control" readonly value="0" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="search_area">
					<div class="inline-block vertical-align-top mrg-right-20">
						<strong>발송단가</strong>
					</div>
					<div class="inline-block width-auto color-gray">
						SMS : 8.8원, LMS : 26.6원, MMS 55.0원, 알림톡 : 10원, 채널+ : 10원<br />
						부가세포함, 2020년 7월 기준(변경시 재공지)
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-head-white">
					<colgroup>
						<col width="50%" />
						<col width="50%" />
					</colgroup>
					<thead>
						<tr>
							<th>발송비용 200만원 초과인 경우</th>
							<th>발송비용 200만원 미만인 경우</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="text-left">전략기획부, 개인디지털채널부와 합의<br />
								<p class="color-gray">- 전략기획부 : 예산</p>
								<p class="color-gray">- 개인디지털채널부 : LMS 발송</p>
							</td>
							<td class="text-left vertical-align-top">합의생략</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="row ele_area">
				<div class="search_field display-block">
					<label for="cnsltContent1" class="required">협의내용</label>
					<div>
						<textarea rows="3" id="cnsltContent1" name="cnsltContent1"
							class="width-100 requiredStep1" placeholder="협의내용을 입력하세요"></textarea>
					</div>
				</div>
			</div>
			<div class="row pdd-top-10">
				<label class="check-container font-weight-bold">사전 협의 완료 
					<input type="checkbox" id="priorCnsltChk1" class="requiredStep1" name="priorCnsltChk" value="Y" />
					<span class="checkmark"></span>
				</label>
			</div>
		</div>
	</div>
	<!-- end 예산 검토 -->
	<!-- begin 준법심의 -->
	<div class="row clearfix pdd-top-40">
		<div class="reg-left">
			<h3 class="required">준법심의</h3>
			<p>발송 메시지 사전심의</p>
		</div>
		<div class="reg-right">
			<div class="pdd-btm-10">
				<strong>마케팅(광고) 문자메시지인 경우</strong>
				<p class="pdd-top-5">
					준법지원부 준법감시인의 사전심의를 받아야 하며 준법심의 없이 광고 시 은행법 등<br /> 위반으로 금융감독원 제재 및
					과태료 부과 대상
				</p>
			</div>
			<button type="button" id="btnPopupLmsSendCheckList"
				class="btn btn-download width-100">대량문자 발송 메시지 체크리스트</button>
			<div class="row ele_area">
				<div class="search_field inline-form">
					<label class="width120 required">준법심의 대상여부</label>
					<div class="inline-block">
						<label class="radio-container">대상
							<input type="radio" name="lawDeliberationYn" value="Y" checked="checked"/>
							<span class="checkmark"></span>
						</label>
						<label class="radio-container">대상아님 
							<input type="radio" name="lawDeliberationYn" value="N" />
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
			</div>
			<div class="row ele_area">
				<div class="search_field display-block">
					<label class="required">협의내용</label>
					<div>
						<textarea rows="3" id="cnsltContent2" name="cnsltContent2"
							class="width-100 requiredStep1" placeholder="협의내용을 입력하세요"></textarea>
					</div>
				</div>
			</div>
			<div class="row pdd-top-10">
				<label class="check-container font-weight-bold">사전 협의 완료
					<input type="checkbox" id="priorCnsltChk2" class="requiredStep1" name="priorCnsltChk" value="Y" />
					<span class="checkmark"></span>
				</label>
			</div>
		</div>
	</div>
	<!-- end 준법심의 -->
	<!-- begin 유관부서협의 -->
	<div class="row clearfix pdd-top-40">
		<div class="reg-left">
			<h3 class="required">유관부서협의</h3>
			<p>유관부서와 일정 협의</p>
		</div>
		<div class="reg-right">
			<div class="pdd-btm-10">
				<strong>IBK 고객센터</strong>
				<p class="pdd-top-5">
					IBK 고객센터 응대방안 사전협의<br /> IBK 고객센터 대량문자 발송요청 시스템에 사전등록<br /> 발송요청일
					3~5일 전 사전협의 완료<br /> 문자내용, 일정, 발송시간, 분산발송여부 등 협의<br />
				</p>
			</div>
			<button type="button" class="btn btn-inner width-100">IBK 고객센터 대량문자 발송요청 시스템 바로가기</button>
			<div class="row ele_area">
				<div class="search_field display-block">
					<label class="required">협의내용</label>
					<div>
						<textarea rows="3" id="cnsltContent3" name="cnsltContent3"
							class="width-100 requiredStep1" placeholder="협의내용을 입력하세요"></textarea>
					</div>
				</div>
			</div>
			<div class="row pdd-top-10">
				<label class="check-container font-weight-bold">사전 협의 완료
					<input type="checkbox" id="priorCnsltChk3" class="requiredStep1" name="priorCnsltChk" value="Y" />
					<span class="checkmark"></span>
				</label>
			</div>
		</div>
	</div>
	<!-- end 유관부서협의 -->
</div>
<div class="section-right"></div>
<script type="text/javascript">
	//예상 발송비용 > 메시지 유형 변경 이벤트
	function changeExpctMsgType(e) {
		sendPriceChk();

		// 메시지단계 > 메시지유형 셋팅
		var expctMsgType = $(e).val();
		smsReq.setMsgType(expctMsgType);

		$("#msgDstic").val(expctMsgType);
	}
	
	// 예상 발송비용 > 예상 발송건수 입력 이벤트
	$("#sendCnt").keyup(function() {
		sendPriceChk();
	});
	
	// 대량문자 발송 메시지 체크리스트 팝업 노출
	$("#btnPopupLmsSendCheckList").click(function() {
		//$("#frmMsg").validate().cancelSubmit = true;
		$('#popupLmsSendCheckList').popup('show');
	}); 
	
	// 예상 발송비용 값 체크 메서드
	function sendPriceChk() {
		var msgType = $("#expctMsgType").val();
		var sendCnt = str.uncomma($("#sendCnt").val());
		var sendPrice = 0;
		var check = /^[0-9]+$/;
		if(msgType == '') {
			sweet.alert("메시지 유형을 선택해 주세요.");
			$("#sendCnt").val('');
			$("#sendPrice").val(sendPrice);
			return;
		}

		if(msgType == 'SM') {
			sendPrice = 8.8;
		} else if(msgType == 'LM') {
			sendPrice = 26.6;
		} else if(msgType == 'MM') {
			sendPrice = 55.0;
		} else {
			sendPrice = 10;
		}
		
		var price = Number((sendPrice * sendCnt).toFixed(2));
		$("#sendPrice").val(str.comma(price));
	}
</script>