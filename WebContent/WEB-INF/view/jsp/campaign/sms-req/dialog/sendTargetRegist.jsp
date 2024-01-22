<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div id="popupUserReg" class="modalPopup hide position-top" style="width: 900px">
	<div class="modal-header">
		<h1>발송대상 등록</h1>
	</div>
	<div class="modal-body">
		<div class="required-msg">
			<i class="required"></i> 는 필수 정보입니다.
		</div>
		<div class="row">
			<div class="inline-form search_field">
				<label class="width120 required font-weight-bold">중복체크<span class="mrg-left-5 icon-tooltip"
						data-tippy-content="툴팁 내용 전달 부탁드립니다."><i
						class="fa fa-info"></i></span></label>
				<div class="ele_area">
					<div class="search_field inline-form">
						<div class="inline-block">
							<label class="radio-container">중복제거
								 <input type="radio" name="dupCheck" value="Y" checked="checked" />
								 <span class="checkmark"></span>
							</label>
							<label class="radio-container">중복허용 
								<input type="radio" name="dupCheck" value="N" />
								<span class="checkmark"></span>
							</label>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="inline-form search_field">
				<label class="width120 required font-weight-bold">파일 등록</label>
				<div>
					<div class="filebox input-group width500">
						<input type="file" name="file" id="sendUserFile" class="file-upload"
							data-input="sendUserFileName" data-url="${pageContext.request.contextPath}/campaign/smsreq/file/customers"> 
						<input class="form-control inline-block" id="sendUserFileName"
							placeholder="파일을 선택하세요" readonly>
						<a href="javascript:void(0)" class="icon-input-del hide"></a>
						<div class="input-group-btn">
							<label for="sendUserFile" class="btn btn-inner" id="sendUserFileBtn">불러오기</label>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="hide" style="position:absolute;left:310px;top:250px;" id="loadingBar">
			<img src="/static/images/Loading.gif">
			<div style="position: relative;top: -54px;">
				<p style="text-align: center;background: white;width: 115px;margin: auto;">파일 검증 중 입니다.</p>
				<p style="text-align: center;">10,000건에 평균 3분 정도 소요됩니다.</p>
			</div>
		</div>
		<div class="row">
			<div class="search_area">
				<p>※ 파일등록 확장자는 EXCEL(*.xls, *.xlsx)만 가능합니다.</p>
				<p>※ 파일등록 안내</p>
				<p class="pdd-btm-10" style="margin-left: 12px">
					첫번째 행은 컬럼 제목으로 고객명, 고객번호, 휴대폰 번호는 필수 정보이며, 변수는 최대 10개까지 입력 가능합니다.<br>
					파일 등록 시 필수 컬럼명 검증 완료 후 파일이 등록되며 파일 검증이 진행됩니다.<br>
					발송대상 건수에 따라 전체 검증 소요시간이 상이합니다.<br> 고객명과 변수 컬럼은 발송될 메시지 본문 내용에
					포함되는 단어입니다.<br>
					<br> 샘플을 다운받아 편집 또는 아래 보기와 같이 편집 후 EXCEL형식(*.xls, *.xlsx)으로
					저장하여 등록하시기 바랍니다.
				</p>
				<div>
					<button class="btn btn-download width160" onclick="sendTargetRegist.sampleDownload(0)">일반발송 샘플 다운로드</button>
					<button class="btn btn-download width160" onclick="sendTargetRegist.sampleDownload(1)">치환형발송 샘플 다운로드</button>
				</div>
				<div class="row mrg-top-20 padding-20" style="background: #fff">
					<div class="markDiv"><span class="markFont">SAMPLE</span></div>
					<div class="table-responsive">
						<table class="table" style="max-width: 1000px; width: 1000px;">
							<thead>
								<tr>
									<th>고객명</th>
									<th>고객번호</th>
									<th>휴대폰번호</th>
									<th>변수1</th>
									<th>변수2</th>
									<th>변수3</th>
									<th>변수4</th>
									<th>변수5</th>
									<th>변수6</th>
									<th>변수7</th>
									<th>변수8</th>
									<th>변수9</th>
									<th>변수10</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>강길동</td>
									<td>1234567890</td>
									<td>010-2345-6789</td>
									<td>2,000원</td>
									<td>7월 17일</td>
									<td>입금</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
								</tr>
								<tr>
									<td>강길동</td>
									<td>1234567890</td>
									<td>010-2345-6789</td>
									<td>2,000원</td>
									<td>7월 17일</td>
									<td>입금</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
									<td>10%</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button class="btn btn-border-sub1" id="btnSendTargetCancel" onclick="sendTargetRegist.cancel();">닫기</button>
		<button class="btn btn-bg-main" id="btnSendTargetConfirm" onclick="sendTargetRegist.confirm();" disabled>확인</button>
	</div>
