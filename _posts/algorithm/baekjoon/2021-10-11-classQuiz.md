---
title: 클래스 문제
category: baekjoon
---

# Class 4

## 조합

```java
public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int m = sc.nextInt();
		if (n/2 < m) m = n - m;
		
		BigInteger answer = factorial(n, m).divide(factorial(m, m));
		System.out.println(answer);
	}

	private static BigInteger factorial(int n, int m) {
		BigInteger big = new BigInteger("1");
		for (int i = n; i > n - m; i--) 
			big = big.multiply(BigInteger.valueOf(i));
		
		return big;	
	}
}
```

## N과 M(1) -15649

```
1 2 3 4
1 2 4 3
1 3 2 4
1 3 4 2
1 4 2 3
1 4 3 2
2 1 3 4
2 1 4 3
2 3 1 4
2 3 4 1
2 4 1 3
2 4 3 1
3 1 2 4
3 1 4 2
3 2 1 4
3 2 4 1
3 4 1 2
3 4 2 1
4 1 2 3
4 1 3 2
4 2 1 3
4 2 3 1
4 3 1 2
4 3 2 1
```



```java
public class Main {
	private static int TO;
	private static int NUMBER_OF;
	static ArrayList<Integer> list = new ArrayList<>();
	private static BufferedWriter bw;

	public static void main(String[] args) throws IOException {
		bw = new BufferedWriter(new OutputStreamWriter(System.out));
		Scanner sc = new Scanner(System.in);
		TO = sc.nextInt();
		NUMBER_OF = sc.nextInt();
		
		dfs();
		bw.flush();
	}

	private static void dfs() throws IOException {
		if (list.size() == NUMBER_OF) {
			for (Integer it : list) bw.write(it + " ");
			bw.write("\n");
		} else {
			for (int i = 1; i <= TO; i++) {
				if (!list.contains(i)) {
					list.add(i);
					dfs();
					list.remove(list.indexOf(i));
				}
			}
		}
	}
}
```





## N과 M (2) -15650

**문제**

자연수 N과 M이 주어졌을 때, 아래 조건을 만족하는 길이가 M인 수열을 모두 구하는 프로그램을 작성하시오.

- 1부터 N까지 자연수 중에서 중복 없이 M개를 고른 수열
- 고른 수열은 오름차순이어야 한다.

**입력**

첫째 줄에 자연수 N과 M이 주어진다. (1 ≤ M ≤ N ≤ 8)

**출력**

한 줄에 하나씩 문제의 조건을 만족하는 수열을 출력한다. 중복되는 수열을 여러 번 출력하면 안되며, 각 수열은 공백으로 구분해서 출력해야 한다.

수열은 사전 순으로 증가하는 순서로 출력해야 한다.

| 입력 | 출력                                                  |
| ---- | ----------------------------------------------------- |
| 3 1  | 1<br />2<br />3                                       |
| 4 2  | 1 2 <br />1 3 <br />1 4 <br />2 3 <br />2 4 <br />3 4 |
| 4 4  | 1 2 3 4                                               |

**출력**

```
5 3
1 2 3 
1 2 4 
1 2 5 
1 3 4 
1 3 5 
1 4 5 
2 3 4 
2 3 5 
2 4 5 
3 4 5 
```

**코드**

```java
public class Main {
	private static int TO;
	private static int NUMBER_OF;
	static ArrayList<Integer> list = new ArrayList<>();

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		TO = sc.nextInt();
		NUMBER_OF = sc.nextInt();
		dfs(1);
	}

	private static void dfs(int n) {
		if (list.size() == NUMBER_OF) {
			list.forEach(it -> System.out.printf("%d ", it));
			System.out.println();
		} else {
			for (int i = n; i <= TO; i++) {
				list.add(i);
				dfs(i + 1);
				list.remove(list.indexOf(i));
			}
		}
	}
}
```

**DFS**

```java
private static void dfs(int n) {
    if (list.size() == NUMBER_OF) {
        System.out.println(list);
    } else {
        for (int i = n; i <= TO; i++) {
            list.add(i);
            dfs(i + 1);
            list.remove(list.indexOf(i));
        }
    }
}
```

