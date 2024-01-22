<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3 id="page-title">일반보내기
</h3>
<style>
input#messageTitle::-webkit-input-placeholder { /* Chrome/Opera/Safari */
  color: red;
  font-size:13px;
}
input#messageTitle::-moz-placeholder { /* Firefox 19+ */
  color: red;
  font-size:13px;
}
input#messageTitle:-ms-input-placeholder { /* IE 10+ */
  color: red;
  font-size:13px;
}
input#messageTitle:-moz-placeholder { /* Firefox 18- */
  color: red;
  font-size:13px;
}
</style>

<!-- content -->
<div id="content" > 
  <!-- box_info -->
  <div class="box_info" >
    <div class="title">「비대면 은행영업 가이드라인」에 의해 마케팅 목적의 문자발송이 불가합니다.</div>
    <div class="text1 mgt3">IBK메시지센터는 기존계약의 유지관리(여·수신 만기안내 등)를 목적으로 발송이 가능하며 <font color="red" ><B>고객관리(생일축하, 감성메시지 등)는 CRM시스템을 이용해 주시기 바랍니다. <span>(단, 마케팅 목적의 문자는 발송불가)</span></B></font></div>
    <div class="text2 mgt3">정보통신망법 이용촉진 및 정보보호 등에 관한 법률에 따라 "영리목적 광고성 정보" 수신 거부 고객에 대한 마케팅은 3천만원 이하의 과태료 부과 대상
      입니다. (관련문서 : 상품 안내장 전송(FAX, E-MAIL 등) 관련 유의사항 통보, 정보보호센터 2013.7.25)</div>
  </div>
  <!-- //box_info --> 
  
  <!-- table_view -->
  <span class="tooltiptext">* 관련문서:「서비스 품질보증제」시행 (고객행복부 2010.05.25)<br>  - '신청고객' 선택시 SMS수신거부가 되어있어도 발송됨<br>  - '미신청고객 '선택시  SMS수신거부시 발송안됨</span>
  <div class="tbl_wrap_view mgt5">
    <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
      <caption>
      검색조건 테이블입니다.
      </caption>
      <colgroup>
      <col style="width:180px" />
      <col style="width:auto" />
      </colgroup>
      <tr>
        <th scope="row">발송종류 선택</th>
        <td><div class="row1">
            <div class="radio_default">
              <input type="radio" id="cusType_0" name="cusType" value="0" />
              <label for="cusType_0">기존계약 유지관리</label>
            </div>
            <div class="radio_default">
              <input type="radio" id="cusType_1" name="cusType" value="1" />
              <label for="cusType_1">마케팅 및 고객관리</label>
            </div>
          </div>
          <div class="row1 mgb3"><span>· 기존계약 유지관리</span> : 여·수신 만기 안내 등 고객이 안내 받지 못하면 불이익이 있는 경우 선택</div>
          <div class="row1"><span>· 마케팅 및 고객관리</span> : 상품/서비스 권유, 생일 축하메시지, 감성메세지 등(문자 발송 불가)</div></td>
      </tr>
      <tr>
        <th scope="row">품질보증제 신청여부</th>
        <td>
        	<div class="row1">
	            <div class="radio_default">
	              <input type="radio" id="radio3" name="userAd" value="1" />
	              <label for="radio3">신청고객</label>
	            </div>
	            <div class="radio_default">
	              <input type="radio" id="radio4" name="userAd" value="0" checked="checked" />
	              <label for="radio4">미신청고객</label>
	            </div>
	            <div class="tooltip" >
	            	<img class="tooltipImg" src="${pageContext.request.contextPath}/static/images/icon_help_on.png" />
				</div>
          	</div>
         </td>
      </tr>
    </table>
  </div>
  <!-- //table_view -->
  <!-- wrap_box_nsend -->
  <div class="wrap_box_nsend mgt10">
  	<!-- phone -->
    <div class="col1">
      <div class="box_nsend">
        <div class="top"><input class="nsend" type="text" name="search" id="messageTitle" placeholder="제목을 입력해주세요.(40byte)" style="width:200px;font-size:13px;display: none;" ></div>
        <div class="content" id="sms-mobile">
          <div class="text_sms">
	          <textarea id="message" class="sms" title="메세지 입력" style="font-family:굴림; font-size:16px; width:100%; height:240px; padding-right:5px;"></textarea>
				<span class="main-msg" style="position: absolute; left: 12px; top: 0px; font-size: 11px"> 
				   	<font color="red">
						<center>[문자 발송 시 유의사항]</center><br>
						<B>* 『비대면 은행영업 가이드라인』에 의해 <br>
						마케팅 목적의 문자발송이 불가합니다.</B><br><br>
						마케팅 문자는 반드시 CRM을 이용하여<br>
						주시기 바랍니다.<br><br>
						- 기존계약 유지관리 : 발송가능<br>
				 <B>- 마케팅            : 발송불가</B><br>
						<B>- 고객관리           : 발송불가</B><br>

					</font>
				</span>
           </div>
                <div class="byte">0 byte <span>SMS</span></div>
                <div class="tac mgt19"><a href="javascript:;" class="btn_msave_blue" id="btnMessageSave">메시지저장</a><a href="javascript:;" class="btn_refresh_blue mgl6" id="btnMessageClear">새로쓰기</a><a href="javascript:;" class="btn_scode_blue mgl6" id="specharPreview">특수문자</a></div>
              </div>
              <div class="snum">발신번호 <input type="text" id="sender" name="search" value="" placeholder="입력하세요" ></div>
              <div class="mgt15"><a href="javascript:;" ><img src="${pageContext.request.contextPath}/static/images/btn_preview.png" alt="미리보기" id="popupPreview" /></a><a href="javascript:;" class="mgl5" id="btn_reserve_send"><img src="${pageContext.request.contextPath}/static/images/btn_rsend.png" alt="예약전송" /></a><a href="javascript:;" class="mgl5"><img src="${pageContext.request.contextPath}/static/images/btn_send.png" id="btn_send" alt="보내기" /></a></div>
              <input type="hidden" id="reserveDate"/>
            </div>
          </div>
          <!-- //phone -->
    <!-- 수신번호 -->
    <div class="col2" id="sms-receiver">
    	<div class="title">수신번호 (총 <span>0</span>개)</div>
      <div class="mgt15">
      	<input class="small" type="text" name="number" id="receiverNum" placeholder="" style="width:90px;"><a href="javascript:;" class="btn_default small mgl7" id="btn-add">추가</a> <a href="javascript:;" class="btn_default small" id="btn-fileUpload">불러오기</a>
      </div>
      <!-- table list -->
      <div class="tbl_wrap_list_small mgt10" style="width:218px">
        <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
          <caption>
          	테이블
          </caption>
          <colgroup>
          <col style="width:100px;" />
          <col style="width:" />
          </colgroup>
          <thead>
            <tr>
              <th scope="col"><div class="checkbox_default">
                <input type="checkbox" id="select-all" />
                <label for="select-all">이름</label>
              </div></th>
              <th scope="col">휴대폰번호</th>
              </tr>
          </thead>
        </table>
      </div>
      <!-- //table list -->
      <!-- table list -->
      <div class="tbl_wrap_list_small border_t0" style="width:218px; height:410px; overflow-y:scroll;">
        <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
          <caption>
          테이블
          </caption>
          <colgroup>
          <col style="width:95px;" />
          <col style="width:" />
          </colgroup>
          <tbody class="sms-send-list" id="sms-send-list">
          </tbody>
        </table>
      </div>
      <!-- //table list -->
      <div class="mgt9">
      	<a href="javascript:;" id="btn-remove" class="btn_default delete small">삭제</a><a 
      		href="javascript:;" id="btn-removeAll" class="btn_default delete small mgl6">전체삭제</a><a 
      			href="javascript:;" id="btn-addAddress" class="btn_default gray small mgl11">주소록에 저장</a>
   	  </div>
    </div>
    <!-- //수신번호 -->
    <!-- button -->
    <div class="wrap_btn"><a href="javascript:;" id="btnAddReciver"><img src="${pageContext.request.contextPath}/static/images/btn_arrow_l.png" alt="이동" width="30" height="30"></a></div>
    <!-- //button -->
    <!-- 주소록 -->
    <div class="col3" id="sms-address">
		<div class="title">주소록</div>
      	<!-- tap box -->
      	<div class="wrap_tab mgt24">
      		<div class="tapAddress">
		       	<ul class="tabs" data-persist="true">
		            <li class="selected"><a href="#addrView1">개인</a></li>
		            <li><a href="#addrView1" style="margin-left:-2px;">부서</a></li>
		        </ul>
	        </div>
	        <div class="tabcontents">
				<!-- tab_주소록 리스트 view -->
	            <div id="addrView1">
		            <div class="tac">
		            	<select id="option_AddrSearch">
		                <option value="name">이름</option>
		                <option value="phone">핸드폰번호</option>
		              </select>
		              <input class="small" id="text_AddrSearch" type="text" name="" value="" placeholder="입력하세요" style="width:140px;"><a href="javascript:;" class="btn_default gray small mgl9" id="btn_addrSearch">검색</a>
		            </div>
		            <div class="box_left">
	            		<!-- table list -->
				        <div class="tbl_wrap_list_small2 mgt15" style="width:138px;">
					        <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
		        				<caption> 그룹 </caption>
						        <colgroup>
				      				<col style="width:" />
						        </colgroup>
						        <thead>
							        <tr>
		        						<th scope="col" class="tac">그룹</th>
		        					</tr>
						        </thead>
					        </table>
				        </div>
		              	<!-- //table list -->
		              	<!-- table list -->
				        <div class="tbl_wrap_list_small2 border_t0" style="width:138px; height:358px; overflow-y:scroll;">
					        <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
	        					<caption> 그룹 리스트 테이블  </caption>
						        <colgroup>
						        <col style="width:" />
						        </colgroup>
							    <tbody>
								    <tr>
									    <td>
									    	<!-- 그룹 리스트 출력 -->
									    	<div id="div_address_GroupList">
										    </div>
										    <!-- //그룹 리스트 출력 -->
									    </td>
								    </tr>
							    </tbody>
					        </table>
				        </div>
		              <!-- //table list -->
		            </div>
	              
		            <div class="box_right">
	            		<!-- table list -->
			            <div class="tbl_wrap_list_small2 mgt15" style="width:209px; border-left:1px solid #c4c4c4;">
				            <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
			              		<caption> 상세 </caption>
					            <colgroup>
						            <col style="width:92px;" />
						            <col style="width:" />
					            </colgroup>
					            <thead>
						            <tr>
							            <th scope="col">
							            	<div class="checkbox_default">
							              		<input type="checkbox" id="select-all_address" />
							              		<label for="select-all_address">이름</label>
							            	</div>
						            	</th>
						            	<th scope="col">휴대폰번호</th>
					              	</tr>
					            </thead>
			            	</table>
			            </div>
		              	<!-- //table list -->
		              	<!-- table list -->
			            <div class="tbl_wrap_list_small2 border_t0" style="width:209px; height:358px; overflow-y:scroll; border-left:1px solid #c4c4c4;">
				            <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
			              		<caption> 상세 테이블 </caption>
					            <colgroup>
						            <col style="width:94px;" />
						            <col style="width:" />
					            </colgroup>
					            <tbody  class="div_address_AddrList" id="div_address_AddrList">
					            </tbody>
				            </table>
			            </div>
		              	<!-- //table list -->
	           		</div>
	            </div>
	            <!-- tab_주소록 리스트 view -->
	         </div>
		</div>
      	<!-- //tab box -->
      	<div class="mgt9 tar"><a href="javascript:;" class="btn_default gray small mgl11 mgt9" id="moveAddr">주소록 관리</a></div>
    </div>
    <!-- //주소록 -->
  </div>
  <!-- //wrap_box_nsend -->
  
  
  <div class="wrap_box_ms" style="margin-top: 10px;">
    <!-- tap box -->
      <div class="wrap_tab">
      	<div class="tapPreView">
	        <ul class="tabs big" data-persist="true">
	            <li><a href="#view_tab1" class="big">해피콜문자</a></li>
	            <li><a href="#view_tab1" class="big" style="margin-left:-2px;">본부양식</a></li>
	            <li><a href="#view_tab1" class="big" style="margin-left:-2px;">개인메시지함</a></li>
	            <li><a href="#view_tab1" class="big" style="margin-left:-2px;">부서메시지함</a></li>
	            <span class="btn"><a href="${pageContext.request.contextPath}/form/happy.ibk"><img src="${pageContext.request.contextPath}/static/images/btn_more.png" alt="더 보기" /></a></span>
	        </ul>
        </div>
        <div class="tabcontents big">
       		<!-- tab_메세지 미리보기 -->
            <div id="view_tab1">
              <div id="div_MsgFormSubMenu">
	              <ul class="menu">
	              	<li><a href="javascript:;" class="on">신규</a></li>
	                <li><a href="javascript:;">해피콜</a></li>
	                <li><a href="javascript:;">스마트뱅킹</a></li>
	              </ul>
              </div>
              <!-- 미리보기 리스트 출력 -->
              <div id="div_MsgFormDataView"></div>
              <!-- 미리보기 리스트 출력 -->
              <div class="line_sms mgt6"></div>
              <!-- 페이징 -->
              <div class="paging"></div>
              <!-- //페이징 -->
            </div>
            <!-- //tab_메세지 미리보기 -->
         </div>
      </div>
      <!-- //tab box -->
  </div>
