<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="section-right mrg-top-20" id="previewDiv">
	<div class="div-msg-preview">
		<div class="div-msg-preview-header">
			<h2>
				<i class="fa fa-search pdd-right-5"></i> 미리보기 | <span class="msgDsticTxt">문자 - SMS</span>
			</h2>
		</div>
		<div class="div-msg-preview-body preview-height">
			<div class="mrg-btm-15 hide" id="isTransMsg">
				<label class="pdd-right-10 font-weight-bold">미리보기 유형</label>
				<div class="inline-block">
					<label class="radio-container"><span class="msgDsticTxt">알림톡</span>
	                	<input type="radio" name="previewMsgDsticTxt" value="P" checked="checked">
	                	<span class="checkmark"></span>
	              	</label>
	              	<label class="radio-container">전환발송
	                	<input type="radio" name="previewMsgDsticTxt" value="T">
	                	<span class="checkmark"></span>
	              	</label>
	            </div>
			</div>
			<!-- 그외 > 미리보기 -->
			<div class="emulator_area" id="previewEtc">
				<div class="emulator_cont">
					<div class="template-richcard-general" id="previewBody">
						<div class="template-richcard-titleview">
							<h4 class="title" id="previewTtile"></h4>
		                </div>
						<div class="template-richcard-descriptionview" id="msgCont">
							<p class="text" style="white-space: pre-wrap;word-break: break-all;max-height:261px;" id="previewContents"></p>
						</div>
						<div class="template-openrichcard-suggestion hide">
							<div class="previewBtnNm1"></div>
						</div>
						<div class="template-openrichcard-suggestion hide">
							<div class="previewBtnNm2"></div>
						</div>
						<div class="template-openrichcard-suggestion hide">
							<div class="previewBtnNm3"></div>
						</div>
						<div class="template-openrichcard-suggestion hide">
							<div class="previewBtnNm4"></div>
						</div>
						<div class="template-openrichcard-suggestion hide">
							<div class="previewBtnNm5"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- // 그외 > 미리보기 -->
			<!-- RCS-MMS 캐러셀  미리보기 -->
			<div class="hide" id="previewCarousel">
				<div class="emulator_area" >
					<div class="emulator_cont">
						<div class="template-richcard-carousel-warpper">
							<div class="template-richcard-carousel">
								<div class="template-richcard-carousel-item">
									<div class="template-richcard-mediaview">
				                    </div>
				                    <div class="template-richcard-titleview">
				                      <h4 class="title"></h4>
				                    </div>
				                    <div class="template-richcard-descriptionview">
				                      <p class="text" style="white-space: pre-wrap;word-break: break-all;max-height:320px;"></p>
				                    </div>
				                    <div class="template-openrichcard-suggestion hide">
										<div class="previewBtnSlide1"></div>
									</div>
									<div class="template-openrichcard-suggestion hide">
										<div class="previewBtnSlide2"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="emulator_cont">
						<div class="template-richcard-carousel-warpper">
							<div class="template-richcard-carousel">
								<div class="template-richcard-carousel-item">
									<div class="template-richcard-mediaview">
				                    </div>
				                    <div class="template-richcard-titleview">
				                      <h4 class="title"></h4>
				                    </div>
				                    <div class="template-richcard-descriptionview">
				                      <p class="text" style="white-space: pre-wrap;word-break: break-all;max-height:320px;"></p>
				                    </div>
				                    <div class="template-openrichcard-suggestion hide">
										<div class="previewBtnSlide1"></div>
									</div>
									<div class="template-openrichcard-suggestion hide">
										<div class="previewBtnSlide2"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="emulator_cont">
						<div class="template-richcard-carousel-warpper">
							<div class="template-richcard-carousel">
								<div class="template-richcard-carousel-item">
									<div class="template-richcard-mediaview">
				                    </div>
				                    <div class="template-richcard-titleview">
				                      <h4 class="title"></h4>
				                    </div>
				                    <div class="template-richcard-descriptionview">
				                      <p class="text" style="white-space: pre-wrap;word-break: break-all;max-height:320px;"></p>
				                    </div>
				                    <div class="template-openrichcard-suggestion hide">
										<div class="previewBtnSlide1"></div>
									</div>
									<div class="template-openrichcard-suggestion hide">
										<div class="previewBtnSlide2"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="template-richcard-carousel-button-area">
					<div class="template-richcard-carousel-prev">Prev</div>
		            <div class="template-richcard-carousel-next">Next</div>
		        </div>
			</div>
			<!-- // RCS-MMS 캐러셀  미리보기 -->
			<!-- RCS-스타일템플릿  미리보기 -->
			<div class="emulator_area hide" id="previewCell">
	            <div class="emulator_cont">
	              <div class="emulator_view">
	                <div class="template-openrichcard-linearlayout">
	                  <div class="template-openrichcard-imageview">
	                  </div>
	                  <div class="template-openrichcard-linearlayout" id="cellMsgCont">
	                  </div>
	                </div>
	                <div class="template-openrichcard-suggestion hide">
	                  <div class="previewBtnNm1"></div>
	                </div>
	                <div class="template-openrichcard-suggestion hide">
	                  <div class="previewBtnNm2"></div>
	                </div>
	              </div>
	            </div>
          	</div>
          	<!-- // RCS-스타일템플릿  미리보기 -->
			<div class="emulator_area hide" id="transDiv">
				<div class="emulator_cont">
					<div class="template-richcard-general" id="transBody">
						<div class="template-richcard-titleview">
							<h4 class="title" id="transTtile"></h4>
		                </div>
						<div class="template-richcard-descriptionview">
							<p class="text" style="white-space: pre-wrap;word-break: break-all;max-height:320px;" id="transContents"></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	//미리보기 > 미리보기유형 값 변경 이벤트
	$("input[name=previewMsgDsticTxt]").change(function() {
		var type = $(this).val();
		if("T" == type) {
			$("#transDiv").show();
			$("#previewEtc").hide();
			$("#previewCarousel").hide();
			$("#previewCell").hide();
		} else {
			$("#transDiv").hide();
			if($("#previewDiv").hasClass("carouselShow")) {
				previewFunc.preivewShowChoice(1);
			} else {
				previewFunc.preivewShowChoice(0);
			}
		}
	})
</script>