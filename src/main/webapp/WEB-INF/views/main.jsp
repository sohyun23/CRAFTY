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
				<a href="#"><img class="search-icon" src="http://www.endlessicons.com/wp-content/uploads/2012/12/search-icon.png"></a>
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
				<select class="main-bar-dropdown main-bar-dropdown-1">
					<option class="main-bar-dropdown-option">진행중</option>
					<option class="main-bar-dropdown-option">진행 예정</option>
					<option class="main-bar-dropdown-option">종료</option>
				</select>
				<select class="main-bar-dropdown main-bar-dropdown-2">
					<option class="main-bar-dropdown-option">인기순</option>
					<option class="main-bar-dropdown-option">최신순</option>
				</select>
			</div>
		</div>
		
	<!-- ======================================================= -->
		
	<div class="main-cards">
		<div class="main-card">
			<div class="main-card-image-holder">
				<img class="main-card-image" src="https://source.unsplash.com/300x225/?wave" alt="wave" />
			</div>
			<div class="main-card-title-contianer-total">
				<div class="main-card-title-container">
					<div class ="main-card-title">
						<div class = "main-card-title-big">Card title</div>
						<div class = "main-card-title-small">여기에 카테고리 또는 달성률 기입</div>
					</div>
					<div class = "main-card-btn-container">
						<a href="#" class="main-card-btn">ASD</a>
					</div>
				</div>
				<div class="main-card-description">
					This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
				</div>
			</div>
		</div>
	</div>
	<!-- ======================================================= -->
		<div class="pagination-box">
			<nav class="pagination-nav">
				<ul class="pagination">
					
					<c:if test="${pageInfo.prev}">
						<li><a aria-label="Previous" href="/main?pageNum=${pageInfo.startPage - 1}">Prev</a></li>
					</c:if>
					
					<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<li class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}"><a href="/main?pageNum=${num}">${num}</a></li>
					</c:forEach>
					
					<c:if test="${pageInfo.next}">
						<li><a aria-label="next" href="/main?pageNum=${pageInfo.endPage + 1}">Next</a></li>
					</c:if>
				
				</ul>
			</nav>
		</div>
	</div>
</div>

<%@ include file="footer.jsp" %>

<script type="text/javascript">
	
	function getDept(deptno){
	  let detailForm = document.getElementById("detailForm");
	  detailForm.deptno = deptno;
	  detailForm.action = '/deleteDept.do';
	  detailForm.method = 'POST';
	  detailForm.submit();
	}
	


	
</script>

</body>
</html>