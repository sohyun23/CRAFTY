<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="/css/alarmedGoods.css" rel="stylesheet" type="text/css"/>
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
                    <li><a href="/goods/registered">등록 굿즈 관리</a></li>
                    <li><a href="/likes">좋아요한 굿즈</a></li>
                    <li id="current-title"><a href="/alarm">알림 신청한 굿즈</a></li>
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
            	알림 신청한 굿즈
            </div>
            <c:forEach items="${sessionScope.goodsList}" var="goods">
            	<div class="main-card">
					<div class="main-card-image-holder">
						<img class="main-card-image" src="https://source.unsplash.com/300x225/?wave" alt="wave" />
					</div>
					<div class="main-card-title-contianer-total">
						<div class="main-card-title-container">
							<div class ="main-card-title">
								<div class = "main-card-title-big"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></div>
								<div class = "main-card-title-small"></div>
							</div>
							<div class = "main-card-btn-container">
								<a href="#" class="main-card-btn">ASD</a>
							</div>
						</div>
						<div class="main-card-description">
							${goods.introduction}
						</div>
					</div>
				</div>
            </c:forEach>
          	<div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/alarm?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/alarm?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/alarm?pageNum=${pageInfo.endPage + 1}">Next</a>
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