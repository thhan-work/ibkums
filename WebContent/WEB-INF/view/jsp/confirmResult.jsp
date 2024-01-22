<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>SMS발송 진행현황
</h3>
<!-- content -->
<div id="content">
    <div class="info">* 대량SMS 발송의뢰 내역만 조회 가능합니다.</div>
    <!-- Search -->
    <div class="box_search01">
        <ul>
            <li><span class="title01">등록일</span>
            	<span>
                    <select class="small searchDate" id="searchStartYear"></select>
                </span>
                <span class="text1">년</span>
                <span>
                    <select class="small searchDate" id="searchStartMonth"></select>
                </span>
                <span class="text1">월</span>
                <span>
                    <select class="small searchDate" id="searchStartDay"></select>
                </span>
                <span class="text1">일</span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchStartDatePicker">
                </span>
                <span class="mgl5 mgr5">~</span>
                <span>
                    <select class="small searchDate" id="searchEndYear">
                    </select>
                </span>
                <span class="text1">년</span>
                <span>
                    <select class="small searchDate" id="searchEndMonth">
                    </select>
                </span>
                <span class="text1">월</span>
                <span>
                    <select class="small searchDate" id="searchEndDay">
                    </select>
                </span>
                <span class="text1">일</span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchEndDatePicker">
                </span>
             </li>
             <li>
             	<span class="title01">기안상태</span>
                 <span><select id="draft-status" style="width:155px;">
                     <option value="all" selected>전체</option>
                     <option value="C">임시저장</option>
<!--                      <option value="A">결재진행중</option> -->
                     <option value="B">발송승인대기</option>
                     <option value="I">발송승인중</option>
<!--                      <option value="P">시간경과(관리자문의)</option> -->
<!--                      <option value="N">반려</option> -->
                     <option value="R">발송준비중</option>
                     <option value="Y">발송대기</option>
                     <option value="S">발송중</option>
                     <option value="T">발송중지</option>
                     <option value="D">발송완료</option>
                   </select>
                 </span>
                 <span class="mgl5"><a href="#" class="btn_help"></a></span>
                 <span class="title01 mgl123">메시지구분</span>
                 <span><select id="search-type" style="width:83px;">
                     <option value="all" selected>전체</option>
                     <option value="sms">SMS</option>
                     <option value="lms">LMS</option>
                     <option value="mms">MMS</option>
                   </select>
                 </span>
             </li>
             <li>
             	<span class="title01">기안명</span>
                <span>
                	<input type="text" name="search" value="" id="search-draft-name" style="width:465px">
                </span>
             </li>	
         </ul>
         <span class="btn">
         	<a href="javascript:;" class="btn_search" id="search-btn">조회</a></span>
   	</div>
   	<!-- //Search -->
     
     <div class="table_top"> 총 <span id="total_cnt">0</span>건
         <span class="num">
         	<select id="per-page">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="30">30</option>
            </select>
        </span>
     </div>

    <!-- table list -->
    <div class="tbl_wrap_list">
        <table class="tbl_list" id="smssendlist_table" summary="SMS발송 진행현황 테이블 입니다.">
            <colgroup>
                <col style="width:70px;" />
                <col style="width:" />
                <col style="width:" />
                <col style="width:350px" />
                <col style="width:" />
                <col style="width:" />
              </colgroup>
            <thead>
            <tr>
                  <th scope="col">번호</th>
                  <th scope="col">등록일</th>
                  <th scope="col">메시지구분</th>
                  <th scope="col">기안명</th>
                  <th scope="col">발송진행건수<br>
                  (발송건수/총건수)</th>
                  <th scope="col">기안상태</th>
                </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="6" style="height:375px">
                	<div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
                </td>
              </tr>
            </tbody>
        </table>
    </div>
    <!-- //table list -->
    <!-- 페이징 -->
    <div class="paging" id="pagination">
    </div>
    <!-- //페이징 -->
</div>
<!-- //content -->
