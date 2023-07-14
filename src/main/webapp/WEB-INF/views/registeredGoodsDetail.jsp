<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Crafty</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> 
	<link href="/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="/css/registeredGoodsDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@ include file="header.jsp" %>
	
    <div class="main-container">
	    <div class="side-menu">
	        <div class="menu-container">
	            <ul>
	                <li id="current-title"><a href="/goods/registered/1">참여 내역</a></li>
	                <li><a href="/goods/registered/sales/1">품목별 판매량</a></li>
	            </ul>
	        </div>
	    </div>
	    <div class="line"></div>
	    <div class="main-content">
	        <div class="top">
	            <div class="left">
	                <a id="goods-link" href="/goods/1">
	                    <img id="goods-thumbnail" src="/img/mushroom.jpg" alt=""/>
	                </a>
	            </div>
	            <div class="right">
	                <div id="goods-name">
	                    <a href="/goods/1">감자도리와 구마</a>
	                </div>
	                <div id="goods-period">
	                	기간 : 1111-11-11 - 9999-99-99
	                </div>
	                <div id="attend-number">
	                	참여 수 : 5
	                </div>
	                <button id="delete-popup-btn">삭제 신청</button>
	            </div>
	        </div>
	        <div id="bottom">
	            <table>
	                <thead>
	                    <tr>
	                        <td class="order-num">주문 번호</td>
	                        <td class="order-date">주문 시간</td>
	                        <td class="order-item">주문 아이템</td>
	                        <td class="order-total-price">총 상품 금액</td>
	                        <td class="order-nickname">닉네임</td>
	                        <td class="delivery-num">운송장 번호</td>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${requestScope.orderList}" var="order">
	                		<tr>
		                        <td class="order-num">${order.orderNum}</td>
		                        <td class="order-date">${order.orderCreatedAt}</td>
		                        <td class="order-item">
		                            <c:forEach items="${requestScope.itemList}" var="item">
		                            	<div>${item.itemName}</div>
		                            </c:forEach>
		                        </td>
		                        <td class="order-total-price">${order.orderTotalPrice}</td>
		                        <td class="order-nickname">${order.nickname}</td>
		                        <td class="delivery-info">
		                        	<c:if test="${not empty order.deliveryNum}">
		                        		<div id="delivery-num">${order.deliveryNum}</div>
		                        	</c:if>
		                        	<c:if test="${empty order.deliveryNum}">
		                        		<div id="delivery-popup-btn">등록</div>
		                        	</c:if>
		                        </td>
	                    	</tr>
	                	</c:forEach>
	                    <tr>
	                        <td class="order-num">1943329</td>
	                        <td class="order-date">2023-06-22</td>
	                        <td class="order-item-list">
	                            <div class="order-item">감자도리</div>
	                            <div>구마</div>
	                        </td>
	                        <td class="order-total-price">24,500</td>
	                        <td class="order-nickname">주황버섯</td>
	                        <td class="delivery-info">
	                        	<!-- <div>458672132</div> -->
	                        	<button id="delivery-popup-btn">등록</button>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	        <div class="pagination-box">
          		<nav class="pagination-nav">
          			<ul class="pagination">
						<c:if test="${pageInfo.prev}">
							<li>
								<a aria-label="Previous" href="/goods/registered/${goods.goodsId}?pageNum=${pageInfo.startPage - 1}">Prev</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li	class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}">
								<a href="/goods/registered/${goods.goodsId}?pageNum=${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageInfo.next}">
							<li>
								<a aria-label="next" href="/goods/registered/${goods.goodsId}?pageNum=${pageInfo.endPage + 1}">Next</a>
							</li>
						</c:if>
					</ul>
          		</nav>
            </div>
            <!-- 삭제 신청, 운송장 번호 등록 팝업 -->
            <div class="popup" id="delete-popup">
                <h2>삭제 신청</h2>
                
                <form action="http://localhost:8081/deletePopupText" method="POST">
                    <textarea placeholder="삭제 신청 사유를 적어주세요." name="deleteReason" required></textarea>
                    <div class="form-btn">
                        <input class="submit-btn" type="submit" />
                        <input class="reset-btn" type="reset" />
                    </div>
                </form>
            </div>
            <div class="popup" id="delivery-popup">
                <h2>운송장 번호 등록</h2>
                
                <form action="http://localhost:8081/deliveryPopupText" id="delivery-form" method="POST">
                    <div id="delivery-info">
                        <select id="delivery-popup-company" name="company">
                            <option value="04">CJ대한통운</option>
                            <option value="05">한진택배</option>
                            <option value="08">롯데택배</option>
                            <option value="01">우체국택배</option>
                            <option value="06">로젠택배</option>
                        </select>
                        <input type="text" id="delivery-popup-num" placeholder="운송장 번호" name="deliveryNum" required/>
                    </div>
                    <div class="form-btn">
                        <input class="submit-btn" type="submit" value="등록"/>
                        <input class="reset-btn" type="reset" value="초기화"/>
                    </div>
                </form>
            </div>
	    </div>
	</div>
	
	<%@ include file="footer.jsp" %>
</body>
<script>
	$(function() {
		  
	    // contact form animations
	    $('#delete-popup-btn').click(function() {
	        $('#delete-popup').fadeToggle();
	    })
	    $(document).mouseup(function (e) {
	        var container = $("#delete-popup");
	
	        if (!container.is(e.target) // if the target of the click isn't the container...
	            && container.has(e.target).length === 0) // ... nor a descendant of the container
	        {
	            container.fadeOut();
	        }
	    });
	
	    $('#delivery-popup-btn').click(function() {
	        $('#delivery-popup').fadeToggle();
	    })
	    $(document).mouseup(function (e) {
	        var container = $("#delivery-popup");
	
	        if (!container.is(e.target) // if the target of the click isn't the container...
	            && container.has(e.target).length === 0) // ... nor a descendant of the container
	        {
	            container.fadeOut();
	        }
	    });
	});
</script>
</html>
