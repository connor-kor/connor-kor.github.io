---
title: 자바스크립트 강의
category: javascript
---

# 웹과 자바스크립트

우클릭 - 검사

Elements: 태그들이 있다.

JavaScript 는 사용자와 상호작용하는 언어

## 스크립트와 이벤트

script 태그에 사이에 자바스크립트 코드를 넣는다.

`<script>` 

`<input type="button" value="버튼"` 버튼태그

- `onclick="alert('hi')"` 클릭 시 이벤트

`<input type="text"` 입력창

- `onchange="alert('changed')"` 값 변경 이벤트
- `onkeydown="alert('key down')"` 버튼입력 (혹은 지우기) 이벤트

## 데이터타입

자바스크립트의 데이터타입에 대해 설명합니다.

**숫자**

> 콘솔에서 계산기를 사용할 수 있다.

**문자**

| str         | parameter | function                   |
| ----------- | --------- | -------------------------- |
| length      |           | 길이 반환                  |
| toUpperCase | ()        | 대문자 반환                |
| indexOf     | (String)  | 인덱스 반환<br />없으면 -1 |
| trim        | ()        | 공백 제거                  |

**변수**

`var` variable

---

**참고**

<https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String>


## CSS 기초와 선택자

css 의 속성: property

`<h1`

- `style="color:powderblue"` 

`<div` 어떠한 의미도 없는 태그: 자동 줄바꿈이 된다.

`<span` 의미없는 태그: 자동 줄바꿈이 없다.

- `style="font-weight:bold;"` 
- `class="js"` . 으로 호출: 여러대상을 그루핑합니다.
  `.js` 를 클래스선택자 (class selector) 라고합니다.
- `id="first"`  # 으로 호출: 한가지 대상을 식별합니다. id 를 우선시합니다.
  `#first` 를 id 선택자 (id selector) 라고 합니다.

**클래스명이 js 인  태그들의 스타일 변경**

```html
<style>
    .js{
	font-weight: bold;
	color: red;
    }
    #first{
        color: green;
    }
    span{
        color: blue;
    }
</style>
```

> 우선순위: id > class > span

`query` 질의하다.

```html
<input type="button" value="night" onclick="
    document.querySelector(selectors)
">
```

`document.querySelector(selectors);` 

**버튼클릭으로 배경바꾸기**

```html
<input type="button" value="검정배경" onclick="
    document.body.style.backgroundColor='black';
">
```

`document.querySelector('body').style.backgroundColor='black';` 같은 구문이다.

> 이벤트에서 `document` 를 사용해 자바스크립트를 작성할 수 있다.
>
> 스타일에서 css 선택자를 사용한다.

---

**참고**

<https://developer.mozilla.org/ko/docs/Web/API/Document/querySelector>

# 제어문

date: 06.28

---

JavaScript 는 컴퓨터언어이며 프로그래밍 언어이다.

HTML 은 컴퓨터언어이지만 프로그래밍 언어가 아니다.

program: 순서를 만드는 것

programer: 순서를 만드는 사람

## 조건문

conditional statements

**JavaScript**

`===` 비교연산자 (Comparison operator)

- java: `==` 

`<br>` 줄바꿈

- Java: `\n` 

> Java 와 동일한 것들: 부등호, if문

```html
<script>
document.write(1===1);
</script>
```

**HTML**

`&lt;` < : 왼쪽으로 꺽쇠

`&gt;` > : 오른쪽으로 꺽쇠

> Java 와 동일한 것들: if문

> QuerySelector 에는 작은 따옴표 ( ' ' )
> 모든 곳에 큰 따옴표가 아닌 작은 따옴표를 사용할 것!!
> Java 는 문자에 작은따옴표 문자열에 큰따옴표를 사용하는 것과 다르다.

**토글연습 예제**

```html
<body>
  <h1>토글연습</h1>
  <input id="toggle" type="button" value="Black theme" onclick="
  if(document.querySelector('#toggle').value === 'Black theme'){
    body.style.backgroundColor = 'black';
    // document.querySelector('body').style.backgroundColor = 'black'; 같은코드입니다.
    body.style.color = 'white';
    document.querySelector('#toggle').value = 'White theme';
  }else{
    body.style.backgroundColor = 'white';
    body.style.color = 'black';
    document.querySelector('#toggle').value = 'Black theme';
  }
  ">
  <br>
  <br>
  hello world!!
</body>
```

# 코드사전

**HTML**

| <input    | properties                    |
| --------- | ----------------------------- |
| type      | button, text                  |
| value     | 글                            |
| onclick   | 자바스크립트 코드             |
| onchange  | 값 변경 이벤트                |
| onkeydown | 버튼입력 (혹은 지우기) 이벤트 |

`<div>`

`<span>` 

**CSS**

| style       | properties |
| ----------- | ---------- |
| color       |            |
| class       |            |
| id          |            |
| font-weight |            |

**JavaScript**

| document                          | properties                                              |
| --------------------------------- | ------------------------------------------------------- |
| write                             | 글                                                      |
| body.style.backgroundColor        | 스타일변경                                              |
| querySelector(selectors)          | ex) '#night_day': id 가 night_day 인 쿼리를 반환합니다. |
| querySelector(selectors).value    | value 값 반환                                           |
| querySelector('body').style.color |                                                         |

| event     | properties  |
| --------- | ----------- |
| alert('') | 경고창 출력 |

