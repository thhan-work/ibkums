<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
	.sectionLine {
		border-bottom: 1px solid #999;
		margin-top: 80px;
	}
</style>
<div class="section-left">
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4">
				<span>테스트 발송대상</span> <span class="icon-tooltip"
					data-tippy-content="테스트 메시지를 승인 전 확인할 수 있습니다.<br/>승인자를 제외한  대상자로 테스트 메시지 확인을 원하는 발송대상을 선택하시기 바랍니다. "><i
					class="fa fa-info"></i></span>
			</h3>
		</div>
		<div class="reg-right" id="testSendList">
			<div class="ele_area test-send-copy" id="testSendInfo">
				<div class="search_field inline-form test_send_field">
					<div class="input-group input-group-icon">
						<div class="group-btn">
							<input class="form-control inline-block testSender clearInput" placeholder="발송대상자를 검색하세요" readonly />
							<a href="javascript:void(0)" class="hide icon-clear clearBtn" onclick="clearInput(this)"></a>
						</div>
						<a href="javascript:void(0)" class="icon-search" onclick="callUserSearchPopup(this);"></a>
					</div>
					<p>
						<button type="button" class="btn btn-files btn-files-add" onclick="addTestSendTgt(this);"></button>
					</p>
				</div>
			</div>
		</div>
	</div>
	<button type="button" class="btn btn-bg-main pull-right" id="testSendBtn" onclick="testSend();">테스트발송</button>
	<div class="sectionLine"></div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4">
				<span class="required">승인자</span> 
				<span class="icon-tooltip" data-tippy-content="대량문자 등록 시 승인절차가 필요합니다.<br/>승인자의 승인 후 등록이 완료됩니다.">
					<i class="fa fa-info"></i>
				</span>
			</h3>
		</div>
		<div class="reg-right" id="approvalDiv">
			<div class="ele_area">
				<div class="search_field inline-form mrg-btm-5">
					<label class="mrg-right-10 font-weight-light width60 required">신청자</label>
					<div>
						<input type="text" id="firstApproval" name="firstApproval" class="form-control inline-block" readonly/>
					</div>
					<span class="mrg-left-10 mrg-top-5 width82"> &nbsp; </span>
				</div>
			</div>
			<div class="ele_area row">
				<div class="search_field inline-form mrg-btm-5">
					<label class="mrg-right-10 font-weight-light width60 required">팀원승인</label>
					<div class="input-group input-group-icon">
						<div class="group-btn">
							<input type="text" id="secondApproval" name="secondApproval" class="form-control inline-block clearInput" placeholder="팀원을 검색하세요" readonly />
							<a href="javascript:void(0)" class="hide icon-clear clearBtn" onclick="clearInput(this)"></a>
						</div>
						<a href="javascript:void(0)" class="icon-search" onclick="callUserSearchPopup(this);"></a>
					</div>
					<span class="mrg-left-10 mrg-top-5 width82"> &nbsp; </span>
				</div>
			</div>
			<div class="ele_area row">
				<div class="search_field inline-form mrg-btm-5">
					<label class="mrg-right-10 font-weight-light width60">추가승인</label>
					<div class="input-group input-group-icon">
						<div class="group-btn">
							<input type="text" class="form-control inline-block clearInput" placeholder="팀원을 검색하세요" readonly />
							<a href="javascript:void(0)" class="hide icon-clear clearBtn" onclick="clearInput(this)"></a>
						</div>
						<a href="javascript:void(0)" class="icon-search" onclick="callUserSearchPopup(this);"></a>
					</div>
					<span class="mrg-left-10 mrg-top-5 width82"> &nbsp; </span>
				</div>
			</div>
			<div class="ele_area row">
				<div class="search_field inline-form mrg-btm-5">
					<label class="mrg-right-10 font-weight-light width60">추가승인</label>
					<div class="input-group input-group-icon">
						<div class="group-btn">
							<input type="text" class="form-control inline-block clearInput" placeholder="팀원을 검색하세요" readonly />
							<a href="javascript:void(0)" class="hide icon-clear clearBtn" onclick="clearInput(this)"></a>
						</div>
						<a href="javascript:void(0)" class="icon-search" onclick="callUserSearchPopup(this);"></a>
					</div>
					<span class="mrg-left-10 mrg-top-5 width82"> &nbsp; </span>
				</div>
			</div>
			<div class="ele_area row">
				<div class="search_field inline-form mrg-btm-5">
					<label class="mrg-right-10 font-weight-light width60">추가승인</label>
					<div class="input-group input-group-icon">
						<div class="group-btn">
							<input type="text" class="form-control inline-block clearInput" placeholder="팀원을 검색하세요" readonly />
							<a href="javascript:void(0)" class="hide icon-clear clearBtn" onclick="clearInput(this)"></a>
						</div>
						<a href="javascript:void(0)" class="icon-search" onclick="callUserSearchPopup(this);"></a>
					</div>
					<span class="mrg-left-10 mrg-top-5 width82"> &nbsp; </span>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="section-right"></div>
