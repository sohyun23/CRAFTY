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
               <select class="ongoing-select" onchange="profile('dropdown1', this.value)">
                   <c:if test="${ongoing == 1}">
					<option selected>진행중</option>
					<option>진행 예정</option>
					<option>종료</option>				
				</c:if>
				<c:if test="${ongoing == 0}">
					<option>진행중</option>
					<option selected>진행 예정</option>
					<option>종료</option>				
				</c:if>
				<c:if test="${ongoing == 2}">
					<option>진행중</option>
					<option>진행 예정</option>
					<option selected>종료</option>				
				</c:if>		
               </select>
           </div>
           <div class="cards-container">
           	<c:if test="${empty goodsList}">
           		<c:if test="${ongoing == 0}">
           			<div class="nothing">진행 예정인 굿즈가 존재하지 않아요!</div>
           		</c:if>
           		<c:if test="${ongoing == 1}">
           			<div class="nothing">진행중인 굿즈가 존재하지 않아요!</div>
           		</c:if>
           		<c:if test="${ongoing == 2}">
           			<div class="nothing">종료된 굿즈가 존재하지 않아요!</div>
           		</c:if>
           	</c:if>
           	<c:forEach items="${goodsList}" var="goods">
                <div class="card">
                    <div class="card-top">
                        <a href="/goods/${goods.goodsId}"><img class="card-image" src="${goods.imgPath}/${goods.imgName}" /></a>
                    </div>
                    <div class="card-bottom">
                        <div class="card-title-container">
                            <div class = "card-title"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></div>
                            <!-- 진행중 : 좋아요 버튼 -->
							<c:if test="${ongoing == 1}">
								<!-- 좋아요 안한 굿즈: 빈 하트 -->
								<c:if test="${card.likeId eq 0}">
		                            <button class="heart-btn" id="like-btn" data-goods-id="${card.goodsId}">
		                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
		                                	<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
		                                </svg>
		                            </button>
		                        </c:if>
		                        <!-- 좋아요한 굿즈: 채워진 하트 -->
		                        <c:if test="${card.likeId ne 0}">
		                            <button class="heart-btn" id="unlike-btn" data-like-id="${card.likeId}">
		                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill heart-icon" viewBox="0 0 16 16">
		                                	<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
		                            	</svg>
		                            </button>                                
		                        </c:if>
							</c:if>
							<!-- 진행 예정: 알람 버튼 -->
							<c:if test="${ongoing == 0}">
								<!-- 알람설정 안한 굿즈: 빈 종 -->
								<c:if test="${card.alarmId eq 0}">
		                            <button class="alarm-btn" id="alarm-btn" data-goods-id="${card.goodsId}">
		                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
										  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
										</svg>
		                            </button>
		                        </c:if>
		                        <!-- 알람설정한 굿즈: 채워진 종 -->
		                        <c:if test="${card.alarmId ne 0}">
		                            <button class="alarm-btn" id="unalarm-btn" data-alarm-id="${card.alarmId}">
		                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bell-fill bell-btn" viewBox="0 0 16 16">
											<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
										</svg>
		                            </button>                                
		                        </c:if>
							</c:if>
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
<%@ include file="footer.jsp" %>
</body>
<script>
	// 드롭다운 & 페이지네이션
	let elements = document.getElementsByClassName("paginationBTN");
	for (var i = 0; i < elements.length; i++) {
		  elements[i].addEventListener("click", profile);
	}
	
	function profile(state, value){	
		let ongoing = ${ongoing};
		let pageNum = ${pageInfo.pageRequest.pageNum};
		let amount = ${pageInfo.pageRequest.amount};
		
		let clickValue = event.target.textContent;
		
		if (state == 'dropdown1') {
			pageNum = 1;
			if (value == '진행중') {
				ongoing = 1;
			} else if (value == '진행 예정') {
				ongoing = 0;
			} else {
				ongoing = 2;
			}
		} else {				
			if (clickValue == "Next") {
				pageNum = ${pageInfo.endPage} + 1;
			} else if (clickValue == "Prev") {
				pageNum = ${pageInfo.startPage} - 1
			} else {
				pageNum = clickValue;
			}	
		}
		
		let url = '/profile/' + ${profile.memberId} +
					'?ongoing=' + ongoing +
					'&pageNum=' + pageNum + 
					'&amount=' + amount;

		window.location.href = url;	
	}
	
	
	// 좋아요 & 알람신청 버튼
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
	    // 세션에 멤버 아이디 존재하지 않으면 로그인 페이지로 이동
	    if(!('${sessionScope.memberId}')) {
	        window.location.href = "/login";
	    } else {
	        
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
	}
	
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