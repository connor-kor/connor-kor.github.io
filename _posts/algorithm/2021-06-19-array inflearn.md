---
title: 2. 배열 강의
category: algorithm
---

## 1. 보이는 학생

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] arr = new int[n];
		int max;
		int count = 0;
		
		// 학생들의 키 배열에 넣기
		for (int i = 0; i < arr.length; i++) {
			arr[i] = sc.nextInt();
		}
		
        // 초기값 설정
		max = arr[0];
		count++;
		
		// 뒤 학생이 가장 큰 학생보다 크면 카운트
		for (int i = 1; i < arr.length; i++) {
			if (max < arr[i]) {
				max = arr[i];
				count++;
			}
		}		
		System.out.println(count);
	}
}
```

## 2. 가위바위보

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] a = new int[n];
		int[] b = new int[n];
		
        // A 가위바위보 정보
		for (int i = 0; i < a.length; i++) {
			a[i] = sc.nextInt();
		}
		
        // B 가위바위보 정보
		for (int i = 0; i < b.length; i++) {
			b[i] = sc.nextInt();
		}
		
		for (int i = 0; i < n; i++) {
            
             // A 가 이기는 경우
			boolean winA = ((a[i] == 1) & (b[i] == 3)) | ((a[i] == 2) & (b[i] == 1)) | ((a[i] == 3) & (b[i] == 2));
            
            // 무승부
			if (a[i] == b[i]) {
				System.out.println("D");
                
                // A 가 이기는 경우
			} else if (winA) {
				System.out.println("A");
                
                // B 가 이기는 경우
			} else {
				System.out.println("B");
			}
		}		
	}
}
```

## 3. 피보나치 수열

date: 06.26

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int first = 1;
		int second = 1;
		System.out.print(first + " " + second);
		
		for (int i = 0; i < n - 2; i++) {
			int temp = first + second;
			first = second;
			second = temp;
			System.out.print(" " + second);
		}
	}
}
```

## 4. 소수 (에라토스테네스 체)

에라토스테네스 체 : 소수를 구하는 방법론에서 가장 빠릅니다.

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int count = 0;
		int[] arr = new int[n + 1];

		for (int i = 2; i <= n; i++) {
			if (arr[i] == 0) {
				count++;
				for (int j = i; j <= n; j += i) {
					arr[j] = 1;
				}
			}
		}
		System.out.println(count);
	}
}
```

## 5. 뒤집은 소수

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();

		Loop:
		for (int i = 0; i < n; i++) {
			String input = sc.next();
			String rev = "";
			int len = input.length();
			int prime = 0;

			// 숫자 뒤집기
			for (int j = 0; j < len; j++) {
					rev += input.charAt(len - j - 1);
					
					// 첫 자리 0 없애기
					prime = Integer.parseInt(rev);
			}

			// 뒤집은 숫자가 1이라면 소수가 아닙니다.
			if (prime == 1) {
				continue;
			}
			
			// 소수가 있으면 다음숫자로 넘어가기
			for (int j = 2; j < prime; j++) {
				if ((prime % j) == 0) {
					continue Loop;
				}
			}
			
			System.out.print(prime + " ");
		}
	}
}
```

## 6. 점수계산

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int sum = 0;
		int stack = 0;
		
		for (int i = 0; i < n; i++) {
			int input = sc.nextInt();
			
			if (input == 1) {
				sum += 1 + stack;
				stack++;
			} else {
				stack = 0;
			}
		}
		
		System.out.println(sum);
	}
}
```

## 7. 등수구하기

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[] points = new int[n];

		for (int i = 0; i < n; i++) {
			points[i] = sc.nextInt();
		}

		for (int i = 0; i < n; i++) {
			int rank = 1;
			for (int j = 0; j < n; j++) {
				if (points[i] < points[j]) {
					rank++;
				}
			}
            
			System.out.print(rank + " ");
		}
	}
}
```

## 8. 격자판 최대합

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int max = 0;
		int[][] arr = new int[n][n];
		int sum;

		// 입력
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				arr[i][j] = sc.nextInt();
			}
		}

		// 각 행의 합
		for (int i = 0; i < n; i++) {
			sum = 0;
			for (int j = 0; j < n; j++) {
				sum += arr[i][j];
			}
			if (max < sum) {
				max = sum;
			}
		}

		// 각 열의 합
		for (int i = 0; i < n; i++) {
			sum = 0;
			for (int j = 0; j < n; j++) {
				sum += arr[j][i];
			}
			if (max < sum) {
				max = sum;
			}
		}

		// 각 대각선의 합
		sum = 0;
		for (int i = 0; i < n; i++) {
			sum += arr[i][i];
		}

		if (max < sum) {
			max = sum;
		}

		sum = 0;
		for (int i = 0; i < n; i++) {
			sum += arr[i][n - 1 - i];
		}

		if (max < sum) {
			max = sum;
		}
		
		System.out.println(max);
	}
}
```

## 9. 봉우리

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int num = sc.nextInt();
		int count = 0;
		int[][] arr = new int[num + 2][num + 2];
		
		for (int i = 0; i < num; i++) {
			for (int j = 0; j < num; j++) {
				arr[i + 1][j + 1] = sc.nextInt();
			}
		}
		
		for (int i = 0; i < num; i++) {
			for (int j = 0; j < num; j++) {
				boolean n = arr[i + 1][j + 1] > arr[i][j + 1];
				boolean e = arr[i + 1][j + 1] > arr[i + 1][j + 2];
				boolean w = arr[i + 1][j + 1] > arr[i + 1][j];
				boolean s = arr[i + 1][j + 1] > arr[i + 2][j + 1];
				if (n & e & w & s) {
					count++;
				}
			}
		}
		
		System.out.println(count);
	}
}
```

## 10. 임시반장 정하기

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[][] arr = new int[n][n];
		int[][] president = new int[n][n];
		int who = 0;
		int max = 0;

		// 입력
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				arr[i][j] = sc.nextInt();
			}
		}

		// 같은반이었던 학생들에게 1 대입
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n - 1; j++) {
				for (int k = j + 1; k < n; k++) {
					if (arr[j][i] == arr[k][i]) {
						president[j][i] = 1;
						president[k][i] = 1;
					}
				}
			}
		}

		// 임시반장에 적합한 친구를 찾습니다.
		for (int i = 0; i < n; i++) {
			int sum = 0;
			
			for (int j = 0; j < n; j++) {
				sum += president[i][j];
				if (max < sum) {
					max = sum;
					who = i + 1;
				}
			}
		}

		System.out.println(who);
	}
}
```

