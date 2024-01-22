<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <!-- begin page-header -->
  <div class="page-header">
    datatables(그리드) 샘플
    <ol class="breadcrumb pull-right"></ol>
  </div>
  <!-- end page-header -->

  <!-- begin Tab -->
  <div class="row">
    <ul class="main-tabs">
      <li class="active"><a href="javascript:void(0);" data-toggle="tab" data-tab="sample1" data-id="sample1">기본, 푸터 샘플</a></li>
      <li class=""><a href="javascript:void(0);" data-toggle="tab" data-tab="sample2" data-id="sample2">엑셀다운로드 샘플</a></li>
      <li class=""><a href="javascript:void(0);" data-toggle="tab" data-tab="sample3" data-id="sample3">ajax샘플</a></li>
    </ul>
  </div>
  <!-- end Tab -->

  <!-- begin Content Area -->

  <!-- begin sample1 -->
  <div id="sample1" class="tab-area">
    <div class="row clearfix">
      <div class="search_area">
        <h2 style="margin-bottom: 10px;">- 기본 설정 : WebContent/static/v2/js/custom.js 확인</h2>
        <h3>- 검색란 표시 설정</h3>
          <p>ex) searching: true </p>
        <h3>- 정렬 표시 설정</h3>
          <p>ex) ordering: true </p>
        <h3>- 정보 표시 설정("총 건 중 번째부터 번째까지 표시")</h3>
          <p>ex) info: true </p>
        <h3>- 페이징 표시 설정</h3>
          <p>ex) paging: true </p>
        <h3>- 컬럼 and 데이터 매핑</h3>
          <p>ex) "columns": [{"data": "data1"}]</p>
        <h3>- 컬럼 클래스 적용</h3>
          <p>ex) "columns": [{"data": "data5", "className" : "text-right bg-blue"}]</p>
        <h3>- 컬럼별 설정</h3>
          <p>ex) "columnDefs": [{"targets": 0, "searchable": false, "orderable": false }]</p>
        <h3>- 컬럼별 값 조작</h3>
          <p>ex) "columnDefs": [{"targets": 0, , "render": function (data, type, row) {return moment(data, 'YYYYMMDDHH').format('YYYY-MM-DD');} }]</p>
        <h3>- 컬럼 숨김</h3>
          <p>ex) "columnDefs": [{"targets": [2,3,6,7,9,10], "visible": false}]</p>
        <h3>- 푸터 콜백</h3>
          <p>ex) "footerCallback": function (nRow) {}</p>
        <h3>- 초기화 완료 콜백</h3>
          <p>ex) "initComplete": function( settings, json ) {}</p>
        <div style="margin-bottom: 20px;"></div>
        <h3>- 테이블 hover 클래스 : table-hover</h3>
          <p>ex) "&lt;table id="table1" class="table table-hover"&gt;"</p>
        <h3>- 테이블 포인터 클래스 : table-cursor</h3>
          <p>ex) "&lt;table id="table1" class="table table-cursor"&gt;"</p>
      </div>
    </div>

    <div id="tab-sample1" class="tab-content">
      <!-- begin table -->
      <div class="row">
        <div class="table-responsive">
          <table id="table1" class="table table-hover">
            <colgroup>
              <col width="90" />
              <col width="120" />
              <col width="70" />
              <col width="70" />
              <col width="100" />
              <col width="80 " />
              <col width="75" />
              <col width="75" />
              <col width="75" />
              <col width="75" />
              <col width="75" />
              <col width="75" />
            </colgroup>
            <thead>
            <tr>
              <th rowspan="2"><div class="table-header">발송일</div></th>
              <th rowspan="2"><div class="table-header">메시지유형</div></th>
              <th colspan="2"><div class="table-header">발송구분(건수)</div></th>
              <th rowspan="2" id="total"><div class="table-header">전체건수</div></th>
              <th rowspan="2"><div class="table-header">성공율</div></th>
              <th colspan="3"><div class="table-header">기본발송</div></th>
              <th colspan="3"><div class="table-header">전환발송</div></th>
            </tr>
            <tr>
              <th><div class="table-header">마케팅</div></th>
              <th><div class="table-header">비마케팅</div></th>
              <th id="dSuccess" class="default success"><div class="table-header">성공건</div></th>
              <th id="dFailure" class="default failure"><div class="table-header">실패건</div></th>
              <th><div class="table-header">성공률</div></th>
              <th id="tSuccess" class="transform success"><div class="table-header">성공건</div></th>
              <th id="tFailure" class="transform failure"><div class="table-header">실패건</div></th>
              <th><div class="table-header">성공률</div></th>
            </tr>
            </thead>
            <tfoot>
            <tr>
              <th colspan="12">
                <div>
                  기본 발송 성공 총 건수 (성공률)
                  <span id="cal1Result" class="pull-right"></span>
                </div>
              </th>
            </tr>
            <tr>
              <th colspan="12">
                <div>
                  전환발송 성공 총 건수 (성공률)
                  <span id="cal2Result" class="pull-right"></span>
                </div>
              </th>
            </tr>
            <tr>
              <th colspan="12">
                <div>
                  총 실패 건수 (실패율)
                  <span id="cal3Result" class="pull-right"></span>
                </div>
              </th>
            </tr>
            <tr>
              <th colspan="12" class="table-total">
                <div>
                  총 건수 (총 성공률)
                  <span id="cal4Result" class="pull-right"></span>
                </div>
              </th>
            </tr>
            </tfoot>
          </table>
        </div>
      </div>
      <!-- end table -->
    </div>
  </div>
  <!-- end sample1 -->

  <!-- begin sample2 -->
  <div id="sample2" class="tab-area hide">
    <div class="row clearfix">
      <div class="search_area">
        <h3>- 정보 콜백</h3>
          <p>ex) "infoCallback":function( settings, start, end, max, total, pre) {}</p>
        <h3>- 자동 width 설정</h3>
          <p>ex) autoWidth: false</p>
        <h3>- 엑셀다운로드 추가</h3>
          <p>ex) buttons: [{ extend: 'excel', filename: '엑셀파일명'}]</p>
        <h3>- 엑셀다운로드 푸터 영역 추가</h3>
          <p>ex) buttons: [{ extend: 'excel', filename: '엑셀파일명', footer: true}]</p>
        <h3>- 엑셀다운로드 특정 컬럼만</h3>
          <p>ex) buttons: [{ extend: 'excel', filename: '엑셀파일명', exportOptions: {columns: [0, 1, 2, 4]} }]</p>
      </div>
    </div>

    <!-- begin button Area -->
    <div class="row clearfix">
      <div class="pull-right">
        <button id="exportExcel2" class="btn btn-download">엑셀다운로드</button>
      </div>
    </div>
    <!-- end button Area  -->

    <div id="tab-sample2" class="tab-content">
      <!-- begin table -->
      <div class="row">
        <div class="table-responsive">
          <table id="table2" class="table table-summary table-hover">
            <colgroup>
              <col width="12%" />
              <col width="22%" />
              <col width="22%" />
              <col width="22%" />
              <col width="22%" />
            </colgroup>
            <thead>
            <tr>
              <th><div class="table-header">발송월</div></th>
              <th><div class="table-header">기본 발송 성공 총 건수  (성공률)</div></th>
              <th><div class="table-header">전환 발송 성공  총 건수 (성공률)</div></th>
              <th><div class="table-header">총 실패 건수 (실패율)</div></th>
              <th><div class="table-header">총 건수 ( 총 성공률 )</div></th>
            </tr>
            </thead>
          </table>
        </div>
      </div>
      <!-- end table -->
    </div>
  </div>
  <!-- end sample2 -->

  <!-- begin sample3 -->
  <div id="sample3" class="tab-area hide">
    <div class="row clearfix">
      <div class="search_area">
        <h3>- 정보, 검색, 페이징 위치 조정 ( <a href="https://datatables.net/examples/basic_init/dom.html" target="_blank" style="text-decoration:underline;">참고 사이트 이동</a> )</h3>
          <p>ex) dom: 'irt<"paginate-v2"p>'</p>
        <h3>- 자동 width 설정</h3>
          <p>ex) autoWidth: false</p>
        <h3>- 엑셀다운로드 추가</h3>
          <p>ex) buttons: [{ extend: 'excel', filename: '엑셀파일명'}]</p>
        <h3>- 엑셀다운로드 푸터 영역 추가</h3>
          <p>ex) buttons: [{ extend: 'excel', filename: '엑셀파일명', footer: true}]</p>
        <h3>- 엑셀다운로드 특정 컬럼만</h3>
          <p>ex) buttons: [{ extend: 'excel', filename: '엑셀파일명', exportOptions: {columns: [0, 1, 2, 4]} }]</p>
        <h3>- 페이징 타입</h3>
          <p>ex) pagingType: "full_numbers"(numbers||simple||simple_numbers||full||first_last_numbers)</p>
        <h3>- 페이징 언어 변경</h3>
          <p>ex) language: paginate: {previous: '<i class="fa fa-angle-left"></i>', next: '다음'}</p>
        <h3>- ajax 데이터 조회</h3>
          <p>ex) "ajax": {"url": '/campaign/list.do', "type": "post", data: function (d) {d.searchUserType = $('#search1').val(); //검색값 세팅 }}</p>
        <h3>- 그리드안 버튼 설정</h3>
          <p>ex) "columns": [{"data": "userLevel", "render" : function(data, type, full, meta) { if(data == '9') {// 텍스트} else {// HTML;}return btn; }]</p>
        <h3>- 초기 정렬</h3>
          <p>ex) "order": [[ 1, 'desc']]</p>
        <h3>- 재조회</h3>
          <p>ex) example3.ajax.reload();</p>
        <h3>- 그리드 데이터 조회</h3>
          <p>ex) example3.row(this).data();</p>
      </div>
    </div>

    <!-- begin Search -->
    <div class="row clearfix">
      <div class="search_area">
        <div class="search_field">
          <label>발송구분</label>
          <div>
            <select id="search1">
              <option value="param1-1">전체</option>
              <option value="param1-2">마케팅</option>
              <option value="param1-3">비마케팅</option>
            </select>
          </div>
        </div>
        <div class="search_field">
          <label>메시지 유형</label>
          <div>
            <select id="search2">
              <option value="param2-1">전체</option>
              <option value="param2-2">문자</option>
              <option value="param2-3">알림톡</option>
              <option value="param2-4">RCS</option>
            </select>
            <select id="search3" disabled>
              <option value="param3-1">전체</option>
              <option value="param3-2">SMS</option>
              <option value="param3-3">LMS</option>
              <option value="param3-4">MMS</option>
            </select>
          </div>
        </div>
        <div class="search_field">
          <label>부서</label>
          <div>
            <select id="search4">
              <option value="param4-1">전체</option>
            </select>
          </div>
        </div>
        <div class="search_field">
          <label>
            기간
            <small>최대  31일 조회 가능 ( 당일제외 )</small>
          </label>
          <div>
            <input type="text" id="search5" class="form-control date-picker" value="01/01/2018 - 01/15/2018" />
          </div>
        </div>
        <div class="search_field">
          <button class="btn btn-reset btn-sm">초기화</button>
          <button id="searchBtn" class="btn btn-search btn-sm">검색</button>
        </div>
      </div>
    </div>
    <!-- end Search  -->

    <div id="tab-sample3" class="tab-content">
      <!-- begin table -->
      <div class="row">
        <div class="table-result">
          총 <strong id="countStr" class="split">100</strong>
          <select id="select" class="search-limit">
            <option>10개씩 보기</option>
            <option>20개씩 보기</option>
            <option>30개씩 보기</option>
          </select>
        </div>

        <div class="table-responsive">
          <table id="table3" class="table table-hover table-cursor">
            <colgroup>
              <col width="50" />
              <col width="90" />
              <col width="120" />
              <col width="70" />
              <col width="70" />
              <col width="100" />
              <col width="80 " />
              <col width="75" />
              <col width="75" />
            </colgroup>
            <thead>
            <tr>
              <th><div class="table-header">순번</div></th>
              <th><div class="table-header">등록일</div></th>
              <th><div class="table-header">직원번호</div></th>
              <th><div class="table-header">직원명</div></th>
              <th><div class="table-header">직원IP</div></th>
              <th><div class="table-header">부서명</div></th>
              <th><div class="table-header">권한수준</div></th>
              <th><div class="table-header">사용여부</div></th>
              <th><div class="table-header">수정</div></th>
            </tr>
            </thead>
          </table>
        </div>
      </div>
      <!-- end table -->
    </div>

  </div>
  <!-- end sample2 -->

  <!-- // end Content Area -->




<script type="text/javascript">
    var example1;
    var example2;
    var example3;

    var example1List = [
        {
          "data1": "20220801",
          "data2": "일반-SMS",
          "data3": "",
          "data4": "50000",
          "data5": "",
          "data6": "",
          "data7": "50000",
          "data8": "10000",
          "data9": "",
          "data10": "10000",
          "data11": "",
          "data12": "",
          "data13": "123"
        },
        {
          "data1": "20220901",
          "data2": "일반-LMS",
          "data3": "",
          "data4": "60000",
          "data5": "60000",
          "data6": "",
          "data7": "53000",
          "data8": "0",
          "data9": "",
          "data10": "",
          "data11": "",
          "data12": "",
          "data13": "456"
        }
    ];
    var example2_1List = [
      {
        "data1": "202108",
        "data2": "456,000 건 (95%)",
        "data3": "44,000 건 (5%)",
        "data4": "0 건 (0%)",
        "data5": "5000,000 건 (100%)"
      },
      {
        "data1": "202109",
        "data2": "456,000 건 (95%)",
        "data3": "44,000 건 (5%)",
        "data4": "0 건 (0%)",
        "data5": "5000,000 건 (100%)"
      },
      {
        "data1": "202110",
        "data2": "456,000 건 (95%)",
        "data3": "44,000 건 (5%)",
        "data4": "0 건 (0%)",
        "data5": "5000,000 건 (100%)"
      }
    ];

    $(document).ready(function() {
        init();

        // 엑셀 다운로드 클릭 이벤트
        $('#exportExcel2').on('click', function() {
            $('#sample2 .buttons-excel').trigger('click');
        });
        // 조회 버튼 클릭 이벤트
        $('#searchBtn').click(function () {
            search();
        });
        // 목록 순번 처리
        example3.on('order.dt search.dt', function () {
            example3.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        // row 클릭 이벤트 리스너
        $('#table3 tbody').on('click', 'tr',function () {
          // 선택한 row 정보
          var data = example3.row(this).data();
          alert('행 click => '+data.emplName);
        });
        // 페이지당 건수 변경 이벤트
        $('#select').change(function () {
            example3.page.len($(this).val()).draw();
        });

        // 그리드안 이벤트
        $('#table3 tbody').on('click', '.link', function (e) {
          var data = example3.row($(this).parents('tr')).data();
          alert('수정 click => '+data.partName);

          e.stopImmediatePropagation();
        });
        // 초기화 클릭 이벤트
        $(document).on('click', '.btn-reset', function () {
          $('.search_field select').each(function () {
            // 첫번째 option 선택
            $(this).children('option:eq(0)').prop("selected", true);
          });

          // 변경된 검색조건으로 그리드 조회
          search();
        });
    });

    // 초기실행
    function init() {

      example1 = $('#table1').DataTable({
        dom: 'Bfrtip'
        /* 기본 설정과 동일하므로 주석처리
        // 검색란 표시 설정
        , searching: false
        // 정렬 표시 설정
        , ordering: false
        */
        // 정보 표시 설정
	    , info: false
        // 페이징 표시 설정
        , paging: false
        // 서버처리 중 표시 설정
        , processing: false
        , data: example1List
        , buttons: []
        , "columns": [
            {"data": "data1"}
            // XSS처리 => render: $.fn.dataTable.render.text()
            , {"data": "data2", "className" : "text-left", render: $.fn.dataTable.render.text()}
            , {"data": "data3", "className" : "text-right"}
            , {"data": "data4", "className" : "text-right"}
            , {"data": "data5", "className" : "text-right bg-blue"}
            , {"data": "data6", "className" : "text-right bg-blue"}
            , {"data": "data7", "className" : "text-right bg-yellow"}
            , {"data": "data8", "className" : "text-right bg-yellow"}
            , {"data": "data9", "className" : "text-right"}
            , {"data": "data10", "className" : "text-right"}
            , {"data": "data11", "className" : "text-right"}
            , {"data": "data12", "className" : "text-right"}
            , {"data": "data13"}
        ]
        , "columnDefs": [
          {
            "searchable": false
            , "orderable": false
            , "targets": 0
            , "render": function (data, type, row) {
                // 날짜 포맷팅
                return moment(data, 'YYYYMMDDHH').format('YYYY-MM-DD');
            }
          }
          , {
            // 마케팅, 비마케팅, 기본발송-성공, 기본발송-실패, 전환발송-성공, 전환발송-실패
            "targets": [2,3,6,7,9,10]
            , "render": function (data, type, row) {
                // 콤마
                return num.isEmpty(data)?'-':str.comma(data);
            }
          }
          , {
            "targets": 4
            , "render": function (data, type, row) {
                // 전체건수
                var totalCount = Number(row.data7) + Number(row.data8);
                return num.isEmpty(totalCount)?'-':str.comma(totalCount);
            }
          }
          , {
            "targets": 5
            , "render": function (data, type, row) {
                // 전체성공율
                var totalCount = Number(row.data7) + Number(row.data8) + Number(row.data9); // 전체건수
                var totalSuccessCount = Number(row.data7) + Number(row.data10); // 전체성공건
                return num.isEmpty(totalCount)?'-':num.percent(totalSuccessCount, totalCount);
            }
          }
          , {
            "targets": 8
            , "render": function (data, type, row) {
                // 기본성공율
                var defaultCount = Number(row.data7) + Number(row.data8); // 기본발송총건수
                return num.isEmpty(defaultCount)?'-':num.percent(row.data7, defaultCount);
            }
          }
          , {
            "targets": 11
            , "render": function (data, type, row) {
                // 전환성공율
                var transformCount = Number(row.data10) + Number(row.data11); // 전환발송총건수
                return num.isEmpty(transformCount)?'-':num.percent(row.data10, transformCount);
            }
          }
          // hidden 처리
          , {
            "targets": [12],
            "visible": false,
            "searchable": false
          }
        ]
        // footer영역 콜백
        , "footerCallback": function (nRow) {
          var api = this.api();

          // 기본발송총건수
          var defaultCount = 0;
          api.columns('.default', {page: 'all'}).every(function () {
            defaultCount += fnSum(this.data());
          });
          // 기본발송성공총건수
          var defaultSuccessCount = 0;
          api.columns('#dSuccess', {page: 'all'}).every(function () {
            // 성공 총건수
            defaultSuccessCount += fnSum(this.data());
          });
          // 기본 발송 성공 총 건수 (성공률)
          $('#cal1Result').html(str.comma(defaultSuccessCount)+ "건 ("+num.percent(defaultSuccessCount, defaultCount)+")");

          // 전환발송총건수
          var transformCount = 0;
          api.columns('.transform', {page: 'all'}).every(function () {
            transformCount += fnSum(this.data());
          });
          // 전환발송성공총건수
          var transformSuccessCount = 0;
          api.columns('#tSuccess', {page: 'all'}).every(function () {
            // 성공 총건수
            transformSuccessCount += fnSum(this.data());
          });
          // 전환발송 성공 총 건수 (성공률)
          $('#cal2Result').html(str.comma(transformSuccessCount)+ "건 ("+num.percent(transformSuccessCount, transformCount)+")");

          // 실패총건수
          var failureCount = 0;
          api.columns('.failure', {page: 'all'}).every(function () {
            failureCount += fnSum(this.data());
          });
          // 총 실패 건수 (실패율)
          $('#cal3Result').html(str.comma(failureCount)+ "건 ("+num.percent(failureCount, defaultCount+transformCount)+")");

          // 총 건수 (총 성공률)
          var totalCount = defaultSuccessCount+transformSuccessCount+failureCount;
          var totalSuccessCount = defaultSuccessCount+transformSuccessCount;
          $('#cal4Result').html(str.comma(totalCount)+ "건 ("+num.percent(totalSuccessCount, totalCount)+")");
        }
        // 초기화 완료 후 실행
        , "initComplete": function( settings, json ) {
          // thead, tfoot에 같이 추가되는 className 제거
          $('#table1 thead th').removeClass('text-left');
          $('#table1 thead th').removeClass('text-right');
          $('#table1 thead th').removeClass('bg-blue');
          $('#table1 thead th').removeClass('bg-yellow');

          $('#table1 tfoot th').removeClass('text-left');
          $('#table1 tfoot th').removeClass('text-right');
          $('#table1 tfoot th').removeClass('bg-blue');
          $('#table1 tfoot th').removeClass('bg-yellow');
        }
      });

      example2 = $('#table2').DataTable({
        dom: 'Bfrtip'
        /* 기본 설정과 동일하므로 주석처리
        // 검색란 표시 설정
        , searching: false
        // 정렬 표시 설정
        , ordering: false
        // 정보 표시 설정
	    , info: true
	    */
        // 정보 커스텀
        , "infoCallback":function( settings, start, end, max, total, pre) {
            return "총 " + max + "건 중 "+ start + "번째부터 " + end + "번째까지  표시" ;
        }
        // 페이징 표시 설정
        , paging: false
        // true일 경우 hide탭 width 0됨
        , autoWidth: false
        // 서버처리 중 표시 설정
        , processing: false
        , data: example2_1List
        , buttons: [
          {
            text: '엑셀다운로드-예시 상단 퍼블 버튼도 동작함'
            , extend: 'excel'
            , footer: true // footer 포함여부
            , title: '엑셀다운로드샘플' // 파일명이 없으면 해당 값이 파일명이 됨
            , filename: '엑셀파일명' // 파일명
            /* 일부만 엑셀다운로드시 columns지정
            , exportOptions: {
                columns: [0, 1, 2, 4]
            }
            */
          }
        ]
        , "columns": [
            {"data": "data1"},
            {"data": "data2", "className" : "text-right"},
            {"data": "data3", "className" : "text-right"},
            {"data": "data4", "className" : "text-right"},
            {"data": "data5", "className" : "text-right font-weight-bold"}
        ]
        , "columnDefs": [
          {
            "targets": 0,
            "render": function (data, type, row) {
                // 날짜 포맷팅
                return moment(row.data1, 'YYYYMMDD').format('YYYY-MM');
            }
          }
        ]
        // 초기화 완료 후 실행
        , "initComplete": function( settings, json ) {
          // thead에 같이 추가되는 className 제거
          $('#table2 thead th').removeClass('text-right');
          $('#table2 thead th').removeClass('text-right');
          $('#table2 thead th').removeClass('font-weight-bold');
        }
      });

      example3 = $('#table3').DataTable({
        /* 기본 설정과 동일하므로 주석처리
        // p : 페이징 / <> : div / paginate-v2 : class
        dom: 'irt<"paginate-v2"p>'
        // 검색란 표시 설정
        , searching: false
        // 정보 표시 설정
	    , info: true
        // 정보 커스텀
        , "infoCallback":function( settings, start, end, max, total, pre) {
            $('#countStr').text(max);
        }
        , pagingType: "full_numbers"
        , language: {
            paginate: {
                first: '<i class="fa fa-angle-double-left"></i>'
                , last: '<i class="fa fa-angle-double-right"></i>'
                , previous: '<i class="fa fa-angle-left"></i>'
                , next: '<i class="fa fa-angle-right"></i>'
            },
        }
        */
        // 정렬 기능 표시 설정
        ordering: true
        // true일 경우 hide탭 width 0됨
        , autoWidth: false
        , "ajax": {
            "url": '/campaign/list.do',
            "type": "post",
            "dataSrc": "",
            data: function (d) {
                d.searchUserType = $('#search1').val();
                d.searchWordType = $('#search2').val();
                d.searchWord = $('#search3').val();
            }
        }
        , buttons: []
        , "columns": [
            {"data": null}
            , {"data": "regDt"}
            , {"data": "emplId"}
            , {"data": "emplName", "className" : "text-left"}
            , {"data": "emplIp"}
            , {"data": "partName"}
            , {"data": "emplLevel"}
            , {"data": "useYn"}
            , {"data": "userLevel", "render" : function(data, type, full,	meta) {
                var btn = '';
                if(data == '9') {
                  btn = '수정불가';
                } else {
                  btn = '<a href="javascript:void(0)" class="link">수정</a>';
                }
                return btn;
            }}
        ]
        , "columnDefs": [
          {
            "targets": 1
            , "render": function (data, type, row) {
                // 날짜 포맷팅
                return moment(data, 'YYYYMMDDHH').format('YYYY-MM-DD');
            }
          }
          , {
            "targets": [0, 8]
            , "orderable": false // 해당 컬럼만 정렬기능 막기
          }
        ]
        // 초기화 완료 후 실행
        , "initComplete": function( settings, json ) {
          // thead에 같이 추가되는 className 제거
          $('#table3 thead th').removeClass('text-left');
        }
        // 초기 정렬 설정
        , "order": [[ 1, 'desc']]
      });
    }

    // 더하기
    function fnSum(data) {
      return data.reduce(function (a, b) {
        return Number(a)+Number(b);
      }, 0);
    }

    // 그리드 reload
    function search() {
        example3.ajax.reload();
    }
</script>