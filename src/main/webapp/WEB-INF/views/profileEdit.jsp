<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>ProfileEdit</title>
	<link href="/css/common.css" rel="stylesheet" type="text/css" />
	<link href="/css/profileEdit.css" rel="stylesheet" type="text/css" />
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
                    <li><a href="/goods/attended">참여 굿즈 내역</a></li>
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
                    <li id="current-title"><a href="/profile/edit">프로필 편집</a></li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
        <div class="main-content">
            <div class="title">
               	 프로필 수정
            </div>

        <!-- ----------------------------->

        <div class="main-body">
  	
	<div class="row">
      <!-- left column -->
      <div class="col-md-3">
        <div class="text-center">
          <img src="//placehold.it/100" class="avatar img-circle" alt="avatar">
          <div>
            <input type="file" class="form-control" id="file-load">
          </div>
        </div>
      </div>
      
      <!-- edit form column -->
      <div class="col-md-9 personal-info">
        <br>
        <form class="form-horizontal" role="form">
            <!-- 닉네임 -->
          <div class="form-group">
            <label class="col-lg-3 control-label">닉네임</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="nickNameEdit" maxlength="8" placeholder="기존 닉네임" value="${member.nickname}">
              <button id="duplicate-check-btn" onclick="duplicateCheck()">중복 확인</button>
              <p id="aleady-nickname">이미 존재하는 닉네임입니다.</p>
            </div>
          </div>
          <!-- 소개 -->
          <div class="form-group">
            <label class="col-lg-3 control-label">소개</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="introduceEdit" maxlength="100" placeholder="기존 소개글" value="${member.profileIntroduction}">
            </div>
          </div>

          <h3>계정 정보 수정</h3>
          <!-- 이메일 -->
          <div class="form-group">
            <label class="col-lg-3 control-label">Email</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="emailEdit" placeholder="기존 이메일" value="${member.email}">
            </div>
          </div>
            
          
          <div class="form-group">
            <label class="col-md-3 control-label"></label>
            <div class="col-md-8">
               <label for="confirm_password">주소</label>
                <div class="input-wrapper">
                <input class="form-control" type="text" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" value="${member.zoneCode}" readonly/>
                <button type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" >주소 찾기<br></button>
                </div>

                <div class="input-container">
                    <input class="form-control" type="text" id="sample6_address" placeholder="주소" value="${member.roadAddress}" readonly/>
                    <input class="form-control" type="text" style="color:#9498a0;" id="sample6_extraAddress" placeholder="(참고 항목)" readonly/>
                </div>
                <input class="form-control" type="text" id="sample6_detailAddress" placeholder="상세주소" value="${member.detailAddress}" maxlength="50">
                
            </div>
          </div>
        
              <div class="form-group">
                <label class="col-md-3 control-label"></label>
                <div class="col-md-8" id="form-btn-right">
			    <input id="edit-save-btn" type="button" onclick="clickFollow()" value="Save"></input>
			</div>
            </div>

        </form>
      </div>
  </div>
</div>
</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
              
                function sample6_execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                            var addr = ''; // 주소 변수
                            var extraAddr = ''; // 참고항목 변수

                            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                                addr = data.roadAddress;
                            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                                addr = data.jibunAddress;
                            }

                            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                            if(data.userSelectedType === 'R'){
                                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                    extraAddr += data.bname;
                                }
                                // 건물명이 있고, 공동주택일 경우 추가한다.
                                if(data.buildingName !== '' && data.apartment === 'Y'){
                                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                }
                                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                                if(extraAddr !== ''){
                                    extraAddr = ' (' + extraAddr + ')';
                                }
                                // 조합된 참고항목을 해당 필드에 넣는다.
                                document.getElementById("sample6_extraAddress").value = extraAddr;
                            
                            } else {
                                document.getElementById("sample6_extraAddress").value = '';
                            }

                            // 우편번호와 주소 정보를 해당 필드에 넣는다.
                            document.getElementById('sample6_postcode').value = data.zonecode;
                            document.getElementById("sample6_address").value = addr;
                            // 커서를 상세주소 필드로 이동한다.
                            document.getElementById("sample6_detailAddress").focus();
                        }
                    }).open();
                }

                 
                function readOnlyFalse(){
                    const formInput = document.getElementsByClassName("form-control");
                    let len = formInput.length;
                    for (let i = 0; i < len; i++){
                        formInput.item(i).readOnly = false;
                    }
                }

                function readOnlyTrue(){
                    const formInput = document.getElementsByClassName("form-control");
                    let len = formInput.length;
                    for (let i = 0; i < len; i++){
                        formInput.item(i).readOnly = true;
                    }
                }

                function clickFollow(){
                    const btn = document.getElementById('edit-save-btn'); //id가 'edit-save-btn'인 요소를 반환한다.
                    if(btn.value === "Edit" ){ //버튼의 텍스트값 확인
                        btn.value = 'Save';  // 텍스트를 Save로 변경
                        readOnlyFalse();
                    } else {  // 반대일 경우 다시 변경
                        btn.value = "Edit";
                        readOnlyTrue();
                    }
                }
                
                function duplicateCheck(){

                }
                
                function clickSave() {
                    const form = document.querySelector(".form-horizontal");
                    const formData = new FormData(form);

                    axios.post("/profile/edit", formData)
                         .then(response => {
                             // 수정 성공 시 처리할 코드 작성
                             alert("프로필이 수정되었습니다.");
                             // 필요하다면 페이지 리로드 또는 이동 처리 등 추가 가능
                         })
                         .catch(error => {
                             // 에러 발생 시 처리할 코드 작성
                             alert("프로필 수정에 실패했습니다. 다시 시도해주세요.");
                             console.error(error);
                         });
                }
                
            </script>
</html>