<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/deleteRequest.css" rel="stylesheet" type="text/css"/>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
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
                    <li><a href="/goodsManagement">등록 굿즈</a></li>
                    <li><a href="/registerRequest">등록 신청 굿즈</a></li>
                    <li id="current-title"><a href="/deleteRequest">비공개 신청 굿즈</a></li>
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
                	<c:forEach items="${requestScope.List}" var="goods">
                    	<tr>
                    		<td class="goods-num">${goods.num}</td>
	                        <td class="goods-name"><a href="/goodsDetail">${goods.name}</a></td>
	                        <td class="goods-applicant"><a href="/profile">${goods.applicant}</a></td>
	                        <td class="request-date">${goods.requestDate}</td>
	                        <td class="request-reason"><a href="#">보기</a></td>
	                        <td class="allow-btn">
	                            <button class="allowBtn" onclick="allow()">허가</button>
	                            <button class="disallowBtn" onclick="disallow()">불허</button>
	                        </td>
                    	</tr>
                    </c:forEach>
                    <tr>
                    	<td class="goods-num">2324496</td>
                        <td class="goods-name"><a href="/goodsDetail">감자도리와 구마</a></td>
                        <td class="goods-applicant"><a href="/profile">감자도리사랑단</a></td>
                        <td class="request-date">2023-06-17</td>
                        <td class="request-reason"><a href="#">보기</a></td>
                        <td class="allow-btn">
                            <button class="allowBtn" onclick="allow()">허가</button>
	                        <button class="disallowBtn" onclick="disallow()">불허</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a class="paging-num" aria-label="Previous" href="/?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a class="paging-num" href="/?pageNum=${num}&amount=${pageInfo.pageRequest.amount}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a class="paging-num" aria-label="next" href="/?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}">Next</a>
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