</div>
<!-- //content --> 

<script src="${pageContext.request.contextPath}/static/js/tabcontent.js"></script>
<script src="${pageContext.request.contextPath}/static/js/messageUtil.js"></script>

<!-- alert dialog 와 confirm dilalog 를 사용하기 위해서 필요 -->
<jsp:include page="dialog/messageDialog.jsp" flush="true"/>

<!-- ajax Loding 이미지 -->
<jsp:include page="../common/loading.jsp" flush="true"/>

<!-- 미리보기 팝업 -->
<jsp:include page="dialog/previewDialog.jsp" flush="true"/>
<!-- 특수문자 팝업 -->
<jsp:include page="dialog/specharDialog.jsp" flush="true"/>
<!-- 메세지 저장 팝업 -->
<jsp:include page="dialog/saveMsgDialog.jsp" flush="true"/>
<!-- 예약전송 팝업 -->
<jsp:include page="dialog/reserveDialog.jsp" flush="true"/>

<!-- 주소록에 저장 팝업 -->
<jsp:include page="dialog/addAddressDialog.jsp" flush="true"/>
<!-- 파일업로드 팝업 -->
<jsp:include page="dialog/fileUploadDialog.jsp" flush="true"/>

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
        src="${pageContext.request.contextPath}/static/js/IbkDatatables.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/sms-req/IbkByteCheck.js"></script>
<!-- Script -->
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/notice-column.js"></script>
<script>

var flag=true;
$(document).ajaxStart(function () 
{
    flag=true;
    ajaxLoadingTimeout = setTimeout(function () {
        if(flag){
           $('.dimm').show();
        }
    }, 1000)

});

$(document).ajaxStop(function () {
    flag=false;
    clearTimeout(ajaxLoadingTimeout);
    $('.dimm').hide();
});

