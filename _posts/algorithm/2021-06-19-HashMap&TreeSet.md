---
title: IV. HashMap&TreeSet 강의
category: algorithm
---

## 학급 회장

- 문자열의 HashMap 초기값 설정 및 카운팅

```java
for (char key : str.toCharArray()) {
    int value = map.getOrDefault(key, 0);
	map.put(key, value + 1);
}
    
```
- 숫자의 HashMap 초기값 설정 및 카운팅

```java
for (int i = 0; i < n; i++) {
	int key = sc.nextInt();
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

        // 문자열을 HashMap 으로
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

```java
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int k = sc.nextInt();
		int[] arr = new int[n];
		String answer = "";

        // 숫자들을 배열에
		for (int i = 0; i < arr.length; i++) {
			arr[i] = sc.nextInt();
		}

		for (int i = 0; i < n - k + 1; i++) {
			HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
			for (int j = 0; j < k; j++) {
                 // 숫자들의 배열을 HashMap 으로
				int value = map.getOrDefault(arr[i + j], 0);
				map.put(arr[i + j], value + 1);
			}
			answer += map.size() + " ";
		}
		System.out.println(answer);
	}
}
```

## 모든 아나그램 찾기

```java
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.nextLine();
		String t = sc.nextLine();
		int count = 0;
		char[] arr = s.toCharArray();
		HashMap<Character, Integer> map2 = new HashMap<Character, Integer>();
		
		for (char key : t.toCharArray()) {
			int value = map2.getOrDefault(key, 0);
			map2.put(key, value + 1);
		}
		
		for (int i = 0; i < s.length() - t.length() + 1; i++) {
			HashMap<Character, Integer> map = new HashMap<Character, Integer>();
			for (int j = 0; j < t.length(); j++) {
				int value = map.getOrDefault(arr[i + j], 0);
				map.put(arr[i + j], value + 1);
				if (map.equals(map2)) {
					count++;
				}
			}
		}
		
		System.out.println(count);
	}
}
```

### Sliding window algorithm

```java
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.nextLine();
		String t = sc.nextLine();
		int count = 0;
		HashMap<Character, Integer> map2 = new HashMap<Character, Integer>();
		HashMap<Character, Integer> map1 = new HashMap<Character, Integer>();

		// 두 번째 문자열 HashMap 에 담기
		for (char key : t.toCharArray()) {
			int value = map2.getOrDefault(key, 0);
			map2.put(key, value + 1);
		}

		// 첫 번째 문자열의 일부분 HashMap 에 담기
		for (int i = 0; i < t.length(); i++) {
			int value = map1.getOrDefault(s.charAt(i), 0);
			map1.put(s.charAt(i), value + 1);
		}

        // 중복되는 코드
		if (map1.equals(map2)) {
			count++;
		}

		// Sliding window algorithm 을 이용해 HashMap 에 한 개씩 추가하고 제거하기
		for (int i = 0; i < s.length() - t.length(); i++) {
			int left = i;
			int right = i + t.length();
			int valueRight = map1.getOrDefault(s.charAt(right), 0);
			map1.put(s.charAt(right), valueRight + 1);
			int valueLeft = map1.get(s.charAt(left));
			map1.put(s.charAt(left), valueLeft - 1);
			if (map1.get(s.charAt(left)) == 0) {
				map1.remove(s.charAt(left));
			}

			// 문자열1과 문자열2가 아나그램이라면 count 를 1 증가시킨다.
			if (map1.equals(map2)) {
				count++;
			}
		}

		System.out.println(count);
	}
}
```

### Sliding window algorithm 개선

- 위 코드는 `count++` 가 중복되므로 문자열을 한 개 덜 담으므로써 중복코드를 없앱니다.

```java
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String s = sc.nextLine();
		String t = sc.nextLine();
		int count = 0;
		HashMap<Character, Integer> map1 = new HashMap<Character, Integer>();
		HashMap<Character, Integer> map2 = new HashMap<Character, Integer>();

		// 두 번째 문자열 HashMap 에 담기
		for (char key : t.toCharArray()) {
			int value = map2.getOrDefault(key, 0);
			map2.put(key, value + 1);
		}

		// 첫 번째 문자열의 일부분 HashMap 에 담기 : 문자열을 한 개 덜 담습니다.
		for (int i = 0; i < t.length() - 1; i++) {
			int value = map1.getOrDefault(s.charAt(i), 0);
			map1.put(s.charAt(i), value + 1);
		}

		// Sliding window algorithm 을 이용해 HashMap 에 한 개씩 추가
		for (int i = 0; i < s.length() - t.length() + 1; i++) {
			int left = i;
			int right = i + t.length() - 1;
			int valueRight = map1.getOrDefault(s.charAt(right), 0);
			map1.put(s.charAt(right), valueRight + 1);

			// 문자열1과 문자열2가 아나그램이라면 count 를 1 증가시킨다.
			if (map1.equals(map2)) {
				count++;
			}
            
			// 한 개씩 제거
			int valueLeft = map1.get(s.charAt(left));
			map1.put(s.charAt(left), valueLeft - 1);
			if (map1.get(s.charAt(left)) == 0) {
				map1.remove(s.charAt(left));
			}
		}

		System.out.println(count);
	}
}
```

## k번째 큰 수

date: 06.20

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int N = sc.nextInt();
		int K = sc.nextInt();
		int[] arr = new int[N];
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		ArrayList<Integer> arrList = new ArrayList<Integer>();
		
		for (int i = 0; i < arr.length; i++) {
			arr[i] = sc.nextInt();
		}
		
        // 세 수의 합을 HashMap 에 저장
		for (int i = 0; i < arr.length; i++) {
			for (int j = i + 1; j < arr.length; j++) {
				for (int k = j + 1; k < arr.length; k++) {
					int key = arr[i] + arr[j] + arr[k];
					int value = map.getOrDefault(key, 0);
					map.put(key, value + 1);
				}
			}
		}
		
        // 정렬하기 위해 arrayList 에 저장
		for (int key : map.keySet()) {
			arrList.add(key);
		}
		
        // 정렬 후 세 번째로 큰 수 출력
		arrList.sort(null);
		System.out.println(arrList.get(arrList.size() - 3));
	}
}
```

### TreeSet 

중복도 제거하며 정렬도 된다.

`TreeSet<Integer> tree = new TreeSet<Integer>(Collections.reverseOrder())` 기본은 오름차순, reverseOrder 시 내림차순

`tree`

- `add(value)`
- `remove(value)` 
- `first()`
- `last()`

### TreeSet 으로 풀기

```java
import java.util.Collections;
import java.util.Scanner;
import java.util.TreeSet;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int N = sc.nextInt();
		int K = sc.nextInt();
		int[] arr = new int[N];
		TreeSet<Integer> tree = new TreeSet<Integer>(Collections.reverseOrder());

        // 숫자 입력받아 배열에 저장
		for (int i = 0; i < arr.length; i++) {
			arr[i] = sc.nextInt();
		}

        // 세 수의 합을 TreeSet 에 저장
		for (int i = 0; i < arr.length; i++) {
			for (int j = i + 1; j < arr.length; j++) {
				for (int k = j + 1; k < arr.length; k++) {
					int key = arr[i] + arr[j] + arr[k];
					tree.add(key);
				}
			}
		}

        // 세 번째로 큰 수 출력
		int num = 0;
		for (Integer key : tree) {
			num++;
			if (num == 3) {
				System.out.println(key);
                  break;
			}
		}
	}
}
```

