<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Crafty</title>
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/registeredGoodsSalesByItem.css" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> 
</head>
<body>
	<%@ include file="header.jsp" %>
	
    <div class="main-container">
	    <div class="side-menu">
	        <div class="menu-container">
	            <ul>
	                <li><a href="/goods/registered/1">참여 내역</a></li>
	                <li  id="current-title"><a href="/goods/registered/sales/1">품목별 판매량</a></li>
	            </ul>
	        </div>
	    </div>
	    <div class="line"></div>
	    <div class="main-content">
	        <div class="top">
	            <div class="left">
	                <a id="goods-link" href="/goods/${goods.goodsId}">
	                    <img id="goods-thumbnail" src="/img/mushroom.jpg" alt=""/>
	                </a>
	            </div>
	            <div class="right">
	                <div id="goods-name">
	                    <a href="/goods/${goods.goodsId}">감자도리와 구마</a>
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
	            <table id="sales-by-item-table">
	                <thead id="sales-table-head">
	                    <tr>
	                        <td class="item-name">아이템명</td>
	                        <td class="item-price">가격</td>
	                        <td class="sales-num">판매 개수</td>
	                        <td class="order-total-price">판매 금액</td>
	                    </tr>
	                </thead>
	                <tbody id="sales-table-body">
	                	<c:forEach items="${requestScope.itemList}" var="item">
	                		<tr>
		                        <td class="item-name">${item.itemName}</td>
		                        <td class="item-price">${item.itemPrice}</td>
		                        <td class="sales-num">${item.itemSalesNum}</td>
		                        <td class="order-total-price">${item.orderTotalPrice}</td>
		                    </tr>
	                	</c:forEach>
	                    <tr>
	                        <td class="item-name">감자도리</td>
	                        <td class="item-price">1000</td>
	                        <td class="sales-num">189</td>
	                        <td class="order-total-price">189000</td>
	                    </tr>
                        <tr>
	                        <td class="item-name">구마</td>
	                        <td class="item-price">1000</td>
	                        <td class="sales-num">234</td>
	                        <td class="order-total-price">234000</td>
	                    </tr>
	                </tbody>
	            </table>
                <table id="sales-total-table">
                    <thead id="total-table-head">
                        <tr>
                            <td class="total-sales-num">총 판매 개수</td>
	                        <td class="total-sales-price">총 판매 금액</td>
                        </tr>
                    </thead>
                    <tbody id="total-table-body">
                        <tr>
                            <td class="total-sales-num">${totalSalesNum}423</td>
	                        <td class="total-sales-price">${totalSalesPrice}423000원</td>
                        </tr>
                    </tbody>
                </table>
	        </div>
	        
            <!-- 삭제 신청 팝업 -->
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
    })
</script>
</html>