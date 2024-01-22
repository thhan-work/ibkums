<%@ page contentType="text/html;charset=UTF-8" language="java" %>

      <h3>대량 SMS 발송의뢰 발송 절차
      </h3>
      <!-- content -->
      <div id="content">
        <!-- navigator -->
        <div class="navigator">
        	<!-- 1단계 -->
            <div class="col1">
            	<div class="title">발송 7일 전 ~ 3영업일 전</div>
                <div class="icon"><img src="${pageContext.request.contextPath}/static/images/icon_navigator01.png"></div>
                <dl>
                	<dt><span class="dot mgr5">1</span>발송 일정 협의(IBK고객센터)</dt>
                    <dd>대량 SMS 발송의뢰 > 발송예약 현황보기</dd>
                </dl>
            </div>
            <!-- //1단계 -->
            <!-- 2단계 -->
            <div class="col1">
            	<div class="title">발송 3영업일~1영업일 전</div>
                <div class="icon"><img src="${pageContext.request.contextPath}/static/images/icon_navigator02.png"></div>
                <dl>
                	<dt><span class="dot mgr5">1</span>대상자 파일 요청</dt>
                    <dd>업무 관련 부서에 대상자 파일 요청</dd>
                    <dt class="mgt20"><span class="dot mgr5">2</span>대량 SMS 발송의뢰 하기</dt>
                    <dd>대량 SMS발송의뢰 > SMS발송 의뢰하기</dd>
                </dl>
            </div>
            <!-- //2단계 -->
            <!-- 3단계 -->
            <div class="col2">
            	<div class="title">발송일</div>
                <div class="icon"><img src="${pageContext.request.contextPath}/static/images/icon_navigator03.png"></div>
                <dl>
<!--                 	<dt><span class="dot mgr5">1</span>승인절차 진행(개인디지털채널부/IBK고객센터)</dt> -->
<!--                     <dd>승인 절차 진행 전 필수 확인 사항</dd> -->
<!--                     <dd>(1) 발송구분이 마케팅일 경우<br><span class="mgl20">: 심의필 번호 확인</span></dd> -->
<!--                     <dd>(2) 발송 비용이 200만원 이상일 경우<br><span class="mgl20">: 예산 합의서명 확인</span></dd> -->
                    <dt class="mgt20"><span class="dot mgr5">1</span>발송 승인 진행(테스트 문자 발송)</dt>
                    <dd>승인이 완료된 후 테스트 승인 진행<br>(최대 5명까지 가능)</dd>
                    <dd class="color_orange">*발송 테스트 승인까지 완료되어야 정상<br>발송됩니다.</dd>
                    <dt class="mgt20"><span class="dot mgr5">2</span>발송 상태 확인</dt>
                    <dd>대량 SMS발송의뢰 > SMS발송 진행현황</dd>
                    <dd class="color_orange">*발송 대기 상태가 정상 입니다.</dd>
                </dl>
            </div>
        	<!-- //3단계 -->
        </div>
<!--         //navigator -->
<!--         <div class="tac"><img src="./images/icon_navigator01.png" /><img src="./images/icon_navigator02.png" /><img src="./images/icon_navigator03.png" /><img src="./images/icon_navigator04.png" /><img src="./images/icon_navigator05.png" /><img src="./images/icon_navigator06.png" /><img src="./images/icon_navigator07.png" /><img src="./images/icon_navigator08.png" /></div> -->
        
      </div>

      <!-- //content -->
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>

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
<!-- common event handler on list pages  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/smssendlist-column.js"></script>
      