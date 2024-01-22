<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript" src="/static/v2/js/common/rcsTemplateCommon.js"></script>

<style>
	#popupTemplateView input {pointer-events:none}
</style>

<!-- RCS 템플릿 상세 -->
<div id="popupTemplateView" class="modalPopup hide position-top" style="width: 900px">
  <div class="modal-header"><h1>RCS 템플릿 상세</h1></div>
  <div class="modal-body">
    <div class="row preview-area clearfix">
      <div class="preview-left">
      	<form id="frmRcsDetail">
	        <div class="template-title">승인완료</div>
	        <div class="pdd-right-10 popupTemplateScroll">
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">템플릿ID</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              ABC_1a234_abc
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">템플릿 속성</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              서술(description)
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">유형</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              승인
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">템플릿명</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              회원가입
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">내용</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
	              안녕하세요.<br/>
	              회원가입이 되었습니다.<br/>
	              감사합니다.
	            </div>
	          </div>
	          <div class="row clearfix">
	            <div class="preview-form-left">
	              <h3 class="pdd-top-4">내용</h3>
	            </div>
	            <div class="preview-form-right pdd-top-4">
		            <div class="ele_area cell-copy">
		            	<div class="search_field inline-form">
		            		<div class="mrg-right-10 div-cell-area div-cell-one">
		            			<input type="text" class="form-control mrg-right-10" value="예약일시"/>예약일시
		            		</div>
		            		<div class="mrg-right-10 div-cell-area div-cell-two">
			                    <input type="text" class="form-control mrg-right-10" value="{{예약일시}}"/>
			                </div>
			            </div>
		                <div class="search_field inline-form">
			                <div class="mrg-right-10 div-cell-area div-cell-one">
		            			<input type="text" class="form-control mrg-right-10" value="예약일시2"/>
		            		</div>
		            		<div class="mrg-right-10 div-cell-area div-cell-two">
			                    <input type="text" class="form-control mrg-right-10" value="{{예약일시2}}"/>
			                </div>
		            	</div>
		            </div>
	          	</div>
	          </div>
	        </div>
        </form>
      </div>
      <div class="preview-right">
        <div class="div-msg-preview">
          <div class="div-msg-preview-header">
            <h2><i class="fa fa-search pdd-right-5"></i> 미리보기</h2>
          </div>
          <div class="div-msg-preview-body preview-height">
            <div class="emulator_area">
              <div class="emulator_cont">
                <div class="emulator_view">
                  <div class="template-openrichcard-linearlayout">
                    <div class="template-openrichcard-imageview"><img src=""></div>
                    <div class="template-openrichcard-linearlayout" data-target="pContentDetail">
                      <div class="template-openrich-textview textStart">
                        <p class="text">
                          안녕하세요.<br/>
                          회원가입이 되었습니다.<br/>
                          감사합니다.<br/>
                        </p>
                      </div>
                    </div>
                  </div>
                 <!--  <div class="template-openrichcard-suggestion">
                    <div>확인하기</div>
                  </div> -->
                  <div class="template-openrichcard-suggestion">
                  <!--  id를 data-target 으로 바꿀걸로 변경 -->
                    <div data-id="previewBtn1" data-name="previewBtn"></div>
                  </div>
                  <div class="template-openrichcard-suggestion" >
                    <div data-id="previewBtn2" data-name="previewBtn"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="modal-footer">
	<a href="javascript:;" class="btn btn-border-main" onclick="deleteRcs()">삭제</a>
    <a href="javascript:;" class="btn btn-border-main" onclick="openUpdateRcs()">수정</a>
    <a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="approvalRcs()">승인요청</a>
  </div>
</div>

<!-- 현재 페이지에 필요한 js -->
<script type="text/javascript">
 /* RCS_API_CMNCT : rcs api 연결 여부 체크
 	RCS_API_CMNCT 없거나 RCS_API_CMNCT가 false일 경우 => false
 	RCS_API_CMNCT가 true일 경우 => true 

 	RCS_API_CMNCT == true일 경우 승인요청시 상태값 자동처리
 	RCS_API_CMNCT == false일 경우 승인요청시 상태값 수동처리 (바로 승인완료 처리됨)
 	*/
