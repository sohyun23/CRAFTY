<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crafty</title>
<link href="/css/common.css" rel="stylesheet" type="text/css">
<link href="/css/error.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%@ include file="header.jsp" %>
	
	<c:if test="${not empty errorCode}">
		<div class="main-container">
			<div id="errorMsg">${errorCode} : ${errorMsg} </div>
		</div>
	</c:if>
	<c:if test="${empty errorCode}">
		<div class="main-container">
			<div id="errorMsg">오류가 발생하였습니다.</div>
		</div>
	</c:if>
	
	<%@ include file="footer.jsp" %>
</body>
</html>