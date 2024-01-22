<%@ page contentType="text/html;charset=UTF-8" language="java" %>	
<style>
	.ui-datepicker-header {
	    background: #f6f6f6 !important; 
        border-color: #f6f6f6 !important;
	}
	.ui-state-default, 
	.ui-widget-content .ui-state-default, 
	.ui-widget-header .ui-state-default {
		background: #fff !important; 
	}
	.ui-state-active, 
	.ui-widget-content .ui-state-active, 
	.ui-widget-header .ui-state-active {
		background-color: #357ebd !important; 
		border-color: transparent !important;
    	color: #fff !important;
	}
	
	.ui-datepicker,
	.ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button {
		font-family: arial !important;
	}
	
	td.ui-state-default:hover {
		background-color: #eee !important;
  		color: inherit !important;
	}
	
	.cost {
		color: #03c33e;
		font-size: 10px;
	}
	
	.totalCost {
		color: #03c33e;
		font-size: 11px;
	}
	
	.totalDiv {
		display: flex;
	}
	
	.totalDiv > span {
		margin-left: 10%;
		flex: 80%;
	}
	
	.totalDiv > div:first-child {
		text-align: center;
		flex: 240%;
	}
	
	.totalDiv > div:last-child {
		text-align: end;
		flex: 20%;
	}
</style>
<!-- begin page-header -->
<div class="page-header">
	발송 통계
  	<ol class="breadcrumb pull-right"></ol>
</div>
<!-- end page-header -->

<!-- begin Tab -->
<div class="row">
	<ul class="main-tabs">
		<li class="active"><a href="javascript:void(0);" data-toggle="tab" data-id="daily">일별통계</a></li>
    	<li class=""><a href="javascript:void(0);" data-toggle="tab" data-id="monthly">월별통계</a></li>
    	<li class=""><a href="javascript:void(0);" data-toggle="tab" data-id="department"></a></li>
  	</ul>
</div>
<!-- end Tab -->
<!-- begin Search -->
<div class="row">
	<div class="search_area">
    	<div class="search_field">
      		<label>발송구분</label>
      		<div>
        		<select id="sendType">
          			<option value="all">전체</option>
          			<option value="marketing">마케팅</option>
          			<option value="noMarketing">비마케팅</option>
        		</select>
      		</div>
    	</div>
    	<div class="search_field">
      		<label>메시지 유형</label>
      		<div>
        		<select id="msgType">
          			<option value="all">전체</option>
          			<option value="message">문자</option>
          			<option value="kakao">알림톡</option>
          			<option value="rcs">RCS</option>
				</select>
        		<select id="msgTypeDetail" style="width:135px;" disabled>
          			<option value="all">전체</option>
        		</select>
      		</div>
    	</div>
   	</div>
	<div class="search_area">
    	<div class="search_field">
      		<label>기간</label>
      		<small id="dateComment"></small>
			<div>
   				<input type="text" class="form-control date-picker" id="searchDate" value=""/>
   				<input type="text" class="form-control" id="searchStartMonthDate" value="" style="display: none; width:120px;"/>
   				<span id="waveDash" style="display: none;"> ~ </span>
   				<input type="text" class="form-control" id="searchEndMonthDate" value="" style="display: none; width:120px;"/>
      		</div>
    	</div>
    	<div class="search_field">
      		<label>부서</label>
      		<div id="partDiv">
        		<input type="text" id="partInput" name="" class="form-control" value="" style="display:none;" placeholder="부서를 입력하세요" disabled/>
      		</div>
    	</div>
    	<div class="search_field">
	    	<label>등록자</label>
	    	<div id="regDiv">
	    		<input type="text" id="regInput" name="" class="form-control" value="" style="display:none;" placeholder="등록자를 입력하세요" disabled/>
	    	</div>
    	</div>
    	<div class="search_field">
      		<button class="btn btn-reset btn-sm" id="resetBtn" onclick="searchReset();">초기화</button>
      		<button class="btn btn-search btn-sm" id="searchBtn">검색</button>
   		</div>
	</div>
</div>
<!-- end Search  -->

<div class="row clearfix">
	<div class="pull-right">
    	<button class="btn btn-download">엑셀다운로드</button>
  	</div>
</div>

