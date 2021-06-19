---
category: algorithm
---

## 학급 회장

- HashMap 의 초기값 설정 및 카운팅 방법

```java
for (char key : str.toCharArray()) {
    int value = map.getOrDefault(key, 0);
	map.put(key, value + 1);
}
    
```

```java
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		String vote = sc.next();
		char answer = ' ';
		int max = 0;
		
		// 학급회장 투표
		HashMap<Character, Integer> map = new HashMap<Character, Integer>();
		for (char key : vote.toCharArray()) {
			int value = map.getOrDefault(key, 0);
			map.put(key, value + 1);
		}
		
		// 학급회장 개표
		for (char key : map.keySet()) {
			System.out.println(key + " " + map.get(key));
			if (max < map.get(key)) {
				max = map.get(key);
				answer = key;
			}
		}
		System.out.println(answer);
	}
}
```

> HashMap 에 입력하는 것은 toCharArray(), 출력하는 것은 KeySet()

`map`

- `.put(key, value)`
- `.get(key)`
- `.getOrDefault(key, Integer defaultValue)` : 값이 없으면 defaultValue 값을 가져옵니다.
- `.keySet()` key 값을 모두 불러옵니다. : for-each 구문 사용
- `.containsKey(Key)` boolean : Key 가 있나요?
- `.size()` Key 갯수
- `.remove(Key)` 

## 아나그램 : Anagram

```java
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str1 = sc.nextLine();
		String str2 = sc.nextLine();

		HashMap<Character, Integer> map1 = new HashMap<Character, Integer>();
		HashMap<Character, Integer> map2 = new HashMap<Character, Integer>();

		for (char key : str1.toCharArray()) {
			int value = map1.getOrDefault(key, 0);
			map1.put(key, value + 1);
		}

		for (char key : str2.toCharArray()) {
			int value = map2.getOrDefault(key, 0);
			map2.put(key, value + 1);
		}

		if (map1.equals(map2)) {
			System.out.println("YES");
		} else {
			System.out.println("NO");
		}
	}
}
```

## 매출액의 종류

