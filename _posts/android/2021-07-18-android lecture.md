---
title: 안드로이드 부스트코스
category: android
---

# 0. 위젯

**토스트**

```java
Toast.makeText(getApplicationContext(), "버튼이 눌렸어요.", Toast.LENGTH_LONG).show();
```

**링크연결** 

```java
Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://m.naver.com"));
startActivity(intent);
```



# 1. 레이아웃

android studio: IntelliJ 에서 발전된 개발도구

다운로드링크: <https://developer.android.com/studio?gclid=CjwKCAjwos-HBhB3EiwAe4xM91psnsUbokVvgwEWcNRh-BxSys_fKIvvB6wOoWJ5ZnKqZk_rzkfX0BoCt10QAvD_BwE&gclsrc=aw.ds>{:target="_blank"}

help - check for update: 최신버전 확인

루트디렉토리에 .android 폴더가 생성된다.

패키지 생성 시 Name: 앱이름이 되며 파스칼표기법 혹은 띄어쓰기를 활용한다.

AVD Manager 를 통해 가상단말을 추가한다.

폰트설정: file - settings - editor - font

오토임폴트: file - settings - editor - general - auto import - 

- add unambiguous imports on the fly: import 문 자동추가
- optimize imports on the fly: 불필요한 import문을 제거하여 자동으로 최적화

**도구사용**

테마변경: Appearance&Behavior - Appearance - Theme

gradle 파일 변경저장: Sync project with gradle files

ctrl + Q: 설명문서

ctrl + shift + F: 검색

design 과 blueprint 를 볼 수 있다.

**뷰의속성**

![image-20210719171559186](../../assets/images/image-20210719171559186.png)

뷰 (View): 화면에 보이는 것들. 흔히 컨트롤이나 위젯이라 불리는 UI 구성요소

뷰그룹 (View Group)

위젯 (Widget): 뷰 중에서 일반적인 컨트롤의 역할을 하고있는 것

레이아웃 (Layout): 뷰 그룹 중에서 내부에 뷰들을 포함하고 있으면서 그것들을 배치하는 역할을 하는 것

레이아웃 안에 레이아웃을 포함시킬 수 있다.

필수속성: `layout_width`, `layout_height` 

`match_parent` 부모와 같게.

`wrap_content` 내용을 감싼다.

`ConstraintLayout` 

`LinearLayout` orientation 이 필수

**단위**

px: 픽셀

dp or dip: 밀도 독립적 픽셀 (density independent pixel). 화면이 클수록 크게 표현한다.

예) 1인치 당 160개 점이있는 디스플레이화면에서 1dp = 1px

1인치 당 320 개의 점이있는 디스플레이화면에서 1dp = 2px

sp or sip: 축적 독립적 픽셀 (scale independent pixel).

in: 인치

mm: 밀리미터

em: 글꼴과 상관없이 동일한 텍스트크기 표시

보통은 dp 로 모두 작성

**Constraint Layout: 제약 레이아웃**

autoconnection to parent: 자석모양. 자동연결된다.

bias: 위치조정

guidelines 을 만들 수 있다.

**대표레이아웃**

| 레이아웃   | 설명                                                         |
| ---------- | ------------------------------------------------------------ |
| Constraint | 제약조건을 사용해 화면구성<br />최근에 나온 레이아웃         |
| Linear     | 박스모델<br />한쪽방향으로 차례대로 뷰를 추가하며 화면구성   |
| Relative   | 규칙기반모델<br />부모컨테이너나 다른뷰와 상대적위치로 화면구성 |
| Frame      | 싱글모델<br />가장 상위에있는 하나의 뷰 또는 뷰그룹만 보여주는 방법<br />여러개의 뷰가 들어가면 중첩하여 쌓게됨. 여러개의 뷰를 중첩한 후 각 뷰를 전환하여 보여주는 방식 |
| Table      | 격자모델<br />HTML에서 많이 사용하는 정렬방식과 유사하지만 많이 사용하지는 않음 |

뷰의영역 (box) 는 패딩 (padding) 과 테두리 (border) 와 마진 (margin) 까지를 포함한다.  

background 의 앞 두자리는 투명도이다. 00~ff 까지 투명~원색

`layout_gravity` 뷰 정렬

`gravity` 내용 정렬

`layout-margin`

`padding` 

`layout_weight` 남아있는 공간분할

**Relative Layout: 상대 레이아웃**

`layout_alignParentTop` `Bottom` `Left` `Right` 부모에 상대적으로 연결

`layout_alignTop` `Bottom` `Left` `Right` 뷰에 상대적으로 연결

**Frame Layout: 프레임 레이아웃**

뷰의 가시성 (visibility) 을 이용한다.

```java
ImageView imageView = (ImageView) findViewById(R.id.imageView);
```

R: resource

리소스에 있는 imageView 라는 id 를 찾아서 형변환 (캐스팅) 하여 imageView 변수에 넣습니다.

```java
imageView.setVisibility(View.VISIBLE);
```

visibility 를 제어한다.

**버튼클릭으로 이미지변환**

```java
public void clicked(View view) {
    if (bool == true) {
        bool = false;
    } else {
        bool = true;
    }
    if (bool) {
        imageView.setVisibility(View.VISIBLE);
        imageView2.setVisibility(view.INVISIBLE);
    } else {
        imageView.setVisibility(View.INVISIBLE);
        imageView2.setVisibility(view.VISIBLE);
    }
}
```

**기본위젯**