$(document).ready(function () {
	//document.getElementById('logo').scrollIntoView();
	
// 	reloadPreViewData();


//tooltip 위치정의
// 	var obj = $(".tooltipImg").offset();
// 	console.log(obj);
// 	// #div 좌표 새로 설정
// 	$(".tooltiptext").css({
// 	   "position" : "absolute",
// 	   "top" : $(".tooltipImg").position().top,
// 	   "right" : obj.left + "px"
// 	});

	$(".tooltiptext").position({ 
        my : 'left+5 top', // dialog 기준점
        at : 'right top', // target 기준점
        of : '.tooltipImg'  // target
    });




	$(".tooltipImg").on("mouseover", function(){
		$(".tooltiptext").css("visibility","visible");
	});
	$(".tooltipImg").on("mouseout", function(){
		$(".tooltiptext").css("visibility","hidden");
	});

	 $("input[id='cusType_1']:radio").click(function(){
		 showAlert("마케팅 목적의 문자는 발송불가하며\n 고객관리(생일축하, 감성메시지 등)은 CRM시스템을 이용해주시기 바랍니다.");
	});
	
	 	
	$("#cusType_0").click(function() {
		var offset = $(".tbl_view01").offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
	});
	 
	// 최초 메시지 안내 문구 출력
	$(".main-msg").click(function() {
		var cusType = $("input[name=cusType]:checked").val();
		if (cusType == '0')
		{
			$(".main-msg").remove();
			$("#message").trigger("click");
		}else if (cusType == '1')
		{
			showAlert("마케팅 목적의 문자는 발송불가하며\n 고객관리(생일축하, 감성메시지 등)은 CRM시스템을 이용해주시기 바랍니다.");
			isSmsMainMsg=false;
			return false;
		}else{
			showAlert("발송종류를 선택해주십시요.");
			isSmsMainMsg=false;
			return false;
		}
	});
	 
	$("#moveAddr").click(function() {
	    setTimeout(function () {
	      window.location.href = "${pageContext.request.contextPath}/all-address.ibk";
	    }, 100);
	});
	 
//##################################메시지 내용 입력 이벤트@1#########################################

var isSmsMainMsg = false;
var isFirstMsg = true;
var cusType = null;
var emplId = '<%=session.getAttribute("EMPL_ID")%>';

////메시지 입력 박스 선택 시 이벤트설정 
  $("#message").click(function() {
	
	//두낫콜 관련 start
	cusType = null;
          
    $("input[name=cusType]").each(function() {
      var $this = $(this); 
      if($this.is(":checked")) {
        cusType = $this.val();
      }        
    });

	if (cusType == null)
	{
		showAlert("발송종류를 선택해주십시요.");
		isSmsMainMsg=false;
		return false;
	}else if (cusType == '1')
	{
		showAlert("마케팅 목적의 문자는 발송불가하며\n 고객관리(생일축하, 감성메시지 등)은 CRM시스템을 이용해주시기 바랍니다.");
		isSmsMainMsg=false;
		return false;
	}else
	{
		$(".main-msg").remove();
		isSmsMainMsg=true;
	}

    $("#message").focus();
  });  
  
////메시지 입력 박스 포커스 이벤트
  $("#message").focus(function() {
  	if(isSmsMainMsg && isFirstMsg)
	{
  		$("#message").val("");
  		isFirstMsg = false;
	}else if(isSmsMainMsg && !isFirstMsg){
		
	}else
	{
		$("#cusType_0").focus();	
	}
  });
  
////메시지 제목 입력 박스 포커스 이벤트
  $("#messageTitle").focus(function() {
  	if(!isSmsMainMsg)
	{
  		$("#cusType_0").focus();
	}
  });
  
  $(document).on('keyup', '#messageTitle', function () {
    // 제목은 40byte 로 고정
    var maxByte = 40;
    var strByteInfo = IbkByteCheck.getBytesAndMaxLength($(this).val(), maxByte);
    if (strByteInfo.totalByte > maxByte) {
      showAlert('제목은 '+maxByte+'byte 까지 입력 가능 합니다.');
      $(this).val($(this).val().substring(0, strByteInfo.ableLength))
    }
  });
  
////메시지 입력 박스 키업 이벤트
  $("#message").keyup(function() {
	  messageByteCheck();
  });

////발신번호 숫자입력 체크 이벤트
  $("#sender").on("keyup", function(){
  	inputPhoneType($(this));
  });
  $("#receiverNum").on("keyup", function(){
	  var cusType = $("input[name=cusType]:checked").val();

	  if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");
			$("#receiverNum").val("");
			return false;
	  }
	  
	  inputPhoneType($(this));
  });
  
  $("#receiverNum").keypress(function (event) {
      if (event.which == 13) {
        event.preventDefault();
        $("#btn-add").trigger("click");
      }
    });
  
////미리보기 팝업
  $("#popupPreview").click(function()  {
	  var cusType = $("input[name=cusType]:checked").val();
	  
	  if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");
			return false;
	  }
	  
	  var top = $("#messageTitle").val();
	  var message = $("#message").val();
	  
	  showPreview(top, message);	  
 	  return false;//현재 사용자가 보고있는 위치 유지
  });

  
////특수문자 팝업
  $("#specharPreview").click(function()  {
	  var cusType = $("input[name=cusType]:checked").val();
	  
	  if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");
			return false;
	  }
	  
	  showSpechar();
 	  return false;//현재 사용자가 보고있는 위치 유지
  });
  
//// 예약전송 팝업
  $("#btn_reserve_send").click(function(){
	  var cusType = $("input[name=cusType]:checked").val();
	  
	  if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");
			return false;
	  }
	  
	  var result = validateMsgSendInfo();
	  if(result != false){
		  showReserve(msgSendInfo);
	  }
  });
  
//// SMS 발송
  $("#btn_send").click(function() {
	  var result = validateMsgSendInfo();
	  if(result != false){
		showConfirmSend(msgSendInfo.sendCount + ' 건의 메시지를 전송하시겠습니까?',  msgSend, msgSendInfo);
		return false;
	  }
  });


var msgSendInfo;
//// SMS 발송 정보 벨리데이션
function validateMsgSendInfo(){
  	//두낫콜 관련 start
	var cusType = null;
    $("input[name=cusType]").each(function() {
		var $this = $(this); 
		if($this.is(":checked")) {
			cusType = $this.val();
		}        
	});

	if (cusType == null)
	{
		showAlert("발송종류를 선택해주십시요.");
		return false;
	}else if (cusType == '1')
	{
		showAlert("마케팅 목적의 문자는 발송불가하며\n고객관리(생일축하, 감성메시지 등)는 CRM시스템을 이용해주시기 바랍니다.");
		return false;
	}
	//두낫콜 관련 end
    
    //2012.11.13 BY BSH 자동 입력 관련 추가 
    if($('#sender').val() != ''){
        if(typeof( $('#sender').val() ) != "undefined" ){
//         	alert("undefined");
// 			addTargetKeyDown();   
        }
    }
    else{
        showAlert('발신번호를 입력해 주시기 바랍니다.');
        return false;
    }
	
    var sender = $("#sender").val();      
	
	if(sender.length < 8 ){
		showAlert("발신번호를 정확히 입력해 주세요.");
		return false;
	}
    
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})?[0-9]{3,4}?[0-9]{4}$/;               
    if(!regExp.test(sender) && sender != '15882588') {
      showAlert("발신번호를 정확히 입력해 주세요.");
      return false;
    }
    
    if($("#message").val()=='' || $("#message").val()==' '){
		showAlert("메세지 내용을 입력해 주시기 바랍니다.");
		return false;
    }
    
	//if (_byte > 80)
	//2013.03.27 PWY 제목 입력 check	
	if (_byte > 88)
	{
		if ($("#messageTitle").val()=='' || $("#messageTitle").val()==' ')
		{
			showAlert("메시지 제목을 입력하십시오.");
			return false;
		}
		
		if($("#messageTitle").val().indexOf("<") > -1 || $("#messageTitle").val().indexOf(">") > -1){
			showAlert("제목에 < > 기호는 사용 불가능 합니다.");
			return false;
		}
	}

    if(!checkAuthority(emplId)) {
      if(checkSendTime()) {
        showAlert("SMS 발송 할 수 있는 시간이 아닙니다.");
        return false;
      }  
    }   
      
    var userAd = null;
          
    $("input[name=userAd]").each(function() {
      var $this = $(this); 
      if($this.is(":checked")) {
        userAd = $this.val();
      }        
    });
    
    //var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;               

    var addrs =$("#sms-send-list tr");
   
    if (addrs.length > 0) {
        var receivers = null;
        addrs.each(function(index) {

          if($(this).find('.phone').text().trim() != '') {
            var _addr = $(this).find('label').text() + ":" + $(this).find('.phone').text();

            if (index == 0) receivers = (_addr + "|");
            else receivers += _addr + "|";  
          }         
        });
    } else {
      showAlert("수신번호를 추가 하거나<br>주소록에서 선택하십시오.");
      return false; 
    }
    
    if(_byte > 2000) {
      showAlert("메시지가 2000byte 를 초과하였습니다.");
      return false;
    }
    
    // msgSendInfo 초기화
    msgSendInfo = getMsgSendInfo();
    
    msgSendInfo.cusType = cusType;
    msgSendInfo.sendType = $(".byte").find("span").text();
    msgSendInfo.userAd = userAd;
    msgSendInfo.sendCount = addrs.length;
    msgSendInfo.receivers = receivers;
    msgSendInfo.sender = $("#sender").val();
    msgSendInfo.title =  typeof( $('#messageTitle').val() ) != "undefined" ? $('#messageTitle').val() : null;
    msgSendInfo.message = $("#message").val();
    msgSendInfo.reserveDate = $("#reserveDate").val();
}


