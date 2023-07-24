<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Crafty</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css" />
	<link href="/css/attendedGoodsDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="main-container">
	      <div class="side-menu">
	          <div class="menu-container">
	              <div class="menu">
	                  	굿즈
	              </div>
	              <ul>
					<li id="current-title"><a href="/goods/attended">참여 굿즈 내역</a></li>
                    <li><a href="/goods/registered">등록 굿즈 관리</a></li>
                    <li><a href="/likes">좋아요한 굿즈</a></li>
                    <li><a href="/alarm">알림 신청한 굿즈</a></li>
	              </ul>
	          </div>
	          <div class="menu-container">
	              <div class="menu">
	                  	내 정보
	              </div>
	              <ul>
	                  <li><a href="/profile/edit">프로필 수정</a></li>
	              </ul>
	          </div>
	      </div>
	      <div class="line"></div>
	      <div class="main-content">
	          <div class="title">
	            	  참여 굿즈 상세 내역
	          </div>
	          <div class="top">
	              <div class="left">
	                  <a id="goods-link" href="/goods/${order.goodsId}">
	                      <img id="goods-thumbnail" src="${order.imgPath}/${order.imgName}" alt=""/>
	                  </a>
	              </div>
	              <div class="right">
	                  <div id="goods-name">
	                      <a href="/goods/${order.goodsId}">${order.goodsName}</a>
	                </div>
	                <c:if test="${order.deliveryStatus ne '배송중'}">
	                	<div id="attend-cancel">
	                    	<button onclick="location.href = '#'">참여 취소</button>
	                	</div>
	                </c:if>
	                <c:if test="${order.deliveryStatus eq '배송중'}">
		               	<div id="delivery-info">
		                   	<form action="http://info.sweettracker.co.kr/tracking/5" method="POST">
								<div class="form-group">
									<input type="hidden" class="form-control" id="t_key" name="t_key" value="${deliveryKey}">
								</div>
								<div class="form-group">
									<input type="hidden" class="form-control" id="t_code" name="t_code" value="${order.deliveryCompany}">
								</div>
								<div class="form-group">
									<input type="hidden" class="form-control" name="t_invoice" id="t_invoice" value="${order.deliveryNum}">
								</div>
								<button type="submit" class="btn btn-default">배송 조회</button>
					 		</form>
					    </div>
	                </c:if>
	            </div>
	        </div>
	        <div id="bottom">
	            <div class="info-container">
	                <div class="info-title">
	                  	  주문 금액
	                </div>
	                <c:forEach items="${itemList}" var="item">
		                <div class="info-item">
		                    <div class="item-name">
		                       	 ${item.itemName}
		                    </div>
		                    <div class="item-price">
		                        ${item.itemPrice}원
		                    </div>
		                </div>
	                </c:forEach>
	                <div class="info-item">
	                    <div class="item-name">
	                     	   배송비
	                    </div>
	                    <div class="item-price">
	                        ${order.deliveryFee}원
	                    </div>
	                </div>
	                <hr>
	                <div class="info-item">
	                    <div class="item-total-price">
	                       	 총 금액
	                    </div>
	                    <div class="item-total-price">
	                        ${order.totalAmount}원
	                    </div>
	                </div>
	            </div>
	            <div class="info-container">
	                <div class="info-title">
	                	    수령자
	                </div>
	                <div class="recipient-name">
	                 	 ${order.name}
	                </div>
	            </div>
	            <div class="info-container">
	                <div class="info-title">
	                  	  연락처
	                </div>
	                <div class="recipient-number">
	                    ${order.phoneNum}
	                </div>
	            </div>
	            <div class="info-container">
	                <div class="info-title">
	                   	 배송지
	                </div>
	                <div class="recipient-address">
	                    <div class="zonecode">
	                        ${order.zoneCode}
	                    </div>
	                    <div class="detail-address1">
	                       	 ${order.roadAddress}
	                    </div>
	                    <div class="detail-address2">
	                      	  ${order.detailAddress}
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<%@ include file="footer.jsp" %>
</body>
</html>
