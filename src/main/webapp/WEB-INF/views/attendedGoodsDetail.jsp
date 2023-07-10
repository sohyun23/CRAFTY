<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Crafty</title>
	<link href="/css/attendedGoodsDetail.css" rel="stylesheet" type="text/css" />
	<link href="/css/common.css" rel="stylesheet" type="text/css" />
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
					<li id="current-title"><a href="/attendedGoods">참여 굿즈 내역</a></li>
					<li><a href="/registeredGoods">등록 굿즈 관리</a></li>
					<li><a href="/likedGoods">좋아요한 굿즈</a></li>
					<li><a href="/alarmedGoods">알림 신청한 굿즈</a></li>
	              </ul>
	          </div>
	          <div class="menu-container">
	              <div class="menu">
	                  	내 정보
	              </div>
	              <ul>
	                  <li><a href="/profileEdit">프로필 수정</a></li>
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
	                  <a id="goods-link" href="/goodsDetail">
	                      <img id="goods-thumbnail" src="/img/mushroom.jpg" alt=""/>
	                  </a>
	              </div>
	              <div class="right">
	                  <div id="goods-name">
	                      <a href="#">${projectName}감자도리와 구마</a>
	                </div>
	                <div id="cancel-btn">
                    	<button onclick="location.href = '#'">참여 취소</button>
                	</div>
	                <%-- <c:if test="${goods.상태 eq '모금중'}">
	                	<div id="attend-cancel">
	                    	<button onclick="location.href = '#'">참여 취소</button>
	                	</div>
	                </c:if> --%>
	               	<div id="delivery-info">
	                   	<form action="http://info.sweettracker.co.kr/tracking/5" method="POST">
							<div class="form-group">
								<input type="hidden" class="form-control" id="t_key" name="t_key" value="${deliveryInfo.key}">
							</div>
							<div class="form-group">
								<input type="hidden" class="form-control" id="t_code" name="t_code" value="${deliveryInfo.code}">
							</div>
							<div class="form-group">
								<input type="hidden" class="form-control" name="t_invoice" id="t_invoice" value="${deliveryInfo.invoice}">
							</div>
							<button type="submit" class="btn btn-default">배송 조회</button>
				 		</form>
				    </div>
	            </div>
	        </div>
	        <div id="bottom">
	            <div class="info-container">
	                <div class="info-title">
	                  	  주문 금액
	                </div>
	                <div class="info-item">
	                    <div class="item-name">
	                       	 ${goodsname}감자도리
	                    </div>
	                    <div class="item-price">
	                        ${price}1000원
	                    </div>
	                </div>
	                <div class="info-item">
	                    <div class="item-name">
	                       	 ${goodsname}구마
	                    </div>
	                    <div class="item-price">
	                        ${price}1000원
	                    </div>
	                </div>
	                <div class="info-item">
	                    <div class="item-name">
	                     	   배송비
	                    </div>
	                    <div class="item-price">
	                        ${deliveryFee}2500원
	                    </div>
	                </div>
	                <hr>
	                <div class="info-item">
	                    <div class="item-total-price">
	                       	 총 금액
	                    </div>
	                    <div class="item-total-price">
	                        ${totalPrice}213544원
	                    </div>
	                </div>
	            </div>
	            <div class="info-container">
	                <div class="info-title">
	                	    수령자
	                </div>
	                <div class="recipient-name">
	                 	 ${name}
	                 	   손원영
	                </div>
	            </div>
	            <div class="info-container">
	                <div class="info-title">
	                  	  연락처
	                </div>
	                <div class="recipient-number">
	                    ${phoneNum}
	                    010-1111-2222
	                </div>
	            </div>
	            <div class="info-container">
	                <div class="info-title">
	                   	 배송지
	                </div>
	                <div class="recipient-address">
	                    <div class="zonecode">
	                        ${zonecode}
	                        50947
	                    </div>
	                    <div class="detail-address1">
	                       	 ${address1}
	                       	 경남 김해시 
	                    </div>
	                    <div class="detail-address2">
	                      	  ${address2}
	                      	  111동 222호
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<%@ include file="footer.jsp" %>
</body>
</html>
