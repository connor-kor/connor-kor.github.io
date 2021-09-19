---
title: 5' Stack&queue 강의
category: algorithm
---

# Stack 

## 1. 올바른 괄호

Stack 은 구덩이, Queue 는 원통의 통로

LIFO 구조

`stack` 

- `push()` 넣기
- `pop()` 꺼내기
- `isEmpty()` 비어있으면 true 반환

```java
import java.util.Scanner;
import java.util.Stack;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		Stack<Character> stack = new Stack<>();
		String answer = "YES";
		
		for (char c : str.toCharArray()) {
			if (c == '(') {
				stack.push(c);
			} else if (stack.isEmpty()) {
				answer = "NO";
				break;
			} else {
				stack.pop();
			}
		}
		
		if (!stack.isEmpty()) {
			answer = "NO";
		}
		System.out.println(answer);
	}
}
```

## 2. 괄호문자제거

```java
import java.util.Scanner;
import java.util.Stack;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String str = sc.next();
		Stack<Character> stack = new Stack<>();
		
		for (char c : str.toCharArray()) {
			if (c == '(') {
				stack.push(c);
			} else if (c == ')') {
				stack.pop();
			}
			
			if (stack.isEmpty() & Character.isAlphabetic(c)) {
				System.out.print(c);
			}
		}
	}
}
```

## 3. 크레인 인형뽑기 (카카오)

크레인에서 [1, 5, 3] 의 순서로 인형을 뽑은 예시

![Image1.jpg](../../assets/images/d637c6aff5.jpg)

![Image1.jpg](../../assets/images/e7f1732dc7.jpg)

**입력**

첫 줄에 자연수 N 이 주어집니다.

두 번째 줄부터 N*N board 배열이 주어집니다.

0은 빈 칸을 나타냅니다.

board 의 각 숫자는 각기 다른 인형의 모양을 의미하며 같은 숫자는 같은 모양의 인형을 나타냅니다.

board배열이 끝난 다음줄에 moves 배열의 길이 M이 주어집니다.

마지막 줄에는 moves 배열이 주어집니다.

moves 배열 각 원소들의 값은 1 이상이며 board 배열의 가로 크기 이하인 자연수입니다.

```
5
0 0 0 0 0
0 0 1 0 3
0 2 5 0 1
4 2 4 4 2
3 5 1 3 1
8
1 5 3 5 1 2 1 4
```

**출력**

첫 줄에 터트려져 사라진 인형의 개수를 출력합니다.

```
4
```

**최적화 코드**

```java
class Solution {
	public int solution(int[][] board, int[] moves) {
		Stack<Integer> stack = new Stack<>();
		stack.push(0);
		int count = 0;

		pick: for (int move : moves) {
			int col = 0;
			int row = move - 1;

			while (board[col][row] == 0) {
				col++;
				if (col == board.length) continue pick;
			}

			int pick = board[col][row];
			if (stack.lastElement() == pick) {
				stack.pop();
				count += 2;
			} else stack.push(pick);

			board[col][row] = 0;
		}
		return count;
	}
}
```

**코드**

```java
import java.util.Scanner;
import java.util.Stack;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Stack<Integer> stack = new Stack<>();
		int n = sc.nextInt();
		int[][] board = new int[n][n];
		int count = 0;
		
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				board[i][j] = sc.nextInt();
			}
		}
		int m = sc.nextInt();
		int[] moves = new int[m];
		
		// 입력
		for (int i = 0; i < m; i++) {
			moves[i] = sc.nextInt();
		}
		stack.push(0);

		loop:
		for (int i = 0; i < m; i++) {
			int height = 0;
			
			while (board[height][moves[i] - 1] == 0) {
				height++;
				if (height == n) {
					continue loop;
				}
			}
			int pick = board[height][moves[i] - 1];
			
			if (stack.lastElement() == pick) {
				stack.pop();
				count += 2;
			} else {
				stack.push(pick);
			}
			board[height][moves[i] - 1] = 0;
		}
		System.out.println(count);
	}
}
```

## 4. 후위식 연산 (postfix)

**입력** 

```
352+*9-
```



**출력** 

```
12
```

**코드** 

```java
import java.util.Scanner;
import java.util.Stack;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Stack<Integer> stack = new Stack<>();
		String str = sc.next();
		
		for (char c : str.toCharArray()) {
			int first;
			int second;
			int answer = 0;
			
			if (Character.isDigit(c)) {
				stack.push(c - 48);
			} else {
				second = stack.pop();
				first = stack.pop();
				
				switch (c) {
				case '+':
					answer = first + second;
					break;
				case '-':
					answer = first - second;
					break;
				case '*':
					answer = first * second;
					break;
				case '/':
					answer = first / second;
					break;
				default:
					break;
				}
				stack.push(answer);
			}
		}
		System.out.println(stack.pop());
	}
}
```

