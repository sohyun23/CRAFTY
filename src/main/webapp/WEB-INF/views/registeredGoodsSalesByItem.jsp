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
	                <li><a href="/goods/registered/${goods.goodsId}">참여 내역</a></li>
	                <li  id="current-title"><a href="/goods/registered/sales/${goods.goodsId}">품목별 판매량</a></li>
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
		                        <td class="sales-num">${item.salesTotalNum}</td>
		                        <td class="order-total-price">${item.salesTotalAmount}원</td>
		                    </tr>
	                	</c:forEach>
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
                            <td class="total-sales-num">${goods.salesTotalNum}</td>
	                        <td class="total-sales-price">${goods.salesTotalAmount}원</td>
                        </tr>
                    </tbody>
                </table>
	        </div>
	        
            <!-- 삭제 신청 팝업 -->
            <div class="popup" id="delete-popup">
                <h2>삭제 신청</h2>
                
                <form id="delete-form" action="http://localhost:8081/sales/request/delete/submit" method="POST">
                    <textarea placeholder="삭제 신청 사유를 적어주세요." name="deleteReason" maxlength="50" required></textarea>
                    <input type="hidden" id="request-goods-id" name="goodsId" value="${goods.goodsId}"></input>
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
</script>
</html>