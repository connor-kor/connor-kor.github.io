---
title: CSS 프로젝트
category: project_fullstack
---

## 네이버 프로젝트



**div 태그 영역잡기**

```css
div {
	overflow: hidden;    
}
```

**리스트의 왼쪽여백 제거** 

```css
li {
	margin: 0;
	padding: 0;
}
```

**리스트 좌우로 정렬**

```css
li {
    float: left
}
```

혹은

```css
display: inline-block;
```

**네이버 메인** 

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>2021. 12. 2. - 오후 8:10:31</title>
<link rel="icon" type="image/x-icon" href="../images/SiSt.ico">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: sans-serif;
	margin-left: 385px;
	margin-right: 385px;
}

a {
	text-decoration: none;
	color: #888;
}

a:hover {
	text-decoration: underline;
}

header {
	margin: auto;
	width: 1080px;
	height: 215px;
	display: flex;
	align-items: center;
	position: relative;
}

fieldset {
	border: none;
}

.visually-hidden {
	position: absolute !important;
	height: 1px;
	width: 1px;
	overflow: hidden;
	clip: rect(1px, 1px, 1px, 1px);
	clip: rect(1px, 1px, 1px, 1px);
	white-space: nowrap;
}

.links {
	position: absolute;
	top: 0;
	right: 0;
}

.link_text {
	font-size: 10px;
	margin-left: 5px;
}

.img_logo {
	margin-bottom: 12px;
	width: 220px;
	height: 65px;
}

.search_box {
	width: 520px;
	height: 50px;
	border: 2px solid #03cf5d;
	display: flex;
	align-items: center;
}

.search_box input {
	flex: 9;
	height: 46px;
	padding-left: 12px;
	padding-right: 12px;
	border: none;
	outline: none;
	font-size: 18px;
}

.search_box button {
	flex: 1;
	height: 46px;
	margin: 0;
	padding: 0;
	border: none;
	outline: none;
	background: #03cf5d;
	color: #ffffff;
}

header nav {
	width: 100%;
	height: 45px;
	position: absolute;
	bottom: 0;
}

.nav_items {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 15px;
	font-weight: bold;
	border-top: 1px solid #f1f3f6;
}

.nav_items ul {
	padding-left: 0;
}

.nav_items ul li {
	display: inline-block;
	margin-left: 8px;
}

.nav_items ul li:nth-child(-n+8) a {
	color: #03cf5d;
}

.nav_items ul li a {
	text-decoration: none;
	cursor: pointer;
}

main {
	min-height: 700px;
}

#keyboard {
	color: lightgray;
	font-size: 20px;
	text-align: center;
	width: 10%;
	padding-top: 5px;
}

.search_box i {
	color: white;
	font-size: 22px;
	text-align: center;
}

main div {
	display: block;
}

main div .feed {
	width: 748px;
	height: 45px;
	margin-top: 20px;
	margin-bottom: 10px;
	border: 1px solid lightgray;
	text-align: middle;
}

div .newstand {
	margin-bottom: 20px;
}

.feed a {
	text-decoration: none;
	text-decoration-color: black;
}

.midd {
	padding-top: 9px;
}

div .view {
	width: 750px;
	height: 260px;
	border: 1px solid lightgray;
}

main td {
	width: 120px;
	height: 65px;
	text-align: middle;
	border: 0.5px solid lightgray;
}

.newstand button {
	display: inline-block;
	border: none;
	outline: none;
	box-shadow: none;
	background-color: white;
	border-color: white;
}

.column_left {
	float: left;
	width: 750px;
}

/* 김현준 */
.column_right {
	float: left;
	width: 350px;
	margin-left: 30px;
}

.sc_shopcast {
	width: 350px;
	margin-top: 15px;
}

