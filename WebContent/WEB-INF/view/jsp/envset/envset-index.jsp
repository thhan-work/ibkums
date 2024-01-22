<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h3>경조사메시지 수신설정
</h3>
<!-- content -->
<div id="content">
	<div class="info">* 직원들의 경조사 메시지에 대한 수신거부를 등록합니다.</div>
        <!-- box_info -->
        <c:if test="${flag eq '1'}">
        	<div class="box_info_blue_s">
          		<div class="title_s">현재 ${emplName}님께서는 경조사 메시지에 대한 수신거부가 설정되어 있습니다.</div>
        	</div>
        </c:if>
        <!-- //box_info --> 
        <!-- table_view -->
        <div class="tbl_wrap_view mgt20">
          <table class="tbl_view01" summary="검색조건 테이블입니다. 항목으로는 등이 있습니다">
            <caption>
            검색조건 테이블입니다.
            </caption>
            <colgroup>
            <col style="width:180px" />
            <col style="width:auto" />
            </colgroup>
            <tr>
              <th scope="row">SMS 수신거부 설정</th>
              <td><div class="row1">
                  <div class="radio_default">
                    <input type="radio" name="flag" id="rejectY" checked="checked" value="1" />
                    <label for="rejectY">네(수신거부설정)</label>
                  </div>
                  <div class="radio_default">
                    <input type="radio" name="flag" id="rejectN" value="0" />
                    <label for="rejectN">아니오</label>
                  </div>
                </div></td>
            </tr>
          </table>
        </div>
        <!-- //table_view -->
        <!-- 버튼 -->
        <div class="btn_wrap01_list"><button class="btn_big blue" id="save-btn">적용</button></div>
        <!-- //버튼 -->
</div>
 
<c:url var="url" value="/envset/save" />

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/js/IbkZoomInOut.js"></script>

<script>

  $(document).ready(function () {

	  if("${flag}" == "1"){
		  $("#rejectY").attr('checked', 'checked');
	  } else {
		  $("#rejectN").attr('checked', 'checked');
	  }
	  
	  $("#save-btn").click(function() {
		 var value = $('input[name="flag"]:checked').val();
		 console.log("value : " + value);
		 location.href = "${url}?flag=" + value;

	  });

  });
  
  $("#zoom-in-btn").on('click', function () {
	    IbkZoom.zoomIn();
	  });
	
  $("#zoom-out-btn").on('click', function () {
    IbkZoom.zoomOut();
  });
  

</script>
