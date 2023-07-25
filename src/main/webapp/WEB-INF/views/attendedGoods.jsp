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
	<link href="/css/attendedGoods.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="main-container">
        <div class="side-menu">
            <div class="menu-container">
            	<div class="menu">
                	굿즈
            	</div>
                <ul>
                    <li id="current-title"><a href="/goods/attended">참여 굿즈 내역</a></li>
                    <li><a href="/goods/registered">등록 굿즈 관리</a></li>
                    <li><a href="/likes">좋아요한 굿즈</a></li>
                    <li><a href="/alarm">알림 신청한 굿즈</a></li>
                </ul>
            </div>
            <div class="menu-container">
                <div class="menu">
                    	내 정보
                </div>
                <ul>
                    <li><a onclick="window.location.href='/profile/edit/${sessionScope.memberId}'">프로필 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
                	참여 굿즈 내역
            </div>
            <div class="table-container">
	            <table class="goods-table">
	                <thead >
	                    <tr>
	                        <td class="goods-name">굿즈명</td>
	                        <td class="payment-date">결제 일자</td>
	                        <td class="status">상태</td>
	                        <td class="detail"></td>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:if test="${empty requestScope.orderList}">
	                		<tr>
	                			<td id="nothing" colspan="4">아직 참여한 굿즈가 없어요!</td>
	                		</tr>
	                	</c:if>
						<!-- 반복 출력 -->
						<c:forEach items="${requestScope.orderList}" var="order">
		                    <tr>
		                        <td class="goods-name"><a href="/goods/${order.goodsId}">${order.goodsName}</a></td>
		                        <td class="payment-date"><fmt:formatDate value="${order.orderCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                        <td class="status">
		                        	<c:if test="${order.ongoingStatus eq 2}">
		                        		<c:if test="${order.productionStatus eq 0}">
		                        			제작 확정
		                        		</c:if>
		                        		<c:if test="${order.productionStatus eq 1}">
											제작 무산	                        		
		                        		</c:if>
		                        	</c:if>
		                        	<c:if test="${order.ongoingStatus eq 1}">
		                        		진행중
		                        	</c:if>
		                        </td>
		                        <td class="detail"><button class="detail-btn" onclick="location.href='/goods/attended/${order.orderId}'">상세</button></td>
		                    </tr>
		                </c:forEach>
	                </tbody>
	            </table>
	        </div>
          	<div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/goods/attended?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/goods/attended?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/goods/attended?pageNum=${pageInfo.endPage + 1}">Next</a>
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