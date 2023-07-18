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
<link href="/css/mainLayout.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="path/to/bootstrap-icons.css">
<style type="text/css">
	.main-search-category-container {
		width : 100%;
	}
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<!-- ======================================================= -->
<div class = "main-search-category-container">
	<div class = "main-search-category-bundle">
		<div class="main-category">
			<div class="main-category-container">
				<div class="main-category-list">
					<c:forEach var="cList" items="${categoryList}"> 
						<c:if test="${pageProperties.category == cList}">
							<div class="main-category-cell active">${cList}</div>
						</c:if>
						<c:if test="${pageProperties.category != cList}">
							<div class="main-category-cell">${cList}</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	
		<div class = "main-search">
			<form class="search-container" id="search-container">
				<input type="text" id="search-bar" placeholder="search">
				
				<div class="search-bar-BTN"><img class="search-icon" src="http://www.endlessicons.com/wp-content/uploads/2012/12/search-icon.png"></div>
			</form>
		</div>
	</div>
</div>
	
<!-- ======================================================= -->
<div class="main-container">
	<div class = "main-total-container">
		
		<div class="main-bar">
			<div class="main-bar-title"><h1>메인</h1></div>
			<div class="main-bar-dropdown-bundle">
				<select class="main-bar-dropdown main-bar-dropdown-1" onchange="goMain('dropdown1', this.value)">
					<c:if test="${pageProperties.ongoing == 1}">
						<option class="main-bar-dropdown-option" selected>진행중</option>
						<option class="main-bar-dropdown-option">진행 예정</option>
						<option class="main-bar-dropdown-option">종료</option>				
					</c:if>
					<c:if test="${pageProperties.ongoing == 0}">
						<option class="main-bar-dropdown-option">진행중</option>
						<option class="main-bar-dropdown-option" selected>진행 예정</option>
						<option class="main-bar-dropdown-option">종료</option>				
					</c:if>
					<c:if test="${pageProperties.ongoing == 2}">
						<option class="main-bar-dropdown-option">진행중</option>
						<option class="main-bar-dropdown-option">진행 예정</option>
						<option class="main-bar-dropdown-option" selected>종료</option>				
					</c:if>		
				</select>
				<select class="main-bar-dropdown main-bar-dropdown-2" onchange="goMain('dropdown2', this.value)">
					<c:if test="${pageProperties.order == 0}">
						<option class="main-bar-dropdown-option" selected>인기순</option>
						<option class="main-bar-dropdown-option">최신순</option>
					</c:if>
					<c:if test="${pageProperties.order == 1}">
						<option class="main-bar-dropdown-option">인기순</option>
						<option class="main-bar-dropdown-option" selected>최신순</option>
					</c:if>
				</select>
			</div>
		</div>
		
	<!-- ======================================================= -->
		
	<div class="cards-container">
		
		<c:forEach var="card" items="${goodsList}">
			
			<div class="card">
				<div class="card-top"><a href="/goods/${card.goodsId}"><img class="card-image" src="${card.imgPath}/${card.imgName}" /></a></div>
				<div class="card-bottom">
					<div class="card-title-container">
						<div class = "card-title"><a href="/goods/${card.goodsId}">${card.goodsName}</a></div>
						<c:if test="${card.likeId eq 0}">
                            <button class="heart-btn" id="like-btn" data-goods-id="${card.goodsId}">
                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                	<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                                </svg>
                            </button>
                        </c:if>
                        <c:if test="${card.likeId ne 0}">
                            <button class="heart-btn" id="unlike-btn" data-like-id="${card.likeId}">
                            	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill heart-icon" viewBox="0 0 16 16">
                                	<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                            	</svg>
                            </button>                                
                        </c:if>
					</div>
					
					<div class="category-and-rate">
						<div class="card-category">${card.category}</div>
						<div class="bar">|</div>
						<div class="rate">
							<c:set var="rate" value="${(card.total * 100) / card.targetAmount}" />
							<%
							   double rateValue = (double)pageContext.getAttribute("rate");
							   DecimalFormat decimalFormat = new DecimalFormat("0.0");
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
		
	<!-- ======================================================= -->
		<div class="pagination-box">
			<nav class="pagination-nav">
				<ul class="pagination">
					
					<c:if test="${pageInfo.prev}">
						<li><a aria-label="Previous" class = "paginationBTN Previous">Prev</a></li>
					</c:if>
					
					<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:if test="${pageInfo.pageRequest.pageNum == num}">
							<li class="paginationBTNList"><a class="paginationBTN page active">${num}</a></li>
						</c:if>
						<c:if test="${pageInfo.pageRequest.pageNum != num}">
							<li class="paginationBTNList"><a class="paginationBTN page">${num}</a></li>
						</c:if>

					</c:forEach>
					
					<c:if test="${pageInfo.next}">
						<li><a aria-label="next" class = "paginationBTN next">Next</a></li>
					</c:if>
				
				</ul>
			</nav>
		</div>
	</div>
</div>


<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">	
	
	//==================================== 클릭 할당 함수 및 기능==================================
	// 폼 제출 이벤트를 감지하여 URL을 동적으로 구성하고 페이지로 이동	
	document.getElementById('search-container').addEventListener('submit', function(event) {
		event.preventDefault(); // 폼 제출 기본 동작 취소
		console.log('들어옴');
		var keyword = document.getElementById('search-bar').value; // 검색어 값 가져오기
		var url = '/main/search?keyword=' + encodeURIComponent(keyword) +'&category=전체&ongoing=1&order=0&pageNum=1&amount=8'; // URL 동적 구성
		window.location.href = url; // 페이지 이동
	});
	
	let elements = document.getElementsByClassName("paginationBTN");
	for (var i = 0; i < elements.length; i++) {
		  elements[i].addEventListener("click", goMain);
		}
	
	let categorys= document.getElementsByClassName("main-category-cell");
	for (var i = 0; i < categorys.length; i++) {
		categorys[i].addEventListener("click", goMain);
		}
	
	
	let searchIcon = document.getElementsByClassName("search-icon");
	console.log(searchIcon);
	searchBTN.addEventListener("click", goSearchMain);
	
	
	function goSearchMain() {
		
		console.log(document.getElementsById("search-bar").value);
		
		let url = '/main/search?keyword=' + keyword + '&category=전체&ongoing=1&order=0&pageNum=1&amount=8';
	}
	
	
	function goMain(state, value){	
		let keyword = '${pageInfo.pageRequest.keyword}';
		let category = '${pageProperties.category}';
		let ongoing = ${pageProperties.ongoing};
		let order = ${pageProperties.order};
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
		} else if (state == 'dropdown2') {
			pageNum = 1;
			if (value == '인기순') {
				order = 0;
			} else if (value == '최신순') {
				order = 1;
			}
		} else if (clickValue == "전체" || clickValue == "푸드" || clickValue == "잡화" || clickValue == "뷰티" || clickValue == "유아" || clickValue == "반려동물") {	
			pageNum = 1;
			category = clickValue;
		} else {				
			if (clickValue == "Next") {
				pageNum = ${pageInfo.endPage} + 1;
			} else if (clickValue == "Prev") {
				pageNum = ${pageInfo.startPage} - 1
			} else {
				pageNum = clickValue;
			}	
		}
		
		let url = '/main/search?keyword=' + keyword +
					'&category=' + category +
					'&ongoing=' + ongoing +
					'&order=' + order +
					'&pageNum=' + pageNum + 
					'&amount=' + amount;

		window.location.href = url;	
	}
	
	
	
	
	
	
</script>

</body>
<script>
	//==================================== like, unlike 함수==================================
	
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
</script>
</html>