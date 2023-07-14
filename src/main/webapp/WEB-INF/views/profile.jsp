<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crafty</title>
    <meta charset="UTF-8">
    <meta name="css" content="width=device-width, initial-scale=1">
	<link href="/css/common.css" rel="stylesheet" type="text/css">  
    <link href="/css/profile.css" rel="stylesheet" type="text/css">     
</head>

<body>
<%@ include file="header.jsp" %>
    <header>

        <div class="main-container">
    
            <div class="profile">
    
                <div class="profile-image">
                    <!-- 이 부분에 업로드 받은 이미지 출력 w, h 250px radius 50% 또는 정해진 규격에 맞게 출력되도록 작성 -->
                    <!-- 이미지는 파일 시스템에 저장해서 출력하는 형태로 진행 -->
                    <img src="img\profile2.png" alt="">
    
                </div>
                <div class="profile-user-settings">
    
                    <h1 class="profile-user-name" id="nickname" name="nickname">POJO</h1>
                    
                    <button class="btn profile-edit-btn" onclick="location.href='/profile/edit'">프로필 수정</button>
                    <!-- 이 부분에 업로드 받은 자기소개 출력(200자) --> 
                    <!-- <button class="btn profile-settings-btn" aria-label="profile settings"><i class="fas fa-cog" aria-hidden="true"></i></button> -->
    
                </div>
    
                <div class="profile-bio">
    
                    <p  id="introduce" name="introduction"> 
			                        귓가에 넘치는 바다
			                        눈을 감고 느낀다
			                        난 자리에 가만히 앉아
			                        항해하는 법을 알아
			
			                        뱃노래 뱃노래
			                        외로움을 던지는 노래
			                        몇고개 몇고개의
			                        파도를 넘어야 하나
                     </p>
    
                </div>
    
            </div>
        </div>
            <!-- End of profile section -->
        <!-- End of container -->
        
      </header>
      <main class="main-container">
          <hr style="border: solid px black;">
          <div class="dropdown">
            <br>
                <div>
                    <!-- form id는 메인페이지 진행중, 종료 확인 -->
                    <form >
                      <select class="dropdown-select" id="" onchange="redirectToPage()">
                        <!-- profile?order=recommend -->
                        <option>전체</option>
                        <!-- value에 진행중, 종료 페이지 이동 -->
                        <!-- 진행중 카드 나열 -->
                        <option>진행중</option>
                        <!-- 종료된 카드 나열 -->
                        <option>종료</option>
                        <!-- 안되면 위의 페이지 사용 -->

                        <!-- 비동기로 페이지 가져옵니다 -->
                        <!-- <option value="">진행중</option>
                        <option value="">종료</option> -->
                      </select>
                    </form>
                </div>
                <script>
                    function redirectToPage() {
                      var dropdown = document.getElementById("ing");
                      var selectedOption = dropdown.value;
                      
                      if (selectedOption) {
                        window.location.href = selectedOption;
                      }
                    }
                  </script>
                <br>
                <!-- 이 부분에 카드 넣을 겁니다. -->
                <!-- End of card -->
        
                <!-- <div class="loader"></div> -->
        
                <!-- <hr class="main-container" style="border: solid 1px rgba(255, 255, 255, 0);"> -->
          </div>
            <!-- End of container -->
          <ul class="cards">
          	<li>
          		<div class="card">
                  <div class="card-image-holder">
                    <img class="card-image" src="https://source.unsplash.com/300x225/?wave" alt="wave" />
                  </div>
                  <div class="card-title">
                    <a href="#" class="toggle-info btn">
                      <span class="left"></span>
                      <span class="right"></span>
                    </a>
                    <h2>
                        Card title
                        <small>여기에 카테고리 또는 달성률 기입</small>
                      </h2>
                    </div>
                    <div class="card-description">
                      This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
                    </div>
                </div>
          	</li>
                
              
                <div class="card">
                  <div class="card-image-holder">
                    <img class="card-image" src="https://source.unsplash.com/300x225/?beach" alt="beach" />
                  </div>
                  <div class="card-title">
                    <a href="#" class="toggle-info btn">
                      <span class="left"></span>
                      <span class="right"></span>
                    </a>
                    <h2>
                      Card title
                      <small>여기에 카테고리 또는 달성률 기입</small>
                    </h2>
                  </div>
                  <div class="card-description">
                    This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
                  </div>
              </div>
               
                <div class="card">
                  <div class="card-image-holder">
                    <img class="card-image" src="https://source.unsplash.com/300x225/?mountain" alt="mountain" />
                  </div>
                  <div class="card-title">
                    <a href="#" class="toggle-info btn">
                      <span class="left"></span>
                      <span class="right"></span>
                    </a>
                    <h2>
                      Card title
                      <small>여기에 카테고리 또는 달성률 기입</small>
                    </h2>
                  </div>
                  <div class="card-description">
                    This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
                  </div>
              </div>
              
                <div class="card">
                  <div class="card-image-holder">
                    <img class="card-image" src="https://source.unsplash.com/300x225/?field" alt="field" />
                  </div>
                  <div class="card-title">
                    <a href="#" class="toggle-info btn">
                      <span class="left"></span>
                      <span class="right"></span>
                    </a>
                    <h2>
                      Card title
                      <small>여기에 카테고리 또는 달성률 기입</small>
                    </h2>
                  </div>
                  <div class="card-description">
                    This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
                  </div>
              </div>
              
                <div class="card">
                  <div class="card-image-holder">
                    <img class="card-image" src="https://source.unsplash.com/300x225/?water" alt="water" />
                  </div>
                  <div class="card-title">
                    <a href="#" class="toggle-info btn">
                      <span class="left"></span>
                      <span class="right"></span>
                    </a>
                    <h2>
                      Card title
                      <small>여기에 카테고리 또는 달성률 기입</small>
                    </h2>
                  </div>
                  <div class="card-description">
                    This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
                  </div>
              </div>
              
                <div class="card">
                  <div class="card-image-holder">
                    <img class="card-image" src="https://source.unsplash.com/300x225/?river" alt="river" />
                  </div>
                  <div class="card-title">
                    <a href="#" class="toggle-info btn">
                      <span class="left"></span>
                      <span class="right"></span>
                    </a>
                    <h2>
                      Card title
                      <small>여기에 카테고리 또는 달성률 기입</small>
                    </h2>
                  </div>
                  <div class="card-description">
                    This grid is an attempt to make something nice that works on touch devices. Ignoring hover states when they're not available etc.
                  </div>
          </ul>
            <!-- End of card -->
            <div class="pagination-box">
				<nav class="pagination-nav">
					<ul class="pagination">
						
						<c:if test="${pageInfo.prev}">
							<li><a aria-label="Previous" href="/profile/${memberId}?pageNum=${pageInfo.startPage - 1}">Prev</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<li class="${pageInfo.pageRequest.pageNum == num ? "active" : ""}"><a href="/profile/${memberId}?pageNum=${num}">${num}</a></li>
						</c:forEach>
						
						<c:if test="${pageInfo.next}">
							<li><a aria-label="next" href="/profile/${memberId}?pageNum=${pageInfo.endPage + 1}">Next</a></li>
						</c:if>
					
					</ul>
				</nav>
			</div>
<%@ include file="footer.jsp" %>
</main>
</body>
</html>