//// 메세지 발송 정보
function getMsgSendInfo(){
	return {
		"uniqueKey" : null
		,"sender" : null
		,"sendType" : null
		,"title" : null
		,"mmsTitle" : null
		,"message" : null
		,"msgByte" : null
		,"sendCount" : null
		,"reserveDate" : null
		,"receivers" : null
		,"msgType" : null
		,"isAd" : null
		,"userAd" : null
		,"cusType" : null
	};	
}

//// 메세지 발송
	function msgSend(msgSendInfo){

	    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		msg = 	    		"msgSendInfo.uniqueKey =" + msgSendInfo.uniqueKey + "\n" +
								"msgSendInfo.sender =" + msgSendInfo.sender + "\n" +
								"msgSendInfo.sendType =" + msgSendInfo.sendType + "\n" +
								"msgSendInfo.title =" + msgSendInfo.title + "\n" +
								"msgSendInfo.mmsTitle =" + msgSendInfo.mmsTitle + "\n" +
								"msgSendInfo.message =" + msgSendInfo.message + "\n" +
								"msgSendInfo.msgByte =" + msgSendInfo.msgByte + "\n" +
								"msgSendInfo.sendCount =" + msgSendInfo.sendCount + "\n" +
								"msgSendInfo.reserveDate =" + msgSendInfo.reserveDate + "\n" +
								"msgSendInfo.receivers =" + msgSendInfo.receivers + "\n" +
								"msgSendInfo.msgType =" + msgSendInfo.msgType + "\n" +
								"msgSendInfo.isAd =" + msgSendInfo.isAd + "\n" +
								"msgSendInfo.userAd =" + msgSendInfo.userAd + "\n" +
								"msgSendInfo.cusType =" + msgSendInfo.cusType + "\n";
	    
	    console.log(msgSendInfo);
	    
		$.ajax({
			  url: '${pageContext.request.contextPath}/message/send',
			  type: "POST",
			  contentType: "application/json; charset=utf-8",
			  dataType: "json",
			  data : JSON.stringify(msgSendInfo),
			  success: function (data) {
				console.log(data);
				  
				var completeMsg = "요청 되었습니다.";
				//예약 발송 시 
	            if(msgSendInfo.reserveDate != null && msgSendInfo.reserveDate != "" ) { completeMsg = "예약 되었습니다."; }
	            
//             * Integer ALL_COUNT: (전송을 시도한)전체 메시지 수
//             * Integer SEND_COUNT: 이통사로 전송한 메시지 수(성공건 아님)
//             * Integer CUT_COUNT: (기업은행)차단 등록되어 실패한 메시지 수
//             * Integer EXCEED_COUNT: (기업은행) 허용건수 초과로 실패한 메시지 수
//             * Integer UNIT_DISCORD_COUNT: (기업은행)업무코드/영업점코드 오류 메시지 수
//             * Integer ETC_COUNT: 그외 알 수 없는 오류
				var targetCnt = $("#sms-receiver .title span").text();
	            var allCount = data.ALL_COUNT;             
	            var dupCount = data.DUP_COUNT;
	 			var cutCount = data.CUT_COUNT;
	 			var sendCount = data.SEND_COUNT;
	 			var etcCount  = data.ETC_COUNT;
	 			var exceedCount = data.EXCEED_COUNT;
	 			var unitDiscordCount = data.UNIT_DISCORD_COUNT;

	 			var msg  = "";
	 			var flag = false;

	 			msg = msg + "전체 "+targetCnt+"건중<br>";

	 			if( (targetCnt - dupCount) > 0){
	 				msg = msg + "중복 " + (targetCnt - dupCount) + "건<br>";
	 				flag = true;
	 			}

	 			if(cutCount > 0){
	 				if(flag) {
	 					msg = msg + ","
	 				}
	 				msg = msg + "수신거부 " + cutCount + "건<br>";
	 				flag = true;
	 			}

	 			if(exceedCount > 0){
	 				if(flag) {
	 					msg = msg + ","
	 				}
	 				msg = msg + "허용 건수 초과 " + exceedCount + "건<br>";
	 				flag = true;
	 			}

	 			if(unitDiscordCount >0 ){
	 				if(flag) {
	 					msg = msg + ","
	 				}
	 				msg = msg + "미등록 오류 " + unitDiscordCount + "건<br>";
	 				flag = true;
	 			}

	 			if(etcCount >0 ){
	 				if(flag) {
	 					msg = msg + ","
	 				}
	 				msg = msg + " 기타 오류 " + etcCount + "건<br>";
	 				flag = true;
	 			}

	 			if(flag){
	 				msg = msg + "제외 하고<br/>";
	 			}

	 			msg = msg + sendCount+"건이 전송" + completeMsg;
				  
	 			showAlert(msg);
	 			
	 			//발송 데이터 초기화
	 			initSendInfo();
			  },        
			  error : function(request,status,error){
				var errorInfo = JSON.parse(request.responseText);
			  	showAlert("일반보내기중 오류가 발생하였습니다.<br><br>## Error Message ##<br>["+ errorInfo["code"] +"] "+errorInfo["message"]);
	         }
		});
	};

//// 초기화
function initSendInfo(){
	messageClear(); // 메시지 초기화
	$("#sender").val(""); // 발신번호 초기화
	
	$("#sms-receiver #sms-send-list").children().remove(); // 수신번호 초기화
	addReceiverCount();//수신번호 총 갯수 초기화
}

//// sms 메세지저장       
  $("#btnMessageSave").click(function() {
	  var cusType = $("input[name=cusType]:checked").val();
	  
	  if (cusType == null){
			showAlert("발송종류를 선택해주십시요.");
			return false;
	  }
	  
    var msg = $("#message").val();
    if(msg.trim() == '') {
   		showAlert("저장할 메세지가 없습니다.");
    	return false;
    }
    showSaveMsg(msg);
    return false;//현재 사용자가 보고있는 위치 유지
  });
  
  
  
//// 메시지 새로쓰기
	$("#btnMessageClear").click(function() {
		var cusType = $("input[name=cusType]:checked").val();
		
		  if (cusType == null){
				showAlert("발송종류를 선택해주십시요.");
				return false;
		  }
		
		showConfirmCancel("메시지를 새로 작성하시겠습니까?", messageClear, "메시지를 삭제하였습니다.");
		return false;//현재 사용자가 보고있는 위치 유지
	});
	
	// 최초 메세지 미리보기 리스트 생성
	$(".tapPreView a:first").trigger("click");
	
	// 최초 주소록 리스트 생성
	$(".tapAddress a:first").trigger("click");
	
});
//_READY END


//// 메세지저장 이벤트 처리 함수
function saveMsg(saveMsg_code, saveMsg_msg, saveMsg_title){
	saveMsgInfo = {
							"code" : saveMsg_code,
							"msg" : saveMsg_msg,
							"title" : saveMsg_title
						};

	$.ajax({
	    url: '${pageContext.request.contextPath}/form/'+saveMsg_code+'/save',
	    type: "POST",
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    data: JSON.stringify(saveMsgInfo),
	    success: function (result) {
// 			alert("저장 성공!");
			if(result < 0){
				showAlert("메시지를 저장에 실패하였습니다!");
			}else{
	    		showAlert("메시지를 저장하였습니다.");
			}
	    }
    });
}

var _byte = 0;
var alertMms = "SMS";
////메시지 Byte 체크
// addText (현재 문자 + inputText)
function messageByteCheck(addText){
	 if(addText != null)
	 {
		var messageArea = $("#message");
		messageArea.val(messageArea.val().substring(0, startPosition) + addText + messageArea.val().substring(endPosition, messageArea.val().length));
	 }
 	 _byte = checkByteTextarea($("#message"));//byte 계산
 	 if (_byte > 90) {
		if(alertMms == "SMS") {
	  		alertMms = "MMS";
		}
		$("#messageTitle").show();
     } else {
   	 	alertMms = "SMS";
   	    $("#messageTitle").val("");
		$("#messageTitle").hide();
     } 
 	 $(".byte").empty();
 	 $(".byte").html(_byte+" byte <span>"+alertMms+"</span>");
 	 if(_byte > 2000) {
		showAlert("2000byte 를 초과할 수 없습니다.");
		var idx = 0;
		for(var i=_byte; i > 2000;idx++){
			$("#message").val($("#message").val().substr(0,(2000-idx)));
			i = checkByteTextarea($("#message"));
		}
		messageByteCheck();
       	return false;
     }
}

