<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div class="row clearfix">
	<div class="reg-left">
		<h3 class="pdd-top-4">
			<span class="required">템플릿 선택</span> <span class="icon-tooltip"
				data-tippy-content="사전 정상 승인된 템플릿만 확인 가능합니다.<br/>템플릿이 확인되지 않는다면 템플릿 등록 및 승인을 확인 후 사용하시기 바랍니다."><i
				class="fa fa-info"></i></span>
		</h3>
	</div>
	<div class="reg-right">
		<div>
			<div class="search_area search_inner">
				<div class="search_field width180">
					<label>템플릿 ID / 템플릿명</label>
					<div>
						<input type="text" class="form-control" placeholder="검색어를 입력하세요" id="talkSearchWord" />
					</div>
				</div>
				<div class="search_field">
					<label>등록일</label>
					<div>
						<input type="text" class="form-control date" placeholder="선택하세요" readonly id="talkRegYms"/>
					</div>
				</div>
				<div class="search_field">
					<button type="button" class="btn btn-reset btn-sm width60" onclick="msgStepTalk.init();">초기화</button>
					<button type="button" class="btn btn-search btn-sm width60" onclick="msgStepTalk.search();">검색</button>
				</div>
			</div>
		</div>

		<!-- begin table -->
		<div class="row">
			<div class="table-result">
				총 <strong class="split" id="alimtalk_table_total_cnt">0</strong>
				<select class="search-limit" id="alimtalk_table_per_page">
					<option value="5">5개씩 보기</option>
					<option value="10">10개씩 보기</option>
					<option value="20">20개씩 보기</option>
					<option value="30">30개씩 보기</option>
				</select>
			</div>
			<div class="table-responsive" id="alimtalkDiv">
				<table class="table table-hover table-inner" id="alimtalk_table">
					<colgroup>
						<col width="60" />
						<col width="*" />
						<col width="100" />
						<col width="80" />
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>템플릿 ID / 템플릿명</th>
							<th>등록일</th>
							<th>선택</th>
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
</div>
<div class="row clearfix">
	<div class="reg-left">
		<h3 class="pdd-top-4">
			<span class="required">전환발송 보내기</span> <span class="icon-tooltip"
				data-tippy-content="전환발송 보내기를 사용할 경우, 채널을 통한 메시지 전송 실패 시 문자로<br/>전환하여 전송하는 방법으로 미리보기에서 확인이 가능합니다."><i
				class="fa fa-info"></i></span>
		</h3>
		<p>(발송 실패 시)</p>
	</div>
	<div class="reg-right">
		<div class="ele_area transUse">
			<div class="search_field inline-form">
				<div class="inline-block mrg-btm-5">
					<label class="radio-container">사용 
						<input type="radio" name="transTalk" value="Y" onchange="msgStep.changeTransMsg(this)" />
						<span class="checkmark"></span>
					</label>
					<label class="radio-container">미사용 
						<input type="radio" name="transTalk" value="N" onchange="msgStep.changeTransMsg(this)"/>
						<span class="checkmark"></span>
					</label>
				</div>
			</div>
		</div>
		<section class="hide how-send-type-list">
			<p class="pdd-top-5">메시지를 자유롭게 수정하여 발송 가능하며, 입력한 메시지 byte 수에 따라
				SMS/LMS 로 자동 변경됩니다.</p>
			<div class="row ele_area">
				<div class="search_field display-block">
					<label class="required">대체 메시지 유형</label>
					<div>
						<select class="width-100" name="transMsgType" onchange="msgStep.changeTransMsgType(this)">
							<option value="SM">SMS</option>
							<option value="LM">LMS</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row ele_area">
				<div class="search_field display-block">
					<label class="required">대체 메시지 내용</label>
					<div>
						<div class="ele_area transTitleDiv" style="display:none;">
							<input type="text" class="form-control previewTransTitle remaining_byte"  id="talkTransTitle" name="talkTransTitle"
								placeholder="제목을 입력하세요 (최대 60byte)" data-input="talkTransTitle" data-count="talkTransTitle_count" data-text-len="60"/>
							<p class="text-right color-gray">
								<span id="talkTransTitle_count">0</span>/60 byte
							</p>
						</div>
						<div class="pdd-top-10"
							data-input="talkTransTextarea"
							data-count="talkTransTextarea_count" data-text-len="2000">
							<textarea rows="5" class="width-100 previewTransTextarea" id="talkTransTextarea"
								name="talkTransTextarea" placeholder="내용을 입력하세요"></textarea>
							<p class="text-right color-gray">
								<span id="talkTransTextarea_count">0</span>/<span id="talkTransTextareaMaxLen">90</span> byte
							</p>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>
<style>
	#alimtalkDiv .table>tbody>tr:first-child>td {border-top:none}
</style>
<script type="text/javascript">
	$(document).ready(function () {
		getTalkAjax();
	});

	// 알림톡 템플릿 조회
	var talkGrid = new IbkDataTableNew();
	function getTalkAjax() {
		var requestParam = function (data) {
		    data.perPage = talkGrid.perPage || 5;
		    data.currentPage = talkGrid.currentPage || 1;
		    data.searchWord = $("#talkSearchWord").val();
		    data.regYms = $("#talkRegYms").val().split("-").join("");
	    };
		talkGrid.initDataTable("alimtalk_table", "/campaign/smsreq/alimtalk", requestParam,
				AlimtalkColumn.columns, AlimtalkColumn.columnDefs, null, {scrollY: '220px'});

		generateSlimScroll('#alimtalkDiv .dataTables_scrollBody', { height: '220px', size: '6px', alwaysVisible: true});
	}
	
	var msgStepTalk = msgStepTalk || {};
	msgStepTalk = (function() {
		return {
			// 알림톡 템플릿 검색 버튼
			search: function() {
				talkGrid.currentPage = 1;
				talkGrid.reload();
			},
			// 알림톡 템플릿 초기화
			init: function() {
				$("#talkSearchWord").val('');
			 	$("#talkRegYms").val('');
			 	talkGrid.perPage = 5;
			 	talkGrid.currentPage = 1;
			 	$("#alimtalk_table_per_page").val(talkGrid.perPage);
			},
			// 알림톡 템플릿 사용하기 버튼
			useBtn: function(e) {
				var row = talkGrid.dataTable.row($(e).closest("tr")).data();
				// 저장 값 셋팅
				$("#kkoTmplCd").val(row.kkoTmplCd);
				// 미리보기 셋팅
				previewFunc.setTalkPreview(row);
				// 대체메세지 타입 셋팅
				msgStep.setTransMsgType();
				// 대체메세지 내용 셋팅
				msgStep.setTransMsgContents();
				smsReq.chkBtnActive(smsReq.curStep);
			},
			talkDtlAjax: function(data) {
				$.ajax({
		            url: '${pageContext.request.contextPath}/campaign/smsreq/alimtalkDtl',
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify({
		            	kkoTmplCd: data.kkoTmplCd
	            	})
		        }).done(function (data) {
		        	previewFunc.setTalkPreview(data);
		        }).fail(function (xhr) {
		        	sweet.alert("알림톡 조회 중 에러 발생[" + xhr.status + "]<br>관리자에게 문의 바랍니다.");
		        });
			}
		}
	})();	
	
	// 알림톡 템플릿 목록보기
	$(document).on('click', '#alimtalk_table_reset', function () {
		msgStepTalk.init();
		msgStepTalk.search();
    });
</script>
