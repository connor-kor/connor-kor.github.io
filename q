[33mcommit 76bf49388181d9d4a37a39721967c68960b749fc[m
Author: Connor <kimhyunjun576@gmail.com>
Date:   Sun Jun 6 14:25:45 2021 +0900

    Set _config.yml file
    
    Set locale as KR, title as Connor's develop story, modify
    title_separator
    Set subtitle, name as Connor, description, url, repository
    Set defaults setting : comments, show_date

[1mdiff --git a/_config.yml b/_config.yml[m
[1mindex 565b120..7cdb983 100644[m
[1m--- a/_config.yml[m
[1m+++ b/_config.yml[m
[36m@@ -12,23 +12,29 @@[m
 [m
 # theme                  : "minimal-mistakes-jekyll"[m
 # remote_theme           : "mmistakes/minimal-mistakes"[m
[32m+[m[32m# 테마[m
 minimal_mistakes_skin    : "dark" # "air", "aqua", "contrast", "dark", "dirt", "neon", "mint", "plum", "sunrise"[m
 [m
 # Site Settings[m
[31m-locale                   : "en-US"[m
[31m-title                    : "Site Title"[m
[31m-title_separator          : "-"[m
[31m-subtitle                 : # site tagline that appears below site title in masthead[m
[31m-name                     : "Your Name"[m
[31m-description              : "An amazing website."[m
[31m-url                      : # the base hostname & protocol for your site e.g. "https://mmistakes.github.io"[m
[32m+[m[32mlocale                   : "ko-KR"[m
[32m+[m[32m# 사이트 제목[m
[32m+[m[32mtitle                    : "코너의 개발이야기"[m
[32m+[m[32mtitle_separator          : "|"[m
[32m+[m[32msubtitle                 : "Version 0.1" # site tagline that appears below site title in masthead[m
[32m+[m[32m# 닉네임[m
[32m+[m[32mname                     : "Connor"[m
[32m+[m[32mdescription              : "stories for developers"[m
[32m+[m[32murl                      : "https://connor-kor.github.io/" # the base hostname & protocol for your site e.g. "https://mmistakes.github.io"[m
 baseurl                  : # the subpath of your site, e.g. "/blog"[m
[31m-repository               : # GitHub username/repo-name e.g. "mmistakes/minimal-mistakes"[m
[32m+[m[32m# 레포지토리[m
[32m+[m[32mrepository               : "connor-kor/connor-kor.github.io" # GitHub username/repo-name e.g. "mmistakes/minimal-mistakes"[m
 teaser                   : # path of fallback teaser image, e.g. "/assets/images/500x300.png"[m
[32m+[m[32m# 아바타 이름[m
 logo                     : # path of logo image to display in the masthead, e.g. "/assets/images/88x88.png"[m
 masthead_title           : # overrides the website title displayed in the masthead, use " " for no title[m
 # breadcrumbs            : false # true, false (default)[m
 words_per_minute         : 200[m
[32m+[m[32m# 댓글기능[m
 comments:[m
   provider               : # false (default), "disqus", "discourse", "facebook", "staticman", "staticman_v2", "utterances", "custom"[m
   disqus:[m
[36m@@ -276,7 +282,11 @@[m [mdefaults:[m
     values:[m
       layout: single[m
       author_profile: true[m
[32m+[m[32m      # 읽었던 시간표시[m
       read_time: true[m
[31m-      comments: # true[m
[32m+[m[32m      # 댓글기능[m
[32m+[m[32m      comments: true[m
       share: true[m
       related: true[m
[32m+[m[32m      # 날짜표시[m
[32m+[m[32m      show_date: true[m