</div>
<script type="text/javascript">
	var sendTargetRegist = sendTargetRegist || {};
	sendTargetRegist = (function() {
		return {
			isUpload: false,
			hTimerT26: null,
			replcBtnObj: {},
			replcNmArr: [],
			firstTgtObj: null,
			sendTargetGrid: new IbkDataTableNew(),
			sampleDownload: function(type) { // 샘플다운로드
				var url = "/smsreq/download/sample/general";
				if(type) {
					url = "/smsreq/download/sample/extra";
				}
				location.href = url;
			},
			checkT26Timer: function(qMode) { // 파일검증 옵저버
				var _this = this;
				if(!qMode) qMode = '';
				
		        if(qMode == 'start') {
		            if(this.hTimerT26) clearInterval(this.hTimerT26);
		            this.hTimerT26 = setInterval(function(){
		            	_this.checkT26DataAjax(smsReq.groupUniqNo);
		            }, 5000);
		        } else if(qMode == 'stop') {
		            if(this.hTimerT26) clearInterval(this.hTimerT26);
		        }
			},
			checkT26DataAjax: function(qT26ID) { // 파일검증 체크 Ajax
				var _this = this;
				if(qT26ID) {
		            $.ajax({
		                url: "${pageContext.request.contextPath}/campaign/smsreq/targetFileStatusChk.do",
		                type: 'post',
		                cache: false,
		                async: false,
		                data: {targetId: qT26ID},
		                success: function (res) {
		                    if(res.status == "Y") {
		                    	_this.checkT26Timer('stop');
		                        $("#btnSendTargetConfirm").attr("disabled", false);
		                        $("#btnSendTargetCancel").attr("disabled", false);
		                        $("#sendUserFileBtn").attr("disabled", true);
		                        $("#sendUserFile").attr("disabled", true);
		                        $("#loadingBar").hide();
		                        sendTargetStep.isFinish = true;
		                        
		                     	// 치환변수값 조회
				    	        sendTargetRegist.getReplaceValAjax();
		                        
		                    }
		                },
		                error: function () {
		                    return;
		                }
		            });
		        }
			},
			// 치환변수값 셋팅
			getReplaceValNm: function(idx, json) {
				var rslt = "";
				var fieldLen = this.replcNmArr.length;
				
				if(fieldLen == 0) return rslt;
				
				if(idx <= fieldLen) {
					rslt = json[this.replcNmArr[idx-1]];
				}
				return rslt;
			},
			// 그리드 헤더 동적생성
			makeHeadColumn: function() {
				var fieldLen = this.replcNmArr.length; 
				if(fieldLen) {
					$("#sendTargetHead th:nth-child(n+6)").remove();
					var html = "";
			        for(var i = 0; i < fieldLen; i++) {
				        html +="<th>"+ this.replcNmArr[i] +"</th>"
			        }
			        $("#sendTargetHead").append(html);	
				}
			},
			// 그리드 바디 동적생성
			makeBodyColumn: function() {
				var fieldLen = this.replcNmArr.length; 
				if(fieldLen) {
					sendTargetColumn.columns.splice(5);
					var html = "";
			        for(var i = 1; i <= fieldLen; i++) {
			        	sendTargetColumn.columns.push({data: 'variable' + i,
					    	"render": function (data, type, row) {
					            return sendTargetRegist.getReplaceValNm(data, JSON.parse(row.replaceVariableVal));
					          }
					    })       
			        }
				}
			},
			callSndTgtDtlGrid: function() { // 발송대상 상세 호출
				var _this = this;
				var requestParam = function (data) {
				    data.perPage = _this.sendTargetGrid.perPage;
				    data.currentPage = _this.sendTargetGrid.currentPage;
				    data.batchTagtUniqNo = smsReq.groupUniqNo;
				    data.duplicateCheckYn = $("input[name=dupCheck]:checked").val();
			    };

			    // 그리드 컬럼 동적 생성
			    this.makeBodyColumn();
			    
			    // 그리드 조회
			    _this.sendTargetGrid.initDataTable("sendTarget_table", "/campaign/smsreq/sendTargetList", requestParam,
			    		sendTargetColumn.columns, sendTargetColumn.columnDefs, function(data) {
		    		if(data != null) {
			    		var succCnt = str.comma(data[0].succCnt);
			    		$("#succCnt").text(succCnt);
			    		$("#sendTotCnt").val(succCnt);
						$("#sendRestCnt").val(succCnt);
						$("#sendCnt").val(succCnt);
						sendPriceChk();
						
			    		$("#errCnt").text(str.comma(data[0].errCnt));
			    		$("#duplCnt").text(str.comma(data[0].duplCnt));
		        		$("#sendTargetGroupNm").text($("#msgTitle").val());
		        		$("#sendTargetRegYms").text(data[0].regYmsFmt);

						// 테스트발송시, 치환변수값 저장
						var replcVal = data[0].replaceVariableVal;
		        		if(!str.isEmpty(replcVal)) {
			        		_this.firstTgtObj = JSON.parse(replcVal);
			    		}
		       		}
				});
			},
			confirm: function() { // 확인 버튼
				$('#popupUserReg').popup('hide');
				$("#sendTargetDtl").show();
				this.callSndTgtDtlGrid();
				smsReq.chkBtnActive(3);
			},
			cancel: function() { // 취소 버튼
				var _this = this;
				 if(this.isUpload) {
					sweet.confirm("취소 안내", "작성중인 정보를 취소하시겠습니까?<br>모든 정보는 삭제됩니다.", 'result',  function(isConfirm) {
						if(isConfirm) {
							sendTargetStep.delSendTgtAjax(false);
							$('#popupUserReg').popup("hide");
						}
					});
				} else {
					$('#popupUserReg').popup("hide");	
				}
				 _this.checkT26Timer('stop');
				 _this.initSendTgtGrid();
			},
			// 발송상세 초기화
			initSendTgtGrid: function() {
				$("#sendTargetDtl").hide();
				$("#sendTarget_table tbody").empty();

				// 발송상세 콜백 변수들 초기화
				$("#succCnt").text('');
	    		$("#sendTotCnt").val('');
				$("#sendRestCnt").val('');
	    		$("#errCnt").text('');
	    		$("#duplCnt").text('');
	    		this.firstTgtObj = null;
			},
			setReplcObj: function(replcJsonStr) {
				if(!str.isEmpty(replcJsonStr)) {
			        var obj = JSON.parse(replcJsonStr);
		        	sendTargetRegist.replcBtnObj = obj;
		        	sendTargetRegist.replcNmArr = Object.keys(obj).filter(function(item){return item != '고객명'});

		        	// 치환변수 셋팅
		        	sendTargetRegist.makeHeadColumn();
			        smsReq.makeReplcBtn();
		        }
			},
			getReplaceValAjax: function() { // 치환변수 값 조회
				$.ajax({
		            url: '${pageContext.request.contextPath}/campaign/smsreq/getReplaceVal',
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify({groupUniqNo: smsReq.groupUniqNo})
		        }).done(function (data) {
		        	sendTargetRegist.setReplcObj(data);
		        }).fail(function (xhr) {
		        	sweet.alert("치환변수 값 조회 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
		        });
			},
			insertExcelBlobAjax: function(param) { // 대상자 엑셀 정보 저장
				$.ajax({
		            url: '${pageContext.request.contextPath}/campaign/smsreq/insertExcelBlob',
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify(param)
		        }).done(function (data) {
		        	if("SUCCESS" == data.result) {
						// file ID셋팅
		        		$("#targetFileId").val(data.fileId);
		        		
		    			// 파일검증(M1) 체크 
		    	        sendTargetRegist.checkT26Timer('start');
		        	}
		        }).fail(function (xhr) {
		        	sweet.alert("대상자 엑셀 정보 저장 중 오류가 발생했습니다.<br>관리자에게 문의 바랍니다.");
		        });
			}
		}
	})();
	
	$('#sendUserFile').fileupload({
	    dataType: 'json',
	    add: function (e, data) {
	        var uploadFile = data.files[0];
	        var isValid = true;
	        if (!(/xls|xlsx|XLS|XLSX/i).test(uploadFile.name)) {
	        	sweet.alert('xls, xlsx만 가능합니다!');
	            isValid = false;
	            return false;
	        }
	        data.formData = { 'groupUniqNo': smsReq.groupUniqNo};
	        if (isValid) {
	            data.submit();
	        }
	    },
	    done: function (e, data) {
	        var result = data.result;
	        
	        if (result.message) {
	        	sweet.alert(result.message);

	        	if("FAIL" == result.result) {
	        		return false;	
        		}
	        }
	        var fileOrgNm = data.files[0].name;
	        var fileNm = result.fileNm;
	        
	        $("#sendUserFileName").val(fileOrgNm);
	        $("#inputTargetFileNm").val(fileOrgNm);
	        $("#loadingBar").show();
	        $("#sendUserFileBtn").attr("disabled", true);
	        $("#sendUserFile").attr("disabled", true);
	        $("#btnSendTargetCancel").attr("disabled", true);
	        $("#btnSendTargetConfirm").attr("disabled", true);
	        $("input[name=dupCheck]").attr("disabled", true);

	        // BLOB저장
	        sendTargetRegist.isUpload = true;
	        sendTargetRegist.insertExcelBlobAjax({
	        	fileOrgNm: fileOrgNm,
	        	fileNm: fileNm,
	        });
	        
	    }
	});

</script>