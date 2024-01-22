<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 대량문자 발송 메시지 체크리스트 팝업 -->
<div id="popupLmsSendCheckList" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1>대량문자 발송 메시지 체크리스트</h1></div>
  <div class="modal-body">
    <div class="pdd-top-10">메시지 발송 목적 및 내용에 따라 아래 체크리스트를 작성하시기 바랍니다.</div>
    <div class="row">
      <h2 class="font-size-14">1. 발송 목적</h2>
      <table class="table table-check-list mrg-top-10">
        <colgroup>
          <col width="120" />
          <col width="*" />
          <col width="40" />
        </colgroup>
        <tbody>
        <tr>
          <th>마케팅 목적</th>
          <td>상품가입, 이용 독려 등</td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="sendPurpose" value="marketing"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        <tr>
          <th>고객관리 목적</th>
          <td>안부인사, 기념일 축하 등</td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="sendPurpose" value="custCare"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        <tr>
          <th>고객안내 목적</th>
          <td>만기안내, 서류안내 등</td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="sendPurpose" value="custInfo"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="row chkSendPurpose">
      <h2 class="font-size-14">2. 마케팅 목적의 메시지인 경우</h2>
      <table class="table table-check-list mrg-top-10">
        <colgroup>
          <col width="*" />
          <col width="40" />
        </colgroup>
        <tbody>
        <tr>
          <td>
            <p><strong>영업점에서 작성한 마케팅 문자메시지의 경우 <span class="color-red">준법감시인의 사전 심의</span>를 받으셨습니까?</strong></p>
            <p>임의작성 메시지를 준법심의 없이 광고 시 은행법 등 위반으로서 금융감독원의 제재 및 과태료 부과 대상</p>
          </td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="confirmChk"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <p><strong>준법심의 받은 문자메시지를 <span class="color-red">내용 변경 없이 그대로 사용</span>하셨습니까? (임의 변경 불가)</strong></p>
            <p>필수삽입문구인 ‘(광고)’ + ‘은행명’  + ‘(무료)수신동의철회안내‘ 등이 생략되지 않도록 유의<br/>
              임의 삭제 시 정보통신망법 위반으로서 금융감독원 제재 및 과태료 부과 대상</p>
          </td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="confirmChk"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <p><strong>준법심의 <span class="color-red">유효기간을 준수</span>하셨습니까? (유효기간 경과 시 준법심의절차를 통해 갱신)</strong></p>
          </td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="confirmChk"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <p><strong><span class="color-red">신탁계약(특정금전신탁 등)의 경우 문자메시지 마케팅이 불가</span>합니다. 확인하셨습니까?</strong></p>
            <p>자본 시장법, 금융투자업규정 상 불건전 영업행위로서 금융감독원 제재 및 과태료 부과 대상</p>
          </td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="confirmChk"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="row chkSendPurpose">
      <h2 class="font-size-14">3. 고객관리, 고객안내 목적의 메시지인 경우</h2>
      <table class="table table-check-list mrg-top-10">
        <colgroup>
          <col width="*" />
          <col width="40" />
        </colgroup>
        <tbody>
        <tr>
          <td>
            <p><strong>문자메시지 내용에 <span class="color-red">상품 가입 또는 이용을 권유하는 문구가 없습니까?</span></strong></p>
            <p>광고성 문자메시지는 반드시 준법지원부의 심의절차를 이행하시기 바람</p>
            <p>미심의 또는 신탁 관련 마케팅 문자메시지 발송 시 금융감독원 제재 및 과태료 부과 대상</p>
          </td>
          <td>
            <label class="check-container">&nbsp;
              <input type="checkbox" name="confirmChk"/>
              <span class="checkmark"></span>
            </label>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="row">
      <div class="msg-box">
        <strong class="color-red">
          발송목적에 따라 체크리스트를 적정하게 작성하여 주시기 바라며, 마케팅 목적의 문자메시지 발송 시 은행법,
          자본시장과 금융투자업에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령에 의해 규정된 사항을
          준수하지 않을 경우 금융감독원 제재 및 과태료가 부과될 수 있으므로 유의하시기 바랍니다.
        </strong>
      </div>
      <div class="pdd-top-10 pdd-left-20">
        <p>참고문서 : 문자메시지 발송 체크리스트 신설 (20.07.14)</p>
        <p>문의전화(준법지원부) 8-6340, 5450</p>
      </div>
    </div>
    <div class="row">
      <label class="check-container font-weight-bold">문자메시지 발송 체크리스트를 적정하게 점검하였으며, 문자메시지를 작성하고자 함
        <input type="checkbox" name="confirmChk" id="lastChk"/>
        <span class="checkmark"></span>
      </label>
    </div>
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-border-sub1 popupLmsSendCheckList_close" onclick="btnClose();">닫기</button>
    <button type="button" class="btn btn-bg-main" id="confirmBtn" onclick="confirmBtn();" disabled>확인</button>
  </div>
</div>
<script type="text/javascript">
	//체크리스트 팝업 > 발송 목적 변경 이벤트 (1가지만 선택 가능)
	$("input[type='checkbox'][name='sendPurpose']").change(function(){
		var index = $("input[name='sendPurpose']").index(this);
		if($(this).prop('checked')) {
			$("input[type='checkbox'][name='sendPurpose']").prop("checked", false);
			$(this).prop("checked", true);
		}

		// 발송 목적에 따른 체크박스 활성화 제어
		$(".chkSendPurpose").find("input[name='confirmChk']").prop("disabled", false);
		$(".chkSendPurpose").find("input[name='confirmChk']").prop("checked", false);
		if(index == 0) {
			$(".chkSendPurpose").eq(1).find("input[name='confirmChk']").prop("disabled", true);
		} else {
			$(".chkSendPurpose").eq(0).find("input[name='confirmChk']").prop("disabled", true);
		}
	
		// 체크여부 확인
		messageAllCheck();
	});
	
	// 체크리스트 팝업 > 체크 변경 이벤트
	$("input[type='checkbox'][name='confirmChk']").change(function(){
		// 체크여부 확인
		messageAllCheck();
	});

	// 체크리스트 팝업 > 체크 여부 확인
	function messageAllCheck() {
		var allChk = false;
		var sendPurposeIdx = $("input[name=sendPurpose]:checked").index("input[name=sendPurpose]");
		var $tgt = sendPurposeIdx < 1 ? $(".chkSendPurpose").slice(0,1) : $(".chkSendPurpose").slice(1,2);
		var noChkLen = $tgt.find("input:not(:checked)").length;
		
		if(!noChkLen) {
			allChk = $("#lastChk").is(":checked");	
		}

		$("#confirmBtn").attr("disabled", !allChk);
	}

	// 체크리스트 팝업 > 닫기
	function btnClose() {
		// 체크박스 초기화
		$("input[type='checkbox'][name='confirmChk']").prop("checked", false);
		$("input[type='checkbox'][name='sendPurpose']").prop("checked", false);
	}

	function confirmBtn() {
		smsReq.isCheckListConfirm = true;
		$('#popupLmsSendCheckList').popup('hide');
	}
</script>