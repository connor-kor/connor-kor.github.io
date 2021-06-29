---
title: 2) 배열 강의
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

|         | 1학년 | 2학년 | 3학년 | 4학년 | 5학년 |
| ------- | ----- | ----- | ----- | ----- | ----- |
| 1번학생 | 2     | 3     | 1     | 7     | 3     |
| 2번학생 | 4     | 1     | 9     | 6     | 8     |
| 3번학생 | 5     | 5     | 2     | 4     | 4     |
| 4번학생 | 6     | 5     | 2     | 6     | 7     |
| 5번학생 | 8     | 4     | 2     | 2     | 2     |

입력

```
5
2 3 1 7 3
4 1 9 6 8
5 5 2 4 4
6 5 2 6 7
8 4 2 2 2
```

**출력**

```
1번 학생은 친구가 0명 입니다.
2번 학생은 친구가 1명 입니다.
3번 학생은 친구가 2명 입니다.
4번 학생은 친구가 3명 입니다.
5번 학생은 친구가 2명 입니다.
학급회장은 4번 학생입니다.
```

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[][] classes = new int[n][5];
		int[] students = new int[n];
		int max = 0;
		int president = 0;

		// 입력
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				classes[i][j] = sc.nextInt();
			}
		}

		for (int firstStudent = 0; firstStudent < n - 1; firstStudent++) {
			for (int secondStudent = firstStudent + 1; secondStudent < n; secondStudent++) {
				for (int grade = 0; grade < 5; grade++) {
					if (classes[firstStudent][grade] == classes[secondStudent][grade]) {
						students[firstStudent]++;
						students[secondStudent]++;
						break;
					}
				}
			}
		}

		// 배열에서 가장 친구가 많은 학생 출력
		for (int i = 0; i < n; i++) {
			if (max < students[i]) {
				max = students[i];
				president = i + 1;
			}
			System.out.println(i + 1 + "번 학생은 친구가 " + students[i] + "명 입니다.");
		}

		System.out.println("학급회장은 " + president + "번 학생입니다.");
	}
}
```

Q1. break 을 사용하는 이유는?

A1. 

3번학생과 4번학생의 2학년 3학년을 보면 각각 5, 5 와 2, 2 로 같습니다. 

for 문에서 학년이 2학년일 때 students++ 로 3번학생과 4번학생의 친구가 하나 늘어났지만

3학년일 때는 동일한 친구이므로 친구를 늘리면 안됩니다. (2, 3학년때 각각 두번 같은 반이었어도 친구는 여전히 한 명이므로)

break 을 실행하면 grade (학년) 를 반복하는 for 문을 빠져나옵니다.

그러므로 같은 학생에 대한 학년의 반복을 막을 수 있습니다.

Q2. president 에 i + 1 을 대입하는 이유는?

A2.

students 배열에 넣을때는 0 부터 넣었으므로 students[0] 은 1번학생, students[1] 은 2번학생, students[2] 은 3번학생...

students[4] 은 5번학생이 됩니다. 그러므로 마지막에 president 에는 i + 1 로 대입하여 출력합니다.

## 11. 멘토링

이 강의 선생님은 이 문제를 4중 for문으로 푼다..

뭔가 마음에 들지 않아서 여러 시도 중에 있다.

```java
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int m = sc.nextInt();
		int[][] number = new int[m][n];
		int firstRank = 0;
		int secondRank = 0;
		int count = 0;
		
		// 입력
		for (int i = 0; i < m; i++) {
			for (int j = 0; j < n; j++) {
				number[i][j] = sc.nextInt();
			}
		}
		
		for (int first = 1; first <= n; first++) {
			for (int second = 1; second <= n; second++) {
				int mento = 0;
                
                // 같은사람은 ㅣ등수를 비교하지 않는다.
				if (first == second) {
					continue;
				}
                
				for (int i = 0; i < m; i++) {
					for (int j = 0; j < n; j++) {
						if (number[i][j] == first) {
							firstRank = j;
						} else if (number[i][j] == second) {
							secondRank = j;
						}
					}
					if (firstRank >= secondRank) {
						break;
					}
					mento++;
					if (mento == m) {
						count++;
					}
				}	
			}
		}
		
		System.out.println(count);
	}
}
```

