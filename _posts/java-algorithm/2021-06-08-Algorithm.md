---
title: 알고리즘 정리
---

# 출력

---

`"이것을 프린트합니다.\n"` 혹은 `(n + "입니다.\n")`

- `.repeat(n)` 따옴표나 괄호를 반복

`"역슬래쉬 출력 \\"` 출력 : 역슬래쉬 출력 \

## Scanner

`s`

- `.next()` 문자열 입력

- `.charAt(index)` 인덱스 반환

## Buffered

```java
public static void main(String[] args) throws IOException {
	BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
	BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(System.out));
	int n = Integer.parseInt(br.readLine());
	String str = br.readLine();
		
	bw.write(n + "\n");
	bw.write(str);
	bw.flush();
}
```

장점 : 빠르다.

단점

1. IOException 을 throws 해야한다.
2. 숫자형은 변환해야 한다 : String 으로만 입력되기 때문
3. write 후에 flush 를 해야 출력된다.
4. 공백을 입력받지 못한다.

## 공백

StringTokenizer

# String

---

`str`

- `.toUpperCase()` 대문자 변환

- `.toLowerCase()` 소문자 변환

- `.toCharArray()` 문자열을 배열에 넣음 : for-each 구문을 위해

```java
for (char c : str.toCharArray()) {
			System.out.print(c);
		}
```

# Character

---

`Character`

- `.toUpperCase(char)` 대문자 변환

- `.isLowerCase(char)` 소문자이면 true 반환

# 숫자

---

`/` 왼쪽 값 출력 : 0 의 갯수만큼 오른쪽 값 제거

`%` 오른쪽 값 출력 : 0 의 갯수만큼 오른쪽 값 출력

- 값의 왼쪽과 오른쪽 값 세 개씩 출력하는 코드

```java
int n = 123456789;
System.out.println(n / 1000000);  // 123
System.out.println(n % 1000);	 // 789
```

## Integer

`Integer`

- `parseInt(String)` 정수형으로 변환

# if

---

- Main

```java
public class Main {
	public static void main(String[] args) {
        boolean bool = true;
		String str = Class.doReturn(bool);
		System.out.println(str);
	}
}
```

- 비 효율적인 코드

```java
public class Class {
	static String doReturn(boolean bool) {
		if (bool) {
			return "YES";
		} else {
			return "NO";
		}
	}
}
```


- 효율적인 코드

```java
public class Class {
	static String doReturn(boolean bool) {
		return bool? "YES" : "NO";
	}
}
```

