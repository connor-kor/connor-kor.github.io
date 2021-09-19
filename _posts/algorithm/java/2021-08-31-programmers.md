---
title: 프로그래머스
category: java
---

## 1. 로또의 최고 순위와 최저 순위

**이중 for문 풀이**

```java
class Solution {
    public int[] solution(int[] lottos, int[] win_nums) {
        int count = 0;
        int zero = 0;
        
        for (int lotto : lottos) {
            for (int win_num : win_nums) {
                if (lotto == win_num) count++;
            }
            if (lotto == 0) zero++;
        }

        int bottomRank = count == 0 ? 6 : 7 - count;
        int topRank = count + zero == 0 ? 6 : 7 - (count + zero);
        return {topRank, bottomRank};
    }
}
```

**Map 풀이**

```java
import java.util.HashMap;

class Solution {
    public int[] solution(int[] lottos, int[] win_nums) {
        HashMap<Integer, Boolean> map = new HashMap<>();
        int zeroCount = 0;

        for(int lotto : lottos) {
            if (lotto == 0) zeroCount++;
            else map.put(lotto, true);
        }

        int sameCount = 0;
        for(int winNum : win_nums) {
            if (map.containsKey(winNum)) sameCount++;
        }

        int minRank = sameCount == 0 ? 6 : 7 - sameCount;
        int maxRank = (sameCount + zeroCount) == 0 ? 6 : 7 - (sameCount + zeroCount);
        return new int[] {maxRank, minRank};
    }
}
```

## 2. 없는 숫자 더하기

1점

**문제 설명**

0부터 9까지의 숫자 중 일부가 들어있는 배열 `numbers`가 매개변수로 주어집니다. `numbers`에서 찾을 수 없는 0부터 9까지의 숫자를 모두 찾아 더한 수를 return 하도록 solution 함수를 완성해주세요.

```java
class Solution {
    public int solution(int[] numbers) {
        int answer = 45;
        for (int i : numbers) {
			answer -= i;
		}
        return answer;
    }
}
```

## 3. 음양 더하기

1점

**문제 설명**

어떤 정수들이 있습니다. 이 정수들의 절댓값을 차례대로 담은 정수 배열 absolutes와 이 정수들의 부호를 차례대로 담은 불리언 배열 signs가 매개변수로 주어집니다. 실제 정수들의 합을 구하여 return 하도록 solution 함수를 완성해주세요.

```java
class Solution {
    public int solution(int[] absolutes, boolean[] signs) {
        int answer = 0;
        
        for (int i = 0; i < absolutes.length; i++) {
            answer += absolutes[i] * (signs[i] ? 1 : -1);
        }
        return answer;
    }
}
```

## 4. 내적

1점

**문제 설명**

