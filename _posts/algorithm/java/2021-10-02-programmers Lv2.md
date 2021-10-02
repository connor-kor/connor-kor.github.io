---
title: 프로그래머스 Lv1 2페이지
category: java
---

## 1. 같은 숫자는 싫어

4점

**문제 설명**

배열 arr가 주어집니다. 배열 arr의 각 원소는 숫자 0부터 9까지로 이루어져 있습니다. 이때, 배열 arr에서 연속적으로 나타나는 숫자는 하나만 남기고 전부 제거하려고 합니다. 단, 제거된 후 남은 수들을 반환할 때는 배열 arr의 원소들의 순서를 유지해야 합니다. 예를 들면,

- arr = [1, 1, 3, 3, 0, 1, 1] 이면 [1, 3, 0, 1] 을 return 합니다.
- arr = [4, 4, 4, 3, 3] 이면 [4, 3] 을 return 합니다.

배열 arr에서 연속적으로 나타나는 숫자는 제거하고 남은 수들을 return 하는 solution 함수를 완성해 주세요.

**입출력 예**

| arr             | answer    |
| --------------- | --------- |
| [1,1,3,3,0,1,1] | [1,3,0,1] |
| [4,4,4,3,3]     | [4,3]     |

**숏코딩**

```java
public class Solution {
    public int[] solution(int []arr) {
    	ArrayList<Integer> list = new ArrayList<>(Arrays.asList(arr[0]));

    	for (int i = 0; i < arr.length - 1; i++) {
			if (arr[i] != arr[i + 1]) list.add(arr[i + 1]);
		}
        return list.stream().mapToInt(i -> i).toArray();
    }
}
```

**코드**

```java
public class Solution {
    public int[] solution(int []arr) {
        int[] answer = new int[arr.length];
        answer[0] = arr[0];
        int idx = 1;

        for (int i = 0; i < arr.length - 1; i++) {
			if (arr[i] != arr[i + 1]) answer[idx++] = arr[i + 1];
		}
        return Arrays.copyOf(answer, idx);
    }
}
```

## 2. 문자열 다루기 기본

8점

**문제 설명**

문자열 s의 길이가 4 혹은 6이고, 숫자로만 구성돼있는지 확인해주는 함수, solution을 완성하세요. 예를 들어 s가 "a234"이면 False를 리턴하고 "1234"라면 True를 리턴하면 됩니다.

**입출력 예**

| s      | return |
| ------ | ------ |
| "a234" | false  |
| "1234" | true   |

**코드**

```java
public class Solution {
    public boolean solution(String s) {
    	return s.matches("\\d{4}|\\d{6}");
    }
}
```

## 3. 소수찾기

10점

**문제 설명**

1부터 입력받은 숫자 n 사이에 있는 소수의 개수를 반환하는 함수, solution을 만들어 보세요.

소수는 1과 자기 자신으로만 나누어지는 수를 의미합니다.
(1은 소수가 아닙니다.)

**입출력 예**

| n    | result |
| ---- | ------ |
| 10   | 4      |
| 5    | 3      |

**코드**

```java
public class Solution {
    public int solution(int n) {
        int count = 0;
        
        for (int i = 2; i <= n; i++)
			if (isPrime(i)) count++;
        return count;
    }

	private boolean isPrime(int num) {
		for (int i = 2; i <= Math.sqrt(num); i++)
			if (num % i == 0) return false;
		return true;
	}
}	
```

## 4. 두 정수 사이의 합

2점

**문제 설명**

두 정수 a, b가 주어졌을 때 a와 b 사이에 속한 모든 정수의 합을 리턴하는 함수, solution을 완성하세요.
예를 들어 a = 3, b = 5인 경우, 3 + 4 + 5 = 12이므로 12를 리턴합니다.

**입출력 예**

| a    | b    | return |
| ---- | ---- | ------ |
| 3    | 5    | 12     |
| 3    | 3    | 3      |
| 5    | 3    | 12     |

**숏코딩**

등차수열의 합 공식: $$S_n = \frac{n(a_1 + X)}2$$

n: 항의 개수

$$a_1$$: 첫 항

X: 마지막 항

