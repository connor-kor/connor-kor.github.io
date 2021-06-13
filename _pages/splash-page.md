---

# 이미지 위 글귀
title: "Welcome to my blog"
layout: splash

# permalink 가 / 일 때 메인화면이 됩니다.
permalink: /
date: 2016-03-23T11:48:41-04:00
header:
  overlay_color: "#000"

  # 이미지 밝기 : 0~1 숫자가 점점 진해집니다.
  overlay_filter: "0.5"

  # 헤더 이미지
  overlay_image: /assets/images/macBook.jpg

  # 이미지 위 버튼
  #actions:
  #  - label: "Go!!"
  #    url: "https://connor-kor.github.io/blog/Make-GitHub-blog/"

  # 이미지 저작권
  caption: "Photo credit: [**Patryk Sobczak**](https://unsplash.com/@patryksobczak?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on Unsplash"

# 이미지 위 작은글귀
excerpt: "제 블로그에 오신 것을 환영합니다!!<br><br><br><br><br><br>"
intro: 

  # 본문글귀
  - excerpt: ''
feature_row:

  # 첫 번째 이미지
  - image_path: assets/images/main-git branch.jpg

    # 이미지 저작권
    image_caption: "Photo by [Yancy Min](https://unsplash.com/@yancymin?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
    alt: "placeholder image 1"

    # 제목 및 설명
    title: "Git"
    excerpt: "Git으로 버전 관리하는 블로그를 운영하고 싶은가요?"

    # 두 번째 이미지
  - image_path: /assets/images/main-GitHub blog.jpg

    # 이미지 저작권
    image_caption: "Photo by [Anete Lūsiņa](https://unsplash.com/@anete_lusina?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
    alt: "placeholder image 2"

    # 제목 및 설명
    title: "GitHub blog"
    excerpt: "GitHub 블로그라고 들어보셨나요?"

    # 링크
    url: "/blog/Make-GitHub-blog/"
    btn_label: "Read More"
    btn_class: "btn--primary"

    # 세 번째 이미지
  - image_path: /assets/images/main-love girl.jpg

    # 이미지 저작권
    image_caption: "Photo by [Bart LaRue](https://unsplash.com/@bartlarueeppler?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

    # 제목 및 설명
    title: "Start"
    excerpt: "지금 바로 시작해 보세요!!"

# feature_row2:
#   - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
#     alt: "placeholder image 2"
#     title: "Placeholder Image Left Aligned"
#     excerpt: 'This is some sample content that goes here with **Markdown** formatting. Left aligned with `type="left"`'
#     url: "#test-link"
#     btn_label: "Read More"
#     btn_class: "btn--primary"
# feature_row3:
#   - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
#     alt: "placeholder image 2"
#     title: "Placeholder Image Right Aligned"
#     excerpt: 'This is some sample content that goes here with **Markdown** formatting. Right aligned with `type="right"`'
#     url: "#test-link"
#     btn_label: "Read More"
#     btn_class: "btn--primary"
# feature_row4:
#   - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
#     alt: "placeholder image 2"
#     title: "Placeholder Image Center Aligned"
#     excerpt: 'This is some sample content that goes here with **Markdown** formatting. Centered with `type="center"`'
#     url: "#test-link"
#     btn_label: "Read More"
#     btn_class: "btn--primary"
---

<!-- 인트로 글귀 및 선 -->
{% include feature_row id="intro" type="center" %}

{% include feature_row %}

<!-- {% include feature_row id="feature_row2" type="left" %}

{% include feature_row id="feature_row3" type="right" %}

{% include feature_row id="feature_row4" type="center" %} -->