<spring:eval expression="@environment.getProperty('rcs.api.communication')" var="RCS_API_CMNCT" />  
  <%
    String rcsApiCmnctStr = (String) pageContext.getAttribute("RCS_API_CMNCT");
 	Boolean rcsApiCmnct = true;
 	if(rcsApiCmnctStr != null) {
 		rcsApiCmnct = Boolean.parseBoolean(rcsApiCmnctStr);
 	}
  %>
  var rcsApiCmnct = Boolean('<%=rcsApiCmnct%>');
  //console.log('rcsApiCmnct>>>>>>>>>>', rcsApiCmnct)  
  $(document).ready(function() {
	  detailDialogId ='popupTemplateView';
	  rcsFunc.initValid($("#frmRcsDetail")); // 유효성 초기셋팅
  });

  function setDetail(data) {
	  $('.template-title').text(data.apprResult).show();

	  $('#' + detailDialogId +' .popupTemplateScroll').html(''); // 내용 초기화
	  $('div[data-target=pContentDetail]').html(''); // 미리보기 내용 초기화

	  commonFunc.addRowHtml('템플릿 ID', data.msgbaseId, null);
	  commonFunc.addRowHtml('템플릿 속성', (data.cardType == CARD_TYPE.DESC? "서술":"스타일") + "("+ data.cardType +")" , null);
	  commonFunc.addRowHtml('유형', data.bizService, null);
	  commonFunc.addRowHtml('브랜드', data.brNm, null);
	  commonFunc.addRowHtml('템플릿명', data.msgbaseNm, null);

	  var previewHtml = '';
	  if(data.cardType == CARD_TYPE.DESC) {
		  data.msgbaseDesc = data.msgbaseDesc || '';
		  commonFunc.addRowHtml('내용', data.msgbaseDesc, null);
		  // 미리보기
		  // $('div[data-target=pContentDetail] .text').text(data.msgbaseDesc);
		  previewHtml += makePreviewHtml( data.msgbaseDesc );
	  } 

	  var fmtStr = data.formattedString;
	  if(!str.isEmpty(fmtStr)) {
		  fmtStr = fmtStr.replace(/\r\n/gi,"\\r\\n");
		  var fmtJson = JSON.parse(fmtStr);
		  if(data.cardType == CARD_TYPE.CELL) {
			  previewHtml += setJsonCell(fmtJson); //스타일 셀정보 세팅(내용,미리보기)
		  }
		  // 버튼 추가
		  rcsFunc.addBtnHtml( fmtJson , DAILOG_MODE.DETAIL);
	  }

	  $('div[data-target=pContentDetail]').append( previewHtml );

	  commonFunc.addRowHtml('등록일', data.regDt, data.regUserNm );
	  commonFunc.addRowHtml('승인요청일', data.apprReqYmd, data.apprReqUserNm );
	  commonFunc.addRowHtml('승인완료일', data.apprDt, null );
	  //commonFunc.addRowHtml('사용', data.status == "ready"? "사용" : "미사용" , null );
	  // 상태 사유 표시
	  if(data.apprReason != null ) {
		  commonFunc.addRowHtml( ( data.apprResult.replace('승인요청', '') || '-' ) + ' 사유', (data.apprReason || '-'), null);
	  }

	  // 수정/상세 선택한 유형 이미지 셋팅
	  $('.template-openrichcard-imageview img').attr("src", data.imageUrl);
	  
	 // dialog 기능 버튼
	 var $footerId = $('#' + detailDialogId +' .modal-footer');	
	 $footerId.html(''); // 기능버튼 초기화

	 var apprResult = data.apprResult;
	 var updateBtnHtml = '<a href="javascript:;" class="btn btn-border-main" onclick="openUpdateRcs()">수정</a>';
	 var deleteBtnHtml = '<a href="javascript:;" class="btn btn-border-main" onclick="deleteRcs()">삭제</a>';
	 var approvalBtnHtml = '<a href="javascript:;" class="btn btn-bg-main popupEditAppy" onclick="approvalRcs()">승인요청</a>';
	 
	 if( rcsApiCmnct == true) {
		 /* RCS API 통신할 경우 = 자동 처리 */
		 if(apprResult != "승인요청 중"){
			 if(apprResult != "승인요청 실패" && apprResult != "승인대기") {
				 $footerId.append(updateBtnHtml);			 
			 } 
			 if(apprResult != "승인대기") {
				 // 새마을 rcsTmptList.jsp 참고
				 if(apprResult == "등록" || apprResult == "승인요청 실패" || apprResult == "승인요청 성공" || apprResult == "승인완료") {
					 $footerId.prepend(deleteBtnHtml);
				 }
				 if(apprResult != "승인완료") {
					 $footerId.append(approvalBtnHtml);
				 }
			 }
		 }
	 } else {
		 /* RCS API 통신 안할 경우 = 수동 처리 */
		 //console.log('data.apprResult>>>>>' , data.apprResult)
		  $footerId.append(updateBtnHtml);
 		  $footerId.prepend(deleteBtnHtml);
		  if(data.apprResult !="승인" || data.apprResult !="승인완료") {
			  // 승인일 경우 삭제 불가
			  $footerId.append(approvalBtnHtml);
		  }
	 } 	  

	 $footerId.prepend('<a href="javascript:;" class="btn btn-border-sub1 popupTemplateView_close" >닫기</a>');

	  // 공통 상세화면 초기화
	  commonFunc.changeDetailLayout()
	  
	  $('#' + detailDialogId +' select').prop('disabled', true);
	  $('#' + detailDialogId).popup('show');
  }

  function makePreviewHtml(data) {
	  var dataText ='';
	  var dataColor = '';
	  var className = 'textStart';
	  if(rcsInfo.cardType == CARD_TYPE.CELL) {
		  className = data.textAlignment + ' text-size-' + data.textSize + ' ' +  ( data.textStyle || '');
		  dataText = (data.text || '');
		  dataColor = data.textColor || '';
	  } else {
		  dataText = data;
		  dataColor = '';
	  }
	  var html = '	<div class="template-openrich-textview ' + className + '">';
	  	html += '		<p class="text" style="color: '+ ( dataColor  || '' ) + '">'+ dataText +'</p>'
	  	html += '	</div>';
	  return html;
  }

	//스타일 셀정보 세팅,  return 미리보기 html
	function setJsonCell(json) {
		//cell 데이터가져오기 데이터샘플
		//{"RCSMessage":{"trafficType":"advertisement","openrichcardMessage":{"card":"open_rich_card","layout":{"width":"284dp","height":"content","widget":"LinearLayout","children":[{"width":"content","height":"content","widget":"ImageView","mediaUrl":"maapfile://LT-200821105056505-g0Go","paddingTop":"16dp","marginBottom":"8dp"},{"width":"match","height":"content","widget":"LinearLayout","children":[{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell1}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell2}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell3}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell4}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell5}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell6}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell7}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell8}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell9}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell10}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell11}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell12}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell13}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell14}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell15}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell16}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell17}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell18}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}},{"width":"match","height":"content","widget":"LinearLayout","children":[{"text":"{{cell19}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textStart"},{"text":"{{cell20}}","width":"match","height":"content","weight":1,"widget":"TextView","textSize":"14dp","textColor":"#404040","widgetPolicy":{"allowedAttributes":["text","textAlignment","textColor","textSize","textStyle"]},"textAlignment":"textEnd"}],"visibility":"visible","orientation":"horizontal","widgetPolicy":{"allowedAttributes":["visibility"]},"paddingBottom":"8dp"},{"width":"match","height":"1dp","widget":"View","background":"#c0c0c0","visibility":"gone","marginBottom":"8dp","widgetPolicy":{"allowedAttributes":["visibility"]}}],"orientation":"vertical","paddingBottom":"8dp"}],"background":"#ffffff","orientation":"vertical","paddingLeft":"16dp","paddingRight":"16dp"},"suggestions":[],"zoomAllowed":true}}}
		var twoChildrenArr = json.RCSMessage.openrichcardMessage.layout.children[1].children; 

		var previewHtml ='';
		var html = '<div class="ele_area cell-copy">';
		for(var i = 0; i < twoChildrenArr.length; i++) {
			if(i % 2 == 0) {
				// 짝수일 경우 (cell 데이터 셋팅)
				
				var threeChildrenArr = twoChildrenArr[i].children;
				if(threeChildrenArr[0] != null) { // TODO 새마을 금고 데이터 가져오면서 추가함
					html += '	<div class="search_field inline-form ' + (i == 0? '' : 'pdd-top-10' )+'">';
					html += '		<div class="mrg-right-10 div-cell-area div-cell-one">';
				    html += '			<input type="text" class="form-control mrg-right-10" value="' + (threeChildrenArr[0].text || '') + '" />';
				    html += '		</div>';
				    
				    previewHtml += '<div class="template-openrichcard-linearlayout template-openrichcard-linearlayout-horizontal">';
				    previewHtml += makePreviewHtml( threeChildrenArr[0] );
				}
				
 				//셀 세팅
 				if(threeChildrenArr[1] != null ) {
	 				// 2단일 경우
 					html += '		<div class="mrg-right-10 div-cell-area  div-cell-two">';
 				    html += '			<input type="text" class="form-control mrg-right-10" value="'+ (threeChildrenArr[1].text || '') + '" />';
 				    html += '		</div>';
 				    
 				   previewHtml += makePreviewHtml( (threeChildrenArr[1] || '') );
 				}
 				html += '</div>';
 				previewHtml += '</div>';
			} else {
				// 홀수일 경우  (라인 존재여부 셋팅)
				if(twoChildrenArr[i].visibility == "visible") {
					//라인이 존재할 경우
					previewHtml += '<div class="template-openrichcard-hrview"></div>';
				} 
			}
		}
		html += '</div>';
		
		commonFunc.addRowHtml("내용", html, null);

		return previewHtml;
	}

   function openUpdateRcs() {
	   $('#' + detailDialogId).popup('hide');// 상세화면
	   
	   rcsInfo.title = DAILOG_MODE.UPDATE;
	   rcsFunc.setData(rcsInfo);
	}

	function deleteRcs() {
		sweet.confirm("삭제 안내", "선택한 템플릿을 삭제하시겠습니까?", 'result',  function(isConfirm) {
			if(isConfirm) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/campaign/rcsTemplate/remove',
			        type: "POST",
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(rcsInfo),
			      }).done(function(result) {
			    	  $('#' + detailDialogId).popup('hide');
			    	  commonFunc.search();
			    	  
				      if(result > 0) {
				    	  sweet.alert("삭제가 완료되었습니다.");
				      }
			      }).fail(function(xhr) {
				      console.error(xhr)
				      sweet.alert("RCS 탬플릿  삭제 중 오류가 발생하였습니다.");
			      });
			}
		});
	}

	function approvalRcs () {
		sweet.confirm("승인요청 안내", "운영자 승인이 완료되면 템플릿을 발송할 수 있습니다.<br> 승인요청 하시겠습니까?", 'result',  function(isConfirm) {
			if(isConfirm) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/campaign/rcsTemplate/approval',
			        type: "POST",
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(rcsInfo),
			        dataType: "json",
			      }).done(function(result) {
			    	  $('#' + detailDialogId).popup('hide');
			    	  commonFunc.search();
			    	  
			    	  if(result > 0) {
			    		  sweet.alert("승인 요청하였습니다.");
				      }
			    	    
			      }).fail(function(xhr) {
				      console.error(xhr)
				      sweet.alert("RCS 탬플릿  승인 요청 중 오류가 발생하였습니다.");
			      });
			}
		});
	}

</script>

