<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div class="popup_wrap" id="search-modal" style="display: none;">
    <!-- top -->
    <div class="top">
        <div class="title">수신인 검색 결과</div>
        <div class="btn_close"><a href="javascript:;" id="btn_search_close"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
        <div class="pop_wrap_tree">
            <div class="wrap_tree2" id="sms-search-rej">
            </div>
        </div>
    </div>
    <!-- //content -->
    <!-- footer -->
    <div class="footer_pop">
        <!-- button --><a href="javascript:;" class="btn_big blue" id="btn_search_ok">확인</a><a href="javascript:;" class="btn_big gray" id="btn_search_cancel">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->


<script>
function showSearch(type, boCode) {		
	initData(type, boCode); //수신인 검색
	
	$("#btn_search_close").off('click').on('click', function () {
		$("#search-modal").dialog("close");
	});
	  
	$("#btn_search_cancel").off('click').on('click', function () {
		$("#search-modal").dialog("close");
	});
	  
	//확인 버튼 이벤트
	$("#btn_search_ok").off('click').click(function() {
		var addrs = $("#sms-search-rej input[name=chk]:checked");
	  	if (addrs.length > 0) {
	  		addrs.each(function(){
	  			var name = $(this).parent().find("label").text();
	  			var phone = $(this).parent().find("#phone").text();
	  			
	  			addTarget(name, phone);// 수신번호 목록에 등록
	  		});
	  		addReceiverCount();//수신번호 총 갯수 갱신
		} else {
			showAlert("선택된 연락처가 없습니다.");
		}
	  	$("#search-modal").dialog("close");
	});
    
    
    $("#search-modal").dialog({
		modal: true,
		width: "500px",
		open: function () {
		$(this).css('padding', '0px');
		},
	});
    $(".ui-dialog-titlebar").hide();
}
 
//수신인 검색
function initData(type, boCode){
	$.ajax({
        url: '${pageContext.request.contextPath}/eventsend/search/'+type+'/'+boCode,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
        	var html = "";
        	
        	var contentUL = $("#sms-search-rej");
    		contentUL.empty();
        	if(result.length < 1) {
        		contentUL.html("검색 결과가 없습니다.");
        		return false;
        	}
        	
        	html +=		'<div class="title_tree checkbox_default fn">'
       		html +=			'<input type="checkbox" id="checkbox0" name="chk-all" />'
  			html +=			'<label for="checkbox0">검색결과</label>'
			html +=		'</div>'
			html +=		'<ul id="serach-event-list">'	
			html +=		'</ul>'
        
			contentUL.html(html);
			
			html ="";
        	for(var i=0; i < result.length; i++){
        		var data = result[i];
        		
        		if(type == "code"){//영업점 수신인
        			html += '<li>'
    				html += 	'<div class="checkbox_default fn">'
  					html += 		'<input type="checkbox" id="searchCheckBox'+i+'" name="chk" />'
					html +=			'<label for="searchCheckBox'+i+'" id="name">'+data.emplName+'</label><span class="mgl11" id="phone">'+data.emplHpNo+'</span>'
  					html += 	'</div>'
					html += '</li>'
        		}else if(type == "area"){//지역소속 수신인
        			html += '<li>'
       				html += 	'<div class="checkbox_default fn">'
  					html += 		'<input type="checkbox" id="searchCheckBox'+i+'" name="chk" />'
					html +=			'<label for="searchCheckBox'+i+'" id="name">'+data.boCode+'</label><span class="mgl11" id="phone">'+data.partName+'</span>'
  					html += 	'</div>'
   					html += '</li>'
        		}
        	}
        	$("#serach-event-list").empty();
        	$("#serach-event-list").html(html);
        	
        	// 전체 체크 이벤트
        	$("#sms-search-rej input[name=chk-all]").off('click').click(function() {
        		if ($(this).prop("checked")) {
        			$("input[name=chk]").prop("checked", true);
        		} else {
        			$("input[name=chk]").prop("checked", false);
        		}
        	});	
        }
     });
}
</script>