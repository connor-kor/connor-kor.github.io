---
title: 3) two pointers & sliding window 강의
category: algorithm
---

이 문서에서는 two pointers algorithm 과 sliding window 를 사용하여 O($$n^2$$) 의 복잡도를 O(n) 으로 만듭니다.

## 1. 두 배열 합치기

크기가 n 인 배열과 크기가 m 인 배열을 오름차순으로 정렬된 하나의 배열로 합치시오.

**입력**

```
3
1 3 5
5
2 3 6 7 9
```

**출력**

```
1 2 3 3 5 6 7 9
```
두 가지 방법을 모두 해봤지만 코드의 길이도 비슷해 어떤 것을 해도 무방할 것처럼 보인다.

### for 문과 String 에 담아 출력

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] arr1 = new int[n];
		int index1 = 0;
		int index2 = 0;
		
		// 첫 번째 배열 입력
		for (int i = 0; i < n; i++) {
			arr1[i] = sc.nextInt();
		}
		
		int m = sc.nextInt();
		int[] arr2 = new int[m];
		
		// 두 번째 배열 입력
		for (int i = 0; i < m; i++) {
			arr2[i] = sc.nextInt();
		}
		
		for (int i = 0; i < n + m; i++) {
			
			// 첫 번째 배열이 더 이상 없을 때
			if (index1 == n) {
				while (index2 < m) {
					System.out.print(arr2[index2] + " ");
					index2++;
				}
				break;
			}
			
			// 두 번째 배열이 더 이상 없을 때
			if (index2 == m) {
				while (index1 < n) {
					System.out.print(arr1[index1] + " ");
					index1++;
				}
				break;
			}
			
			// 배열의 앞에서 작은 값을 반환합니다.
			if (arr1[index1] < arr2[index2]) {
				System.out.print(arr1[index1] + " ");
				index1++;
			} else {
				System.out.print(arr2[index2] + " ");
				index2++;
			}
		}
	}
}
```

### while 문과 배열에 담아 출력

```java
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] arr1 = new int[n];
		int index1 = 0;
		int index2 = 0;
		ArrayList<Integer> numbers = new ArrayList<Integer>();

		// 첫 번째 배열 입력
		for (int i = 0; i < n; i++) {
			arr1[i] = sc.nextInt();
		}

		int m = sc.nextInt();
		int[] arr2 = new int[m];

		// 두 번째 배열 입력
		for (int i = 0; i < m; i++) {
			arr2[i] = sc.nextInt();
		}

		while ((n > index1) & (m > index2)) {

			// 배열의 앞에서 작은 값을 반환합니다.
			if (arr1[index1] < arr2[index2]) {
				numbers.add(arr1[index1++]);
			} else {
				numbers.add(arr2[index2++]);
			}
		}

		// 첫 번째 배열이 더 이상 없을 때
		if (index1 == n) {
			while (index2 < m) {
				numbers.add(arr2[index2++]);
			}
			
		// 두 번째 배열이 더 이상 없을 때
		} else {
			while (index1 < n) {
				numbers.add(arr1[index1++]);
			}
		}
		
		for (int i : numbers) {
			System.out.print(i + " ");
		}
	}
}
```

## 2. 공통원소 구하기

