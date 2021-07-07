---
title: VI. Sorting&Searching 강의
category: algorithm
---

## 1. 선택정렬

가장 작은 수를 찾아 앞에서부터 정렬한다.

비교정렬이자 제자리정렬

시간복잡도는 $$O(N^2)$$ 이다.

**입력**

```
6
13 5 11 7 23 15
```

**출력**

```
13과 5을 바꿉니다.
[5, 13, 11, 7, 23, 15]
13과 7을 바꿉니다.
[5, 7, 11, 13, 23, 15]
11과 11을 바꿉니다.
[5, 7, 11, 13, 23, 15]
13과 13을 바꿉니다.
[5, 7, 11, 13, 23, 15]
23과 15을 바꿉니다.
[5, 7, 11, 13, 15, 23]
```

**swap 메서드사용 코드** 

```java
import java.util.Arrays;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] arr = new int[n];

		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}

		for (int i = 0; i < n - 1; i++) {
			int index = i;
			for (int j = i + 1; j < n; j++) {
				if (arr[index] > arr[j]) {
					index = j;
				}
			}
			swap(arr, i, index);
		}
		System.out.println(Arrays.toString(arr));
	}

	static void swap(int[] arr, int i, int j) {
		int temp = arr[i];
		arr[i] = arr[j];
		arr[j] = temp;
	}
}
```

**메소드없는 코드**

```java
import java.util.Arrays;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] arr = new int[n];

		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}

		for (int i = 0; i < n - 1; i++) {
			int index = i;
			for (int j = i + 1; j < n; j++) {
				if (arr[index] > arr[j]) {
					index = j;
				}
			}
			int temp = arr[i];
			arr[i] = arr[index];
			arr[index] = temp;
		}
		System.out.println(Arrays.toString(arr));
	}
}
```

**설명포함 코드**

```java
import java.util.Arrays;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] arr = new int[n];

		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}

		for (int i = 0; i < n - 1; i++) {
			int index = i;
			for (int j = i + 1; j < n; j++) {
				if (arr[index] > arr[j]) {
					index = j;
				}
			}
			int temp = arr[i];
			arr[i] = arr[index];
			arr[index] = temp;
			System.out.println(temp + "과 " + arr[i] + "을 바꿉니다.");
			System.out.println(Arrays.toString(arr));
		}
	}
}
```

## 2. 버블정렬

이웃한 것 끼리 비교하여 정렬



