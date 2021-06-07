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

## 카테고리 및 태그 페이지 연결하기

root directory 에 "_pages" 폴더를 만들고

category-archive.md 와 tag-archive.md 를 붙여넣는다.

```mark
title: "Posts by Category"
layout: categories
permalink: /categories/
author_profile: true
```

```markd
title: "Posts by Tag"
permalink: /tags/
layout: tags
author_profile: true
```

