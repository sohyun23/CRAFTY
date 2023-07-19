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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<!-- #362bd4 -->
<body>
    <div class="container" style="text-align: center">
        <h1>CRAFTY</h1>
        <form method="post" action="main.jsp">
            <input type="text" placeholder="아이디를 입력해주세요." id="id" name="id" required>
            
            <input type="password" placeholder="비밀번호를 입력해주세요." id="pw" name="pw" required>
            
            <button type="button" id="loginBtn" style="color:#E8F1F5;"><b>LOGIN</b></button>
		</form>
            <div style="font-size : 12px; color:#8a8a8a;" >
                <a href="/signUp">회원가입</a> / 
                <a href="/find"> 아이디 찾기</a> / 
                <a href="/find"> 비밀번호 찾기</a>
            </div>

            <!-- Naver -->


            <!-- Kakao -->
            
<!--             <button type="submit" href=# style= "background-color:rgb(253, 229, 8); color:#241313;">
              <a onclick="kakaoLogin();"><b>카카오로 로그인</b></a>
            </button> --> 
         
            <!-- <ul style= "background-color:rgb(253, 229, 8); color:#ffffff;padding: 14px 20px; margin: 8px 0; border: none;  cursor: pointer; width: 100%;"> -->
            <!-- <ul class="">
                <li onclick="kakaoLogin();">
                  <a href="javascript:void(0)">
                      <span>카카오로 로그인</span>
                  </a>
                </li>
                <li onclick="kakaoLogout();">
                  <a href="javascript:void(0)">
                      <span>카카오 로그아웃</span>
                  </a>
                </li>
            </ul> -->
            
            <!-- 카카오 로그인 성공 시, 아래 스크립스 수정 또는 사용 -->

<!--             <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
            <script>
                Kakao.init('aa168779c99bbdd76260eb3e3f004076'); //발급받은 키 중 javascript키를 사용해준다.
                console.log(Kakao.isInitialized()); // sdk초기화여부판단
                //카카오로그인
                function kakaoLogin() {
                    Kakao.Auth.login({
                      success: function (response) {
                        Kakao.API.request({
                          url: '/v2/user/me',
                          success: function (response) {
                              console.log(response)
                          },
                          fail: function (error) {
                            console.log(error)
                          },
                        })
                      },
                      fail: function (error) {
                        console.log(error)
                      },
                    })
                  }
                //카카오로그아웃  
                function kakaoLogout() {
                    if (Kakao.Auth.getAccessToken()) {
                      Kakao.API.request({
                        url: '/v1/user/unlink',
                        success: function (response) {
                            console.log(response)
                        },
                        fail: function (error) {
                          console.log(error)
                        },
                      })
                      Kakao.Auth.setAccessToken(undefined)
                    }
                  }  
                </script> -->
                
			<script>
				$(document).ready(function() {
				  $("#loginBtn").click(function(event) {
				    event.preventDefault();
				    var id = $("#id").val();
				    var pw = $("#pw").val();
				    var jsonObj = $().val();
				    var data = {
				      id: id,
				      pw: pw
				    };
				    
				    console.log(id);
				    console.log(pw);
				    
				    $.ajax({
				      url: "/login",
				      type: "post",
				      data: JSON.stringify(data),
				      contentType: "application/json",
				      dataType: "json",
				      success: function(json) {
				        
				    	  if (!json) {
				          alert("아이디나 비밀번호를 확인하세요.");
				          $("#id").val("");
				          $("#pw").val("");
				        } else {
				        	  
					          console.log(json);
					          sessionStorage.setItem("login", json);
					          alert(json.nickname + "님 환영합니다.");
					          window.location.href = "/main";
				        }
				      },
				      error: function(err) {
				         console.log(err);
				    	  alert("아이디 또는 비밀번호를 잘못 입력하셨습니다?");
				      }
				    });
				    
				    /* 
				    $.ajax({
					    url: "/login",
					    type: "post",
					    data: JSON.stringify(data),
					    contentType: "application/json",
					    dataType: "json", // 데이터 타입을 JSON으로 변경
					    success: function(response) { // 응답 데이터로부터 세션 정보 추출
					        if (!response.success) {
					            alert("아이디나 비밀번호를 확인하세요.");
					            $("#id").val("");
					            $("#pw").val("");
					        } else {
					            var nickname = response.nickname;
					            console.log(nickname);
					            
					            // 세션 정보 활용 가능
					            
					            alert(nickname + "님 환영합니다.");
					            window.location.href = "/main";
					        }
					    },
					    error: function(err) {
					        console.log(err);
					        alert("아이디 또는 비밀번호를 잘못 입력하셨습니다?");
					    }
					});
				    */
				    
				    
				  });
				});
			</script>
    </div>
</body>
</html>