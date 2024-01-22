<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- wrapper -->
    <h3>SMS/MMS 전송내역 조회
    </h3>
<!-- content -->
<div id="content">
    <!-- box_info -->
    <div class="box_info_s">
      <div class="title">검색전에 아래 내용을 반드시 읽어주시기 바랍니다.</div>
      <div class="text1 mgt8">1. 이동통신사 처리결과가 성공이면 IBK기업은행에서 발송한 문자에 대해 이동통신사가 문자 수신을 하고 정상적으로 처리 된겁니다.<br>&nbsp;&nbsp;&nbsp;이동통신사 정책에 따라 스팸처리되었거나 고객 휴대폰 내 스팸메시지로 분류가 된 경우도 '성공'으로 처리됩니다.<br>&nbsp;&nbsp;&nbsp;관련 문의는 이동통신사로 고객님이 직접하셔야 합니다. (문자 수/발신 이력은 고객정보로 분류 – 이동통신사 정책)</div>
      <div class="text1 mgt6">2. 이동통신사 처리결과가 '성공','결과대기' 이외의 경우는 모두 문자 발송이 실패된 겁니다.<br>&nbsp;&nbsp;&nbsp;고객 사정에 의해 실패된 케이스로 이동통신사로 문의하시면 됩니다.</div>
      <div class="text1 mgt6">* SMS/MMS 전송내역 조회는 최근 2년내에 기업은행에서 발송된 내역이 조회 가능합니다.(통신사 본인인증, BC카드사에서 발송된 이력은 본 화면에서 조회되지 않습니다.)</div>
    </div>


    <!-- //box_info --> 
    <!-- Search -->
    <div class="box_search01 mgt20">
      <ul>
        <li><span class="title02">발송일</span>
                <span><input type="text" name="search" value="" id="searchStartDt" readonly value="${s_startdt}" style="width:75px"></span>
                <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchStartDatePicker">
                </span>
                 <span class="mgl5 mgr5">~</span>
                 <span><input type="text" name="search" id="searchEndDt" readonly value="${s_enddt}" style="width:75px"></span>
                 <span class="mgl2" style="cursor:pointer;">
                    <input type="hidden" id="searchEndDatePicker">
                 </span>
                  <span class="title02 mgl15">휴대폰번호<span class="th_must">*</span></span>
                  <span><input type="text" id="searchPhoneNum" name="search" value="${phno}" maxlength="13" placeholder="숫자만 입력" style="width:100px" ${phoneReadonly}></span>
                  <span class="btn3 fr"><a href="javascript:;" id="search-btn" class="btn_search">조회</a></span> </div>
            </li>
      </ul>
      
    <!-- //Search -->
          <div class="table_top">  총 <span id="total_cnt">0</span>건
            <span class="num"> 
              <select id="per-page"> 
                  <option value="10">10</option>
                  <option value="20">20</option> 
                  <option value="30">30</option> 
              </select> 
           </span> 
         </div> 
     <!-- table list -->
        <div class="tbl_wrap_list" style="overflow-x:auto;min-height:320px;">
          <table class="tbl_list" id="allmessage_table" summary="테이블 입니다. 항목으로는 등이 있습니다" >
            <caption>
            테이블
            </caption>
            <colgroup>
            <col style="width: 100px" />
            <col style="width: 105px" />
            <col style="width: 75px" />
            <col style="width: 50px" />
            <col style="width: 135px" />
            <col style="width: 265px" />
            <col style="width: 85px" />
            <col style="width: 75px" />
            <col style="width: 120px" />
            <col style="width: 95px" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col" style="display:none;">아이디</th>
                <th scope="col">발송시스템</th>
                <th scope="col">발송일시</th>
                <th scope="col">이동통신사<br>처리결과</th>
                <th scope="col">메시지<br>구분</th>
                <th scope="col">메시지 제목</th>
                <th scope="col">메시지 내용</th>
                <th scope="col">업무담당자</th>
                <th scope="col">업무담당자<br>연락처</th>
                <th scope="col">전행고객번호/<br>관련계좌번호</th>
                <th scope="col">발신전화번호</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="13" style="height:330px">
                    <div class="nodata"><p>조회 하신 데이터가 없습니다.</p></div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- //table list -->
        <div class="totalm_databox mgt20">
            <span>합계</span><span class="text1 mgl50">전송성공수 : <span id="successCount">0</span> / <span id="total_cnt">0</span> (성공메시지 / 총 메시지)</span><span class="text1 mgl54">전송성공률 : <span id="successPercent">0</span><span>%</span></span>
        </div>
          <!-- 페이징 -->
        <div class="paging" id="pagination">
        </div>
        <!-- //페이징 -->        
      </div>
      <!-- //content --> 
  <!-- footer
    <footer>copyright</footer>
    <!-- //footer --> 
