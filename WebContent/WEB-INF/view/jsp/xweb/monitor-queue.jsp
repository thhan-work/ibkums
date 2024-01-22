<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>처리현황
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
				<div class="tbl_wrap_list_monit" v-for="qitem, groupname in qconf">
				<div class="title">
					{{groupname}}
				</div>
				<table class="tbl_list">
					<thead>
					<tr>
						<th class="q">QUEUE</th><th>#T</th><th class="w">SZ*CNT</th><th class="v">WRWR</th><th class="v">RX</th><th class="w">TPS</th><th class="w">잔량/M</th><th class="w">처리/ERR</th><th class="w">응답/ERR</th><th class="w">결과/ERR</th><th class="n">IN</th><th class="n">OUT</th><th class="n">PID-P</th><th class="n">PID-G</th>
					</tr>
					</thead>
					<tbody>
							<tr v-for="qprop, qname in qitem" v-bind:class="getAlert(qprop, qname)">
								<td v-bind:class="qprop.type" class="q">{{qname}}</td>
								<td><span v-if="qdata[qname]">{{qdata[qname].id}}{{qdata[qname].type}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].alloc}}</span><span v-else>&nbsp;</span></td>									
								<td><span v-if="qdata[qname]">{{qdata[qname].stat}}</span><span v-else>&nbsp;</span></td>								
								<td><span v-if="qdata[qname]">{{qdata[qname].master}}</span><span v-else>&nbsp;</span>
									<select v-bind:class="getAlert(qprop, qname)" v-if="qprop.type == 'agt' && qdata[qname]" v-model="qdata[qname].setratio" @change="changeRatio(qname, qdata[qname].id, qdata[qname].setratio)">
										<option v-for="n in 12" :value="n-2">{{n-2}}</option>
									</select>
								</td>
								<td><span v-if="qdata[qname]">{{qdata[qname].tps}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].tot}}/{{qdata[qname].mem}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].done}}/{{qdata[qname].edone}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].ack}}/{{qdata[qname].eack}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].rslt}}/{{qdata[qname].erslt}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].lastin}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].lastout}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].pidp}}</span><span v-else>&nbsp;</span></td>
								<td><span v-if="qdata[qname]">{{qdata[qname].pidg}}</span><span v-else>&nbsp;</span></td>
							</tr>
						</tbody>
				</table>
		    	</div>
	            <!-- 모니터링 view -->
	         </div>
		</div>
      	<!-- //tab box -->
    </div>
    <!-- //주소록 -->
    
    
        
</div>
<!-- //content -->
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
			selected_server_home: "",
			servers: [
				{
					name: "SMS1",
					url: "vela.odinue.net:24049",
					home: "/app/m1_ibk/M1std/webapp/webshell/sh/",
				},
				{
					name: "SMS2",
					url: "vela.odinue.net:24049",
					home: "/app/m1_ibk/M1std/webapp/webshell/sh/",
				},
			],
			qconf: [
			],
			qdata: {
			},
			interval: null,			
		},
		methods: {
			startInterval: function() {
				var _inst = this;
				if (this.interval == null) {
					this.interval = setInterval(function() {
						_inst.getQData()	
					}, 1000);		
				}
			},
			stopInterval: function() {
				if (this.interval != null) {
					clearInterval(this.interval);
					this.interval = null;
				}
			},
			changeRatio: function(qname, qid, ratio) {
				var _inst = this;
				var confirmMessage = qname + " (#"+qid+")큐의 비율을 " + ratio + "로 조정하시겟습니까 ?";
			    showConfirmForAjax("비율조정", confirmMessage, function() {
			    	if (this.selected_server && this.selected_server != "") 
			    		$('.dimm').show();{
			    		$.ajax({
							url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
							data: { "cmd": _inst.selected_server_home+'m1shell ratio ' + qid + ' ' + ratio, "wait": -1},
							dataType: "jsonp",
							method: "post",
							success: function(json){							
								show_result(_inst.selected_server, "ratio", json.result);
							}
						})
						.done(function(){
							$('.dimm').hide();
						})
						.fail(function(jqXHR, status, error){
						});
					}
			    });
			},
			getSelectedClass: function(sel_server) {
				if (this.selected_server == sel_server.url) {
					return "selected";
				}
				return "";
			},
			getAlert: function(qprop, qname) {
				var conf_stat_arr = qprop.wrwr.split(" ");
				var qdata = this.qdata[qname];
				
				if (qdata == undefined) {
					return qprop.type + " none";	
				}
				
				for(var i=0,m=conf_stat_arr.length;i<m;i++) {
					if (conf_stat_arr[i] == qdata.stat) {
						return qprop.type + " normal";
					}
				}
				return qprop.type + " alert";
			},
			getQConf: function() {
				var _inst = this;
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.qconf.ftl',
						dataType: "jsonp",
						success: function(json){
							_inst.qconf = json;
						}					
					})
					.done(function(){
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},
			getQData: function() {
				var _inst = this;
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.monitque.ftl',
						dataType: "jsonp",			
						success: function(json){
						 	console.log(json);
					/*		var smsqm = json.smsqm; */

							_inst.qdata = {};
							for(var idx in json) {
								var qdata = json[idx];			
								qdata.setratio = qdata.master;
								_inst.qdata[qdata.name] = qdata;								
							}						
						}
					})
					.done(function(){
					})
					.fail(function(jqXHR, status, error){
					});
				}
			},		
			changeServer: function(url, home) {
				this.selected_server = url;
				this.selected_server_home = home;
				this.getQConf();
			},
		},
		created: function () {
			var _inst = this;
			if (this.servers.length > 0) {
				this.selected_server = this.servers[0].url;			
				this.selected_server_home = this.servers[0].home;
			}
			this.getQConf();
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


<!-- Datatables Column Definition-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_b	" id="popup_result" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">결과</div>
            <div class="btn_close"><a href="#" onclick="popClose('#popup_result')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
    </div>
    <!-- //top -->

    <!-- content -->
    <div class="content_pop">
    <!-- table_view -->
      <div class="tbl_wrap_view">
        <table class="tbl_view01">
          <colgroup>
          <col style="width:140px" />
          <col style="width:auto" />
          </colgroup>
          <tr>
            <th scope="row">프로세스명</th>
            <td>
            	<span id="process_name"></span>
            </td>
          </tr>
          <tr>
            <th scope="row">쉘</th>
            <td>
            	<span id="shell"></span>
            </td>
          </tr>
          <tr>
            <th scope="row">결과</th>
            <td><textarea id="result" style="width:400px;background-color: lightgray;height: 350px;" rows='20' cols='80'>
            </textarea></td>
          </tr>
        </table>
      </div>
      <!-- //table_view -->
    </div>
    <!-- //content -->

    <!-- footer -->
    <div class="footer_pop">
        <a href="#" class="btn_big gray"  onclick="popClose('#popup_result')">닫기</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->

<script>
    function show_result(process_name, shell, result){
        popOpen("#popup_result");        
        $("#popup_result").find("#process_name").html(process_name);
        $("#popup_result").find("#shell").html(shell);
        $("#popup_result").find("#result").val(result);
    }
</script>