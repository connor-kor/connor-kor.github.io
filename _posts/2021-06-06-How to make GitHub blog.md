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

1. Fork : 테마제공자로부터 계속 업데이트받을 수 있고 Pull request 등도 할 수 있다.
2. Clone : 본인만의 Commit 을 쌓을 수 있다.

본인은 Clone 했으므로 이 방법대로 설명합니다.

<img src="/assets/images/howToMakeGitHubBlog1.png" width="600px">

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

10) 초록색 창에 "Your site is published at https://~" 를 클릭해서 들어가보세요!!