<div class="tab-content">
	<!-- begin 일별통계 -->
	<div id="tab-daily" class="tab-main-content">
		<!-- begin table -->
		<div class="row">
			<div class="table-responsive">
				<table class="table table-hover" id="dailyStatistics_table">
	        		<colgroup>
	          			<col width="90" />
	          			<col width="90" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="90" />
	          			<col width="90 " />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	        		</colgroup>
	        		<thead>
	        			<tr>
	          				<th rowspan="2">발송일</th>
	          				<th rowspan="2">메시지유형</th>
	          				<th colspan="2">발송구분(건수)</th>
	          				<th rowspan="2">전체건수</th>
	          				<th rowspan="2">성공률</th>
	          				<th colspan="3">기본발송</th>
	          				<th colspan="3">전환발송</th>
	        			</tr>
	        			<tr>
	          				<th>마케팅</th>
	          				<th>비마케팅</th>
	          				<th>
	          					성공건 <br>
	          					<span class="cost">금액</span>
	          				</th>
	          				<th>실패건</th>
	          				<th>성공률</th>
	          				<th>
	          					성공건<br>
	          					<span class="cost">금액</span>
	          				</th>
	          				<th>실패건</th>
	          				<th>성공률</th>
	        			</tr>
	        		</thead>
	        		<tbody>
	        			<tr>
	                		<td colspan="12" style="height:200px;">
	                			<div class="nodata"><p>검색 결과가 없습니다.</p></div>
	                		</td>
	            		</tr>
	        		</tbody>
	        		<tfoot>
		        		<tr>
		          			<td colspan="12">
		            			<div class="totalDiv">
		            				<div>
	              						<span class="text-center">기본발송 성공 총 건수 (성공률)</span><br>
	              						<span class="totalCost">금액</span>
	              					</div>
		              				<div>
			              				<span class="pull-right" id="dailyTotalSuccess">0 건 (0%)</span>
		              				</div>
		            			</div>
		          			</td>
		        		</tr>
		        		<tr>
		          			<td colspan="12">
		            			<div class="totalDiv">
		            				<div>
		             					<span class="text-center">전환발송 성공 총 건수 (성공률)</span><br>
		            					<span class="totalCost">금액</span>
		            				</div>
	             					<div>
			            				<span class="pull-right" id="dailyTotalReSuccess">0 건 (0%)</span>
	             					</div>
		            			</div>
		          			</td>
		        		</tr>
		        		<tr>
		          			<td colspan="12">
		           	 			<div class="totalDiv">
            	 					<span class="text-center">총 실패 건수 (실패율)</span>
            	 					<div>
		              					<span class="pull-right" id="dailyTotalFailure">0 건 (0%)</span>
            	 					</div>
		            			</div>
		          			</td>
		        		</tr>
		        		<tr>
		          			<td colspan="12" class="table-total">
		            			<div class="totalDiv">
		             				<span class="text-center"> 총 건수 (총 성공률)</span>
		             				<div>
			              				<span class="pull-right" id="dailyTotalSum">0 건 (0%)</span>
		             				</div>
		            			</div>
		          			</td>
		        		</tr>
	        		</tfoot>
	      		</table>
	    	</div>
		</div>
	</div>
	<!-- end 일별통계 -->
	
	<!-- begin 월별통계 -->
	<div id="tab-monthly" class="tab-main-content hide">
		<!-- begin table -->
	  	<div class="row">
	    	<div class="table-responsive">
	      		<table class="table table-summary" id="monthlyStatistics_topTable">
	        		<colgroup>
	          			<col width="12%" />
	          			<col width="22%" />
	          			<col width="22%" />
	          			<col width="22%" />
	          			<col width="22%" />
	        		</colgroup>
	        		<thead>
	        			<tr>
	          				<th>발송월</th>
	          				<th>
	          					기본발송 성공 총 건수  (성공률)<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>
	          					전환발송 성공  총 건수 (성공률)<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>총 실패 건수 (실패율)</th>
	          				<th>총 건수 ( 총 성공률 )</th>
	        			</tr>
	        		</thead>
	        		<tbody>
	        			<tr>
	                		<td colspan="5" style="height:50px;">
	                			<div class="nodata"><p>검색 결과가 없습니다.</p></div>
	                		</td>
	            		</tr>
	        		</tbody>
				</table>
			</div>
		</div>
	  	<!-- end table -->
	
	  	<!-- begin table -->
	  	<div class="row">
	    	<div class="table-responsive">
	      		<table class="table" id="monthlyStatistics_bottomTable">
	        		<colgroup>
	          			<col width="90" />
	          			<col width="90" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="90" />
	          			<col width="90 " />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
			          	<col width="80" />
			         	<col width="80" />
			          	<col width="80" />
	        		</colgroup>
	        		<thead>
	        			<tr>
	          				<th rowspan="2">발송월</th>
	          				<th rowspan="2">메시지유형</th>
	          				<th colspan="2">발송구분(건수)</th>
	          				<th rowspan="2">전체건수</th>
	          				<th rowspan="2">성공률</th>
	          				<th colspan="3">기본발송</th>
	          				<th colspan="3">전환발송</th>
	        			</tr>
	        			<tr>
	          				<th>마케팅</th>
	          				<th>비마케팅</th>
	          				<th>
	          					성공건<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>실패건</th>
	          				<th>성공률</th>
	          				<th>
	          					성공건<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>실패건</th>
	          				<th>성공률</th>
	        			</tr>
	        		</thead>
	        		<tbody>
		        		<tr>
	                		<td colspan="12" style="height:200px;">
	                			<div class="nodata"><p>검색 결과가 없습니다.</p></div>
	                		</td>
	            		</tr>
	        		</tbody>
	        		<tfoot>
	        			<tr>
	          				<td colspan="12">
	            				<div class="totalDiv">
	            					<div>
              							<span class="text-center">기본발송 성공 총 건수 (성공률)</span><br>
              							<span class="totalCost">금액</span>
              						</div>
	             					<div>
	              						<span class="pull-right" id="monthlyTotalSuccess">0 건 (0%)</span>
	              					</div>
	            				</div>
	          				</td>
	        			</tr>
	        			<tr>
	          				<td colspan="12">
	            				<div class="totalDiv">
              						<div>
              							<span class="text-center">전환발송 성공 총 건수 (성공률)</span><br>
              							<span class="totalCost">금액</span>
              						</div>
              						<div>
	              						<span class="pull-right" id="monthlyTotalReSuccess">0 건 (0%)</span>
	              					</div>
	            				</div>
	          				</td>
	        			</tr>
	        			<tr>
	          				<td colspan="12">
	            				<div class="totalDiv">
	              					<span class="text-center">총 실패 건수 (실패율)</span>
	              					<div>
		              					<span class="pull-right" id="monthlyTotalFailure">0 건 (0%)</span>
	              					</div>
	            				</div>
	          				</td>
	        			</tr>
	        			<tr>
	          				<td colspan="12" class="table-total">
	            				<div class="totalDiv">
	              					<span class="text-center">총 건수 (총 성공률)</span>
	              					<div>
		              					<span class="pull-right" id="monthlyTotalSum">0 건 (0%)</span>
	              					</div>
	            				</div>
	          				</td>
	        			</tr>
	        		</tfoot>
				</table>
			</div>
		</div>
	  	<!-- end table -->
	</div>
	<!-- end 월별통계 -->
	
	<!-- begin 부서통계 -->
	<div id="tab-department" class="tab-main-content hide">
		<!-- begin table -->
	  	<div class="row">
	    	<div class="table-responsive">
	      		<table class="table table-summary" id="departmentStatistics_topTable">
	        		<colgroup>
	          			<col width="10%" />
	          			<col width="18%" />
	          			<col width="18%" />
	          			<col width="18%" />
	          			<col width="18%" />
	          			<col width="18%" />
	        		</colgroup>
	        		<thead>
	        			<tr>
	          				<th>발송월</th>
	          				<th>부서별</th>
	          				<th>
								기본발송 성공 총 건수(성공률)<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>
	          					전환발송 성공 총 건수(성공률)<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>총 실패 건수(실패율)</th>
	          				<th>총 건수(총 성공률)</th>
	        			</tr>
	        		</thead>
	        		<tbody>
	        			<tr>
	                		<td colspan="12" style="height:50px;">
	                			<div class="nodata"><p>검색 결과가 없습니다.</p></div>
	                		</td>
	            		</tr>
	        		</tbody>
	      		</table>
	    	</div>
	  	</div>
	  	<!-- end table -->
	
	  	<!-- begin table -->
	  	<div class="row">
	    	<div class="table-responsive">
	      		<table class="table" id="departmentStatistics_bottomTable">
	        		<colgroup>
	          			<col width="90" />
	          			<col width="90" />
	          			<col width="90" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="90" />
	          			<col width="90" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	          			<col width="80" />
	        		</colgroup>
	        		<thead>
	        			<tr>
	          				<th rowspan="2">발송월</th>
	          				<th rowspan="2">부서</th>
	          				<th rowspan="2">메시지유형</th>
	          				<th colspan="2">발송구분(건수)</th>
	          				<th rowspan="2">전체건수</th>
	          				<th rowspan="2">성공률</th>
	          				<th colspan="3">기본발송</th>
	          				<th colspan="3">전환발송</th>
	        			</tr>
	        			<tr>
	          				<th>마케팅</th>
	          				<th>비마케팅</th>
	          				<th>
	          					성공건<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>실패건</th>
	          				<th>성공률</th>
	          				<th>
	          					성공건<br>
	          					<span class="cost">금액</span>	
	          				</th>
	          				<th>실패건</th>
	          				<th>성공률</th>
	        			</tr>
	        		</thead>
	        		<tbody>
	        			<tr>
	                		<td colspan="13" style="height:200px;">
	                			<div class="nodata"><p>검색 결과가 없습니다.</p></div>
	                		</td>
	            		</tr>
	        		</tbody>
	        		<tfoot>
		        		<tr>
		          			<td colspan="13">
		            			<div class="totalDiv">
		              				<div>
	              						<span class="text-center">기본발송 성공 총 건수 (성공률)</span><br>
	              						<span class="totalCost">금액</span>
	              					</div>
		              				<div>
		              					<span class="pull-right" id="departmentTotalSuccess">0 건 (0%)</span>
		              				</div>
		            			</div>
		          			</td>
		        		</tr>
		        		<tr>
		          			<td colspan="13">
		            			<div class="totalDiv">
		              				<div>
	              						<span class="text-center">전환발송 성공 총 건수 (성공률)</span><br>
	              						<span class="totalCost">금액</span>
	              					</div>
		              				<div>
		              					<span class="pull-right" id="departmentTotalReSuccess">0 건 (0%)</span>
		              				</div>
		            			</div>
		          			</td>
		        		</tr>
		        		<tr>
		          			<td colspan="13">
		            			<div class="totalDiv">
		              				<span class="text-center">총 실패 건수 (실패율)</span>
		              				<div>
		              					<span class="pull-right" id="departmentTotalFailure">0 건 (0%)</span>
		              				</div>
		            			</div>
		          			</td>
		        		</tr>
		        		<tr>
		          			<td colspan="13" class="table-total">
		            			<div class="totalDiv">
		              				<span class="text-center">총 건수 (총 성공률)</span>
		              				<div>
		              					<span class="pull-right" id="departmentTotalSum">0 건 (0%)</span>
		              				</div>
		            			</div>
		          			</td>
		        		</tr>
	        		</tfoot>
	      		</table>
	    	</div>
	  	</div>
	  	<!-- end table -->
	</div>
	<!-- end 부서별통계 --> 