//메시지 새로쓰기
function messageClear() {
		$("#messageTitle").val("");
	    $("#message").val("");
	    messageByteCheck();
}
  
//###############################수신번호 목록 @2#####################################################
$(document).ready(function () {
//// 받는사람 추가버튼 클릭 이벤트
	$("#btn-add").click(function() { addTargetList(); });
	  
//// 받는사람 삭제
	$("#sms-receiver #btn-remove").click(function() {
  		var addrs = $("#sms-receiver input[name=addrchk]:checked");
	  	if (addrs.length > 0) {
	  		addrs.each(function(){
	  			$(this).parent().parent().parent().remove();
	  		});
	  		
	  		addReceiverCount();//수신번호 총 갯수 갱신
		} else {
			showAlert("선택된 연락처가 없습니다.");
		}
	  	 $('#select-all').prop("checked", false);
		return false;
	});
	  
//// 받는사람 전체삭제
	$("#sms-receiver #btn-removeAll").click(function() {
		var addrs = $("#sms-receiver input[name=addrchk]");
		if (addrs.length > 0) {
			$("#sms-receiver #sms-send-list").children().remove();
			addReceiverCount();//수신번호 총 갯수 갱신
		} else {
			showAlert("등록된 연락처가 없습니다.");
		}
		phoneNums = new Array();
		 $('#select-all').prop("checked", false);
		return false;
	});
	  

////주소록에 저장 버튼 이벤트
	$("#sms-receiver #btn-addAddress").click(function() {
  		var addrs = $("#sms-receiver input[name=addrchk]:checked");
	  	if (addrs.length > 0) {
	  		//선택 연락처 리스트 생성
	  		var contactList="";
	  		addrs.each(function(idx){
	  			var name = $(this).parent().parent().parent().find("label").text();
	  			var phone = $(this).parent().parent().parent().find(".phone").text();
				var _addr = "," + name + ":" + phone;
				
				contactList += _addr;
	  		});
	  		contactList = contactList.substr(1,contactList.length);
	  		
			//주소록에 저장 팝업 출력
	  		showAddAddress(contactList);
	  		addReceiverCount();//수신번호 총 갯수 갱신
		} else {
			showAlert("선택된 연락처가 없습니다.");
		}
		return false;
	});
	 
	 
//// 수신번호 파일 업로드 버튼 이벤트
	$("#btn-fileUpload").click(function(){
		showFileUpload();
	});
});
// READY END
  
  
  
  
var checkIdx = 1;
  
//// 수신번호  추가
function addTargetList(inputList, inputType) {
  var addMaxCount = 5000;
  var receiverNum = $("#receiverNum").val();
  var receiverName = "이름없음";
  var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

  var maxSize = 1;
  var cntErrorPhone = 0;
  var textErrorPhone = "";
  var cntErrorOverlap = 0;
  var textErrorOverlap = "";
  var cntOverMaxSize = 0;
  
  var cusType = $("input[name=cusType]:checked").val();
	
  if (cusType == null){
		showAlert("발송종류를 선택해주십시요.");
		return false;
  } 
  
  if(inputList != null && inputList != ""){
	  maxSize = inputList.length;
  }else{
	  if(receiverNum.trim() == '') {
		    showAlert("휴대폰 번호를 입력해 주세요.");
		    $(this).focus();
		    return false;
	  }
  }
  
  var $frag = $(document.createDocumentFragment());
  for(var i=0; i < maxSize; i++){
	  if(inputType != null && inputType != ""){
		 if(inputType == "file"){
		   	var fileData = inputList[i];
	  		var receiverName = fileData.name != "" ? fileData.name : "이름없음";
	  		var receiverNum = fileData.mobile;
		 }else if(inputType == "select"){
		 	var receiverName = $(inputList[i]).parent().parent().parent().find("label").text();
		 	var receiverNum = $(inputList[i]).parent().parent().parent().find(".phone").text();
		 }
	  }
	
	  if($("#sms-receiver .sms-send-list").children().length >= addMaxCount){
	   //showAlert("수신번호는 최대 1000건까지 등록 가능합니다.");
	   cntOverMaxSize++;
	   continue;
	  }
	    
	  if(receiverNum.trim() == '') {
	    //showAlert("휴대폰 번호를 입력해 주세요.");
	    cntErrorPhone++;
	    textErrorPhone += receiverName+" "+ receiverNum+"<br>"; 
	    continue;
	  }
	  
	  if(!regExp.test(receiverNum) && receiverNum.substr(0,3) != "070") {
	    //showAlert("휴대폰번호 형식에 맞지 않습니다.<br>번호를 정확히 입력해 주세요.<br>["+receiverName+" / "+ receiverNum + "]");
	    cntErrorPhone++;
	    textErrorPhone += receiverName+"/"+ receiverNum+"<br>"; 
	    continue;
	  }
	  	  
	  var overlap = false;
/*
	  //중복체크 로직 제거(backEnd 처리) --- by yoosin 20190719
	  var phoneNumArr = new Array();
	  $("#sms-send-list tr").each(function(index) {
	    phoneNumArr[index] = $(this).find(".phone").text().trim();
	  });
	  
	  var _val = receiverNum.replace(/[^0-9]/g,"");
	  

	  for(var t = 0; t < phoneNumArr.length; t++) {
	    if(phoneNumArr[t] == _val) {
	      //showAlert("중복되는 핸드폰번호가 있습니다.<br>확인해 주세요.");
  			cntErrorOverlap++;
  			textErrorOverlap += receiverName+"/"+ receiverNum+"<br>"; 
  			overlap = true;
  		    break;
	    }
	  } // end for
*/

	  if(!overlap){
		  var _val = receiverNum.replace(/[^0-9]/g,"");
		  $frag.append("<tr><td><div class='checkbox_default'><input type='checkbox' class='dt-check-box' name='addrchk' value='' checked='checked'/><label class='dt-check-box-label' for='addrchk'>"+receiverName+"</label></div></td><td class='phone'>"+_val+"</td></tr>");
	  }
  }
  
  $("#sms-send-list").hide();
  $("#sms-send-list").append($frag);
  addReceiverCount();
  $("#sms-receiver #receiverNum").val("");
  $("#sms-send-list").show();
  
  if(inputList != null && inputList != ""){
	  var textAlert = "";
	  textAlert += '[수신번호 등록]<br>'
	  			+ 			'총 :' + maxSize + '건<br>';
	  
	  if(cntErrorPhone != 0){
		  textAlert += '형식오류 :' + cntErrorPhone + '건<br>';
	  }
	  if(cntErrorOverlap != 0){
		  textAlert += '중복오류 :' + cntErrorOverlap + '건<br>';
	  }
	  if(cntOverMaxSize != 0){
		  textAlert += addMaxCount+'건 초과 :' + cntOverMaxSize + '건<br>';
	  }
	  var cntError = cntErrorPhone + cntErrorOverlap + cntOverMaxSize;
	  if(cntError != 0){
		  textAlert += '정상 :' + (maxSize - cntError) + '건<br><br>';
	  }
	  
	  if(textErrorPhone != ""){
		  textAlert += ' ----------- 휴대폰번호 형식오류 목록 ----------- <br>'
				+				textErrorPhone + '<br>'
	  }
	  if(textErrorOverlap != ""){
		  textAlert += ' ----------- 휴대폰번호 중복오류 목록 ----------- <br>'
				+				textErrorOverlap + '<br>'
	  }
	
	  showAlert(textAlert);
//   console.log(inputName + "[" + i + "] END");
  }
}



////수신번호  추가
// function addTargetList(fileList) {
// 	var receiverNum = $("#receiverNum").val();
// 	var receiverName = "이름없음";
// 	var lastCount = $("#sms-receiver .sms-send-list").children().length;
// 	var appendText = "";
// 	var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	
	
// 	var cusType = $("input[name=cusType]:checked").val();
	
