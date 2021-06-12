---
title: 깃허브블로그 만들기 (GitHub blog)
category: blog
tags: GitHub blog pages minimal-mistakes 테마 댓글 disqus jekyll git
---

이 문서는 깃허브블로그 만드는 법을 minimal-mistakes 테마를 사용하여 설명합니다.
공통되는부분도 있고 다른부분도 있으니 유의해서 봐주세요.

# 블로그만들기

## 테마정하기

Jekyll 테마제공 사이트

<[Free Jekyll Themes](https://jekyllthemes.io/free)>

후보테마

<[mmistakes/minimal-mistakes: Jekyll theme for building a personal site, blog, project documentation, or portfolio. (github.com)](https://github.com/mmistakes/minimal-mistakes)>

<[mmistakes/minimal-mistakes: Jekyll theme for building a personal site, blog, project documentation, or portfolio. (github.com)](https://github.com/mmistakes/minimal-mistakes)>

기준

1. 모바일에서 보기 편한 반응형인지
2. 디자인이 마음에 드는지
3. 검색, 태그, 댓글, Syntax Highlighting, 수식입력 등 기능 지원
4. 가격 등

## 테마 가져오기

> 선행학습 : GitHub 계정이 있나요? Git 이 깔려있나요? 

1. Fork : 테마제공자로부터 계속 업데이트받을 수 있고 Pull request 등도 할 수 있다.
2. Clone : 본인만의 Commit 을 쌓을 수 있다.

본인은 Clone 했으므로 이 방법대로 설명합니다.

![howToMakeGitHubBlog2](\assets\images\howToMakeGitHubBlog1.png)

1) 테마 GitHub 사이트에서 Code 를 눌러 오른쪽 버튼을 눌러 URL 을 복사합니다.

![howToMakeGitHubBlog2](\assets\images\howToMakeGitHubBlog2.png)

2) Git Bash 를 실행해 폴더 (저는 blog 폴더에 내려받겠습니다) 에 내려받습니다.

```bash
cd "폴더위치"
ls # 자신의폴더이름 확인
git clone "URL 붙여넣기" "폴더이름" # 붙여넣기는 Shift + Insert
```



![howToMakeGitHubBlog2](\assets\images\howToMakeGitHubBlog3.png)

3) blog 폴더에 정상적으로 내려받은 것을 확인할 수 있습니다.

![howToMakeGitHubBlog2](\assets\images\howToMakeGitHubBlog4.png)

4) ls -al 명령어로 .git 파일을 확인할 수 있는데요.

![howToMakeGitHubBlog2](\assets\images\howToMakeGitHubBlog5.png)

5) rm -rf .git 명령어로 삭제합니다. master 가 사라진 것으로 삭제가 제대로 된 것을 알 수 있습니다.

![howToMakeGitHubBlog6](\assets\images\howToMakeGitHubBlog6.png)

6) GitHub 로 들어가 새로운 Repository (레포지토리) 를 만드세요.

![howToMakeGitHubBlog7](\assets\images\howToMakeGitHubBlog7.png)

7) 자신의 이름이 username 이라면 Repository 이름을 username.github.io 로 만드세요.

![howToMakeGitHubBlog8](\assets\images\howToMakeGitHubBlog8.png)

8) 자신의 Repository 가 만들어진 것을 볼 수 있습니다. 클릭하세요.

![howToMakeGitHubBlog9](\assets\images\howToMakeGitHubBlog9.png)

9) Settings 을 누르고 좌측 탭에서 Pages 를 누른 후 Source 를 master 에 연결하면 페이지가 생성됩니다.
![howToMakeGitHubBlog9](\assets\images\howToMakeGitHubBlog10.png)

10) 성공! 초록색 창에 "Your site is published at https://~" 를 클릭해서 들어가보세요!!

도움이 되었다면 댓글을 달아주세요!!

# 기능추가

## 댓글기능

> Disqus is an American blog comment hosting service for web sites and online communities that use a networked platform.

우리는 disqus 라는 '웹사이트 혹은 온라인 커뮤니티를 위한 미국 블로그 댓글호스팅 서비스' 를 이용할 것입니다.

