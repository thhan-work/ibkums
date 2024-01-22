<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--popup-->
<div class="popup_wrap" id="reserve-modal" style="display: none;">
  <!-- top -->
  <div class="top">
    <div class="title">예약전송</div>
    <div class="btn_close"><a href="javascript:;" id="btn_reserve_close"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
  </div>
 <!-- //top --> 
  
  <!-- content -->
  <div class="content_pop"> 
    <!-- Search -->
    <div class="box_search01">
      <ul>
        <li> <span>
			<select class="small" name="year">
			</select>
			</span><span class="text1">년</span> <span>
			
			<select class="small" name="month">
          	</select>
          	</span><span class="text1">월</span> <span>
          	
	        <select class="small" name="date">
	       	</select>
          	</span><span class="text1">일</span> <span>
          	
          <select class="small" name="hour">
          </select>
          </span><span class="text1">시</span> <span>
          <select class="small" name="min">
          </select>
          </span><span class="text1">분</span> </li>
      </ul>
    </div>
    <!-- //Search -->
    <div class="mgt10">* 예약전송 가능시간은 07:30 ~ 20:50 까지 입니다.</div>
    <div class="mgt5">* 참좋은 음악회 관련해서만 22:59까지 예약 해주시기 바랍니다.</div>
  </div>
  <!-- //content --> 
  
  <!-- footer -->
  <div class="footer_pop"> 
    <!-- button --><a href="javascript:;" class="btn_big blue" id="btn_reserve_ok">등록</a><a href="javascript:;" class="btn_big gray" id="btn_reserve_cancel">취소</a><!-- //button --> 
  </div>
  <!-- //footer --> 
</div>
<!--//popup-->

<script>
$(document).ready(function () {
	  initSetDate();
});

var year  = $("select[name=year]");
var month = $("select[name=month]");
var date  = $("select[name=date]");
var hour  = $("select[name=hour]");
var min   = $("select[name=min]");


function showReserve() {
	initSetDate();
  
	$("#btn_reserve_close").off().on('click', function () {
	    $("#reserve-modal").dialog("close");
	});
	
	$("#btn_reserve_ok").off('click').on('click', function () {
	    $("#reserve-modal").dialog("close");
		setReserveDate();
	});
	
	$("#btn_reserve_cancel").off('click').on('click', function () {
	    $("#reserve-modal").dialog("close");
	});
	
	
	$("#reserve-modal").dialog({
	    modal: true,
	    width: "530px",
	    open: function () {
	      $(this).css('padding', '0px');
	    },
	  });
	$(".ui-dialog-titlebar").hide();
}


//// 현재시간으로 셋팅
function initSetDate(){
	  // 현재시간 설정.
	  var now   = new Date();
	  
	  year.html(messageInitData.getYearOptionHtml(5, 0));
	  month.html(messageInitData.getMonthOptionHtml());
	  date.html(messageInitData.getDayOptionHtml(now.getFullYear(), (now.getMonth() + 1)));
	  hour.html(messageInitData.getHourOptionHtml());
	  min.html(messageInitData.getMinOptionHtml());
	  
	  var yearVal = now.getFullYear();
  	  var monthVal = (now.getMonth() + 1) < 10 ? "0"+(now.getMonth() + 1) : (now.getMonth() + 1)
  	  var dateVal = now.getDate() < 10 ? "0"+now.getDate() : now.getDate();
  	  var hourVal = now.getHours() < 10 ? "0"+now.getHours() : now.getHours();
  	  var minVal = now.getMinutes() < 10 ? "0"+now.getMinutes() : now.getMinutes();
	  
	  year.val(yearVal);
	  month.val(monthVal);
	  date.val(dateVal);
	  hour.val(hourVal);
	  min.val(minVal);	
	  
	  year.change(function(){
		  changeLastDay();
	  });

	  month.change(function(){
		  changeLastDay();
	  });
}

function changeLastDay(){
	// 선택 년,월의 마지막일 보정
	var monthLastDay = ( new Date( year.val(), month.val(), 0) ).getDate();
	var dateVal = $("select[name=date]").val();
	
	if(dateVal > monthLastDay){
		dateVal = '01';
	}
	
	date.empty();
	date.html(messageInitData.getDayOptionHtml(year.val(), month.val()));
	date.val(dateVal);
}

  function setReserveDate(){
	    var reservedTime = year.val() + "년 " + month.val() + "월 " + date.val() + "일 " + hour.val() + "시 " + min.val() + "분";
	    var _reservedTime = 
	    	year.val() + 
	    	((month.val().length == 1)? "0" + month.val() : month.val()) + 
	    	((date.val().length  == 1)? "0" + date.val()  :  date.val()) + 
	    	((hour.val().length  == 1)? "0" + hour.val()  :  hour.val()) +
	    	((min.val().length   == 1)? "0" + min.val()   :  min.val());
	    
	    // 예약발송 유효성 체크
	    var length = _reservedTime.length;
	    var time = _reservedTime.substring(length-4, length);
	    
	    /*
	    if(time < 730 || time > 2050) {
	      jAlert(" 예약발송 가능 시간을 확인해 주세요.");
	      return false;
	    }
	    */
	    if(time < 730 || time > 2259) {
		      showAlert(" 예약발송 가능 시간을 확인해 주세요.");
		      return false;
	    }
	    
	    var now2   = new Date();
	    var year2  = now2.getFullYear() + "";
	    var month2 = (now2.getMonth() + 1) + "";
	    var date2  = now2.getDate() + "";
	    var hour2  = now2.getHours() + "";
	    var min2   = now2.getMinutes() + "";
	    var currentTime = 
	    	year2 + 
	    	((month2.length == 1)? "0" + month2 : month2) +
	    	((date2.length  == 1)? "0" + date2  : date2) +
	    	((hour2.length  == 1)? "0" + hour2  : hour2) +
	    	((min2.length   == 1)? "0" + min2   : min2);
	    		
	    if(_reservedTime < currentTime ) {
    		showAlert("예약 시간을 확인해 주세요. <br>현재시간보다 이전에 예약설정 할 수 없습니다.");
      		return false;
	    }
	    
	    showAlert(reservedTime + "에 예약설정이 되었습니다.", function() {
	        $("#reserveDate").val(_reservedTime);
	        $("#btn_send").trigger("click");
	    });
  }
  
</script>