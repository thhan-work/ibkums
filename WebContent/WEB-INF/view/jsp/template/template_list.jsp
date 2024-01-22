<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
<h3>템플릿 리스트
</h3>
<!-- content -->
<div id="content">
    <!-- Search -->
    <div class="box_search01">
        <ul>
            <li>

				<span class="text1">타입</span>
                <span>
					<select v-model="tmpl_list.searchType" >
						<option value="">전체</option>
						<option value="B">기본제공</option>
						<option value="I">개별작성</option>
						<option value="N">명함</option>
					</select>
				</span>
				&nbsp;
				<span class="text1">사용여부</span>
                <span>
					<select v-model="tmpl_list.searchUseYn" >
						<option value="">전체</option>
						<option value="Y">사용</option>
						<option value="N">미사용</option>
					</select>
				</span>
				&nbsp;
                <span class="text1">카테고리</span>
                <span>
					<input type="text" v-model="tmpl_list.searchCategory" maxlength="20" value="" style="width:120px">
				</span>
				&nbsp;
                <span class="text1">제목</span>
                <span>
					<input type="text" v-model="tmpl_list.searchTitle" maxlength="40" value="" style="width:120px">
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
					<div class="image_box" style="cursor:pointer" @click="viewTmpl(tmpl_result.data[f-1].MMS_IMG_ID)"><img v-bind:src="getImageUrl(tmpl_result.data[f-1])" style="width:100%;height:100%;" /></div>
					<div>
	                	<label><b>식별번호 : </b>{{tmpl_result.data[f-1].MMS_IMG_ID}}</label>
	                </div>
					<div>
						<label><b>카테고리 : </b>{{tmpl_result.data[f-1].IMG_CTGY_NM}}</label>
	                </div>
	                <div>
	                	<label><b>이미지명 : </b>{{tmpl_result.data[f-1].IMG_NM}}</label>
	                </div>
	                <div>
	                	<button class="btn_small mod_btn" @click="downloadTmpl(tmpl_result.data[f-1].MMS_IMG_ID)">다운로드</button>
	                </div>
				</div>
            </li>
        </ul> 
        <ul v-if="4 < tmpl_result.data.length" class="box_ms mgt10" style="margin-bottom: 50px;">
            <li v-for="f in 4">
            	<div v-if="f+4 <= tmpl_result.data.length" >
	                <div class="image_box" style="cursor:pointer" @click="viewTmpl(tmpl_result.data[f+3].MMS_IMG_ID)"><img v-bind:src="getImageUrl(tmpl_result.data[f+3])" style="width:100%;height:100%;" /></div>
	                <div>
	                	<label><b>식별번호 : </b>{{tmpl_result.data[f+3].MMS_IMG_ID}}</label>
	                </div>
	                <div>
						<label><b>카테고리 : </b>{{tmpl_result.data[f+3].IMG_CTGY_NM}}</label>
	                </div>
	                <div>
	                	<label><b>이미지명 : </b>{{tmpl_result.data[f+3].IMG_NM}}</label>
	                </div>
	                <div>
	                	<button class="btn_small mod_btn" @click="downloadTmpl(tmpl_result.data[f+3].MMS_IMG_ID)">다운로드</button>
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
	<div v-if="tmpl_result.totalRecords > 0" class="paging">
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_first.png' alt='첫 페이지' @click="goTmplPage(1)"/></a>
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_previous.png' alt='이전 페이지' @click="goTmplPage(tmpl_result.currentPage == 1? 1:tmpl_result.currentPage-1)" /></a>
  		<span class='wrap'>
			<a href="#" v-bind:class="{on:(tmpl_result.startPage+n-1 == tmpl_list.currentPage)}" v-for="n in tmpl_result.endPage - tmpl_result.startPage + 1" @click="goTmplPage(tmpl_result.startPage+n-1)">{{tmpl_result.startPage+n-1}}</a>
		</span>
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_next.png' alt='다음 페이지' @click="goTmplPage(tmpl_result.currentPage == tmpl_result.lastPage ? tmpl_result.lastPage:tmpl_result.currentPage+1)" /></a>
		<a style="cursor:pointer;"><img src='${pageContext.request.contextPath}/static/images/btn_pg_last.png' alt='마지막 페이지' @click="goTmplPage(tmpl_result.lastPage)"/></a>
	</div>
    <!-- //페이징 -->
    <!-- 버튼 -->
    <div class="btn_wrap01_list">
        <a href="#"  class="btn_big blue" @click="allDownloadTmpl">이미지 다운로드</a>
        <a href="#"  class="btn_big blue" @click="registTmplPopup">등록</a>
    </div>
    <!-- //버튼 -->
    
	<!--popup-->
	<div class="popup_wrap_c" id="popup_regist" style="display:none">
	    <!-- top -->
	    <div class="top">
	            <div class="title">등록</div>
	            <div class="btn_close"><a href="#" @click="popRegistClose" ><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
	    </div>
	    <!-- //top -->
	
	    <!-- content -->
	    <div class="content_pop">
	    <!-- table_view -->
	      <div class="tbl_wrap_view_jobcode">
	        <form name="regist_form" id="regist_form">
	        <table class="tbl_view01">
	          <colgroup>
	          <col style="width:200px" />
	          <col style="width:auto" />
	          </colgroup>
	          <tr>
	            <th scope="row">이미지카테고리<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_regist.IMG_CTGY_NM"  ref="tmpl_regist.IMG_CTGY_NM"  style="width:700px;">
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">이미지명<span class="th_must">*</span></th>
	            <td>
	            	<input type="text" v-model="tmpl_regist.IMG_NM" ref="tmpl_regist.IMG_NM" style="width:700px;">
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">템플릿 타입<span class="th_must">*</span></th>
	            <td>
	                <select v-model="tmpl_regist.IMG_TYPE_CD" >
		                <option value="B">기본제공</option>
		                <option value="I">개별작성</option>
		                <option value="N">명함</option>
		            </select>
	            </td>
	          </tr>
	          
	          <tr>
	            <th scope="row">이미지<span class="th_must">*</span></th>
	            <td>
	            	<div style="height:180px;" > 
	            		<img v-if="tmpl_regist.IMAGE_PATH!=''" v-bind:src="getTmplUploadedImage(tmpl_regist.IMAGE_PATH)" style="height:100%;" />
	            	</div>
	            	
					<input type="text" class="imgPath" v-model="tmpl_regist.IMAGE_PATH" placeholder="파일 업로드" readonly="readonly" style="display:none">
					<input type="file" id="fileupload" name="fileupload" placeholder="파일 업로드"  @change="imageChoice" >
						
	            </td>            
	          </tr>
	          
	          <tr>
	            <th scope="row">사용여부<span class="th_must">*</span></th>
	            <td>
	                <select v-model="tmpl_regist.USE_YN" >
		                <option value="Y">사용</option>
		                <option value="N">미사용</option>
		            </select>
	            </td>
	          </tr>
	          <tr>
	            <th scope="row">이미지 우선순위</th>
	            <td>
	                <input type="text" v-model="tmpl_regist.IMG_SQN" style="width:700px;">
	            </td>
	          </tr>
	          <tr>
	            <th scope="row">개인화 렌더링 정보</th>
	            <td>
	                <textarea type="text" v-model="tmpl_regist.MMS_USER_DFNT_CON" style="width:700px;"></textarea>
	            </td>            
	          </tr>
	         
	        </table>
	        </form>
	      </div>
	      <!-- //table_view -->
	    </div>
	    <!-- //content -->
	
	    <!-- footer -->
	    <div class="footer_pop">
	        <!-- button --><a href="#" @click="registTmpl" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  @click="popRegistClose" >취소</a><!-- //button -->
	    </div>
	    <!-- //footer -->
	</div>
	<!--//popup-->
	
	<!--popup-->
	<div class="popup_wrap_c" id="popup_modify" style="display:none">
	    <!-- top -->
	    <div class="top">
	            <div class="title">수정</div>
	            <div class="btn_close"><a href="#" @click="popModifyClose" ><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
	    </div>
	    <!-- //top -->
	
		<!-- content -->
	    <div class="content_pop">
	    <!-- table_view -->
	      <div class="tbl_wrap_view_jobcode">
	        <form name="regist_form" id="regist_form">
	        <table class="tbl_view01">
	          <colgroup>
	          <col style="width:200px" />
	          <col style="width:auto" />
	          </colgroup>
	          
	          <tr>
	            <th scope="row">이미지시퀀스<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.MMS_IMG_ID" ref="tmpl_modify.MMS_IMG_ID" style="width:700px;background-color:lightgray;" readonly>
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">이미지카테고리<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.IMG_CTGY_NM" style="width:700px;">
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">이미지명<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.IMG_NM" style="width:700px;">
	            </td>            
	          </tr>
	          <tr>
	            <th scope="row">템플릿 타입<span class="th_must">*</span></th>
	            <td>
	                <select v-model="tmpl_modify.IMG_TYPE_CD" >
		                <option value="B">기본제공</option>
		                <option value="I">개별작성</option>
		                <option value="N">명함</option>
		            </select>
	            </td>
	          </tr>
	          
	          <tr>
	            <th scope="row">이미지<span class="th_must">*</span></th>
	            <td>
	            	<div style="height:180px;" @click="openImageDetail(tmpl_modify.MMS_IMG_ID)" ><img v-bind:src="getImageUrl(tmpl_modify)" style="height:100%;" />
	            	</div>
	            </td>            
	          </tr>
	          
	          <tr>
	            <th scope="row">사용여부<span class="th_must">*</span></th>
	            <td>
	                <select v-model="tmpl_modify.USE_YN" >
		                <option value="Y">사용</option>
		                <option value="N">미사용</option>
		            </select>
	            </td>
	          </tr>
	          <tr>
	            <th scope="row">이미지 우선순위</th>
	            <td>
	                <input type="text" v-model="tmpl_modify.IMG_SQN" style="width:700px;">
	            </td>
	          </tr>
	          <tr>
	            <th scope="row">개인화 렌더링 정보</th>
	            <td>
	                <textarea type="text" v-model="tmpl_modify.MMS_USER_DFNT_CON" style="width:700px;"></textarea>
	            </td>
	          </tr>
	          
	          <tr>
	            <th scope="row">등록부서<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.DVCD" style="width:700px;background-color:lightgray;" readonly>
	            </td>            
	          </tr>
	          
	          <tr>
	            <th scope="row">등록자<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.EMN" style="width:700px;background-color:lightgray;" readonly>
	            </td>            
	          </tr>
	          
	          <tr>
	            <th scope="row">등록일<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.RGSN_TS" style="width:700px;background-color:lightgray;" readonly>
	            </td>            
	          </tr>
	          
	          <tr>
	            <th scope="row">수정일<span class="th_must">*</span></th>
	            <td>
	                <input type="text" v-model="tmpl_modify.MDFC_TS" style="width:700px;background-color:lightgray;" readonly>
	            </td>            
	          </tr>
	         
	        </table>
	        </form>
	      </div>
	      <!-- //table_view -->
	    </div>
	    <!-- //content -->
	   
	    <!-- footer -->
	    <div class="footer_pop"> 
	        <!-- button --><a href="#" @click="modifyTmpl" class="btn_big blue">수정</a><a href="#" class="btn_big gray"  @click="popModifyClose">취소</a><!-- //button -->
	    </div>
	    <!-- //footer -->
	</div>
	<!--//popup-->
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
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/jquery.filedownload.js"></script>
<script>
$(document).ready(function() {
   	var app = new Vue ({
   		el : '#content',
   		data : {
   			tmpl_list: {
   				searchType:"",
   				searchCategory: "",
   				searchTitle: "",
   				searchUseYn:"",
				perPage:8,
				currentPage:1
			},
			tmpl_result: {
				totalRecords: 0,
				startPage:1,
				endPage:1,
				lastPage:1
			},
			tmpl_regist:{
				IMG_CTGY_NM:"",
				IMG_NM:"",
				IMG_TYPE_CD:"B",
   				USE_YN:"Y",
   				MMS_USER_DFNT_CON:"",
   				IMAGE_PATH:"",
   				EMN:"",
   				DVCD:"",
   				IMG_SQN:"100"
   			},
   			tmpl_modify:{
   				MMS_IMG_ID:"",
   				IMG_CTGY_NM:"",
   				IMG_NM:"",
   				IMG_TYPE_CD:"",
   				USE_YN:"",
   				MMS_USER_DFNT_CON:"",
   				DVCD:"",
   				IMG_SQN:"",
   				EMN:"",
   				RGSN_TS:"",
   				MDFC_TS:""
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
			registTmplPopup: function(){
				this.tmpl_regist = {
						IMG_CTGY_NM:"",
						IMG_NM:"",
						IMG_TYPE_CD:"B",
		   				USE_YN:"Y",
		   				MMS_USER_DFNT_CON:"",
		   				IMAGE_PATH:"",
		   				EMN:'${EMPL_ID}',
		   				DVCD:'${EMPL_BOCODE}',
		   				IMG_SQN:"100"
					};
				popOpen("#popup_regist");
			},
			registTmpl: function() {
				var _inst = this;
				var categoryLen = _inst.getByteLen(_inst.tmpl_regist.IMG_CTGY_NM);
				var nameLen = _inst.getByteLen(_inst.tmpl_regist.IMG_NM);
				if (_inst.tmpl_regist.IMG_CTGY_NM == "") {
					alert("이미지카테고리는 필수입력 항목입니다.");
					_inst.$refs["tmpl_regist.IMG_CTGY_NM"].focus();
					return;
				}
				
				if (categoryLen > 20 ) {
					alert("이미지카테고리는 한글기준 최대 10자 입니다.");
					_inst.$refs["tmpl_regist.IMG_CTGY_NM"].focus();
					return;
				}
				
				if (_inst.tmpl_regist.IMG_NM == "") {
					alert("이미지명은 필수입력 항목입니다.");
					_inst.$refs["tmpl_regist.IMG_NM"].focus();
					return;
				}
				
				if (nameLen > 100 ) {
					alert("이미지명은 한글기준 최대 50자 입니다.");
					_inst.$refs["tmpl_regist.IMG_NM"].focus();
					return;
				}
			
				if (_inst.tmpl_regist.IMAGE_PATH == "") {
					alert("이미지파일은 필수 항목입니다.");
					return;
				}
				
				$.ajax({						
					url: '${pageContext.request.contextPath}/template-regist',
					type: 'POST',
					data: _inst.tmpl_regist,
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_regist={
								IMG_CTGY_NM:"",
								IMG_NM:"",
								IMG_TYPE_CD:"B",
				   				USE_YN:"Y",
				   				MMS_USER_DFNT_CON:"",
				   				IMG_SQN:"100",
				   				IMAGE_PATH:""
						};
						alert("등록이 완료되었습니다."); 
						_inst.popRegistClose();
						_inst.searchTmpl();
					}
				});
			},
			viewTmpl: function(MMS_IMG_ID){
				popOpen("#popup_modify");
 				var _inst = this;
				$.ajax({						
					url: '${pageContext.request.contextPath}/template-modifyInfo',
					type: 'POST',
					data: {MMS_IMG_ID:MMS_IMG_ID},
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_modify=result;
					}
				});
			},
			downloadTmpl: function(MMS_IMG_ID) {
				$.fileDownload("${pageContext.request.contextPath}/download-template-img.ibk",{
			      httpMethod: "GET",
			      data: {
			    	  seq: MMS_IMG_ID
			      },
			      successCallback: function (url) {
			      },
			      failCallback: function(responesHtml, url){
			      }
			     });
			},
			allDownloadTmpl: function() {
				$.fileDownload("${pageContext.request.contextPath}/download-all-template-img.ibk",{
			      httpMethod: "GET",
			      data: { },
			      successCallback: function (url) {
			      },
			      failCallback: function(responesHtml, url){
			      }
			     });
			},
			modifyTmpl: function() {
				var _inst = this;
				var categoryLen = _inst.getByteLen(_inst.tmpl_modify.IMG_CTGY_NM);
				var nameLen = _inst.getByteLen(_inst.tmpl_modify.IMG_NM);
				if (_inst.tmpl_modify.IMG_CTGY_NM == "") {
					alert("이미지카테고리는 필수입력 항목입니다.");
					_inst.$refs["tmpl_modify.IMG_CTGY_NM"].focus();
					return;
				}
				
				if (categoryLen > 20 ) {
					alert("이미지카테고리는 한글기준 최대 10자 입니다.");
					_inst.$refs["tmpl_modify.IMG_CTGY_NM"].focus();
					return;
				}
				
				if (_inst.tmpl_modify.IMG_NM == "") {
					alert("이미지명은 필수입력 항목입니다.");
					_inst.$refs["tmpl_modify.IMG_NM"].focus();
					return;
				}
				
				if (nameLen > 100 ) {
					alert("이미지명은 한글기준 최대 50자 입니다.");
					_inst.$refs["tmpl_modify.IMG_NM"].focus();
					return;
				}
				
				$.ajax({						
					url: '${pageContext.request.contextPath}/template-modify',
					type: 'POST',
					data: _inst.tmpl_modify,
					dataType: 'JSON',
					success: function (result) {
						alert("수정이 완료되었습니다.");
						_inst.popModifyClose();
						_inst.searchTmpl();
					}
				});
			},
			getImageUrl: function(item) {
				return "${pageContext.request.contextPath}/template-img.ibk?seq=" + item.MMS_IMG_ID; // + "&" + (new Date().getTime()); 
			},
			openImageDetail: function(seq) {
				var image = $("<img style='width:100%;height: calc( 100vh - 250px);'/> ").attr("src", "${pageContext.request.contextPath}/template-img.ibk?seq=" + seq);
				$("#image_detail").find("#image_view").children().remove();
				$("#image_detail").find("#image_view").append(image);
				popOpen("#image_detail");
			},
			popRegistClose: function() {
				$("#popup_regist").find("input[name=fileupload]").val("");
				popClose("#popup_regist");
			},
			popModifyClose: function(){
				popClose("#popup_modify");
			},
			imageChoice: function() {
				var _inst = this;
				
				var filename = $("#popup_regist").find("input[name=fileupload]").val();
				if (filename == "") {
					return;
				}
				var fileExt = filename.substring(filename.lastIndexOf(".")).toUpperCase();
				
				if (fileExt != ".JPG" && fileExt != ".JPEG") {
					$("#popup_regist").find("input[name=fileupload]").val("");
					alert("jpg나 jpeg 파일만 등록이 가능합니다.");
					return;
				}
				
				var formData = new FormData();  
				formData.append("fileName", $("#popup_regist").find("input[name=fileupload]")[0].files[0]); 
				
				$.ajax({ 
					url: '${pageContext.request.contextPath}/template-regist-image', 
					type: 'POST',
					dataType: 'JSON',
					enctype: 'multipart/form-data',
					data: formData, 
					processData: false, 
					contentType: false, 
					success: function(data){ 
						if (data.result) {
							_inst.tmpl_regist.IMAGE_PATH=data.filename;
						} else {
							$("#popup_regist").find("input[name=fileupload]").val("");
							alert(data.error);
						}
					} 
				});
			},
			getTmplUploadedImage: function(item){
				return "${pageContext.request.contextPath}/template-uploaded-img.ibk?filename=" + item;
			},
			getByteLen: function(value) {
				var j_len = 0;
				var j_char = '';
				for(var i=0; i<value.length; i++) {
					j_len += this.getBytes(value.charAt(i));
				}
				return j_len;
			},
			getBytes: function(value) {
				if(escape(value).length > 4) {
					return 2;
				} else if(value != '\r') {
					return 1;
				}
				return 0;
			}
   		},
		created : function() {
			this.searchTmpl();
		}
   		
   	});
});


</script>