#yejun_iframe {
	width: 350px;
	height: 430px;
}
</style>
</head>
<body>
	<header>
		<div class="links">
			<a href="/" class="link_text">네이버를 시작페이지로</a> <a href="/"
				class="link_text">쥬니어네이버</a> <a href="/" class="link_text">해피빈</a>
		</div>
		<a href="/"><img src="naver_basic_jpg.jpg" class="img_logo" /></a>
		<form>
			<fieldset>
				<legend class="visually-hidden">검색</legend>
				<div class="search_box">
					<input type="text" maxlength="225" tabindex="1" /><i id="keyboard"
						class="fa fa-keyboard-o"></i>
					<button type="submit" tabindex="2">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</fieldset>
		</form>
		<div>
			<img
				src="https://s.pstatic.net/static/www/mobile/edit/20211130/mobile_141941831425.png"
				alt="자원봉사자의 날" width="225px" height="56px"
				style="vertical-align: top;">
		</div>
		<nav>
			<div class="nav_items">
				<ul>
					<li><img src="mail.JPG" alt=""
						style="vertical-align: middle; width: 30px; padding-right: 4px;"><a
						href="/">메일</a></li>
					<li><a href="/">카페</a></li>
					<li><a href="/">블로그</a></li>
					<li><a href="/">지식iN</a></li>
					<li><a href="/">쇼핑</a></li>
					<li><a href="/">쇼핑LIVE</a></li>
					<li><a href="/">Pay</a></li>
					<li><a href="/">TV</a></li>
					<li><a href="/">사전</a></li>
					<li><a href="/">뉴스</a></li>
					<li><a href="/">증권</a></li>
					<li><a href="/">부동산</a></li>
					<li><a href="/">지도</a></li>
					<li><a href="/">VIBE</a></li>
					<li><a href="/">책</a></li>
					<li><a href="/">웹툰</a></li>
					<li><a href="/">더보기</a></li>
				</ul>
				<div class="weather">
					<span></span> <span><img src="sun.JPG" alt=""
						style="width: 28px; vertical-align: middle; text-align: center; padding-right: 4px;">9.0°
						맑음</span> <span style="color: lightblue; font-size: 80%;">-2.0°</span> <span
						style="color: gray; font-size: 80%;">/8.0° 신림동</span>
				</div>
			</div>
		</nav>
	</header>
	<main>
		<div class="con">

			<div id="NM_INT_LEFT" class="column_left">
				<div class="advertisement">
					<a href="https://www.coupangeats.com/play_coldplay_tb/"><img
						src="gwanggo.jpg" style="width: 750px; height: 135px;"></a>
				</div>
				<div class="feed">
					<div class="midd">

						&nbsp;&nbsp;<b>중앙일보</b> > 확진자 증가에 따른 환자 급증! 정부 거리두기 단계 고려중 <a
							href="https://news.naver.com/"> 네이버뉴스 </a> * <a
							href="https://entertain.naver.com/home">연예 </a> <a
							href="https://sports.news.naver.com/index">스포츠 </a> <a
							href="https://news.naver.com/main/main.naver?mode=LSD&mid=shm&sid1=101">경제</a>


					</div>
				</div>

				<div class="newstand">
					<div class="midd">

						<a href="https://newsstand.naver.com/"><img src="newstand.png"><b>뉴스스탠드</b></a>
						>
						<button class="subscribe">구독한 언론사</button>
						&nbsp;*
						<button class="allnews">
							<b>전체언론사</b>
						</button>
						&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
						<img src="btnimg.PNG">
					</div>

				</div>
				<div class="view_table" id="view_form_all">
					<table class="newstable">
						<tr>
							<td><img src="asia.png" width="120px" height="65px"></td>
							<td><img src="dailyanpng.png" width="120px" height="65px"></td>
							<td><img src="osen.png" width="120px" height="65px"></td>
							<td><img src="kyongje.png" width="120px" height="65px"></td>
							<td><img src="jiji.png" width="120px" height="65px"></td>
							<td><img src="kbs.png" width="120px" height="65px"></td>
						</tr>
						<tr>
							<td><img src="kbs.png" width="120px" height="65px"></td>
							<td><img src="asia.png" width="120px" height="65px"></td>
							<td><img src="dailyanpng.png" width="120px" height="65px"></td>
							<td><img src="osen.png" width="120px" height="65px"></td>
							<td><img src="kyongje.png" width="120px" height="65px"></td>
							<td><img src="jiji.png" width="120px" height="65px"></td>
						</tr>
						<tr>
							<td><img src="jiji.png" width="120px" height="65px"></td>
							<td><img src="kbs.png" width="120px" height="65px"></td>
							<td><img src="asia.png" width="120px" height="65px"></td>
							<td><img src="dailyanpng.png" width="120px" height="65px"></td>
							<td><img src="osen.png" width="120px" height="65px"></td>
							<td><img src="kyongje.png" width="120px" height="65px"></td>
						</tr>
						<tr>
							<td><img src="kyongje.png" width="120px" height="65px"></td>
							<td><img src="jiji.png" width="120px" height="65px"></td>
							<td><img src="kbs.png" width="120px" height="65px"></td>
							<td><img src="asia.png" width="120px" height="65px"></td>
							<td><img src="dailyanpng.png" width="120px" height="65px"></td>
							<td><img src="osen.png" width="120px" height="65px"></td>
						</tr>
					</table>
				</div>


				<div>
					<iframe src="layout05.html" width="100%" height="800px"
						frameborder="0" scrolling="no"></iframe>
				</div>


				<div>
					<iframe src="layout06.html" width="750px" height="250px"
						frameborder="0" scrolling="no"></iframe>
				</div>



				<div>
					<iframe src="layout05.html" width="100%" height="800px"
						frameborder="0" scrolling="no"></iframe>
				</div>


			</div>

			<div id="NM_INT_RIGHT" class="column_right">
				<iframe src="layout03.html" frameborder="0" id="yejun_iframe"></iframe>
				<div id="shopcast" class="sc_shopcast">
					<iframe id="shopcast_iframe" title="쇼핑캐스트" width="350"
						height="1539" marginheight="0" marginwidth="0" scrolling="no"
						frameborder="0" src="layout04_07.html"></iframe>
				</div>
			</div>

		</div>
	</main>


	<footer>
		<div>
			<iframe src="foot.html" width="100%" height="220" frameborder="0"
				scrolling="no"></iframe>
		</div>
	</footer>
</body>
</html>
```

