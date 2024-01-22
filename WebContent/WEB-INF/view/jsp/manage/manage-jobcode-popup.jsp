<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_c" id="popup_regist" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">등록</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_regist')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view_jobcode">
        <form name="regist_form" id="regist_form">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:150px" />
          <col style="width:auto" />
          <col style="width:150px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">시스템명<span class="th_must">*</span></th>
            <td>
                <input type="text" name="bzwkNm" id="bzwkNm" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">단위상세코드<span class="th_must">*</span></th>
            <td>
                <input type="text" name="bzwkIdnfr" id="bzwkIdnfr" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">업무내용</th>
            <td>
                <input type="text" name="inptCmdCtnt" id="inptCmdCtnt" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">담당부서<span class="th_must">*</span></th>
            <td>
                <input type="text" name="rspblDvsnName" id="rspblDvsnName" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">업무담당자<span class="th_must">*</span></th>
            <td>
                <input type="text" name="rspblPsnName" id="rspblPsnName" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">담당자 연락처<span class="th_must">*</span></th>
            <td>
                <input type="text" name="rspblPsnTelno" id="rspblPsnTelno" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">현업부서</th>
            <td>
                <input type="text" name="emplDvsnNm" id="emplDvsnNm" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">현업담당자</th>
            <td>
                <input type="text" name="emplName" id="emplName" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">활동여부</th>
            <td>
                <select name="liveYn" id="liveYn">
	                <option value="Y">활동</option>
	                <option value="N">미활동</option>
	            </select>
            </td>
            <th scope="row">발송매체</th>
            <td>
                <input type="checkbox" name="sendDstic" id="sendDstic" value="SMS"/>SMS
                <input type="checkbox" name="sendDstic" id="sendDstic" value="LMS"/>LMS
                <input type="checkbox" name="sendDstic" id="sendDstic" value="MMS"/>MMS
            </td>
          </tr>
          
          <tr>
            <th scope="row">통지대상</th>
            <td>
                <input type="text" name="noticeObject" id="noticeObject" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">메시지조립여부</th>
            <td>
                <input type="text" name="msgAsblStsizCtnt" id="msgAsblStsizCtnt" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">발송주기 및 시간</th>
            <td>
                <input type="text" name="valdFrqnCtnt" id="valdFrqnCtnt" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">개발적용일</th>
            <td>
                <input type="text" name="dvlmYms" id="dvlmYms" value="" placeholder="" style="width:280px;">                
            </td>
          </tr>
          
          <tr>
            
            <th scope="row">인터페이스</th>
            <td colspan="3">
                <input type="text" name="interface" id="interface" value="" placeholder="" style="width:763px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">서비스 IP</th>
            <td>
                <input type="text" name="serviceIp" id="serviceIp" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">서비스 PORT</th>
            <td>
                <input type="text" name="servicePort" id="servicePort" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">단순통지</th>
            <td>
                <select name="simpleNotice" id="simpleNotice">
	                <option value="Y">Y</option>
	                <option value="N">N</option>
	            </select>
            </td>
            <th scope="row">거래에 영향이 있는 통지</th>
            <td>
                <select name="tranEffeNotice" id="tranEffeNotice">
	                <option value="Y">Y</option>
	                <option value="N">N</option>
	            </select>
            </td>
          </tr>
          
          <tr>
            <th scope="row">비고</th>
            <td>
                <input type="text" name="outptCmdCtnt" id="outptCmdCtnt" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">고객접촉IF테이블</th>
            <td>
                <input type="text" name="custContIf" id="custContIf" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">동기/비동기</th>
            <td>
                <select id="synAsyn" name="synAsyn">
	                <option value="Y">동기</option>
	                <option value="N">비동기</option>
	            </select>
            </td>
            <th scope="row">IF ID</th>
            <td>
                <input type="text" name="ifId" id="ifId" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">타겟 I/O</th>
            <td>
                <input type="text" name="targetIo" id="targetIo" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">USER ID</th>
            <td>
                <input type="text" name="userId" id="userId" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">메시지형태</th>
            <td>
                <textarea type="text" name="smplMsgCtnt" id="smplMsgCtnt" value="" placeholder="" style="width:280px;"></textarea>
            </td>
            <th scope="row">함수/트리거/<br>DB정보</th>
            <td>
                <textarea type="text" name="funcTriInfo" id="funcTriInfo" value="" placeholder="" style="width:280px;"></textarea>
            </td>
          </tr>
          
          <tr>
            <th scope="row">거래안되는 사유</th>
            <td colspan="3">
                <input type="text" name="tranNoReason" id="tranNoReason" value="" placeholder="" style="width:763px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">데이터저장경로</th>
            <td>
                <input type="text" name="dataSavePath" id="dataSavePath" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">서비스 ID</th>
            <td>
                <input type="text" name="serviceId" id="serviceId" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
        </table>
        </form>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="#" id="save_jobcode_btn" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  onclick="popClose('#popup_regist')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<!--popup-->
