---
title: 문자열 강의
category: algorithm
---

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

## 알파벳만 단어 뒤집기

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

## 중복문자제거

date: 06.20

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		String answer = "";

		for (int index = 0; index < str.length(); index++) {
			char c = str.charAt(index);
            
             // 처음나오는 문자만 answer 에 추가한다.
			if (str.indexOf(c) == index) {
				answer += c;
			}
		}

		System.out.println(answer);
	}
}
```

입력 : ksekkset

출력 : kset

Q. 어떻게 중복되는 문자가 제거됐을까?

A. `indexOf(char)` 에 답이 있다. indexOf 는 문자가 나오는 첫 번째 인덱스 값을 반환하기 때문에 변수 index 와 같아졌을때만 answer 에 문자를 더하기 때문에 그렇다.

## 회문문자열 : palindrome

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		int back = str.length() - 1;
		String answer = "YES";
		
		// 대문자 변환
		str = str.toUpperCase();
		
        // 하나라도 다르면 NO 를 반환합니다.
		for (int front = 0; front < str.length() / 2; front++) {
			if (str.charAt(front) != str.charAt(back)) {
				answer = "NO";
				break;
			} 
			back--;
		}
		
		System.out.println(answer);
	}
}
```

### StringBuilder 사용

`String reverse = new StringBuilder(str).reverse().toString()` 

`builder` 

- `.equalsIgnoreCase(String)` 

## 유효한 팰린드롬

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String input = sc.nextLine();
		String str = "";
		String answer = "YES";

        // 알파벳만 반환
		for (char c : input.toCharArray()) {
			if (Character.isAlphabetic(c)) {
				str += c;
			}
		}

        // 대문자 변환
		str = str.toUpperCase();

		for (int front = 0; front < str.length() / 2; front++) {
			int back = str.length() - 1 - front;
			if (str.charAt(front) != str.charAt(back)) {
				answer = "NO";
				break;
			}
		}

		System.out.println(answer);
	}
}
```

## 숫자만 추출

- 직접 작성한 코드

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String input = sc.next();
		String str = "";

		for (char c : input.toCharArray()) {
			if (Character.isDigit(c)) {
				str += c;
			}
		}

		// 첫 번째 수가 0이면 제거
		while (str.charAt(0) == '0') {
			str = str.substring(1);
		}

		System.out.println(str);
	}
}
```

- 인프런 강의

숫자 0~9 는 아스키코드로 48~57

조건이 48~57 일 때

answer = answer * 10 + (x - 48)

- 이상적인 코드

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String input = sc.next();
		String str = "";
		int number;
		
		for (char c : input.toCharArray()) {
			if (Character.isDigit(c)) {
				str += c;
			}
		}

        // 앞에 0 을 없애줍니다.
		number = Integer.parseInt(str);

		System.out.println(number);
	}
}
```

- 아스키코드 활용

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String input = sc.next();
		int number = 0;

		for (char c : input.toCharArray()) {
			if (c >= 48 & c <= 57) {
				number = (number*10) + (c-48);
			}
		}

		System.out.println(number);
	}
}
```

## 가장 짧은 문자거리

`Math`

- `.min()` 

```java
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.next();
		char t = sc.next().charAt(0);
		ArrayList<Integer> arr = new ArrayList<Integer>();
		int order = 0;
		int distance = 0;
		int first;
		int second;

		// t 의 인덱스 값을 arr 에 저장
		for (int i = 0; i < s.length(); i++) {
			if (s.charAt(i) == t) {
				arr.add(i); // 1, 5, 10
			}
		}

		// 첫 번째 인덱스까지
		for (int i = 0; i < arr.get(0) + 1; i++) {
			distance = arr.get(order) - i;
			System.out.print(distance + " ");
		}

		// 두 인덱스 사이
		while (arr.size() - 1 > order) {
			first = arr.get(order);
			second = arr.get(order + 1);

			for (int i = 0; i < (second - first) / 2; i++) {
				distance++;
				System.out.print(distance + " ");

			}

			for (int i = 0; i < (second - first) / 2; i++) {
				distance = second - i;
				System.out.print(distance + " ");
			}

			System.out.println("\nfirst: " + first + ", second: " + second);
			order++;
		}

	}
}
```

### 문자열이 무한대

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.next();
		char t = sc.next().charAt(0);
		int len = s.length();
		int[] disArr = new int[len];
		int distance = -1;

		for (int i = 0; i < len; i++) {
			if (s.charAt(i) == t) {
				distance = 0;
				disArr[i] = distance;
			} else if (distance != -1) {
				distance++;
				disArr[i] = distance;

				// 정의되지 않은 곳에 -1 저장
			} else {
				disArr[i] = distance;
			}
		}

		for (int i = len - 1; i >= 0; i--) {
			if (s.charAt(i) == t) {
				distance = 0;
			} else {
				distance++;
			}
			if (disArr[i] == -1) {
				disArr[i] = distance;
			}
			if (disArr[i] > distance) {
				disArr[i] = distance;
			}
		}

		for (int i : disArr) {
			System.out.print(i + " ");
		}
	}
}
```

### 문자열의 길이가 100 미만

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.next();
		char t = sc.next().charAt(0);
		int len = s.length();
		int[] disArr = new int[len];
		int distance = 1000;

		for (int i = 0; i < len; i++) {
			if (s.charAt(i) == t) {
				distance = 0;
				disArr[i] = distance;
			} else {
				distance++;
				disArr[i] = distance;
			}
		}

		for (int i = len - 1; i >= 0; i--) {
			if (s.charAt(i) == t) {
				distance = 0;
			} else if (disArr[i] > distance) {
				distance++;
				disArr[i] = distance;
			}
		}

		for (int i : disArr) {
			System.out.print(i + " ");
		}
	}
}
```

## 문자열 압축

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		int count = 1;

		for (int i = 0; i < str.length(); i++) {
			if (i < str.length() - 1) {
				boolean compress = (str.charAt(i) == str.charAt(i + 1));

				if (!compress) {
					System.out.print(str.charAt(i));
					if (count != 1) {
						System.out.print(count);
					}

					// 출력 후 count 초기화
					count = 1;
				} else {
					count++;
				}
                
			  // 마지막 문자 비교 : 빈 문자를 추가하면 필요없는 코드이다.
			} else {
				System.out.print(str.charAt(i));
				if (count != 1) {
					System.out.print(count);
				}
			}
		}
	}
}
```

### 이상적인 코드

- 마지막문자를 비교할 필요없이 간단히 빈 문자 " " 를 추가합니다.

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		str += " ";
		int count = 1;

		for (int i = 0; i < str.length(); i++) {
			if (i < str.length() - 1) {
				boolean compress = (str.charAt(i) == str.charAt(i + 1));

				if (!compress) {
					System.out.print(str.charAt(i));
					if (count != 1) {
						System.out.print(count);
					}

					// 출력 후 count 초기화
					count = 1;
				} else {
					count++;
				}
			} 
		}
		
	}
}
```