// 	if (cusType == null){
// 		showAlert("발송종류를 선택해주십시요.");
// 		return false;
// 	}
	
	
	
// 	for(var i=0; i < fileList.length; i++){
// 		var fileData = fileList[i];
// 		var inputName = fileData.name;
// 		var inputPhone = fileData.mobile;
		
// 		if(inputName != null && inputName != ""){receiverName = inputName;}
// 		if(inputPhone != null && inputPhone != ""){receiverNum = inputPhone;}

// 		if(lastCount >= 1000){
// 		 showAlert("수신번호는 최대 1000건까지 등록 가능합니다.");
// 		 return false;
// 		}

// 		var phoneNumArr = new Array();
// 		$("#sms-send-list tr").each(function(index) {
// // 		  phoneNumArr[index] = $(this).find(".phone").text().trim();
		  
// 		  var phoneNum = $(this).find(".phone").text().trim();
// 		  var _val = receiverNum.replace(/\-/ig,"");
		  
// 		  if(phoneNum == _val) {
// 			    showAlert("중복되는 핸드폰번호가 있습니다.<br>확인해 주세요.");
// 			    $(this).focus();
// 			    return false;
// 		  }
// 		});
		
// 		var _val = receiverNum.replace(/\-/ig,"");
// 		appendText = appendText + "\n" + "<tr><td><div class='checkbox_default'><input type='checkbox' class='dt-check-box' name='addrchk' value='' checked='checked'/><label class='dt-check-box-label' for='addrchk'>"+receiverName+"</label></div></td><td class='phone'>"+_val+"</td></tr>";
// // 		$("#sms-send-list").append($("<tr><td><div class='checkbox_default'><input type='checkbox' class='dt-check-box' name='addrchk' value='' checked='checked'/><label class='dt-check-box-label' for='addrchk'>"+receiverName+"</label></div></td><td class='phone'>"+_val+"</td></tr>"));
		
// 		lastCount++;
// 	}
	
// 	$("#sms-send-list").append(appendText);
// 	addReceiverCount();
// 	$("#sms-receiver #receiverNum").val("");

// //   console.log(inputName + "[" + i + "] END");
// }





//받는 사람 카운터 갱신
function addReceiverCount() {
  var _count = $("#sms-receiver .sms-send-list").children().length;
  $("#sms-receiver .title span").text(_count);
}

//----------------------------- 수신번호 체크박스 이벤트 설정  ----------------------------------------------------------------
//// 전체 체크박스 클릭 이벤트 리스너
//// datatables 의 모든 셀렉트 박스가 선택 된다.
$('#sms-receiver #select-all').on('click', function () {
	var selectAllChecked = $('#sms-receiver #select-all').prop('checked');
	$("#sms-receiver .dt-check-box").each(function(){
		$(this).prop('checked', selectAllChecked);
	});
});

//// 삭제 버튼 클릭시 선택된 항목을 삭제 하는 이벤트 리스너
//// datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
//// $(document).on 을 사용
$(document).on('click', "#delete-btn", function () {
  var deleteTarget = [];
  ($(".dt-check-box").each(function () {
    if ($(this).prop('checked')) {
      deleteTarget.push($(this).val());
    }
  }));
  if (deleteTarget.length < 1) {
    showAlert("선택된 공지사항이 없습니다.")
  } else {
    var confirmMessage = "총 " + deleteTarget.length + "건 삭제 하시겠습니까?";
    showConfirmForAjax(confirmMessage, deleteNotice, deleteTarget);
  }
});


// 체크 박스 선택시 전체 선택 체크 박스의 체크 여부를 판단하는 이벤트 리스너
// datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
// $(document).on 을 사용
$(document).on('click', '#sms-receiver .dt-check-box-label', function () {
  // If checkbox is not checked
  var $_checkbox = $(this).siblings('input');
  if ($_checkbox.prop('checked')) {
    $_checkbox.prop('checked', false);
    $('#sms-receiver #select-all').prop("checked", false);
  } else {
    $_checkbox.prop('checked', true);
    var checkedCount = $("#sms-receiver .dt-check-box:checked").length;
    if (checkedCount == $("#sms-receiver .dt-check-box").length) {
      $('#sms-receiver #select-all').prop("checked", true);
    }
  }
});

//----------------------------- 수신번호 체크박스 이벤트 설정  End----------------------------------------------------------------



//###############################주소록 목록 @3#####################################################
var addrGroupCode = "personal";

//// 주소록 : 탭 메뉴 클릭 이벤트
$(".tapAddress a").each(function(){
	$(this).on('click', function(){
		var tab = $(this).text();
		
		if(tab == "개인"){ 
			addrGroupCode = "personal"; 
		} else if(tab == "부서"){	
			addrGroupCode = "share";
		}
		
		reloadAddressViewData();
		
	 	$(".tapAddress li.selected").prop("class","");
	 	$(this).parent().prop("class","selected");
	});
});

//// 주소록 : 데이터 출력
function reloadAddressViewData(){
	$.ajax({
		  url: '${pageContext.request.contextPath}/addressCall/'+addrGroupCode,
		  type: "GET",
		  contentType: "application/json; charset=utf-8",
		  dataType: "json",
		  success: function (result) {
			var obj = JSON.stringify(result);  //personalGroupList , shareGroupList, partList, addrType
			
			var html = "";
			var addrType = result.addrType;
			  
			if(addrType == "personal"){ // 개인 탭
				var personalGroupList = result.personalGroupList;
				var shareGroupList = result.shareGroupList;
				
				html += 	'<div class="wrap_tree mgt13" id="addr_treePersonal">'
						+			'<div class="title_tree"><a href="javascript:;" id="all">개인주소록</a></div>'
						+			'<ul>'
						
				for(var i=0; i < personalGroupList.length; i++){
					
					html +=			'<li><a href="javascript:;" id="'+personalGroupList[i].grpSeq+'" emplId="'+personalGroupList[i].emplId+'">'+personalGroupList[i].groupName+'</a></li>'
				}				
				
				html +=			'</ul>'
						+		'</div>'
						+		'<div class="wrap_tree mgt15" id="addr_treeShare">'
						+			'<div class="title_tree"><a href="javascript:;" id="all">부서공유주소록</a></div>'
						+			'<ul>'
				for(var i=0; i < shareGroupList.length; i++){
					html +=			'<li><a href="javascript:;" id="'+shareGroupList[i].grpSeq+'" emplId="'+shareGroupList[i].emplId+'">'+shareGroupList[i].groupName+'</a></li>'
				}		
				html +=			'</ul>'
						+		'</div>'
				
				$("#div_address_GroupList").empty();
				$("#div_address_GroupList").html(html);
				$("#div_address_AddrList").empty();
				
				// 개인주소록 이벤트 설정
				$("#addr_treePersonal a").each(function(){
					$(this).click(function(){
						onClickList = $("#div_address_GroupList a[class=on]");
						onClickList.each(function(){
							$(this).prop("class", "");
						});
						$(this).prop("class", "on");
						
						getAddressList("personal", $(this));
					})
				});
				
				// 부서공유주소록 이벤트 설정
				$("#addr_treeShare a").each(function(){
					$(this).click(function(){
						onClickList = $("#div_address_GroupList a[class=on]");
						onClickList.each(function(){
							$(this).prop("class", "");
						});
						$(this).prop("class", "on");
						
						getAddressList("share", $(this));
					})
				});
				  
			  }else if(addrType == "share"){ // 부서 탭
				  var partList = result.partList;
				  
					html += 	'<div class="wrap_tree mgt13" id="addr_treeGroup">'
						+				'<div class="title_tree">전체주소록</div>'
						+				'<ul>'
					for(var i=0; i < partList.length; i++){
						html +=			'<li><a href="javascript:;" id="'+partList[i].boCode+'">['+partList[i].boCode+'] '+partList[i].partName+'</a></li>'
					}		
					html +=			'</ul>'
						+			'</div>'
				
					$("#div_address_GroupList").empty();
					$("#div_address_GroupList").html(html);
					$("#div_address_AddrList").empty();
				  
					// 부서주소록 이벤트 설정
					$("#addr_treeGroup a").each(function(){
						$(this).click(function(){
							onClickList = $("#div_address_GroupList a[class=on]");
							onClickList.each(function(){
								$(this).prop("class", "");
							});
							$(this).prop("class", "on");
							
							getAddressList("group", $(this));
						})
					});
			  }
		  }
	});
}

