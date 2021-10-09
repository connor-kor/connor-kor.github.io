---
title: 안드로이드 키워드
category: shortcut
---

**버튼**

```java
Button button = findViewById(R.id.button);
button.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {

    }
});
```

1. B b = f R.id.버튼
2. b. new

버튼.셋온클릭리스너(뉴 뷰.온클릭리스너)

**inflate**

```java
LayoutInflater inflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
inflater.inflate(R.layout.xml, view);
```

1. L i = sy Co. 후 캐스팅
2. i. R.l.레이아웃 뷰

리시코 아이 알 엘

**Toast**

```java
Toast.makeText(this, "", Toast.LENGTH_SHORT).show();
```

Toast

