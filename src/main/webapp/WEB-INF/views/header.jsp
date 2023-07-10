<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_style_header -->
<header>
	<div class="header">
		<div class="centered">
			<a href="/main" class="main-title">CRAFTY</a>		
		</div>
		
		<div class="main-dropdown">
			<div class="main-dropdown-button">
				<div class="main-dropdown-profile-image">
					<img alt="profile-image" src="${profile.imgPath}" class="profile-image">
				</div>
				<div class="dropdown-options">
					<a href="#" class="dropdown-item">굿즈 등록</a>
					<a href="#" class="dropdown-item">프로필</a>
					<a href="#" class="dropdown-item">참여 현황</a>
					<a href="#" class="dropdown-item">로그아웃</a>
				</div>			
			</div>
        </div>   
	</div>
</header>