길이가 같은 두 1차원 정수 배열 a, b가 매개변수로 주어집니다. a와 b의 [내적](https://en.wikipedia.org/wiki/Dot_product)을 return 하도록 solution 함수를 완성해주세요.

이때, a와 b의 내적은 `a[0]*b[0] + a[1]*b[1] + ... + a[n-1]*b[n-1]` 입니다. (n은 a, b의 길이)

```java
class Solution {
    public int solution(int[] a, int[] b) {
        int answer = 0;
        
        for (int i = 0; i < a.length; i++) {
            answer += a[i] * b[i];
        }
        return answer;
    }
}
```

## 5. 소수 만들기

date 9.19

**문제 설명**

주어진 숫자 중 3개의 수를 더했을 때 소수가 되는 경우의 개수를 구하려고 합니다. 숫자들이 들어있는 배열 nums가 매개변수로 주어질 때, nums에 있는 숫자들 중 서로 다른 3개를 골라 더했을 때 소수가 되는 경우의 개수를 return 하도록 solution 함수를 완성해주세요.

**제한사항**

- nums에 들어있는 숫자의 개수는 3개 이상 50개 이하입니다.
- nums의 각 원소는 1 이상 1,000 이하의 자연수이며, 중복된 숫자가 들어있지 않습니다.

---

**입출력 예**

| nums        | result |
| ----------- | ------ |
| [1,2,3,4]   | 1      |
| [1,2,7,6,4] | 4      |

**입출력 예 설명**

입출력 예 #1
[1,2,4]를 이용해서 7을 만들 수 있습니다.

입출력 예 #2
[1,2,4]를 이용해서 7을 만들 수 있습니다.
[1,4,6]을 이용해서 11을 만들 수 있습니다.
[2,4,7]을 이용해서 13을 만들 수 있습니다.
[4,6,7]을 이용해서 17을 만들 수 있습니다.

**숏코딩**

```java
class Solution {
	public int solution(int[] nums) {
		int count = 0;

		for (int i = 0; i < nums.length - 2; i++) {
			for (int j = i + 1; j < nums.length - 1; j++) {
				for (int k = j + 1; k < nums.length; k++) {
					int sum = nums[i] + nums[j] + nums[k];
					if (isPrime(sum)) count++;
				}
			}
		}
		return count;
	}

	private boolean isPrime(int number) {
		for (int i = 2; i <= Math.sqrt(number); i++) {
			if (number % i == 0) return false;
		}
		return true;
	}
}
```

**메모이제이션**

```java
class Solution {
	public int solution(int[] nums) {
		ArrayList primes = new ArrayList();
		ArrayList nonPrimes = new ArrayList();
		int count = 0;

		for (int i = 0; i < nums.length - 2; i++) {
			for (int j = i + 1; j < nums.length - 1; j++) {
				for (int k = j + 1; k < nums.length; k++) {
					int sum = nums[i] + nums[j] + nums[k];
		
					if (primes.contains(sum)) count++;
					else if (nonPrimes.contains(sum)) {}
					else if (isPrime(sum)) {
						count++;
						primes.add(sum);
					} else nonPrimes.add(sum);
				}
			}
		}
		return count;
	}

	private boolean isPrime(int number) {
		for (int i = 2; i <= Math.sqrt(number); i++) {
			if (number % i == 0) return false;
		}
		return true;
	}
}
```

**설명출력 전체코드**

```java
public class Main {
	public static void main(String[] args) {
		Solution s = new Solution();
		int[] nums = {1, 2, 7, 6, 4, 5};

		System.out.println(s.solution(nums));
	}
}

class Solution {
	public int solution(int[] nums) {
		ArrayList primes = new ArrayList();
		ArrayList nonPrimes = new ArrayList();
		System.out.println(Arrays.toString(nums));
		int count = 0;

		for (int i = 0; i < nums.length - 2; i++) {
			for (int j = i + 1; j < nums.length - 1; j++) {
				for (int k = j + 1; k < nums.length; k++) {
					System.out.printf("%d+%d+%d=%d\n", nums[i], nums[j], nums[k], nums[i] + nums[j] + nums[k]);
					int sum = nums[i] + nums[j] + nums[k];
		
					if (primes.contains(sum)) {
						count++;
						System.out.println("소수배열: " + primes);
						System.out.printf("%d 이 이미 있습니다. count = %d\n", sum, count);
					} else if (nonPrimes.contains(sum)) {
						System.out.println("소수가 아닌 배열: " + nonPrimes);
						System.out.printf("%d 이 이미 있습니다.\n", sum);
						continue;
					}
					else if (isPrime(sum)) {
						count++;
						primes.add(sum);
						System.out.printf("count = %d\n", count);
					} else {
						nonPrimes.add(sum);
					}
				}
			}
		}
		System.out.println();
		return count;
	}

	private boolean isPrime(int number) {
		System.out.println("isPrime 실행");
		for (int i = 2; i <= Math.sqrt(number); i++) {
			if (number % i == 0) return false;
		}
		return true;
	}
}
```

## **6. 크레인 인형뽑기 게임**

8점

**문제 설명**

게임개발자인 "죠르디"는 크레인 인형뽑기 기계를 모바일 게임으로 만들려고 합니다.
"죠르디"는 게임의 재미를 높이기 위해 화면 구성과 규칙을 다음과 같이 게임 로직에 반영하려고 합니다.

![image-20210919182553924](../../../assets/images/image-20210919182553924.png)

게임 화면은 **"1 x 1"** 크기의 칸들로 이루어진 **"N x N"** 크기의 정사각 격자이며 위쪽에는 크레인이 있고 오른쪽에는 바구니가 있습니다. (위 그림은 "5 x 5" 크기의 예시입니다). 각 격자 칸에는 다양한 인형이 들어 있으며 인형이 없는 칸은 빈칸입니다. 모든 인형은 "1 x 1" 크기의 격자 한 칸을 차지하며 **격자의 가장 아래 칸부터 차곡차곡 쌓여 있습니다.** 게임 사용자는 크레인을 좌우로 움직여서 멈춘 위치에서 가장 위에 있는 인형을 집어 올릴 수 있습니다. 집어 올린 인형은 바구니에 쌓이게 되는 데, 이때 바구니의 가장 아래 칸부터 인형이 순서대로 쌓이게 됩니다. 다음 그림은 [1번, 5번, 3번] 위치에서 순서대로 인형을 집어 올려 바구니에 담은 모습입니다.

![image-20210919182622223](../../../assets/images/image-20210919182622223.png)

만약 같은 모양의 인형 두 개가 바구니에 연속해서 쌓이게 되면 두 인형은 터뜨려지면서 바구니에서 사라지게 됩니다. 위 상태에서 이어서 [5번] 위치에서 인형을 집어 바구니에 쌓으면 같은 모양 인형 **두 개**가 없어집니다.

![image-20210919182635887](../../../assets/images/image-20210919182635887.png)

크레인 작동 시 인형이 집어지지 않는 경우는 없으나 만약 인형이 없는 곳에서 크레인을 작동시키는 경우에는 아무런 일도 일어나지 않습니다. 또한 바구니는 모든 인형이 들어갈 수 있을 만큼 충분히 크다고 가정합니다. (그림에서는 화면표시 제약으로 5칸만으로 표현하였음)

게임 화면의 격자의 상태가 담긴 2차원 배열 board와 인형을 집기 위해 크레인을 작동시킨 위치가 담긴 배열 moves가 매개변수로 주어질 때, 크레인을 모두 작동시킨 후 터트려져 사라진 인형의 개수를 return 하도록 solution 함수를 완성해주세요.

**[제한사항]**

- board 배열은 2차원 배열로 크기는 "5 x 5" 이상 "30 x 30" 이하입니다.
- board의 각 칸에는 0 이상 100 이하인 정수가 담겨있습니다.
  - 0은 빈 칸을 나타냅니다.
  - 1 ~ 100의 각 숫자는 각기 다른 인형의 모양을 의미하며 같은 숫자는 같은 모양의 인형을 나타냅니다.
- moves 배열의 크기는 1 이상 1,000 이하입니다.
- moves 배열 각 원소들의 값은 1 이상이며 board 배열의 가로 크기 이하인 자연수입니다.

**입출력 예**

| board                                                        | moves             | result |
| ------------------------------------------------------------ | ----------------- | ------ |
| [[0,0,0,0,0],[0,0,1,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]] | [1,5,3,5,1,2,1,4] | 4      |

**입출력 예에 대한 설명**

**입출력 예 #1**

인형의 처음 상태는 문제에 주어진 예시와 같습니다. 크레인이 [1, 5, 3, 5, 1, 2, 1, 4] 번 위치에서 차례대로 인형을 집어서 바구니에 옮겨 담은 후, 상태는 아래 그림과 같으며 바구니에 담는 과정에서 터트려져 사라진 인형은 4개 입니다.

![image-20210919182702192](../../../assets/images/image-20210919182702192.png)

**코드**

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

## 7. 체육복 (그리디)

15점

**문제 설명**

점심시간에 도둑이 들어, 일부 학생이 체육복을 도난당했습니다. 다행히 여벌 체육복이 있는 학생이 이들에게 체육복을 빌려주려 합니다. 학생들의 번호는 체격 순으로 매겨져 있어, 바로 앞번호의 학생이나 바로 뒷번호의 학생에게만 체육복을 빌려줄 수 있습니다. 예를 들어, 4번 학생은 3번 학생이나 5번 학생에게만 체육복을 빌려줄 수 있습니다. 체육복이 없으면 수업을 들을 수 없기 때문에 체육복을 적절히 빌려 최대한 많은 학생이 체육수업을 들어야 합니다.

전체 학생의 수 n, 체육복을 도난당한 학생들의 번호가 담긴 배열 lost, 여벌의 체육복을 가져온 학생들의 번호가 담긴 배열 reserve가 매개변수로 주어질 때, 체육수업을 들을 수 있는 학생의 최댓값을 return 하도록 solution 함수를 작성해주세요.

**제한사항**

- 전체 학생의 수는 2명 이상 30명 이하입니다.
- 체육복을 도난당한 학생의 수는 1명 이상 n명 이하이고 중복되는 번호는 없습니다.
- 여벌의 체육복을 가져온 학생의 수는 1명 이상 n명 이하이고 중복되는 번호는 없습니다.
- 여벌 체육복이 있는 학생만 다른 학생에게 체육복을 빌려줄 수 있습니다.
- 여벌 체육복을 가져온 학생이 체육복을 도난당했을 수 있습니다. 이때 이 학생은 체육복을 하나만 도난당했다고 가정하며, 남은 체육복이 하나이기에 다른 학생에게는 체육복을 빌려줄 수 없습니다.

**입출력 예**

| n    | lost   | reserve   | return |
| ---- | ------ | --------- | ------ |
| 5    | [2, 4] | [1, 3, 5] | 5      |
| 5    | [2, 4] | [3]       | 4      |
| 3    | [3]    | [1]       | 2      |

**입출력 예 설명**

예제 #1
1번 학생이 2번 학생에게 체육복을 빌려주고, 3번 학생이나 5번 학생이 4번 학생에게 체육복을 빌려주면 학생 5명이 체육수업을 들을 수 있습니다.

예제 #2
3번 학생이 2번 학생이나 4번 학생에게 체육복을 빌려주면 학생 4명이 체육수업을 들을 수 있습니다.

**좋은코드**  

```java
class Solution {
    public int solution(int n, int[] lost, int[] reserve) {
        int[] students = new int[n];
        int answer = n;

        for (int l : lost) 
            students[l-1]--;
        for (int r : reserve) 
            students[r-1]++;

        for (int i = 0; i < students.length; i++) {
            if(students[i] == -1) {
                if(i-1 >= 0 && students[i-1] == 1) {
                    students[i]++;
                    students[i-1]--;
                }else if(i+1 < students.length && students[i+1] == 1) {
                    students[i]++;
                    students[i+1]--;
                }else 
                    answer--;
            }
        }
        return answer;
    }
}
```

**while 문 한개로 작성한 코드** 

```java
class Solution {
	public int solution(int n, int[] lost, int[] reserve) {
		int lostCount = lost.length;
		int lostIdx = 0;
		int reserveIdx = 0;
		Arrays.sort(lost);
		Arrays.sort(reserve);

		while (lostIdx < lost.length && reserveIdx < reserve.length) {
			if (lostIdx + 1 < lost.length && lost[lostIdx + 1] == reserve[reserveIdx]) {
				lostCount--;
				lostIdx += 2;
				reserveIdx++;
			} else if (reserveIdx + 1 < reserve.length && lost[lostIdx] == reserve[reserveIdx + 1]) {
				lostCount--;
				lostIdx++;
				reserveIdx += 2;
			} else if (lost[lostIdx] == reserve[reserveIdx]) {
				lostCount--;
				lostIdx++;
				reserveIdx++;
			} else if (Math.abs(lost[lostIdx] - reserve[reserveIdx]) == 1) {
				lostCount--;
				lostIdx++;
				reserveIdx++;
			} else if (lost[lostIdx] > reserve[reserveIdx]) reserveIdx++;
			else lostIdx++;
		}
		return n - lostCount;
	}
}
```

**여분을 도둑맞은학생 저장 코드** 

```java
class Solution {
    public int solution(int n, int[] lost, int[] reserve) {
    	ArrayList<Integer> extraStolen = new ArrayList<>();
        int lostCount = lost.length;
        int lostIdx = 0;
        int reserveIdx = 0;
        Arrays.sort(lost);
        Arrays.sort(reserve);

        while (lostIdx < lost.length && reserveIdx < reserve.length) {
        	if (lost[lostIdx] > reserve[reserveIdx]) reserveIdx++;
        	else if (lost[lostIdx] < reserve[reserveIdx]) lostIdx++;
        	else {
        		extraStolen.add(lost[lostIdx]);
        		lostIdx++;
        		reserveIdx++;
        		lostCount--;
        	}
        }
        
        lostIdx = 0;
        reserveIdx = 0;
        while (lostIdx < lost.length && reserveIdx < reserve.length) {
        	if (extraStolen.contains(lost[lostIdx])) {
        		lostIdx++;
        		continue;
        	} else if (extraStolen.contains(reserve[reserveIdx])) {
        		reserveIdx++;
        		continue;
        	}
        	
        	if (Math.abs(lost[lostIdx] - reserve[reserveIdx]) == 1) {
        		lostCount--;
        		lostIdx++;
        		reserveIdx++;
        	} else if (lost[lostIdx] > reserve[reserveIdx]) reserveIdx++;
        	else lostIdx++;
        }
        return n - lostCount;
    }
}
```

**HashSet 코드**

## 8. 두 개 뽑아서 더하기

6점

배열 -> ArrayList: Arrays.asList()

ArraysList -> 배열: arr.toArray()

`sumArr.stream().mapToInt(i->i).toArray()` 

**코드**

```java
class Solution {
    public int[] solution(int[] numbers) {
    	ArrayList<Integer> sumArr = new ArrayList<>();
    	
    	for (int i = 0; i < numbers.length - 1; i++) {
    		for (int j = i + 1; j < numbers.length; j++) {
    			int sum = numbers[i] + numbers[j];
    			if (!sumArr.contains(sum)) sumArr.add(sum);
			}
		}
    	sumArr.sort(null);
    	return sumArr.stream().mapToInt(i->i).toArray();
    }
}
```

**HashSet vs TreeSet**

Q. TreeSet 은 HashSet 과 다르게 정렬된다?

A. 
