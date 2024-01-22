<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<h3>본부양식
</h3>

<!-- content -->
<div id="content">
		<!-- wrap_form -->
		<div class="wrap_form">
				<div class="info_form">메시지 등록은 문자보내기에서 가능합니다.</div>
				<div id="div_MsgFormDataView">
					<c:forEach var="data" items="${dataList}" varStatus="status">
						<c:set var="seq" value="${status.index}"></c:set>
						<!-- 부서서식함, 개인서식함으로 인한 치환-->
						<c:if test="${dataList[0].code eq 'dept'}" >
							<c:set target="${data}" property="msgFormCts" value="${data.myMsgCts}"></c:set>
							<c:set target="${data}" property="msgFormTit" value="${data.myMsgTitle}"></c:set>
							<c:set var="seq" value="${data.myMsgDateKey}"></c:set>
						</c:if>
						<c:if test="${dataList[0].code eq 'personal'}" >
							<c:set target="${data}" property="msgFormCts" value="${data.myMsgCts}"></c:set>
							<c:set target="${data}" property="msgFormTit" value="${data.myMsgTitle}"></c:set>
							<c:set var="seq" value="${data.seq}"></c:set>
						</c:if>
						<!-- 부서서식함, 개인서식함으로 인한 치환 end-->
						
						<c:if test="${status.first}">
							<ul class="box_ms mgt10">
						</c:if>
							<li>
								<div class="text_box">${data.msgFormCts}</div>
								<div class="radio_default mgt8">
										<input type="radio" name="radio_preView" id="radio${status.count}"/>
										<label for="radio${status.count}">${data.msgFormTit}</label>
										<input type="hidden" id="seq" value="${seq}"/>
								</div>
							</li>
						<c:if test="${status.count mod 4 == 0}">
							</ul>
							<ul class="box_ms">
						</c:if>
						<c:if test="${status.last}">
							</ul>
						</c:if>
					</c:forEach>
				</div>			
		</div>
		<!-- //wrap_form -->
		<!-- 페이징 -->
		<div class="paging">
			<a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pg_first.png" id="first-page" alt="첫 페이지"/></a>
	        <a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pg_previous.png" id="pre-page" alt="이전 페이지"/></a>
	        <span class="wrap">
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			    	<c:choose>
			    		<c:when test="${currentPage == i}">
			    			<a class="on" href="#">${i}</a>
			    		</c:when>
			    		<c:otherwise>
			    			<a href='javascript:;' class='page-btn'>${i}</a>
			    		</c:otherwise>
			    	</c:choose>
				</c:forEach>
			</span>
			<a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pg_next.png" id="next-page" alt = "다음 페이지" /></a><a href="javascript:;"><img src="${pageContext.request.contextPath}/static/images/btn_pg_last.png" id="last-page" alt="마지막 페이지"/></a>
		</div>
		<!-- //페이징 --> 
		<!-- 버튼 -->
		<div class="btn_wrap01_list"><a href="javascript:;" class="btn_big blue" id="btn_SavePersonal">개인서식함 저장</a></div>
		<!-- //버튼 --> 
</div>
<!-- //content --> 


<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="./dialog/msgFormDialog.jsp" flush="true"/>
<!-- ajax Loding 이미지 -->
<jsp:include page="../common/loading.jsp" flush="true"/>

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
<!-- Script -->
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/notice-column.js"></script>
<script>
////ajax Loding 이미지 설정
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


var code = "head";
// 현재 조회된 데이터 정보
var viewDataInfo = null; 
// 조회,저장,삭제 데이터 정보
var msgFormInfo = getMsgFormInfo();

$(document).ready(function () {
});

$(document).on('click', '#btn_SavePersonal', function(){
	  var selectData = $("#div_MsgFormDataView input[name=radio_preView]:checked");
	  
	  if(selectData.length < 1)
	  {
		  showAlert("메시지가 선택되지 않았습니다.<br>메세지 선택 후 다시 시도 하시기 바랍니다.");
		  return false;
	  }
	  
	  msgFormInfo.msg = selectData.parent().parent().find(".text_box").text();
	  msgFormInfo.title =  selectData.parent().parent().find("label").text();
	  msgFormInfo.seq =  selectData.parent().find("#seq").val();
	  
	  showConfirmSave("개인서식함에 저장 하시겠습니까?", savePersonalForm);  
});

function savePersonalForm(){
	  $.ajax({
	      url: '${pageContext.request.contextPath}/form/personal/save',
	      type: "POST",
	      contentType: "application/json; charset=utf-8",
	      dataType: "json",
	      data: JSON.stringify(msgFormInfo),
	      success: function (result) {
	    	  if(result > 0)
	  		  {
			    	  showAlert("저장에 성공하였습니다.");
	  		  }
	      }
	  });
}

$(document).on('click', '.page-btn', function () {
		msgFormInfo.currentPage = $(this).text();
		reloadData();
  });

 $(document).on('click', '#first-page', function () {
		msgFormInfo.currentPage = 1;
		reloadData();
 });

 $(document).on('click', '#pre-page', function () {
	 var startPage = "${startPage}";
	 if(viewDataInfo != null){startPage = viewDataInfo.startPage;}
	 
	 msgFormInfo.currentPage = msgFormInfo.currentPage - 1;
   if (msgFormInfo.currentPage < 1) {
  	 msgFormInfo.currentPage = 1;
   }
   reloadData();
 });

 $(document).on('click', '#last-page', function () {
	 var lastPage = "${lastPage}";
	 if(viewDataInfo != null){lastPage = viewDataInfo.lastPage;}
	 
	 msgFormInfo.currentPage = lastPage;
	 reloadData();
 });

 $(document).on('click', '#next-page', function () {
	 var endPage = "${endPage}";
	 var lastPage = "${lastPage}";
	 if(viewDataInfo != null){
		 lastPage = viewDataInfo.lastPage;
		 endPage = viewDataInfo.endPage;
	}
	 
	 msgFormInfo.currentPage = msgFormInfo.currentPage + 1;
   if (msgFormInfo.currentPage > lastPage) {
  	 msgFormInfo.currentPage = lastPage;
   }
   reloadData();
 });

function reloadData(){
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
					+		'<div class="text_box">'+data.msgFormCts+'</div>'
					+		'<div class="radio_default mgt8">'
					+			'<input type="radio" name="radio_preView" id="radio'+i+'"/>'
					+			'<label for="radio'+i+'">'+data.msgFormTit+'</label>'
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
          html += '<a href="#" class="on">' + i + '</a>'
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
    }
  });
}

function getMsgFormInfo() {
  return {
	"code" : code,
	"division" : "mms",
	"msg" : null,
    "title" : null,
    "seq" : null,
    "msgFormCate": null,
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
</script>
</script>
