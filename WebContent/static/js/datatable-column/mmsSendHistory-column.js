var IbkMmsSendHistoryListColumn = {
  columns: [
    {data: 'rnum'}, //순번 
    {
	    data: 'sentDate', //발송일시
	    "render":function (data, type, row) {
	    	return data != null ? moment(data, "YYYYMMDDHHmmss").format("YYYY-MM-DD HH:mm:ss") : "-";
        }
    },
    {
    	data: 'rsltDate', //수신일시
    	"render":function (data, type, row) {
	    	return data != null ? moment(data, "YYYYMMDDHHmmss").format("YYYY-MM-DD HH:mm:ss") : "-";
        }
    },
    {
    	data: 'phone', //수신번호
    	"render":function (data, type, row) {
    		var pattern = /^(\d{3})-?(\d{4})-?(\d{4})$/;
	        var result = "-";
	        if(!data) return result;

	        var match = pattern.exec(data);
	        if(match) {
	            result = match[1]+"-****-"+match[3];
	        } else {
	            result = "-";
	        }
	        return result;
        }
    },
    {
    	data: 'callback', //발신번호
    	"render":function (data, type, row) {
	    	return data != null ? data : "-";
        }
    },
    {
        data: 'msgDstic', //메시지유형
        "render": function (data, type, row) {
        	var fmtMsgDstic = "";
        	if(row.altMsgYn == 'Y') {
        		fmtMsgDstic += '(전환)';
        	}
        	
    		if(data == 'SM' || data == 'LM' || data == 'MM') {
    			fmtMsgDstic += '문자 - ' + data + "S";
    		} else if(data == 'KM') {
    			fmtMsgDstic += '알림톡';
    		} else if(data == 'SR') {
    			fmtMsgDstic += 'RCS - SMS';
    		} else if(data == 'LR') {
    			fmtMsgDstic += 'RCS - LMS';
    		} else if(data == 'MR') {
    			fmtMsgDstic += 'RCS - MMS';
    		} else if(data == 'TR') {
    			fmtMsgDstic += 'RCS - 템플릿';
    		} else {
    			fmtMsgDstic = '-';
    		}
    		
    		return fmtMsgDstic;
    	}
  	},
    {
  		data: 'telcoInfo', // 이통사
  		"render":function (data, type, row) {
	    	return data != null ? data : "-";
        }
    },
    {
        data: 'rslt', //처리상태구분
        "render":function (data, type, row) {
        	if(data != null) {
        		if(data == '1000') {
        			data = '성공';
        		} else {
        			data = '실패';
        		}
        	} else {
        		data = '-';
        	}
	    	return data;
        }
    },
  ],
  columnDefs: [{
	  
  },
  ]
}