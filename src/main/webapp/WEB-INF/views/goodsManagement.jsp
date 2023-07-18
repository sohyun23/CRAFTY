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
                    <li id="current-title"><a href="/admin/goods">등록 굿즈</a></li>
                    <li><a href="/admin/request/register">등록 신청 굿즈</a></li>
                    <li><a href="/admin/request/nondisclosure">비공개 신청 굿즈</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 등록 굿즈
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
                        <td class="adjustment-amount">정산 금액</td>
                        <td class="adjustment-status">정산</td>
                    </tr>
                </thead>
                <tbody>
					<!-- 굿즈 리스트 출력 -->
					<c:forEach items="${requestScope.goodsList}" var="goods">
	                    <tr>
	                    	<td class="goods-num">${goods.goodsId}</td>
	                        <td class="goods-name"><a href="/goods/${goods.goodsId}">${goods.goodsName}</a></td>
	                        <td class="goods-seller"><a href="/profile/${goods.memberId}">${goods.nickname}</a></td>
	                        <td class="total-amount">${goods.amount}</td>
	                        <td class="attend-list"><a href="/admin/goods/${goods.goodsId}">확인</a></td>
	                        <td class="adjustment-date">
	                        	<c:if test="${goods.adjustmentCreatedAt ne '1111-11-11'}">
	                        		${goods.adjustmentCreatedAt}
	                        	</c:if>
	                        </td>
	                        <td class="adjustment-amount">
	                        	<c:if test="${goods.lastTotalAmount ne 0}">
	                        		${goods.lastTotalAmount}
	                        	</c:if>
	                        </td>
	                        <td class="adjustment-status">
	                        	<c:if test="${goods.lastTotalAmount ne 0}">
	                        		정산 완료
	                        	</c:if>
	                        </td>
	                    </tr>
	                </c:forEach>
                </tbody>
            </table>
            <!-- 페이지네이션 -->
            <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/admin/goods?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/admin/goods?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/admin/goods?pageNum=${pageInfo.endPage + 1}">Next</a>
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
	
</script>
</html>