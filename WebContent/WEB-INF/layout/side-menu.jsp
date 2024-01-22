<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    <!-- begin sidebar -->
    <div class="sidebar">
        <!-- begin sidebar scrollbar -->
        <div data-scrollbar="true" data-height="100%">
            <!-- begin sidebar nav -->
            <ul class="nav font-size-12 left-menu">
                <%-- 20221215 고도화될 메뉴들로 숨김
                <li class="has-sub">
                    <a href="javascript:;" class="icon-send">
                        <b class="caret pull-right"></b>
                        <span>문자보내기</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/message.ibk" id="message_link" data-menu-id="message_link">일반보내기</a>
                        </li>
                        <li>
                            <a href="/filesend.ibk" id="filesend_link" data-menu-id="filesend_link">파일대량보내기</a>
                        </li>
                        <li>
                            <a href="/eventsend.ibk" id="eventmessage_link" data-menu-id="eventmessage_link">경조사보내기</a>
                        </li>
                        <c:if test="${fn:contains(sessionScope.USER_CLASS,'A') && fn:contains(sessionScope.USER_CLASS,'S')}">
                        <li>
                            <a href="/emplsms/emplsend.ibk" id="emplsend_link" data-menu-id="emplsend_link">직원용 SMS 발송</a>
                        </li>
                        </c:if>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-messagebox">
                        <b class="caret pull-right"></b>
                        <span>메시지함</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/mymessage.ibk" id="mymessage_link" data-menu-id="mymessage_link">내가 보낸메시지</a>
                        </li>
                        <li>
                            <a href="/reservedmessage.ibk" id="reservedmessage_link" data-menu-id="reservedmessage_link">예약 메시지</a>
                        </li>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-form">
                        <b class="caret pull-right"></b>
                        <span>서식함</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/form/happy.ibk" id="happy_link" data-menu-id="happy_link">해피콜문자</a>
                        </li>
                        <li>
                            <a href="/form/head.ibk" id="head_link" data-menu-id="head_link">본부양식</a>
                        </li>
                        <li>
                            <a href="/form/personal.ibk" id="personal_link" data-menu-id="personal_link">개인서식함</a>
                        </li>
                        <li>
                            <a href="/form/dept.ibk" id="dept_link" data-menu-id="dept_link">부서서식함</a>
                        </li>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-address">
                        <b class="caret pull-right"></b>
                        <span>주소록</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/all-address.ibk" id="all_address_link" data-menu-id="all_address_link">전체주소록</a>
                        </li>
                        <li>
                            <a href="/personal-address.ibk" id="personal_address_link" data-menu-id="personal_address_link">개인주소록</a>
                        </li>
                        <li>
                            <a href="/share-address.ibk" id="share_address_link" data-menu-id="share_address_link">부서공유주소록</a>
                        </li>
                        <li>
                            <a href="/upload-address.ibk" id="fileupload_address_link" data-menu-id="fileupload_address_link">주소록파일등록</a>
                        </li>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-setting">
                        <b class="caret pull-right"></b>
                        <span>환경설정</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/envset.ibk" id="envset_link" data-menu-id="envset_link">경조사메시지 수신설정</a>
                        </li>
                        <li>
                            <a href="/smsUnsubscribe.ibk" id="smsUnsubscribe_link" data-menu-id="smsUnsubscribe_link">고객수신거부관리</a>
                        </li>
                        <c:if test="${fn:contains(sessionScope.LOGIN_METHOD,'idpw')}">
                        <li>
                            <a href="/changepassword.ibk" id="changePassword_link" data-menu-id="changePassword_link">비밀번호변경</a>
                        </li>
                        </c:if>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-request">
                        <b class="caret pull-right"></b>
                        <span>대량SMS 발송의뢰</span>
                    </a>
                    <ul class="sub-menu">
                        <!-- <li>
                            <a href="/reservationStatus.ibk" id="reservationStatus_link" data-menu-id="reservationStatus_link">발송예약 현황보기</a>
                        </li> -->
                        <li>
                            <a href="/smsreq2.ibk" id="smsreq_link" data-menu-id="smsreq_link">SMS발송 의뢰하기</a>
                        </li>
                        <li>
                            <a href="/smssendlist.ibk" id="smssendlist_link" data-menu-id="smssendlist_link">SMS발송 진행현황</a>
                        </li>
                    </ul>
                </li>
                &lt;%&ndash; 202205 v1
                <li class="has-sub">
                    <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        <span>결재함</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/confirmlist.ibk" id="confirmlist_link" data-menu-id="confirmlist_link">결재내역</a>
                        </li>
                    </ul>
                </li>
                &ndash;%&gt;
                <c:if test="${fn:contains(sessionScope.USER_CLASS,'A')}">
                <li class="has-sub">
                    <a href="javascript:;" class="icon-admin">
                        <b class="caret pull-right"></b>
                        <span>운영관리</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="/admin/user.ibk" id="user_link" data-menu-id="user_link">SSO 로그인 권한관리</a>
                        </li>
                        &lt;%&ndash; 202205 v1
                        <li>
                            <a href="/admin/employee.ibk" id="employee_link" data-menu-id="employee_link">직원용 SMS 발송 직원관리</a>
                        </li>
                        <li>
                            <a href="/admin/authorizer.ibk" id="authorizer_link" data-menu-id="authorizer_link">승인자(협의자) 관리</a>
                        </li>
                        <li>
                            <a href="/admin/admin.ibk" id="admin_link" data-menu-id="admin_link">관리자 관리</a>
                        </li>
                        &ndash;%&gt;
                        <li>
                            <a href="/admin/directlogin.ibk" id="directlogin_link" data-menu-id="directlogin_link">로그인사용자 관리</a>
                        </li>
                        <li>
                            <a href="/admin/motplogin.ibk" id="motplogin_link" data-menu-id="motplogin_link">MOTP사용자 관리</a>
                        </li>
                        <li>
                            <a href="/admin/notice.ibk" id="notice_link" data-menu-id="notice_link">공지사항</a>
                        </li>
                        <li>
                            <a href="/admin/login-history.ibk" id="login_history_link" data-menu-id="login_history_link">로그인이력 조회</a>
                        </li>
                        <li>
                            <a href="/template-list.ibk" id="template_link" data-menu-id="template_link">MMS 템플릿 관리</a>
                        </li>
                        &lt;%&ndash; 202205 v1
                        <li>
                            <a href="/admin/loglist.ibk" id="loglist_link" data-menu-id="loglist_link">이력 조회</a>
                        </li>
                        &ndash;%&gt;
                    </ul>
                </li>
                </c:if>
                <li class="has-sub">
                    <a href="${pageContext.request.contextPath}/address/download/sample/manual" class="icon-download-document">
                        <span>메뉴얼 다운로드</span>
                    </a>
                </li>
                --%>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-lms">
                        <b class="caret pull-right"></b>
                        <span>대량문자</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/campaign/reservationStatus.ibk" data-menu-id="21">예약 현황</a></li>
                        <li><a href="/campaign/smsreq.ibk" data-menu-id="22">등록하기</a></li>
                        <li><a href="/campaign/sendStatus.ibk" data-menu-id="23">발송 현황</a></li>
                        <li><a href="/campaign/sendStatistics.ibk" data-menu-id="24">발송 통계</a></li>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-center">
                        <b class="caret pull-right"></b>
                        <span>템플릿 관리</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/campaign/rcsTemplate.ibk" data-menu-id="45">RCS 템플릿</a></li>
                        <li><a href="/campaign/alimTalkTemplate.ibk" data-menu-id="46">알림톡 템플릿</a></li>
                        <li><a href="/campaign/rcsBrand.ibk" data-menu-id="47">RCS 브랜드/발신번호</a></li>
                    </ul>
                </li>
                <li class="has-sub">
                    <a href="javascript:;" class="icon-key">
                        <b class="caret pull-right"></b>
                        <span>권한 관리</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="/campaign/authUser.ibk" data-menu-id="50">권한 사용자 부여</a></li>
                    </ul>
                </li>
            </ul>
            <!-- end sidebar nav -->
        </div>
        <!-- end sidebar scrollbar -->
    </div>
    <!-- end sidebar -->

    <!--
    TODO : 메뉴 URL 정리, SSO 연계 후 사용자 권한 별 설정 필요
    -->
