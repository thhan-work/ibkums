var IbkDataTableInSearch = {
  perPage: 5,
  currentPage: 1,
  endPage: 0,
  lastPage: 0,
  startPage: 0,
  dataTable: null,

  initDataTable: function (targetId, searchUrl, requestParam, columns,
      columnDefs) {
    IbkDataTableInSearch.dataTable = $('#' + targetId).DataTable({
          "ajax": {
            "url": searchUrl,
            "data": requestParam
          },
          "processing":
              true,
          "dataSrc":
              "data",
          "bPaginate":
              false,
          "bFilter":
              false,
          "bInfo":
              false,
          "language":
              {
                'loadingRecords': '&nbsp;',
                'processing': '<div style="height:250px"><img src="/static/images/list-loading.gif"></div>',
                "emptyTable":
                    "<div style='height:150px;margin-top:50px'>조회 목록이 없습니다.</div>",
              }
          ,
          'columns': columns,
          'columnDefs': columnDefs,
          select:
              {
                'style':
                    'multi'
              }
          ,
          "drawCallback":
              function (settings) {
                var html = '';
                if (settings.json) {
                	//console.log(settings.json);
                  var tableJson = settings.json;
                  IbkDataTableInSearch.endPage = tableJson.endPage;
                  IbkDataTableInSearch.lastPage = tableJson.lastPage;
                  IbkDataTableInSearch.startPage = tableJson.startPage;
                  IbkDataTableInSearch.currentPage = tableJson.currentPage;
                  $("#total_cnt_insearch").text($.number(tableJson.totalRecords));
                  var totalCount=tableJson.totalRecords;
                  //console.log(totalCount>0);
                  if(totalCount>0){
                      $("#searchpagination").show();
                	  html += '<a href="javascript:;">'
                          + '    <img src="/static/images/btn_pg_first.png" id="first-searchpage_insearch" alt="첫 페이지"/>'
                          + '  </a>';
                      html += '<a href="javascript:;">'
                          + '    <img src="/static/images/btn_pg_previous.png" id="pre-searchpage_insearch" alt="이전 페이지"/>'
                          + '  </a>';
                      html += '<span class="wrap">';
                      for (i = tableJson.startPage; i <= tableJson.endPage; i++) {
                        if (tableJson.currentPage == i) {
                          html += '<a href="#" class="on">' + i + '</a>'
                        } else {
                          html += "<a href='javascript:;' class='page-btn' id='searchpage-btn_insearch'>" + i
                              + "</a>"
                        }
                      }
                      html += "</span>";

                      html += '<a href="javascript:;">'
                          + '     <img src="/static/images/btn_pg_next.png" id="next-searchpage_insearch"'
                          + 'alt = "다음 페이지" / > '
                          + '</a>';
                      html += '<a href="javascript:;">\n'
                          + '        <img src="/static/images/btn_pg_last.png" id="last-searchpage_insearch"\n'
                          + '        alt="마지막 페이지"/>\n'
                          + '        </a>';
                      $("#searchpagination").html(html);
                  }else{
                      $("#searchpagination").hide();
                  }
                  
                }
              }
        }
    )
    ;
// html append event trigger
    $(document).on('click', '#searchpage-btn_insearch', function () {
      IbkDataTableInSearch.currentPage = $(this).text();
      IbkDataTableInSearch.reload();
    });

    $(document).on('click', '#first-searchpage_insearch', function () {
      IbkDataTableInSearch.currentPage = 1;
      IbkDataTableInSearch.reload();
    });

    $(document).on('click', '#pre-searchpage_insearch', function () {
      IbkDataTableInSearch.currentPage = IbkDataTableInSearch.startPage - 1;
      if (IbkDataTableInSearch.currentPage < 1) {
        IbkDataTableInSearch.currentPage = 1;
      }
      IbkDataTableInSearch.reload();
    });

    $(document).on('click', '#last-searchpage_insearch', function () {
      IbkDataTableInSearch.currentPage = IbkDataTableInSearch.lastPage;
      IbkDataTableInSearch.reload();
    });

    $(document).on('click', '#next-searchpage_insearch', function () {
      IbkDataTableInSearch.currentPage = IbkDataTableInSearch.endPage + 1;
      if (IbkDataTableInSearch.currentPage > IbkDataTableInSearch.lastPage) {
        IbkDataTableInSearch.currentPage = IbkDataTableInSearch.lastPage;
      }
      IbkDataTableInSearch.reload();
    });
  },
  reload: function () {
    IbkDataTableInSearch.dataTable.ajax.reload();
  }
}