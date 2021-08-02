---
title: 패스트캠퍼스
category: android
---

# 1. 코틀린

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

