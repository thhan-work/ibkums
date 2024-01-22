<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--popup-->
<div class="popup_wrap_help" id="alert-file-send-help" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">도움말</div>
        <div class="btn_close">
            <a href="javascript:;" id="alert-file-send-dialog-close"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a>
        </div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
        <div class="wrap_lmenu">
            <ul>
                <li class="depth1">일반</li>
                <li class="on"><a href="javascript:;" onclick="showHelpAlert_file_send()">파일대량보내기</a></li>
                <li class=""><a href="javascript:;"  onclick="showHelpAlert_all()">전체 주소록</a></li>
                <li class=""><a href="javascript:;"  onclick="showHelpAlert_person()">개인 주소록</a></li>
                <li class=""><a href="javascript:;" onclick="showHelpAlert_file()">주소록 파일 등록</a></li>
            </ul>
        </div>
        <div class="content_help">
            <div class="wrap_help">
                <p>Step <span>01</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_01_01.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>파일 대량 보내기 화면 선택</li>
                            <li class="text"><span>일반 > 문자보내기 > 파일 대량 보내기 선택</span> 하시면 <span>파일 대량 보내기 화면</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>02</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_01_02.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">2</span>파일선택</li>
                            <li class="text">파일대량보내기 화면에서 <span>파일불러오기</span> 버튼을 클릭하면  <span>파일 선택 창</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>03</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_01_03.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">3</span>파일불러오기 확인</li>
                            <li class="text"><span>파일 첨부 후 "확인"버튼을 클릭</span> 하시면 <span>발송 목록 정보 화면</span>이 나타납니다.</li>
                            
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>04</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_01_04.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">4</span>메시지 발송 확인창</li>
                            <li class="text">파일 대량 보내기 화면에서 <span>"보내기"버튼을 클릭</span>하시면 <span>"보내기 팝업"</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>05</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_01_05.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">5</span>메시지 전송 완료</li>
                            <li class="text">메시지 발송 확인 창에서 <span>"확인"버튼을 클릭</span>하시면 <span>메시지 전송 완료창 화면</span>이 나타납니다.</li>
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

<!--popup-->
<div class="popup_wrap_help" id="alert-help" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">도움말</div>
        <div class="btn_close">
            <a href="javascript:;" id="alert-dialog-close"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a>
        </div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
        <div class="wrap_lmenu">
            <ul>
                <li class="depth1">일반</li>
                <li class=""><a href="javascript:;" onclick="showHelpAlert_file_send()">파일대량보내기</a></li>
                <li class="on"><a href="javascript:;"  onclick="showHelpAlert_all()">전체 주소록</a></li>
                <li class=""><a href="javascript:;"  onclick="showHelpAlert_person()">개인 주소록</a></li>
                <li class=""><a href="javascript:;" onclick="showHelpAlert_file()">주소록 파일 등록</a></li>
            </ul>
        </div>
        <div class="content_help">
            <div class="wrap_help">
                <p>Step <span>01</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02_01.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>전체 주소록</li>
                            <li class="text"><span>일반 > 주소록 > 전체 주소록  선택</span> 하시면 <span>전체 주소록 화면</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>02</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02_02.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">2</span>그룹 추가</li>
                            <li class="text">전체 주소록 화면에서 <span>"그룹추가" 버튼을  클릭</span> 하시면 <span>"그룹 추가 팝업 창"</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>03</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02_03.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">3</span>그룹 추가 완료</li>
                            <li class="text">"그룹추가 팝업"에서 <span>그룹명과 그룹설명 입력 후 "등록"버튼을 클릭</span>하시면 전체 주소록 화면에서 <span>입력한 그룹이 추가되어 </span>나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>04</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02_04.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">4</span>그룹선택</li>
                            <li class="text">전체 주소록 목록 화면에서 그룹을 선택하시면<span>선택 그룹에 포함된 사람 목록 화면</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>05</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02_05.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">5</span>그룹선택 사람 추가</li>
                            <li class="text">선택 그룹 화면에서<span> "사람추가"버튼을 클릭 </span>하시면 사람 추가 화면이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>06</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_02_06.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">6</span>사람 추가 완료</li>
                            <li class="text">사람 추가 화면에서<span> 추가할 사람의 정보를 입력 한 후 "확인"버튼을 클릭 </span>하시면 선택 그룹에 사람이 추가되고 그룹선택 화면이 나타납니다.</li>
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

