<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodsDetail</title>
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/goodsDetail.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>

	<%@ include file="header.jsp" %>
	<div class="main-container">
		<!-- action, method -->
		<div class="top-row">
			<div class="top-left">
				<div id="thumbnail-box">
					<img class="thumbnail" src="/img/${thumbnailImgName}" />
				</div>
				<div id="detail"><b>
					${goods.introduction}</b>
				</div>
				<!-- input 빼고 div안에 삽입되도록 -->
			</div>
			<!-- 박스크기 정하기 -->
			<div class="top-right">
				<div id="block1">
					<div id="goods-info">
					<div id="seller-container">
						<a href="/profile/${goods.memberId}"><img id="profile" src="/img/${goods.profileImg}" onerror="this.src='/img/profile.png';"></a>
						<div id="seller-name"><a href="/profile/${goods.memberId}">${goods.nickname}</a></div>
					</div>
					<div id="goods-name">${goods.goodsName}</div>
					<div id="period"> ${goods.startDate} - ${goods.endDate}</div>
					<hr>
					<div id="goods-list">
                        <div id="goods-select" onclick="toggleItemContainer()">
                            <div id="select-text">=========아이템을 선택해주세요=========</div>
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                <path id="chevron-path" fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                            </svg>
                        </div>
                        <div id="item-container">
                        	<c:forEach items="${itemList}" var="item">
                        		<div class="item">
                        			<div class="item-id">${item.itemId}</div>
	                                <div class="item-name">${item.itemName}</div>
	                                <div class="item-price">${item.itemPrice}</div>
	                                <div class="item-config">${item.itemComposition}</div>
	                            </div>
                        	</c:forEach>
                        </div>
                    </div>
                    <hr>
                    <div id="selected-item"><b>선택 아이템</b></div>
					<div id="goods-composition">
						<ul id="goods-cart"></ul>
					</div>
					<hr>	
				<div class="price-cal">
					<div class="cal-name">
						<div id="total-goods"><b>총 아이템 금액</b></div>
						<div id="total-price" value="0">
							0원
							<!--db에서 받아온 정보를 더하기-->
						</div>
					</div>
					<div class="cal-name">
						<div id="delivery"><b>배송 금액</b></div>
						
						<div id="delivery-price" value="2500">2500원</div>
						<!--db에서 받아온 정보를 출력하기-->
					</div>
					
					<hr>
					
					<div class="cal-name">
						<div id="total-pay-amount"><b>총 결제 금액</b></div>
						<div id="total-pay-amount-price" value="0">0원</div>
						<!--db에서 받아온 정보를 더하기-->
					</div>
						<br>
					<div id= "kakao-pay">
						<c:if test="${goods.ongoingStatus eq 1}">
							<img id="API-icon" src="/craftyimg/payicon.png">						
						</c:if>
					</div>
				</div>
		
				</div>
			</div>
					</div>
		</div>
		
		<hr>
		
		<div id="expbottom">
			<!-- 상품설명 -->
			<div id="goods-explanation">
				<img src="/img/${contentImgName}">
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
<script>
	
	// ================ 상품 선택 ================
	const goodsList = document.getElementById("goods-list");
	const goodsCart = document.getElementById("goods-cart");
	
	let totalPrice = 0;
	let totalPayPrice = 0;
	let itemIndex = 0; //변수 선언
	const totalPriceElement = document.getElementById('total-price');
	const deliveryElement = document.getElementById('delivery-price');
	const totalPayPriceElement = document.getElementById('total-pay-amount-price');
	//해당 ID를 가진 곳에서 요소 들고오기. const는 변하지 않을 값, let은 변할 값
	
	function plusList(itemId, itemName, itemPrice){
		let items = document.getElementsByClassName('items-id') // class가 items인 모든 노드를 전부 가져오기
	
		for(i=0; i<items.length; i++){ 
			if(itemId === items[i].textContent){ //goodsList에서 가져온 value를 items에 있는 value 들과 일치하는지 비교
				alert("이미 선택하셨습니다.");
				return; //일치하면 alert 출력하고 입력하지 않고 돌아감
			}
		}
	
		const createitem = document.createElement("li");
		//createitem 이라는 id의 li 요소를 생성할 것
		
		createitem.innerHTML = '<div class="item-box">' +
								'<div class="items-id" id="selected-items-id" value="' + itemId + '">' + itemId + '</div>' +
	                            '<div class="items-name" id="selected-items-name" value="' + itemName + '">' + itemName + '</div>' +
	                            '<div class="items-price" id="selected-items-price" value="' + itemPrice + '">' + itemPrice + '원</div>' +
								'<button class="item-delete" id="delete-btn" onclick="deleteitem(' + itemPrice + ')"> 삭제</button>'+
								'<div>';
		goodsCart.appendChild(createitem);
		
		const delivery = parseInt(deliveryElement.getAttribute('value'));
		let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
		//각 변수 Element의 value값을 가져와서 숫자만 추출함
		
		totalPrice += parseInt(itemPrice);
		// itemPrice를 정수로 변환하여 totalPrice 변수에 더함
		
		totalPriceElement.setAttribute("value", totalPrice);
		totalPriceElement.innerHTML = totalPrice + "원";
		// totalPrice를 문자열로 변환, 원과 연결, total~ 요소의 내용으로 설정. innerHTML은 요소 내용 결정하는 것
		
		totalPayPrice = totalPrice + delivery;
	
		// console.log(totalPrice);
		
		totalPayPriceElement.setAttribute("value", totalPayPrice);
		totalPayPriceElement.innerHTML = totalPayPrice + "원";
	}
	
	function deleteitem(itemPrice) {
		// console.log("----")
		// console.log(itemPrice)
		
		let totalPayPrice = parseInt(totalPayPriceElement.getAttribute('value'));
		
		//total~Element의 value값 가져와서 정수변환
		// console.log(event.target);
		// console.log(event.target.parentElement);
		const removingOne = event.target.parentElement.parentElement; //이벤트 발생한 요소의 부모요소의 부모 선택
		removingOne.remove();//removingOne 제거
		
		totalPrice -= itemPrice;
		totalPriceElement.setAttribute("value", totalPrice);
		totalPriceElement.innerHTML = totalPrice + "원";
		
		// console.log("totalPayPrice: ", totalPayPrice);
		// console.log("price: ", itemPrice);
		totalPayPrice -= itemPrice;
		
		// console.log("totalPayPrice: ", totalPayPrice);
	
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
	        // ▽
	        chevronPath.setAttribute("d", "M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z");
	    } else {
	        itemContainer.style.display = "none";
	        // △
	        chevronPath.setAttribute("d", "M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z");
	    }
	}
	
	// item-container의 item 클래스를 클릭하면 plusList() 함수에 해당 아이템 이름과 가격 전달
	const items = document.querySelectorAll(".item");
	for (let i = 0; i < items.length; i++) {
	    items[i].addEventListener("click", function() {
	    	const itemId = this.querySelector(".item-id").textContent;
	        const itemName = this.querySelector(".item-name").textContent;
	        const itemPrice = this.querySelector(".item-price").textContent;
	        plusList(itemId, itemName, itemPrice);
	    });
	}
	
	// ==================== 결제 =======================
		
	const payIcon = document.getElementById('API-icon');	
	
	payIcon.addEventListener("click", function() {
		let items = document.getElementsByClassName('items-name');
		
		// 로그인이 되어 있지 않으면 
		if(!('${sessionScope.memberId}')) {
			alert('로그인 페이지로 이동합니다.');
			window.location.href = '/login';
		} else if(items.length === 0){
			alert('선택한 아이템이 없습니다.');
		} else {
			// 결제 수행
			payment();
		}
	});
		
		
	function payment() {
		/*
			1. 비동기로 orders, order_items insert
				- totalPrice, delivery, totalPayPrice, itemIdList 필요
				- return orderId
				- insert 실패 시 alert('주문을 다시 시도해주세요.')
			2. 성공 시 결제 api 호출
				- orderId, 
			3. 성공 시 alert('결제 성공')
				- 결제 상세 페이지('/goods/attended/{orderId}')로 이동
				- 실패 시 alert('결제 실패') 후 goodsDetail 페이지 이동
		*/
		
		/* iamport 카카오페이 결제 */
		var IMP = window.IMP; // 생략가능
        IMP.init('imp34872754'); // 부여받은 "가맹점 식별코드"를 사용
        var msg;    
        
		const goodsId = ${goods.goodsId};
		const totalPrice = parseInt(document.getElementById('total-price').getAttribute('value'));    
        const delivery = parseInt(document.getElementById('delivery-price').getAttribute('value'));
   		const totalPayPrice = parseInt(document.getElementById('total-pay-amount-price').getAttribute('value'));
   		
		// class가 items-id인 요소들 전부 다 가져오기
		let selectItems = document.getElementsByClassName('items-id');
		// selectItem의 itemId list
		let itemIdList = Array.from(selectItems).map(item => parseInt(item.getAttribute('value')));
		
		// console.log(itemIdList);
		
		const url = 'http://localhost:8081/create/consumer/info';
		
		axios.get(url)
			  .then(response => {
			    console.log(response.data);
			    
			    IMP.request_pay({
		            pg : 'kakaopay',
		            pay_method : 'card',
		            merchant_uid : response.data.orderId,
		            name : '${goods.goodsName}',
		            amount : totalPayPrice,
		            buyer_email : response.data.email,
		            buyer_name : response.data.name,
		            buyer_tel : response.data.phoneNum
		        }, function(rsp) {
		            if ( rsp.success ) {
		            	console.log(rsp);
		            	
		            	var url = 'http://localhost:8081/payment/order';
		            	var data = {
		            		// payment_info
		           			orderId: rsp.merchant_uid,
		            		impUid: rsp.imp_uid,
		            		payAmount: rsp.paid_amount,
		            		paymentMean: rsp.pg_provider,
		            		status: rsp.status,
		            		// orders
		            		goodsId: ${goods.goodsId},
		           			totalPrice: totalPrice,
		           			delivery: delivery,
		           			totalPayPrice: totalPayPrice,
		           			itemIdList: itemIdList
		            	};
		            	axios.post(url, data)
				       		 .then((response) => {
				           	  	console.log(response);
				           	  	
				           	  	var url = "http://localhost:8081/goods/attended/" + response.data;
				           	  	location.href= url;
			             	 })
			             	 .catch((error) => {
			             		 console.log(error);
							 })
		           	
		            } else {
		                alert('결제실패 : ' + rsp.error_msg);
		            }
		        });
				    
			  })
			  .catch(error => {
			     console.error('에러:', error);
			  });
		
	}
		
</script>
</html>