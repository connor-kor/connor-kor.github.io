---
title: 프로그래머스 Lv1 3페이지
category: programmers
---

## 1. 약수의 합

2점

**문제 설명**

정수 n을 입력받아 n의 약수를 모두 더한 값을 리턴하는 함수, solution을 완성해주세요.

**제한 사항**

- `n`은 0 이상 3000이하인 정수입니다.

**입출력 예**

| n    | return |
| ---- | ------ |
| 12   | 28     |
| 5    | 6      |

```java
public class Solution {
    public int solution(int n) {
    	if (n <= 1) return n;
        int sum = n + 1;
        for (int i = 2; i <= sqrt(n); i++) if (n % i == 0) 
        	sum += i + n/i; 
        return (int) sqrt(n) != sqrt(n) ? sum : sum - (int) sqrt(n);
    }
}
```

## 2. 콜라츠 추측

5점

**문제 설명**

1937년 Collatz란 사람에 의해 제기된 이 추측은, 주어진 수가 1이 될때까지 다음 작업을 반복하면, 모든 수를 1로 만들 수 있다는 추측입니다. 작업은 다음과 같습니다.

```
1-1. 입력된 수가 짝수라면 2로 나눕니다. 
1-2. 입력된 수가 홀수라면 3을 곱하고 1을 더합니다.
2. 결과로 나온 수에 같은 작업을 1이 될 때까지 반복합니다.
```

예를 들어, 입력된 수가 6이라면 6→3→10→5→16→8→4→2→1 이 되어 총 8번 만에 1이 됩니다. 위 작업을 몇 번이나 반복해야하는지 반환하는 함수, solution을 완성해 주세요. 단, 작업을 500번을 반복해도 1이 되지 않는다면 –1을 반환해 주세요.

**제한 사항**

- 입력된 수, `num`은 1 이상 8000000 미만인 정수입니다.

**입출력 예**

| n      | result |
| ------ | ------ |
| 6      | 8      |
| 16     | 4      |
| 626331 | -1     |

```java
public class Solution {
    public int solution(int num) {
    	long n = num;
        int count = 0;
        
        while (n != 1) {
        	n = n % 2 == 0 ? n/2 : n*3 + 1;
        	if (++count == 500) return -1;
        }
        return count;
    }
}
```

## 3. 직사각형 별찍기

1점

**문제 설명**

이 문제에는 표준 입력으로 두 개의 정수 n과 m이 주어집니다.
별(*) 문자를 이용해 가로의 길이가 n, 세로의 길이가 m인 직사각형 형태를 출력해보세요.

**예시**

입력

```
5 3
```

출력

```
*****
*****
*****
```

**코드** 

```java
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int x = sc.nextInt();
        int y = sc.nextInt();
        System.out.println(("*".repeat(x)+"\n").repeat(y));
        sc.close();
    }
}
```

## 4. 하샤드 수

1점

**문제 설명**

양의 정수 x가 하샤드 수이려면 x의 자릿수의 합으로 x가 나누어져야 합니다. 예를 들어 18의 자릿수 합은 1+8=9이고, 18은 9로 나누어 떨어지므로 18은 하샤드 수입니다. 자연수 x를 입력받아 x가 하샤드 수인지 아닌지 검사하는 함수, solution을 완성해주세요.

**입출력 예**

| arr  | return |
| ---- | :----: |
| 10   |  true  |
| 12   |  true  |
| 11   | false  |
| 13   | false  |

**코드**

```java
public class Solution {
	int sum = 0;
    public boolean solution(int x) {
      String.valueOf(x).chars().forEach(it -> sum += it - '0');
      return x % sum == 0;
    }
}
```



```java
public class Solution {
    public boolean solution(int x) {
        int sum = 0;
        for (char c : String.valueOf(x).toCharArray()) sum += c-'0';
        return x % sum == 0;
    }
}
```

> `String.chars()` 메서드는 char 스트림을 반환한다.

## 5. 정수 내림차순 배치하기

작성날짜: 10/10

1점

**문제 설명**

함수 solution은 정수 n을 매개변수로 입력받습니다. n의 각 자릿수를 큰것부터 작은 순으로 정렬한 새로운 정수를 리턴해주세요. 예를들어 n이 118372면 873211을 리턴하면 됩니다.

**입출력 예**

| n      | return |
| ------ | :----: |
| 118372 | 873211 |

**코드**

```java
class Solution {
    public long solution(long n) {
		char[] arr = String.valueOf(n).toCharArray();
		Arrays.sort(arr);
		String str = new StringBuilder(new String(arr)).reverse().toString();
		return Long.parseLong(str);
    }
}
```

**스트림** 

```java
class Solution {
    static long sum = 0;
    static int pow = 0;
    public long solution(long n) {
        String.valueOf(n).chars().sorted().forEach(it -> sum += (it - '0') * pow(10, pow++));
        return sum;
    }
}
```

