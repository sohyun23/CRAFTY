<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
<head>
	<title>main</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<link href="/css/common.css" rel="stylesheet" type="text/css">
	<link href="/css/card.css" rel="stylesheet" type="text/css">
	<link href="/css/main.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="path/to/bootstrap-icons.css">
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<!-- ======================================================= -->	<div class="main-search-container">
		<div class="main-search">
			<form class="search-container" id="search-container">
				<input type="text" id="search-bar" placeholder="search">		
				<button class="search-bar-BTN"><img class="search-icon" src="http://www.endlessicons.com/wp-content/uploads/2012/12/search-icon.png"></button>
			</form>
		</div>
	</div>
		
	<!-- ======================================================= -->
	<div class="main-container">
		<div class="banner"><img src="/craftyImg/banner.png"></div>
		<div class="today-most-order-goods">
			<div class="title">
				<h2>오늘 사람들이 가장 많이 참여한 굿즈</h2>
				<h2 class="order-more">더보기 ></h2>
			</div>
			<div class="cards-container">
				<c:if test="${empty mostOrderGoodsList}"><div class="nothing">오늘은 아무도 참여하지 않았어요!</div></c:if>
				<c:forEach var="card" items="${mostOrderGoodsList}">
					<div class="card">
						<div class="card-top"><a href="/goods/${card.goodsId}"><img class="card-image" src="${card.imgPath}/${card.imgName}" /></a></div>
						<div class="card-bottom">
							<div class = "card-title"><a href="/goods/${card.goodsId}">${card.goodsName}</a></div>
							<div class="category-and-rate">
								<div class="card-category">${card.category}</div>
								<div class="bar">|</div>
								<div class="rate">
									<c:set var="rate" value="${(card.total * 100) / card.targetAmount}" />
									<%
									   double rateValue = (double)pageContext.getAttribute("rate");
									   DecimalFormat decimalFormat = new DecimalFormat("0.00");
									   String formattedRate = decimalFormat.format(rateValue);
									%>
									<c:set var="formattedRate" value="<%= formattedRate %>" />
									달성률 : ${formattedRate}%
								</div>
							</div>
							<div class="card-description">${card.introduction}</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	
		<div class="debut-goods">
			<div class="title">
				<h2>오늘 오픈한 굿즈</h2>
				<h2 class="debut-more">더보기 ></h2>
			</div>
			<div class="cards-container">
				<c:if test="${empty debutGoodsList}"><div class="nothing">오늘 오픈한 굿즈가 없어요!</div></c:if>
				<c:forEach var="card" items="${debutGoodsList}">
					<div class="card">
						<div class="card-top"><a href="/goods/${card.goodsId}"><img class="card-image" src="${card.imgPath}/${card.imgName}" /></a></div>
						<div class="card-bottom">
							<div class = "card-title"><a href="/goods/${card.goodsId}">${card.goodsName}</a></div>
							<div class="category-and-rate">
								<div class="card-category">${card.category}</div>
								<div class="bar">|</div>
								<div class="rate">
									<c:set var="rate" value="${(card.total * 100) / card.targetAmount}" />
									<%
									   double rateValue = (double)pageContext.getAttribute("rate");
									   DecimalFormat decimalFormat = new DecimalFormat("0.00");
									   String formattedRate = decimalFormat.format(rateValue);
									%>
									<c:set var="formattedRate" value="<%= formattedRate %>" />
									달성률 : ${formattedRate}%
								</div>
							</div>
							<div class="card-description">${card.introduction}</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="open-scheduled-goods">
			<div class="title">
				<h2>오픈 예정 굿즈</h2>
				<h2 class="schduled-more">더보기 ></h2>
			</div>
			<div class="cards-container">
				<c:if test="${empty openScheduledGoodsList}"><div class="nothing">오픈 예정인 굿즈가 없어요!</div></c:if>
				<c:forEach var="card" items="${openScheduledGoodsList}">
					<div class="card">
						<div class="card-top"><a href="/goods/${card.goodsId}"><img class="card-image" src="${card.imgPath}/${card.imgName}" /></a></div>
						<div class="card-bottom">
							<div class = "card-title"><a href="/goods/${card.goodsId}">${card.goodsName}</a></div>
							<div class="category-and-rate">
								<div class="card-category">${card.category}</div>
							</div>
							<div class="card-description">${card.introduction}</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
<script type="text/javascript">	
	
	//==================================== 클릭 할당 함수 및 기능==================================
	// 폼 제출 이벤트를 감지하여 URL을 동적으로 구성하고 페이지로 이동	
	document.getElementById('search-container').addEventListener('submit', function(event) {
		event.preventDefault(); // 폼 제출 기본 동작 취소
		var keyword = document.getElementById('search-bar').value; // 검색어 값 가져오기
		var url = '/main/search?keyword=' + encodeURIComponent(keyword); // URL 동적 구성
		window.location.href = url; // 페이지 이동
	});
	
</script>
</html>