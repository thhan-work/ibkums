<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- begin page-header -->
<div class="page-header">
    예약 현황
    <ol class="breadcrumb pull-right"></ol>
</div>
<!-- end page-header -->

<!-- begin table -->
<div class="row mrg-top-20">
    <div class="width-70 pull-left">
        <div class="calendar-inner-table" id="monCalendar">
        </div>
    </div>
    <div class="width-28 pull-right" id="hourly_reservation_list">
        <h2 class="hour-reservation-title">시간대별 예약 내역</h2>
       	
    </div>
</div>
<!-- end table -->

<jsp:include page="./dialog/reservationSelectDay-list.jsp" flush="true"/>

<script type="text/javascript">
    $(document).ready(function() {
        monCalendar('monCalendar');
        generateSlimScroll('.hour-reservation-area .hour-reservation-box', { height: '82px', size: '3px'});

        // 일별, 시간별 예약 건수 조회
        getMonthlyList();
        getHourlyList();

        // 20221215 당월 이전 날짜는 조회 불가 처리
        $('#preMonth').hide();
    });

	// 예약상세 팝업 호출
    function callReservationPopup() {
        // 팝업호출
        $("[data-calendar-id]").off("click");
        $("[data-calendar-id]").click(function(){
            $('#popupReservationStatus').popup('show');

         	// 팝업초기화
            $("#dailyPageSize").val('5');
            
         	// 예약상세페이지 조회
			var calDataArr = $(this).data('calendar-id').split("/");
            getDailyList(calDataArr[0], calDataArr[1]);
        });
    }

	// 달력 변경
	function moveMonth(type) {
		var curDate = [$(".calYear").text(), $(".calMonth").text()];

        /* 20221215 이전버튼 클릭 연타시 dimmed 아래로 알럿 나오는 이슈 있으므로 주석처리
		if(type == "prev" && now.getFullYear() == curDate[0] && (now.getMonth() + 1) == curDate[1]){
			sweet.alert("이번달" + "(" + curDate[0] + "/" + curDate[1] + ") 이전 날짜는 \n조회가 불가능 합니다.");
			return false;
		}
        */

		// prev, next에 따른 년도, 월 값 셋팅	
		var addDate = type == 'prev' ? -1 : 1;
		var monthCondition = type == 'prev' ? '0' : '13';
		var initMonth = type == 'prev' ? '12' : '01';
		curDate[1] = str.pad((parseInt(curDate[1]) + addDate), 2);
		if(curDate[1] == monthCondition){
			curDate[0] = (parseInt(curDate[0]) + addDate).toString();
			curDate[1] = initMonth;
		}

		// 캘린더 셋팅
		monCalendar('monCalendar', curDate.join("-"));

		// 일별 예약 건수 셋팅
		getMonthlyList(curDate.join(""));

        // 20221215 당월 이전 날짜는 조회 불가 처리
        var now = new Date();
        var nowMonth = (""+(now.getMonth() + 1)).length < 2 ? "0"+(now.getMonth() + 1) : (now.getMonth() + 1);
        var compareYear = curDate[1] == '00' ? curDate[0]-1 : curDate[0];
        var compareMonth = curDate[1] == '00' ? '12' : curDate[1];
        if((now.getFullYear() == compareYear) && (compareMonth == nowMonth)) {
            $('#preMonth').hide();
        } else {
            $('#preMonth').show();
        }
	}

	// 선택한 년/월의  일별 예약 건수 셋팅
	function getMonthlyList(pengagYms){
		pengagYms = pengagYms || $(".calYear").text() + $(".calMonth").text();
		
	    $.ajax({
	        url: '${pageContext.request.contextPath}/campaign/reservationStatus/monthly',
	        type: "POST",
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify({
	        	pengagYms : pengagYms
	        }),
	      }).done(function(data) {
	    	  var now = new Date();
	    	  var today = dateFunc.getToday('');

	    	  if(data.length) {
		    	  data.forEach(function(item) {
		    		  if(today <= item.pengagYms){
		    			  $('#calendar_' + item.pengagYms).after('<div class="calendar_cnt" data-calendar-id="'+ item.pengagYms +'/' + Number(item.sectionNumber) + '">예약 '+ Number(item.sectionNumber) +'건</div>');
		    		  }
		    	  })
	    	  }
	    	  
	    	  //건수 클릭 이벤트 추가
	    	  callReservationPopup();
	          
	      }).fail(function(xhr) {
	    	  sweet.alert("발송예약 현황보기 일별 총건수 조회 중 오류가 발생하였습니다.");
	      });
	}

	// 시간별 예약 건수 조회
	function getHourlyList(){
		
		//조회 일자 셋팅 (1:오늘 / 2:오늘,내일 / 3:오늘,내일,모레 / n:오늘,내일,모레... )
		var viewDays = 3;
		var viewDaysTitle = ["오늘", "내일", "모레"];
		
		var pengagYmsArr = [];
		var now = new Date();

		var addVal = 0;
		for(var i = 0; i < viewDays; i++){
			addVal = i > 1 ? 1 : i;
			pengagYmsArr.push(dateFunc.addDate(now, addVal, ''));
		}

		var html = "";
	    $.ajax({
	        url: '${pageContext.request.contextPath}/campaign/reservationStatus/hourly',
	        type: "POST",
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify({
	        	pengagYms : pengagYmsArr.join(',')
	        }),
	      }).done(function(data) {
		      console.log("data", data);
	    	  if(data.length) {
		    	  data.forEach(function(item, index) {
			    	  
		    		  html += '<div class="hour-reservation-area">';
		    		  html += '<h3>' + viewDaysTitle[index] + '(' + str.getYyyymmddFmt(pengagYmsArr[index], '.') + ')</h3>';
					  html += '<div class="hour-reservation-box">';
					  
			    	  if(item.length) {
				    	  item.forEach(function(child) {
				    		  html += '<div>';
				    		  html += '<p>' + str.getHhssFmt(child.pengagYms, ":") + '</p>';
				    		  html += '<p>' + str.comma(child.sectionNumber) + '건</p>';
				    		  html += '</div>';
					      })
				      } else {
				    	  html += '<div>예약 내역 없음</div>';
				      }
				      
			    	  html += '</div>';
			    	  html += '</div>';
		    	  })

		    	  $("#hourly_reservation_list").append(html);
		    	  generateSlimScroll('.hour-reservation-area .hour-reservation-box', { height: '90px', size: '3px'});
	    	  }
	      }).fail(function(xhr) {
	        //sweet.alert("시간별 예약 내역 건수 조회 중 오류가 발생하였습니다.");
	    });
	}
</script>