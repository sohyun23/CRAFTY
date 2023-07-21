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
        <h1 id="craftyTitle" style="cursor: pointer;">CRAFTY</h1>
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
                
			<script>		
				$(document).ready(function() {
			        $("#pw").keypress(function(event) {
			            if (event.keyCode === 13) { // Enter 키의 keyCode 값은 13
			                event.preventDefault();
			                $("#loginBtn").click();
			            }
			        });
			    });
			
			
				$(document).ready(function() {
				  $("#loginBtn").click(function(event) {
				    event.preventDefault();
				    var id = $("#id").val();
				    var pw = $("#pw").val();
				    var json = $().val();
				    var data = {
				      id: id,
				      pw: pw
				    };
				    
				/* 	console.log(id);
				    console.log(pw); */
				    
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
				    	  alert("아이디 또는 비밀번호를 잘못 입력하셨습니다");
				      }
				    });			       				    
				  });
		 			<!-- 타이틀 클릭 시, 메인페이지 이동 -->
				  $(document).ready(function() {
				        $("#craftyTitle").on("click", function() {
				                window.location.href = "/main";
				        });
				    });
				});
			</script>
    </div>
</body>
</html>