---
title: 안드로이드 부스트코스
category: android
---

# 위젯

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

configure - check for update: 최신버전 확인

루트디렉토리에 .android 폴더가 생성된다.

패키지 생성 시 Name: 앱이름이 되며 파스칼표기법 혹은 띄어쓰기를 활용한다.

AVD Manager 를 통해 가상단말을 추가한다.

폰트설정: file - settings - editor - font

오토임폴트: file - settings - editor - general - auto import - 

- add unambiguous imports on the fly: import 문 자동추가
- optimize imports on the fly: 불필요한 import문을 제거하여 자동으로 최적화

**도구사용**



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

