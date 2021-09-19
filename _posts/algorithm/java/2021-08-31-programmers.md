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

