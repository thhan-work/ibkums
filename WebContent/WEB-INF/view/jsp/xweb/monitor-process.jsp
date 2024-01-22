<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>프로세스현황
</h3>
<!-- content -->
<div id="content">

	<div class="table_top">
        <a href="javascript:" v-if="interval == null" class="btn_default blue" @click="startInterval">시작</a>
        <a href="javascript:" v-if="interval != null" class="btn_default delete" @click="stopInterval">정지</a>        
   	</div>
    <div class="col3">
      	<!-- tap box -->
      	<div class="wrap_tab mgt24">
      		<div class="tapAddress">
		       	<ul class="tabs" data-persist="true">
		       		<li v-for="server in servers" v-bind:class="getSelectedClass(server)">
				      <a href="javascript:" @click="changeServer(server.url, server.home)">{{ server.name }}</a>
				    </li>		            
		        </ul>
	        </div>
			<!-- 모니터링 view -->
            <div>	            	
				<div class="tbl_wrap_list_monit">
				
				<table class="tbl_list">
					<thead>
						<tr>
							<th class="p">Process</th>
							<th class="w">PID</th>
							<th class="d" style="width: 100px;">ELAPSED</th>
							<th class="d">TIME</th>
							<th class="v">%CPU</th>
							<th class="w">%MEM</th>
							<th class="w">USER</th>
							<th class="d" style="width: 110px;">Status</th>
							<th class="m">Action</th>
						</tr>
					</thead>

					<tbody id="process-list" v-for="proc in proc_list">
						<tr v-bind:class="getAlert(proc.pid)">
							<td class="p">
								<em class="hd">{{proc.sh_abbr}}</em></td>
							<td><span v-if="proc_data[proc.pid]">{{proc_data[proc.pid].pid}}</span><span v-else>&nbsp;</span></td>
							<td><span v-if="proc_data[proc.pid]">{{proc_data[proc.pid].elapsed}}</span><span v-else>&nbsp;</span></td>
							<td><span v-if="proc_data[proc.pid]">{{proc_data[proc.pid].time}}</span><span v-else>&nbsp;</span></td>
							<td><span v-if="proc_data[proc.pid]">{{proc_data[proc.pid].cpu}}</span><span v-else>&nbsp;</span></td>
							<td><span v-if="proc_data[proc.pid]">{{proc_data[proc.pid].mem}}</span><span v-else>&nbsp;</span></td>
							<td><span v-if="proc_data[proc.pid]">{{proc_data[proc.pid].user}}</span><span v-else>&nbsp;</span></td>
							<td class="s r"><span v-if="proc_data[proc.pid]">Running</span><span v-else>Not running</span></td>
							<td class="m">
								<!-- <a href="javascript:;" class="btn_small blue small">Log</a> -->
								<a href="javascript:" v-if="!proc_data[proc.pid]" class="btn_small small" @click="start(proc.sh)">Start</a>
								<a href="javascript:" v-if="proc_data[proc.pid]" class="btn_small small" @click="stop(proc.sh)">Stop</a>
								<a href="javascript:" v-if="proc_data[proc.pid]" class="btn_small small" @click="restart(proc.sh)">Restart</a>
							</td>
						</tr>							
					</tbody>
				</table>
				
		    	</div>
	            <!-- 모니터링 view -->
	         </div>
		</div>
      	<!-- //tab box -->
    </div>
        