텍스트뷰 속성

- `text` 문자
- `textColor` 색상
- `textSize` 크기
- `textStyle` 스타일속성
- `typeFace` 폰트설정 `normal` `sans` `serif` `monospace` 
- `maxLines="1"` 한 줄로만 표시

`radioButton`

- `isChecked` 

**상태 드로어블**









---



# 5. 네트워킹

## **스레드**

자바의 스레드를 기본으로 쓸 수 있다.

1. 스레드 만들기
2. 화면에 보여주기
3. 애니메이션 만들기
4. 트윈 애니메이션 만들기
5. 그래프 애니메이션 만들기

동시에 리소스를 접근할 경우 데드락 (DeadLcok) 이 발생

표준자바에서 스레드 사용방법

- 스레드는 new 연산자를 이용하여 객체를 생성한 후 start() 메서드를 호출하면 시작함
- Thread 클래스에 정의된 생성자는 그게 파라미터가 없는경우와 Runnable 객체를 파라미터로 가지는 두가지로 구분함

```java
running = true;
Thread thread1 = new BackgroundThread();
thread1.start();
```

핸들러란? (Handler)

- 메시지 큐를 이용해 메인스레드에서 처리할 메시지를 다른 스레드로 전달하는 역할을 담당함
- 특정 메시지가 미래의 어떤시점에 실행되도록 스케줄링 할 수 있음

`obtainMessage()` 

`sendMessage()` 

`handleMessage()` 

**스레드 예제**

```java
TextView textView = (TextView) findViewById(R.id.textView);

Button start = (Button) findViewById(R.id.start);
start.setOnClickListener(new View.OnClickListener() {
@Override
public void onClick(View v) {
	BackgroundThread thread = new BackgroundThread();
	thread.start();
	}
});

Button check = (Button) findViewById(R.id.check);
check.setOnClickListener(new View.OnClickListener() {
@Override
public void onClick(View v) {
	textView.setText("현재 값: " + value);
	}
});
```

```java
class BackgroundThread extends Thread {
    boolean running = false;

    public void run() {
        running = true;
        while (running) {
            value += 1;
            try {
                Thread.sleep(1000);
            } catch (Exception e) {
            }
        }
    }
}
```

**값 입력**

1. 핸들러선언
2. 메시지선언
3. 번들선언
4. `bundle.putInt("key", value)`  번들에 값을 저장합니다.
5. `msg.setData(bundle)` 메시지에 담습니다.
6. `handler.sendMessage(msg)` 핸들러로 메시지를 보냅니다.

**값 읽기**

`msg.getData().getInt("key")` key 값과 연결된 value 를 int 형으로 반환합니다.

`msg.getData()` bundle 값을 반환합니다.

**멀티스레드 예제**

```java
        textView = (TextView) findViewById(R.id.textView);
        Button start = (Button) findViewById(R.id.start);
        start.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                BackgroundThread thread = new BackgroundThread();
                thread.start();
            }
        });
```

```java
    class BackgroundThread extends Thread {
        int value = 0;
        boolean running = false;

        public void run() {
            running = true;
            while (running) {
                value += 1;
                Message msg = handler.obtainMessage();
                Bundle bundle = new Bundle();
                bundle.putInt("key", value);
                msg.setData(bundle);
                handler.sendMessage(msg);
                try {
                    Thread.sleep(1000);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    class ValueHandler extends Handler {
        @Override
        public void handleMessage(@NonNull Message msg) {
            super.handleMessage(msg);
            int value = msg.getData().getInt("key");
            textView.setText("현재 값: " + value);
        }
    }
```

date: 07.19

**압축형 코드**

```java
start.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                for (int i = 0; i < 1000; i++) {
                    int value= i;
                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            textView.setText("현재 값: " + value);
                        }
                    });

                    try {
                        Thread.sleep(1000);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
    }
});
```

**사용방법**

1. 뉴 쓰레드
2. 뉴 러너블
3. 핸들러 포스트
4. 뉴 러너블
5. 쓰레드 스타트

```java
start.setOnClickListener(new View.OnClickListener() {
@Override
    public void onClick(View v) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                handler.post(new Runnable() {
                    @Override
                    public void run() {
                    }
                });
            }
        }).start();
    }
});
```

## AsyncTask

필수요소: doInBackground (콜백요소)

선택요소: onPostExecute, onProgressUpdate

doInBackground 에서 PostExecute 로 값을 넘겨준다.

publishProgress 를 선언하면 onProgressUpdate 를 호출

```java
package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    TextView textView;
    Handler handler = new Handler();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textView = (TextView) findViewById(R.id.textView);
        Button start = (Button) findViewById(R.id.start);
        start.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        for (int i = 0; i < 1000; i++) {
                            int value= i;
                            handler.post(new Runnable() {
                                @Override
                                public void run() {
                                    textView.setText("현재 값: " + value);
                                }
                            });

                            try {
                                Thread.sleep(1000);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }).start();
            }

            class ProgressTask extends AsyncTask<String, Integer, Integer> {
                int value = 0;

                @Override
                protected Integer doInBackground(String... strings) {
                    for(int i = 0; i < 100; i++) {
                        publishProgress(i);

                    }
                    return null;
                }

                @Override
                protected void onProgressUpdate(Integer... values) {
                    super.onProgressUpdate(values);
                }   

                @Override
                protected void onPostExecute(Integer integer) {
                    super.onPostExecute(integer);
                }
            }


        });

    }
}
```