## N과 M (3) -15651

```
1 1 1
1 1 2
1 1 3
1 2 1
1 2 2
1 2 3
1 3 1
1 3 2
1 3 3
2 1 1
2 1 2
2 1 3
2 2 1
2 2 2
2 2 3
2 3 1
2 3 2
2 3 3
3 1 1
3 1 2
3 1 3
3 2 1
3 2 2
3 2 3
3 3 1
3 3 2
3 3 3
```



## N과 M (5) -15654

**문제**

N개의 자연수와 자연수 M이 주어졌을 때, 아래 조건을 만족하는 길이가 M인 수열을 모두 구하는 프로그램을 작성하시오. N개의 자연수는 모두 다른 수이다.

- N개의 자연수 중에서 M개를 고른 수열

**입력**

첫째 줄에 N과 M이 주어진다. (1 ≤ M ≤ N ≤ 8)

둘째 줄에 N개의 수가 주어진다. 입력으로 주어지는 수는 10,000보다 작거나 같은 자연수이다.

**출력**

한 줄에 하나씩 문제의 조건을 만족하는 수열을 출력한다. 중복되는 수열을 여러 번 출력하면 안되며, 각 수열은 공백으로 구분해서 출력해야 한다.

수열은 사전 순으로 증가하는 순서로 출력해야 한다.

**예제 입력 1**

```
3 1
4 5 2
```

**예제 출력 1**

```
2
4
5
```

**예제 입력 2**

```
4 2
9 8 7 1
```

**예제 출력 2**

```
1 7
1 8
1 9
7 1
7 8
7 9
8 1
8 7
8 9
9 1
9 7
9 8
```

**예제 입력 3**

```
4 4
1231 1232 1233 1234
```

**예제 출력 3**

```
1231 1232 1233 1234
1231 1232 1234 1233
1231 1233 1232 1234
1231 1233 1234 1232
1231 1234 1232 1233
1231 1234 1233 1232
1232 1231 1233 1234
1232 1231 1234 1233
1232 1233 1231 1234
1232 1233 1234 1231
1232 1234 1231 1233
1232 1234 1233 1231
1233 1231 1232 1234
1233 1231 1234 1232
1233 1232 1231 1234
1233 1232 1234 1231
1233 1234 1231 1232
1233 1234 1232 1231
1234 1231 1232 1233
1234 1231 1233 1232
1234 1232 1231 1233
1234 1232 1233 1231
1234 1233 1231 1232
1234 1233 1232 1231
```

**코드**

```java
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class Main {
	static int TO;
	static int NUMBER_OF;
	static int[] arr;
	static ArrayList<Integer> answer = new ArrayList<>();
	private static BufferedWriter bw;
	
	public static void main(String[] args) throws IOException {
		bw = new BufferedWriter(new OutputStreamWriter(System.out));
		Scanner sc = new Scanner(System.in);
		TO = sc.nextInt();
		NUMBER_OF = sc.nextInt();
		arr = new int[TO];
		
		for (int i = 0; i < arr.length; i++) 
			arr[i] = sc.nextInt();
		
		Arrays.sort(arr);
		dfs();
		bw.flush();
	}

	private static void dfs() throws IOException {
		if (answer.size() == NUMBER_OF) {
			for (Integer it : answer) 
				bw.write(it + " ");
			
			bw.write("\n");
		} else {
			for (int i = 0; i < TO; i++) {
				if (!answer.contains(arr[i])) {
					answer.add(arr[i]);
					dfs();
					answer.remove(answer.indexOf(arr[i]));
				}
			}
		}
	}
}
```

> 출력이 많기 때문에 Scanner 대신에 BufferedWriter 를 사용해야 시간초과를 방지할 수 있다.

**DFS** 

```java
private static void dfs() throws IOException {
    if (answer.size() == NUMBER_OF) {
        for (Integer it : answer) bw.write(it + " ");
        bw.write("\n");
    } else {
        for (int i = 0; i < TO; i++) {
            if (!visited[i]) {
                answer.add(arr[i]);
                visited[i] = true;
                dfs();
                answer.remove(answer.indexOf(arr[i]));
                visited[i] = false;
            }
        }
    }
}
```

