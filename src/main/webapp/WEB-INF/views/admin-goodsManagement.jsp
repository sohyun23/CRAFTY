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
                    <li id="current-title"><a href="#">결제 확인</a></li>
                    <li><a href="#">등록 신청 굿즈</a></li>
                    <li><a href="#">비공개 신청 굿즈</a></li>
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
               	 결제 확인
            </div>
            <div>
                <select class="pay-dropdown">
                    <option value="">전체</option>
                    <option value="">정산 완료</option>
                    <option value="">모금중</option>
                </select>
            </div>
            <table class="goods-table">
                <thead>
                    <tr>
                        <td class="goodsManagement-name">굿즈명</td>
                        <td class="goodsManagement-seller">판매자</td>
                        <td class="goodsManagement-amount">모금 금액</td>
                        <td class="goodsManagement-payList">결제 리스트</td>
                        <td class="goodsManagement-adjustmentDate">정산 완료일</td>
                        <td class="goodsManagement-adjustmentBtn"></td>
                    </tr>
                </thead>
                <tbody>
                	<%-- <c:if test="${empty requestScope.List}">    
						<tr>
					        <td colspan="5">
					            <p align="center"><b><span style="font-size:12pt;">등록된 굿즈가 없습니다!</span></b></p>
					        </td>
					    </tr>
					</c:if> --%>
					<!-- 반복 출력 -->
					<%-- <c:forEach items="${requestScope.List}" var="goods">
	                    <tr>
	                        <td class="goodsManagement-name"><a href="#">굿즈명</a></td>
	                        <td class="goodsManagement-seller">판매자</td>
	                        <td class="goodsManagement-amount">모금 금액</td>
	                        <td class="goodsManagement-payList"><a href="#" class="link-under">확인</a></td>
	                        <td class="goodsManagement-adjustmentDate">정산 완료일</td>
	                        <td class="goodsManagement-adjustmentBtn">
	                        	<c:if test="${goods.상태 eq "정산하기"}">
	                        		<input type="button" class="adjustmentBtn" value="정산하기" onclick="adjustment()"/>
	                        	</c:if>
                        		${goods.상태}
	                        </td>
	                    </tr>
	                </c:forEach> --%>
	                <tr>
                        <td class="goodsManagement-name"><a href="#">드라마 한니발 레시피북 FEEDING HANNIBAL 출간</a></td>
                        <td class="goodsManagement-seller"><a href="#">세기말풋사과보습학원</a></td>
                        <td class="goodsManagement-amount">918,000,000</td>
                        <td class="goodsManagement-payList"><a href="#" id="pay-list-check">확인</a></td>
                        <td class="goodsManagement-adjustmentDate"></td>
                        <td class="goodsManagement-adjustmentBtn">
							<c:if test="${status eq '정산하기'}">
                        		<input type="button" class="adjustmentBtn" value="정산하기" onclick="adjustment()"/>
                        	</c:if>
                       		<c:if test="${status ne '정산하기'}">
                        		${status}
                        	</c:if>
						</td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/paging?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/paging?pageNum=${num}&amount=${pageInfo.pageRequest.amount}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/paging?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}">Next</a>
							</li>
						</c:if>
					</ul>
          		</nav>
            </div>
        </div>
    </div>
</body>
<script>
	function adjustment(){
	    var result = confirm("정산하시겠어요?");
	
	    if(result) {
	    	// axios 사용해서 해당 상품 정보 넘기고 정산 테이블에 추가 
	    	
	    	window.location.href = "http://localhost:8081/adminTest2";
	    }
	};
</script>
</html>