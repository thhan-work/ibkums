<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row clearfix pdd-top-10">
	<div class="reg-left"></div>
	<div class="reg-right">
		<div class="search_field width-100">
			<select id="rcsMsgType" class="width-100"
				onchange="changeRcsMsgType(this)">
				<option value="SR">SMS</option>
				<option value="LR">LMS</option>
				<option value="MR">MMS</option>
			</select>
		</div>
	</div>
</div>
<div class="row clearfix hide" id="rcsMmsCardType">
	<div class="reg-left">
		<h3 class="pdd-top-4">
			<span class="required">카드 형태</span> <span class="icon-tooltip"
				data-tippy-content="
<p class='pdd-btm-5'>< 카드 형태 안내 ></p>
<table class='table table-sm'>
<colgroup>
	<col width='80' />
	<col width='*' />
</colgroup>
<thead>
	<tr>
		<th>카드 타입</th>
		<th>설명</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>Standalone</td>
		<td class='text-left'>미디어를 위에 배치하여 풍부한 메시지로 구성해보세요.</td>
	</tr>
	<tr>
		<td>Carousel</td>
		<td class='text-left'>여러 개의 미디어를 한번에 발송하거나,<br/>컨텐츠 내용의 구분이 필요할 때 사용할 수 있습니다.
	</td>
</tr>
</tbody>
</table>"><i
				class="fa fa-info"></i></span>
		</h3>
	</div>
	<div class="reg-right">
		<div class="ele_area">
			<div class="search_field inline-form">
				<p class="mrg-right-10 width200">
					<select class="width-100" onchange="changeRcsMsgType(this)" id="rcsMmsCardSelect">
						<option value="MR">Standalone</option>
						<option value="CR">Carousel</option>
					</select>
				</p>
				<div>
					<input type="text" class="form-control" value="Medium Top" placeholder="" id="rcsMmsCardSizeDiv" readonly />
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row clearfix hide" id="rcsMmsSlideCount">
	<div class="reg-left">
		<h3 class="pdd-top-4 required">슬라이드 개수</h3>
	</div>
	<div class="reg-right">
		<div class="ele_area">
			<div class="search_field inline-form">
				<div class="inline-block">
					<label class="radio-container">3개 
						<input type="radio" name="rcsCRSlide" value="3" checked="checked" /> <span class="checkmark"></span>
					</label>
					<label class="radio-container">4개
						<input type="radio" name="rcsCRSlide" value="4" /> <span class="checkmark"></span>
					</label>
					<label class="radio-container">5개 
						<input type="radio" name="rcsCRSlide" value="5" /> <span class="checkmark"></span>
					</label>
					<label class="radio-container">6개
						<input type="radio" name="rcsCRSlide" value="6" /> <span class="checkmark"></span>
					</label>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row clearfix hide" id="rcsMmsImage">
	<div class="reg-left">
		<h3 class="required pdd-top-4">이미지 파일</h3>
	</div>
	<div class="reg-right">
		<div class="ele_area file-copy">
			<div class="search_field inline-form">
				<div class="filebox input-group input-group-icon width-100 mrg-btm-5">
					<div class="group-btn">
						<input type="file" name="rcsMmsFile" id="rcsMmsFile" class="file-upload" onchange="msgStep.mmsFileUploadAjax(this, 'MR', rcsMmsFileClbk)">
						<input class="form-control inline-block rcsImgFileData" placeholder="이미지 파일을 선택하세요" readonly name="rcsMmsFileNm">
						<a href="javascript:void(0)" class="icon-input-del hide" onclick="msgStep.deleteImgFile(this, 'MR', true)"></a>
					</div>
					<label for="rcsMmsFile" class="btn btn-inner fileSelect">선택</label>
				</div>
			</div>
		</div>
		<p class="color-blue mrg-top-5">※ 가로 568px, 세로 336px(권장 이미지 크기)<br>확장자 jpg, png 용량 1Mb 이하로 등록하시기 바랍니다.</p>
	</div>
</div>
<div class="row clearfix hide" id="rcsMsgTitleDiv">
	<div class="reg-left">
		<h3 class="required pdd-top-4">메시지 제목</h3>
	</div>
	<div class="reg-right">
		<div class="ele_area remaining" data-input="rcsMsgTitle"
			data-count="rcsMsgTitle_count" data-text-len="30">
			<input type="text" class="form-control previewTitle" id="rcsMsgTitle"
				name="rcsMsgTitle" placeholder="제목을 입력하세요" />
			<p class="text-right color-gray">
				<span id="rcsMsgTitle_count">0</span>/30 자
			</p>
		</div>
	</div>
