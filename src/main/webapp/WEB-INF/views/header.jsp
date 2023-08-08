<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_style_header -->
<header>
	<div class="header">
		<div class="centered">
			<a href="/main" class="main-title">CRAFTY</a>		
		</div>
		<c:if test="${empty sessionScope.memberId}">
			<div class="login-container" onclick="location.href='/login';">
				<div class="login-img">
					<img src="/craftyImg/profile.png"/>
				</div>
				<div>로그인/회원가입</div>
			</div>
		</c:if>
		<c:if test="${not empty sessionScope.memberId}">
			<div class="main-dropdown">
				<div class="main-dropdown-button">
					<div class="main-dropdown-profile-image">
						<img src="${sessionScope.profileImg}" onerror="this.src='/img/profile.png';" class="profile-image">
					</div>
					<div class="dropdown-options">
						<c:if test="${sessionScope.position eq 0}">
							<a href="/register" class="dropdown-item">굿즈 등록</a>
							<a href="/profile/${sessionScope.memberId}" class="dropdown-item">프로필</a>
							<a href="/goods/attended" class="dropdown-item">참여 현황</a>						
						</c:if>
						<c:if test="${sessionScope.position eq 1}">						
							<a href="/admin/goods" class="dropdown-item">관리자</a>
						</c:if>
						<a href="/logout" class="dropdown-item">로그아웃</a>
					</div>			
				</div>
	        </div>   
		</c:if>
	</div>
</header>

