---
title: VII. Recursive&Tree&Graph(DFS, BFS 기초)
category: algorithm
---

## 1. 재귀함수: 스택프레임

재귀함수는 스택을 사용합니다.

```java
public class Main {
	public static void main(String[] args) {
		recursive(3);
	}
}
```

**재귀함수 전에 선언**

```java
static void recursive(int n) {
    if (n != 0) {
        System.out.print(n + " ");
        recursive(n - 1);
    }
}
```
**출력**

```
3 2 1 
```
**재귀함수 후에 선언** 

```java
static void recursive(int n) {
	if (n != 0) {
		recursive(n - 1);
		System.out.print(n + " ");
	}
}
```
**출력**

```
1 2 3 
```

## 2. 이진수 출력 (재귀)

이진수는 나머지를 역으로 출력하면 됩니다.

```java
public class Main {
	static void r(int n) {
		if (n != 0) {
			r(n / 2);
			System.out.print(n % 2);
		}
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		r(sc.nextInt());
	}
}
```

## 3. 팩토리얼

```java
public class Main {
	static int r(int n) {
		if (n == 1) {
			return 1;
		} else {
			return r(n - 1) * n;
		}
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println(r(sc.nextInt()));
	}
}
```

## 4. 피보나치 재귀 (메모이제이션)

대부분은 재귀함수보다 for 문과 배열로 짜는 것이 메모리 등이 더 가볍고 유리합니다.

**기본코드** 

```java
public class Main {
	static int r(int n) {
		if (n == 1 || n == 2) {
			return 1;
		} else {
			return r(n - 1) + r(n - 2);
		}
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		System.out.println(r(n));
	}
}
```

**입력** 

```
10
```

**출력**

```
1 1 2 3 5 8 13 21 34 55 
```

**배열저장 코드**

```java
public class Main {
	static int[] arr;
	
	static int r(int n) {
		if (n == 1 || n == 2) {
			return arr[n - 1] = 1;
		} else {
			return arr[n - 1] = r(n - 1) + r(n - 2);
		}
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		arr = new int[n];
		r(n);
		
		for (int num : arr) {
			System.out.print(num + " ");
		}
	}
}
```

**메모이제이션의 중요성**

n = 45 일 때,

메모이제이션을 사용한 코드는 0.1초만에 출력되는 반면

사용하지 않은 코드는 4.45초가 걸렸다.

n = 46 일 때,

메모이제이션을 사용한 코드는 0.1초만에 출력되는 반면

사용하지 않은 코드는 6.89초가 걸렸다.

```java
if (arr[n] > 0) {
    return arr[n];
```

단 두 줄의 코드를 추가함으로써 엄청난 시간을 아낄 수 있는 것이다.

**코드** 

```java
public class Main {
	static int[] arr;

	static int r(int n) {
		if (arr[n] > 0) {
			return arr[n];
		} else if (n == 1 || n == 2) {
			return arr[n] = 1;
		} else {
			return arr[n] = r(n - 1) + r(n - 2);
		}
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		arr = new int[n + 1];
		r(n);

		for (int num : arr) {
			System.out.print(num + " ");
		}
	}
}
```

## 5. 이진트리순회 (DFS: Depth-First Search)

전위순회

중위순회: 부모를 중간에 출력

후위순회: 부모를 마지막에 출력. 병합정렬과 같습니다.

```java
class Node {
	int data;
	Node left, right;

	Node(int data) {
		this.data = data;
	}
}

public class Main {
	public static void main(String[] args) {
		Node root = new Node(1);
		root.left = new Node(2);
		root.right = new Node(3);
		root.left.left = new Node(4);
		root.left.right = new Node(5);
		root.right.left = new Node(6);
		root.right.right = new Node(7);
		
		dfs(root);
	}
}
```

**전위순회**

```java
static void dfs(Node node) {
	if (node != null) {
		System.out.print(node.data + " ");
		dfs(node.left);
		dfs(node.right);
	}
}
```

**출력**

```
1 2 4 5 3 6 7 
```

**중위순회**

```java
static void dfs(Node node) {
	if (node != null) {
		dfs(node.left);
		System.out.print(node.data + " ");
		dfs(node.right);
	}
}
```

**출력**

```
4 2 5 1 6 3 7 
```

**후위순회**

```java
static void dfs(Node node) {
	if (node != null) {
		dfs(node.left);
		dfs(node.right);
		System.out.print(node.data + " ");
	}
}
```

**출력**

```
4 5 2 6 7 3 1 
```

