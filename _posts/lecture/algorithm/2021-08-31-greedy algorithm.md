---
title: 9' 그리디 알고리즘
category: algorithm
---

## 1. 씨름선수

키와 몸무게가 자신보다 모두 큰 사람이 있다면 탈락하고 아니라면 뽑힌다.

해설: 키 순으로 정렬한 다음 몸무게 max 변수를 만들어 인원을 확인한다.

**객체의 속성으로 정렬**

객체의 속성 (attribute) 로 정렬하기 위해서는

1. Comparable 인터페이스를 구현한다.
2. compareTo 메소드의 리턴으로 this.속성 - o.속성 을 입력한다. (오름차순)
3. Collections.sort(리스트)

**결과**

```
height: 178
weight: 90
max: 90
-----
height: 176
weight: 82
max: 90
-----
height: 174
weight: 62
max: 90
-----
height: 170
weight: 91
max: 91
-----
height: 154
weight: 96
max: 96
-----
count: 3
```

**코드**

```java
ArrayList<Player> players = new ArrayList<>();
Player p = new Player(200, 100);
int count = 0;
int max = 0;

// 생성
for (int i = 0; i < 5; i++) {
    players.add(new Player((int) (Math.random() * 50 + 150), (int) (Math.random() * 40 + 60))); 
}

Collections.sort(players);

for (Player player : players) {
    if (max < player.weight) {
        max = player.weight;
        count++;
    }
    System.out.printf("height: %d\nweight: %d\nmax: %d\n-----\n", player.height, player.weight, max);
}

System.out.printf("count: %d", count);

```

## 2. 회의실 배정

**설명**

한 개의 회의실이 있는데 이를 사용하고자 하는 n개의 회의들에 대하여 회의실 사용표를 만들려고 한다.

각 회의에 대해 시작시간과 끝나는 시간이 주어져 있고, 각 회의가 겹치지 않게 하면서 회의실을 사용할 수 있는 최대수의 회의를 찾아라.

단, 회의는 한번 시작하면 중간에 중단될 수 없으며 한 회의가 끝나는 것과 동시에 다음 회의가 시작될 수 있다.

**입력**

첫째 줄에 회의의 수 n(1<=n<=100,000)이 주어진다. 둘째 줄부터 n+1 줄까지 각 회의의 정보가 주어지는데

이것은 공백을 사이에 두고 회의의 시작시간과 끝나는 시간이 주어진다. 회의시간은 0시부터 시작한다.

회의의 시작시간과 끝나는 시간의 조건은 (시작시간 <= 끝나는 시간)입니다.

**출력**

첫째 줄에 최대 사용할 수 있는 회의 수를 출력하여라.

**입력**

```
5
1 4
2 3
3 5
4 6
5 7
```

**출력**

```
2 3
1 4
3 5
4 6
5 7
3
```

**코드**

 ```java
 public class Main {
 	public static void main(String[] args) {
 		Scanner sc = new Scanner(System.in);
 		ArrayList<Conference> conferences = new ArrayList<>();
 		int count = 0;
 		int max = 0;
 
 		int n = sc.nextInt();
 		for (int i = 0; i < n; i++) {
 			int start = sc.nextInt();
 			int end = sc.nextInt();
 			conferences.add(new Conference(start, end));
 		}
 
 		Collections.sort(conferences);
 
 		for (Conference conference : conferences) {
 			System.out.printf("%d %d\n", conference.start, conference.end);
 		}
 		
 		for (Conference conference : conferences) {
 			if (max <= conference.start) {
 				max = conference.end;
 				count++;
 			}
 		}
 		System.out.println(count);
 	}
 }
 
 class Conference implements Comparable<Conference> {
 	int start;
 	int end;
 	
 	public Conference(int start, int end) {
 		this.start = start;
 		this.end = end;
 	}
 
 	@Override
 	public int compareTo(Conference o) {
 		if (this.end != o.end) return this.end - o.end;
 		return this.start - o.start;
 	}
 }
 ```

## 3. 결혼식

**설명**

현수는 다음 달에 결혼을 합니다.

현수는 결혼식 피로연을 장소를 빌려 3일간 쉬지 않고 하려고 합니다.

피로연에 참석하는 친구들 N명의 참석하는 시간정보를 현수는 친구들에게 미리 요구했습니다.