</div>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkValidation.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkInitData.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkDatepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/IbkDatatables-new.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/datatable-column/dailyStatistics-column.js"></script>
<script type="text/javascript" 
		src="${pageContext.request.contextPath}/static/js/jquery.filedownload.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/v2/js/jquery.mtz.monthpicker.js"></script>
<script type="text/javascript">
	var tabActive = $(".main-tabs").find(".active a").data("id");
	var requestParam = {
		statisticsType: tabActive
	};
	
	$(document).ready(function() {
		// 초기값 세팅	
		init();

	 	// 탭 클릭 이벤트
 		$(".main-tabs a[data-toggle='tab']").click(function() {
			var bodyHtml = '';
			var topBodyHtml = '';

			// 탭 활성화
     		$(this).parents().closest('ul').last().find('li.active').removeClass('active')
	     	$(this).parent().addClass('active')
	     	$('.tab-main-content').hide();
	     	$('#tab-'+$(this).data('id')).show();

	     	tabActive = $(this).data('id');
	     	
	     	if(tabActive == 'daily') {
		     	// 일별통계 기간 검색조건 초기화
	 	     	$("#searchDate").show();
	 	     	$("#searchStartMonthDate").hide();
	 	     	$("#searchEndMonthDate").hide();
	 	     	$("#waveDash").hide();
	 	     	$("#dateComment").html("");

				// 테이블 초기화	
	 	     	bodyHtml = '<tr><td colspan="12" style="height:200px;"><div class="nodata"><p>검색 결과가 없습니다.</p></div></td></tr>';
	 	     	$("#dailyStatistics_table").find('tbody').empty();
	 	     	$("#dailyStatistics_table").find('tbody').append(bodyHtml);	 	     	

	 	    	// 통계 상세 list 총 건수 html 초기화
	 	     	resetTotalBottomHtml('daily');
		    } else {
		    	// 월별/부서별 통계 기간 검색조건 초기화
		    	$("#searchDate").hide();
	 	     	$("#searchStartMonthDate").show();
	 	     	$("#searchEndMonthDate").show();
	 	     	$("#waveDash").show();
	 	     	$("#dateComment").html("최대  3개월 조회 가능");
	 	     	
				if(tabActive == 'monthly') {
					// 월별 통계 테이블 초기화
					bodyHtml = '<tr><td colspan="12" style="height:200px;"><div class="nodata"><p>검색 결과가 없습니다.</p></div></td></tr>';

					$("#monthlyStatistics_bottomTable").find('tbody').empty();
		 	     	$("#monthlyStatistics_bottomTable").find('tbody').append(bodyHtml);	

		 	     	bodyHtml = '<tr><td colspan="5" style="height:50px;"><div class="nodata"><p>검색 결과가 없습니다.</p></div></td></tr>';

					$("#monthlyStatistics_topTable").find('tbody').empty();
		 	     	$("#monthlyStatistics_topTable").find('tbody').append(bodyHtml);	

		 	   		// 통계 상세 list 총 건수 html 초기화
		 	     	resetTotalBottomHtml('monthly');
				} else {
					// 부서별 통계 테이블 초기화
					bodyHtml = '<tr><td colspan="13" style="height:200px;"><div class="nodata"><p>검색 결과가 없습니다.</p></div></td></tr>';

					$("#departmentStatistics_bottomTable").find('tbody').empty();
		 	     	$("#departmentStatistics_bottomTable").find('tbody').append(bodyHtml);	

		 	     	bodyHtml = '<tr><td colspan="12" style="height:50px;"><div class="nodata"><p>검색 결과가 없습니다.</p></div></td></tr>';

					$("#departmentStatistics_topTable").find('tbody').empty();
		 	     	$("#departmentStatistics_topTable").find('tbody').append(bodyHtml);	

		 	    	// 통계 상세 list 총 건수 html 초기화
		 	     	resetTotalBottomHtml('department');
				}
		    }

			// 검색조건 초기화
	     	searchReset();

	     	// 기존 요청param 데이터 초기화
	     	requestParam = {};
	     	requestParam["statisticsType"] = tabActive;
	 	});
	});

	// 메시지 유형 변경 이벤트
	$("#msgType").change(function() {
		var val = $(this).val();
		var html = '';

		$("#msgTypeDetail").empty();
		
		if(val == "message") {			// 메시지 유형이 '문자'일 때
			html += '<option value="all">전체</option>'
	            + '<option value="SM">SMS</option>'
	            + '<option value="LM">LMS</option>'
	            + '<option value="MM">MMS</option>';
	            
	    	$("#msgTypeDetail").html(html);
	    	$("#msgTypeDetail").attr("disabled", false);
		} else if(val == "kakao") {		// 메시지 유형이 '알림톡'일 때 
			html += '<option value="KM">전체</option>';
			
			$("#msgTypeDetail").html(html);
			$("#msgTypeDetail").attr("disabled", true);
		} else if(val == "rcs") {		// 메시지 유형이 'RCS'일 때
			html += '<option value="all">전체</option>'
	            + '<option value="SR">SMS</option>'
	            + '<option value="LR">LMS</option>'
	            + '<option value="MR">MMS</option>'

			$("#msgTypeDetail").html(html);
	    	$("#msgTypeDetail").attr("disabled", false);
		} else {
			html += '<option value="all">전체</option>';
			
			$("#msgTypeDetail").html(html);
			$("#msgTypeDetail").attr("disabled", true);
		}
	});

	// 조회 버튼 클릭 이벤트
	$("#searchBtn").click(function () {
		// 기간 유효성 체크
		if(!searchDateValidate()) {
			return false;
		};

		// 요청 param 셋팅
		setRequestParam();
		// 통계 조회
		selectStatisticsAjax();
	});

	// 엑셀다운로드 클릭 이벤트
	$(".btn-download").click(function() {
		$.fileDownload("${pageContext.request.contextPath}/campaign/sendStatisticsExcelDownload", {
            httpMethod: "POST",
            data: requestParam,
            successCallback: function (url) {
            },
            failCallback: function (responesHtml, url) {
            }
        });
	});

	// 기간 유효성 체크
	function searchDateValidate() {
		var searchDate 				= '';	
		var searchStartMonthDate 	= '';
		var searchEndMonthDate 		= '';
		var startFmtDt 				= '';
		var endFmtDt 				= '';

		var stYear	= '';
		var stMonth = '';
		var stDay	= '';

		var edYear	= '';
		var edMonth = '';
		var edDay	= '';
		
		var stDate 		= null;
		var edDate		= null;
		var rsltDate 	= null;
		
		if(tabActive == 'daily') {
			searchDate 	= $("#searchDate").val();
			var dateArr = searchDate.split(" ~ ");
			startFmtDt 	= str.replace(dateArr[0], "-", "");
			endFmtDt 	= str.replace(dateArr[1], "-", "");

			stYear 	= startFmtDt.substr(0,4);
			stMonth = startFmtDt.substr(4,2)-1;
			stDay 	= startFmtDt.substr(6,2);
			stDate	= new Date(stYear, stMonth, stDay);

			edYear 	= endFmtDt.substr(0,4);
			edMonth = endFmtDt.substr(4,2)-1;
			edDay 	= endFmtDt.substr(6,2);
			edDate	= new Date(edYear, edMonth, edDay); 

			rsltDate = (Date.parse(edDate)-Date.parse(stDate))/(1000*60*60*24);
			
		} else if(tabActive == 'monthly' || tabActive == 'department') {
			searchStartMonthDate 	= $("#searchStartMonthDate").val();	
			searchEndMonthDate 		= $("#searchEndMonthDate").val();
			startFmtDt 				= str.replace(searchStartMonthDate, "-", "");
			endFmtDt 				= str.replace(searchEndMonthDate, "-", "");

			stYear 	= startFmtDt.substr(0,4);
			stMonth = startFmtDt.substr(4,2)-1;
			stDate	= new Date(stYear, stMonth);

			edYear 	= endFmtDt.substr(0,4);
			edMonth = endFmtDt.substr(4,2)-1;
			edDate	= new Date(edYear, edMonth);

			rsltDate = (Date.parse(edDate)-Date.parse(stDate))/(1000*60*60*24);

			if(rsltDate > 62) {
				sweet.alert('조회기간은 최대 3개월입니다.');
				dateInit();

				return false;
			}
		}

		if(rsltDate < 0) {
			sweet.alert('시작일은 종료일보다 작아야합니다.');
			dateInit();

			return false;
		}
		return true;
	}

	// 요청 param 셋팅
	function setRequestParam() {
		var searchDate = '';	
		var stMonthDate = '';
		var edMonthDate = '';
		if(tabActive == 'daily' ) {
			searchDate = $("#searchDate").val();
			var dateArr = searchDate.split(" ~ ");
		} else if(tabActive == 'monthly'|| tabActive == 'department'){
			stMonthDate = $("#searchStartMonthDate").val();
			edMonthDate = $("#searchEndMonthDate").val();
			searchDate = $("#searchStartMonthDate").val();
		}
		
		var data = {
  			messageType 		: $("#msgType").val(),
  			messageTypeDetail 	: $("#msgTypeDetail").val(),
			sendType 			: $("#sendType").val(),
			partNm 				: $("#partInput").val(),
			regNm 				: $("#regInput").val(),
			statisticsType		: tabActive
  		};

		if(tabActive == 'daily') {
			data["searchStartDt"] = str.replace(dateArr[0], "-", "");
			data["searchEndDt"] = str.replace(dateArr[1], "-", "");
		} else if(tabActive == 'monthly' || tabActive == 'department') {
			data["searchStartDt"] = str.replace(stMonthDate, "-", "");
			data["searchEndDt"] = str.replace(edMonthDate, "-", "") + "31";
		}

		requestParam = data;
	}

	// 초기값 세팅
  	function init() {
  		roleInit();		// 권한별 메뉴 초기값 세팅
		dateInit();		// 날짜 초기값 세팅
  	}

  	// 통계 조회
  	function selectStatisticsAjax() {
  		$.ajax({
  	        url: '${pageContext.request.contextPath}/campaign/sendStatisticsList',
  	      	type: "POST",
  	        contentType: "application/json; charset=utf-8",
  	        data: JSON.stringify(requestParam),
  	  	}).done(function(result){
				var statisticsList = result.statisticsList;		// 일별/월별/부서별 통계 상세 list 데이터
				var totalCount = result.totalCount;				// 통계 list total갯수
				var totalCountGroupByMonth = result.totalCountGroupByMonth;				// 월별통계 list
				var totalCountGroupByDepartment = result.totalCountGroupByDepartment;	// 부서별통계 list
				var tbodyHtml = '';
				var topTbodyHtml = '';
				var totalSuccess = '';
				var totalFailure = '';
				var totalSum = '';
				
				if(statisticsList != null) {
					// 통계 상세 list 데이터 세팅
					if(statisticsList.length > 0) {
						var mergeCnt = 0;
						for(var i=0; i < statisticsList.length; i++) {
							if(requestParam.statisticsType == 'department') {	// 부서별 통계일 때
								tbodyHtml += '<tr>';
								tbodyHtml += 	'<td class="departmentStatistics_bottomTable_td">'+ isEmptyFmtData(str.getYyyymmddFmt(statisticsList[i].standardYmd, '-')) +'</td>';
								tbodyHtml += 	'<td class="text-left">'+ isEmptyFmtData(statisticsList[i].groupValue2) +'</td>';
								tbodyHtml += 	'<td>'+ isEmptyFmtData(fmtMsgDstic(statisticsList[i].msgDstic)) +'</td>';
								tbodyHtml += 	'<td class="text-right">'+ (statisticsList[i].marketingCnt > 0 ? str.comma(statisticsList[i].marketingCnt) : "-") +'</td>';
								tbodyHtml += 	'<td class="text-right">'+ (statisticsList[i].noMarketingCnt > 0 ? str.comma(statisticsList[i].noMarketingCnt) : "-") +'</td>';
								tbodyHtml += 	'<td class="text-right bg-blue">'+ str.comma(statisticsList[i].totalSendNumber) +'</td>';
								tbodyHtml += 	'<td class="text-right bg-blue">'+ statisticsList[i].totalSuccessPercent +'%</td>';
								tbodyHtml += 	'<td class="text-right bg-yellow">'+ str.comma(statisticsList[i].successNumber) +'<br>'
													+'<span class="cost">₩'+ str.comma(statisticsList[i].successCost) +'</span>'+'</td>';
								tbodyHtml += 	'<td class="text-right bg-yellow">'+ str.comma(statisticsList[i].failureNumber) +'</td>';
								tbodyHtml += 	'<td class="text-right">'+ statisticsList[i].successPercent +'%</td>';

								// 기본발송의 실패건이 있을 경우
								if(statisticsList[i].failureNumber > 0) {
									tbodyHtml += 	'<td class="text-right">'+ str.comma(statisticsList[i].reSuccessNumber) +'<br>'
														+'<span class="cost">₩'+ str.comma(statisticsList[i].reSuccessCost) +'</span>'+'</td>';
									tbodyHtml += 	'<td class="text-right">'+ str.comma(statisticsList[i].reFailureNumber) +'</td>';
									tbodyHtml += 	'<td class="text-right">'+ statisticsList[i].reSuccessPercent +'%</td>';
								} else {
									tbodyHtml += 	'<td class="text-right">-</td>';
									tbodyHtml += 	'<td class="text-right">-</td>';
									tbodyHtml += 	'<td class="text-right">-</td>';
								}
								
								tbodyHtml += '</tr>';

							} else {	// 일별/월별 통계일 때
								tbodyHtml += '<tr>';
								if(requestParam.statisticsType == 'monthly') {
									tbodyHtml += 	'<td class="monthlyStatistics_bottomTable_td">'+ isEmptyFmtData(str.getYyyymmddFmt(statisticsList[i].standardYmd, '-')) +'</td>';
								} else if(requestParam.statisticsType == 'daily') {
									tbodyHtml += 	'<td class="dailyStatistics_table_td">'+ isEmptyFmtData(str.getYyyymmddFmt(statisticsList[i].standardYmd, '-')) +'</td>';
								}
								tbodyHtml += 	'<td>'+ isEmptyFmtData(fmtMsgDstic(statisticsList[i].msgDstic)) +'</td>';
								tbodyHtml += 	'<td class="text-right">'+ (statisticsList[i].marketingCnt > 0 ? str.comma(statisticsList[i].marketingCnt) : "-") +'</td>';
								tbodyHtml += 	'<td class="text-right">'+ (statisticsList[i].noMarketingCnt > 0 ? str.comma(statisticsList[i].noMarketingCnt) : "-") +'</td>';
								tbodyHtml += 	'<td class="text-right bg-blue">'+ isEmptyFmtData(str.comma(statisticsList[i].totalSendNumber)) +'</td>';
								tbodyHtml += 	'<td class="text-right bg-blue">'+ isEmptyFmtData(statisticsList[i].totalSuccessPercent) +'%</td>';
								tbodyHtml += 	'<td class="text-right bg-yellow">'+ isEmptyFmtData(str.comma(statisticsList[i].successNumber)) +'<br>'
													+'<span class="cost">₩'+ isEmptyFmtData(str.comma(statisticsList[i].successCost)) +'</span>'+'</td>';
								tbodyHtml += 	'<td class="text-right bg-yellow">'+ isEmptyFmtData(str.comma(statisticsList[i].failureNumber)) +'</td>';
								tbodyHtml += 	'<td class="text-right">'+ isEmptyFmtData(statisticsList[i].successPercent) +'%</td>';

								// 기본발송의 실패건이 있을 경우
								if(statisticsList[i].failureNumber > 0) {
									tbodyHtml += 	'<td class="text-right">'+ isEmptyFmtData(str.comma(statisticsList[i].reSuccessNumber)) +'<br>'
														+'<span class="cost">₩'+ str.comma(statisticsList[i].reSuccessCost) +'</span>'+'</td>';
									tbodyHtml += 	'<td class="text-right">'+ isEmptyFmtData(str.comma(statisticsList[i].reFailureNumber)) +'</td>';
									tbodyHtml += 	'<td class="text-right">'+ isEmptyFmtData(statisticsList[i].reSuccessPercent) +'%</td>';
								} else {
									tbodyHtml += 	'<td class="text-right">-</td>';
									tbodyHtml += 	'<td class="text-right">-</td>';
									tbodyHtml += 	'<td class="text-right">-</td>';
								}
								
								tbodyHtml += '</tr>';
							}
						}

						
						if(totalCountGroupByMonth.length > 0) {		// 월별통계일 때
							for(var i=0; i < totalCountGroupByMonth.length; i++) {
								topTbodyHtml += '<tr>';
								topTbodyHtml += 	'<td class="monthlyStatistics_topTable_td">'+ isEmptyFmtData(str.getYyyymmddFmt(totalCountGroupByMonth[i].standardYmd, '-')) +'</td>';
								topTbodyHtml += 	'<td class="text-right">'+ str.comma(totalCountGroupByMonth[i].monthSuccessNumber) 
															+ ' 건 (' + totalCountGroupByMonth[i].monthSuccessPercent + '%)'+'<br>'
															+'<span class="totalCost">₩'+ str.comma(totalCountGroupByMonth[i].successCost) +'</span>'+'</td>';
								topTbodyHtml += 	'<td class="text-right">'+ str.comma(totalCountGroupByMonth[i].monthReSuccessNumber)
															+ ' 건 (' + totalCountGroupByMonth[i].monthReSuccessPercent + '%)'+'<br>'
															+'<span class="totalCost">₩'+ str.comma(totalCountGroupByMonth[i].reSuccessCost) +'</span>'+'</td>';
								topTbodyHtml += 	'<td class="text-right">'+ str.comma(totalCountGroupByMonth[i].monthFailureNumber)
															+ ' 건 (' + totalCountGroupByMonth[i].monthFailurePercent + '%)</td>';
								topTbodyHtml += 	'<td class="text-right font-weight-bold">'+ str.comma(totalCountGroupByMonth[i].monthSendNumber) 
															+ ' 건 (' + totalCountGroupByMonth[i].monthPercent + '%)'+'</td>';
								topTbodyHtml += '</tr>';
							}
						} else if(totalCountGroupByDepartment.length > 0) {		// 부서별통계일 때
							for(var i=0; i < totalCountGroupByDepartment.length; i++) {
								topTbodyHtml += '<tr>';
								topTbodyHtml += 	'<td class="departmentStatistics_topTable_td">'+ isEmptyFmtData(str.getYyyymmddFmt(totalCountGroupByDepartment[i].standardYmd, '-')) +'</td>';
								topTbodyHtml += 	'<td class="text-left">'+ isEmptyFmtData(totalCountGroupByDepartment[i].groupValue2) +'</td>';
								topTbodyHtml += 	'<td class="text-right">'+ str.comma(totalCountGroupByDepartment[i].departmentSuccessNumber) 
															+ ' 건 (' + totalCountGroupByDepartment[i].departmentSuccessPercent + '%)'+'<br>'
															+ '<span class="totalCost">₩'+ str.comma(totalCountGroupByDepartment[i].successCost) +'</span>'+'</td>';
								topTbodyHtml += 	'<td class="text-right">'+ str.comma(totalCountGroupByDepartment[i].departmentReSuccessNumber) 
															+ ' 건 (' + totalCountGroupByDepartment[i].departmentReSuccessPercent + '%)'+'<br>'
															+ '<span class="totalCost">₩'+ str.comma(totalCountGroupByDepartment[i].reSuccessCost) +'</span>'+'</td>';
								topTbodyHtml += 	'<td class="text-right">'+ totalCountGroupByDepartment[i].departmentFailureNumber 
															+ ' 건 (' + totalCountGroupByDepartment[i].departmentFailurePercent + '%)</td>';
								topTbodyHtml += 	'<td class="text-right">'+ str.comma(totalCountGroupByDepartment[i].departmentSendNumber) 
															+ ' 건 (' + totalCountGroupByDepartment[i].departmentPercent + '%)'+'</td>';
								topTbodyHtml += '</tr>';
							}
						}

						totalSuccess 	= isEmptyFmtData(str.comma(totalCount.totalSuccessNumber)) + " 건 (" + isEmptyFmtData(totalCount.totalSuccessPercent) + "%)";
						totalReSuccess 	= isEmptyFmtData(str.comma(totalCount.totalReSuccessNumber)) + " 건 (" + isEmptyFmtData(totalCount.totalReSuccessPercent) + "%)";
						totalFailure 	= isEmptyFmtData(str.comma(totalCount.totalFailureNumber)) + " 건 (" + isEmptyFmtData(totalCount.totalFailurePercent) + "%)";
						totalSum 		= isEmptyFmtData(str.comma(totalCount.totalSendNumber)) + " 건 (" + isEmptyFmtData(totalCount.totalPercent) + "%)";
					} else {	// 상세 통계 list 데이터가 없을 때
						tbodyHtml += '<tr>';
						topTbodyHtml += '<tr>';
						
						if(requestParam.statisticsType == 'department') {	// 부서통계일 때
							tbodyHtml += '<td colspan="13" style="height:200px;">';
							topTbodyHtml += '<td colspan="6" style="height:50px;">';
						} else {	// 월별통계일 때
							tbodyHtml += '<td colspan="12" style="height:200px;">';
							topTbodyHtml += '<td colspan="5" style="height:50px;">';
						}
						topTbodyHtml += '<div class="nodata"><p>검색 결과가 없습니다.</p></div>';
						topTbodyHtml += '</td>';
						topTbodyHtml += '</tr>';

						tbodyHtml += '<div class="nodata"><p>검색 결과가 없습니다.</p></div>';
						tbodyHtml += '</td>';
						tbodyHtml += '</tr>';

						totalSuccess = "0 건 (0%)";
						totalReSuccess = "0 건 (0%)";
						totalFailure = "0 건 (0%)";
						totalSum = "0 건 (0%)";
					}

					// html 데이터 셋팅
					if(requestParam.statisticsType == 'daily') {	// 일별통계일 때
						$("#dailyStatistics_table tbody").html(tbodyHtml);
						$("#dailyTotalSuccess").html(totalSuccess);
						$("#dailyTotalReSuccess").html(totalReSuccess);
						$("#dailyTotalFailure").html(totalFailure);
						$("#dailyTotalSum").html(totalSum);

						// 기존의 기본/전환 발송 성공 총 건수 금액 초기화 
						$("#dailyTotalSuccess").nextAll().remove();
						$("#dailyTotalReSuccess").nextAll().remove();

						// 통계 상세 list가 있을 시, 기본/전환 발송 성공 총 건수에 금액 표시
						if(statisticsList.length > 0) {
							$("#dailyTotalSuccess").after('<br><span class="totalCost">₩'+str.comma(totalCount.successCost)+'</span>');
							$("#dailyTotalReSuccess").after('<br><span class="totalCost">₩'+str.comma(totalCount.reSuccessCost)+'</span>');
						}

						// 테이블 머지 세팅
						setRowspan("dailyStatistics_table");
					} else if(requestParam.statisticsType == 'monthly') {	// 월별통계일 때
						$("#monthlyStatistics_bottomTable tbody").html(tbodyHtml);
						$("#monthlyTotalSuccess").html(totalSuccess);
						$("#monthlyTotalReSuccess").html(totalReSuccess);
						$("#monthlyTotalFailure").html(totalFailure);
						$("#monthlyTotalSum").html(totalSum);
						$("#monthlyStatistics_topTable tbody").html(topTbodyHtml);

						// 기존의 기본/전환 발송 성공 총 건수 금액 초기화 
						$("#monthlyTotalSuccess").nextAll().remove();
						$("#monthlyTotalReSuccess").nextAll().remove();

						// 통계 상세 list가 있을 시, 기본/전환 발송 성공 총 건수에 금액 표시
						if(statisticsList.length > 0) {
							$("#monthlyTotalSuccess").after('<br><span class="totalCost">₩'+str.comma(totalCount.successCost)+'</span>');
							$("#monthlyTotalReSuccess").after('<br><span class="totalCost">₩'+str.comma(totalCount.reSuccessCost)+'</span>');
						}
						
						// 테이블 머지 세팅
						setRowspan("monthlyStatistics_bottomTable");
						setRowspan("monthlyStatistics_topTable");
					} else if(requestParam.statisticsType == 'department') {
						$("#departmentStatistics_bottomTable tbody").html(tbodyHtml);
						$("#departmentTotalSuccess").html(totalSuccess);
						$("#departmentTotalReSuccess").html(totalReSuccess);
						$("#departmentTotalFailure").html(totalFailure);
						$("#departmentTotalSum").html(totalSum);
						$("#departmentStatistics_topTable tbody").html(topTbodyHtml);

						// 기존의 기본/전환 발송 성공 총 건수 금액 초기화 
						$("#departmentTotalSuccess").nextAll().remove();
						$("#departmentTotalReSuccess").nextAll().remove();

						// 통계 상세 list가 있을 시, 기본/전환 발송 성공 총 건수에 금액 표시
						if(statisticsList.length > 0) {
							$("#departmentTotalSuccess").after('<br><span class="totalCost">₩'+str.comma(totalCount.successCost)+'</span>');
							$("#departmentTotalReSuccess").after('<br><span class="totalCost">₩'+str.comma(totalCount.reSuccessCost)+'</span>');
						}

						// 테이블 머지 세팅
						setRowspan("departmentStatistics_bottomTable");
						setRowspan("departmentStatistics_topTable");
					}
				}
    	}).fail(function(xhr){
    	});
  	}

  	// 메시지 타입 포맷
  	function fmtMsgDstic(msgDstic) {
        if(msgDstic == 'SM' || msgDstic == 'LM' || msgDstic == 'MM') {
        	msgDstic = "문자 - " + msgDstic + "S";
		} else if(msgDstic == 'KM') {
			msgDstic = '알림톡';
		} else if(msgDstic == 'SR') {
			msgDstic = 'RCS - SMS';
		} else if(msgDstic == 'LR') {
			msgDstic = 'RCS - LMS';
		} else if(msgDstic == 'MR') {
			msgDstic = 'RCS - MMS';
		} else if(msgDstic == 'TR') {
			msgDstic = 'RCS - 템플릿';
		}
		
		return msgDstic;
  	}

  	// 빈값 포맷
  	function isEmptyFmtData(data) {
  		if(data == null || data == "" || data == "undefined") {
  			data = "-";
  		}
  		return data;
  	}

 	// 권한별 메뉴 초기값 세팅
  	function roleInit() {
  		var userLevel = '${headerInfo.userLevel}';
  		var partName = '${headerInfo.partName}';
  		var emplName = '${headerInfo.emplName}';
  		var partHtml = '';

  		//userLevel = 'N';  사용자

  		// 관리자 일 때
  		if(userLevel == 'A') {
  			$("#partInput").attr("disabled", false); 
  			$("#regInput").attr("disabled", false); 
  			$("#partInput").show();
  			$("#regInput").show();
  			$('[data-id="department"]').html("부서별통계");
  		} else if(userLevel == 'N'){
  			$("#partInput").val(partName);
  			$("#regInput").val(emplName);
  			$("#partInput").show();
  			$("#regInput").show();
  			$('[data-id="department"]').html("부서통계");
  		}
  	}

 	// 날짜 초기값 세팅
  	function dateInit() {
  		moment.locale('ko'); // 한글 셋팅
  		var date = new Date();
  		var firstDay = dateFunc.getLastWeek();	// 1주일 전 날짜
  		var lastDay = dateFunc.getToday();		// 오늘 날짜
  		var year = date.getFullYear(); 			// 년도
  		var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1); // 월

		if(tabActive == 'daily') {
			$('.date-picker').daterangepicker({
	  			locale :{
	  				format: 'YYYY-MM-DD',
	  				separator: ' ~ ',
	  				applyLabel: "적용",
	  				cancelLabel: "닫기"
	  			},
	  			"startDate": lastDay,
	  			"endDate": lastDay
	  		});
		} else if(tabActive == 'monthly' || tabActive == 'department') {
			// monthPicker 값 셋팅
			setMonthPicker("searchStartMonthDate", year, month);
			setMonthPicker("searchEndMonthDate", year, month);

			// monthPicker 활성화, 년도 초기화
			$('.mtz-monthpicker-year').val(year).prop("selected", true);
			$('td[data-month]').removeClass('ui-state-active');
			$('td[data-month="'+month+'"]').addClass('ui-state-active');
		}
  	}

 	// 검색 초기화
  	function searchReset() {
  	   	$("#msgType").val('all');			// 메시지 유형 초기화
  	   	$("#dateSelect").val('regDate');	// 기간 초기화
  	  	$("#sendType").val('all');			// 발송구분 초기화
  	   	
  	   	// 메시지유형 상세 초기화
  	   	$("#msgTypeDetail").children('option:not(:first)').remove();
  	   	$("#msgTypeDetail").val('all');
  	   	$("#msgTypeDetail").attr("disabled", true);

  	  	$("#partInput").val('');
     	$("#regInput").val('');
     	
  	   	// 초기값 세팅
  	   	init();
  	}

 	// 테이블 머지 세팅
  	function setRowspan(tableNm) {	
		var tableTd = tableNm + "_td";

		$("#" + tableNm + " ." + tableTd).each(function() {
			var rows = $("."+ tableTd + ":contains('" + $(this).text() +"')");
			if(rows.length > 1) {
				rows.eq(0).attr("rowspan", rows.length);
				rows.not(":eq(0)").remove();
			}
		})	
  	}

 	// monthPicker 데이터 셋팅
  	function setMonthPicker(id, year, month) {
  		$("#" + id).monthpicker({
			pattern: 'yyyy-mm',
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월',
				'7월', '8월', '9월', '10월', '11월', '12월'],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', 
				'11월', '12월'],
			selectedYear: year,
			selectedMonth: month,
  	  	});

		$("#" + id).val(year + "-" + month);
  	}

 	// 통계 상세 list 총 건수 html 초기화
  	function resetTotalBottomHtml(id) {
  		var totalBottomHtml = '0 건 (0%)';
  		
  		$("#" + id + "TotalSuccess").html(totalBottomHtml);
     	$("#" + id + "TotalSuccess").nextAll().empty();
     	$("#" + id + "TotalReSuccess").html(totalBottomHtml);
     	$("#" + id + "TotalReSuccess").nextAll().empty();
     	$("#" + id + "TotalFailure").html(totalBottomHtml);
     	$("#" + id + "TotalFailure").nextAll().empty();
     	$("#" + id + "TotalSum").html(totalBottomHtml);
     	$("#" + id + "TotalSum").nextAll().empty();
  	}
</script>