<!-- //wrapper -->

<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="/WEB-INF/view/jsp/common/dialog.jsp" flush="true"/>
<jsp:include page="allmessage-popup.jsp" flush="true"/>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatatables3.js"></script>
<!-- Script -->
<!-- common event handler on list pages  -->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/list_stuff.js"></script>
<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/allmessage-column.js"></script>

<script>
    var aKakaoCode = {
        '3005':'수신확인 안됨 (성공불확실)'
        ,'3006':'내부 시스템 오류로 메시지 전송실패'
        ,'3008':'전화번호 오류'
        ,'3016':'메시지 내용이 템플릿과 일치하지 않음'
        ,'3018':'메시지를 전송할수 없음(친구차단, 카카오톡 미설치 등)'
        ,'3027':'메시지 버튼이 템플릿과 일치하지 않음'
        ,'8002':'시스템에 문제로 인한 발송실패'
        ,'9999':'시스템에 문제로 인한 발송실패'
        ,'9002':'메시지 내용을 입력하지 않아서 실패'
        ,'9401':'카카오알림톡 발송테스트'
    };

    $(document).ready(function () {
        
        if($("#searchPhoneNum").val() != '') {
            $("#search-btn").trigger("click");
        }
        
        $("body").attr("style", "-ms-overflow-style: scrollbar !important;");
        
        $("#content").parents("section").width("1320px"); // 원본 1220px;
        $("#content").parents("article").width("1200px");  // 1000px
        $("#content").parents("section").find("aside").hide();
        
        //$.ajaxSetup({ async: false });//총 건수 셋팅을 위한 딜레이
    
        enterKeyListener();
    
        // 날짜 범위를 값을 세팅 해줌
        var initSearchStartDate = '${s_startdt}'; // moment().format("YYYY-MM-01");
        var initSearchEndDate = '${s_enddt}'; // moment().format("YYYY-MM-DD");
        if(!initSearchStartDate) initSearchStartDate = moment().format("YYYY-MM-01");
        if(!initSearchEndDate) initSearchEndDate = moment().format("YYYY-MM-DD");
        
        
        $("#searchStartDt").val(initSearchStartDate);
        $("#searchEndDt").val(initSearchEndDate);
        $("#searchStartDatePicker").val(initSearchStartDate);
        $("#searchEndDatePicker").val(initSearchEndDate);
    
        // datepicker 세팅
        IbkDatepicker.Datepicker("searchStartDatePicker", "${pageContext.request.contextPath}");
        IbkDatepicker.Datepicker("searchEndDatePicker", "${pageContext.request.contextPath}",'');
        initTable();
    });


    // 조회 버튼 클릭 이벤트 리스너
    $("#search-btn").on('click', function () {
        if($("#searchPhoneNum").val() == '') {
            showAlert("휴대폰 번호는 필수 값입니다.");
            return false;
        }
        
        if(!IbkValidation.invalidSameDateScope("searchStartDatePicker", "searchEndDatePicker")){
            if($("#searchPhoneNum").val() == '') {
                showAlert("휴대폰번호가 없는 경우, 하루만 조회 가능합니다.")
                return false;
            }
        }
        
        if (IbkValidation.invalidDateScope("searchStartDatePicker", "searchEndDatePicker")) {
            // dialog jsp 가 include 되어 있어야 합니다.
            showAlert("검색 날짜 범위가 잘못 되었습니다.");
            return false;
        }
        if (IbkValidation.invalidSameYYYYMMScope("searchStartDatePicker", "searchEndDatePicker")) {
            showAlert("동일 월만 조회 가능 합니다.");
            return false;
        }
        ///핸드폰번호 유효성 검사 
        if($("#searchPhoneNum").val().length < 10 && $("#searchPhoneNum").val().length > 1 ){
            if($("#searchPhoneNum").val().substr(0,2) != '01'){
                showAlert("유효한 휴대폰번호가 아닙니다.");
                return false;
            }
            showAlert("유효한 휴대폰번호가 아닙니다.(10자리 이상)");
            return false;
        }

        checkEmplHp($("#searchPhoneNum").val(), function(){
            initTable();
        });
    });

    // 직원 휴대폰번호는 검색하지 못하게 체크 진행
    function checkEmplHp(qHpNo, callback) {
        if(qHpNo && qHpNo.match(/^01[0-9]{8,9}/)) {
            $.ajax({
                url:'${pageContext.request.contextPath}/allmessage/checkEmplHp',
                type:"GET",
                data : {'searchPhoneNumber':qHpNo},
                success:function(result){
                    if(result == 'Y') {
                        if (callback && typeof callback == 'function') {
                            callback.call(this);
                        }
                    } else {
                        switch(result) {
                            case 'D':
                                showAlert("로그인 후 이용해주세요.");
                                break;
                            case 'F':
                                showAlert("유효한 휴대폰번호가 아닙니다.");
                                break;
                            case 'N':
                                showAlert("직원 휴대폰번호로는 조회불가");
                                break;
                            default:
                                showAlert("조회 중 에러가 발생했습니다 (" + result +")");
                                break;
                        }
                    }
                },error : function(e){
                    showAlert("조회 중 에러가 발생했습니다 (" + e +")");
                    //console.log(e);
                }
            })
        }
    }

    //상세화면 팝업 값세팅
    $(document).on('click', '#allmessage_table tr', function(){
        //console.log(IbkDataTable.dataTable.row( this ).data());
        if (IbkDataTable.dataTable.row( this ).data() == undefined) {
            return;
        }
        var msgkey =IbkDataTable.dataTable.row( this ).data().msgkey;
        var id = IbkDataTable.dataTable.row( this ).data().id;
        var reqDate = IbkDataTable.dataTable.row( this ).data().reqDate;
        var rslt = IbkDataTable.dataTable.row( this ).data().rslt;
        var messageType = IbkDataTable.dataTable.row( this ).data().messageType;
        var subject = IbkDataTable.dataTable.row( this ).data().subject;
        var msg = IbkDataTable.dataTable.row( this ).data().msg;
        
        var unit = IbkDataTable.dataTable.row( this ).data().unitPic.split(" ");
        var bocdNm = unit[0];
        if(unit.length > 2){
            var unitPic = unit[1] + " " +  unit[2]; 
        }else {
            var unitPic = unit[1];
        }
        
        
        var unitPicTelno = IbkDataTable.dataTable.row( this ).data().unitPicTelno;
        var etc3 = IbkDataTable.dataTable.row( this ).data().etc3;
        var callback = IbkDataTable.dataTable.row( this ).data().callback;
        var telcoInfo = IbkDataTable.dataTable.row( this ).data().telcoInfo;
        var rsltDate = IbkDataTable.dataTable.row( this ).data().rsltDate;
        var lvia = IbkDataTable.dataTable.row( this ).data().unitName;
        var vsubCode = IbkDataTable.dataTable.row( this ).data().vsubCode;
        
        //발송시스템이 null일 경우 작동 하도록 수정 20200626 pmk
        if(IbkDataTable.dataTable.row( this ).data().id){
            var updateKey = IbkDataTable.dataTable.row( this ).data().id.split("_")[0];     
        }else {
            var updateKey = "";
        }
        
        var etc1 = IbkDataTable.dataTable.row( this ).data().etc1;
        var etc3 = IbkDataTable.dataTable.row( this ).data().etc3;
        var tranRefkey = IbkDataTable.dataTable.row( this ).data().tranRefkey;
        
        if (etc1 == null) etc1 = "";
        if (etc3 == null) etc3 = "";
        if (tranRefkey == null) tranRefkey = "";
        
        var seq1 = IbkDataTable.dataTable.row( this ).data().seq1;
        var seq2 = IbkDataTable.dataTable.row( this ).data().seq2;
        var seq3 = IbkDataTable.dataTable.row( this ).data().seq3;
        
        var csGuide = IbkDataTable.dataTable.row( this ).data().csGuide;
    
        var refCtnt = IbkDataTable.dataTable.row( this ).data().refCtnt;
        var agentRslt = IbkDataTable.dataTable.row( this ).data().agentRslt;
        var sAgentRslt = messageType == 'KAKAO' && agentRslt && aKakaoCode[agentRslt] ? ('['+ agentRslt +'] '+ aKakaoCode[agentRslt]) : '';
        
        var fvia = lvia + "(" + id +")";
        
        var result = {
            msgkey: msgkey,
            fvia : fvia,
            reqDate : reqDate,
            rslt : rslt,
            messageType : messageType,
            subject : subject,
            msg : msg,
            bocdNm : bocdNm,
            unitPic : unitPic,
            unitPicTelno : unitPicTelno,
            callback : callback,
            telcoInfo : telcoInfo,
            rsltDate : rsltDate,
            lvia : lvia,
            vsubCode : vsubCode,
            updateKey : updateKey,
            etc1:etc1,
            etc3:etc3,
            tranRefkey:tranRefkey,
            seq1:seq1,
            seq2:seq2,
            seq3:seq3,
            csGuide:csGuide,
            agentRslt:sAgentRslt,
            refCtnt:refCtnt
        };
        setJobCodeInfo('#popup_detail', result);
    });

    //성공건수, 성공율 맵핑
    function successCount(){
        $(".dataTables_scrollHead").css("width",$(".dataTables_scrollBody").width() + "px");
        var JSONrequestsParam = {
                'searchStartDt' : $("#searchStartDt").val().replace(/-/g, ''),
                'searchEndDt' :$("#searchEndDt").val().replace(/-/g, ''),
                'searchSendStatus' : $("#searchSendStatus").val(),
                'searchPhoneNumber' : $("#searchPhoneNum").val()
            }
    
        $.ajax({
            url:'${pageContext.request.contextPath}/allmessage/successCount',
            type:"GET",
            data : JSONrequestsParam,
            success:function(result){
                $('#successCount').text($.number(result));
                //전송성공율 반올림
            var nPer = Math.ceil(( result/$('#total_cnt').text().replace(/,/g,""))*100)  ;
                if(isNaN(nPer)){
                $("#successPercent").text('0');
                }else {
                $("#successPercent").text(nPer);
                }
            },error : function(evt){
                //console.log(evt);
            }
        })
    }
    

    // 페이지당 조회 카운트 변경 이벤트 리스너
    $("#per-page").on('change', function () {
        IbkDataTable.perPage = $(this).val();
        IbkDataTable.currentPage = 1;
        IbkDataTable.reload();
    });
    
    //검색 시작일 datepikcer 값 변경 시
    // 검색 시작일 셀렉트 박스 날짜 값을 변경해 주는 이벤트 리스너
    $("#searchStartDatePicker").on('change', function(data){
        var date = data.target.value;
        IbkDatepicker.setDateSelectByDate("searchStartDt", date);
    });
    
     $("#searchEndDatePicker").on('change', function(data){
        var date = data.target.value;
        IbkDatepicker.setDateSelectByDate("searchEndDt", date);
    });

    //휴대폰번호에 숫자만 가능 
    $("#searchPhoneNum").keyup(function(event){
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9]/gi,''));
    });
    
    // enter ket 이벤트 리스너
    function enterKeyListener() {
        // enter key event
        $("#searchPhoneNum").keypress(function (event) {
            if (event.which == 13) {
                event.preventDefault();
                $("#search-btn").trigger("click");
            }
        });
    }

    $("#zoom-in-btn").on('click', function () {
        IbkZoom.zoomIn();
    });
    
    $("#zoom-out-btn").on('click', function () {
        IbkZoom.zoomOut();
    });


    datagridTrColorChanger("#allmessage_table");

    ////조회 리스트 출력
    function initTable(){
        var JSONrequestsParam = {
            'searchStartDt' : $("#searchStartDt").val().replace(/-/g, ''),
            'searchEndDt' :$("#searchEndDt").val().replace(/-/g, ''),
            'searchSendStatus' : $("#searchSendStatus").val(),
            'searchPhoneNumber' : $("#searchPhoneNum").val()
        };
        
        if(IbkDataTable.dataTable == null){
            // datatables ajax 에서 사용 할 parameter 세팅
            // 꼭!!! function(data) 처럼 함수로 정의를 해야 한다.
            var phoneNumber= "${phno}";

            var requestParam = function (data) {
                // 필수 변경 불가
                data.perPage = IbkDataTable.perPage;
                // 필수 변경 불가
                data.currentPage = IbkDataTable.currentPage;
                // 여기서 부터는 Custom 하게
                data.searchStartDt = $("#searchStartDt").val().replace(/-/g, '');
                data.searchEndDt = $("#searchEndDt").val().replace(/-/g, '');
                data.searchSendStatus = $("#searchSendStatus").val();
                data.searchPhoneNumber = $("#searchPhoneNum").val();
            };

            // datatables 세팅 모든 파라미터는 필수값
            IbkDataTable.initDataTable("allmessage_table", "${pageContext.request.contextPath}/allmessage", requestParam,
                    IbkAllMessageColumn.columns, IbkAllMessageColumn.columnDefs, successCount, {"scrollY": "330px", "scrollX": true});
        }else{
            $(".dataTables_processing").css("z-index","99999");
            IbkDataTable.currentPage = 1;
            IbkDataTable.reload();
        }

        //successCount(JSONrequestsParam);
    }
</script>