</div>
<!-- //content -->
<!-- codegroup popup -->
<jsp:include page="monitor-process-popup.jsp" flush="true"/>
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>
<!-- ajax Loding 이미지 -->
<jsp:include page="../common/loading.jsp" flush="true"/>

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
<script>

  $(document).ready(function () {
	  var app = new Vue({
		el: '#content',
		data: {
			selected_server: "",
			servers: [
				{
					name: "SMS1",
					url: "vela.odinue.net:24049",
					home: "/app/m1_ibk/M1std/webapp/webshell/sh/",
				},
				{
					name: "SMS2",
					url: "192.168.0.221:24049",
					home: "/app/m1_ibk/M1std/webapp/webshell/sh/",
				},
			],
			proc_list: [
			],
			proc_data: {
			},
			interval: null,		
		},
		methods: {
			startInterval: function() {
				var _inst = this;
				if (this.interval == null) {
					this.interval = setInterval(function() {
						_inst.getProcData()	
					}, 1000);		
				}
			},
			stopInterval: function() {
				if (this.interval != null) {
					clearInterval(this.interval);
					this.interval = null;
				}
			},
			getSelectedClass: function(sel_server) {
				if (this.selected_server == sel_server.url) {
					return "selected";
				} 
				return "";
			},
			getAlert: function(pid) {
				var proc = this.proc_data[pid];
				if (proc == undefined) {
					return "alert";	
				}
				return "normal";
			},
			getProcList: function() {
				var _inst = this;
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
						data: { "cmd": _inst.selected_server_home+'m1shell list', "wait": -1},
						dataType: "jsonp",
						method: "post",
						success: function(json){							
							_inst.proc_list = [];
							var proc_list = json.result.split("\n");
							for(var proc_list_idx in proc_list) {
								var proc = proc_list[proc_list_idx].split("\t");
								if(proc.length == 2) {
									_inst.proc_list.push({
										"pid": proc[0],
										"sh": proc[1],
										"sh_abbr": proc[1].substring(proc[1].lastIndexOf("/")+1, proc[1].lastIndexOf(".")),
									});
								}
							}
						}
					})
					.done(function(){
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},
			getProcData: function() {
				var _inst = this;
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
						data: { "cmd": _inst.selected_server_home+'m1shell status', "wait": -1},
						dataType: "jsonp",
						method: "post",
						success: function(json){							
							console.log(json);
							_inst.proc_data = {};
							var proc_list = json.result.split("\n");
							for(var proc_list_idx in proc_list) {
								var proc = proc_list[proc_list_idx].split("\t");
								if(proc.length == 7) {
									_inst.proc_data[proc[0]] = {
										"process": proc[0],
										"pid": proc[1],
										"elapsed": proc[2],
										"time": proc[3],
										"cpu": proc[4],
										"mem": proc[5],
										"user": proc[6],
									};
								}
							}
						}
					})
					.done(function(){
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},		
			restart: function(sh) {
				var _inst = this;
				$('.dimm').show();
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
						data: { "cmd": _inst.selected_server_home+'m1shell restart '+ sh, "wait": -1},
						dataType: "jsonp",
						method: "post",
						success: function(json){							
							show_result(_inst.selected_server, sh, json.result);
						}
					})
					.done(function(){
						$('.dimm').hide();
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},
			start: function(sh) {
				var _inst = this;
				$('.dimm').show();
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
						data: { "cmd": _inst.selected_server_home+'m1shell start '+ sh, "wait": -1},
						dataType: "jsonp",
						method: "post",
						success: function(json){							
							show_result(_inst.selected_server, sh, json.result);
						}
					})
					.done(function(){
						$('.dimm').hide();
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},
			stop: function(sh) {
				var _inst = this;
				$('.dimm').show();
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
						data: { "cmd": _inst.selected_server_home+'m1shell stop '+ sh, "wait": -1},
						dataType: "jsonp",
						method: "post",
						success: function(json){							
							show_result(_inst.selected_server, sh, json.result);
						}
					})
					.done(function(){
						$('.dimm').hide();
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},
			changeServer: function(url, home) {
				$('.dimm').show();
				this.selected_server = url;
				this.selected_server_home = home;
				this.getProcList();
				$('.dimm').hide();
			},
		},
		created: function () {
			var _inst = this;
			if (this.servers.length > 0) {
				this.selected_server = this.servers[0].url;
				this.selected_server_home = this.servers[0].home;
			}
			this.getProcList();
			this.startInterval();
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
