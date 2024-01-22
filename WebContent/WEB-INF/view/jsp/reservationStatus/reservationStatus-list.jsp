<%@ page contentType="text/html;charset=UTF-8" language="java" %>

      <h3>발송예약 현황보기
      </h3>
      <!-- content -->
      <div id="content">
        
        <div class="wrap_sendcs">
        	<!-- 달력 -->
          <div class="box_calendar">
          	<!-- 버튼 -->
            <div class="wrap_btn">
            	
              <a href="javascript:;" id="preMonth"><img src="${pageContext.request.contextPath}/static/images/btn_calendar_left.png" alt="이전달"/></a>
              <div class="dropdown mgl24">
              <button onclick="myFunction()" class="dropbtn_year"></button>
                <div id="dropbtn_year" class="dropdown-content">
                </div>
              </div>
              <div class="dropdown mgl12 mgr24">
              <button onclick="myFunction2()" class="dropbtn_month"></button>
                <div id="dropbtn_month" class="dropdown-content month">
                </div>
              </div>
              <a href="javascript:;" id="nextMonth"><img src="${pageContext.request.contextPath}/static/images/btn_calendar_right.png" alt="다음달" /></a>
            </div>
            <!-- //버튼 -->
            <!-- table list -->
            <div class="tbl_wrap_calendar mgt20">
              <table class="tbl_list" summary="테이블 입니다. 항목으로는 등이 있습니다">
                <caption>
                테이블
                </caption>
                <colgroup>
                <col style="width:107px" />
                <col style="width:107px" />
                <col style="width:107px" />
                <col style="width:107px" />
                <col style="width:107px" />
                <col style="width:107px" />
                <col style="width:107px" />
                </colgroup>
                <thead>
                  <tr>
                    <th scope="col">일</th>
                    <th scope="col">월</th>
                    <th scope="col">화</th>
                    <th scope="col">수</th>
                    <th scope="col">목</th>
                    <th scope="col">금</th>
                    <th scope="col">토</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td valign="top" id="W1-0">&nbsp;</td>
                    <td valign="top" id="W1-1">&nbsp;</td>
                    <td valign="top" id="W1-2">&nbsp;</td>
                    <td valign="top" id="W1-3">&nbsp;</td>
                    <td valign="top" id="W1-4">&nbsp;</td>
                    <td valign="top" id="W1-5">&nbsp;</td>
                    <td valign="top" id="W1-6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" id="W2-0">&nbsp;</td>
                    <td valign="top" id="W2-1">&nbsp;</td>
                    <td valign="top" id="W2-2">&nbsp;</td>
                    <td valign="top" id="W2-3">&nbsp;</td>
                    <td valign="top" id="W2-4">&nbsp;</td>
                    <td valign="top" id="W2-5">&nbsp;</td>
                    <td valign="top" id="W2-6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" id="W3-0">&nbsp;</td>
                    <td valign="top" id="W3-1">&nbsp;</td>
                    <td valign="top" id="W3-2">&nbsp;</td>
                    <td valign="top" id="W3-3">&nbsp;</td>
                    <td valign="top" id="W3-4">&nbsp;</td>
                    <td valign="top" id="W3-5">&nbsp;</td>
                    <td valign="top" id="W3-6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" id="W4-0">&nbsp;</td>
                    <td valign="top" id="W4-1">&nbsp;</td>
                    <td valign="top" id="W4-2">&nbsp;</td>
                    <td valign="top" id="W4-3">&nbsp;</td>
                    <td valign="top" id="W4-4">&nbsp;</td>
                    <td valign="top" id="W4-5">&nbsp;</td>
                    <td valign="top" id="W4-6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" id="W5-0">&nbsp;</td>
                    <td valign="top" id="W5-1">&nbsp;</td>
                    <td valign="top" id="W5-2">&nbsp;</td>
                    <td valign="top" id="W5-3">&nbsp;</td>
                    <td valign="top" id="W5-4">&nbsp;</td>
                    <td valign="top" id="W5-5">&nbsp;</td>
                    <td valign="top" id="W5-6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" id="W6-0">&nbsp;</td>
                    <td valign="top" id="W6-1">&nbsp;</td>
                    <td valign="top" id="W6-2">&nbsp;</td>
                    <td valign="top" id="W6-3">&nbsp;</td>
                    <td valign="top" id="W6-4">&nbsp;</td>
                    <td valign="top" id="W6-5">&nbsp;</td>
                    <td valign="top" id="W6-6">&nbsp;</td>
                  </tr>
                  </tbody>
              </table>
            </div>
            <!-- //table list -->
          </div>
          <!-- //달력 -->
          <!-- 리스트 -->
          <div class="box_list" id="hourly_reservation_list">
          	<div class="title">시간별 예약 내역</div>
          </div>
        	<!-- //리스트 -->
        </div>
        
      </div>
      <!-- //content --> 
    
    
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<jsp:include page="./dialog/reservationSelectDay-list.jsp" flush="true"/>

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
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!-- Script -->
<!-- common event handler on list pages  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>