## 5. 쇠막대기

![Image1.jpg](../../assets/images/35b4910834.jpg)

**조건** 

- 쇠막대기는 자신보다 긴 쇠막대기 위에만 놓일 수 있다. - 쇠막대기를 다른 쇠막대기 위에 놓는 경우 완전히 포함되도록 놓되,
  끝점은 겹치지 않도록 놓는다.
- 각 쇠막대기를 자르는 레이저는 적어도 하나 존재한다.
- 수직으로 그려진 점선 화살표는 레이저의 발사 방향이다.

**설명** 

1. 모든 ‘( ) ’는 반 드시 레이저를 표현한다.
2. 쇠막대기의 왼쪽 끝은 여는 괄호 ‘ ( ’ 로, 오른쪽 끝은 닫힌 괄호 ‘) ’ 로 표현된다.
3. 이와 같은 방식으로 주어진 쇠막대기들은 총 17 개의 조각으로 잘려진다.

**입력** 

```
()(((()())(())()))(())
```

**출력** 

```
17
```

**코드** 

```java
import java.util.Scanner;
import java.util.Stack;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Stack<Character> stack = new Stack<>();
		String str = sc.next();
		int answer = 0;

		for (int i = 0; i < str.length(); i++) {
			if (str.charAt(i) == '(') {
				stack.push('(');
			} else {
				stack.pop();
				if (str.charAt(i - 1) == '(') {
					answer += stack.size();
				} else {
					answer++;
				}
			}
		}
		System.out.println(answer);
	}
}
```

# Queue

`queue`

- `offer(value)` 
- `poll()` 
- `peek()` 확인만
- `size()`
- `contains(x)` 

FIFO: first in first out

선언

```java
Queue<Integer> queue = new LinkedList<Integer>();
```

Q. Queue 에서 add 와 offer 의 차이점은?

A. add() 는 Collection 프레임워크에서 오고 offer() 는 Queue 프레임워크에서 옵니다.

add() 는 항상 true 를 반환하고 용량문제로 넣지못할 때에는 throws 예외를 발생시킵니다.

반면 offer() 는 넣지못할 때에는 false 를 반환합니다.

<https://stackoverflow.com/questions/15591431/difference-between-offer-and-add-in-priority-queue-in-java>{:target="_blank"}

## 6. 공주구하기

1번 왕자부터 시계방향으로 돌아가며 1부터 시작하여 번호를 외치게 한다.

한 왕자가 K(특정숫자)를 외치면 그 왕자는 공주를 구하러 가는데서 제외되고 원 밖으로 나오게 된다.

그리고 다음 왕자부터 다시 1부터 시작하여 번호를 외친다.

**예시**

예를 들어 총 8명의 왕자가 있고, 3을 외친 왕자가 제외된다고 하자. 처음에는 3번 왕자가 3을 외쳐 제외된다.

이어 6, 1, 5, 2, 8, 4번 왕자가 차례대로 제외되고 마지막까지 남게 된 7번 왕자에게 공주를 구하러갑니다.

**입력**

```
8 3
```

**출력**

```
7
```

**코드**

```java
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Queue<Integer> queue = new LinkedList<Integer>();
		int n = sc.nextInt();
		int k = sc.nextInt();
		
		for (int i = 1; i <= n; i++) {
			queue.offer(i);
		}
		
		while (queue.size() != 1) {
			for (int i = 1; i < k; i++) {
				queue.offer(queue.poll());
			}
			queue.poll();
		}
		System.out.println(queue.poll());
	}
}
```

## 7. 교육과정 설계

**예시**

만약 총 과목이 A, B, C, D, E, F, G가 있고, 여기서 필수과목이 CBA로 주어지면 필수과목은 C, B, A과목이며 이 순서대로 꼭 수업계획을 짜야 합니다.

필수과목순서가 주어지면 현수가 짠 N개의 수업설계가 잘된 것이면 “YES", 잘못된 것이면 ”NO“를 출력하는 프로그램을 작성하세요.

**입력**

```
CBA
CBDAGE
```

**출력**

```
YES
```

**코드**

```java
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Queue<Character> queue = new LinkedList<>();
		String require = sc.next();
		String subject = sc.next();
		int count = 0;

		for (char c : require.toCharArray()) {
			queue.offer(c);
		}

		for (char c : subject.toCharArray()) {
			if (queue.peek() == c) {
				count++;
				queue.poll();
				if (queue.isEmpty()) {
					break;
				}
			}
		}

		if (count == require.length()) {
			System.out.println("YES");
		} else {
			System.out.println("NO");
		}
	}
}
```

