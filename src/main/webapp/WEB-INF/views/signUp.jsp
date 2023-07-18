<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Crafty</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">
    <link href="/css/login.css" rel="stylesheet" type="text/css"> 
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>CRAFTY</h1>
        <form method="post" action="/signUp">
            <label for="username">이름</label>
            <input type="text" placeholder="이름을 입력해주세요" name="name" maxlength="4" required>

            <label for="nickname">닉네임</label>
            <input type="text" placeholder="닉네임을 입력해주세요" name="nickname" maxlength="8" required>

            <label for="id">아이디</label>
            <input type="text" placeholder="아이디를 입력해주세요" name="loginId" maxlength="20" required>

            <label for="password">비밀번호</label>
            <input type="password" placeholder="비밀번호를 입력하세요" name="loginPw" maxlength="20" required>
            
            <label for="confirm_password">비밀번호 확인</label>
            <input type="password" placeholder="비밀번호를 다시 입력하세요" name="confirm_password" maxlength="20" required>
            

            <label for="phone_number">휴대폰 번호(ex)01012345678)</label>
            <div class="input-wrapper">
            <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="11" placeholder="휴대폰 번호" name="phoneNum" required>
            <!-- <button type="button" onclick="sendVerificationCode()"><b>인증번호 발송</b></button> -->
            </div>

            <!-- <div class="input-wrapper">
            <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="6" placeholder="인증번호" name="checkNumber" required>
            <button type="submit" href=#><b>인증번호 확인</b></button>
            </div> -->

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
            </script>

            <label for="email">E-mail</label>
            <input type="email" id="email" placeholder="이메일을 입력해주세요" name="email" maxlength="30" required>

            <label for="birthDate">생년월일(주민등록번호 앞 6자리)</label>
            <!-- <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '')" pattern="\d*" maxlength="6" placeholder="YYMMDD" name="birth" required> -->
            <input type="text" placeholder="YY/MM/DD" name="birthDate" required>
                        
            <label for="gender">성별</label>
            <div class="input-wrapper">
                <label>
                  <input type="radio" name="gender" value="M">남자</label>
                <label>
                  <input type="radio" name="gender" value="F">여자</label>
            </div>
            <!-- <input type="submit" value="Sign Up"> -->

			<button><input type="submit" value="Sign Up"></button>

        </form>
    </div>
</body>
</html>