<script>
$(document).ready(function () {
	//상단 날짜 선택 selectBox 값 셋팅
	setSelectDate();
	//우측 시간별 예약 내역 셋팅
	setDateAndTotCnt_HourlyList();
	
	//이전달 버튼 이벤트
	$("#preMonth").off("click").on("click", function(){
		var year = $(".dropbtn_year").text().replace("년","");
		var month = $(".dropbtn_month").text().replace("월","");
		
		var now = new Date();
		if(now.getFullYear() == year && (now.getMonth() + 1) == month){
			showAlert("이번달" + "("+year + "/" + month+") 이전 날짜는 <br>조회가 불가능 합니다.");
			return false;
		}
		
		// 전 달로 셋팅
		month = (parseInt(month) - 1).toString();
		// 1월 전 달 선택 시 년도 변경
		if(month == "0"){
			year = (parseInt(year) - 1).toString();
			month = "12";
		}
		
		setSelectDate(year, month);
	});
	
	//다음달 버튼 이벤트
	$("#nextMonth").off("click").on("click", function(){
		var year = $(".dropbtn_year").text().replace("년","");
		var month = $(".dropbtn_month").text().replace("월","");
		// 다음 달로 셋팅
		month = (parseInt(month) + 1).toString();
		// 12월 다음 달 선택 시 년도 변경
		if(month == "13"){
			year = (parseInt(year) + 1).toString();
			month = "1";
		}
		
		setSelectDate(year, month);
	});
});


