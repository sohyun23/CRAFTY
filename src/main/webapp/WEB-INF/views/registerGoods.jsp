<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/registerGoods.css" rel="stylesheet" type="text/css" />
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
      
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <title>CRAFTY</title>
  </head>
  <link
    href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css"
    rel="stylesheet"
  />
  <body>
  <%@ include file="header.jsp" %>
  
    <div class="main-container">
    	
      <div id="thumnail">
      	<h1>썸네일 이미지</h1>
      	<input type="file" name="thumbnailFile" id="thumnailBtn"/>
        <!-- 
        <button id="thumnailBtn">이미지 등록</button>
       -->
      </div>

      <div id="goodsName">
        <h1>굿즈 명</h1>
        <div class="divLeft">
          <input
            id="goodsNameInput"
            placeholder="굿즈 명을 입력해주세요."
            name="goodsName"
            type="text"
            maxlength="30"
          />
        </div>
      </div>

      <div id="goodsIntro">
        <h1>굿즈 소개글</h1>
        <div class="divLeft">
          <input
            id="goodsIntroInput"
            placeholder="굿즈 소개글을 입력해주세요.(50자 내외)"
            maxlength="60"
          />
        </div>
      </div>

      <div id="goodsCategory">
        <h1>카테고리</h1>
        <div class="divLeft">
        <div id= "goodsCategoryForm">
          <!-- <form id="goodsCategoryForm"> -->
            <select id= "GoodsCategorySelect" name="selectGoodsCategory">
              <option value="푸드">푸드</option>
              <option value="잡화">잡화</option>
              <option value="뷰티">뷰티</option>
              <option value="유아">유아</option>
              <option value="반려동물">반려동물</option>
              <option value="기타">기타</option>
            </select>
            <span>

          </div>
        </div>
      </div>

      <div id="salePeriod">
        <h1>모금 기간</h1>
        <div id="dateTxt">
          <div id="startDateTxt">
            시작일
            <input
              class="date"
              id="startDateInput"
              type="date"
            />
          </div>
          <div id="endDateTxt">
            종료일
            <input class="date" id="endDateInput" type="date" value="endDate" />
          </div>
        </div>
      </div>

      <div id="goodsDescription">
        <h1>굿즈 설명 이미지</h1>
        <input type="file" id="descriptionBtn"/>
        <!-- <button id="descriptionBtn">이미지 등록</button> -->
      </div>

      <div id="itemInfo">
        <h1>상품 정보 입력</h1>
        <div class="divLeft">
         <!--  <form id="itemInfoForm">--> 
         <div id= itemInfoForm>
            <div id="itemInputBox">
              상품명<span class="ness">*</span>
              <div>
                <input
                  class="itemForm"
                  type="text"
                  id="itemName"
                  name="itemName"
                  placeholder="상품명을 입력하세요."
                  maxlength="20"
                />
              </div>

              가격<span class="ness">*</span>
              <div>
                <input
                  class="itemForm"
                  id="itemPrice"
                  name="itemPrice"
                  placeholder="가격을 입력하세요."
                  type="text"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                  min="0"
                />
              </div>

              상품구성
              <div>
                <input
                  class="itemForm"
                  type="text"
                  id="itemComposition"
                  name="itemComposition"
                  placeholder="상품구성을 입력하세요."
                  maxlength="20"
                />
              </div>

              수량 <span class="ness">*</span>
              <div>
                <input
                  class="itemForm"
                  id="itemQuantity"
                  name="itemQuantity"
                  placeholder="수량을 입력하세요."
                  type="text"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                  min="0"
                />
              </div>
            </div>
            <br />
            <div id="itemSubmit">
              <input
                id="itemSubmitInput"
                type="button"
                onclick="itemInfoList()"
                value="등록"
              />
            </div>
            </div>
           <!--  </form>-->
        </div>
      </div>

      <div id="itemCompositionList">
        <h1>상품 구성 리스트</h1>
        <div class="divLeft">
          <ul id="itemList"></ul>
        </div>
      </div>

      <div id="targetAmount">
        <h1>목표 금액</h1>
        <div class="divLeft">
          <input
            id="targetAmountInput"
            placeholder="목표 금액(원)을 입력해주세요."
            name="targetAmountInput"
            type="text"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
            min="0"
          />
        </div>
      </div>

      <div id="postDate">
        <h1>발송 예정일</h1>
        <div class="divLeft">
          <input class="date" id="postDateInput" type="date" value="postDate" />
        </div>

        <div id="goodsCategory">
          <h1>정산받을 계좌 정보</h1>
          <!-- 
          <form id="bankCategoryForm">
             -->
             <div id="bankCategoryForm">
            <select id="bankCategorySelect"name="bankCategory">
              <option value="sinhan">신한</option>
              <option value="kb">국민</option>
              <option value="kakao">카카오</option>
              <option value="nh">NH</option>
              <option value="hana">하나</option>
            </select>
            <span>
              <input
                id="bankAccountNumber"
                name="bankAccountNumber"
                placeholder="입금받을 계좌번호를 입력해주세요."
                type="text"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                min="0"
              />
            </span>
            </div>
            <!--
          </form>-->
        </div>
      </div>

      <div id="aggrement">
        <h1>판매자 준수 사항 동의서</h1>
        <button id="aggrementDiscription">내용보기</button><br />
        <br />
        <div class="divLeft" id="aggrementCheck">
          <input id="aggrementCheckbox" type="checkbox" /> 판매자 준수 사항을
          확인하였고, 동의합니다.
        </div>
      </div>
      <br />

      <hr />
      <br />
      <div id="registGoods">
        <button id="registGoodsBtn" type="submit" onclick="validateForm()">굿즈 만들기</button>
      </div>
    </div>

     <%@ include file="footer.jsp" %>
  </body>

 <script>
 // 금일 날짜 구하기
 const today = new Date().toISOString().split("T")[0];

 // 7일 후의 날짜 구하기
 const sevenDaysLater = new Date();
 sevenDaysLater.setDate(sevenDaysLater.getDate() + 7);
 const sevenDaysLaterFormatted = sevenDaysLater.toISOString().split("T")[0];

 // startDateInput 요소에 최소 날짜를 오늘로부터 7일 이후로 설정
 const startDateInput = document.getElementById("startDateInput");
 startDateInput.min = sevenDaysLaterFormatted;

 // endDateInput 요소의 최소 날짜를 startDateInput의 선택된 값 이후로 설정
 const endDateInput = document.getElementById("endDateInput");
 endDateInput.min = sevenDaysLaterFormatted;

 // startDateInput의 값이 변경될 때 endDateInput의 최소 날짜를 업데이트
 startDateInput.addEventListener("change", function () {
   endDateInput.min = startDateInput.value;
   postDateInput.min = startDateInput.value;
 });

 // endDateInput 요소에 변경되는 값에 따라 postDateInput의 최소 날짜도 업데이트
 endDateInput.addEventListener("change", function () {
   postDateInput.min = endDateInput.value;
 });
 
 const itemName = document.getElementById("itemName");
 const itemPrice = document.getElementById("itemPrice");
 const itemComposition = document.getElementById("itemComposition");
 const itemQuantity = document.getElementById("itemQuantity");


 const itemList = document.getElementById("itemList");
 
 
 if (!itemList.hasChildNodes()) {
     itemList.style.display = "none"; // Hide the list if there are no child nodes
   }else{
	   
	   itemList.style.display = "block";
   }
 
 
 
 function itemInfoList() {
   if (
     itemName.value == "" ||
     itemPrice.value == "" ||
     itemQuantity.value == ""
   ) {
     alert("입력값을 입력하세요.");
     itemName.value = "";
     itemPrice.value = "";
     itemQuantity.value = "";
   } else {
     const createitem = document.createElement("li");
     createitem.innerHTML = '<div class="item">' +
							     '<input class="listItemName" value="' + itemName.value + '" type="text"></input>' +
							     '<input class="listItemPrice" value="' + itemPrice.value + '" type="hidden"></input>' +
							     '<input class="listItemComposition" value="' + itemComposition.value + '" type="hidden"></input>' +
							     '<input class="listItemQuantity" value="' + itemQuantity.value + '" type="hidden"></input>' +
							     '<button class="itemdelete" onclick="deleteitem(event)">x</button>' +
							     '</div>';
     itemList.appendChild(createitem);
	
     if (!itemList.hasChildNodes()) {
         itemList.style.display = "none"; // Hide the list if there are no child nodes
       } else {
         itemList.style.display = "block"; // Show the list if there are child nodes
       }
     
     itemName.value = "";
     itemPrice.value = "";
     itemComposition.value = "";
     itemQuantity.value = "";

   }
 }
 
 function deleteitem(event) {
	 const listItem = event.target.closest("li");
	  listItem.remove();
	  if (!itemList.hasChildNodes()) {
	      itemList.style.display = "none"; // 자식 노드가 없으면 리스트를 숨김
	    }
	  
   }
 

  function validateForm() {
    const goodsNameInput = document.getElementById("goodsNameInput").value;
    const goodsIntroInput = document.getElementById("goodsIntroInput").value;
    const startDateInput = document.getElementById("startDateInput").value;
    const endDateInput = document.getElementById("endDateInput").value;
    const targetAmountInput = document.getElementById("targetAmountInput").value;
    const postDateInput = document.getElementById("postDateInput").value;
    const thumbnailFile = document.getElementById("thumnailBtn").files[0];
    const descriptionFile = document.getElementById("descriptionBtn").files[0];
    const bankAccountNumberInput = document.getElementById("bankAccountNumber").value;
    const itemList = document.getElementById("itemList");
    
    if (!thumbnailFile) {
      alert("썸네일 사진을 등록해 주세요.");
      return;
    }

    if (goodsNameInput.trim() === "") {
      alert("굿즈명을 입력해 주세요.");
      return;
    }

    if (goodsIntroInput.trim() === "") {
      alert("굿즈 소개글을 입력해 주세요.");
      return;
    }

    if (startDateInput.trim() === "") {
      alert("모금 시작 날짜를 입력해 주세요.");
      return;
    }

    if (endDateInput.trim() === "") {
      alert("모금 종료 날짜를 입력해 주세요.");
      return;
    }

    if (!descriptionFile) {
      alert("굿즈 상세 설명 사진을 등록해 주세요.");
      return;
    }
    
    if (!itemList.hasChildNodes()) {
      alert("상품을 등록해 주세요.");
      return;
    }
    
    if (targetAmountInput.trim() === "") {
      alert("목표 금액을 입력해 주세요.");
      return;
    }

    if (postDateInput.trim() === "") {
      alert("발송 예정 날짜를 입력해 주세요.");
      return;
    }

    if (bankAccountNumberInput.trim() === "") {
        alert("계좌번호를 입력해 주세요.");
        return;
      }  
    
    if (!aggrementCheckbox.checked) {
        alert("판매자 준수 사항에 동의해 주세요.");
        return;
      }


    // Validation successful, proceed with form submission
    submitForm();
  }

  function submitForm() {
    const thumbnailFile = document.getElementById("thumnailBtn").files[0];
    const goodsNameInput = document.getElementById("goodsNameInput").value;
    const goodsIntroInput = document.getElementById("goodsIntroInput").value;
    const goodsCategorySelect = document.getElementById("GoodsCategorySelect").value;
    const startDateInput = document.getElementById("startDateInput").value;
    const endDateInput = document.getElementById("endDateInput").value;
    const descriptionFile = document.getElementById("descriptionBtn").files[0];
    const targetAmountInput = document.getElementById("targetAmountInput").value;
    const postDateInput = document.getElementById("postDateInput").value;
    const bankCategorySelect = document.getElementById("bankCategorySelect").value;
    const bankAccountNumberInput = document.getElementById("bankAccountNumber").value;
    const aggrementCheckbox = document.getElementById("aggrementCheckbox");

    const formData = new FormData();
    formData.append("thumbnailFile", thumbnailFile);
    formData.append("goodsName", goodsNameInput);
    formData.append("goodsIntro", goodsIntroInput);
    formData.append("goodsCategory", goodsCategorySelect);
    formData.append("startDate", startDateInput);
    formData.append("endDate", endDateInput);
    formData.append("descriptionFile", descriptionFile);
    formData.append("targetAmount", targetAmountInput);
    formData.append("postDate", postDateInput);
    formData.append("bankCategory", bankCategorySelect);
    formData.append("bankAccountNumber", bankAccountNumberInput);

    const itemListPayload = [];
    const itemList = document.getElementById("itemList");
    if (itemList.hasChildNodes()) {
      const children = itemList.childNodes;
      for (let i = 0; i < children.length; i++) {
        const listItemName = children[i].getElementsByClassName("listItemName")[0].value;
        const listItemPrice = children[i].getElementsByClassName("listItemPrice")[0].value;
        const listItemComposition = children[i].getElementsByClassName("listItemComposition")[0].value;
        const listItemQuantity = children[i].getElementsByClassName("listItemQuantity")[0].value;
        const itemPayload = {
          itemName: listItemName,
          itemPrice: listItemPrice,
          itemComposition: listItemComposition,
          itemQuantity: listItemQuantity,
        };
        itemListPayload.push(itemPayload);
      }
    }

    formData.append("itemList", JSON.stringify(itemListPayload));

    axios({
      method: "post",
      url: "/register/goods",
      headers: {
        "Content-Type": "multipart/form-data",
      },
      data: formData,
    })
      .then((response) => {
        console.log(response);
        // Success, do something with the response
        window.location.href="http://localhost:8081/main";
      })
      .catch((error) => {
        console.log(error.response.data.code);
        // Error, handle the error
        const url = "http://localhost:8081/error/" + error.response.data.code;
        window.location.href=url;
      });
  }

</script>
</html>
