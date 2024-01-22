<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Datatables Column Definition-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/common/bpopup.js"></script>
<!--popup-->
<div class="popup_wrap_c" id="popup_regist" style="display:none">
    <!-- top -->
    <div class="top">
            <div class="title">등록</div>
            <div class="btn_close"><a href="#" @click="popCreateClose" ><img src="${pageContext.request.contextPath}/static/images/btn_pop_close.png" alt="닫기" /></a></div>
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
                <input type="text" v-model="tmpl_create.createCategory"  ref="tmpl_create.createCategory"  style="width:700px;">
            </td>            
          </tr>
          <tr>
            <th scope="row">이미지명<span class="th_must">*</span></th>
            <td>
            	<input type="text" v-model="tmpl_create.createTitle" ref="tmpl_create.createTitle" style="width:700px;">
            </td>            
          </tr>
          <tr>
            <th scope="row">템플릿 타입<span class="th_must">*</span></th>
            <td>
                <select v-model="tmpl_create.createType" >
	                <option value="B">기본제공</option>
	                <option value="I">개별작성</option>
	                <option value="N">명함</option>
	            </select>
            </td>
          </tr>
          
          <tr>
            <th scope="row">이미지<span class="th_must">*</span></th>
            <td>
            	<div style="height:180px;">
            	</div>
                <input type="file" v-model="tmpl_create.createImage" style="width:700px;">
            </td>            
          </tr>
          
          <tr>
            <th scope="row">사용여부</th>
            <td>
                <select v-model="tmpl_create.createUseYn" >
	                <option value="Y">사용</option>
	                <option value="N">미사용</option>
	            </select>
            </td>
          </tr>
          <tr>
            <th scope="row">개인화 렌더링 정보</th>
            <td>
                <textarea type="text" v-model="tmpl_create.createPersonalInfo" style="width:700px;"></textarea>
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
        <!-- button --><a href="#" @click="createTmpl" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  @click="popCreateClose" >취소</a><!-- //button -->
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
                <input type="text" v-model="tmpl_modify.modifySEQ" ref="tmpl_modify.modifySEQ" style="width:700px;background-color:lightgray;" readonly>
            </td>            
          </tr>
          <tr>
            <th scope="row">이미지카테고리<span class="th_must">*</span></th>
            <td>
                <input type="text" v-model="tmpl_modify.modifyCategory" style="width:700px;">
            </td>            
          </tr>
          <tr>
            <th scope="row">이미지명<span class="th_must">*</span></th>
            <td>
                <input type="text" v-model="tmpl_modify.modifyName" style="width:700px;">
            </td>            
          </tr>
          <tr>
            <th scope="row">템플릿 타입<span class="th_must">*</span></th>
            <td>
                <select v-model="tmpl_modify.modifyType" >
	                <option value="B">기본제공</option>
	                <option value="I">개별작성</option>
	                <option value="N">명함</option>
	            </select>
            </td>
          </tr>
          
          <tr>
            <th scope="row">이미지<span class="th_must">*</span></th>
            <td>
            	<div style="height:180px;">
            	</div>
            </td>            
          </tr>
          
          <tr>
            <th scope="row">사용여부</th>
            <td>
                <select v-model="tmpl_modify.modifyUseYn" >
	                <option value="Y">사용</option>
	                <option value="N">미사용</option>
	            </select>
            </td>
          </tr>
          <tr>
            <th scope="row">개인화 렌더링 정보<span class="th_must">*</span></th>
            <td>
                <textarea type="text" v-model="tmpl_modify.modifyPersonalInfo" style="width:700px;"></textarea>
            </td>
          </tr>
          
          <tr>
            <th scope="row">등록부서<span class="th_must">*</span></th>
            <td>
                <input type="text" v-model="tmpl_modify.modifyBoCode" style="width:700px;background-color:lightgray;" readonly>
            </td>            
          </tr>
          
          <tr>
            <th scope="row">등록자<span class="th_must">*</span></th>
            <td>
                <input type="text" v-model="tmpl_modify.modifyEmplId" style="width:700px;background-color:lightgray;" readonly>
            </td>            
          </tr>
          
          <tr>
            <th scope="row">등록일<span class="th_must">*</span></th>
            <td>
                <input type="text" v-model="tmpl_modify.modifyRegDate" style="width:700px;background-color:lightgray;" readonly>
            </td>            
          </tr>
          
          <tr>
            <th scope="row">수정일<span class="th_must">*</span></th>
            <td>
                <input type="text" v-model="tmpl_modify.modifyModDate" style="width:700px;background-color:lightgray;" readonly>
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
        <!-- button --><a href="#" id="update_jobcode_btn" class="btn_big blue">확인</a><a href="#" class="btn_big gray"  onclick="popClose('#popup_modify')">취소</a><!-- //button -->
    </div>
    <!-- //footer -->
