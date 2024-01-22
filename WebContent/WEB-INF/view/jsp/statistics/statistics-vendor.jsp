<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>벤더사별 통계
</h3>
<!-- content -->
<div id="content">
    <!-- Search -->
    <div class="box_search01">
      <ul>
        <li>
			<span class="title02">검색년월</span>
			<span>
				<select class="small searchDate" v-model="searchYear">
					<option v-for="val in year" :value="val" :selected="searchYear == val">{{val}}</option>
				</select>
			</span>
			<span class="text1">년</span>
			<span>
				<select class="small searchDate" v-model="searchMonth">
					<option v-for="val in month" :value="val" :selected="searchMonth == val" >{{val}}</option>
				</select>
			</span>
			<span class="text1">월</span>                
			
			
			<span class="title02 mgl15" style="margin-left: 22px !important;">벤더사</span>
			<span>
				<select style="width:100px;" v-model="vendor">
					<option value="" selected>전체</option>
					<option value="KT">KT</option>
					<option value="LG">LG</option>
				</select>
			</span>
        </li>
      </ul>
      <span class="btn3"><a href="#" class="btn_search" @click="search">조회</a></span>
    </div>
    
    <!-- table list -->
    <div class="table_top">
        <a href="#" class="btn_default blue fr" @click="excelDownload">엑셀다운</a>
   	</div>
   	
    <!-- //Search -->

    <!-- table list -->
    <div class="tbl_wrap_list">
        <table class="tbl_list" id="notice_table" summary="벤더별 통계 테이블 입니다.">
            <colgroup>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
            </colgroup>
            <thead>
            <tr>                
                <th scope="col" rowspan="2">벤더사</th>
                <th scope="col" colspan="2">SMS</th>
                <th scope="col" colspan="3">LMS</th>
                <th scope="col" colspan="2">MMS</th>
                <th scope="col" colspan="2">FAX</th>
                <th scope="col" rowspan="2">이용요금</th>
            </tr>
            <tr>                
                <th scope="col">발송건수</th>
                <th scope="col">금액</th>
                
                <th scope="col">구분</th>
                <th scope="col">발송건수</th>
                <th scope="col">금액</th>
                
                <th scope="col">발송건수</th>
                <th scope="col">금액</th>
                
                <th scope="col">발송건수</th>
                <th scope="col">금액</th>
           	</tr>
            </thead>
            
            <tbody v-for="data, vendor_name in vendor_data">
            	<tr>
            		<td rowspan="3">{{vendor_name}}</td>
            		
            		<td rowspan="3">{{getData(vendor_name, "SM")}}</td>
            		<td rowspan="3">{{getPrice(vendor_name, "SM")}}</td>
            		            		
            		<td>KT</td>
            		<td>{{getData(vendor_name, "LM", "KTF")}}</td>
            		<td>{{getPrice(vendor_name, "LM", "KTF")}}</td>
            		
            		<td>{{getData(vendor_name, "MM", "KTF")}}</td>
            		<td>{{getPrice(vendor_name, "MM", "KTF")}}</td>
            		
            		<td rowspan="3"><span v-if="vendor_name == 'LG'">{{getData(vendor_name, "FX")}}</span><span v-else>-</span></td>
            		<td rowspan="3"><span v-if="vendor_name == 'LG'">{{getPrice(vendor_name, "FX")}}</span><span v-else>-</span></td>
            		
            		<td rowspan="3">-</td>
            	</tr>
            	<tr>
            		<td>LGT</td>
            		<td>{{getData(vendor_name, "LM", "LGT")}}</td>
            		<td>{{getPrice(vendor_name, "LM", "LGT")}}</td>
            		
            		<td>{{getData(vendor_name, "MM", "LGT")}}</td>
            		<td>{{getPrice(vendor_name, "MM", "LGT")}}</td>
            	</tr>
            	<tr>
            		<td>SKT</td>
            		<td>{{getData(vendor_name, "LM", "SKT")}}</td>
            		<td>{{getPrice(vendor_name, "LM", "SKT")}}</td>
            		
            		<td>{{getData(vendor_name, "MM", "SKT")}}</td>
            		<td>{{getPrice(vendor_name, "MM", "SKT")}}</td>
            	</tr>
            	
            	<tr>
            		<td>소계</td>
            		
            		<td>{{getData(vendor_name, "SM")}}</td>
            		<td>{{getPrice(vendor_name, "SM")}}</td>
            		            		
            		<td>-</td>
            		<td>{{getData(vendor_name, "LM")}}</td>
            		<td>{{getPrice(vendor_name, "LM")}}</td>
            		
            		<td>{{getData(vendor_name, "MM")}}</td>
            		<td>{{getPrice(vendor_name, "MM")}}</td>
            		
            		<td><span v-if="vendor_name == 'LG'">{{getData(vendor_name, "FX")}}</span><span v-else>-</span></td>
            		<td><span v-if="vendor_name == 'LG'">{{getPrice(vendor_name, "FX")}}</span><span v-else>-</span></td>
            		
            		<td>{{getPrice(vendor_name)}}</td>
            	</tr>
            </tbody>
            
            <tbody>
            	<tr>
            		<td>합계</td>
            		
            		<td>{{getData(undefined, "SM")}}</td>
            		<td>{{getPrice(undefined,"SM")}}</td>
            		            		
            		<td>-</td>
            		<td>{{getData(undefined, "LM")}}</td>
            		<td>{{getPrice(undefined,"LM")}}</td>
            		
            		<td>{{getData(undefined, "MM")}}</td>
            		<td>{{getPrice(undefined,"MM")}}</td>
            		
            		<td>{{getData(undefined, "FX")}}</td>
            		<td>{{getPrice(undefined,"FX")}}</td>
            		
            		<td>{{getPrice()}}</td>
            	</tr>
            </tbody>
            
        </table>
    </div>
    <!-- //table list -->
    <!-- 페이징 -->
    <div class="paging" id="pagination">
    </div>
    <!-- //페이징 -->
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
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery.filedownload.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/vue.js"></script>
<!-- Script -->
<script>

  $(document).ready(function () {
	  
	  var app = new Vue({
		el: '#content',
		data: {
			searchYear: moment().format("YYYY"),
			searchMonth: moment().format("MM"),
			vendor: "",
			year: [],
			month: [],
			vendor_data: {},
			received_data: [],
			vendor_price_data: {
				"LG": {
					"SM": 0,
					"LM": 0,
					"MM": 0,
					"FX": 0,
				},
				"KT": {
					"SM": 0,
					"LM": 0,
					"MM": 0,
					"FX": 0,
				},
			},
			vendor_order: ["KT", "LG"],
			telco_order: ["KTF", "LGT", "SKT"],
			msg_order: ["SM", "LM", "MM", "FX"],
			telco_type: {},
		},
		methods: {			
			getPriceData: function() {
				var _inst = this;
				$.ajax({
					url: '${pageContext.request.contextPath}/manage-code/발송단가',
					dataType: "json",			
					success: function(json){
						for(var idx in json) {
							var row = json[idx];
							var vendor = row.dsplyNm.split("_")[0];
							var msgDstic = row.dsplyNm.split("_")[1];
														
							_inst.vendor_price_data[vendor][msgDstic]=parseFloat(row.cdValue);
							
							if (msgDstic == "LM") {
								_inst.vendor_price_data[vendor]["MM"]=parseFloat(row.cdValue);
							}
						}
					}
				})
				.done(function(){
				})
				.fail(function(jqXHR, status, error){
				});
			},
			getSendData: function() {
				var _inst = this;
				$.ajax({
					url: '${pageContext.request.contextPath}/statistics-vendor',
					dataType: "json",		
					data: {
						"searchYear": _inst.searchYear,
						"searchMonth": _inst.searchMonth,
						"vendor": _inst.vendor,
					},
					success: function(json){
						_inst.vendor_data = {};
						_inst.telco_type = {};
						
						_inst.received_data = json;
						
						for(var idx in json) {
							var row = json[idx];
							var vendor = row.vendor;
							var msgDstic = row.msgDstic;
							var telcoCode = row.telcoCode;
							var successNumber = row.successNumber;
							
							_inst.telco_type[telcoCode] = telcoCode;
							
							var vendorData = _inst.vendor_data[vendor];
							if (vendorData == undefined) {
								vendorData = {"successNumber":0};
								_inst.vendor_data[vendor] = vendorData;
								
								for(var msg in _inst.msg_order) {
									var msg_name = _inst.msg_order[msg];
									vendorData[msg_name] = {"successNumber":0};
									for(var telco in _inst.telco_order) {
										var telco_name = _inst.telco_order[telco];
										vendorData[msg_name][telco_name] = {"successNumber":0};
									}	
								}
							}
							vendorData.successNumber += successNumber;	
							var msgDsticData = vendorData[msgDstic];
							msgDsticData.successNumber += successNumber;
							var telcoCodeData = msgDsticData[telcoCode];
							telcoCodeData.successNumber += successNumber;
						}
					}
				})
				.done(function(){
				})
				.fail(function(jqXHR, status, error){
				});
			},		
			getData: function(vendor, msgDstic, telco) {
				var ret = 0;
				for(var idx in this.received_data) {
					var row = this.received_data[idx];
					var successNumber = row.successNumber;
					if (vendor != undefined && vendor != row.vendor) {
						continue;
					}
					if (msgDstic != undefined && msgDstic != row.msgDstic) {
						continue;
					}
					if (telco != undefined && telco != row.telcoCode) {
						continue;
					}
					ret += successNumber;
				}

				if (ret == undefined) {
					return "-";
				}
				
				if (ret == 0) {
					return "-";
				}
				
				return $.number(ret);	
			},
			getPrice: function(vendor, msgDstic, telco) {
				var ret = 0;
				for(var idx in this.received_data) {
					var row = this.received_data[idx];
					var successNumber = row.successNumber;
					if (vendor != undefined && vendor != row.vendor) {
						continue;
					}
					if (msgDstic != undefined && msgDstic != row.msgDstic) {
						continue;
					}
					if (telco != undefined && telco != row.telcoCode) {
						continue;
					}
					ret += successNumber * this.vendor_price_data[row.vendor][row.msgDstic];
				}

				if (ret == undefined) {
					return "-";
				}
				
				if (ret == 0) {
					return "-";
				}
				
				return $.number(ret, 2);				
			},
			search: function() {
				this.send_data = {};
				this.getSendData();
			},	
			excelDownload: function() {
				var _inst = this;
				$.fileDownload("${pageContext.request.contextPath}/statistics-vendor-excel.ibk", {
					httpMethod: "POST",
					data: {
						"searchYear": _inst.searchYear,
						"searchMonth": _inst.searchMonth,
						"vendor": _inst.vendor
					},
					successCallback: function (url) {
					},
					failCallback: function(responesHtml, url){
					}
				});				
			}
		},
		created: function () {
			var maxYear = parseInt(moment().format('YYYY'));
			var minYear = parseInt(moment().format('YYYY')) - 10;		    
			for (i = minYear; i <= maxYear; i++) {		      
				this.year.push(i);
			}
		    
			for (i = 1; i <= 12; i++) {
				if (i < 10) {
					temp = '0' + i;
				} else {
					temp = '' + i;
				}
				this.month.push(temp);
			}
			this.getPriceData();
			this.getSendData();
		},
	});
		  

	  $("#zoom-in-btn").on('click', function () {
	    IbkZoom.zoomIn();
	  });
	
	  $("#zoom-out-btn").on('click', function () {
	    IbkZoom.zoomOut();
	  });
	  
  });
</script>
