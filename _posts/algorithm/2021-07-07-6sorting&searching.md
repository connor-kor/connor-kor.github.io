---
title: VI. Sorting&Searching 강의
category: algorithm
---

# 정렬

정렬상태와 알고리즘에 따른 속도

<https://www.toptal.com/developers/sorting-algorithms>

## 1. 선택정렬

![image-20210707204811224](../../assets/images/image-20210707204811224.png)

가장 작은 수를 찾아 앞에서부터 정렬한다.

비교정렬이자 제자리정렬

시간복잡도는 $$O(N^2)$$ 이다.

항상 비슷한 시간이 걸린다.

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

![img](../../assets/images/img.png)


이웃한 것 끼리 비교하여 정렬

이미 거의 정렬된 상태에서 빠르다.

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
		
		for (int i = 1; i < n; i++) {
			for (int j = 0; j < n - i; j++) {
				if (arr[j] > arr[j + 1]) {
					int temp = arr[j];
					arr[j] = arr[j + 1];
					arr[j + 1] = temp;
				}
			}
		}
		System.out.println(Arrays.toString(arr));
	}
}
```

## 3. 삽입정렬

  ![그림입니다.  원본 그림의 이름: CLP000050e05703.bmp  원본 그림의 크기: 가로 1280pixel, 세로 1718pixel](../../assets/images/EMB000050e05704.bmp)  

이미 거의 정렬된 상태에서 빠르다.

i 는 1부터 증가, j 는 감소하며 i 값을 끼워넣는다.

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

		for (int i = 1; i < n; i++) {
			int target = arr[i];
			int j = i - 1;
			while (j >= 0 && target < arr[j]) {
				arr[j + 1] = arr[j];
				j--;
			}
			arr[j + 1] = target;
		}
		System.out.println(Arrays.toString(arr));
	}
}
```

| 정렬     | 초기값 | 최종값 | 초기값 | 최종값      |
| -------- | ------ | ------ | ------ | ----------- |
| 선택정렬 | 0      | n-1    | i+1    | n           |
| 버블정렬 | 1      | n      | 0      | n-i         |
| 삽입정렬 | 1      | n      | i-1    | 0 보다 크다 |

## 4. LRU (캐시, 카카오 변형)

