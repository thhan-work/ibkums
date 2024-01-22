<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="section-left">
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="required pdd-top-4">발송대상</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area file-copy">
				<div class="search_field inline-form mrg-btm-5">
					<div class="filebox input-group width-100 mrg-right-10">
						<div class="filebox input-group width-100">
                            <input class="form-control inline-block" placeholder="파일을 선택하세요" name="inputTargetFileNm" id="inputTargetFileNm" readonly>
                            <div class="input-group-btn ">
                                <label class="btn btn-inner" onclick="sendTargetStep.callSendRegPopup(this);">불러오기</label>
                            </div>
                        </div>
					</div>
					<div class="input-group-btn hide" style="display:none;max-width:80px;" id="test">
		              	<label class="btn btn-inner" style="width:120px;background: #b360a9;color: white;" onclick="testDownBlob();">테스트(BLOB다운로드)</label>
		          	</div>
				</div>
			</div>
		</div>
	</div>
	<div class="hide row" id="sendTargetDtl">
		<p class="page-mid-header">발송대상 상세</p>
		<div class="table-result">
			총 <strong class="split" id="sendTarget_table_total_cnt">0</strong>
			<select class="search-limit" id="sendTarget_table_per_page">
				<option value="10">10개씩 보기</option>
				<option value="20">20개씩 보기</option>
				<option value="30">30개씩 보기</option>
			</select>
			<div class="pull-right mrg-top-5">
				성공 : <span class="color-blue split mrg-right-15 font-weight-bold" id="succCnt">0</span>
				실패 : <span class="color-fail split mrg-right-15 font-weight-bold" id="errCnt">0</span>
				중복 : <span class="font-weight-bold" id="duplCnt">0</span>
			</div>
		</div>
		<div class="table-responsive">
			<table class="table" style="width:100%;" id="sendTarget_table">
				<thead>
					<tr id="sendTargetHead">
						<th>No.</th>
						<th>검증결과</th>
						<th>고객명</th>
						<th>고객번호</th>
						<th>휴대폰번호</th>
					</tr>
				</thead>
				<tbody>
		        	<tr>
		                <td colspan="4" style="height:215px">
		                	<div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
		                </td>
		            </tr>
		        </tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
	var sendTargetStep = sendTargetStep || {};
	sendTargetStep = (function() {
		return {
			isFinish: false,
			initRegPopup: function() {
				$("#sendUserFileName").val('');
				$("#sendUserFile").val('');
				$("#inputTargetFileNm").val('').trigger('input');
		        $("#btnSendTargetConfirm").attr("disabled", true);

		        sendTargetRegist.isUpload = false;
		        sendTargetStep.isFinish = false;
			},
			callSendRegPopup: function(e) { // 발송등록 팝업 호출
				$("input[name=dupCheck]").attr("disabled", false);
				$("input[name=dupCheck][value='Y']").prop("checked", true);
				// 불로오기 비활성화 제거
				$("#sendUserFileBtn").attr("disabled", false);
                $("#sendUserFile").attr("disabled", false);
				
				var _this = this;
				if(this.isFinish) {
					sweet.confirm("발송대상 재등록 안내", "파일 검증이 완료된 발송대상이 등록되어 있습니다.<br>재등록을 하면 이전 파일은 삭제됩니다.<br>재등록 하시겠습니까?", 'result',  function(isConfirm) {
						if(isConfirm) {
							sendTargetRegist.initSendTgtGrid();
							_this.delSendTgtAjax(true);
						}
					});					
				} else {
					_this.initRegPopup();
					 $('#popupUserReg').popup('show');
				}
			},
			delSendTgtAjax: function(isShow) {
				var _this = this;
				var targetFileId = $("#targetFileId").val();

				if(str.isEmpty(targetFileId)) {
					sweet.alert("대상자 파일이 존재하지 않습니다.");
					return false;
				}
				
				$.ajax({
		            url: '${pageContext.request.contextPath}/campaign/smsreq/deleteSendTgt',
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify({
		            	targetId: smsReq.groupUniqNo,
		            	targetFileId: targetFileId
	            	})
		        }).done(function (data) {
			        if(data.result == "SUCCESS") {
			        	_this.initRegPopup();
	
			        	// 4단계 초기화
			        	msgStep.initMsgStep();
	
			        	if(isShow) $('#popupUserReg').popup('show');
			        } else {
			        	sweet.alert("대상자 삭제 중 에러 발생[" + xhr.status + "]<br>관리자에게 문의 바랍니다");
			        }
		        }).fail(function (xhr) {
		        	sweet.alert("대상자 삭제 중 에러 발생[" + xhr.status + "]<br>관리자에게 문의 바랍니다.");
		        });
			},
		}
	})();

	// TODO 삭제예정
	$("header").dblclick(function() {
	    $("#test").show();
	});
	function testDownBlob() {
		location.href = '${pageContext.request.contextPath}/campaign/smsreq/testDownBlob/4';
	}
	
</script>
