<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>find id pw test</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">
    <link href="/css/find.css" rel="stylesheet" type="text/css"> 
</head>
<!-- #362bd4 -->
<body>
    <div class="container" id="container">

        <div class="form-container find-pw-container">
            <form action="#">
                <h1>CRAFTY</h1>
                <input type="text" maxlength="20" placeholder="아이디를 입력해주세요" />
                <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '')" pattern="\d*" maxlength="11" placeholder="휴대폰 번호를 입력해주세요" />
                
                
                <!-- 이 부분을 입력받아 DB와 대조해서 일치하다면 alert()창으로 비밀번호 출력  -->
                <button>
                    	비밀번호 찾기
                </button>
                
                
            </form>
        </div>

        <div class="form-container find-id-container">
            <form action="#">
                <h1>CRAFTY</h1>
                <input type="text" maxlength="4" placeholder="이름를 입력해주세요" />
                <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '')" pattern="\d*" maxlength="11" placeholder="휴대폰 번호를 입력해주세요" />
                <!-- <a href="#">Forgot your password?</a> -->
                
                <!-- 이 부분을 입력받아 DB와 대조해서 일치하다면 alert()창으로 아이디 출력  -->
                <button>
                    	아이디 찾기
                </button>
                
                
            </form>
        </div>

        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1 style="color:#E8F1F5">아이디 찾기</h1>
                    <p>아이디를 잊으셨나요? </br>아이디를 찾기 위해 아래를 누르세요</p>
                    <button class="ghost" id="findID">아이디 찾기</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1 style="color:#E8F1F5">비밀번호 찾기</h1>
                    <p>비밀번호를 잊으셨나요? </br>비밀번호를 찾기 위해 아래를 누르세요</p>
                    <button class="ghost" id="findPW">비밀번호 찾기</button>
                </div>
            </div>
        </div>
        <script>
            const signUpButton = document.getElementById('findPW');
            const signInButton = document.getElementById('findID');
            const container = document.getElementById('container');

            signUpButton.addEventListener('click', () => {
                container.classList.add("right-panel-active");
            });

            signInButton.addEventListener('click', () => {
                container.classList.remove("right-panel-active");
            });
        </script>
    </div>
</body>
</html>
