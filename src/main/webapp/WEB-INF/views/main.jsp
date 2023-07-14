<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>main</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<link href="css/common.css" rel="stylesheet" type="text/css">
<link href="css/mainLayout.css" rel="stylesheet" type="text/css">
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
					<div class="main-category-cell">전체</div>
					<div class="main-category-cell">푸드</div>
					<div class="main-category-cell">잡화</div>
					<div class="main-category-cell">뷰티</div>
					<div class="main-category-cell">유아</div>
					<div class="main-category-cell">반려동물</div>
				</div>
			</div>
		</div>
	
		<div class = "main-search">
			<form class="search-container" action="">
				<input type="text" id="search-bar" placeholder="search">
				<a href="/main/search?keyword={keyword}&ongoing=진행중&order=인기순&pageNum=1&amount=8"><img class="search-icon" src="http://www.endlessicons.com/wp-content/uploads/2012/12/search-icon.png"></a>
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
					<option class="main-bar-dropdown-option" selected>진행중</option>
					<option class="main-bar-dropdown-option">진행 예정</option>
					<option class="main-bar-dropdown-option">종료</option>
				</select>
				<select class="main-bar-dropdown main-bar-dropdown-2" onchange="goMain('dropdown2', this.value)">
					<option class="main-bar-dropdown-option" selected>인기순</option>
					<option class="main-bar-dropdown-option">최신순</option>
				</select>
			</div>
		</div>
		
	<!-- ======================================================= -->
		
	<div class="main-cards">
	
		
		<c:forEach var="card" items="${goodsList}">
	
			<div class="main-card">
				<div class="main-card-image-holder">
					<img class="main-card-image" src="${card.imgPath}" alt="wave" />
				</div>
				<div class="main-card-title-contianer-total">
					<div class="main-card-title-container">
						<div class ="main-card-title">
							<div class = "main-card-title-big">${card.goodsName}</div>
							<div class = "main-card-title-small">${card.category}</div>
						</div>
						<div class = "main-card-btn-container">
							<a href="#" class="main-card-btn">ASD</a>
						</div>
					</div>
					<div class="main-card-description">
						${card.introduction}
					</div>
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
						<li class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}"><a class="paginationBTN page">${num}</a></li>
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

<!--
href="/링크?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}"

href="/링크?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}"
-->


<script type="text/javascript">
	let dropdown1 = document.getElementsByClassName("main-bar-dropdown-1");
	console.log(dropdown1.options);
	
	
	let elements = document.getElementsByClassName("paginationBTN");
	for (var i = 0; i < elements.length; i++) {
		  elements[i].addEventListener("click", goMain);
		}
	
	function getDept(deptno){
	  let detailForm = document.getElementById("detailForm");
	  detailForm.deptno = deptno;
	  detailForm.action = '/deleteDept.do';
	  detailForm.method = 'POST';
	  detailForm.submit();
	}

	function goMain(state, value){	
		let search;
		let onGoing;
		let order;
		let pageNum;
		let amount = 8;
		
		if (state == 'dropdown1') {
			pageNum = 1;
			if (value == '진행중') {
				onGoing = 1;
			} else if (value == '진행 예정') {
				onGoing = 0;
			} else {
				onGoing = 2;
			}
		} else if (state == 'dropdown2') {
			pageNum = 1;
			if (value == '인기순') {
				onGoing = 0;
			} else if (value == '최신순') {
				onGoing = 1;
			}
		} else {
			let clickedElement = event.target;
			let clickValue = clickedElement.textContent;
			
			let dropdown1 = document.getElementsByClassName("main-bar-dropdown-1");
			let dropdown2 = document.getElementsByClassName("main-bar-dropdown-2");
			
			//dropdown1.options[dropdown1.selectedIndex].text;
			
			
			if (clickValue == "Next") {
				console.log('clear1');
			} else if (clickValue == "Prev") {
				console.log('clear2');
			} else {
				pagenum = clickValue;
			}
			
			
		}
		
		

	}
	
</script>

</body>
</html>