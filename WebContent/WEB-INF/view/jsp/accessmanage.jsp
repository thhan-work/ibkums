<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="wrapper">
    <h3>직원용 SMS발송 접근 관리
    </h3>
    <div class="box_search01">
        <ul>
            <li>
                <span class="title01">등록일</span>
                <span>
            <select class="small">
                    <option>2018</option>
                    <option>2019</option>
                  </select>
          </span>
                <span class="text1">년</span>
                <span>
            <select class="small">
                    <option>08</option>
                    <option>09</option>
                  </select>
          </span>
                <span class="text1">월</span>
                <span>
            <select class="small">
                    <option>02</option>
                    <option>03</option>
            </select>
          </span>
                <span class="text1">일</span>
                <span class="mgl2">
            <a href="#">
              <img src="${pageContext.request.contextPath}/static/images/btn_calendar.png" alt="날짜선택">
            </a>
          </span>
                <span class="mgl5 mgr5">~</span>
                <span>
            <select class="small">
              <option>2018</option>
              <option>2019</option>
            </select>
          </span>
                <span class="text1">년</span>
                <span>
            <select class="small">
              <option>08</option>
              <option>09</option>
            </select>
          </span>
                <span class="text1">월</span>
                <span>
            <select class="small">
              <option>02</option>
              <option>03</option>
            </select>
          </span><span class="text1">일</span>
                <span class="mgl2">
            <a href="#"><img src="${pageContext.request.contextPath}/static/images/btn_calendar.png" alt="날짜선택"></a>
          </span>
            </li>
            <li>
          <span>
            <select name="searchWordType" v-model="searchWordType" style="width:100px;">
              <option value="empNm" selected>직원명</option>
              <option value="empNo">직원번호</option>
              <option value="empIp">직원IP</option>
              <option value="empDepNm">부서명</option>
            </select>
          </span>
                <span><input type="text" name="search" value="" style="width:300px" v-model="searchWord"></span>
                <span class="title01" style="margin-left: 20px  ">사용여부</span>
                <span>
            <select name="searchWordType" v-model="useYn" style="width:60px;">
              <option selected value="">전체</option>
              <option value="Y">사용</option>
              <option value="N">미사용</option>
            </select>
          </span>
            </li>
        </ul>
        <span class="btn" @click="findUsers"><a href="#"><img src="${pageContext.request.contextPath}/static/images/btn_search01.png"
                                                              alt="조회"/></a></span>
    </div>

    <div style="margin-top: 10px">
        <button class="b-btn b-btn-add" @click="addUser">등록</button>
        <button class="b-btn b-btn-del" @click="deleteUser">삭제</button>
    </div>
    <div class="tbl_wrap_list">
        <%--<my-vuetable ref="vuetable"--%>
                     <%--api-url="http://localhost:9080/api/access/users"--%>
                     <%--:fields="fields"--%>
                     <%--:append-params="moreParams"--%>
                     <%--track-by="empNo"--%>
                     <%--pagination-path=""--%>
                     <%--@vuetable:pagination-data="onPaginationData">--%>
        <%--</my-vuetable>--%>
    </div>

    <%--<modals-container/>--%>
</div>