/* 년/월 클릭 시 선택박스 나오도록 세팅 */
function myFunction() {
    document.getElementById("dropbtn_year").classList.toggle("show");
}
function myFunction2() {
    document.getElementById("dropbtn_month").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  var eventClass = $(event.target).prop('class')
 
  if (eventClass != "dropbtn_year" && eventClass != "dropbtn_month") {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


//// 상단 년/월 선택 selectBox 값 셋팅 @jys
// month = 1~12 (한자리 앞에 0 안붙여도 됨) 
function setSelectDate(year, month){
	// 현재시간 설정.
	var now = new Date();
	var inputDate = new Date();
	
	if(year != null && now.getFullYear() != year){
		inputDate =  new Date(year, 0);	
	}
	
	var yearVal = inputDate.getFullYear();
	var monthVal = (inputDate.getMonth() + 1) < 10 ? "0"+(inputDate.getMonth() + 1) : (inputDate.getMonth() + 1);
	var dateVal = inputDate.getDate() < 10 ? "0"+inputDate.getDate() : inputDate.getDate();
	var hourVal = inputDate.getHours() < 10 ? "0"+inputDate.getHours() : inputDate.getHours();
	var minVal = inputDate.getMinutes() < 10 ? "0"+inputDate.getMinutes() : inputDate.getMinutes();
	
	//연도 셋팅
	$(".dropbtn_year").text(inputDate.getFullYear() + "년");
	//월 셋팅
	var startMonth = 1;
	if(year != null && now.getFullYear() != year){
		$(".dropbtn_month").text(month + "월");
		startMonth = 1;
	}else{
		if(month == null || month < (inputDate.getMonth()+1)){
			$(".dropbtn_month").text((inputDate.getMonth() + 1) + "월");
			startMonth = (inputDate.getMonth() + 1);
			year = (inputDate.getFullYear());
			month = (inputDate.getMonth() + 1);
		}else{
			$(".dropbtn_month").text(month + "월");
			startMonth = (inputDate.getMonth() + 1);
		}
	}
	
	var html = "";
	//선택 연도 셋팅
	for(var i = 0; i < 5; i++){
		html += '<a href="javascript:;">' + (now.getFullYear() + i) +'년</a>';
	}
	$("#dropbtn_year").html(html);
	
	//연도 선택 시 이벤트 설정
	$("#dropbtn_year a").each(function(){
		$(this).on('click', function(){
			var year = $(this).text().replace("년","");
			var month = $(".dropbtn_month").text().replace("월","");
			
			if($(".dropbtn_year").text() != $(this).text()){
				setSelectDate(year, month);
			}
			document.getElementById("dropbtn_year").classList.toggle("show");
		})
	});
	
	html = "";
	//선택 월 셋팅
	for(var i = startMonth; i <= 12; i++){
		html += '<a href="javascript:;" style="width: 43px;">' + i + '월</a>';
	}
	$("#dropbtn_month").html(html);
	
	//월 선택 시 이벤트 설정
	$("#dropbtn_month a").each(function(){
		$(this).on('click', function(){
			var year = $(".dropbtn_year").text().replace("년","");
			var month = $(this).text().replace("월","");
			
			if($(".dropbtn_month").text() != $(this).text()){
				setSelectDate(year, month);
			}
			document.getElementById("dropbtn_month").classList.toggle("show");
		})
	});
	
	setDate_ScheduleTable(year, month);
}



//// 스케쥴표에 선택한 년/월의  날짜 셋팅  @jys
function setDate_ScheduleTable(year, month){
	// 현재시간 설정.
	var now = new Date();
	var inputDate = new Date();
	
	if(year != null && now.getFullYear() != year){
		inputDate =  new Date(year, 0);	
	}
	
	var startWeek = new Date(year, (month-1), 1).getDay() //0:일, 1:월, 2:화, 3:수, 4:목, 5:금, 6:토 
	var monthLastDay = new Date(year, (month), 0).getDate();	// 해당 월의 마지막 일
	
	var week = startWeek;	// 요일 (0:일, 1:월, 2:화, 3:수, 4:목, 5:금, 6:토)
	var orderWeek = 1;	// 주 (1주, 2주 ... n주)
	
	//일자 초기화
	$(".tbl_list tr td span").remove();
	$(".today").prop("class", "");
	
	var monthVal = month < 10 ? "0"+(month) : (month);
	for(var day=1; day <= monthLastDay; day++){
		var dateVal = day < 10 ? "0"+day : day;
// 		console.log(orderWeek + " / " + week + " / " + day);
		var html = '<span id="'+(year.toString()+monthVal.toString()+dateVal.toString())+'">' + day + '</span>';		// 날짜 셋팅 및 span id 값에 년월일 셋팅
		
		$("#W" + orderWeek + "-" + week).html(html);
		
		if(++week == 7){	// week 값이 7일 경우 다음 주로 변경
			week = 0;
			orderWeek += 1;
		}
	}
	
	// 오늘 Today 표시
	if(now.getFullYear() == year && (now.getMonth() + 1) == month){
		var dateVal = now.getDate() < 10 ? "0"+now.getDate() : now.getDate();
		var obj = $("#"+year.toString()+monthVal.toString()+dateVal.toString());
		obj.prop("class", "today_box");
		obj.text(obj.text() + " Today");
		obj.parent().prop("class", "today");
	}
	
	// 일시 별 예약 건수 셋팅
	setTotCnt_ScheduleTable(year, month);
}

////스케쥴표에 선택한 년/월의  일별 예약 건수 셋팅  @jys
function setTotCnt_ScheduleTable(year, month){
	month = month < 10 ? "0"+month : month;
	var pengagYms = year.toString() + month.toString();
    $.ajax({
        url: '${pageContext.request.contextPath}/reservationStatus/monthly',
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
        	pengagYms : pengagYms
        }),
      }).done(function(data) {
    	  console.log(data);
    	  
    	  var now = new Date();
    	  var today = now.getFullYear() + ((now.getMonth() + 1) < 10 ? "0"+(now.getMonth() + 1) : (now.getMonth() + 1)) + (now.getDate() < 10 ? "0"+now.getDate() : now.getDate());
    	  var dataSize = data.length;
    	  
    	  for(var i = 0; i < dataSize; i++){
    		  if(today <= data[i].pengagYms){	//today 이전 일자는 표시 X
	    		  // 일별 건수 셋팅
	    		  var html = '<span class="data"><a href="javascript:;">예약 ' + $.number(data[i].sectionNumber) + '건</a></span>';
	    		  $("#"+data[i].pengagYms).parent().append(html);
    		  }
    	  }
    	  
    	  //건수 클릭 이벤트 추가
    	  $(".tbl_list tr td .data").each(function(){
    		  $(this).off('click').on('click', function(){
    			  var pangagYms = $(this).siblings('span').prop('id');
    			  reservationSelectDayInit(pangagYms);
    		  })
    	  });
    	  
      }).fail(function(xhr) {
        showAlert("발송예약 현황보기 일별 총건수 조회 중 오류가 발생하였습니다.");
      });
}

