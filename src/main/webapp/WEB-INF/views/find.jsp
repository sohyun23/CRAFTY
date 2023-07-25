<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Crafty</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">
    <link href="/css/find.css" rel="stylesheet" type="text/css"> 
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
    <div class="container" id="container">
        <div class="form-container find-pw-container">
            <form action="/submit" method="post">
                <h1 id="craftyTitleFindPw" style="cursor: pointer;">CRAFTY</h1>
                <input type="text" id="findPwId" name="id" maxlength="20" placeholder="아이디를 입력해주세요" />
                <input type="text" id="findPwPhone" name="phone" oninput="this.value = this.value.replace(/[^0-9]/g, '')" pattern="\d*" maxlength="11" placeholder="휴대폰 번호를 입력해주세요" />
                <button id="findPwButton">비밀번호 재설정</button>
            </form>
        </div>
        <div class="form-container find-id-container">
            <form action="/submit" method="post">
                <h1 id="craftyTitleFindId" style="cursor: pointer;">CRAFTY</h1>
                <input type="text" id="findIdName" name="name" maxlength="4" placeholder="이름을 입력해주세요" />
                <input type="text" id="findIdPhone" name="phone" oninput="this.value = this.value.replace(/[^0-9]/g, '')" pattern="\d*" maxlength="11" placeholder="휴대폰 번호를 입력해주세요" />
                <button id="findIdButton">아이디 찾기</button>
            </form>
        </div>
        
        <!-- 오버레이 -->
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1 style="color:#E8F1F5">아이디 찾기</h1>
                    <p>아이디를 잊으셨나요? </br>아이디를 찾기 위해 아래를 누르세요</p>
                    <button class="ghost" id="overlayFindId">아이디 찾기</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1 style="color:#E8F1F5">비밀번호 재설정</h1>
                    <p>비밀번호를 잊으셨나요? </br>비밀번호를 재설정 하기 위해 아래를 누르세요</p>
                    <button class="ghost" id="overlayFindPw">비밀번호 재설정</button>
                </div>
            </div>
        </div>

        <script>
            const signUpButton = document.getElementById('overlayFindPw');
            const signInButton = document.getElementById('overlayFindId');
            const container = document.getElementById('container');

            signUpButton.addEventListener('click', () => {
                container.classList.add("right-panel-active");
            });

            signInButton.addEventListener('click', () => {
                container.classList.remove("right-panel-active");
            });
        </script>

        <script>
		    $(document).ready(function() {
		        // 아이디 찾기 버튼 클릭 이벤트
		        $("#findIdButton").click(function(e) {
		            e.preventDefault();          
		            
		            $.ajax({
		                url: '/find',
		                type: 'post',
		                data: { 
		                    action: 'findId',
		                    name: $("#findIdName").val(),
		                    phoneNum: $("#findIdPhone").val()
		                },
		                success: function(data) {
		                    alert("회원님의 아이디는 " + data + " 입니다.");
		                },
		                error: function(request, status, error) {
		                    alert("입력하신 정보가 일치하지 않습니다.");
		                }
		            });
		        });
				
		     	// 비밀번호 찾기 버튼 클릭 이벤트
		        $("#findPwButton").click(function(e) {
		            e.preventDefault();
		            
		            var loginId = $("#findPwId").val();
		            var phoneNum = $("#findPwPhone").val();

		            $.ajax({
		                url: '/find',
		                type: 'post',
		                data: {
		                    action: 'resetPw',
		                    loginId: loginId,
		                    phoneNum: phoneNum
		                },
		                success: function(data) {
		                    console.log(data);
		                    alert("비밀번호를 재설정하여 가입하신 이메일로 전송하였습니다 " + data);
		                    window.location.href = "/login";
		                },
		                error: function(request, status, error) {
		                    console.log(error);
		                    console.log(request);
		                    console.log(status);
		                    alert("입력하신 정보가 일치하지 않습니다.");
		                }
		            });
		        });
		     	// "CRAFTY" 타이틀 클릭 이벤트
		        $("#craftyTitleFindPw").on("click", function() {
		            window.location.href = "/login";
		        });

		        $("#craftyTitleFindId").on("click", function() {
		            window.location.href = "/login";
		        });
		    });
		</script>
    </div>
</body>
</html>
