<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div class="popup_wrap_help"  style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">도움말</div>
        <div class="btn_close">
            <a href="javascript:;" ><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a>
        </div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
        <div class="wrap_lmenu">
            <ul>
                <li class="depth1">일반</li>
                <li class="on"><a id="file" href="javascript:;">파일대량보내기</a></li>
                <li class=""><a id="all" href="./fileSend-dialog.jsp">전체 주소록</a></li>
                <li class=""><a id="personal" href="javascript:;">개인 주소록</a></li>
                <li class=""><a id="addressFile" href="javascript:;">주소록 파일 등록</a></li>
            </ul>
        </div>
        <div class="content_help">
            <div class="wrap_help">
                <p>Step <span>01</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_01.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>파일 대량 보내기 화면 선택</li>
                            <li class="text"><span>SMS > 문자보내기 > 파일 대량 보내기 선택</span> 하시면 <span>파일 대량 보내기 화면</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>02</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>샘플다운로드</li>
                            <li class="text"><span>샘플다운로드</span> 버튼을 클릭하면 하단에 <span>샘플파일</span>저장 유무에 관한 물음이 뜹니다.</li>
                        </ul>
                        <ul>
                        	<li class="title"><span class="num">2</span>샘플다운로드</li>
                            <li class="text"><span>저장버튼</span>을 클릭하면 <span>샘플파일이</span>다운되는 것을 확인할 수 있습니다.</li>
                        </ul>
                        <ul>
                        	<li class="title"><span class="num">3</span>샘플다운로드</li>
                            <li class="text"><span>폴더열기</span>를 클릭하면 <span>다운로드 된 파일</span>이 열립니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>03</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_03.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>파일불러오기</li>
                            <li class="text"><span>파일불러오기</span> 버튼을 클릭합니다.</li>
                            
                        </ul>
                        <ul>
                            <li class="title"><span class="num">2</span>파일불러오기</li>
                            <li class="text">화면중앙에 <span>파일선택 팝업</span>이 나타납니다.</li>
                        </ul>
                        <ul>
                            <li class="title"><span class="num">3</span>파일불러오기</li>
                            <li class="text"><span>파일찾기 버튼</span>을 클릭하면 파일을 선택할 창이 뜹니다.</li>
                        </ul>
                    </div>
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_04.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">4</span>파일불러오기</li>
                            <li class="text"><span>업로드할 파일선택 창</span>이 뜹니다.</li>
                            
                        </ul>
                        <ul>
                            <li class="title"><span class="num">5</span>파일불러오기</li>
                            <li class="text"><span>업로드할 파일</span>을 선택한 후 <span>열기 버튼</span>을 클릭합니다.</li>
                        </ul>
                        <ul>
                            <li class="title"><span class="num">6</span>파일불러오기</li>
                            <li class="text"><span>선택한 파일명</span>이 인풋창에 뜹니다.</li>
                        </ul>
                        <ul>
                            <li class="title"><span class="num">7</span>파일불러오기</li>
                            <li class="text"><span>파일명</span> 확인 후 <span>등록 버튼</span>을 클릭합니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>04</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_05.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>업로드 파일 확인</li>
                            <li class="text"><span>업로드 파일</span> 이 정상적으로 등록되었는지 <span>확인</span>합니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>05</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_06.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>발송 정보 입력 및 보내기</li>
                            <li class="text"><span>발신인 전화번호, 예약발송 설정</span>을 입력하고 <span>보내기</span>버튼을 클릭합니다.</li>
                            <li class="text"><br></li>
                            <li class="text"><br></li>
                            <li class="text"><br></li>
                            <li class="text"><br></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //content -->
</div>
<!--//popup-->

<script>
  function showHelpAlert() {
    $(".btn_close").on('click', function () {
      $(".popup_wrap_help").dialog("close");
    });

    $(".popup_wrap_help").dialog({
      modal: true,
      width: "1000px",
      open: function() {
    	  $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
  
  

</script>