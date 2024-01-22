
<%@ page language="java" contentType="text/html;charset=utf-8" %>

<%
	java.util.Date date = new java.util.Date();
	int year = date.getYear()+1900;
	int month = date.getMonth() +1 ;
	int day = date.getDay() + 1;
	int hour = date.getHours();
%>

<script>
var year = <%=year%>;
var month = <%=month%>;
var day = <%=day%>;
var hour = <%=hour%>;
</script>

