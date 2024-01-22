<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div id="popupReservationStatus" class="modalPopup hide" style="width: 900px">
  <div class="modal-header"><h1>예약 현황 상세</h1></div>
  <div class="modal-body">
    <div class="popup-title-info">
      <span class="split" id="pengagYmsTxt"></span>
      <span class="font-size-12 mrg-left-10">총 <span id="sectionNumber">0</span>건 예약</span>
    </div>
    <!-- begin table -->
    <div class="row">
      <div class="table-result">
        총 <strong class="split" id="dailyTotCnt">0</strong>
        <select class="search-limit" onchange="changeDailyPageSize(this)" id="dailyPageSize">
          <option value="5">5개씩 보기</option>
          <option value="10">10개씩 보기</option>
          <option value="20">20개씩 보기</option>
          <option value="30">30개씩 보기</option>
        </select>
      </div>
      <div class="table-responsive" style="height:231px;">
        <table class="table table-hover">
          <colgroup>
            <col width="60" />
            <col width="*" />
            <col width="100" />
            <col width="100" />
            <col width="100" />
            <col width="100" />
            <col width="80" />
          </colgroup>
          <thead>
	          <tr>
	            <th>No.</th>
	            <th>발송명</th>
	            <th>메시지 유형</th>
	            <th>부서</th>
	            <th>등록자</th>
	            <th>건수</th>
	            <th>시간</th>
	          </tr>
          </thead>
          <tbody id="dailyGrid">
	          
          </tbody>
        </table>
      </div>
      <div class="text-center">
        <ul class="twbsPagination"></ul>
      </div>
    </div>
    <!-- end Table -->
  </div>
  <div class="modal-footer">
    <a href="javascript:;" class="btn btn-border-sub1 popupReservationStatus_close" >닫기</a>
  </div>
  <input type="hidden" value="" id="pengagYms"/>
</div>
<!--//popup-->

<script>
	var errMsg = {
		searchErr: "예약 상세 조회 중 오류가 발생하였습니다."
	};

	// 페이지 변경 시
	function changeDailyPage(page) {
		getDataGrid({
			pengagYms : $("#pengagYms").val(),
			currentPage : page,
			perPage : $("#dailyPageSize").val(),
		});
	}

	// 페이지사이즈 변경 시
	function changeDailyPageSize(evnt) {

		// 조회
		getDataGrid({
			pengagYms : $("#pengagYms").val(),
			currentPage : 1,
			perPage : evnt.value,
		});
	}

	// 예역현황상세 조회
	function getDailyList(pengagYms, sectionNumber) {
		$("#pengagYms").val(pengagYms);
		$("#pengagYmsTxt").text(str.getYyyymmddFmt(pengagYms, "-"));
        $("#sectionNumber").text(sectionNumber);

     	// 조회
		getDataGrid({
			pengagYms : pengagYms,
			currentPage : 1,
			perPage : 5,
		});
	}

	// 조회
    function getDataGrid(params){
    	$("#dailyGrid").empty();
    	
        pagingFunc.postData("${pageContext.request.contextPath}/campaign/reservationStatus/daily", params, errMsg.searchErr, function(data) {
            console.log("result", data);
            
			// 총카운트 셋팅
			$("#dailyTotCnt").text(str.comma(data.totalRecords));
			
            // 그리드 테이블 페이징 재셋팅
            setPagingDom(data.lastPage, data.currentPage);

            if(data.data.length) {
                var html = "";
                data.data.forEach(function(item) {
                	html += "<tr>";
                	html += "<td>" + item.rnum + "</td>";
                	html += "<td>" + item.groupNm + "</td>";
                	html += "<td>" + item.msgDstic + "</td>";
                	html += "<td>" + item.partName + "</td>";
                	html += "<td>" + item.emplName + "</td>";
                	html += "<td>" + str.comma(item.sectionNumber) + "</td>";
                	html += "<td>" + str.getHhssFmt(item.pengagYms.substring(0,12), ":") + "</td>";
                	html += "</tr>";
                })
                
                $("#dailyGrid").append(html);
            }
        });
    }

 	// 페이징 dom 셋팅
	function setPagingDom(totalPage, startPage) {
		$('.twbsPagination').twbsPagination('destroy');
		$('.twbsPagination').twbsPagination({
            totalPages: totalPage,
            startPage: startPage,
            initiateStartPageClick: false,
            first: '<i class="fa fa-angle-double-left"></i>',
            prev: '<i class="fa fa-angle-left"></i>',
            next: '<i class="fa fa-angle-right"></i>',
            last: '<i class="fa fa-angle-double-right"></i>',
            onPageClick: function (event, page) {
                changeDailyPage(page);
            }
        });
	}

</script>