<div class="popup_wrap_c" id="popup_modify" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">수정</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_modify')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view_jobcode">
        <form name="modify_form" id="modify_form">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">시스템명<span class="th_must">*</span></th>
            <td>
                <input type="text" name="bzwkNm" id="bzwkNm" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">단위상세코드<span class="th_must">*</span></th>
            <td>
                <input type="text" name="bzwkIdnfr" id="bzwkIdnfr" value="" placeholder="" style="width:280px;background-color: lightgray;" readonly>
            </td>
          </tr>
          
          <tr>
            <th scope="row">업무내용</th>
            <td>
                <input type="text" name="inptCmdCtnt" id="inptCmdCtnt" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">담당부서<span class="th_must">*</span></th>
            <td>
                <input type="text" name="rspblDvsnName" id="rspblDvsnName" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">업무담당자<span class="th_must">*</span></th>
            <td>
                <input type="text" name="rspblPsnName" id="rspblPsnName" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">담당자 연락처<span class="th_must">*</span></th>
            <td>
                <input type="text" name="rspblPsnTelno" id="rspblPsnTelno" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">현업부서</th>
            <td>
                <input type="text" name="emplDvsnNm" id="emplDvsnNm" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">현업담당자</th>
            <td>
                <input type="text" name="emplName" id="emplName" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">활동여부</th>
            <td>
                <select name="liveYn" id="liveYn">
	                <option value="Y">활동</option>
	                <option value="N">미활동</option>
	            </select>
            </td>
            <th scope="row">발송매체</th>
            <td>
                <input type="checkbox" name="sendDstic" id="sendDstic" value="SMS"/>SMS
                <input type="checkbox" name="sendDstic" id="sendDstic" value="LMS"/>LMS
                <input type="checkbox" name="sendDstic" id="sendDstic" value="MMS"/>MMS
            </td>
          </tr>
          
          <tr>
            <th scope="row">통지대상</th>
            <td>
                <input type="text" name="noticeObject" id="noticeObject" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">메시지조립여부</th>
            <td>
                <input type="text" name="msgAsblStsizCtnt" id="msgAsblStsizCtnt" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">발송주기 및 시간</th>
            <td>
                <input type="text" name="valdFrqnCtnt" id="valdFrqnCtnt" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">개발적용일</th>
            <td>
                <input type="text" name="dvlmYms" id="dvlmYms" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>            
            <th scope="row">인터페이스</th>
            <td colspan="3">
                <input type="text" name="interface" id="interface" value="" placeholder="" style="width:763px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">서비스 IP</th>
            <td>
                <input type="text" name="serviceIp" id="serviceIp" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">서비스 PORT</th>
            <td>
                <input type="text" name="servicePort" id="servicePort" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">단순통지</th>
            <td>
                <select name="simpleNotice" id="simpleNotice">
	                <option value="Y">Y</option>
	                <option value="N">N</option>
	            </select>
            </td>
            <th scope="row">거래에 영향이 있는 통지</th>
            <td>
                <select name="tranEffeNotice" id="tranEffeNotice">
	                <option value="Y">Y</option>
	                <option value="N">N</option>
	            </select>
            </td>
          </tr>
          
          <tr>
            <th scope="row">비고</th>
            <td>
                <input type="text" name="outptCmdCtnt" id="outptCmdCtnt" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">고객접촉IF테이블</th>
            <td>
                <input type="text" name="custContIf" id="custContIf" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">동기/비동기</th>
            <td>
                <select id="synAsyn" name="synAsyn">
	                <option value="Y">동기</option>
	                <option value="N">비동기</option>
	            </select>
            </td>
            <th scope="row">IF ID</th>
            <td>
                <input type="text" name="ifId" id="ifId" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">타겟 I/O</th>
            <td>
                <input type="text" name="targetIo" id="targetIo" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">USER ID</th>
            <td>
                <input type="text" name="userId" id="userId" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">메시지형태</th>
            <td>
                <textarea type="text" name="smplMsgCtnt" id="smplMsgCtnt" value="" placeholder="" style="width:280px;"></textarea>
            </td>
            <th scope="row">함수/트리거/DB정보</th>
            <td>
                <textarea type="text" name="funcTriInfo" id="funcTriInfo" value="" placeholder="" style="width:280px;"></textarea>
            </td>
          </tr>
          
          <tr>
            <th scope="row">거래안되는 사유</th>
            <td colspan="3">
                <input type="text" name="tranNoReason" id="tranNoReason" value="" placeholder="" style="width:763px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">데이터저장경로</th>
            <td>
                <input type="text" name="dataSavePath" id="dataSavePath" value="" placeholder="" style="width:280px;">
            </td>
            <th scope="row">서비스 ID</th>
            <td>
                <input type="text" name="serviceId" id="serviceId" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
        </table>
        </form>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="#" id="update_jobcode_btn" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  onclick="popClose('#popup_modify')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->


