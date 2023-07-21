<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	                <li  id="current-title"><a href="/goods/registered/${goods.goodsId}">참여 내역</a></li>
	                <li><a href="/goods/registered/sales/${goods.goodsId}">품목별 판매량</a></li>
	            </ul>
	        </div>
	    </div>
	    <div class="line"></div>
	    <div class="main-content">
	        <div class="top">
	            <div class="left">
	                <a id="goods-link" href="/goods/${goods.goodsId}">
	                    <img id="goods-thumbnail" src="${goods.imgPath}/${goods.imgName}" alt=""/>
	                </a>
	            </div>
	            <div class="right">
	                <div id="goods-name">
	                    <a href="/goods/${goods.goodsId}">${goods.goodsName}</a>
	                </div>
	                <div id="goods-period">
	                	기간 : ${goods.startDate} - ${goods.endDate}
	                </div>
	                <div id="attend-number">
	                	참여 수 : ${goods.salesNum}
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
	                	<c:if test="${empty requestScope.orderList}">
	                		<tr>
	                			<td id="nothing" colspan="6">주문건이 존재하지 않습니다!</td>
	                		</tr>
	                	</c:if>
	                	<c:if test="${not empty requestScope.orderList}">
		                	<c:forEach items="${requestScope.orderList}" var="order">
		                		<tr>
			                        <td class="order-num">${order.orderId}</td>
			                        <td class="order-date"><fmt:formatDate value="${order.orderCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			                        <td class="order-item">${order.orderItems}</td>
			                        <td class="order-total-price">${order.totalAmount}</td>
			                        <td class="order-nickname"><a href="/profile/${order.memberId}">${order.nickname}</a></td>
			                        <td class="delivery-info">
			                        	<c:if test="${not empty order.deliveryNum}">
			                        		<div id="delivery-num">${order.deliveryNum}</div>
			                        	</c:if>
			                        	<c:if test="${empty order.deliveryNum}">
			                        		<button id="delivery-popup-btn" data-order-id="${order.orderId}">등록</button>
			                        	</c:if>
			                        </td>
		                    	</tr>
		                	</c:forEach>
		                </c:if>
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
                
                <form action="http://localhost:8081/request/delete/submit" method="POST">
                    <textarea placeholder="삭제 신청 사유를 적어주세요." name="deleteReason" maxlength="" required></textarea>
                    <input type="hidden" id="request-goods-id" name="goodsId" value="${goods.goodsId}"></input>
                    <div class="form-btn">
                        <input class="submit-btn" type="submit" />
                        <input class="reset-btn" type="reset" />
                    </div>
                </form>
            </div>
            <div class="popup" id="delivery-popup">
                <h2>운송장 번호 등록</h2>
                
                <form action="http://localhost:8081/delivery/info/submit" id="delivery-form" method="POST">
                    <div id="delivery-info">
                        <select id="delivery-popup-company" name="company">
                            <option value="04">CJ대한통운</option>
                            <option value="05">한진택배</option>
                            <option value="08">롯데택배</option>
                            <option value="01">우체국택배</option>
                            <option value="06">로젠택배</option>
                        </select>
                        <input type="text" id="delivery-popup-num" placeholder="운송장 번호" name="deliveryNum" required/>
                        <input type="hidden" id="delivery-order-id" name="orderId" value=""></input>
                        <input type="hidden" id="delivery-goods-id" name="goodsId" value="${goods.goodsId}"></input>
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
	// popup 실행 함수
	document.addEventListener("DOMContentLoaded", function() {
	    var deletePopupBtn = document.getElementById("delete-popup-btn");
	    var deletePopup = document.getElementById("delete-popup");
	    var deleteForm = document.getElementById("delete-form");
	    var requestGoodsId = document.querySelector("input[name='goodsId']");
	
	    deletePopupBtn.addEventListener("click", function() {
	        deletePopup.style.display = "block";
	    });
		
	    // 팝업 영역 외의 부분 클릭 시 사라짐 
	    document.addEventListener("mouseup", function(e) {
	        if (!deletePopup.contains(e.target)) {
	            deletePopup.style.display = "none";
	        }
	    });
	});
	
	// 운송장 번호 등록 팝업
    var deliveryPopupBtns = document.querySelectorAll("#delivery-popup-btn");
    var deliveryPopup = document.getElementById("delivery-popup");
    var deliveryForm = document.getElementById("delivery-form");
    var deliveryOrderId = document.getElementById("delivery-order-id");

    function openDeliveryPopup(orderId) {
        deliveryOrderId.value = orderId;
        deliveryPopup.style.display = "block";
    }

    for (var i = 0; i < deliveryPopupBtns.length; i++) {
        deliveryPopupBtns[i].addEventListener("click", function() {
            var orderId = this.getAttribute("data-order-id");
            openDeliveryPopup(orderId);
        });
    }

    // 팝업 영역 외의 부분 클릭 시 사라짐 
    document.addEventListener("mouseup", function(e) {
        if (!deliveryPopup.contains(e.target)) {
            deliveryPopup.style.display = "none";
        }
    });
	
</script>
</html>