각 친구들은 자신이 몇 시에 도착해서 몇 시에 떠날 것인지 현수에게 알려주었습니다.

현수는 이 정보를 바탕으로 피로연 장소에 동시에 존재하는 최대 인원수를 구하여 그 인원을 수용할 수 있는 장소를 빌리려고 합니다. 여러분이 현수를 도와주세요.

만약 한 친구가 오는 시간 13, 가는시간 15라면 이 친구는 13시 정각에 피로연 장에 존재하는 것이고 15시 정각에는 존재하지 않는다고 가정합니다.

**입력**

첫째 줄에 피로연에 참석할 인원수 N(5<=N<=100,000)이 주어집니다.

두 번째 줄부터 N줄에 걸쳐 각 인원의 오는 시간과 가는 시간이 주어집니다.

시간은 첫날 0시를 0으로 해서 마지막날 밤 12시를 72로 하는 타임라인으로 오는 시간과 가는 시간이 음이 아닌 정수로 표현됩니다.

**출력**

첫째 줄에 피로연장에 동시에 존재하는 최대 인원을 출력하세요.

**입력**

```
5
14 18
12 15
15 20
20 30
5 14
```

**출력**

```
2
```

**코드**

```java
public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		ArrayList<Time> arr = new ArrayList<>();
		int count = 0;
		int max = 0;

		int n = sc.nextInt();
		for (int i = 0; i < n * 2; i++) {
			int time = sc.nextInt();
			arr.add(new Time(time, i % 2 == 0 ? 's' : 'e'));
		}
		Collections.sort(arr);
		
		for (Time obj : arr) {
			count += obj.status == 's' ? 1 : -1;
			if (max < count) max = count;
		}
		System.out.println(max);
	}
}

class Time implements Comparable<Time> {
	int time;
	char status;
	
	public Time(int time, char status) {
		this.time = time;
		this.status = status;
	}

	@Override
	public int compareTo(Time o) {
		if (this.time != o.time) return this.time - o.time;
		return this.status - o.status;
	}
}
```

## 4. 최대 수입 스케줄

작성날짜: 10/3

Priority Queue 응용문제

**설명**

현수는 유명한 강연자이다. N개이 기업에서 강연 요청을 해왔다. 각 기업은 D일 안에 와서 강연을 해 주면 M만큼의 강연료를 주기로 했다.

각 기업이 요청한 D와 M를 바탕으로 가장 많을 돈을 벌 수 있도록 강연 스케쥴을 짜야 한다.

단 강연의 특성상 현수는 하루에 하나의 기업에서만 강연을 할 수 있다.

**입력**

첫 번째 줄에 자연수 N(1<=N<=10,000)이 주어지고, 다음 N개의 줄에 M(1<=M<=10,000)과 D(1<=D<=10,000)가 차례로 주어진다.

**출력**

첫 번째 줄에 최대로 벌 수 있는 수입을 출력한다.

**입력**

```
6
50 2
20 1
40 2
60 3
30 3
30 1
```

**출력**

```
150
```

**코드**

```java
class Solution {
	int solution(int n, int[][] arr) {
		Arrays.sort(arr, (o1, o2) -> o2[1] - o1[1]);
		int max = arr[0][1];
		PriorityQueue<Integer> q = new PriorityQueue<>(Comparator.reverseOrder());
		int income = 0;
		int idx = 0;

		for (int i = max; i >= 1; i--) {
		    for (; idx < arr.length; idx++) {
		        if (arr[idx][1] == i) q.offer(arr[idx][0]); 
		        else break;
		    }
		    if (!q.isEmpty()) income += q.poll();
		}
		return income;
	}
}
```

> Queue 에서 poll() 은 꼭 isEmpty() 와 같이쓰도록 한다. 아니면 런타임에러가 난다.

**입력코드**

```java
public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int[][] arr = new int[n][2];

		for (int i = 0; i < n; i++) 
		    for (int j = 0; j < 2; j++) 
		        arr[i][j] = sc.nextInt();
		
		Solution s = new Solution();
		System.out.println(s.solution(n, arr));
	}
}
```

**다익스트라 알고리즘**

전제: 가중치 값이 음수가 되면 안된다.

PriorityQueue 는 log n 만큼의 시간복잡도가 든다.

