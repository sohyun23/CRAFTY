<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Crafty</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">
    <link href="/css/login.css" rel="stylesheet" type="text/css"> 
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <div class="container">
        <h1 id="craftyTitle" style="cursor: pointer;">CRAFTY</h1>
        <form method="post" action="/signUp" onsubmit="return validateForm()">
            <label for="username">이름</label>
            <input type="text" placeholder="이름을 입력해주세요" name="name" maxlength="4" required>
			
            <label for="nickname">닉네임</label>
			<div class="input-wrapper">
            <input type="text" id="nickname" placeholder="닉네임을 입력해주세요" name="nickname" maxlength="8" required>
			<button type="button" onclick="isNicknameExists()"><b>중복 확인</b></button>
			</div>
			
            <label for="id">아이디</label>
            <div class="input-wrapper">
            <input type="text" id="loginId" placeholder="아이디를 입력해주세요" name="loginId" maxlength="20" required>
			<button type="button" onclick="isIdExists()"><b>중복 확인</b></button>
			</div>
			
            <label for="password">비밀번호</label>
            <input type="password" placeholder="비밀번호를 입력하세요" name="loginPw" maxlength="20" required>
            
            <label for="confirm_password">비밀번호 확인</label>
            <input type="password" placeholder="비밀번호를 다시 입력하세요" name="confirm_password" maxlength="20" required>
            

            <label for="phone_number">휴대폰 번호(ex) 01012345678)</label>
            <div class="input-wrapper">
            <input type="text"  id="phoneNum" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="11" placeholder="휴대폰 번호" name="phoneNum" required>
            <button type="button" onclick="isPhoneNumExists()"><b>중복 확인</b></button>
            </div>

            <label for="confirm_password">주소</label>
            <div class="input-wrapper">
            <input type="text" id="sample6_postcode" name="zoneCode" onclick="sample6_execDaumPostcode()" placeholder="우편번호"readonly/>
            <button type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" ><b>주소 찾기</b><br></button>
            </div>

            <div class="input-container">
                <input type="text" id="sample6_address" name="roadAddress" placeholder="주소" readonly/>
                <input type="text" style="color:#9498a0;" id="sample6_extraAddress" placeholder="(참고 항목)" readonly/>
            </div>

            <input type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소" maxlength="50">

            <label for="email">E-mail</label>
			<div class="input-wrapper">
            <input type="email" id="email" placeholder="이메일을 입력해주세요" name="email" maxlength="30" required>
			<button type="button" onclick="isEmailExists()"><b>중복 확인</b></button>
			</div>
            <label for="birthDate">생년월일(주민등록번호 앞 6자리)</label>
            <input type="text" placeholder="YY/MM/DD" name="birthDate" required>
                        
            <label for="gender">성별</label>
            <div class="input-wrapper">
                <label>
                  <input type="radio" name="gender" value="M">남자</label>
                <label>
                  <input type="radio" name="gender" value="F">여자</label>
            </div>

			<button type="submit"><b>Sign Up</b></button>
        </form>
        
       	 	<!-- 유효성 검사 -->
 	        <script>
	
	 	    	function isNicknameExists() {
	 	    	    let nickname = document.querySelector('input[name="nickname"]').value;
	 	    	    console.log(nickname)
	 	    	    axios.get('/isExists', {params: {nickname: nickname}})
		                .then(function (response) {
		                    alert(response.data)
		                    console.log(response)
		                })
		                .catch(function (error) {
		                    console.log(error);
	                });
	 	    	}
	
	 	    	function isIdExists() {
	 	    	    let loginId = document.querySelector('input[name="loginId"]').value;
	 	    	    axios.get('/isExists', {params: {loginId: loginId}})
		                .then(function (response) {
		                    alert(response.data)
		                    console.log(response)
		                })
		                .catch(function (error) {
		                    console.log(error);
		                });
	 	    	}
	
	 	    	function isPhoneNumExists() {
	 	    	    let phoneNum = document.querySelector('input[name="phoneNum"]').value;
	 	    	    console.log(phoneNum)
	 	    	    axios.get('/isExists', {params: {phoneNum: phoneNum}})
		                .then(function (response) {
		                    alert(response.data)
		                    console.log(response)
		                })
		                .catch(function (error) {
		                    console.log(error);
		                });
	 	    	}
	
	 	    	function isEmailExists() {
	 	    	    let email = document.querySelector('input[name="email"]').value;
	 	    	   	console.log(email)
	 	    	    axios.get('/isExists', {params: {email: email}})
		                .then(function (response) {
		                    alert(response.data)
		                    console.log(response)
		                })
		                .catch(function (error) {
		                    console.log(error);
		                });
	 	    	}
 	        
	        /* function isNicknameExists() {
	            let nickname = document.querySelector('input[name="nickname"]').value;
	            axios.post('/nicknameExists', nickname)
	                .then(function (response) {
	                    if (response.data.data) {
	                        alert('이미 사용중인 닉네임입니다.');
	                    } else {
	                        alert('사용 가능한 닉네임입니다.');
	                    }
	                })
	                .catch(function (error) {
	                    console.log(error);
	                });
	        }

	        function isIdExists() {
	            let id = document.querySelector('input[name="loginId"]').value;
	            axios.post('/idExists', id)
	                .then(function (response) {
	                    if (response.data.data) {
	                        alert('이미 사용중인 아이디입니다.');
	                    } else {
	                        alert('사용 가능한 아이디입니다.');
	                    }
	                })
	                .catch(function (error) {
	                    console.log(error);
	                });
	        }

	        function isPhoneNumExists() {
	            let phoneNum = document.querySelector('input[name="phoneNum"]').value;
	            axios.post('/phoneNumExists', phoneNum)
	                .then(function (response) {
	                    if (response.data.data) {
	                        alert('이미 사용중인 휴대폰 번호입니다.');
	                    } else {
	                        alert('사용 가능한 휴대폰 번호입니다.');
	                    }
	                })
	                .catch(function (error) {
	                    console.log(error);
	                });
	        }

	        function isEmailExists() {
	            let email = document.querySelector('input[name="email"]').value;
	            axios.post('/emailExists', email)
	                .then(function (response) {
	                    if (response.data.data) {
	                        alert('이미 사용중인 이메일입니다.');
	                    } else {
	                        alert('사용 가능한 이메일입니다.');
	                    }
	                })
	                .catch(function (error) {
	                    console.log(error);
	                });
	        } */
			    
			    var error = "${error}";
			    if (error !== "") {
			    	alert(error);
			    }
				<!-- 타이틀 클릭 시, 메인페이지 이동 
			    $(document).ready(function() {
			        $("#craftyTitle").on("click", function() {
			                window.location.href = "/main";
			        });
			    });
			</script>
        
            
            
        <!-- 유효성 검사(+ etc) -->
        <script>
        	/* Form Done */
	        function validateForm() {
	        	function validateLoginId() {
	                const loginId = document.querySelector('input[name="loginId"]').value;
	                const loginIdRegex = /^[a-z0-9_]{4,20}$/;
	                if (!loginIdRegex.test(loginId)) {
	                    alert('아이디는 영문 소문자, 숫자, 밑줄(_)로 4자 이상, 20자 이하로 입력해주세요.');
	                    return false;
	                }
	                return true;
	            }

	            function validatePassword() {
	                const password = document.querySelector('input[name="loginPw"]').value;
	                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
	                if (!passwordRegex.test(password)) {
	                    alert('비밀번호는 영문 대문자, 소문자, 숫자, 특수문자를 포함하여 8자 이상으로 입력해주세요.');
	                    return false;
	                }
	                return true;
	            }

	            function validateConfirmPassword() {
	                const password = document.querySelector('input[name="loginPw"]').value;
	                const confirmPassword = document.querySelector('input[name="confirm_password"]').value;
	                if (password !== confirmPassword) {
	                    alert('비밀번호가 일치하지 않습니다.');
	                    return false;
	                }
	                return true;
	            }

	            // 각 입력 필드에 대한 유효성 검사 함수 호출
	            if (!validateLoginId() || !validatePassword() || !validateConfirmPassword() || !validateBirthDate()) {
	                return false; // 폼 제출을 막습니다.
	            }
	            return true; // 폼 제출을 허용합니다.
	        }
	        /* 성별 선택 */
	        function selectGender(gender) {
	            const maleBtn = document.getElementById('male');
	            const femaleBtn = document.getElementById('female');

	            if (gender === 'M') {
	                maleBtn.checked = true;
	                maleBtn.nextElementSibling.classList.add('selected');
	                femaleBtn.checked = false;
	                femaleBtn.nextElementSibling.classList.remove('selected');
	            } else if (gender === 'F') {
	                femaleBtn.checked = true;
	                femaleBtn.nextElementSibling.classList.add('selected');
	                maleBtn.checked = false;
	                maleBtn.nextElementSibling.classList.remove('selected');
	            }
	        }        
        	
        </script>
        
        <!-- 다음 주소찾기 api -->
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
            </script>
        
        
    </div>
</body>
</html>