</div>
<div class="row clearfix">
	<div class="clearfix" id="rcsValueChoice">
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
	<div class="row clearfix" id="rcsMsgContents">
		<div class="reg-left vertical-div">
			<h3 class="required pdd-top-4 vertical-text">메시지 내용</h3>
		</div>
		<div class="reg-right">
			<div>
				<div class="search_field width-100">
					<div class="ele_area" data-input="rcsTextarea"
						data-count="rcsTextarea_count" data-text-len="100">
						<textarea rows="5" class="width-100 previewTextarea" id="rcsTextarea"
							name="rcsTextarea" placeholder="내용을 입력하세요"></textarea>
						<p class="text-right color-gray">
							<span id="rcsTextarea_count">0</span>/<span id="rcsTextareaMaxLen">100</span> 자
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="rcsBtnParent">
		<div class="row clearfix" id="SLMR">
			<div class="reg-left">
				<h3 class="pdd-top-4">
					<span class="required">버튼 노출</span> <span class="icon-tooltip"
						data-tippy-content="
	<p>메시지 유형 중 RCS에서만 버튼이 노출됩니다.</p>
	<p class='pdd-btm-5'>최소 1개~3개로 유형별 버튼 개수는 다르며 액션 선택에 따라 입력값이 다릅니다.</p>
	<table class='table table-sm'>
	<colgroup>
		<col width='120' />
		<col width='*' />
	</colgroup>
	<tbody>
		<tr>
			<th>URL연결</th>
			<td class='text-left'>Web page 또는 App으로 이동할 수 있습니다.</td>
		</tr>
		<tr>
			<th>전화걸기</th>
			<td class='text-left'>특정 전화번호로 전화를 걸 수 있습니다.</td>
		</tr>
	</tbody>
	</table>">
						<i class="fa fa-info"></i>
					</span>
				</h3>
			</div>
			<div class="reg-right">
				<div class="ele_area">
					<div class="search_field inline-form">
						<div class="inline-block" id="rcsBtnCntEl">
							<label class="radio-container">미사용
								<input type="radio" name="rcsBtnCnt" data-name="rcsBtn" data-target="SLMR" value="0" checked="checked" />
								<span class="checkmark"></span>
							</label>
							<label class="radio-container">1개
								<input type="radio" name="rcsBtnCnt" data-name="rcsBtn" data-target="SLMR" value="1" />
								<span class="checkmark"></span>
							</label>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row clearfix hide" id="rcsTemplateGrid">
		<div class="reg-left">
			<h3 class="pdd-top-4">
				<span class="required">템플릿 선택</span>
				<span class="icon-tooltip" data-tippy-content="사전 정상 승인된 템플릿만 확인 가능합니다.<br/>템플릿이 확인되지 않는다면 템플릿 등록 및 승인을 확인 후 사용하시기 바랍니다.">
					<i class="fa fa-info"></i>
				</span>
			</h3>
		</div>
		<div class="reg-right">
			<div>
				<div class="search_area search_inner">
					<div class="search_field width180">
						<label>템플릿 ID / 속성 / 유형 / 템플릿명</label>
						<div>
							<input type="text" class="form-control" placeholder="검색어를 입력하세요"  id="rcsTemplateSearchWord"/>
						</div>
					</div>
					<div class="search_field">
						<label>등록일</label>
						<div>
							<input type="text" class="form-control date" placeholder="선택하세요" readonly  id="rcsTemplateRegDt"/>
						</div>
					</div>
					<div class="search_field">
						<button type="button" class="btn btn-reset btn-sm width60" onclick="initRcsTemplate();">초기화</button>
						<button type="button" class="btn btn-search btn-sm width60" onclick="searchRcsTemplate();">검색</button>
					</div>
				</div>
			</div>

			<!-- begin table -->
			<div class="row">
				<div class="table-result">
					총 <strong class="split" id="rcsTemplate_table_total_cnt">0</strong>
					<select class="search-limit" id="rcsTemplate_table_per_page">
						<option value="5">5개씩 보기</option>
						<option value="10">10개씩 보기</option>
						<option value="20">20개씩 보기</option>
						<option value="30">30개씩 보기</option>
					</select>
				</div>
				<div class="table-responsive" style="height:310px;">
					<table class="table table-hover table-inner" id="rcsTemplate_table">
						<colgroup>
				          <col width="20px" />
				          <col width="50px" />
				          <col width="50px" />
				          <col width="50px" />
				          <col width="50px" />
				          <col width="20px" />
				          <col width="20px" />
				        </colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>템플릿 ID</th>
								<th>템플릿 속성</th>
								<th>템플릿 유형</th>
								<th>템플릿명</th>
								<th>등록일</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
				        	<tr>
				                <td colspan="6" style="height:215px">
				                	<div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
				                </td>
				            </tr>
				        </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix hide" id="mmsTabDiv">
		<div class="reg-left">
			<h3 class="pdd-top-4">
				<span class="required">메시지 내용</span>
			</h3>
		</div>
		<div class="reg-right">
			<ul class="tabs-blue">
				<li class="active rcsMmsTab">
					<a href="javascript:void(0);" data-toggle="tab" data-id="rcsMmsTab1">M 01</a>
				</li>
				<li class="rcsMmsTab">
					<a href="javascript:void(0);" data-toggle="tab" data-id="rcsMmsTab2">M 02</a>
				</li>
				<li class="rcsMmsTab">
					<a href="javascript:void(0);" data-toggle="tab" data-id="rcsMmsTab3">M 03</a>
				</li>
				<li class="rcsMmsTab" style="display:none;">
					<a href="javascript:void(0);" data-toggle="tab" data-id="rcsMmsTab4">M 04</a>
				</li>
				<li class="rcsMmsTab" style="display:none;">
					<a href="javascript:void(0);" data-toggle="tab" data-id="rcsMmsTab5">M 05</a>
				</li>
				<li class="rcsMmsTab" style="display:none;">
					<a href="javascript:void(0);" data-toggle="tab" data-id="rcsMmsTab6">M 06</a>
				</li>
			</ul>
			<c:forEach begin="1" end="6" var="item" varStatus="status">
				<div class="rcsMmsTabCls ${status.count ne 1 ? 'hide' :''}" id="rcsMmsTab${status.count}">
					<div class="row ele_area elTab">
						<div class="search_field display-block">
							<label> <span class="required">이미지 파일</span></label>
							<div class="ele_area file-copy">
								<div class="mrg-btm-5 search_field inline-form">
									<div class="filebox input-group input-group-icon width-100">
										<div class="group-btn">
											<input type="file" name="rcsCRFile${status.count}" id="rcsCRFile${status.count}" class="file-upload" onchange="msgStep.mmsFileUploadAjax(this, 'CR', rcsMmsFileClbk)"> 
											<input type="text" class="form-control inline-block rcsImgFileData" name="rcsCrFileNm${status.count}" placeholder="이미지 파일을 선택하세요" readonly>
											<a href="javascript:void(0)" class="icon-input-del hide" onclick="msgStep.deleteImgFile(this, 'CR', true)"></a>
										</div>
											<label for="rcsCRFile${status.count}" class="btn btn-inner fileSelect">선택</label>
									</div>
								</div>
							</div>
						</div>
						<p class="color-blue mrg-top-5">※ 가로 696px, 세로 504px (권장 이미지 크기)<br>
						가로 696px, 세로 1569px (최대 이미지 크기)<br>
						확장자 jpg, png 용량 1Mb 이하로 등록하시기 바랍니다.
						</p>
					</div>
					<div class="row ele_area elTab">
						<div class="search_field display-block">
							<label><span class="required">메시지 제목</span></label>
							<div class="ele_area remaining" data-input="rcsMsgTitle_CR${status.count}"
								data-count="rcsMsgTitle_CR${status.count}_count" data-text-len="30">
								<input type="text" class="form-control previewTitle" id="rcsMsgTitle_CR${status.count}"
									name="rcsMsgTitle_CR${status.count}" placeholder="제목을 입력하세요">
								<p class="text-right color-gray">
									<span id="rcsMsgTitle_CR${status.count}_count">0</span>/30자
								</p>
							</div>
						</div>
					</div>
					<div class="row ele_area elTab">
						<div class="search_field display-block">
							<label>치환변수 선택</label>
							<div class="replaceVal"></div>
							<div class="mrg-top-5">
								<span class="color-blue">※ 치환변수 값이 예측된 byte보다 클 경우, 메시지 내용이 잘릴 수 있습니다.</span>
							</div>
						</div>
					</div>
					<div class="row ele_area elTab">
						<div class="search_field display-block">
							<label>메시지 내용</label>
							<div class="search_field width-100">
								<div class="ele_area" data-input="rcsTextarea_CR${status.count}"
									data-count="rcsTextarea_CR${status.count}_count" data-text-len="1300">
									<textarea rows="5" class="width-100 previewTextarea" id="rcsTextarea_CR${status.count}"
										name="rcsTextarea_CR${status.count}" placeholder="내용을 입력하세요"></textarea>
									<p class="text-right color-gray">
										<span id="rcsTextarea_CR${status.count}_count">0</span>/1,300 자
									</p>
								</div>
							</div>
						</div>
					</div>
					<div class="ele_area elTab rcsBtnParent mrg-top-10">
						<div class="search_field display-block">
							<label> <span class="required font-weight-bold">버튼 노출</span> <span class="icon-tooltip"
								data-tippy-content="
		<p>메시지 유형 중 RCS에서만 버튼이 노출됩니다.</p>
		<p class='pdd-btm-5'>최소 1개~3개로 유형별 버튼 개수는 다르며 액션 선택에 따라 입력값이 다릅니다.</p>
		<table class='table table-sm'>
		<colgroup>
			<col width='120' />
			<col width='*' />
		</colgroup>
		<tbody>
			<tr>
				<th>URL연결</th>
				<td class='text-left'>Web page 또는 App으로 이동할 수 있습니다.</td>
			</tr>
			<tr>
				<th>전화걸기</th>
				<td class='text-left'>특정 전화번호로 전화를 걸 수 있습니다.</td>
			</tr>
		</tbody>
		</table>"><i
									class="fa fa-info"></i></span>
							</label>
							<div class="ele_area" id="CR${status.count}_">
								<div class="search_field inline-form">
									<div class="inline-block rcsBtnCntEl">
										<label class="radio-container">미사용 
											<input type="radio" name="rcsBtnCnt_CR${status.count}" data-name="rcsBtn" data-target="CR${status.count}_" value="0" checked="checked" /> 
											<span class="checkmark"></span>
										</label>
										<label class="radio-container">1개 
											<input type="radio" name="rcsBtnCnt_CR${status.count}" data-name="rcsBtn" data-target="CR${status.count}_" value="1" />
											<span class="checkmark"></span>
										</label>
										<label class="radio-container">2개
											<input type="radio" name="rcsBtnCnt_CR${status.count}" data-name="rcsBtn" data-target="CR${status.count}_" value="2" />
											<span class="checkmark"></span>
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4">
				<span class="required">전환발송 보내기</span> <span class="icon-tooltip"
					data-tippy-content="전환발송 보내기를 사용할 경우, 채널을 통한 메시지 전송 실패 시 문자로<br/>전환하여 전송하는 방법으로 미리보기에서 확인이 가능합니다.">
					<i class="fa fa-info"></i>
				</span>
			</h3>
			<p>(발송 실패 시)</p>
		</div>
		<div class="reg-right">
			<div class="ele_area transUse">
				<div class="search_field inline-form">
					<div class="inline-block mrg-btm-5">
						<label class="radio-container">사용 
							<input type="radio" name="transRcs" value="Y" onchange="msgStep.changeTransMsg(this)" />
							<span class="checkmark"></span>
						</label>
						<label class="radio-container">미사용 
							<input type="radio" name="transRcs" value="N" onchange="msgStep.changeTransMsg(this)" />
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
			</div>
			<section class="hide how-send-type-list">
				<p class="pdd-top-5" id="rcsTransDesc1">메시지를 자유롭게 수정하여 발송 가능하며, 입력한 메시지 byte 수에 따라
					SMS/LMS 로 자동 변경됩니다.</p>
				<p class="hide pdd-top-5" id="rcsTransDesc2">메시지를 자유롭게 수정하여 발송 가능하며, 전화발송용 이미지를 첨부해야 이미지 함께 발송됩니다.<br>이미지 파일은 최소 1개 ~ 최대 3개까지 첨부 가능합니다.<br>
				확장자 jpg, jpeg, 최대 1000px X 1000px로 1개당 용량 300KB이하, 총 900KB 이하로 등록하시기 바랍니다.</p>
				<div class="row ele_area">
					<div class="search_field display-block">
						<label class="required">대체 메시지 유형</label>
						<div>
							<select class="width-100" id="rcsTransMsgType" name="transMsgType" onchange="msgStep.changeTransMsgType(this)">
								<option value="SM">SMS</option>
								<option value="LM">LMS</option>
							</select>
							<input type="text" class="form-control" id="rcsMmsTransMsgType" value="MMS" readonly style="display:none;"/>
						</div>
					</div>
				</div>
				<div class="row ele_area">
					<div class="search_field display-block">
						<label class="required">대체 메시지 내용</label>
						<div>
							<div class="transTitleDiv" style="display:none;">
								<input type="text" class="form-control previewTransTitle remaining_byte" id="rcsTransTitle" name="rcsTransTitle"
									placeholder="제목을 입력하세요 (최대 60byte)" data-input="rcsTransTitle" data-count="rcsTransTitle_count" data-text-len="60" />
								<p class="text-right color-gray">
									<span id="rcsTransTitle_count">0</span>/60 byte
								</p>
							</div>
							<div class="pdd-top-10"
								data-input="rcsTransTextarea"
								data-count="rcsTransTextarea_count" data-text-len="90">
								<textarea rows="5" class="width-100 previewTransTextarea" id="rcsTransTextarea"
									name="rcsTransTextarea" placeholder="내용을 입력하세요"></textarea>
								<p class="text-right color-gray">
									<span id="rcsTransTextarea_count">0</span>/<span id="rcsTransTextareaMaxLen">90</span> byte
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="row ele_area hide" id="rcsTransImage">
                    <div class="search_field display-block">
                        <label class="required">대체 이미지 파일</label>
                        <div class="file-copy addFileEl" id="rcsFileEl">
                            <div class="search_field inline-form">
                                <div class="filebox input-group input-group-icon width-100 mrg-right-10">
                                	<div class="group-btn">
                                    	<input type="file" name="rcsTransMmsFile1" id="rcsTransMmsFile1" class="file-upload" onchange="msgStep.mmsFileUploadAjax(this, 'N', rcsTransFileChange)">
                                    	<input class="form-control inline-block transImgFileData" placeholder="이미지 파일을 선택하세요" name="rcsTransMmsFileNm1" id="rcsTransMmsFileNm1" readonly>
                                    	<a href="javascript:void(0)" class="icon-input-del hide" onclick="msgStep.deleteImgFile(this, 'TRANS', true)"></a>
                                    </div>
                                    <label for="rcsTransMmsFile1" class="btn btn-inner fileSelect">선택</label>
                                </div>
                                <p><button type="button" class="btn btn-files btn-files-add btnFileAdd" onclick="msgStep.addMmsFile(this, 'rcsTransMmsFile')" id="rcsMmsBtnAdd"></button></p>
                            </div>
                        </div>
                    </div>
                </div>
			</section>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		
		// 탭 클릭 이벤트
		$("#mmsTabDiv a[data-toggle='tab']").click(function () {
			$(this).parents().closest('ul').last().find('li.active').removeClass('active');
		    $(this).parent().addClass('active');
		    $('div[id^=rcsMmsTab]').hide();
		    $('#' + $(this).data('id')).show();
		    $('#previewCarousel .emulator_area').slick("slickGoTo", $("#mmsTabDiv a[data-toggle='tab']").index($(this)));
		    $("#frmMsg").valid();
		});
	});

	//메시지 유형 변경시
	function changeRcsMsgType(e) {
		var txt = $( "#rcsMsgType option:selected" ).text();
		var msgType = $(e).val();
		$("#expctMsgType").val(msgType);
		$("#msgDstic").val(msgType);
		
		switch (msgType) {
			case 'SR':
				previewFunc.preivewShowChoice(0);
				$("#rcsMmsCardType").hide();
				$("#rcsMmsImage").hide();
				$("#rcsMsgTitleDiv").hide();
				$("#rcsMsgContents").show();
				$("#rcsValueChoice").show();
				$("#SLMR").parent().show();
				$("#rcsTemplateGrid").hide();
				$("#rcsTemplateType").hide();
				$("#rcsMmsSlideCount").hide();
				$("#mmsTabDiv").hide();
				$("#rcsTransImage").hide();
				$("#rcsTextareaMaxLen").text("100");
				$("#rcsTransTextareaMaxLen").text("90");
				makeRcsBtnCntEl(1);
				$("#rcsMmsCardSelect").val("MR");
				$("#rcsTransMsgType").show();
				$("#rcsMmsTransMsgType").hide();
				$("#rcsTransDesc1").show();
				$("#rcsTransDesc2").hide();
				break;
			case 'LR':
				previewFunc.preivewShowChoice(0);
				$("#rcsMmsCardType").hide();
				$("#rcsMmsImage").hide();
				$("#rcsMsgTitleDiv").show();
				$("#rcsMsgContents").show();
				$("#rcsValueChoice").show();
				$("#SLMR").parent().show();
				$("#rcsTemplateGrid").hide();
				$("#rcsTemplateType").hide();
				$("#rcsMmsSlideCount").hide();
				$("#mmsTabDiv").hide();
				$("#rcsTransImage").hide();
				$("#rcsTextareaMaxLen").text("1,300");
				$("#rcsTransTextareaMaxLen").text("2,000");
				makeRcsBtnCntEl(3);
				$("#rcsMmsCardSelect").val("MR");
				$("#rcsTransMsgType").show();
				$("#rcsMmsTransMsgType").hide();
				$("#rcsTransDesc1").show();
				$("#rcsTransDesc2").hide();
				break;
			case 'MR':
				previewFunc.preivewShowChoice(0);
				$("#rcsMmsCardType").show();
				$("#rcsMmsImage").show();
				$("#rcsMsgTitleDiv").show();
				$("#rcsMsgContents").show();
				$("#rcsValueChoice").show();
				$("#SLMR").parent().show();
				$("#rcsTemplateGrid").hide();
				$("#rcsTemplateType").hide();
				$("#rcsMmsSlideCount").hide();
				$("#mmsTabDiv").hide();
				$("#rcsTransImage").show();
				$("#rcsTextareaMaxLen").text("1,300");
				$("#rcsTransTextareaMaxLen").text("2,000");
				$("#rcsMmsCardSizeDiv").val("Medium Top");
				makeRcsBtnCntEl(2);
				$("#rcsMmsCardSelect").val("MR");
				$("#rcsTransMsgType").hide();
				$("#rcsMmsTransMsgType").show();
				$("#rcsTransDesc1").hide();
				$("#rcsTransDesc2").show();
				break;
			case 'CR':
				previewFunc.preivewShowChoice(1);
				sliderInit();
				$("#rcsMmsCardType").show();
				$("#rcsMmsImage").hide();
				$("#rcsMsgTitleDiv").hide();
				$("#rcsMsgContents").hide();
				$("#rcsValueChoice").hide();
				$("#SLMR").parent().hide();
				$("#rcsTemplateGrid").hide();
				$("#rcsTemplateType").hide();
				$("#rcsMmsSlideCount").show();
				$("#mmsTabDiv").show();
				$("#rcsTransImage").show();
				$("#rcsTextareaMaxLen").text("1,300");
				$("#rcsTransTextareaMaxLen").text("2,000");
				$("#rcsMmsCardSizeDiv").val("Medium");
				makeRcsCrBtnCntEl();
				mmsTabClick(0);
				$("#rcsTransMsgType").hide();
				$("#rcsMmsTransMsgType").show();
				$("#rcsTransDesc1").hide();
				$("#rcsTransDesc2").show();
				$("#frmMsg").valid();
				break;
			default:
				break;
		}

		// 추가 공통 값 셋팅
		msgStep.initRcsWrite();
		msgStep.initPreview();
		
		$(".msgDsticTxt").text("RCS -" + txt);
		$("input[name=previewMsgDsticTxt][value=P]").prop("checked", true).change();
		
		// 메시지내용 validate rule변경 
		$('#rcsTextarea').rules("add", {
			maxlength: str.uncomma($("#rcsTextareaMaxLen").text())
		});

		$('#rcsTransTextarea').rules("add", {
			maxbytelength: str.uncomma($("#rcsTransTextareaMaxLen").text())
		});
	}

	var rcsTemplateGrid = new IbkDataTableNew();
	rcsTemplateGrid.perPage = 5;
	function getTemplateAjax() {
		var requestParam = function (data) {
		    data.perPage = rcsTemplateGrid.perPage;
		    data.currentPage = rcsTemplateGrid.currentPage;
		    data.searchWord = $("#rcsTemplateSearchWord").val();
		    data.regDt = $("#rcsTemplateRegDt").val().split("-").join("");
	    };

	    rcsTemplateGrid.initDataTable("rcsTemplate_table", "/campaign/smsreq/rcsTemplate", requestParam,
	    		RcsTemplateColumn.columns, RcsTemplateColumn.columnDefs);
	}

	// rcs템플릿 초기화
	function initRcsTemplate() {
		$("#rcsTemplateRegDt").val('');
	 	$("#rcsTemplateSearchWord").val('');
	}

	// rcs템플릿 검색 버튼
	function searchRcsTemplate() {
		rcsTemplateGrid.currentPage = 1;
		rcsTemplateGrid.reload();
	}

	// 버튼노출 개수 라디오버튼 생성
	function makeRcsBtnCntEl(cnt) {
		var html = '';
		$("#rcsBtnCntEl").empty();
		for(var i=0; i < cnt + 1; i++) {
			if(i == 0) {
				html += '<label class="radio-container">미사용';
			} else {
				html += '<label class="radio-container">' + i + '개';
			}
			html += '	<input type="radio" name="rcsBtnCnt" data-name="rcsBtn" data-target="SLMR" value="'+ i +'" />';
			html += '	<span class="checkmark"></span>';
			html += '</label>';
		}
		$("#rcsBtnCntEl").append(html);
		$("#rcsBtnCntEl input:first").prop("checked", true).change();
	}

	// Carousel 버튼노출 개수 초기화
	function makeRcsCrBtnCntEl() {
		$(".rcsBtnCntEl").each(function(idx, item) {
			$(item).find("input:first").prop("checked", true).change();
		}) 
	}

	// RCS MMS 이미지 파일 변경시
	function rcsMmsFileClbk($target, data, isDetail) {
		// $target > file dom
		
		var id = $target.attr("id");
		var imgSeq = data.imgSeq || 0;

		// 파일명셋팅
		var filename = data.filename;
		var orgFileName = data.orgFileName || filename;

		// 상세조회시, 파일명 수정
		if(orgFileName.startsWith("/")) {
			orgFileName = orgFileName.split("/")[2];
		}
		
		$target.next().val(orgFileName).trigger("input");

		// 파일삭제 기능 활성화
		$target.parent().find('.icon-input-del').removeClass('hide');
		$target.closest('.search_field').find(".fileSelect").addClass('hide');

		// 이미지 파일 정보 값 셋팅
		$target.parent().find(".rcsImgFileData").data("path", filename);
		$target.parent().find(".rcsImgFileData").data("imgSeq", imgSeq);

		// Standalone Carousel 분기처리 미리보기 값 셋팅
		var html = '';
		var src = "${pageContext.request.contextPath}/template-uploaded-img.ibk?filename=" + filename + "&isRcsFile=Y";
		if(isDetail) {
			src = "${pageContext.request.contextPath}/template-img.ibk?seq=" + imgSeq;
		}
		if(id.indexOf("CR") > -1) {
			// 미리보기 img 제거
			/* var sIdx = $(".slick-active").index(".slick-slide:not(.slick-cloned)");
			if(data && data.sIdx) sIdx = data.sIdx; */
			var sIdx = $target.closest(".reg-right").find(".rcsMmsTabCls").index($target.closest(".rcsMmsTabCls"));
			previewFunc.delImgPrevew(1, sIdx, true);

			// 미리보기 img 값 셋팅
			html = '<img style="height:200px;" src="'+ src +'">';
			$("#previewCarousel .slick-slide:not(.slick-cloned)").eq(sIdx).find(".template-richcard-mediaview").append(html);
		} else {
			// 미리보기 img 제거
			previewFunc.delImgPrevew(0, 0, false);

			// 미리보기 img 값 셋팅
			html = '<div class="template-richcard-mediaview">';
			html += '<img style="height:200px;" src="'+ src +'">';
			html += '</div>';
			$("#previewBody").prepend(html);
		}
	}

	// 대체메시지 MMS 이미지 파일 변경시,
	function rcsTransFileChange($target, data, isDetail) {
		var imgSeq = data.imgSeq || 0;
		
		// 파일명셋팅
		$target.next().val(data.orgFileName).trigger("input");

		// 파일삭제 기능 활성화
		$target.parent().find('.icon-input-del').removeClass('hide');
		$target.closest('.search_field').find(".fileSelect").addClass('hide');

		// 미리보기 img 제거
		var idx = $target.closest(".addFileEl").find(".search_field").index($target.closest(".search_field"));
		previewFunc.delImgPrevew(2, idx, false);
		
		// 미리보기 img 값 셋팅
		var src = "${pageContext.request.contextPath}/template-uploaded-img.ibk?filename=" + data.filename;
		if(isDetail) {
			src = "${pageContext.request.contextPath}/template-img.ibk?seq=" + imgSeq;
		} 
		var html = '<div class="template-richcard-mediaview">';
		html += '<img style="height:200px;" src="'+ src +'">';
		html += '</div>';

		if(idx == 0) {
			$("#transBody").prepend(html);
		} else {
			$("#transBody > div:nth-child(" + idx + ")").after(html);	
		}

		// 이미지 파일 정보 값 셋팅
		$target.parent().find(".transImgFileData").data("path", data.filename);
		$target.parent().find(".transImgFileData").data("imgSeq", imgSeq);

		// 스크롤 기능 추가
		var imageLen = $("#transBody .template-richcard-mediaview").length;
		if(imageLen == 1) generateSlimScroll('#transDiv .emulator_cont', { height: '530px', size: '3px'});
	}
	
	// RCS템플릿 목록보기
	$(document).on('click', '#rcsTemplate_table_reset', function () {
		initRcsTemplate();
		searchRcsTemplate();
    });

	// RCS-Carousel 슬라이드 체인지 이벤트
	$("input[name=rcsCRSlide]").change(function() {
		var slideCnt = $(this).val();
		$(".rcsMmsTab").each(function(index, item) {
			$(item).show();
	    	if(index+1 > slideCnt) $(item).hide(); 
		})
		
		// 슬라이드 노출개수에 따른 미리보기 슬라이드 추가
		previewFunc.dynamicPreviewSlider(slideCnt);
		
		// 탭 첫번째 값으로 초기화
		mmsTabClick(0);

		// 미리보기 첫번째 값으로 초기화
		$('#previewCarousel .emulator_area').slick("slickGoTo", 0);
		
	})
	
	// mms tab 클릭 이벤트
	function mmsTabClick(idx) {
		$("#mmsTabDiv a[data-toggle='tab']").eq(idx).click();	
	}
	
	// Carousel 슬라이드 초기화
    function sliderInit() {
    	$('#previewCarousel .emulator_area').not('.slick-initialized').slick({
    		slidesToShow: 1,
          	slidesToScroll: 1,
          	dots: false,
          	prevArrow: false,
          	nextArrow: false
        });

        $("#previewCarousel  .template-richcard-carousel-prev").click(function() {
            $('#previewCarousel .emulator_area').slick('slickPrev');

            var mmsTabLen = $(".rcsMmsTab:visible").length - 1;
    		var mmsTabActive = $(".rcsMmsTab.active").index();
            var idx = mmsTabActive == 0 ? mmsTabLen : mmsTabActive - 1;  
            mmsTabClick(idx);
        });

        $("#previewCarousel  .template-richcard-carousel-next").click(function() {
            $('#previewCarousel .emulator_area').slick('slickNext');

            var mmsTabLen = $(".rcsMmsTab:visible").length - 1;
    		var mmsTabActive = $(".rcsMmsTab.active").index();
            var idx = mmsTabActive == mmsTabLen ? 0 : mmsTabActive + 1;  
            mmsTabClick(idx);
        });

        $('.slick-carousel .template-richcard-descriptionview .text').slimscroll({
            height: '125px',
            size: '3px',
            position: 'right',
            alwaysVisible: true,
            distance : '0px',
       	});
    }

    // TODO 수정 시, 파일사이즈 DB 저장 필요
    // RCS Carousel 이미지 사이즈 유효성 체크
    function validCarouselSize() {
    	var slideCnt = Number($("input[name=rcsCRSlide]:checked").val());
    	var sum = 0;

    	// 이미지 파일 총사이즈 체크
    	var valid = [].some.call($("div[id^=rcsMmsTab]").slice(0, slideCnt), function(idx, item){
    		var rslt = false;
    		// 신규인 경우,
    		var size = $(item).find("input[type=file]")[0].files[0].size;

    		sum += size;

			// 1MB
    		if(sum > 1048576) {
     	 		rslt = true;
     		}
     		return rslt;
 		})

 		if(valid) {
 			sweet.alert("슬라이드 이미지 파일의 총 사이즈가 초과되었습니다.");
 			return false;
 		}
    }

    // RCS Carousel 내용 총합 체크
    function validCarouselCntnt() {
    	var slideCnt = Number($("input[name=rcsCRSlide]:checked").val());
    	var sum = 0;

    	// 총합 체크
    	var stIdx = 0;
    	var edIdx = slideCnt;
    	var valid = [].some.call($("div[id^=rcsMmsTab]").slice(0, slideCnt), function(idx, item){
    		var rslt = false;
    		var cntnt = $(item).find(".previewTextarea").val();

    		sum += cntnt.length;
			
    		if(sum > 1300) {
    			stIdx = idx;
     	 		rslt = true;
     		}
     		return rslt;
 		})

 		if(valid) {
 	 		// 초기화
 			initCarouselCntnt(stIdx, edIdx);
 			sweet.alert("슬라이드 내용의 총합이 초과되었습니다.");
 			return false;
 		}
    }
    
    // RCS Carousel 내용 초기화
    function initCarouselCntnt(stIdx, edIdx) {
    	$("div[id^=rcsMmsTab]").slice(stIdx, edIdx).each(function(idx, item){
    		$(item).find(".previewTextarea").val('');
 		})
    }

    // RCS 라인 유효성 체크
    function validRcsLine(e) {
        // 메시지유형
        var msgType = $("#msgDstic").val();
        if(msgType == 'SR') return false;

        // 라인수 구하기
        var maxByteLine = getCtntLineByte(msgType);
        var maxLine = getMaxLineCntnt(e, msgType);

		// 값 셋팅
        var qMsg = $(e).val();
        var lineContents = getLineCntnt(qMsg, maxByteLine);
		var totalRow = lineContents.split("\n").length;

		// 글자라인수 유효성 체크
        if(totalRow > maxLine) {
            // 초기화
        	initLine(e, lineContents, maxLine);
            sweet.alert("글자 라인수가 초과되었습니다.");
            return false;
        } 
        
        $(e).val(lineContents);
    }

    function initLine(e, value, maxLine) {
        if(str.isEmpty(value)) return false;
        
    	var totalRow = value.split("\n").length;
    	var diff = maxLine - totalRow;

		// 최대값 보다 totalRow가 더 큰 경우, 차이만큼 슬라이스 처리 
    	if(diff < 0) {
    		var newVal = value.split("\n").slice(0, diff);
    		$(e).val(newVal);	
       	}
        
    }

    // 제목 1라인 최대 글자수 구하기
    function getTitleLineByte(msgType) {
    	// 타입별 최대라인수			
		if(msgType == "CR") {
			return 13;
		} else {
			return 16;
		}
    }

 	// 제목 최대 라인수 구하기
    function getMaxLineTitle(msgType) {
    	// 타입별 최대라인수			
		if(msgType == "CR") {
			return 3;
		} else {
			return 2;
		}
    }

 	// 내용 1라인 최대 글자수 구하기
    function getCtntLineByte(msgType) {
    	// 타입별 최대라인수			
		if(msgType == "CR") {
			return 14;
		} else {
			return 18;
		}
    }

    // 내용 최대 라인수 구하기
    function getMaxLineCntnt(e, msgType) {
        var line = 0;
		// 행 - 제목수, 열 - 버튼수
		// [0][0] -> 제목x, 버튼x | [1][2] -> 제목1줄, 버튼 2개
		var i,j = 0;
		var lrLine = [[28, 26, 24, 22], [27, 25, 23, 20], [26, 23, 21, 19]];
		var mrLine = [[15, 13, 11], [14, 12, 10], [13, 11, 9]];
		var crLine = [[17, 15, 13], [16, 14, 12], [15, 13, 11], [14, 12, 10]];
		
		// 제목 수, 버튼 수 구하기
		var titleMax = getTitleLineByte(msgType);
		var titleVal = "";
		var btnCnt = 0;

		if(msgType == "CR") {
			titleVal = $(e).closest(".rcsMmsTabCls").find(".previewTitle").val();
			btnCnt = $(e).closest(".rcsMmsTabCls").find('input[name=rcsBtnCnt_CR1]:checked').val();
		} else {
			titleVal = $("#rcsMsgTitleDiv .previewTitle").val();
			btnCnt = $('input[name=rcsBtnCnt]:checked').val();
		}

		if(!str.isEmpty(titleVal)) {
			i = parseInt(titleVal.length / titleMax);	
		}
		j = Number(btnCnt);
			
		// 타입별 최대라인수			
		if(msgType == "LR") {
			return lrLine[i][j];
		} else if(msgType == "MR") {
			return mrLine[i][j];
		} else if(msgType == "CR") {
			return crLine[i][j];
		}
		
        return line;
    }

    // 엔터가 포함된 내용 구하기
    function getLineCntnt(qMsg, maxLine) {
        if(str.isEmpty(qMsg)) return '';

        var sMsgOut = '';
		var sMsg = qMsg.replace(/\r\n/g, "\n");
		var aSplitVars = sMsg.match(/\${.*?}/g);
		var sMsgSimple = sMsg.replace(/\${.*?}/g, "\r");
		var nCurReplace = 0;
		
		var aMsgSplit = sMsgSimple.split(/\n/g);
		for (var i = 0; i < aMsgSplit.length; i++) {
			var nChars = 0;
			for (var j = 0; j < aMsgSplit[i].length; j++) {
				if (aMsgSplit[i][j].match(/\r/)) {
					sMsgOut += aSplitVars[nCurReplace];
					++nCurReplace;
				} else {
					sMsgOut += aMsgSplit[i][j];
					++nChars;
				}
				if (nChars >= maxLine) {
					sMsgOut += "\n";
					nChars = 0;
				}
			}
			if (i < aMsgSplit.length - 1) {
				sMsgOut += "\n";
			}
		}
		return sMsgOut;
    }
    

	// RCS 템플릿 그리드 > 사용버튼(사용안함) 
    function useRcsTemplateBtn(e) {
    	var row = rcsTemplateGrid.dataTable.row($(e).closest("tr")).data();
    	var cardType = row.cardType;
    	var msgCont = row.msgbaseDesc;
    	var fmtStr = row.formattedString;
    	var targetId = "previewEtc";
    	
    	previewFunc.setCellImage(fmtStr);

		if(cardType == "스타일" || cardType == "cell") { //스타일 템플릿 메시지 내용 설정
			targetId = "previewCell";
			previewFunc.preivewShowChoice(2);
			previewFunc.setCellPreviewContents(fmtStr, msgCont);
		} else { //서술 템플릿 메시지 내용 설정
			previewFunc.preivewShowChoice(0);
			previewFunc.setPreviewContents(msgCont);
		}
		
		// 버튼 값 셋팅
		if(!str.isEmpty(fmtStr)) {
			// 22.06.22 JSON.parse 오류 방지 추가
			fmtStr = fmtStr.replace(/(\r\n)|\r|\n/gi, "\\r\\n");
			var jsonObj = JSON.parse(fmtStr); //RCSMessage 가져오기
			var suggestions = jsonObj.RCSMessage.openrichcardMessage.suggestions; // 버튼정보 가져오기
			
			if(!str.isEmpty(suggestions)) {
				suggestions.forEach(function(item, index) {
					if(item.action) {
						previewFunc.setPreviewBtn(targetId, index+1, item.action.displayText);
					}
				})	
			}
		}
    }
</script>