## 8. 응급실

• 환자가 접수한 순서대로의 목록에서 제일 앞에 있는 환자목록을 꺼냅니다.

• 나머지 대기 목록에서 꺼낸 환자 보다 위험도가 높은 환자가 존재하면 대기목록 제일 뒤로 다시 넣습니다. 그렇지 않으면 진료를 받습니다.

즉 대기목록에 자기 보다 위험도가 높은 환자가 없을 때 자신이 진료를 받는 구조입니다.

현재 N명의 환자가 대기목록에 있습니다.

N명의 대기목록 순서의 환자 위험도가 주어지면, 대기목록상의 M번째 환자는 몇 번째로 진료를 받는지 출력하는 프로그램을 작성하세요.

대기목록상의 M번째는 대기목록의 제일 처음 환자를 0번째로 간주하여 표현한 것입니다.

M번째 환자는 몇 번째로 진료받는지 출력하세요.	

**예시**

위험도가 70인 2번째 환자는 3번째로 진료를 받는다.

**입력**

```
5 2
60 50 70 80 90
```

**출력**

```
[0환자:위험도60, 1환자:위험도50, 2환자:위험도70, 3환자:위험도80, 4환자:위험도90]
0환자:위험도60를 뒤로 보냅니다.
[1환자:위험도50, 2환자:위험도70, 3환자:위험도80, 4환자:위험도90, 0환자:위험도60]
1환자:위험도50를 뒤로 보냅니다.
[2환자:위험도70, 3환자:위험도80, 4환자:위험도90, 0환자:위험도60, 1환자:위험도50]
2환자:위험도70를 뒤로 보냅니다.
[3환자:위험도80, 4환자:위험도90, 0환자:위험도60, 1환자:위험도50, 2환자:위험도70]
3환자:위험도80를 뒤로 보냅니다.
[4환자:위험도90, 0환자:위험도60, 1환자:위험도50, 2환자:위험도70, 3환자:위험도80]
1번째 진료는 4환자:위험도90입니다.
0환자:위험도60를 뒤로 보냅니다.
[1환자:위험도50, 2환자:위험도70, 3환자:위험도80, 0환자:위험도60]
1환자:위험도50를 뒤로 보냅니다.
[2환자:위험도70, 3환자:위험도80, 0환자:위험도60, 1환자:위험도50]
2환자:위험도70를 뒤로 보냅니다.
[3환자:위험도80, 0환자:위험도60, 1환자:위험도50, 2환자:위험도70]
2번째 진료는 3환자:위험도80입니다.
0환자:위험도60를 뒤로 보냅니다.
[1환자:위험도50, 2환자:위험도70, 0환자:위험도60]
1환자:위험도50를 뒤로 보냅니다.
[2환자:위험도70, 0환자:위험도60, 1환자:위험도50]
3번째 진료는 2환자:위험도70입니다.
```

**설명없는 코드**

```java
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

class Person {
	int id;
	int risk;

	public Person(int id, int risk) {
		this.id = id;
		this.risk = risk;
	}
}

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Queue<Person> queue = new LinkedList<>();
		int n = sc.nextInt();
		int m = sc.nextInt();
		int order = 1;
		boolean pass;

		for (int i = 0; i < n; i++) {
			int risk = sc.nextInt();
			queue.offer(new Person(i, risk));
		}

		while (true) {
			pass = false;
			for (Person person : queue) {
				if (queue.peek().risk < person.risk) {
					queue.offer(queue.poll());
					pass = true;
					break;
				}
			}
			if (!pass) {
				if (queue.poll().id == m) {
					System.out.println(order);
					break;
				}
				order++;
			}
		}
	}
}
```

**설명포함 코드**

```java
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

class Person {
	int id;
	int risk;

	public Person(int id, int risk) {
		this.id = id;
		this.risk = risk;
	}

	@Override
	public String toString() {
		return id + "환자:위험도" + risk;
	}
}

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Queue<Person> queue = new LinkedList<>();
		int n = sc.nextInt();
		int m = sc.nextInt();
		int order = 1;
		boolean pass;

		for (int i = 0; i < n; i++) {
			int risk = sc.nextInt();
			queue.offer(new Person(i, risk));
		}
		
		System.out.println(queue);
		while (true) {
			pass = false;
			for (Person person : queue) {
				if (queue.peek().risk < person.risk) {
					System.out.println(queue.peek() + "를 뒤로 보냅니다.");
					queue.offer(queue.poll());
					System.out.println(queue);
					pass = true;
					break;
				}
			}
			if (!pass) {
				System.out.println(order + "번째 진료는 " + queue.peek() + "입니다.");
				if (queue.poll().id == m) {
					break;
				}
				order++;
			}
		}
	}
}
```
