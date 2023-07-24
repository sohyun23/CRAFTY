<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="/css/registeredGoods.css" rel="stylesheet" type="text/css"/>
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
                    <li><a href="/goods/attended">참여 굿즈 내역</a></li>
                    <li id="current-title"><a href="/goods/registered">등록 굿즈 관리</a></li>
                    <li><a href="/likes">좋아요한 굿즈</a></li>
                    <li><a href="/alarm">알림 신청한 굿즈</a></li>
                </ul>
            </div>
            <div class="menu-container">
                <div class="menu">
                   	 내 정보
                </div>
                <ul>
                    <li><a href="/profile/edit">프로필 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 등록 굿즈 관리
            </div>
            <div class="table-container">
	            <table>
	                <thead>
	                    <tr>
	                        <td class="goods-name">굿즈명</td>
	                        <td class="create-date">작성 일자</td>
	                        <td class="status">상태</td>
	                        <td class="detail"></td>
	                    </tr>
	                </thead>
	                <tbody>
						<c:if test="${empty requestScope.goodsList}">
	                		<tr>
	                			<td id="nothing" colspan="4">아직 등록한 굿즈가 없어요!</td>
	                		</tr>
	                	</c:if>
						<c:forEach items="${requestScope.goodsList}" var="goods">
		                    <tr>
		                        <td class="goods-name"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></td>
		                        <td class="create-date">${goods.goodsCreatedAt}</td>
		                        <td class="status"> <!-- ongoingStatus, productionStatus, registrationStatus -->
		                        	<c:if test="${goods.registrationStatus eq 1}"> <!-- 등록 상태 -->
		                        		<c:if test="${goods.ongoingStatus eq 0}"> <!-- 오픈 예정 상태 -->
		                        			오픈 예정
		                        		</c:if>
		                        		<c:if test="${goods.ongoingStatus eq 1}"> <!-- 진행중 상태 -->
		                        			진행중
		                        		</c:if>
		                        		<c:if test="${goods.ongoingStatus eq 2}">	<!-- 종료 상태 -->
		                        			<c:if test="${goods.productionStatus eq 0}"> <!-- 제작 확정 상태 -->
		                        				제작 확정
		                        			</c:if>
		                        			<c:if test="${goods.productionStatus eq 1}"> <!-- 제작 무산 상태 -->
		                        				제작 무산
		                        			</c:if>
		                        		</c:if>
		                        	</c:if>
		                        	<c:if test="${goods.registrationStatus eq 0}"> <!-- 미등록 상태 -->
		                        		등록 요청중
		                        	</c:if>
		                        </td>
		                        <td class="detail"><button class="detail-btn" onclick="location.href='/goods/registered/${goods.goodsId}'">상세</button></td>
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
								<a aria-label="Previous" href="/goods/registered?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/goods/registered?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/goods/registered?pageNum=${pageInfo.endPage + 1}">Next</a>
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