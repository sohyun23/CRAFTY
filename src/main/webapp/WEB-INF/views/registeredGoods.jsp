<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crafty</title>
<link href="/css/myPage.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="main-container">
        <div class="side-menu">
            <div class="menu-container">
                <div class="menu">
                    	굿즈
                </div>
                <ul>
                    <li><a href="#">참여 굿즈 내역</a></li>
                    <li id="current-title"><a href="#">등록 굿즈 관리</a></li>
                    <li><a href="#">좋아요한 굿즈</a></li>
                    <li><a href="#">알림 신청한 굿즈</a></li>
                </ul>
            </div>
            <div class="menu-container">
                <div class="menu">
                   	 내 정보
                </div>
                <ul>
                    <li><a href="#">프로필 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 등록 굿즈 관리
            </div>
            <table>
                <thead>
                    <tr>
                        <td class="registeredGoods-goodsName">굿즈명</td>
                        <td class="registeredGoods-createDate">작성 일자</td>
                        <td class="registeredGoods-status">상태</td>
                        <td class="registeredGoods-detail"></td>
                    </tr>
                </thead>
                <tbody>
                    <%-- <c:if test="${empty requestScope.goodsList}">    
						<tr>
					        <td colspan="5">
					            <p align="center"><b><span style="font-size:12pt;">등록한 굿즈가 없습니다!</span></b></p>
					        </td>
					    </tr>
					</c:if> --%>
					<!-- 반복 출력 -->
					<c:forEach items="${requestScope.goodsList}" var="goods">
	                    <tr>
	                        <td class="registeredGoods-goodsName"><a href="#">굿즈명</a></td>
	                        <td class="registeredGoods-createDate">작성 일자</td>
	                        <td class="registeredGoods-status">상태</td>
	                        <td class="registeredGoods-detail"><button onclick="location.href='#'">상세</button></td>
	                    </tr>
	                </c:forEach>
	                <!-- <tr>
                        <td class="registeredGoods-goodsName"><a href="#">굿즈명</a></td>
                        <td class="registeredGoods-createDate">작성 일자</td>
                        <td class="registeredGoods-status">상태</td>
                        <td class="registeredGoods-detail"><button onclick="location.href='#'">상세</button></td>
                    </tr> -->
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
</html>