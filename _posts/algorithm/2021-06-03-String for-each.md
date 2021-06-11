---
title: 문자열 for-each 및 대소문자 변환
categories: algorithm
---

## 문자 카운트

`s` 스캐너

`.next()` 문자열 반환

`.charAt(index)` 문자 반환

```
str
.toUpperCase()
.toLowerCase()
```

`.toCharArray()` 문자열을 배열화 해서 for-each 구문을 쓸 수 있다.

```
Character
.toUpperCase(char)
```

- 문자열 for-each 사용법

```java
for (char c : str.toCharArray()) {
			System.out.print(c);
		}
```

- 문자 카운트 예시

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		char x = sc.next().charAt(0);
		int count = 0;

		for (char c : str.toLowerCase().toCharArray()) {
			if (Character.toLowerCase(x) == c) {
				count++;
			}
		}
		System.out.println(count);
	}
}
```

## 대소문자 변환

```
Character
isLowerCase(char)
```

- 예시

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		String conversion = "";

		for (char c : str.toCharArray()) {
			if (Character.isLowerCase(c)) {
				conversion += Character.toUpperCase(c);
			} else {
				conversion += Character.toLowerCase(c);
			}
		}
		System.out.println(conversion);		
	}
}
```

아스키번호

대문자 : 65~90

소문자 : 97~122

대문자 = 소문자 - 32