//// 주소록 : 그룹 해당 주소록 리스트 출력
function getAddressList(type, obj){
	var objId = obj.prop("id");
	var emplId = obj.attr("emplId");
	console.log(emplId);
//  var emplId = '<%=session.getAttribute("EMPL_ID")%>';
	var url = "${pageContext.request.contextPath}/addressCall/";
// 	/addressCall/{emplId}/{groupType}        : pdef, gdef
	
	if(type == "personal"){ // 개인주소록
		if(objId == "all"){
			url += emplId +"/"+ "pdef";
		}else{
			url += emplId +"/"+ objId;
		}
	}else if(type == "share"){ // 부서공유주소록
		if(objId == "all"){
			url += emplId +"/"+ "gdef";
		}else{
			url += emplId +"/"+ objId;
		}
	}else if(type == "group"){ // 부서주소록 
		if(objId == "all"){
			url += emplId;
		}else{
			url += objId +"/"+ "ddef";
		}
	}

	$.ajax({
		  url: url,
		  type: "GET",
		  contentType: "application/json; charset=utf-8",
		  dataType: "json",
		  success: function (result) {
		  	setAddressList(result);
		  }
	});
}

function setAddressList(result){
	var html = "";

	if(result.length == 0){
		html +=			'<tr>'
				+	    		'<td class="phone" colspan="2"> * 등록된 연락처가 없습니다.</td>'
				+			'</tr>'
	}else{
		for(var i=0; i < result.length; i++){
			var data = result[i];
			
			if(data.mobile != null && data.mobile != ""){
				html +=			'<tr>'
						+	    		'<td>'
						+	    			'<div class="checkbox_default">'
						+	    				'<input type="checkbox" class="dt-check-box" name="addrchk" value="" />'
						+	    				'<label class="dt-check-box-label" for="addrchk">'+data.firstName+'</label>'
						+	    			'</div>'
						+	    		'</td>'
						+	    		'<td class="phone">'+data.mobile.replace(/[^0-9]/g,"")+'</td>'
						+			'</tr>'
			}
		}		
	}
		
	$("#div_address_AddrList").empty();
	$("#div_address_AddrList").html(html);
}

//// 주소록 : 주소록 -> 수신번호 추가 버튼 이벤트
$("#btnAddReciver").on('click', function(){
	var addrs = $("#div_address_AddrList input[name=addrchk]:checked");
	
  	if (addrs.length > 0) {
  		addTargetList(addrs, "select")
  		
//   		addrs.each(function(){
//   			alert( $(addrs[0]).parent().parent().parent().find("label").text())
//   			var name = $(this).parent().parent().parent().find("label").text();
//   			var phone = $(this).parent().parent().parent().find(".phone").text();
  			
//   			addTarget(name, phone);
  			
//   			$(this).prop("checked", false);
//   		});
  		
  		addReceiverCount();//수신번호 총 갯수 갱신
  		$('#sms-address #select-all_address').prop("checked", false);
	} else {
		$('#sms-address #select-all_address').prop("checked", false);
		showAlert("선택된 연락처가 없습니다.");
	}
	return false;
});


//// 주소록 : 검색 버튼 이벤트
$("#btn_addrSearch").on("click", function(){
	var searchWordType = $("#option_AddrSearch option:selected").val()  //조회 항목 명
	var searchWord = $("#text_AddrSearch").val();	//조회 항목 값
	
	if(searchWord == null || searchWord == ""){
		showAlert("입력된 검색 정보가 없습니다.");
		$("#text_AddrSearch").focus();
		return false;
	}
	
	if(searchWordType == 'phone' && searchWord.length < 7)
	{
		showAlert("핸드폰 번호를 7자리 이상 입력해 주시기 바랍니다.");
		$("#text_AddrSearch").focus();
		return false;
	}
	
	var type = $(".tapAddress li.selected a").text();
	var emplId = '<%=session.getAttribute("EMPL_ID")%>';
	var url = "${pageContext.request.contextPath}/addressCall/";
// 	/addressCall/{emplId}/{groupType}        : pdef, gdef
	
	if(type == "개인"){ // 개인탭 검색
		url += emplId +"/"+ "pdef";
	}else if(type == "부서"){ // 부서탭 검색
		url += "0000/ddef";
	}
	
	$.ajax({
		  url: url,
		  type: "GET",
		  contentType: "application/json; charset=utf-8",
		  dataType: "json",
		  data: {"searchWordType":searchWordType
			  		,"searchWord":searchWord
		  },
		  success: function (result) {
				onClickList = $("#div_address_GroupList a[class=on]");
				onClickList.each(function(){
					$(this).prop("class", "");
				});
				setAddressList(result);
				
				//검색 텍스트 박스 초기화
				$("#text_AddrSearch").val("");
		  }
	});
	
});


//----------------------------- 주소록 체크박스 이벤트 설정  ----------------------------------------------------------------
////전체 체크박스 클릭 이벤트 리스너
////datatables 의 모든 셀렉트 박스가 선택 된다.
$('#sms-address #select-all_address').on('click', function () {
var selectAllChecked = $('#sms-address #select-all_address').prop('checked');
$("#sms-address .dt-check-box").each(function(){
	$(this).prop('checked', selectAllChecked);
});
});


//체크 박스 선택시 전체 선택 체크 박스의 체크 여부를 판단하는 이벤트 리스너
//datatables 가 생성되고 난 후에 이벤트 리스너를 등록 해야 하기 때문에
//$(document).on 을 사용
$(document).on('click', '#sms-address .dt-check-box-label', function () {
// If checkbox is not checked
var $_checkbox = $(this).siblings('input');
if ($_checkbox.prop('checked')) {
$_checkbox.prop('checked', false);
$('#sms-address #select-all_address').prop("checked", false);
} else {
$_checkbox.prop('checked', true);
var checkedCount = $("#sms-address .dt-check-box:checked").length;
if (checkedCount == $("#sms-address .dt-check-box").length) {
 $('#sms-address #select-all_address').prop("checked", true);
}
}
});

//----------------------------- 주소록 체크박스 이벤트 설정  End----------------------------------------------------------------

//###############################메시지 미리보기 @4#####################################################
var code = "happy"

// 현재 조회된 데이터 정보
var viewDataInfo = null; 
// 조회,저장,삭제 데이터 정보
var msgFormInfo = getMsgFormInfo();

////메시지 미리보기 : 탭 메뉴 클릭 이벤트
$(".tapPreView a").each(function(){
	$(this).on('click', function(){
			var tab = $(this).text();
			if(tab == "해피콜문자")
			{
				code = "happy";
				msgFormInfo = getMsgFormInfo();
				// 해피콜문자 첫번째 서브메뉴 선택 (신규메뉴)
				changeSubMenu($(".wrap_box_ms .menu a:first"))
				msgFormInfo.msgFormCate="1";
				
				reloadPreViewData();
				$(".menu").show();
			}else if(tab == "본부양식")
			{
				code = "head";
				msgFormInfo = getMsgFormInfo();
				
				reloadPreViewData();
				$(".menu").hide();
			}else if(tab == "개인메시지함")
			{
				code = "personal";
				msgFormInfo = getMsgFormInfo();
				
				reloadPreViewData();
				$(".menu").hide();
			}else if(tab == "부서메시지함")
			{
				code = "dept";
				msgFormInfo = getMsgFormInfo();
				
				reloadPreViewData();
				$(".menu").hide();
			}
		}
	);
});


////메시지 미리보기 : 서브 메뉴 클릭 이벤트
$(".wrap_box_ms .menu a").each(function(){
	$(this).on('click', function(){
			changeSubMenu($(this));
			return false;
		}
	);
});

//// 메시지 미리보기 : 해피콜문자 서브 메뉴 클릭 이벤트
function changeSubMenu(obj){
	var onClickList = $(".wrap_box_ms .menu a[class=on]");
	onClickList.each(function(){
		$(this).prop("class", "");
	});
	obj.prop("class", "on");
	
	msgFormInfo = getMsgFormInfo();
	reloadPreViewData();
}

$(document).on('click', '.page-btn', function () {
	msgFormInfo.currentPage = $(this).text();
	reloadPreViewData();
});

