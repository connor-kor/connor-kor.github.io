---
title: 문자열 알고리즘
---

## `String`

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

## 단어 뒤집기 : 내가 구현한 코드

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

## 단어 뒤집기 : 인프런

`String tmp = new StringBuilder(x)` Stiring 의 객체이다.

`StringBuilder(String)`

- `.reverse()`
- `.toString()` 

`ArrayList`

- `add(Object)` 뒤집은 char 를 한개씩 추가한다.

1. 단어를 Array 화 한 후 앞뒤를 변수선언, 앞뒤를 서로 바꾸기.
