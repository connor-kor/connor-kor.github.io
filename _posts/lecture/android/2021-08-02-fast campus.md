---
title: 패스트캠퍼스
category: android
---

# 코틀린

1. 함수는 fun 으로 선언. 중괄호로 감싸도 되고 등호로 표현해도 된다.
2. 상수는 val, 변수는 var 타입추론이 가능하므로 타입선언이 꼭 필요하지 않다.
3. null 이 가능한 타입과 가능하지 않은 타입이 있다. 그래서 초기화가 있어야 한다.
4. Long 형은 L, Float 형은 f 를 끝에 붙인다.
5. until 이라는 키워드도 있다.
6. for-each 구문도 for (number in numberList){} 로 사용할 수 있다.
7. while 문과 do-while 문이 있다.
8. 자바와 다르게 Int 는 대문자로 시작한다.
9. swich 문이 없는 대신 when 문이 있다.

```kotlin
fun main() {
    for (i in 1..5) {
        print(i)  // 12345
    }
}
```

```kotlin
fun main() {
    for (i in 1..10 step 2) {
        print(i)  // 13579
    }
}
```

```kotlin
fun main() {
    for (i in 8 downTo 0 step 2) {
        print(i)  // 86420
    }
}
```

**if 문**

```kotlin
var max: Int
if (a > b) {
    max = a
} else {
    max = b
}
```

**간략한 코드:** 변수 = if 와 같이 사용할 수 있다.

```kotlin
var max = if (a > b) {
    a
} else {
    b
}
```

**when 문**

```kotlin
when (x) {
    1 -> print("x 는 1 입니다.")
    2 -> print("x 는 2 입니다")
    else -> print("x 는 1 도 2 도 아닙니다.")
}
```

**콤마 사용**

```kotlin
when (x) {
    1, 3 -> print("x 는 1 또는 3 입니다.")
    2 -> print("x 는 2 입니다")
    else -> print("x 는 1, 2, 3 이 아닙니다.")
	}
}
```

**in 사용**

```kotlin
when (x) {
    in 1..10 -> print("x 는 1 과 10 사이에 있습니다.")
    !in 11..20 -> print("x 는 11 과 20 사이에 없습니다.")
}
```

**is 사용**

```kotlin
when (x) {
    is Int -> print("x 는 정수입니다.")
    else -> print("x 는 정수가 아닙니다.")
}
```

자바의 **switch 문**

```java
int key = 1;

switch (key) {
case 1 -> System.out.print("x 는 1 입니다.");
case 2 -> System.out.print("x 는 2 입니다.");
default -> System.out.print("x 는 1 도 2 도 아닙니다.");
}
```

**자바와 코틀린 비교**

Null Safe

```kotlin
val b: Int? = 100  // null 이 가능
val c: Int = 100   // null 이 불가능
```

NullPointException 을 피하기 위해 안전한 코드를 사용해야 한다.

**안전한 코드**

```kotlin
b?.sum()  // null 일 경우 실행하지 않음
c.sum()   // 애초에 null safe 함
```

자바보다 간략하게 물음표 (?) 만 간단히 넣어 null safe 로 작성할 수 있다.

**Scope Function:** apply, with, let, also, run

| Function | Object reference | Return value   | Is extension function                       |                 |
| -------- | ---------------- | -------------- | ------------------------------------------- | --------------- |
| let      | lt               | Lambda result  | Yes                                         | if 문 null safe |
| run      | this             | Lambda result  | Yes                                         |                 |
| run      | -                | Lambda result  | No: called without the context object       |                 |
| with     | this             | Lambda result  | No: takes the context object as an argument | 객체 메서드     |
| apply    | this             | Context object | Yes                                         | 객체 초기화     |
| also     | lt               | Context object | Yes                                         |                 |

 **apply**

객체를 쉽게 초기화할 수 있다.

new 와 같은 객체 초기화 코드

```kotlin
val person = Person().apply {
    firstName = "Fast"
    lastName = "Campus"
}
```

**also**

```kotlin
Random.nextInt(100).also {
    println("값: $it")  // 값: 56
}
```

```kotlin
Random.nextInt(100).also { value ->
	print("값: $value")
}
```

**java 비교**

```java
int value = Random().nextInt(100);
System.out.print(value);
```

**let**

if 문의 null 확인을 간단히 쓸 수 있다.

null 이 아닌 객체에서 람다를 실행할 때 사용

```kotlin
val number: Int?
val sumNumberStr = number?.let {
    "${sum(10, it)}"
}
```

**java 비교**

```java
Integer number = null;
String sumNumberStr = null;

if (number != null) {
    sumNumberStr = "" + sum(10, number);
}
```



```kotlin
val number: Int?
val sumNumberStr = number?.let {
    "${sum(10, it)}"
}.orEmpty()
```

**java 비교**

```java
Integer number = null;
String sumNumberStr = null;

if (number != null) {
    sumNumberStr = "" + sum(10, number);
} else {
    sumNumberStr = "";
}
```

**with**

객체의 메서드를 한꺼번에 실행할 수 있다.

```kotlin
val person = Person()

with(person) {
    work()
    sleep()
    println(age)
}
```

**java 비교**

```java
Person person = new Person();

person.work();
person.sleep();
System.out.println(person.age);
```

**run**

setter 와 메소드의 반환 값을 변수에 저장을 동시에 실행한다.

확장함수로 사용할 수 있다.

```kotlin
val result = service.run {
    port = 8080
    query()
}
```

**java 비교**

```java
service.port = 8080;
Result result = service.query();
```

**Data Class**

생성자, getter, setter 를 한꺼번에 정의한다.

val 는 상수이므로 선언 시 setter 는 생성되지 않는다.

var 는 변수이므로 선언 시 setter 가 생성된다.

```kotlin
data class JavaObject(val s: String)
```

**java 비교**

```java
public class JavaObject {
    private String s;
    
    JavaObject(String s) {
        this.s = s;
    }
    
    public String getS() {
        return s;
    }
    
    public void setS(String s) {
        this.s = s;
    }
}
```

**Lambda expression**

```kotlin
button.setOnClickListener { v ->
                           
}
```

**java 비교**

```java
button.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        
    }
});
```

**late init, lazy init**

`lateinit` 후에 초기화 할 것이기 때문에 물음표 (?) 를 생략하고 사용한다.

```kotlin
var nullableNumber: Int? = null
lateinit var lateinitNumber: Int

lateinitNumber = 10

nullableNumber?.add()
lateinitNumber.add()
```

`lazyinit` 사용하는 순간에 변수에 값이 저장된다.

```kotlin
val lazyNumber :Int by lazy {
    100
}

lazyNumber.add()
```

코틀린 메뉴얼 사이트: <https://kotlinlang.org/>{:target="_blank"}

# 3-5. 틴더 앱

1. 파이어베이스 로그인
2. 파이어베이스 데이터베이스

# 4-1. 유튜브 앱

1. 모션 레이아웃
2. ExoPlayer 
3. Youtube

ExoPlayer: 구글에서 만든 라이브러리. 내장되어 있지 않고 오픈소스이다.

메뉴얼: <https://exoplayer.dev/>{:target="_blank"}

# 5-1 Todo 앱

1. MVP, MVVM, 구글아키텍쳐
2. DI 소개, Koin 사용
3. 시나리오 기반 TDD 코드 작성
4. ToDo 리스트, 상세화면 구현

# 5-4 SNS 앱

중고거래 앱의 개선

1. 파이어베이스 스토리지
2. 중고거래 앱 UI 수정
3. 카메라 기능 연결
4. 복수의 이미지 업로드 구현
5. 갤러리 기능 구현

