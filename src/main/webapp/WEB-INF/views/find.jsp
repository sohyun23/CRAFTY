<!DOCTYPE html>
<html>
<head>
    <title>find id pw test</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/css/find.css" rel="stylesheet" type="text/css"> 
</head>
<body>
    <div class="container" id="container">
        <div class="form-container find-pw-container">
            <form action="/submit" method="post">
                <h1>CRAFTY</h1>
                <input type="text" id="findPwId" name="id" maxlength="20" placeholder="아이디를 입력해주세요" />
                <input type="text" id="findPwPhone" name="phone" oninput="this.value = this.value.replace(/[^0-9]/g, '')" pattern="\d*" maxlength="11" placeholder="휴대폰 번호를 입력해주세요" />
                <button id="findPwButton">비밀번호 찾기</button>
            </form>
        </div>
        <div class="form-container find-id-container">
            <form action="#">
                <h1>CRAFTY</h1>
                <input type="text" id="findIdName" name="name" maxlength="4" placeholder="이름를 입력해주세요" />
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
                    <h1 style="color:#E8F1F5">비밀번호 찾기</h1>
                    <p>비밀번호를 잊으셨나요? </br>비밀번호를 찾기 위해 아래를 누르세요</p>
                    <button class="ghost" id="overlayFindPw">비밀번호 찾기</button>
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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
		                    phone: $("#findIdPhone").val()
		                },
		                success: function(data) {
		                    alert(data.id);
		                },
		                error: function(request, status, error) {
		                    alert("error");
		                }
		            });
		        });
		
		        // 비밀번호 찾기 버튼 클릭 이벤트
		        $("#findPwButton").click(function(e) {
		            e.preventDefault();
		            
		            $.ajax({
		                url: '/find',
		                type: 'post',
		                data: { 
		                    action: 'findPw',
		                    id: $("#findPwId").val(),
		                    phone: $("#findPwPhone").val()
		                },
		                success: function(data) {
		                    alert(data.pw);
		                },
		                error: function(request, status, error) {
		                    alert("error");
		                }
		            });
		        });
		    });
		</script>
    </div>
</body>
</html>