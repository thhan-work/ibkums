var IbkContentsColumn = {
  columns: [
    {data: "emplId"},
    {data: 'regDt',
      "render":function (data, type, row) {
        return moment(data, "YYYYMMDDHHmmss").format("YYYY-MM-DD")
      }
    },
    {data: 'partName',
      "render": function (data, type, row) {
        return data;
      }
    },
    {
        data: 'userLevel',
        "render": function (data, type, row) {
            return data + "차";
        }
    },
    {
      data: 'emplName'
    },
    {
      data: 'emplId'
    },
     {
         data: null,
             "render": function (data, type, row) {
             return '<a href="javascript:" class="btn_small mod_btn" id="employee-'
             + row.emplId
             + '">수정</a>';
         }
     }
  ],
  columnDefs: [{
    'targets': 0,
    'searchable': false,
    'orderable': false,
    'className': 'dt-body-center',
    'render': function (data, type, full, meta) {
      return '<div class="checkbox_center">'
          + '<input type="checkbox" class="dt-check-box" value="' + data
          + '"/>'
          + '                        <label class="dt-check-box-label" for="dt-check-box"></label>'
          + '</div>'
    }
  }]
}