//// 시간별 예약 내역 건수 셋팅 @jys
function setDateAndTotCnt_HourlyList(){
	//현재 시간
	var now = new Date();
	
	//조회 일자 셋팅 (1:오늘 / 2:오늘,내일 / 3:오늘,내일,모레 / n:오늘,내일,모레... )
	var viewDays = 3;
	var viewDaysTitle = ["오늘", "내일", "모레"];
	
	var pengagYms = "";
	for(var i = 0; i < viewDays; i++){
		var yearVal = now.getFullYear();
		var monthVal = (now.getMonth() + 1) < 10 ? "0"+(now.getMonth() + 1) : (now.getMonth() + 1);
		var dateVal = (now.getDate() + i) < 10 ? "0" + (now.getDate() + i) : (now.getDate() + i);
		
		//조회일자 셋팅 (년월일)
		pengagYms += "," + yearVal.toString() + monthVal.toString() + dateVal.toString();
	}
	pengagYms = pengagYms.substring(1, pengagYms.length);	// 맨앞 ',' 제거

	var splitPengagYms = pengagYms.split(','); // 조회된 데이터가 없을 경우 날짜 셋팅을 위한 값
	
    $.ajax({
        url: '${pageContext.request.contextPath}/reservationStatus/hourly',
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
        	pengagYms : pengagYms
        }),
      }).done(function(data) {
//     	  console.log(data);
    	  
    	  var dataLength = data.length;
		  var html = "";    	  
    	  for(var i=0; i < dataLength; i++){
			  if(i == 0){ // head
  			  	html += '<div class="lbox first mgt11">';
  			  }else{
  				html += '<div class="lbox mgt2">';
  			  }
    		  
			  var title = (i < viewDaysTitle.length ? viewDaysTitle[i] : (i) + "일 후");
			  var date = "(" + splitPengagYms[i].substring(4, 6) + "/" + splitPengagYms[i].substring(6, 8) + ")"; 
			
			  html += '<div class="lbox_title">' + title + '<span>' + date +'</span></div>';					
              html += '<div class="lbox_scoll">';
              html += '<ul>';
			  
    		  var dataDetailLength = data[i].length; 
    		  if(dataDetailLength == 0){	// 일시에 예약 건수가 없을 경우 
    			  html += '<li style="text-align: center;"><span>예약 내역 없음.<span></li>';
    		  }else{	// 일시에 예약 건수가 있을 경우 출력
        		  for(var d=0; d < dataDetailLength; d++){
          			var detail = data[i][d];  
      				// Detail Contents
      	        	var time = detail.pengagYms.substring( 8, 10 )	+ ":" + detail.pengagYms.substring( 10, 12 );
      	        	html += '<li><span class="clock">' + time + '</span><span class="data"><span>' + $.number(detail.sectionNumber) + '</span> 건</span></li>';
          		  }
    		  }
    		  
    		  // tail
   		  	  html += '</ul>';
			  html += '</div>';
    		  html += '</div>';
    	  }
    	  
    	  $("#hourly_reservation_list").append(html);
    	  
      }).fail(function(xhr) {
        showAlert("시간별 예약 내역 건수 조회 중 오류가 발생하였습니다.");
    });
}
</script>  
