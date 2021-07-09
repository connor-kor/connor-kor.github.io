---
title: 1) 사이드바에 카테고리 만드는 방법 (커스텀)
categories: blog
---

<[사이드바에 카테고리 만드는 방법 (커스텀) (velog.io)](https://velog.io/@connor/사이드바에-카테고리-만드는-방법-커스텀#1-category-cppmd){:target="_blank"}>

> 코드를 여기 넣으니 for 문이 실행되서 velog 에 옮겨놓았습니다.

## 1. category-cpp.md 파일 생성 : 페이지 만들기

root directory 에 _pages 폴더를 만들고 그 안에 categories 폴더를 만들어 마크다운 파일을 저장

## 2. nav_list_main 파일 생성 : 커스텀 사이드바 코드

> txt 파일이 아닌 일반파일로 만들 것!!

## 3. sidebar.html 에 추가 : sidebar 가 true 이면 사이드바 추가

세 줄의 코드를 `</div>` 위에 붙여넣습니다.

## 4. 카테고리 등록 및 _config.yml 추가

글을 작성할 때 `categories: 카테고리` 를 작성해보세요!

그 후 _config.yml 파일의 가장 하단부에 있는 defaults 에 `sidebar_main: true` 를 추가하세요!

---

### 출처

식빵맘님 감사합니다 :)

<[[Github 블로그\] minimal-mistake 블로그 카테고리 만들기 (+ 전체 글 수) - 평생 공부 블로그 : Today I Learned‍ 🌙 (ansohxxn.github.io)](https://ansohxxn.github.io/blog/category/){:target="_blank"}>
