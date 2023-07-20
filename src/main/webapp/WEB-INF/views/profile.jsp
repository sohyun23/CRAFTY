<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crafty</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">
	<link href="/css/common.css" rel="stylesheet" type="text/css">  
    <link href="/css/profile.css" rel="stylesheet" type="text/css">
    <link href="/css/card.css" rel="stylesheet" type="text/css">
    
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="path/to/bootstrap-icons.css">
</head>

<body>
<%@ include file="header.jsp" %>
<div class="content">
    <div class="main-container">
        <div class="top">
            <div class="top-left">
                <img class="profile-img" src="/img/${profile.profileImg}" onerror="this.src='/img/profile.png'">
            </div>
            <div class="top-right">
                <div class="profile-user-settings">
                    <div class="profile-user-name" id="nickname" name="nickname">${profile.nickname}</div>
                    <c:if test="${sessionScope.memberId eq profile.memberId}">
	                    <button class="btn profile-edit-btn" onclick="location.href='/profile/edit'">프로필 수정</button>
                    </c:if>
                </div>
                <div class="profile-bio">${profile.profileIntroduction}</div>
            </div>
        </div>
        <hr>
        <div class="bottom">
            <div class="dropdown-select">
                <select class="ongoing-select">
                    <option value="1">진행중</option>
                    <option value="0">오픈 예정</option>
                </select>
            </div>
            <div class="cards-container">
            	<c:forEach items="${goodsList}" var="goods">
	                <div class="card">
	                    <div class="card-top">
	                        <a href="/goods/${goods.goodsId}"><img class="card-image" src="${goods.imgPath}/${goods.imgName}" /></a>
	                    </div>
	                    <div class="card-bottom">
	                        <div class="card-title-container">
	                            <div class = "card-title"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></div>
	                            <c:if test="${goods.likeId eq 0}">
	                            	<button class="heart-btn" id="like-btn" data-goods-id="${goods.goodsId}">
	                            		<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
										  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
										</svg>
	                            	</button>
	                            </c:if>
	                            <c:if test="${goods.likeId ne 0}">
		                            <button class="heart-btn" id="unlike-btn" data-like-id="${goods.likeId}">
		                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill heart-icon" viewBox="0 0 16 16">
										  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
										</svg>
		                            </button>	                            
	                            </c:if>
	                        </div>
	                        <div class="category-and-rate">
	                            <div class="card-category">${goods.category}</div>
	                            <div class="bar">|</div>
	                            <div class="rate">
									<c:set var="rate" value="${(goods.total * 100) / goods.targetAmount}" />
									<%
									   double rateValue = (double)pageContext.getAttribute("rate");
									   DecimalFormat decimalFormat = new DecimalFormat("0.0");
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
        </div>
        <div class="pagination-box">
       		<nav class="pagination-nav">
       			<ul class="pagination">
					<c:if test="${pageInfo.prev}">
						<li>
							<a aria-label="Previous" href="/profile/${profile.memberId}?pageNum=${pageInfo.startPage - 1}">Prev</a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
							<a href="/profile/${profile.memberId}?pageNum=${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageInfo.next}">
						<li>
							<a aria-label="next" href="/profile/${profile.memberId}?pageNum=${pageInfo.endPage + 1}">Next</a>
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
		var likeBtns = document.querySelectorAll("#like-btn");
		var unlikeBtns = document.querySelectorAll("#unlike-btn");
		
		for (var i = 0; i < likeBtns.length; i++) {
			likeBtns[i].addEventListener("click", function() {
	            var goodsId = this.getAttribute("data-goods-id");
	            like(goodsId);
	            console.log(goodsId);
	        });
	    }
		
		for (var i = 0; i < unlikeBtns.length; i++) {
			unlikeBtns[i].addEventListener("click", function() {
	            var likeId = this.getAttribute("data-like-id");
	            unlike(likeId);
	        });
	    }
	});
	
	// 좋아요 함수
	function like(goodsId) {
		var url = "http://localhost:8081/goods/like/" + goodsId;
		
		axios.get(url)
		     .then(response => {
				 // 좋아요 성공
		      
				 location.reload();
		     })
		     .catch(error => {
		        // 좋아요 실패
		         /* console.error("다시 시도해주세요.", error); */
		         confirm(error.response.data);
		         location.reload();
		     });
		
	}
	
	// 좋아요 취소 함수
	function unlike(likeId) {
		var url = "http://localhost:8081/goods/unlike/" + likeId;
		console.log(likeId);
		axios.get(url)
			 .then(response => {
				 // 좋아요 취소 성공
		      	
				 location.reload();
		      })
		      .catch(error => {
		        // 좋아요 취소 실패
		         console.error("다시 시도해주세요.", error);
		        
		         location.reload();
		      });
	}

</script>
</html>