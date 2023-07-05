<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crafty</title>
<link href="/css/myPage.css" rel="stylesheet" type="text/css"/>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="main-container">
        <div class="side-menu">
            <div class="dashboard">
                Dashboard
            </div>
            <hr>
            <div class="menu-container">
                <div class="menu">
                    	굿즈 관리
                </div>
                <ul>
                    <li><a href="#">결제 확인</a></li>
                    <li><a href="#">등록 신청 굿즈</a></li>
                    <li id="current-title"><a href="#">비공개 신청 굿즈</a></li>
                </ul>
            </div>
            <div class="menu-container">
                <div class="menu">
                    	멤버 관리
                </div>
                <ul>
                    <li><a href="#">멤버 확인</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 비공개 신청 굿즈
            </div>
            <table class="goods-table">
                <thead>
                    <tr>
                        <td class="deleteRequest-goodsName">굿즈명</td>
                        <td class="deleteRequest-requestDate">요청일</td>
                        <td class="deleteRequest-requestReason">요청 사유</td>
                        <td class="deleteRequest-allow"></td>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach items="${requestScope.List}" var="goods">
                    	<tr>
	                        <td class="deleteRequest-goodsName"><a href="#">Goods1</a></td>
	                        <td class="deleteRequest-requestDate">2023-06-17</td>
	                        <td class="deleteRequest-requestReason"><a href="#">보기</a></td>
	                        <td class="deleteRequest-allow">
	                            <input type="button" id="allowBtn" value="허가" onclick="allow()"/>
	                            <input type="button" id="disallowBtn" value="불허" onclick="disallow()"/>
	                        </td>
                    	</tr>
                    </c:forEach>
                    <tr>
                        <td class="deleteRequest-goodsName"><a href="#">Goods1</a></td>
                        <td class="deleteRequest-requestDate">2023-06-17</td>
                        <td class="deleteRequest-requestReason"><a href="#">보기</a></td>
                        <td class="deleteRequest-allow">
                            <input type="button" id="allowBtn" value="허가" onclick="allow()"/>
                            <input type="button" id="disallowBtn" value="불허" onclick="disallow()"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/?pageNum=${num}&amount=${pageInfo.pageRequest.amount}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}">Next</a>
							</li>
						</c:if>
					</ul>
          		</nav>
            </div>
        </div>
    </div>
</body>
<script>
	function allow(){
    	var result = confirm("비공개 허가하시겠습니까?");

	    if(result) {
	    	// axios.post를 이용해 해당 상품의 정보 넘기고, goods 테이블의 비공개 status update
	    	
	    	window.location.href = "http://localhost:8081/adminTest2";
	    }
	};
	function disallow(){
	    var result = confirm("비공개 불허가하시겠습니까?");
	
	    if(result) {
	    	// 왜 불허하는지 이유는 안알려줘도 괜찮은가.. ㅋㅋ 생각해보니 글네..
	    	// 상태 변경점 없음
	    	window.location.href = "http://localhost:8081/adminTest2";
	    }
	};
</script>
</html>