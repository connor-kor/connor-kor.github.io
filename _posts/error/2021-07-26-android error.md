---
title: 안드로이드 에러
category: error
---

```
Installation did not succeed.
The application could not be installed.

List of apks:
[0] 'C:\Users\kimhy\Documents\lecture\boostCourse\24.MyProgressBara\app\build\outputs\apk\debug\app-debug.apk'
Installation failed due to: ''cmd package install-create -r -t --user current --full --dont-kill -S 3293889' returns error 'Unknown failure: cmd: Can't find service: package''
```

원인: 설치가 되지 않는 것 보니 용량 문제인 것 같다.

해결: AVD Manager - 우클릭 - Wipe Data

```
Execution failed for task ':app:checkDebugDuplicateClasses'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.CheckDuplicatesRunnable

* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
```

원인: ?

해결: gradle.properties 에 다음과 같은 코드 추가

```
android.enableJetifier=true
```