<!--popup-->
<div class="popup_wrap_b" id="popup_excel" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">엑셀 업로드</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_excel')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view_jobcode">
        <form name="upload_excel" id="upload_excel" enctype="multipart/form-data">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">중복처리방식</th>
            <td>
                <input type="text" name="bzwkNm" id="bzwkNm" value="" placeholder="" style="width:280px;">
            </td>
          </tr>
          
          <tr>
            <th scope="row">파일</th>
            <td>
                <input type="file" name="excelFile" id="excelFile" style="width:280px;">
            </td>
          </tr>
        </table>
        </form>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="#" id="upload_jobcode_excel" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  onclick="popClose('#popup_excel')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
    function registration_init(){
        popOpen("#popup_regist");
        resetJobCode($("#popup_regist"));
        $("#popup_regist").find("#bzwkNm").focus();
    }
    
    function modification_init(){
        popOpen("#popup_modify");
        resetJobCode($("#popup_modify"));
    }
    
    function upload_init(){
        popOpen("#popup_excel");
        resetJobCode($("#popup_excel"));
    }
    
    //전화번호 형식 입력
    function inputPhoneType(obj){
  	  var inputVal = obj.val();
  	  obj.val(inputVal.replace(/[^0-9-]/gi,''));
    };
    
    $("#rspblPsnTelno").on("keyup", function(){
    	inputPhoneType($(this));
    });
    
    $("#popup_excel").find("#upload_jobcode_excel").on('click', function(){
   		var popup = $("#popup_excel");
   		var form = $('#upload_excel')[0];
   	    var data = new FormData(form);
   	    
   		$.ajax({
   	        type: "POST",
   	        enctype: 'multipart/form-data',
   	        url: "${pageContext.request.contextPath}/manage-jobcode-upload",
   	        data: data,
   	        processData: false,
   	        contentType: false,
   	        cache: false,
   	        timeout: 600000,
   	        success: function (data) {
   	        	showAlert("업로드에 성공하였습니다.");
              	$("#alert-modal").parent().css({'z-index':30000000});
   	         	popClose('#popup_excel');
   	         	IbkDataTable.reload();
   	        },
   	        error: function (e) {
   	        	showAlert("업로드에 실패하였습니다.");
              	$("#alert-modal").parent().css({'z-index':30000000});   	         	
   	        }
   	    });
   	 });
    	 
   	 $("#popup_modify").find("#update_jobcode_btn").on('click', function(){
   		var popup = $("#popup_modify");
 		var jobCodeInfo = getJobCodeInfo($("#modify_form"));
 		var isOk = checkRequiredField(popup, jobCodeInfo
				, ['bzwkNm','bzwkIdnfr','rspblDvsnName','rspblPsnName','rspblPsnTelno']
		); 
 		
 		if (isOk) {
        	jobCodeUpdate(jobCodeInfo);
 		}
   	 });
       	 
  	 $("#popup_regist").find("#save_jobcode_btn").on('click', function(){
  		 var popup = $("#regist_form");
  		 var jobCodeInfo = getJobCodeInfo(popup);
  		 

		var isOk = checkRequiredField($("#popup_regist"), jobCodeInfo
				, ['bzwkNm','bzwkIdnfr','rspblDvsnName','rspblPsnName','rspblPsnTelno']
		);
  		 
		if (isOk) {
			$.ajax({
              url: '${pageContext.request.contextPath}/manage-jobcode/' + popup.find("#bzwkIdnfr").val() +'/count',
                  type: 'GET',
                  success: function (result) {
                     if(result >= 1){
                    	showAlert("해당 업무코드는 이미 존재합니다.");
                      	$("#alert-modal").parent().css({'z-index':30000000});
                     }else{
                    	jobCodeRegistration(jobCodeInfo);
                     }
              }
          });
		}
    });
  	 
  	 function checkRequiredField(popup, param, required) {
  		 for(var idx in required) {
  			 var requiredFieldName = required[idx];
  			 var paramValue = param[requiredFieldName];
  			 
  			if (paramValue == undefined || paramValue == null || paramValue == "") {
  				showAlert("필수 항목을 모두 입력하세요.", function() {
  					popup.find("#" + requiredFieldName).focus();
  				});
  	         	$("#alert-modal").parent().css({'z-index':30000000});
  				return false;
  			} 
  		 }
  		 
  		 return true;
  	 }

  function getJobCodeInfo(popup) {
	  var formArray = popup.serializeArray();
	  
	  var param = {};
	  for(var idx in formArray) {
		  var element = formArray[idx];
		  var name = element.name;
		  
		  if(param[name] != undefined) {
			  var paramValue = param[name];
			  paramValue += '/' + element.value;
			  param[name] = paramValue;				  
		  } else {
			  param[name] = element.value;
		  }	  
		  
	  }
	  return param;	 
  }
  
  function resetJobCode(popup) {
	  popup.find(':input')
		  .not(':button, :submit, :reset, :hidden, :checkbox')
		  .val('')
		  .prop('checked', false)
		  .prop('selected', false);
	  
	  popup.find(':input:checkbox')	  
		  .prop('checked', false)
		  .prop('selected', false);
  }
  
   function setJobCodeInfo(popup, result) {
	   for(var name in result) {
		   if (name == "sendDstic") {
			   continue;
		   }
		   var value = result[name];
		   popup.find("#"+name).val(value);
	   }
	   
	   var sendDstic = result.sendDstic;
	   if (sendDstic != null && sendDstic != "" && sendDstic != undefined) {
			var sendDsticArray = sendDstic.split("/");
			for(var sendDsticItem in sendDsticArray) {
				popup.find('#sendDstic[value="'+sendDsticArray[sendDsticItem]+'"]').prop("checked", 'checked');		
			}
	   }
  }
   
  function jobCodeUpdate(jobCodeInfo){
    $.ajax({
      url: '${pageContext.request.contextPath}/manage-jobcode/'+ jobCodeInfo.bzwkIdnfr,
      type: "PUT",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(jobCodeInfo),
      success: function (result) {
        showAlert("정보 수정이 되었습니다.");
        $("#alert-modal").parent().css({'z-index':30000000});
        popClose('#popup_modify');
        IbkDataTable.reload();
      }
    });
  }
  
  function jobCodeRegistration(jobCodeInfo){
    $.ajax({
      url: '${pageContext.request.contextPath}/manage-jobcode',
      type: "POST",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(jobCodeInfo),
      success: function (result) {
        showAlert("정보 등록을 완료 하였습니다.");
        $("#alert-modal").parent().css({'z-index':30000000});
        popClose('#popup_regist');
        IbkDataTable.reload();
      }
    });
  }
</script>