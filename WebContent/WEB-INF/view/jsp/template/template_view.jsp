<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
<h3 style="font-size:20px;">이미지 목록
</h3>
<!-- content -->
<div id="content">
    <!-- Search -->
   <div class="box_search01">
        <ul>
            <li>

				<span class="text1">카테고리</span>
                <span>
					<select v-model="tmpl_list.searchCategory" >
						<option value="">전체</option>
						<option v-for="result in tmpl_categoryListResult.data" v-bind:value="result.IMG_CTGY_NM" >{{result.IMG_CTGY_NM}}</option>
						<!-- <option v:bind-value="tmpl_categoryListResult.data[0].IMG_CTGY_NM" >{{tmpl_categoryListResult.data[0].IMG_CTGY_NM}}</option>
						<option v:bind-value="tmpl_categoryListResult.data[1].IMG_CTGY_NM" >{{tmpl_categoryListResult.data[1].IMG_CTGY_NM}}</option>
						<option v:bind-value="tmpl_categoryListResult.data[2].IMG_CTGY_NM" >{{tmpl_categoryListResult.data[2].IMG_CTGY_NM}}</option>
						<option v:bind-value="tmpl_categoryListResult.data[3].IMG_CTGY_NM" >{{tmpl_categoryListResult.data[3].IMG_CTGY_NM}}</option>
						<option v:bind-value="tmpl_categoryListResult.data[4].IMG_CTGY_NM" >{{tmpl_categoryListResult.data[4].IMG_CTGY_NM}}</option>
						<option v:bind-value="tmpl_categoryListResult.data[5].IMG_CTGY_NM" >{{tmpl_categoryListResult.data[5].IMG_CTGY_NM}}</option> -->
					</select>
				</span>
				
            </li>
        </ul>
        <span class="btn3"><a href="#" class="btn_search" @click="searchTmpl">조회</a></span>
    </div>
    <!-- table list -->
    <div class="table_top">
    	총 <span>{{tmpl_result.totalRecords}}</span>건
    </div>

    <div v-if="tmpl_result.totalRecords > 0" class="wrap_form">
 		<ul class="box_ms mgt10" style="margin-bottom: 70px;">
			<li v-for="f in 4">
				<div v-if="f <= tmpl_result.data.length" >
					<div class="image_box" @click="openImageDetail(tmpl_result.data[f-1].MMS_IMG_ID)"><img v-bind:src="getImageUrl(tmpl_result.data[f-1])" style="width:100%;height:100%;cursor:pointer;" /></div>
					<div>
	                	<label><b>식별번호 : </b>{{tmpl_result.data[f-1].MMS_IMG_ID}}</label>
	                </div>
					<div>
						<label><b>카테고리 : </b>{{tmpl_result.data[f-1].IMG_CTGY_NM}}</label>
	                </div>
	                <div>
	                	<label><b>이미지명 : </b>{{tmpl_result.data[f-1].IMG_NM}}</label>
	                </div>
				</div>
            </li>
        </ul> 
        <ul v-if="4 < tmpl_result.data.length" class="box_ms mgt10" style="margin-bottom: 50px;">
            <li v-for="f in 4">
            	<div v-if="f+4 <= tmpl_result.data.length" >
	                <div class="image_box" @click="openImageDetail(tmpl_result.data[f+3].MMS_IMG_ID)"><img v-bind:src="getImageUrl(tmpl_result.data[f+3])" style="width:100%;height:100%;cursor:pointer;" /></div>
	                <div>
	                	<label><b>식별번호 : </b>{{tmpl_result.data[f+3].MMS_IMG_ID}}</label>
	                </div>
	                <div>
						<label><b>카테고리 : </b>{{tmpl_result.data[f+3].IMG_CTGY_NM}}</label>
	                </div>
	                <div>
	                	<label><b>이미지명 : </b>{{tmpl_result.data[f+3].IMG_NM}}</label>
	                </div>
				</div>
            </li>
        </ul>
    </div>
    <div v-if="tmpl_result.totalRecords <= 0"  class="wrap_form" >
		<ul class="box_ms mgt10" style="text-align:center">
			<label >조회 하신 데이터가 없습니다.</label>
        </ul> 
    </div>
    <!-- 페이징 -->
	 <div class="paging">
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_first.png' alt='첫 페이지' @click="goTmplPage(1)"/></a>
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_previous.png' alt='이전 페이지' @click="goTmplPage(tmpl_result.currentPage == 1? 1:tmpl_result.currentPage-1)" /></a>
  		<span class='wrap'>
			<a href="#" v-bind:class="{on:(tmpl_result.startPage+n-1 == tmpl_list.currentPage)}" v-for="n in tmpl_result.endPage - tmpl_result.startPage + 1" @click="goTmplPage(tmpl_result.startPage+n-1)">{{tmpl_result.startPage+n-1}}</a>
		</span>
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_next.png' alt='다음 페이지' @click="goTmplPage(tmpl_result.currentPage == tmpl_result.lastPage ? tmpl_result.lastPage:tmpl_result.currentPage+1)" /></a>
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_last.png' alt='마지막 페이지' @click="goTmplPage(tmpl_result.lastPage)"/></a>
	</div>
    <!-- //페이징 -->
	<div class="popup_wrap_c" id="image_detail" style="display:none">
	    <!-- top -->
	    <div class="top">
	            <div class="title" id="popup_employee_title">이미지상세보기</div>
	            <div class="btn_close"><a href="javascript:;" onclick="popClose('#image_detail')"><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
	    </div>
	    <!-- //top -->
	    <!-- content -->
	    <div class="content_pop">
	    <!-- table_view -->
	      <div class="tbl_wrap_view" style="height: calc( 100vh - 250px);">
	      	<div id="image_view"></div>
	      </div>
	      <!-- //table_view -->
	    </div>
	    <!-- //content -->
	
	    <!-- footer -->
	    <div class="footer_pop">
	        <!-- button --><a href="javascript:popClose('#image_detail');" class="btn_big blue">확인</a>
	    </div>
	    <!-- //footer -->    
	</div>
