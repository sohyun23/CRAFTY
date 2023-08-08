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
          <img src="//placehold.it/100" class="avatar img-circle" alt="avatar" id="images"> <!-- 보조 강사 b-->
          <div>
            <input type="file" class="form-control" id="profileImg" onchange="uploadImage(this);"> <!-- 보조 강사b -->
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
              <input class="form-control" type="text" id="nickname" name="nickname" maxlength="8" placeholder="기존 닉네임" value="${member.nickname}">
              <button type="button" onclick="isNicknameExists()">중복 확인</button>
            <!-- id="duplicate-check-btn" -->
            </div>
          </div>
          
          <!-- 소개 -->
          <div class="form-group">
            <label class="col-lg-3 control-label">소개</label>
            <div class="col-lg-8">
              <input id="introduceInput" class="form-control" type="text" name="introduceEdit" maxlength="100" placeholder="${member.profileIntroduction}" value="${member.profileIntroduction}">
            </div>
          </div>

          <h3>계정 정보 수정</h3>
          <!-- 이메일 -->
          <div class="form-group">
            <label class="col-lg-3 control-label">Email</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" id="email" name="email" placeholder="기존 이메일" value="${member.email}">
              <button type="button" onclick="isEmailExists()">중복 확인</button>
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
			    <input id="edit-save-btn" type="button" onclick="clickFollow()" value="Save">
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

                
                
                function clickFollow() {
                	const profileImg = document.getElementById("profileImg").files[0];
                    const nickname = document.getElementById("nickname").value;
                    const profileIntroduction = document.getElementById("introduceInput").value;
                    const email = document.getElementById("email").value;
                    const zoneCode = document.getElementById("sample6_postcode").value;
                    const roadAddress = document.getElementById("sample6_address").value;
                    const detailAddress = document.getElementById("sample6_detailAddress").value;

                    // 서버로 전송할 데이터를 FormData로 생성합니다.
                    const formData = new FormData();
                    formData.append("profileImg", profileImg);
                    formData.append("nickname", nickname);
                    formData.append("profileIntroduction", profileIntroduction);
                    formData.append("email", email);
                    formData.append("zoneCode", zoneCode);
                    formData.append("roadAddress", roadAddress);
                    formData.append("detailAddress", detailAddress);
                    
                    // 서버로 데이터를 전송합니다.
                    axios({
					      method: "post",
					      url: "/profile/edit",
					      headers: {
					        "Content-Type": "multipart/form-data",
					      },
					      data: formData,
					    })
                        
                    
                    .then((response)=> {
                            // 수정 성공 시 처리할 코드 작성
                            alert("프로필이 수정되었습니다.");
                            window.location.href = "/profile/" + ${member.memberId};
                            // 필요하다면 페이지 리로드 또는 이동 처리 등 추가 가능
                        })
                        .catch(error => {
                            // 에러 발생 시 처리할 코드 작성
                            alert("프로필 수정에 실패했습니다. 다시 시도해주세요.");
                            console.error(error);
                        });
                }
                
                
             	// 페이지 로딩 후 실행할 함수	
             	document.addEventListener("DOMContentLoaded", function() {
                // 입력 필드를 클릭할 때 이벤트 리스너 추가  
                document.getElementById("introduceInput").addEventListener("click", function() {
                    // 입력 필드의 값을 비웁니다.
                    this.value = "";
                  });
                });
                
                /* 닉네임 중복 검사 */
                function isNicknameExists() {
	 	    	    let nickname = document.querySelector('input[name="nickname"]').value;
	 	    	    console.log(nickname)
	 	    	    axios.get('/isExistsProfileEdit', {params: {nickname: nickname}})
		                .then(function (response) {
		                    alert(response.data)
		                    console.log(response)
		                })
		                .catch(function (error) {
		                    console.log(error);
	                });
	 	    	}
                
                /* 이메일 중복 검사 */
                function isEmailExists() {
	 	    	    let email = document.querySelector('input[name="email"]').value;
	 	    	   	console.log(email)
	 	    	    axios.get('/isExistsProfileEdit', {params: {email: email}})
		                .then(function (response) {
		                    alert(response.data)
		                    console.log(response)
		                })
		                .catch(function (error) {
		                    console.log(error);
		                });
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
                
             	// 보조 강사
                function uploadImage(input){
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();

                        reader.onload = function (e) {
                            document.getElementById('images').setAttribute('src', e.target.result)
                              
                        };

                        reader.readAsDataURL(input.files[0]);
                    }
                }
                
            </script>
</html>