<%-- 202205 v1
    <div id="main01" style="display:none">
        <h2>일반</h2>
        <ul class="cd-accordion-menu animated">
            <li class="has-children">
                <input type="checkbox" name ="group-1" id="group-1" >
                <label for="group-1" class="sm02_01">문자보내기</label>
                <ul>
                    <li class="has-children">
                        <a href="/message.ibk" class="sublabel"  id="message_link">일반보내기</a>
                    </li>
                    <li class="has-children">
                        <a href="/filesend.ibk" class="sublabel" id="filesend_link">파일대량보내기</a>
                    </li>
                    <li class="has-children">
                        <a href="/eventsend.ibk" class="sublabel" id="eventmessage_link">경조사보내기</a>
                    </li>
                    <c:if test="${fn:contains(sessionScope.USER_CLASS,'A') && fn:contains(sessionScope.USER_CLASS,'S')}">
                    <li class="has-children">
                        <a href="/emplsms/emplsend.ibk" class="sublabel" id="emplsend_link">직원용 SMS 발송</a>
                    </li>
                    </c:if>
                </ul>
            </li>
            <li class="has-children">
                <input type="checkbox" name ="group-2" id="group-2" >
                <label for="group-2" class="sm02_02">메시지함</label>
                <ul>
                    <li class="has-children">
                        <a href="/mymessage.ibk" class="sublabel" id="mymessage_link">내가 보낸메시지</a>
                    </li>
                    <li class="has-children">
                        <a href="/reservedmessage.ibk" class="sublabel" id="reservedmessage_link">예약 메시지</a>
                    </li>
                </ul>
            </li>
            <li class="has-children">
                <input type="checkbox" name ="group-3" id="group-3" >
                <label for="group-3" class="sm02_02">서식함</label>
                <ul>
                    <li class="has-children">
                        <a href="/form/happy.ibk" class="sublabel"  id="happy_link">해피콜문자</a>
                    </li>
                    <li class="has-children">
                        <a href="/form/head.ibk" class="sublabel"  id="head_link">본부양식</a>
                    </li>
                    <li class="has-children">
                        <a href="/form/personal.ibk" class="sublabel" id="personal_link">개인서식함</a>
                    </li>
                    <li class="has-children">
                        <a href="/form/dept.ibk" class="sublabel"  id="dept_link">부서서식함</a>
                    </li>
                </ul>
            </li>
            <li class="has-children">
                <input type="checkbox" name ="group-4" id="group-4" >
                <label for="group-4" class="sm02_02">주소록</label>
                <ul>
                    <li class="has-children">
                        <a href="/all-address.ibk" class="sublabel" id="all_address_link">전체주소록</a>
                    </li>
                    <li class="has-children">
                        <a href="/personal-address.ibk" class="sublabel" id="personal_address_link">개인주소록</a>
                    </li>
                    <li class="has-children">
                        <a href="/share-address.ibk" class="sublabel" id="share_address_link">부서공유주소록</a>
                    </li>
                    <li class="has-children">
                        <a href="/upload-address.ibk" class="sublabel" id="fileupload_address_link">주소록파일등록</a>
                    </li>
                </ul>
            </li>
            <li class="has-children">
                <input type="checkbox" name ="group-5" id="group-5" >
                <label for="group-5" class="sm02_02">환경설정</label>
                <ul>
                    <li class="has-children">
                        <a href="/envset.ibk" class="sublabel" id="envset_link">경조사메시지 수신설정</a>
                    </li>
                    <li class="has-children">
                        <a href="/smsUnsubscribe.ibk" class="sublabel" id="smsUnsubscribe_link">고객수신거부관리</a>
                    </li>
                    <c:if test="${fn:contains(sessionScope.LOGIN_METHOD,'idpw')}">
                    <li class="has-children">
                        <a href="/changepassword.ibk" class="sublabel" id="changePassword_link">비밀번호변경</a>
                    </li>
				    </c:if>
                </ul>
            </li>
        </ul>
    </div>

    <div id="main02" style="display:none">
        <h2><a href="#" id='nevigation_link'>대량SMS 발송의뢰</a></h2>

        <ul class="cd-accordion-menu animated">
            <li class="has-children">
                <input type="checkbox" name ="group-6" id="group-6" >
                <label for="group-6" class="sm02_01">대량SMS 발송의뢰</label>
                <ul>
                    <li class="has-children">
                        <a href="/reservationStatus.ibk" class="sublabel" id="reservationStatus_link">발송예약 현황보기</a>
                    </li>
                    <li class="has-children">
                        <a href="/smsreq.ibk" class="sublabel" id="smsreq_link">SMS발송 의뢰하기</a>
                    </li>
                    <li class="has-children">
                        <a href="/smssendlist.ibk" class="sublabel" id="smssendlist_link">SMS발송 진행현황</a>
                    </li>
                </ul>
            </li>

