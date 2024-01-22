<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatablesInSearch.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/reservationSelectDay-column.js"></script>
<!--popup-->
<div class="popup_wrap" id="search_popup_wrap" style="display:none; width: 800px">
  <!-- top -->
  <div class="top">
    <div class="title" id="popTitle">예약 상세</div>
    <div class="btn_close"><a href="javascript:" onclick="popClose('#search_popup_wrap')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
  </div>
  <!-- //top -->
  <!-- content -->
  <div class="content_pop">
    <div class="table_top_pop"> 총 <span id="total_cnt_insearch">0</span>건</div>
    <!-- table list -->
    <div class="tbl_wrap_list_pop">
      <table class="tbl_list"  id="search_data_table" style="width:100%">
        <caption>
        테이블
        </caption>
        <colgroup>
        <col style="width:50px" />
        <col style="width:" />
        <col style="width:" />
        <col style="width:" />
        <col style="width:" />
        <col style="width:" />
        <col style="width:" />
        </colgroup>
        <thead>
          <tr>
            <th scope="col">번호</th>
            <th scope="col">기안명</th>
            <th scope="col">요청 건수</th>
            <th scope="col">구분</th>
            <th scope="col">시간</th>
            <th scope="col">기안자</th>
            <th scope="col">기안부서</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>
    <!-- //table list -->
    <input type="hidden" id="selectDate">
    <!-- 페이징 -->
    <div class="paging" id="searchpagination" style="display:none">
    </div>
  </div>
  <!-- //content -->

  <!-- footer -->
  <div class="footer_pop">
    <!-- button --><a href="javascript:" onclick="popClose('#search_popup_wrap')" id="confirm_in_search-btn"  class="btn_big blue">확인</a><!-- //button -->
  </div>
  <!-- //footer -->
</div>
<!--//popup-->
<script>
    var firsttime = true;
    function reservationSelectDayInit(pengagYms, isScrollPopup){
    	$("#selectDate").val(pengagYms);
        if (isScrollPopup) {
          popOpenScroll("#search_popup_wrap");
        }else{
          popOpen("#search_popup_wrap");
        }
        $("#popTitle").text("예약 상세 (" + (pengagYms.substring(0, 4) + "-" + pengagYms.substring(4, 6) + "-" + pengagYms.substring(6, 8)) +")");
        
        if(firsttime){
            // datatables ajax 에서 사용 할 parameter 세팅
            // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
            var requestParamInSearch = function (data) {
                // 필수 변경 불가
                data.perPage = IbkDataTableInSearch.perPage;
                // 필수 변경 불가
                data.currentPage = IbkDataTableInSearch.currentPage;
                // 여기서 부터는 Custom 하게
                data.pengagYms = $("#selectDate").val();
            };
            // datatables 세팅 모든 파라미터는 필수값
            IbkDataTableInSearch.initDataTable("search_data_table", "${pageContext.request.contextPath}/reservationStatus/daily", requestParamInSearch,IbkContentsColumnInSearch.columns, IbkContentsColumnInSearch.columnDefs);
            datagridTrColorChanger("#search_data_table");

            $("#blank_view").hide();
            $("#table_view").show();
            $("#searchpagination").show();


//             var table = $('#search_data_table').DataTable();
//             $('#search_data_table tbody').on( 'click', 'tr', function () {
//                 $('.search-dt-check-box').prop("checked", false);
//                 var $_checkbox = $(this).children().find( "input" );
//                if ($_checkbox.prop('checked')) {
//                     $_checkbox.prop("checked",false);
//                }else{
//                     $_checkbox.prop("checked",true);
//                }
//             } );

        }else{
            search_reservationStatus();
        }
        firsttime = false;
    }

    function search_reservationStatus(){
        IbkDataTableInSearch.currentPage = 1;
        IbkDataTableInSearch.reload();
    }


</script>