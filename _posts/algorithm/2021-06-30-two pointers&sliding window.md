---
title: III. two pointers & sliding window 강의
category: algorithm
---

이 문서에서는 two pointers 알고리즘과 sliding window 알고리즘을 사용하여 O($$n^2$$) 의 복잡도를 O(n) 으로 만듭니다.

for 문 안에 while 문과 if 문이 들어간 것이 이상적입니다. (4~6번 알고리즘)

```java
for(){
    while(){
    }
    if(){
    }
}
```

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

**정렬** 

배열에 담아 `Arrays.sort(arr)` 해도되고

저처럼 ArrayList 에 담아 `arr.sort(null)` 해도 됩니다.

```java
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		ArrayList<Integer> arr1 = new ArrayList<Integer>();
		ArrayList<Integer> arr2 = new ArrayList<Integer>();
		
		int n = sc.nextInt();
		for (int i = 0; i < n; i++) {
			arr1.add(sc.nextInt());
		}
		
		int m = sc.nextInt();
		for (int i = 0; i < m; i++) {
			arr2.add(sc.nextInt());
		}

		// 정렬
		arr1.sort(null);
		arr2.sort(null);
		
		while ((arr1.size() > 0) & arr2.size() > 0) {
			
			// 첫 번째 배열이 작을경우 배열의 첫 번째 수 제거
			if (arr1.get(0) < arr2.get(0)) {
				arr1.remove(0);
				
			// 두 번재 배열이 작을경우 배열의 첫 번째 수 제거
			} else if (arr1.get(0) > arr2.get(0)) {
				arr2.remove(0);
				
			// 두 배열의 첫 번째 수가 같을경우 출력하고 제거
			} else {
				System.out.print(arr1.get(0) + " ");
				arr1.remove(0);
				arr2.remove(0);
			}
		}
	}
}
```

## 3. 최대 매출

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int k = sc.nextInt();
		int[] arr = new int[n];
		int sum = 0;
		int max = 0;
		
		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}
		
		for (int i = 0; i < k - 1; i++) {
			sum += arr[i];
		}
		
		for (int left = 0; left <= n - k; left++) {
			int right = k - 1 + left;
			sum += arr[right];
			if (max < sum) {
				max = sum;
			}
			sum -= arr[left];
		}
		System.out.println(max);
	}
}
```

## 4. 연속 부분수열

N개의 수열 에서 연속부분수열의 합이 M 이 되는 경우의 수

**입력**

```
8 6
1 2 1 3 1 1 1 2
```

**출력**

```
+1+2+1+3-1
1가지
+1-2+1
2가지
+1-1
3가지
+2-3
```

**입력**

```
8 6
1 1 1 1 1 5 3 2
```

**출력**

```
+1+1+1+1+1+5-1-1-1-1
1가지
+3-1-5+2
```

**설명없는 코드** 

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int m = sc.nextInt();
		int[] arr = new int[n];
		int sum = 0;
		int tail = 0;
		int count = 0;
		
		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}
		
		for (int head = 0; head < n; head++) {
			sum += arr[head];
			while (sum > m) {
				sum -= arr[tail++];
			}
			if (sum == m) {
				count++;
			}
		}
		System.out.println(count);
	}
}
```

**설명출력 코드**

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int m = sc.nextInt();
		int[] arr = new int[n];
		int sum = 0;
		int tail = 0;
		int count = 0;
		
		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}
		
		for (int head = 0; head < n; head++) {
			sum += arr[head];
			System.out.print("+" + arr[head]);
			while (sum > m) {
				System.out.print("-" + arr[tail]);
				sum -= arr[tail++];
			}
			if (sum == m) {
				count++;
				System.out.println("\n" + count + "가지");
			}
		}
	}
}
```

## 5. 연속된 자연수의 합

2개 이상의 연속된 자연수의 합으로 정수 N 을 표현하는 방법의 가짓수를 출력

- 7+8=15
- 4+5+6=15
- 1+2+3+4+5=15

답은 3가지이다.

**입력**

```
15
```

**출력**

```
+1+2+3+4+5
1가지
+6-1-2-3
2가지
+7-4-5+8-6
3가지
```

**설명없는 코드**

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int count = 0;
		int sum = 0;
		int tail = 1;

		for (int head = 1; head <= (n / 2) + 1; head++) {
			sum += head;
			while (sum > n) {
				sum -= tail++;
			}
			if (sum == n) {
				count++;
			}
		}
		System.out.println(count);
	}
}
```

**설명출력 코드** 

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int count = 0;
		int sum = 0;
		int tail = 1;

		for (int head = 1; head <= (n / 2) + 1; head++) {
			System.out.print("+" + head);
			sum += head;
			while (sum > n) {
				System.out.print("-" + tail);
				sum -= tail++;
			}
			if (sum == n) {
				count++;
				System.out.println();
				System.out.println(count + "가지");
			}
		}
	}
}
```

## 6. 최대 길이 연속부분수열

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int k = sc.nextInt();
		int[] arr = new int[n];
		int max = 0;
		int length = 0;
		int count = 0;
		int tail = 0;

		for (int i = 0; i < n; i++) {
			arr[i] = sc.nextInt();
		}
		
		for (int head = 0; head < n; head++) {
			if (arr[head] == 0) {
				count++;
			}
			while (count > k) {
				if (arr[tail] == 0) {
					count--;
				}
				tail++;
			}
			length = head - tail + 1; 
			if (max < length) {
				max = length;
			}
		}
		System.out.println(max);
	}
}
```