```java
public class Solution {
    public long solution(int a, int b) {
        return (long) (Math.abs(b-a)+1)*(a+b)/2;
    }
}
```

**코드**

```java
public class Solution {
    public long solution(int a, int b) {
        long sum = 0;
        
        for (int i = a > b ? b : a; i <= (a > b ? a : b); i++) sum += i;
        return sum;
    }
}
```

## 5. 직업군 추천하기

틀린문제

**직업군 언어 점수**

![image-20210924223928987](../../../assets/images/image-20210924223928987.png)

**table 문자배열**

```
["SI JAVA JAVASCRIPT SQL PYTHON C#", 
"CONTENTS JAVASCRIPT JAVA PYTHON SQL C++", 
"HARDWARE C C++ PYTHON JAVA JAVASCRIPT", 
"PORTAL JAVA JAVASCRIPT PYTHON KOTLIN PHP", 
"GAME C++ C# JAVASCRIPT C JAVA"]
```

**languages 문자배열**

```
["PYTHON", "C++", "SQL"]
```

**개선된 코드**

```java
public class Solution {
    public String solution(String[] table, String[] languages, int[] preference) {
    	String answer = "";
        int max = 0;
        String[][] jobs = new String[5][6];
        Arrays.sort(table, Collections.reverseOrder());
        
        for (int i = 0; i < table.length; i++) {
			jobs[i] = table[i].split(" ");
		}

        for (String[] job : jobs) {
        	int sum = 0;
        	int idx = 0;
        	for (String l : languages) {
        		for (int i = 1; i < job.length; i++) {
        			if (job[i].equals(l)) {
        				sum += (6 - i) * preference[idx++];
        				break;
        			}
        		}
			}
        	if (max <= sum) {
        		max = sum;
        		answer = job[0];
        	}
		}
        return answer;
    }
}
```

**코드**

```java
public class Solution {
    public String solution(String[] table, String[] languages, int[] preference) {
        String answer = "";
        int sum;
        String[][] scores = new String[5][5];
        int max = 0;
        Arrays.sort(table, Collections.reverseOrder());
        
        for (int i = 0; i < table.length; i++) {
			scores[i] = table[i].split(" ");
		}

        for (int i = 0; i < scores.length; i++) {
        	sum = 0;
        	
        	for (int j = 0; j < languages.length; j++) {
        		for (int k = 1; k < scores.length; k++) {
        			if (languages[j].equals(scores[i][k])) {
        				sum += (6 - k) * preference[j];
        				break;
        			}
        		}
        	}
        	if (max <= sum) {
        		max = sum;
        		answer = scores[i][0];
        	}
        	System.out.println(sum);
		}
        
        System.out.println(Arrays.toString(scores[0]));
        System.out.println(Arrays.toString(scores[1]));
        System.out.println(Arrays.toString(scores[2]));
        System.out.println(Arrays.toString(scores[3]));
        System.out.println(Arrays.toString(scores[4]));
        return answer;
    }
}
```

**배열의 내림차순 정렬**

```java
Arrays.sort(table, Collections.reverseOrder());
```

## 6. 최소직사각형 (8주차)

2점

**문제 설명**

명함 지갑을 만드는 회사에서 지갑의 크기를 정하려고 합니다. 다양한 모양과 크기의 명함들을 모두 수납할 수 있으면서, 작아서 들고 다니기 편한 지갑을 만들어야 합니다. 이러한 요건을 만족하는 지갑을 만들기 위해 디자인팀은 모든 명함의 가로 길이와 세로 길이를 조사했습니다.

아래 표는 4가지 명함의 가로 길이와 세로 길이를 나타냅니다.

| 명함 번호 | 가로 길이 | 세로 길이 |
| --------- | --------- | --------- |
| 1         | 60        | 50        |
| 2         | 30        | 70        |
| 3         | 60        | 30        |
| 4         | 80        | 40        |

가장 긴 가로 길이와 세로 길이가 각각 80, 70이기 때문에 80(가로) x 70(세로) 크기의 지갑을 만들면 모든 명함들을 수납할 수 있습니다. 하지만 2번 명함을 가로로 눕혀 수납한다면 80(가로) x 50(세로) 크기의 지갑으로 모든 명함들을 수납할 수 있습니다. 이때의 지갑 크기는 4000(=80 x 50)입니다.

