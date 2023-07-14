<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Crafty</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">    
    <link href="/css/common.css" rel="stylesheet" type="text/css"> 
    <link href="/css/login.css" rel="stylesheet" type="text/css"> 
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<!-- #362bd4 -->
<body>
    <div class="container" style="text-align: center">
        <h1>CRAFTY</h1>
        <form method="post" action="login.jsp">
            <input type="text" placeholder="아이디를 입력해주세요." id="id" name="id" required>
            
            <input type="password" placeholder="비밀번호를 입력해주세요." name="password" required>
            
            <button type="submit" href="/main" style="color:#E8F1F5;"><b>LOGIN</b></button>

            <div class="links" style="font-size : 12px; color:#8a8a8a;" >
                <a href="/signUp">회원가입</a> / 
                <a href="/find"> 아이디 찾기</a> / 
                <a href="/find"> 비밀번호 찾기</a>
            </div>

            <!-- Naver -->
            <button type="submit" href=# style= "background-color:rgb(45, 192, 32); color:#ffffff;">
              <b>네이버로 로그인</b>
            </button>


            <!-- Kakao -->
            
            <button type="submit" href=# style= "background-color:rgb(253, 229, 8); color:#241313;">
              <a onclick="kakaoLogin();"><b>카카오로 로그인</b></a>
            </button> 
         
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

            <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
                </script>

        </form>
    </div>
</body>
</html>