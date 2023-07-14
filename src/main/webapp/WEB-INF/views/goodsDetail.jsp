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
					<img class="thumbnail" alt="thumbnail" src="/img/image1.png" />
				</div>
				<div id="detail">
					칫솔만 들면 도망가는 우리 댕댕이 양치하기 참 힘들었다.. 이젠 물고 뜯고 즐기는 허니콤케어로 쉽게 케어하세요.
				</div>
				<!-- input 빼고 div안에 삽입되도록 -->
			</div>
			<!-- 박스크기 정하기 -->
			<div class="top-right">
				<div id="block1">
					<div id="goods-name">굿즈 이름</div>

					<form action="/goodsDetail" method="POST">
						<select name="goods-list" id="goods-list" onchange="plusList()">
							<option>---------선택해주세요---------</option>
							<option>감자도리 2500</option>
							<option>구마 1000</option>
							<option>새 1500</option>
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
				<img id="profile" alt="프로필사진" src="/img/profile.png">
				<div id="seller-name"><a href="/profile/${goods.nickname}"></a>판매자 닉네임</div>
			</div>
			<!-- 상품설명 -->
			<div id="goods-explanation">
				<figure><img src="/img/image1.png" alt=""></figure>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
<script>
function hello(){
	console.log('안녕하세요');
}


const itemName = document.getElementById("item-name");
const itemPrice = document.getElementById("item-price");
// const itemComposition = document.getElementById("itemComposition");
const itemQuantity = document.getElementById("item-quantity");

//const itemList = document.getElementById("item-list");
 
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
let itemIndex = 0; //변수 선언
const totalPriceElement = document.getElementById('total-price');
const deliveryElement = document.getElementById('delivery-price');
const totalPayPriceElement = document.getElementById('total-pay-amount-price');
//해당 ID를 가진 곳에서 요소 들고오기. const는 변하지 않을 값, let은 변할 값

function plusList(){
	const value = (goodsList.options[goodsList.selectedIndex].value);//goodsList 에서 선택된 option의 value를 지정
	let items = document.getElementsByClassName('items') // class가 items인 모든 노드를 전부 가져오기

	for(i=0; i<items.length; i++){ 
		if($('#goods-list').val() == items[i].value){ //goodsList에서 가져온 value를 items에 있는 value 들과 일치하는지 비교
			alert("이미 선택하셨습니다.");
			return;//일치하면 alert 출력하고 입력하지 않고 돌아감
		}
	}

	const createitem = document.createElement("li");
	//createitem 이라는 id의 li 요소를 생성할 것
	let price = (goodsList.options[goodsList.selectedIndex].value);
	//price 변수는 굿즈리스트의 select 목록 값을 가져옴
	
	createitem.innerHTML = '<span class="item-box">' +
							'<input class="items" id="selected-items" value="" type="text" disabled/>'+
							'<button class="item-delete" id="delete-btn" onclick="deleteitem(' + itemIndex + ')">삭제</button>'+
							'<span>';
	goodsCart.appendChild(createitem); 
	
	itemIndex = (++itemIndex)%(goodsList.options.length-1);
	//변수값 1 증가시킨 뒤, 이것을 goodsList~length-1로 나눈 나머지 값을 itemIndex에 할당함 
	
	
	const delivery = parseInt(deliveryElement.getAttribute('value'));
	let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
	//각 변수 Element의 value값을 가져와서 숫자만 추출함
	
	totalPrice += parseInt(price.split(' ')[1]);
	//공백에서 첫번쨰 글자부터 가격값을 정수로 변환하여 totalPrice 변수에 더함

	totalPriceElement.innerHTML = totalPrice + "원";
	//totalPrice를 문자열로 변환, 원과 연결, total~ 요소의 내용으로 설정. innerHTML은 요소 내용 결정하는 것
	
	let index = document.getElementsByClassName("items").length -1;
	//클래스가 items인 것들을 고르고 .length 개수 나타낸 뒤 1 빼고 index 변수에 해당 값 할당, 더하기 식에 관여
	document.getElementsByClassName("items")[index].setAttribute("value",price);
	//index value 속성을 price 값으로 설정
	
	
	console.log('---');
	console.log(price);
	
	totalPayPrice = totalPrice + delivery;

	//console.log(typeof(delivery));
	console.log(totalPrice);
	
	totalPayPriceElement.setAttribute("value", totalPayPrice);
	totalPayPriceElement.innerHTML = totalPayPrice + "원";
}

function deleteitem(itemIndex) {
	
	let itemPrice = goodsList.options[itemIndex + 1].value;//goodsList options에서 itemIndex 값들 가져옴
	console.log("----")
	console.log(itemPrice)
	//goods-list가 아니라 total-price 아래의 것으로 해야함
	
	let price = parseInt(itemPrice.split(' ')[1]);//공백 뒤에서부터 숫자 들고 옴
	
	let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
	
	//total~Element의 value값 가져와서 정수변환
	console.log(event.target);
	console.log(event.target.parentElement);
	const removingOne = event.target.parentElement.parentElement;//이벤트 발생한 요소의 부모요소의 부모 선택
	removingOne.remove();//removingOne 제거
	
	totalPrice -= price;
	totalPriceElement.setAttribute("value", totalPrice);
	totalPriceElement.innerHTML = totalPrice + "원";
	
	console.log("totalPayPrice: ", totalPayPrice);
	console.log("price: ", price);
	totalPayPrice -= price;
	
	console.log("totalPayPrice: ", totalPayPrice);
	totalPayPriceElement.setAttribute("value", totalPayPrice);
	totalPayPriceElement.innerHTML = totalPayPrice + "원";
	//totalPayPrice : 0, price : NaN, totalPayPrice : NaN
	//처음 0 공통, price는 NaN->2500->1000 순으로 변화, totaLPayPrice2는 NaN->2500->4000으로 변화
}



</script>
</html>