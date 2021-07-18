---
title: 안드로이드 부스트코스
category: android
---

## 5. 네트워킹

**스레드**

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

        Button check = (Button) findViewById(R.id.check);
        check.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });
    }
```

```java
    class BackgroundThread extends Thread {
        int value = 0;
        boolean running = false;

        public void run() {
            running = true;
            while (running) {
                value += 1;
                Message message = handler.obtainMessage();
                Bundle bundle = new Bundle();
                bundle.putInt("value", value);
                message.setData(bundle);
                handler.sendMessage(message);
                try {
                    Thread.sleep(1000);
                } catch (Exception e) {
                }
            }
        }
    }

    class ValueHandler extends Handler {
        @Override
        public void handleMessage(@NonNull Message msg) {
            super.handleMessage(msg);
            Bundle bundle = msg.getData();
            int value = bundle.getInt("value");
            textView.setText("현재 값: " + value);
        }
    }
```

