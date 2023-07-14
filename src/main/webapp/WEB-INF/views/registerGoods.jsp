<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/registerGoods.css" rel="stylesheet" type="text/css" />
    <title>Crafty</title>
</head>

<body>
  <%@ include file="header.jsp" %>
    <div class="main-container">
    	
      <div id="thumnail">
      	<h1>이미지 등록</h1>
        <button id="thumnailBtn">이미지 등록</button>
      </div>

      <div id="goodsName">
        <h1>굿즈 명</h1>
        <div class="divLeft">
          <input
            id="goodsNameInput"
            placeholder="굿즈 명을 입력해주세요."
            name="goodsName"
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
          <form id="goodsCategoryForm">
            <select name="selectGoodsCategory">
              <option value="food">푸드</option>
              <option value="stuff">잡화</option>
              <option value="beauty">뷰티</option>
              <option value="child">유아</option>
              <option value="pet">반려동물</option>
              <option value="etc">기타</option>
            </select>
            <span>
              <input id="categorySubmit" type="submit" value="submit" />
            </span>
          </form>
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
              value="startDate"
            />
          </div>
          <div id="endDateTxt">
          		종료일
            <input class="date" id="endDateInput" type="date" value="endDate" />
          </div>
        </div>
      </div>

      <div id="goodsDescription">
        <h1>상세 설명</h1>
        <button id="descriptionBtn">이미지 등록</button>
      </div>

      <div id="itemInfo">
        <h1>상품 정보 입력</h1>
        <div class="divLeft">
          <form id="itemInfoForm">
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
          </form>
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
          <form id="bankCategoryForm">
            <select id="bank-category" name="bankCategory">
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
          </form>
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
        <button id="registGoodsBtn" onclick="location.href ='/main'">굿즈 만들기</button>
      </div>
    </div>
	<%@ include file="footer.jsp" %>
</body>

<script>
    const itemName = document.getElementById("itemName");
    const itemPrice = document.getElementById("itemPrice");
    const itemComposition = document.getElementById("itemComposition");
    const itemQuantity = document.getElementById("itemQuantity");

    function test() {
      alert("dd");
    }

    const itemList = document.getElementById("itemList");
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

        createitem.innerHTML = `<div class="item" >
                            <input class="items" value='${itemName.value}, ${itemPrice.value}원 , ${itemQuantity.value}개' type="text"></input>
                            <button class="itemdelete" id="deleteBtn" onclick="deleteitem(event)">x</button>
                            <div>`;
        itemList.appendChild(createitem);

        itemName.value = "";
        itemPrice.value = "";
        itemComposition.value = "";
        itemQuantity.value = "";
      }
    }
    function deleteitem(event) {
      console.log(event.target.parentElement);
      const removingOne = event.target.parentElement.parentElement;
      alert(removingOne);
      removingOne.remove();
    }
</script>
</html>
