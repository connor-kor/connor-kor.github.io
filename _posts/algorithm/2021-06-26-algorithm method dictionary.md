---
title: 알고리즘함수 사전 (편집중..)
category: algorithm
---

## String 

| str         | parameter                           | function                             | note                         |
| ----------- | ----------------------------------- | ------------------------------------ | ---------------------------- |
| toUpperCase | ()                                  | 대문자로 반환                        |                              |
| toLowerCase | ()                                  | 소문자로 반환                        |                              |
| toCharArray | ()                                  | 배열에 넣음                          |                              |
| indexOf     | (String) or int                     | 첫 번째 인덱스 반환                  | 중복제거                     |
| substring   | (beginIndex) (beginIndex, endIndex) | 슬라이스                             | 갯수 (endIndex - startIndex) |
| replace     | (oldChar, newChar)                  | 변환                                 |                              |
| equals      | (Object)                            | 값이 같은지 확인                     |                              |
| split       | (String 구분자) (String, int)       | 구분하여 배열반환<br />배열크기 지정 |                              |

| String  | parameter              | function      | note          |
| ------- | ---------------------- | ------------- | ------------- |
| valueOf | (char[]) or everything | 문자열로 반환 | 문자배열 출력 |

## Character 

| Character    | parameter     | function             | note |
| ------------ | ------------- | -------------------- | ---- |
| toUpperCase  | (char)        | 대문자로 반환        |      |
| toLowerCase  | (char)        | 소문자로 반환        |      |
| isAlphabetic | (char) or int | 알파벳이면 true 반환 |      |
| isDigit      | (char) or int | 숫자이면 true 반환   |      |



## Integer

| Integer  | parameter                | function                                | note |
| -------- | ------------------------ | --------------------------------------- | ---- |
| parseInt | (String) (String, int n) | 숫자로 반환<br />n 진수를 10진수로 반환 |      |

# 자료구조 

## Array (length)

| Array    | parameter  | function         | note |
| -------- | ---------- | ---------------- | ---- |
| length   | 괄호없음   | 배열길이 반환    |      |
| clone    | (같은타입) | 복사             |      |
| equals   | (Object)   | 요소 같으면 true |      |
| toString |            |                  |      |

## ArrayList  (add, get, set, remove, size)

| ArrayList   | parameter              | function                 | note |
| ----------- | ---------------------- | ------------------------ | ---- |
| add         | (int) (index, element) | 추가 후 true 반환        |      |
| set         | (index, element)       | 기존값 반환 후 수정      |      |
| get         | (index)                | 반환                     |      |
| remove      | (index)                | 기존값 반환 후 제거      |      |
| clear       | ()                     | 모든요소 제거            |      |
| size        | ()                     | 배열크기 반환            |      |
| indexOf     | (Object)               | 첫 번째 인덱스값 반환    |      |
| lastIndexOf | (Object)               | 마지막 인덱스값 반환     |      |
| isEmpty     | ()                     | 배열이 비었을 때 true    |      |
| sort        | (null)                 | 배열을 오름차순으로 변경 |      |

## LinkedList 

| LinkedList  | parameter | function | note |
| ----------- | --------- | -------- | ---- |
| addFirst    |           |          |      |
| addLast     |           |          |      |
| getFirst    |           |          |      |
| getLast     |           |          |      |
| removeFirst |           |          |      |
| removeLast  |           |          |      |

## HashMap  (put, get, remove)

| HashMap      | parameter      | function                                         | note          |
| ------------ | -------------- | ------------------------------------------------ | ------------- |
| put          |                |                                                  |               |
| get          |                |                                                  |               |
| getOrDefault | (key, default) | value 값 반환<br />값이 없는경우 default 값 반환 |               |
| remove       |                |                                                  |               |
| keySet       |                |                                                  | for-each 구문 |

## TreeMap

# ETC

## Scanner