</div>
<!--//popup-->


<script>

$(document).ready(function() {
   	var app = new Vue ({
   		el : '#popup_regist',
   		data : {
   			tmpl_create:{
   				createCategory:"",
   				createTitle:"",
   				createType:"B",
   				createUseYn:"Y",
   				createPersonalInfo:""
   			}
   		},
   		methods : {
   			popCreateClose: function() {
				popClose('#popup_regist');
			},
			createTmpl: function() {
				var _inst = this;
				if (_inst.tmpl_create.createCategory == "") {
					alert("이미지카테고리는 필수입력 항목입니다.");
					_inst.$refs["tmpl_create.createCategory"].focus();
					return;
				}
				if (_inst.tmpl_create.createTitle == "") {
					alert("이미지명은 필수입력 항목입니다.");
					_inst.$refs["tmpl_create.createTitle"].focus();
					return;
				}
				 
				$.ajax({						
					url: '${pageContext.request.contextPath}/template-create',
					type: 'POST',
					data: _inst.tmpl_create,
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_create.createCategory="";
						_inst.tmpl_create.createTitle="";
						_inst.tmpl_create.createType="B";
						_inst.tmpl_create.createUseYn="Y";
						_inst.tmpl_create.createPersonalInfo="";
						popClose('#popup_regist');
					}
				});
			}
   		}
   		
   	});
   	
   	var app2 = new Vue ({
   		el : '#popup_modify',
   		data : {
   			tmpl_modify:{
   				modifySEQ:"",
   				modifyCategory:"",
   				modifyName:"",
   				modifyType:"",
   				modifyUseYn:"",
   				modifyPersonalInfo:"",
   				modifyBoCode:"",
   				modifyEmplId:"",
   				modifyRegDate:"",
   				modifyModDate:""
   			}
   		},
   		methods : {
			popModifyClose: function(){
				popClose('#popup_modify');
			},
			modifyInfo: function(seq){
				var _inst = this;
				$.ajax({						
					url: '${pageContext.request.contextPath}/template-modifyInfo',
					type: 'POST',
					data: {modifySEQ:seq},
					dataType: 'JSON',
					success: function (result) {
						_inst.tmpl_modify.modifySEQ = result.MODIFYSEQ;
						_inst.tmpl_modify.modifyCategory = result.MODIFYCATEGORY;
						_inst.tmpl_modify.modifyName = result.MODIFYNAME;
						_inst.tmpl_modify.modifyType = result.MODIFYTYPE;
						_inst.tmpl_modify.modifyUseYn = result.MODIFYUSEYN;
						_inst.tmpl_modify.modifyPersonalInfo = result.MODIFYPERSONALINFO;
						_inst.tmpl_modify.modifyBoCode = result.MODIFYBOCODE;
						_inst.tmpl_modify.modifyEmplId = result.MODIFYEMPLID;
						_inst.tmpl_modify.modifyRegDate = result.MODIFYREGDATE;
						_inst.tmpl_modify.modifyModDate = result.MODIFYMODDATE; 
					}
				});
				
				
				
			}
   		},
		created : function(seq) {
			this.modifyInfo(seq);
		}
   		
   	});
});

</script>