<!--             <li class="has-children"> -->
<!--                 <input type="checkbox" name ="group-7" id="group-7" > -->
<!--                 <label for="group-7" class="sm02_02">결재함</label> -->
<!--                 <ul> -->
<!--                     <li class="has-children"> -->
<!--                         <a href="/confirmlist.ibk" class="sublabel" id="confirmlist_link">결재내역</a> -->
<!--                     </li> -->
<!--                 </ul> -->
<!--             </li> -->
        </ul>
    </div>
    <c:if test="${fn:contains(sessionScope.USER_CLASS,'A')}">
    <div id="main03" style="display:none">
        <h2>관리자</h2>

        <ul class="cd-accordion-menu animated">
            <li class="has-children">
                <input type="checkbox" name ="group-8" id="group-8">
                <label for="group-8" class="sm03_01">운영관리</label>
                <ul>
                	<li class="has-children">
                        <a href="/admin/user.ibk" class="sublabel" id="user_link">SSO 로그인 권한관리</a>
                    </li>
                    <!-- li class="has-children">
                        <a href="/admin/employee.ibk" class="sublabel" id="employee_link">직원용 SMS 발송 직원관리</a>
                    </li-->
<!--                     <li class="has-children"> -->
<!--                         <a href="/admin/authorizer.ibk" class="sublabel" id="authorizer_link">승인자(협의자) 관리</a> -->
<!--                     </li> -->
                    <!-- li class="has-children">
                        <a href="/admin/admin.ibk" class="sublabel" id="admin_link">관리자 관리</a>
                    </li>-->
                    <li class="has-children">
                        <a href="/admin/directlogin.ibk" class="sublabel" id="directlogin_link">로그인사용자 관리</a>
                    </li>
                    <li class="has-children">
                        <a href="/admin/motplogin.ibk" class="sublabel" id="motplogin_link">MOTP사용자 관리</a>
                    </li>
                    <li class="has-children">
                        <a href="/admin/notice.ibk" class="sublabel" id="notice_link">공지사항</a>
                    </li>
                    <li class="has-children">
                        <a href="/admin/login-history.ibk" class="sublabel" id="login_history_link">로그인이력 조회</a>
                    </li>
                    <li class="has-children">
                        <a href="/template-list.ibk" class="sublabel" id="template_link">MMS 템플릿 관리</a>
                    </li>
<!--                     <li class="has-children"> -->
<!--                         <a href="/admin/loglist.ibk" class="sublabel" id="loglist_link">이력 조회</a> -->
<!--                     </li> -->
                </ul>
            </li>
        </ul>
    </div>    
    </c:if>
    
	<div >
        <ul class="cd-accordion-menu">          
            <li class="download"><a href="${pageContext.request.contextPath}/address/download/sample/manual" style="background: url(${pageContext.request.contextPath}/static/images/icon_download_blue.png) 10px 50% no-repeat;">메뉴얼 다운로드</a></li>
        </ul>
	</div>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/menu.js">
    </script>
--%>