<!--popup-->
<div class="popup_wrap_help" id="alert-person-help" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">도움말</div>
        <div class="btn_close">
            <a href="javascript:;" id="alert-person-dialog-close"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a>
        </div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
        <div class="wrap_lmenu">
            <ul>
                <li class="depth1">일반</li>
                <li class=""><a href="javascript:;" onclick="showHelpAlert_file_send()">파일대량보내기</a></li>
                <li class=""><a href="javascript:;"  onclick="showHelpAlert_all()">전체 주소록</a></li>
                <li class="on"><a href="javascript:;"  onclick="showHelpAlert_person()">개인 주소록</a></li>
                <li class=""><a href="javascript:;" onclick="showHelpAlert_file()">주소록 파일 등록</a></li>
            </ul>
        </div>
        <div class="content_help">
            <div class="wrap_help">
                <p>Step <span>01</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_03_01.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>그룹추가, 수정, 삭제</li>
                            <li class="text"><span><b>그룹추가</b></span>: 개인주소록 화면에서 "그룹추가"버튼을 클릭하시면 "그룹추가창"이 나타나고 그룹명, 그룹설명 입력한 후 그룹 추가를 하실 수 있습니다.</li>
                            <li class="text"><br></li>
                            <li class="text"><span><b>수정</b></span>: 선택한 그룹의 그룹명, 그룹설명을 수정 하실 수 있습니다.</li>
                            <li class="text"><br></li>
                            <li class="text"><span><b>삭제</b></span>: 선택한 그룹을 삭제 하실 수 있습니다.</li>
                        </ul>
                        <ul>
                            <li class="title"><span class="num">2</span>그룹 선택</li>
                            <li class="text">개인 주소록  목록 화면에서 그룹을 선택하시면 <span>선택 그룹에 포함된 사람 목록 화면</span>이 나타납니다. </li>
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

<!--popup-->
<div class="popup_wrap_help" id="alert-file-help" style="display: none">
    <!-- top -->
    <div class="top">
        <div class="title">도움말</div>
        <div class="btn_close">
            <a href="javascript:;" id="alert-file-dialog-close"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a>
        </div>
    </div>
    <!-- //top -->
    <!-- content -->
    <div class="content_pop">
        <div class="wrap_lmenu">
            <ul>
                <li class="depth1">일반</li>
                <li class=""><a href="javascript:;" onclick="showHelpAlert_file_send()">파일대량보내기</a></li>
                <li class=""><a href="javascript:;"  onclick="showHelpAlert_all()">전체 주소록</a></li>
                <li class=""><a href="javascript:;"  onclick="showHelpAlert_person()">개인 주소록</a></li>
                <li class="on"><a href="javascript:;" onclick="showHelpAlert_file()">주소록 파일 등록</a></li>
            </ul>
        </div>
        <div class="content_help">
            <div class="wrap_help">
                <p>Step <span>01</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_04_01.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">1</span>주소록 파일 등록</li>
                            <li class="text"><span>일반 > 주소록 > 주소록 파일 등록을 클릭 </span> 하시면 <span> 주소록 파일 등록 화면</span>이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>02</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_04_02.png" alt="" style="width:500px;" /></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">2</span>파일 불러오기</li>
                            <li class="text">주소록 파일 등록 화면에서 <span>"등록하기" 버튼을  클릭</span> 하시면 <span>"추가 팝업 창"</span>이 나오며 등록할 파일을 선택하실 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>03</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_04_03.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">3</span>파일 불러오기 추가 완료</li>
                            <li class="text"><span>파일 선택 후 "등록"버튼을 클릭</span>하시면 목록에서 <span>불러온 주소록이 추가되어 </span>나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>04</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_04_04.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">4</span>주소록 등록하기</li>
                            <li class="text"><span>"등록하기"버튼을 클릭</span>하시면 "주소록 등록하기 팝업"이 나타납니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap_help">
                <p>Step <span>05</span>.</p>
                <div class="row1">
                    <div class="col1"><img src="${pageContext.request.contextPath}/static/images/help_img_04_05.png" alt="" style="width:500px;"/></div>
                    <div class="col2">
                        <ul>
                            <li class="title"><span class="num">5</span>주소록 등록 완료</li>
                            <li class="text">"주소록 등록하기 팝업"에서<span> 그룹명, 그룹설명을 입력 한 후 "등록하기"버튼을 클릭 </span>하시면 주소록 등록 완료창이 나타납니다.</li>
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

  function showHelpAlert_file_send(callback) {
	closeAlert();
    $(".btn_close").off('click').on('click', function () {
      $("#alert-file-send-help").dialog("close");
    });

    $("#alert-file-send-help").dialog({
      modal: true,
      width: "1000px",
      open: function() {
    	  $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
  
  function showHelpAlert_all(callback) {
	closeAlert();
	$(".popup_wrap_help").each(function(i) {
	  if($(this).is(":visible")){
		  $("#"+$(this).prop("id")).dialog("close");
	  }
	});
	  
    $(".btn_close").off('click').on('click', function () {
      $("#alert-help").dialog("close");
    });

    $("#alert-help").dialog({
      modal: true,
      width: "1000px",
      open: function() {
    	  $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
  
  
  function showHelpAlert_person(callback) {
	closeAlert();
    $(".btn_close").off('click').on('click', function () {
      $("#alert-person-help").dialog("close");
    });

    $("#alert-person-help").dialog({
      modal: true,
      width: "1000px",
      open: function() {
    	  $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
  
  
  function showHelpAlert_file(callback) {
	closeAlert();
    $(".btn_close").off('click').on('click', function () {
      $("#alert-file-help").dialog("close");
    });

    $("#alert-file-help").dialog({
      modal: true,
      width: "1000px",
      open: function() {
    	  $(this).css('padding', '0px');
      },
    });
    $(".ui-dialog-titlebar").hide();
  }
  
  function closeAlert(){
	$(".popup_wrap_help").each(function(i) {
		  if($(this).is(":visible")){
			  $("#"+$(this).prop("id")).dialog("close");
		  }
	});
  }

</script>