모든 명함의 가로 길이와 세로 길이를 나타내는 2차원 배열 sizes가 매개변수로 주어집니다. 모든 명함을 수납할 수 있는 가장 작은 지갑을 만들 때, 지갑의 크기를 return 하도록 solution 함수를 완성해주세요.

**입출력 예**

| sizes                                         | result |
| --------------------------------------------- | ------ |
| [[60, 50], [30, 70], [60, 30], [80, 40]]      | 4000   |
| [[10, 7], [12, 3], [8, 15], [14, 7], [5, 15]] | 120    |
| [[14, 4], [19, 6], [6, 16], [18, 7], [7, 11]] | 133    |

**코드**

```java
public class Solution {
    public int solution(int[][] sizes) {
        for (int[] size : sizes) if (size[0] < size[1]) rotate(size);
        return Arrays.stream(sizes).max(Comparator.comparingInt(it -> it[0])).get()[0]
        		* Arrays.stream(sizes).max(Comparator.comparingInt(it -> it[1])).get()[1];
    }

	private void rotate(int[] size) {
		int temp = size[0];
		size[0] = size[1];
		size[1] = temp;
	}
}
```

배열이 가로세로가 바뀌었다면 다음과 같은 코드도 짤 수 있다.

```java
return Arrays.stream(sizes[0]).max().getAsInt()
        * Arrays.stream(sizes[1]).max().getAsInt();
```

## 7. 수박수박수박수박수박수?

작성날짜: 9.23

**문제 설명**

길이가 n이고, "수박수박수박수...."와 같은 패턴을 유지하는 문자열을 리턴하는 함수, solution을 완성하세요. 예를들어 n이 4이면 "수박수박"을 리턴하고 3이라면 "수박수"를 리턴하면 됩니다.

**제한 조건**

- n은 길이 10,000이하인 자연수입니다.

**입출력 예**

| n    | return     |
| ---- | ---------- |
| 3    | "수박수"   |
| 4    | "수박수박" |

**개선된 코드**

```java
class Solution {
	public String solution(int n) {
		StringBuffer str = new StringBuffer();

		for (int i = 0; i < n/2; i++) str.append("수박");
		if (n % 2 == 1) str.append("수");
		return str.toString();
	}
}
```

**코드**

```java
class Solution {
	public String solution(int n) {
		StringBuffer str = new StringBuffer();

		for (int i = 0; i < n; i++) str.append(i % 2 == 0 ? "수" : "박");
		return str.toString();
	}
}
```

## 8. 문자열을 정수로 바꾸기

작성날짜: 10/2	

1점

**문제 설명**

문자열 s를 숫자로 변환한 결과를 반환하는 함수, solution을 완성하세요.

**제한 조건**

- s의 길이는 1 이상 5이하입니다.
- s의 맨앞에는 부호(+, -)가 올 수 있습니다.
- s는 부호와 숫자로만 이루어져있습니다.
- s는 "0"으로 시작하지 않습니다.

**입출력 예**

예를들어 str이 "1234"이면 1234를 반환하고, "-1234"이면 -1234를 반환하면 됩니다.
str은 부호(+,-)와 숫자로만 구성되어 있고, 잘못된 값이 입력되는 경우는 없습니다.

> 함수를 사용하면 쉽게 풀 수 있지만 알고리즘을 연습하기위한 좋은 방법은 아닙니다.

**함수사용 코딩**

```java
public class Solution {
    public int solution(String s) {
    	return Integer.parseInt(s);
    }
}
```

**parseInt 없는 코드**

```java
public class Solution {
    public int solution(String s) {
    	String absStr = s.matches("[+-].+") ? s.substring(1) : s;
    	int figures = (int) Math.pow(10, absStr.length() - 1);
    	int abs = 0;
    	
    	for (char c : absStr.toCharArray()) {
    		abs += figures * (c - '0');
    		figures /= 10;
		}
    	return s.startsWith("-") ? -abs : abs;
    }
}
```

