<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="/css/deleteRequest.css" rel="stylesheet" type="text/css"/>
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
                    <li><a href="/admin/request/register">등록 신청 굿즈</a></li>
                    <li id="current-title"><a href="/admin/request/nondisclosure">비공개 신청 굿즈</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 비공개 신청 굿즈
            </div>
            <table>
                <thead>
                    <tr>
                        <td class="goods-num">굿즈 번호</td>
                        <td class="goods-name">굿즈명</td>
                        <td class="goods-applicant">신청자</td>
                        <td class="request-date">요청일</td>
                        <td class="request-reason">요청 사유</td>
                        <td class="allow-btn"></td>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach items="${requestScope.goodsList}" var="goods">
                    	<tr>
                    		<td class="goods-num">${goods.goodsId}</td>
	                        <td class="goods-name"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></td>
	                        <td class="goods-applicant"><a href="/profile/${goods.memberId}">${goods.nickname}</a></td>
	                        <td class="request-date">${goods.nondisclosureCreatedAt}</td>
	                        <td class="request-reason">${goods.nondisclosureReason}</td>
	                        <td class="allow-btn">
	                            <button class="allowBtn" onclick="allow()">허가</button>
	                            <button class="disallowBtn" onclick="disallow()">불허</button>
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
								<a class="paging-num" aria-label="Previous" href="admin/request/nondisclosure/?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a class="paging-num" href="admin/request/nondisclosure/?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a class="paging-num" aria-label="next" href="admin/request/nondisclosure/?pageNum=${pageInfo.endPage + 1}">Next</a>
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
	function allow(){
    	var result = confirm("비공개 허가하시겠습니까?");

	    if(result) {
	    	// axios.post를 이용해 해당 상품의 정보 넘기고, goods 테이블의 비공개 status update
	    	
	    	window.location.href = "http://localhost:8081/adminTest2";
	    }
	};
	function disallow(){
	    var result = confirm("비공개 불허가하시겠습니까?");
	
	    if(result) {
	    	// 왜 불허하는지 이유는 안알려줘도 괜찮은가.. ㅋㅋ 생각해보니 글네..
	    	// 상태 변경점 없음
	    	window.location.href = "http://localhost:8081/adminTest2";
	    }
	};
</script>
</html>