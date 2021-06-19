---
title: 문자열 강의
category: algorithm
---

# String

## 문자 카운트

date: 06.03

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

### 대소문자 변환

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

### `String`

- `.split(' ')` 공백구분

```java
String[] arr = str.split(" ");
```

- `.length` 길이반환
- `.indexOf(' ')` 찾으면 그 값 반환. 없으면 -1 반환 : 있는지 없는지만  확인하고 몇 개 있는지는 확인할 수 없다.
- `.substring(startIndex, endIndex)` start 부터 end 까지 슬라이스 : 글자 수는 end - start
- `.substring(index)` index 부터 끝까지 슬라이스
- `new String[n]` 크기가 n 인 리스트를 만든다. n = arr.length
- `.charAt(index)` index 에 음수가 올 수 없다.

> array.length 는 괄호가 없지만 String.length() 는 괄호가 있다.



## 줄에서 가장 긴 단어 출력

date: 06.08

```java
public class Main {
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		int max = 0;
		String answer = "";
		String str = s.nextLine();
		String[] arr = str.split(" ");

		for (String string : arr) {
			if (max < string.length()) {
				max = string.length();
				answer = string;
			}
		}
		System.out.println(answer);
	}
}
```

### 단어 뒤집기 : 내가 구현한 코드

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		// 몇개의 단어를 뒤집을까요?
		int n = sc.nextInt();
		String[] revArr = new String[n];

		// 단어 n 개 만큼 반복
		for (int i = 0; i < n; i++) {
			String str = sc.next();
			int len = str.length();
			String reverse = "";

			// 단어를 뒤집습니다.
			for (int j = 0; j < len; j++) {
				reverse += str.charAt(len - j - 1);
			}
            
			// 뒤집은 단어를 array 에 넣어 보관합니다.
			revArr[i] = reverse;
		}
		
		// 뒤집은 단어를 출력합니다.
		for (String string : revArr) {
			System.out.println(string);
		}
	}
}
```

### 단어 뒤집기 : 인프런

`String tmp = new StringBuilder(x)` Stiring 의 객체이다.

`StringBuilder(String)`

- `.reverse()`
- `.toString()` 

`ArrayList`

- `add(Object)` 뒤집은 char 를 한개씩 추가한다.

1. 단어를 Array 화 한 후 앞뒤를 변수선언, 앞뒤를 서로 바꾸기.

## 문자열을 문자들의 배열로

date: 06.10


- 비 효율적인 코드

```java
int len = str.length();
char[] arr = new char[len];
		
for (int i = 0; i < len; i++) {
	arr[i] = str.charAt(i);
}
		
```

- 효율적인 코드

```java
char[] arr = str.toCharArray();
```

### 문자들의 배열을 문자열로

---

```java
String str = String.valueOf(arr);
System.out.println(str);
```

### 알파벳만 단어 뒤집기

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String scan = sc.next();
		char[] arr = scan.toCharArray();
		int left = 0;
		int right = scan.length() - 1;

		while (left < right) {
			if (Character.isAlphabetic(arr[left]) & Character.isAlphabetic(arr[right])) {
				char temp = arr[left];
				arr[left] = arr[right];
				arr[right] = temp;
			}
			left++;
			right--;
		}
		
		String str = String.valueOf(arr);
		System.out.print(str);
	}
}
```

