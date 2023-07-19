<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodsDetail</title>
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/goodsDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	<%@ include file="header.jsp" %>
	<div class="main-container">
		<!-- action, method -->
		<div class="top-row">
			<div class="top-left">
				<div id="thumbnail-box">
					<img class="thumbnail" src="/img/${thumbnailImgName}" />
				</div>
				<div id="detail">
					${goods.introduction}
				</div>
				<!-- input 빼고 div안에 삽입되도록 -->
			</div>
			<!-- 박스크기 정하기 -->
			<div class="top-right">
				<div id="block1">
					<div id="goods-name">${goods.goodsName}</div>

					<div id="goods-list">
                        <div id="goods-select" onclick="toggleItemContainer()">
                            <div id="select-text">======아이템을 선택해주세요=====</div>
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                <path id="chevron-path" fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                            </svg>
                        </div>
                        <div id="item-container">
                        	<c:forEach items="${itemList}" var="item">
                        		<div class="item">
	                                <div class="item-name">${item.itemName}</div>
	                                <div class="item-price">${item.itemPrice}</div>
	                                <div class="item-config">${item.itemComposition}</div>
	                            </div>
                        	</c:forEach>
                        </div>
                    </div>
                    <div id="selected-item">선택 아이템</div>
						
					<div id="goods-composition">
						<ul id="goods-cart"></ul>
					</div>
				</div>
				<div class="price-cal">
					<div class="cal-name">
						<div id="total-goods">총 상품 금액</div>
						<div id="total-price" value="0">
							0원
							<!--db에서 받아온 정보를 더하기-->
						</div>
					</div>
					<div class="cal-name">
						<div id="delivery">배송 금액</div>
						
						<div id="delivery-price" value="2500">2500원</div>
						<!--db에서 받아온 정보를 출력하기-->
					</div>
					
					<hr>
					
					<div class="cal-name">
						<div id="total-pay-amount">총 결제 금액</div>
						<div id="total-pay-amount-price" value="0">0원</div>
						<!--db에서 받아온 정보를 더하기-->
					</div>
					<div>
						<a href="#">
							<img id="API-icon" src="/craftyimg/payicon.png" alt="결제">
						<a>
					</div>
				</div>
		
			</div>
		</div>
		
		<hr>
		
		<div id="expbottom">
			<div id="seller-container">
				<a href="/profile/${goods.memberId}"><img id="profile" alt="프로필사진" src="/img/${goods.profileImg}"></a>
				<div id="seller-name"><a href="/profile/${goods.memberId}">${goods.nickname}</a></div>
			</div>
			<!-- 상품설명 -->
			<div id="goods-explanation">
				<figure><img src="/img/${contentImgName}" alt=""></figure>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
<script>
	const goodsList = document.getElementById("goods-list");
	const goodsCart = document.getElementById("goods-cart");
	
	let totalPrice = 0;
	let totalPayPrice = 0;
	let itemIndex = 0; //변수 선언
	const totalPriceElement = document.getElementById('total-price');
	const deliveryElement = document.getElementById('delivery-price');
	const totalPayPriceElement = document.getElementById('total-pay-amount-price');
	//해당 ID를 가진 곳에서 요소 들고오기. const는 변하지 않을 값, let은 변할 값
	
	function plusList(itemName, itemPrice){
		let items = document.getElementsByClassName('items-name') // class가 items인 모든 노드를 전부 가져오기
	
		for(i=0; i<items.length; i++){ 
			if(itemName === items[i].textContent){ //goodsList에서 가져온 value를 items에 있는 value 들과 일치하는지 비교
				alert("이미 선택하셨습니다.");
				return; //일치하면 alert 출력하고 입력하지 않고 돌아감
			}
		}
	
		const createitem = document.createElement("li");
		//createitem 이라는 id의 li 요소를 생성할 것
		
		createitem.innerHTML = '<div class="item-box">' +
	                            '<div class="items-name" id="selected-items-name" value="' + itemName + '">' + itemName + '</div>' +
	                            '<div class="items-price" id="selected-items-price" value="' + itemPrice + '">' + itemPrice + '원</div>' +
								'<button class="item-delete" id="delete-btn" onclick="deleteitem(' + itemPrice + ')">삭제</button>'+
								'<div>';
		goodsCart.appendChild(createitem);
		
		const delivery = parseInt(deliveryElement.getAttribute('value'));
		let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
		//각 변수 Element의 value값을 가져와서 숫자만 추출함
		
		totalPrice += parseInt(itemPrice);
		// itemPrice를 정수로 변환하여 totalPrice 변수에 더함
	
		totalPriceElement.innerHTML = totalPrice + "원";
		// totalPrice를 문자열로 변환, 원과 연결, total~ 요소의 내용으로 설정. innerHTML은 요소 내용 결정하는 것
		
		totalPayPrice = totalPrice + delivery;
	
		console.log(totalPrice);
		
		totalPayPriceElement.setAttribute("value", totalPayPrice);
		totalPayPriceElement.innerHTML = totalPayPrice + "원";
	}
	
	function deleteitem(itemPrice) {
		console.log("----")
		console.log(itemPrice)
		
		let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
		
		//total~Element의 value값 가져와서 정수변환
		console.log(event.target);
		console.log(event.target.parentElement);
		const removingOne = event.target.parentElement.parentElement; //이벤트 발생한 요소의 부모요소의 부모 선택
		removingOne.remove();//removingOne 제거
		
		totalPrice -= itemPrice;
		totalPriceElement.setAttribute("value", totalPrice);
		totalPriceElement.innerHTML = totalPrice + "원";
		
		console.log("totalPayPrice: ", totalPayPrice);
		console.log("price: ", itemPrice);
		totalPayPrice -= itemPrice;
		
		console.log("totalPayPrice: ", totalPayPrice);
	
	    if(totalPrice == 0) {
	        totalPayPriceElement.setAttribute("value", 0);
	        totalPayPriceElement.innerHTML = 0 + "원";
	    } else {
	        totalPayPriceElement.setAttribute("value", totalPayPrice);
	        totalPayPriceElement.innerHTML = totalPayPrice + "원";
	    }
	
	
		//totalPayPrice : 0, price : NaN, totalPayPrice : NaN
		//처음 0 공통, price는 NaN->2500->1000 순으로 변화, totaLPayPrice2는 NaN->2500->4000으로 변화
	}
	
	function toggleItemContainer() {
	    var itemContainer = document.getElementById("item-container");
	    var chevronPath = document.getElementById("chevron-path");
	
	    if (itemContainer.style.display === "none") {
	        itemContainer.style.display = "block";
	        chevronPath.setAttribute("d", "M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z");
	    } else {
	        itemContainer.style.display = "none";
	        chevronPath.setAttribute("d", "M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z");
	    }
	}
	
	// item-container의 item 클래스를 클릭하면 plusList() 함수에 해당 아이템 이름과 가격 전달
	const items = document.querySelectorAll(".item");
	for (let i = 0; i < items.length; i++) {
	    items[i].addEventListener("click", function() {
	        const itemName = this.querySelector(".item-name").textContent;
	        const itemPrice = this.querySelector(".item-price").textContent;
	        plusList(itemName, itemPrice);
	    });
	}
</script>
</html>