$(document).on('click', '#first-page', function () {
	msgFormInfo.currentPage = 1;
	reloadPreViewData();
});

$(document).on('click', '#pre-page', function () {
 var startPage = "${startPage}";
 if(viewDataInfo != null){startPage = viewDataInfo.startPage;}
 
//  msgFormInfo.currentPage = startPage - 1;
 msgFormInfo.currentPage = msgFormInfo.currentPage - 1;
 if (msgFormInfo.currentPage < 1) {
	 msgFormInfo.currentPage = 1;
 }
 reloadPreViewData();
});

$(document).on('click', '#last-page', function () {
 var lastPage = "${lastPage}";
 if(viewDataInfo != null){lastPage = viewDataInfo.lastPage;}
 
 msgFormInfo.currentPage = lastPage;
 reloadPreViewData();
});

$(document).on('click', '#next-page', function () {
 var endPage = "${endPage}";
 var lastPage = "${lastPage}";
 if(viewDataInfo != null){
	 lastPage = viewDataInfo.lastPage;
	 endPage = viewDataInfo.endPage;
}
 
//  msgFormInfo.currentPage = endPage + 1;
msgFormInfo.currentPage = msgFormInfo.currentPage + 1;
 if (msgFormInfo.currentPage > lastPage) {
	 msgFormInfo.currentPage = lastPage;
 }
 reloadPreViewData();
});

/**
 * 메세지 미리보기 화면 리스트 조회
 */
function reloadPreViewData(){
$.ajax({
  url: '${pageContext.request.contextPath}/form/'+code,
  type: "POST",
  contentType: "application/json; charset=utf-8",
  dataType: "json",
  data: JSON.stringify(msgFormInfo),
  success: function (result) {
	  	viewDataInfo = result;
		var dataList = result.data;
		
	    // 미리보기 리스트 갱신
	    var html="";
	    for(var i = 1; i <= dataList.length ; i++)
		{
	    	var data = dataList[i-1];
	    	var seq = i-1
			// 부서서식함, 개인서식함으로 인한 치환
			if(dataList[0].code == "dept")
			{
				data.msgFormCts = data.myMsgCts;
				data.msgFormTit = data.myMsgTitle;
				seq = data.myMsgDateKey;
			}else if(dataList[0].code == "personal")
			{
				data.msgFormCts = data.myMsgCts;
				data.msgFormTit = data.myMsgTitle;
				seq = data.seq;
			}
			
			if(i == 1)
			{
				html += '<ul class="box_ms mgt10">'
			}
			html += '<li>'
					+		'<div class="text_box"><a href="javascript:;" name="a_preView" id="aPreView'+i+'">'+data.msgFormCts+'</a></div>'
					+		'<div class="radio_default mgt8">'
					+			'<input type="radio" name="radio_preView" id="radioPreView'+i+'"/>'
					+			'<label for="radioPreView'+i+'">'+data.msgFormTit+'</label>'
					+			'<input type="hidden" id="seq" value="'+seq+'"/>'
					+		'</div>'
					+	'</li> '
			if(i%4 == 0){
				html += '</ul>'
						+	'<ul class="box_ms">'
			}
			if(i == (dataList.length)){
				html += '</ul>'
			}
		}
		
	    $("#div_MsgFormDataView").empty();
	    $("#div_MsgFormDataView").html(html);
	    
	    // 페이징 처리 갱신
	    html ="";
	    html += '<a href="javascript:;">'
	        + '    <img src="${pageContext.request.contextPath}/static/images/btn_pg_first.png" id="first-page" alt="첫 페이지"/>'
	        + '  </a>';
	    html += '<a href="javascript:;">'
	        + '    <img src="${pageContext.request.contextPath}/static/images/btn_pg_previous.png" id="pre-page" alt="이전 페이지"/>'
	        + '  </a>';
	    html += '<span class="wrap">';
	    for (i = result.startPage; i <= result.endPage; i++) {
	      if (result.currentPage == i) {
	        html += '<a href="javascript:;" class="on">' + i + '</a>'
	      } else {
	        html += "<a href='javascript:;' class='page-btn'>" + i
	            + "</a>"
	      }
	    }
	    html += "</span>";
	
	    html += '<a href="javascript:;">'
	        + '     <img src="${pageContext.request.contextPath}/static/images/btn_pg_next.png" id="next-page"'
	        + 'alt = "다음 페이지" / > '
	        + '</a>';
	    html += '<a href="javascript:;">\n'
	        + '        <img src="${pageContext.request.contextPath}/static/images/btn_pg_last.png" id="last-page"\n'
	        + '        alt="마지막 페이지"/>\n'
	        + '        </a>';
	    $(".paging").empty();
	    $(".paging").html(html);
	    
	    
	    
	////메시지 미리보기 : 미리보기 메세지 선택 이벤트
		$("#div_MsgFormDataView input[name=radio_preView]").each(function(){
	  		$(this).on('click', $(this), function(){
	  			var cusType = $("input[name=cusType]:checked").val();

	  			if (cusType == null)
	  			{
	  				showAlert("발송종류를 선택해주십시요.");
	  				isSmsMainMsg=false;
	  				return false;
	  			}else if (cusType == '1')
	  			{
	  				showAlert("마케팅 목적의 문자는 발송불가하며\n 고객관리(생일축하, 감성메시지 등)은 CRM시스템을 이용해주시기 바랍니다.");
	  				isSmsMainMsg=false;
	  				return false;
	  			}else if (cusType == '0')
	  			{
	  				$(".main-msg").remove();
	  				$("#message").trigger("click");
	  			}
	  			
	  			var msg = $(this).parent().parent().find(".text_box").text();
	  			var title = $(this).parent().parent().find("label").text();
	  			var seq = $(this).parent().find("#seq").val();
	  			setTimeout(function(){		// $("#message").trigger("click") 처리를 위한 딜레이
		  			$("#message").val("");
		  			messageByteCheck(msg);
		  			$("#messageTitle").val(title);
		  			$("#message").focus();
	  			}, 10);
			  });
		 });
	    
		////메시지 미리보기 : 미리보기 메세지 선택 이벤트
		$("#div_MsgFormDataView a[name=a_preView]").each(function(){
	  		$(this).on('click', $(this), function(){
	  			var cusType = $("input[name=cusType]:checked").val();

	  			if (cusType == null)
	  			{
	  				showAlert("발송종류를 선택해주십시요.");
	  				isSmsMainMsg=false;
	  				return false;
	  			}else if (cusType == '1')
	  			{
	  				showAlert("마케팅 목적의 문자는 발송불가하며\n 고객관리(생일축하, 감성메시지 등)은 CRM시스템을 이용해주시기 바랍니다.");
	  				isSmsMainMsg=false;
	  				return false;
	  			}else if (cusType == '0')
	  			{
	  				$(".main-msg").remove();
	  				$("#message").trigger("click");
	  			}
	  			
	  			var msg = $(this).parent().parent().find(".text_box").text();
	  			var title = $(this).parent().parent().find("label").text();
	  			var seq = $(this).parent().find("#seq").val();
	  			setTimeout(function(){		// $("#message").trigger("click") 처리를 위한 딜레이
		  			$("#message").val("");
		  			messageByteCheck(msg);
		  			$("#messageTitle").val(title);
		  			$("#message").focus();
	  			}, 10);
			  });
		 });
	    
	    
	    
	  }
});
}

function getMsgFormInfo() {
var msgFormCate = null;
if(code == "happy")
{
	var msgFormCate = $(".menu .on").text();
	if(msgFormCate == "신규"){
		msgFormCate = "1";
	}else if(msgFormCate == "해피콜"){
		msgFormCate = "2";
	}else if(msgFormCate == "스마트뱅킹"){
		msgFormCate = "8";
	}
}

return {
  "code" : code,
  "division" : "mms",
  "msg" : null,
  "title" : null,
  "seq" : null,
  "msgFormCate": msgFormCate,
  "perPage": 8,
  "currentPage": 1
};
}


$("#zoom-in-btn").on('click', function () {
IbkZoom.zoomIn();
});

$("#zoom-out-btn").on('click', function () {
IbkZoom.zoomOut();
});

////전화번호 형식 입력 @jys
function inputPhoneType(obj){
	  var inputVal = obj.val();
	  obj.val(inputVal.replace(/[^0-9-]/gi,''));
};

</script>
