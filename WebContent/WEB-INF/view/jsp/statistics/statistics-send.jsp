<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>발송현황
</h3>
<!-- content -->
<div id="content">

    <div class="box_search01">
      <ul>
        <li>
        	<span>* 실시간 업무별 발송 건수가 조회되는 화면입니다.</span>
        </li>
      </ul>
      <span class="btn3"><a href="#" class="btn_search" @click="search">조회</a></span>
    </div>
    
    <div class="table_top"></div>
   	
   	<!-- table list -->
    <div class="tbl_wrap_list">
        <table class="tbl_list" id="notice_table" summary="영업점별 통계 테이블 입니다.">
            <colgroup>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
            </colgroup>
            <thead>
            <tr>                
                <th scope="col" rowspan="2">업무구분</th>
                <th scope="col" rowspan="2">발송대기</th>
                <th scope="col" rowspan="2">발송요청</th>
                <th scope="col" rowspan="2">결과대기</th>
                <th scope="col" colspan="2">결과완료</th>                
            </tr>
            <tr>                
                <th scope="col">성공</th>
                <th scope="col">실패</th>
            </tr>
            </thead>
            
            <tr v-for="job_name in job_type" @click="setTaskName(job_name)" style="cursor:pointer;">                
                <td>{{job_name}}</td>
                <td v-if="send_data[job_name]">{{send_data[job_name].waitSend}}</td>
                <td v-if="send_data[job_name]">{{send_data[job_name].reqSend}}</td>
                <td v-if="send_data[job_name]">{{send_data[job_name].waitRep}}</td>
                <td v-if="send_data[job_name]">{{send_data[job_name].repSucc}}</td>
                <td v-if="send_data[job_name]">{{send_data[job_name].repFail}}</td>                                
           	</tr>
        </table>
    </div>
    <!-- //table list -->
    
    <div v-if="task_name" class="table_top">
    {{task_name}} 상세업무별
    </div>
    
    <!-- table list -->
    <div v-if="task_name"  class="tbl_wrap_list">
    	
        <table class="tbl_list" id="notice_table" summary="발송현황 통계 테이블 입니다.">
            <colgroup>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
                <col style="width:"/>
            </colgroup>
            <thead>
            <tr>                
                <th scope="col" rowspan="2">상세 업무명</th>
                <th scope="col" rowspan="2">발송대기</th>
                <th scope="col" rowspan="2">발송요청</th>
                <th scope="col" rowspan="2">결과대기</th>
                <th scope="col" colspan="2">결과완료</th>                
            </tr>
            <tr>                
                <th scope="col">성공</th>
                <th scope="col">실패</th>
            </tr>
            </thead>
            
            <tr v-for="task_detail_data in send_data[task_name].task_data">                
                <td>{{task_detail_data.unitSystemItemName}}</td>
                <td>{{task_detail_data.waitSend}}</td>
                <td>{{task_detail_data.reqSend}}</td>
                <td>{{task_detail_data.waitRep}}</td>
                <td>{{task_detail_data.repSucc}}</td>
                <td>{{task_detail_data.repFail}}</td>                                
           	</tr>
           	
           	<tr v-if="send_data[task_name].task_data.length < 1"><td style='height:150px;margin-top:50px' colspan="6">조회 목록이 없습니다.</td></tr>
        </table>
    </div>
    <!-- //table list -->
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
        src="${pageContext.request.contextPath}/static/js/vue.js"></script>
<!-- Script -->

<script>

  $(document).ready(function () {
	  var app = new Vue({
		el: '#content',
		data: {
			job_type: ["SMS 실시간", "SMS 일반", "SMS 배치", "MMS 실시간", "MMS 배치", "그룹발송",],
			send_data: {},
			task_name: "",
		},
		methods: {			
			getSendData: function() {
				var _inst = this;
				$.ajax({
					url: '${pageContext.request.contextPath}/statistics-send',
					dataType: "json",			
					success: function(json){
						_inst.send_data = {};
						
						for(var idx in _inst.job_type) {
							var job_name = _inst.job_type[idx];
							job_group = {};
							job_group["repFail"] = 0;
							job_group["repSucc"] = 0;
							job_group["reqSend"] = 0;
							job_group["waitRep"] = 0;
							job_group["waitSend"] = 0;
							job_group["task_data"] = [];
							
							_inst.send_data[job_name] = job_group;
						}
						
						for(var idx in json) {
							var line = json[idx];
							var job_name = line.lvia;
							var job_group = _inst.send_data[job_name];
							
							job_group["repFail"] += line.repFail;
							job_group["repSucc"] += line.repSucc;
							job_group["reqSend"] += line.reqSend;
							job_group["waitRep"] += line.waitRep;
							job_group["waitSend"] += line.waitSend;
							job_group["task_data"].push(line);
						}
					}
				})
				.done(function(){})
				.fail(function(jqXHR, status, error){});
			},		
			setTaskName: function(taskName) {
				this.task_name = taskName;
			},
			search: function() {
				this.send_data = {};
				this.task_name = "";
				this.getSendData();
			},			
		},
		created: function () {
			var _inst = this;
			this.getSendData();
		}
	});

	  $("#zoom-in-btn").on('click', function () {
	    IbkZoom.zoomIn();
	  });
	
	  $("#zoom-out-btn").on('click', function () {
	    IbkZoom.zoomOut();
	  });

  });
</script>