</div>
<!-- //content -->

<!-- bpopoup Definition-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!-- alert dialog 와 confirm dialog 를 사용하기 위해서 필요 -->
<jsp:include page="../common/dialog.jsp" flush="true"/>

<script>
$(document).ready(function() {
   	var app = new Vue ({
   		el : '#content',
   		data : {
   			tmpl_list: {
   				searchType:"B",
   				searchCategory: "",
   				searchTitle: "",
   				searchUseYn:"Y",
				perPage:8,
				currentPage:1
			},
			tmpl_result: {
				totalRecords: 0,
				startPage:1,
				endPage:1,
				lastPage:1
			},
			tmpl_categoryListResult: {
				totalRecords: 0,
				startPage:1,
				endPage:1,
				lastPage:1
			}
   		},
   		methods : {
   			searchTmpl: function() {
   				var _inst = this;
   				$.ajax({						
					url: '${pageContext.request.contextPath}/template-list',
					type: 'POST',
					data: _inst.tmpl_list,
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_result = result;
						_inst.tmpl_list.currentPage = result.currentPage;
					}
				});
				_inst.goTmplPage(1);
   			},
   			categorySearchTmpl: function() {
   				var _inst = this;
   				$.ajax({						
					url: '${pageContext.request.contextPath}/template-categoryList',
					type: 'POST',
					data: _inst.tmpl_list,
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_categoryListResult = result;
					}
				});
   			},
   			goTmplPage: function(pageNo) {
				var _inst = this;
				_inst.tmpl_list.currentPage = pageNo;
				$.ajax({						
					url: '${pageContext.request.contextPath}/template-list',
					type: 'POST',
					data: _inst.tmpl_list,
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_result = result;		
						_inst.tmpl_list.currentPage = result.currentPage;
					}
				});
			},
			getImageUrl: function(item) {
				return "${pageContext.request.contextPath}/template-img.ibk?seq=" + item.MMS_IMG_ID; 
			},
			openImageDetail: function(seq) {
				var image = $("<img style='width:100%;height: calc( 100vh - 250px);'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + seq);
				$("#image_detail").find("#image_view").children().remove();
				$("#image_detail").find("#image_view").append(image);
				popOpen("#image_detail");
			}
   		},
		created : function() {
			this.searchTmpl();
			this.categorySearchTmpl();
		}
   		
   	});
});


</script>