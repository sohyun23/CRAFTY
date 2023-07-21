<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="/css/registerRequest.css" rel="stylesheet" type="text/css"/>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %>

	<div class="dashboard-container">
        <div class="side-menu">
            <div class="dashboard">
                Dashboard
            </div>
            <div class="hr-container">
        		<hr>
    		</div>
            <div class="menu-container">
                <div class="menu">
                    	굿즈 관리
                </div>
                <ul>
                    <li><a href="/admin/goods">등록 굿즈</a></li>
                    <li id="current-title"><a href="/admin/request/register">등록 신청 굿즈</a></li>
                    <li><a href="/admin/request/nondisclosure">비공개 신청 굿즈</a></li>
                </ul>
            </div>
            
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 등록 신청 굿즈
            </div>
            <table>
                <thead>
                    <tr>
                    	<td class="goods-num">굿즈 번호</td>
                        <td class="goods-name">굿즈명</td>
                        <td class="goods-applicant">신청자</td>
                        <td class="request-date">요청일</td>
                        <td class="allow-btn"></td>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach items="${requestScope.goodsList}" var="goods">
	                    <tr>
	                        <td class="goods-num">${goods.goodsId}</td>
	                        <td class="goods-name"><a href="/goods/${goodsId}">${goods.goodsName}</a></td>
	                        <td class="goods-applicant"><a href="/profile/${memberId}">${goods.nickname}</a></td>
	                        <td class="request-date"><fmt:formatDate value="${goods.goodsCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                        <td class="allow-btn">
	                            <button class="allowBtn" onclick="allow(${goods.goodsId})">허가</button>
	                            <button class="disallowBtn" onclick="disallow(${goods.goodsId})">불허</button>
	                        </td>
	                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/admin/request/register?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/admin/request/register?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/admin/request/register?pageNum=${pageInfo.endPage + 1}">Next</a>
							</li>
						</c:if>
					</ul>
          		</nav>
            </div>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
<script>
	function allow(goodsId){
	    var result = confirm("등록을 허가합니다.");
	
	    if(result) {
	    	// axios.get를 이용해 해당 굿즈의 ID 넘김, goods 테이블의 등록 status update
	    	
	    	axios.get('http://localhost:8081/request/register/allow/'+goodsId)
				 .then(response => {
					confirm(response.data);
				 })
				 .catch(error => {
				 	confirm(error.response.data);
				 })
	    	
	    	window.location.href = "http://localhost:8081/admin/request/register";
	    }
	};
	function disallow(goodsId){
	    var result = confirm("등록을 불허가합니다.");
	
	    if(result) {
	    	// 불허시 테이블에서 삭제?
	    	
	    	axios.get('http://localhost:8081/request/register/disallow/'+goodsId)
				 .then(response => {
					confirm(response.data);
				 })
				 .catch(error => {
				 	confirm(error.response.data);
				 })
	    	
	    	
	    	window.location.href = "http://localhost:8081/admin/request/delete";
	    }
	};
</script>
</html>