<https://disqus.com/profile/login/>

![image-20210612210333738](../../assets/images/image-20210612210333738.png)&#160;&#160;![image-20210612210552316](../../assets/images/image-20210612210552316.png)&#160;&#160;![image-20210612211347815](../../assets/images/image-20210612211347815.png)

1) Disqus 에 가입합니다.

2) Get started 를 클릭합니다.

3) 아래에 I want to install Disqus on my site 를 클릭합니다.

4) Website Name 에 본인의 Disqus URL 이 될 이름을 정해줍니다.

  ![그림입니다.  원본 그림의 이름: CLP000070b40003.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485f90.bmp)  

5) 아래로 내리면 무료플랜인 Basic plan 이 보입니다. Subscribe Now 를 클릭합니다.

  ![그림입니다.  원본 그림의 이름: CLP000070b40004.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485f94.bmp)  

6) 본인의 플랫폼을 선택합니다. 저는 Jekyll Platform 이군요.

![그림입니다.  원본 그림의 이름: CLP000070b40005.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485fa6.bmp)  

7-1) _config.yml 파일의 가장 하단에 'comments: true' 를 입력합니다. (아래사진처럼)

![image-20210612212702056](../../assets/images/image-20210612212702056.png)

7-2) 본인의 layout 이 single 인 것을 확인하고 (7-3에 영향을 줍니다.)

  ![그림입니다.  원본 그림의 이름: CLP000070b40007.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485fbc.bmp)  

Universal Embed Code 를 눌러서 1번에 나오는 코드를 복사합니다. (6과 7-1 사이 사진)


![image-20210612213626810](../../assets/images/image-20210612213626810.png)

7-3) if page.comments 와 endif 를 앞뒤로 추가해서 _layouts/single.html 에 이렇게 추가해주면 됩니다.

저는 '공유하기' 와 '이전 & 다음 버튼' 사이에 넣었습니다.


![그림입니다.  원본 그림의 이름: CLP000070b40006.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485fb6.bmp)  

8) Website URL 에 본인의 웹사이트주소를 넣습니다. Comment Policy URL 은 비워두면 자동으로 완성되므로 저는 Category 만 선택하고 Next 를 눌렀습니다.

  ![그림입니다.  원본 그림의 이름: CLP000070b40008.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485fbf.bmp)  

9) Balanced 는 이미지, 비디오, 링크, 게스트 댓글 등을 허용하고 Strict (엄격한 모드) 는 허용하지 않습니다.

> 게스트모드는 이름과 이메일만으로 댓글을 작성할 수 있습니다.

![image-20210612215821454](../../assets/images/image-20210612215821454.png)

10) _config.yml 파일에서 'comments:' 부분을 찾아 'provider:' 에 "disque" 를 입력하고 'shortname:' 에 자신의 Disqus 사이트이름을 입력합니다. 만약 모르겠다면

![image-20210612220113829](../../assets/images/image-20210612220113829.png)

Admin 으로 들어가서

![image-20210612220201703](../../assets/images/image-20210612220201703.png)

Settings - General - Shortname 을 확인합니다.

![그림입니다.  원본 그림의 이름: CLP000070b40011.bmp  원본 그림의 크기: 가로 1920pixel, 세로 1080pixel](../../assets/images/EMB000029485fd7.bmp)  

완성! 도움이 되었다면 댓글을 달아주세요!!

## 목차기능

minimal-mistakes 테마기준으로 목차는 이미 구현되있습니다.

![image-20210612222546425](../../assets/images/image-20210612222546425.png)

'_config.yml' 파일의 가장 하단부분에서 'defaults:' 를 찾은 후 

- 'toc: true' 를 입력해 목차를 활성화합니다.
- 'toc_label:' 부분에 목차위에 표시될 글을 입력합니다.
- 'toc_sticky: true' 를 입력해 목차를 화면이동과 같이 움직이게 합니다.

![image-20210612222936797](../../assets/images/image-20210612222936797.png)

오른쪽에 목차가 성공적으로 표시됩니다. :)
