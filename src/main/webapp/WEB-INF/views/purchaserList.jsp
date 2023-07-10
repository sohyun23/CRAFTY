<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/purchaserList.css" rel="stylesheet" type="text/css"/>
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
                    <li id="current-title"><a href="/goodsManagement">등록 굿즈</a></li>
                    <li><a href="/registerRequest">등록 신청 굿즈</a></li>
                    <li><a href="/deleteRequest">비공개 신청 굿즈</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 주문 목록
            </div>            
            <table>
                <thead>
                    <tr>
                    	<td class="order-num">주문 번호</td>
                        <td class="order-purchaser">구매자</td>
                        <td class="order-date">결제 날짜</td>
                        <td class="order-means">결제 수단</td> <!-- 이거 하려면 결제 테이블에 수단도 저장해야됨 -->
                        <td class="order-amount">결제 금액</td>
                    </tr>
                </thead>
                <tbody>
					<!-- 반복 출력 -->
					<c:forEach items="${requestScope.orderList}" var="order">
	                    <tr>
	                    	<td class="order-num">${order.num}</td>
	                        <td class="order-purchaser"><a href="/profile">${order.purchaser}</a></td>
	                        <td class="order-date">${order.date}</td>
	                        <td class="order-means">${order.means}</td>
	                        <td class="order-amount">${order.amount}</td>
	                    </tr>
	                </c:forEach>
	                <tr>
	                	<td class="order-num">3465465</td>
                        <td class="order-purchaser"><a href="/profile">감자도리야</a></td>
                        <td class="order-date">23-07-10 12:45:11</td>
                        <td class="order-means">카카오페이</td>
                        <td class="order-amount">5500</td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/paging?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/paging?pageNum=${num}&amount=${pageInfo.pageRequest.amount}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/paging?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}">Next</a>
							</li>
						</c:if>
					</ul>
          		</nav>
            </div>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>