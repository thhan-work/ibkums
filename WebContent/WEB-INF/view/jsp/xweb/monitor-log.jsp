<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>로그조회
</h3>
<!-- content -->
<div id="content">
	<!-- Search -->
    <div class="box_search01">
      <ul>
        <li>
			<span class="title02">검색키워드</span>
			<span>
				<input type="text" maxlength="20" value="" v-model="search_word" v-on:keyup.enter="grep_log" style="width:400px">
			</span>
        </li>
      </ul>
      <span class="btn3"><a href="#" class="btn_search" @click="grep_log">조회</a></span>
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
				
				<textarea style="width:97%;height:500px;">{{result}}</textarea>
				
		    	</div>
	            <!-- 모니터링 view -->
	         </div>
		</div>
      	<!-- //tab box -->
    </div>
        
</div>
<!-- //content -->
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
			result: "",		
			search_word: "",
		},
		methods: {
			getSelectedClass: function(sel_server) {
				if (this.selected_server == sel_server.url) {
					return "selected";
				} 
				return "";
			},
			grep_log: function(keyword) {
				var _inst = this;
				$('.dimm').show();
				if (this.selected_server && this.selected_server != "") {
					$.ajax({
						url: 'http://'+_inst.selected_server+'/webshell/json.run.ftl',
						data: { "cmd": _inst.selected_server_home+'m1shell greplog '+ _inst.search_word, "wait": -1},
						dataType: "jsonp",
						method: "post",
						success: function(json){							
							console.log(json);
							_inst.result = json.result;
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
				this.result = "";
				$('.dimm').hide();
			},
		},
		created: function () {
			var _inst = this;
			if (this.servers.length > 0) {
				this.selected_server = this.servers[0].url;
				this.selected_server_home = this.servers[0].home;
			}
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