<script type="text/javascript">
	// 커밋노논
	$(document).ready(function () {
		// 1차승인자 셋팅
		$("#firstApproval").val('${emplBoName} / ${emplName}');

		// clear버튼 노출제어
		showHideClearBtn();
	});
	
	// 승인자검색 팝업 호출
	var $userSrchTgt = null;
	function callUserSearchPopup(e) {
		$userSrchTgt = $(e).prev().find('.clearInput');
		$("#approvalNm").val('');
		$("#userSearch_table_per_page").val('5');
		userSearchGrid.perPage = 5;
		userSearchGrid.currentPage = 1;
		userSearchGrid.reload();
		$('#popupUserSearch').popup('show');

		// 수정필요
		setTimeout(function() { 
			$("#userSearch_table_reset").hide();
	  	}, 50);
	}

	// 테스트 발송자 추가
	function addTestSendTgt(e) {
		var $addEL = $(e).parent().parent().parent();
		var el = $addEL.parent().find(".test-send-copy");
		
		if($(e).hasClass("btn-files-add")) {

			// 최대 5개 까지 가능
			if(el.length > 4) {
				return false;
			}

			// 복사 EL
			var cloneEl = $("#testSendInfo").clone();

			// 복사 EL 초기화
			$(cloneEl).attr("id", "");
			$(cloneEl).find(".confirm-emp-id").remove();
			$(cloneEl).find(".clearInput").val('');
			$(cloneEl).find(".clearBtn").addClass('hide');
			var btnEl = $(cloneEl).find("button");
			btnEl.removeClass("btn-files-add");
			btnEl.addClass("btn-files-del");
			
			// 추가
			$addEL.parent().append(cloneEl);

			// clear버튼 노출제어
			showHideClearBtn();
		} else {
			$addEL.remove();
		}
	}

	// 테스트 발송
	function testSend() {
		// 유효성 체크
		var isSenderChk = true;
		$(".testSender").each(function(idx, item) {
			if(str.isEmpty($(item).val())) isSenderChk = false;
		})
		
		if(!isSenderChk) {
			sweet.alert("테스트 발송대상자를 추가하세요.");
			return false;
		}

		// 파라미터값 셋팅
		var smsReqData = smsReq.createReqData();

		// 테스트발송용 파라미터 추가
		// 치환메시지
        var targetReplaceVal  = "";
        if (!$.isEmptyObject(sendTargetRegist.firstTgtObj)) {
        	targetReplaceVal  = JSON.stringify(sendTargetRegist.firstTgtObj);
        }

    	// 테스트발송대상자
    	var testSenderList = [];
    	$("#testSendList .confirm-emp-id").each(function () {
    		testSenderList.push({
                emplId: $(this).val(),
                emplHpNo: $(this).data("emplhpno")
            });
        });
		
		var addData = {
			targetReplaceVal : targetReplaceVal
			, testSenderList: testSenderList    	
		}

		smsReqData = $.extend(addData, smsReqData);
		testSendAjax(smsReqData);
	}
	
	// 테스트 발송
	function testSendAjax(smsReqData) {
		$.ajax({
            url: '${pageContext.request.contextPath}/campaign/smsreq/testSend',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(smsReqData)
        }).done(function (data) {
        	if(data.success == 'true') {
        		smsReq.testSendFlag = true;
        		smsReq.chkBtnActive(smsReq.curStep);
        		sweet.alert("테스트발송 되었습니다.");
            } else {
            	sweet.alert("테스트 발송 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
            }
        }).fail(function (xhr) {
        	sweet.alert("테스트 발송 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
        });
	}

	// input clear 버튼 노출 제어 
	function showHideClearBtn() {
		$('.clearInput').on('input', function() {
			if($(this).val().length == 0) {
				$(this).siblings('.clearBtn').addClass('hide');
			} else {
				$(this).siblings('.clearBtn').removeClass('hide');
			}
		})
	}

	// input value 초기화
	function clearInput(e) {
		$(e).prev().val('');
		$(e).parent().find(".confirm-emp-id").remove();
		$(e).toggleClass('hide');
		smsReq.chkBtnActive(smsReq.curStep);
	}
</script>