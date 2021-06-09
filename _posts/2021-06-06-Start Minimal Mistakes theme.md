---
title: Minimal Mistakes 테마 시작하기
categories: blog
---

## 글쓰는 법

1. root directory 에 "_posts" 폴더를 만들고 

2. .md 확장자로 저장. 형식은 "YEAR_MONTH_DAY-title.md" 를 따른다.

   ex) 2021-06-06-Start Minimal Mistakes theme

   title 은 영어로 작성할 것.

\-\-\-

title: 제목

categories: category

tags: tag

\-\-\-

## 이미지 추가하는 법

보통 직접 assets/images 폴더에 이미지파일을 저장하고 상대경로로 연결해야 한다.

하지만 이 작업을 Typora 프로그램에서 해주기 때문에 이미지를 직접 저장하는 과정이 필요없다.

![image-20210609230029207](/assets/images/image-20210609230029207.png)

1) 파일 - 환경설정

![image-20210609230302150](/assets/images/image-20210609230302150.png)

2) 이미지탭에서 When Insert - 특별한 동작없음 을 클릭하고 Copy image to custom folder 로 변경한 후 

- "로컬 이미지에 위 규칙을 적용"
- "온라인 이미지에 위 규칙을 적용"
- "가능하다면 상대적 위치 사용" 을 체크한다.

> 만약 Typora 에서는 보이는데 서버에서는 보이지 않는다면 Ctrl + / 를 눌러 assets 앞에 ".." 을 없애고 저장 후 다시 확인해본다.


1. Print Screen 버튼을 누른 후 붙여넣기
2. 한글파일에서 저장 후 붙여넣기
3. 인터넷에서 복사 후 붙여넣기

모두 정상 작동하는 것을 볼 수 있다.

> 단 삭제는 수동으로 해야한다. 붙여넣기 후 안쓰는 이미지라면 삭제할 것!!

## 카테고리 및 태그 페이지 연결하기

root directory 에 "_pages" 폴더를 만들고

category-archive.md 와 tag-archive.md 를 붙여넣는다.

```html
title: "Posts by Category"
layout: categories
permalink: /categories/
author_profile: true
```

```html
title: "Posts by Tag"
permalink: /tags/
layout: tags
author_profile: true
```

## 헤드에 메뉴버튼 만들기

```yaml
# main links
main:
  - title: 카테고리
    url: /categories/
  - title: 태그
    url: /tags/
  - title: 아카이브
    url: /year-archive/
  - title: "Sample Collections"
    url: /collection-archive/
  - title: "Quick-Start Guide"
    url: https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/
  - title: "Sitemap"
    url: /sitemap/
  # - title: "About"
  #   url: https://mmistakes.github.io/minimal-mistakes/about/
```

_data/navigation.yml 파일에 title 과 url 을 추가한다.

이 url 은 root directory 에 _pages 폴더 내에 적절한 파일이 있어야 한다.
