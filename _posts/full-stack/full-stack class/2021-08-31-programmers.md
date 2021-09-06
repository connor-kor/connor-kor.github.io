---
title: 프로그래머스
category: fullstack-class
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

