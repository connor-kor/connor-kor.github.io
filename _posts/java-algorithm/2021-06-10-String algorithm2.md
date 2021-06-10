---
title: 문자열 알고리즘2 - 알파벳만 단어 뒤집기
---

### 문자열을 문자들의 배열로

---

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

