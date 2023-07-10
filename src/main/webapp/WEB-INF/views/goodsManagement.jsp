<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<link href="/css/goodsManagement.css" rel="stylesheet" type="text/css"/>
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %>

	<div class="dashboard-container">
        <div class="side-menu">
            <div class="dashboard">
                Dashboard
            </div>
            <div class="hr-container">
        		<hr>
    		</div>
            <div class="menu-container">
                <div class="menu">
                    	굿즈 관리
                </div>
                <ul>
                    <li id="current-title"><a href="/goodsManagement">등록 굿즈</a></li>
                    <li><a href="/registerRequest">등록 신청 굿즈</a></li>
                    <li><a href="/deleteRequest">비공개 신청 굿즈</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 등록 굿즈
               	<div>
	                <select>
	                    <option value="">전체</option>
	                    <option value="">정산 완료</option>
	                    <option value="">모금중</option>
	                </select>
	            </div>
            </div>            
            <table>
                <thead>
                    <tr>
                    	<td class="goods-num">굿즈 번호</td>
                        <td class="goods-name">굿즈명</td>
                        <td class="goods-seller">판매자</td>
                        <td class="total-amount">모금액</td>
                        <td class="attend-list">참여자</td>
                        <td class="adjustment-date">정산일</td>
                        <td class="adjustment-status">정산</td>
                        <td class="adjustment-amount">정산 금액</td>
                    </tr>
                </thead>
                <tbody>
					<!-- 반복 출력 -->
					<c:forEach items="${requestScope.goodsList}" var="goods">
	                    <tr>
	                    	<td class="goods-num">${goods.num}</td>
	                        <td class="goods-name"><a href="/goodsDetail">${goods.name}</a></td>
	                        <td class="goods-seller"><a href="profile">${goods.seller}</a></td>
	                        <td class="total-amount">${goods.totalAmount}</td>
	                        <td class="attend-list"><a href="/purchaserList">확인</a></td>
	                        <td class="adjustment-date">${goods.adjustmentDate}</td>
	                        <td class="adjustment-status">${goods.adjustmentStatus}</td>
	                        <td class="adjustment-amount">${goods.adjustmentAmount}</td>
	                    </tr>
	                </c:forEach>
	                <tr>
	                	<td class="goods-num">882125</td>
                        <td class="goods-name"><a href="/goodsDetail">드라마 한니발 레시피북 FEEDING HANNIBAL</a></td>
                        <td class="goods-seller"><a href="/profile">세기말풋사과보습</a></td>
                        <td class="total-amount">423000000</td>
                        <td class="attend-list"><a href="/purchaserList">확인</a></td>
                        <td class="adjustment-date">2022-06-21</td>
                        <td class="adjustment-status">정산 완료</td>
	                        <td class="adjustment-amount">401850</td>
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
    
    <%@ include file="footer.jsp" %>
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