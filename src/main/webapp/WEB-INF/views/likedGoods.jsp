<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="/css/likedGoods.css" rel="stylesheet" type="text/css"/>
	<link href="/css/card.css" rel="stylesheet" type="text/css"/>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<link rel="stylesheet" href="path/to/bootstrap-icons.css">
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
                    <li  id="current-title"><a href="/likes">좋아요한 굿즈</a></li>
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
            	좋아요한 굿즈
            </div>
			<div class="cards-container">
				<c:if test="${empty goodsList}">
		        	<div class="nothing">아직 좋아요한 굿즈가 없어요!</div>
		    	</c:if>
				<c:forEach items="${goodsList}" var="goods">
					<div class="card">
						<div class="card-top">
						     <a href="/goods/${goods.goodsId}"><img class="card-image" src="${goods.imgPath}/${goods.imgName}" /></a>
						</div>
						<div class="card-bottom">
							<div class="card-title-container">
								<div class = "card-title"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></div>
								<div class = "card-btn">
	                                <button class="heart-btn" id="unlike-btn" data-like-id="${goods.likeId}">
	                                	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill heart-icon" viewBox="0 0 16 16">
											<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
										</svg>
	                                </button>                                
								</div>
						    </div>
						    <div class="category-and-rate">
								<div class="card-category">${goods.category}</div>
								<div class="bar">|</div>
								<div class="rate">
									<c:set var="rate" value="${(goods.total * 100) / goods.targetAmount}" />
									<%
									   double rateValue = (double)pageContext.getAttribute("rate");
									   DecimalFormat decimalFormat = new DecimalFormat("0.00");
									   String formattedRate = decimalFormat.format(rateValue);
									%>
									<c:set var="formattedRate" value="<%= formattedRate %>" />
									달성률: ${formattedRate}%
								</div>
						    </div>
						    <div class="card-description">${goods.introduction}</div>
						</div>
	                </div>
                </c:forEach>
            </div>
          	<div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/likes?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/likes?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/likes?pageNum=${pageInfo.endPage + 1}">Next</a>
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
    document.addEventListener("DOMContentLoaded", function() {
        var unlikeBtns = document.querySelectorAll("#unlike-btn");
        
        for (var i = 0; i < unlikeBtns.length; i++) {
            unlikeBtns[i].addEventListener("click", function() {
                var likeId = this.getAttribute("data-like-id");
                unlike(likeId);
            });
        }
    });
    
 	// 좋아요 취소 함수
	function unlike(likeId) {
	 
		 if(!('${sessionScope.memberId}')) {
	         window.location.href = "/login";
	     } else {
	    	 var url = "http://localhost:8081/goods/unlike/" + likeId;
			 
	    	 axios.get(url)
			      .then(response => {
			          // 좋아요 성공
			       
			          location.reload();
			       })
			       .catch(error => {
			         // 좋아요 실패
			          console.error("다시 시도해주세요.", error);
			         
			          location.reload();
			       });
	     }
	}

</script>
</html>