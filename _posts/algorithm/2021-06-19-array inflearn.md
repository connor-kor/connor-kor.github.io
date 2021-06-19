---
title: 배열 강의
category: algorithm
---

## 보이는 학생

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

## 가위바위보

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

