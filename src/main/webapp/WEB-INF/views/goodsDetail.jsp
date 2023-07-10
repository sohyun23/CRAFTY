<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodsDetail</title>
    <link href="/resources/css/goodsDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<div id="main-container">
	<!-- action, method -->
		<div class="top-row">
			<div id="top-left">
				<div id="thumbnail-box">
					<img class="thumbnail" alt="thumbnail" src="/resources/images/image1.png" />
				</div>
				<div id="detail">
					ddddddddddd
					qwdqqqqqqqqqqq
					qwdqqqqqqqqqqq
					qwdqqqqqqqqqqq
				</div>
				<!-- input 빼고 div안에 삽입되도록 -->
			</div>
			<!-- 박스크기 정하기 -->
			<div class="top-right">
				<div id="block1">
					<div id="goods-name">굿즈 이름</div>

					<form action="/goodsDetail" medthod="POST">
						<select name="goods-list" id="goods-list" onchange="plusList()">
							<option>---------선택해주세요---------</option>
							<option>감자도리 2500</option>
							<option>구마 1000</option>
						</select>
						<!-- <input id="listSubmit" type="button" onclick="plusList()" value="확인"> -->
					</form>
						
					<div id="goods-composition">
						<ul id="goods-cart"></ul>
							
					</div>
				</div>
				
				
				<div class="price-cal">
					<div class="cal-name">
						<div id="total-goods">총 상품 금액</div>
						<div id="total-price" value="0">
							0
							<!--db에서 받아온 정보를 더하기-->
							<!--위에 드롭다운 삽입방식처럼 넣기 같은 라인이어야함-->
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
						
						<div id="total-pay-amount-price" value="0">
							0
						</div>
						<!--db에서 받아온 정보를 더하기-->
					</div>
					<div id="API-icon">
						<span>aaa</span>
					</div>
				</div>
		
			</div>
		</div>
		
		<hr>
		
		<div id="expbottom">
			<div id="seller-container">
				<img id="profile" alt="프로필사진" src="/resources/images/profile.png">
				<div id="seller-name">판매자 닉네임</div>
			</div>
			<!-- 상품설명 -->
			<div id="goods-explanation">
				<figure><img src="/resources/images/image1.png" alt=""></figure>
			</div>
		</div>
</div>
</body>
<script>
function hello(){
	console.log('안녕하세요');
}


const itemName = document.getElementById("item-name");
const itemPrice = document.getElementById("item-price");
// const itemComposition = document.getElementById("itemComposition");
const itemQuantity = document.getElementById("item-quantity");

const itemList = document.getElementById("item-list");
 
const goodsList = document.getElementById("goods-list");
const goodsCart = document.getElementById("goods-cart");
	// for문 안에서 li 안의 value랑 비교
	// ul 태그 안에 li
	// li 안에 돌아서 요소 비교
	// ul안에 몇개 있는지
	// goodsList에서 선택한 value값(2 아님)
/*
    변경 사항 요약
    1. 굳이 Child() 기능을 사용하지 않는다. 
    2. 대신 132번 줄을 통해 생성된 항목의 클래스 명이 'items'이므로 document.getElementsByClassName('items')를 통해 전부 조회한다
    3. 사용자가 새로운 상품을 추가할 때 2번에서 조회된 items와 전부 비교하여 해당 상품이 있을 경우 alert를 호출한다. (154 ~ 159번 줄) 
*/
let totalPrice = 0;
let totalPayPrice = 0;
const totalPriceElement = document.getElementById('total-price');
const deliveryElement = document.getElementById('delivery-price');
let totalPayPriceElement = document.getElementById('total-pay-amount-price');
function plusList(){
	const value = (goodsList.options[goodsList.selectedIndex].value);//goodsList 에서 선택된 option의 value를 지정
	let items = document.getElementsByClassName('items') // 135번 줄에서 생성된 class가 items인 모든 노드를 전부 가져오기

	for(i=0; i<items.length; i++){ 
		if($('#goods-list').val() == items[i].value){ //goodsList에서 가져온 value를 items에 있는 value 들과 일치하는지 비교
			alert("이미 선택하셨습니다.");
			return;//일치하면 alert 출력하고 입력하지 않고 돌아감
		}
	}

	const createitem = document.createElement("li");
	//createitem 이라는 id의 li 요소를 생성할 것
	
	createitem.innerHTML = `<span class="item-box">
							<input class="items" value='${value}' type="text" disabled/>
							<button class="item-delete" id="delete-btn" onclick="deleteitem(event)">삭제</button>
							<span>`;
	goodsCart.appendChild(createitem); 

	let price = (goodsList.options[goodsList.selectedIndex].value);
	let deliver = parseInt(deliveryElement.getAttribute('value'));
	let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
	
	totalPrice += parseInt(price.split(' ')[1]);

	totalPriceElement.innerHTML = totalPrice;
	
	console.log(totalPrice);
	
	
	
	totalPayPrice = totalPrice + deliver;

	console.log(typeof(deliver));
	
	totalPayPriceElement.innerHTML = totalPayPrice;

}

function deletegoods(event) {
	  console.log(event.target);

	  console.log(event.target.parentElement);
	  const removingOne = event.target.parentElement.parentElement;
	  alert(removingOne);
	  removingOne.remove();
}



</script>
</html>