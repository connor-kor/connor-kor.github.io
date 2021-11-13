---
title: 오라클 프로젝트
category: project_fullstack
---

**LISTAGG 예제**

```sql
SELECT DISTINCT job,   LISTAGG( empno, '/' ) WITHIN GROUP( ORDER BY empno )  OVER( PARTITION BY job ) 
FROM emp;
-- 예제 1)
SELECT DISTINCT deptno
,   LISTAGG( empno, '/' ) WITHIN GROUP( ORDER BY empno )  OVER( PARTITION BY deptno ) empnos
FROM emp
ORDER BY deptno ASC;

-- 예제 2)
WITH FRU AS (
SELECT 1 AS FID, '딸기' AS FNAME FROM DUAL
UNION ALL
SELECT 2 AS FID, '사과' AS FNAME FROM DUAL
UNION ALL
SELECT 3 AS FID, '바나나' AS FNAME FROM DUAL
)
SELECT LISTAGG(FNAME, '/') WITHIN GROUP(ORDER BY fname ASC) fname
FROM FRU;
```

**계정의 테이블 모두 삭제**

```sql
SELECT  'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;'
FROM    user_objects
WHERE   object_type = 'TABLE';
```

**제약조건 제거**

```sql
-- 제약조견명 찾기
SELECT * 
FROM user_constraints
WHERE table_name = 'NF_ACCOUNT';

-- NF_ACCUONT 에서 PHONE_NUM 의 NOT NULL 제약조건 삭제
ALTER TABLE nf_account
DROP CONSTRAINT sys_c009422;
```

**시퀀스 0부터 시작**

```sql
CREATE SEQUENCE sq_acc
MINVALUE 0;
```

> START WITH 를 0 으로하면 MINVALUE 보다 작을 수 없다는 에러가 뜬다.

## 회원가입

**[회원가입 프로시저]**

작성날짜: 11.13

**(1) 카드**

```sql
CREATE OR REPLACE PROCEDURE ins_signup_with_card (
    p_email          VARCHAR2
    , p_password     VARCHAR2
    , p_bank         VARCHAR2
    , p_cardno       NUMBER
    , p_expired_date NUMBER
    , p_name         VARCHAR2
    , p_birth_year   NUMBER
    , p_birth_month  NUMBER
    , p_birth_date   NUMBER
    , p_membrship_id NUMBER
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    v_acc_id := lpad(sq_acc.NEXTVAL, 6, 0);
    
    -- 계정 테이블
    INSERT INTO nf_account (acc_id, email, password, pay_id)
        VALUES (v_acc_id, p_email, p_password, 1);
        
    -- 신용카드 테이블
    INSERT INTO creditCard 
        VALUES (v_acc_id, p_bank, p_cardno, p_expired_date , p_name                  
        , p_birth_year || p_birth_month || p_birth_date);
    
    -- 계정 멤버십 정보 테이블
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id );
                    
    COMMIT;
    dbms_output.put_line('카드로 회원가입에 성공했습니다.');    
END; 
```



> DATE 타입에 INSERT 할 때 `pBirthYear || pBirthMonth || pBirthDate` 와 같이 to_date 가 필요없다.

실행

```sql
EXEC ins_signup_with_card('mea_95@naver.com' , '12341234', '국민', 63960204058792 , 1222 , '라이언' , 1995 , 11 , 29, 3);
```

> 여러 줄로 나눠서 실행하면 오류가 난다.
>
> EXEC 에서 주석도 작성할 수 없다.

**(2) 카카오페이**

```sql
CREATE OR REPLACE PROCEDURE ins_signup_with_kakao (
    p_email           VARCHAR2
    , p_password      VARCHAR2
    , p_phone_num     VARCHAR2
    , p_membrship_id  NUMBER
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    v_acc_id := lpad(sq_acc.NEXTVAL, 6, 0);
    
    -- 계정 테이블
    INSERT INTO nf_account
        VALUES (v_acc_id, p_phone_num, p_email, p_password, 2);
        
    -- 카카오 테이블
    INSERT INTO kakaopay 
        VALUES (v_acc_id);
    
    -- 계정 멤버십 정보 테이블
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id);
                    
    COMMIT;
    dbms_output.put_line('카카오계정으로 회원가입에 성공했습니다.');        
END; 
```



실행

```sql
EXEC ins_signup_with_kakao('kor.turtle@gmail.com', 'abc6789', '010-9427-2830', 1);
```

**(3) 통신사**

```sql
-- 통신사 회원가입 프로시저
CREATE OR REPLACE PROCEDURE ins_signup_with_mobile (
    p_email           VARCHAR2
    , p_password      VARCHAR2
    , p_phone_num     VARCHAR2
    , p_membrship_id  NUMBER
    , p_mname         VARCHAR2
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    v_acc_id := lpad(sq_acc.NEXTVAL, 6, 0);
    
    -- 계정 테이블
    INSERT INTO nf_account
        VALUES (v_acc_id, p_phone_num, p_email, p_password, 3);
        
    -- 통신사 테이블
    INSERT INTO mobile 
        VALUES (v_acc_id, p_mname);
    
    -- 계정 멤버십 정보 테이블
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id);
                    
    COMMIT;
    dbms_output.put_line('통신사로 회원가입에 성공했습니다.');            
END; 
```



실행

```sql
EXEC ins_signup_with_mobile('kor.allen@gmail.com', 'tiger7777', '010-1541-2830', 2, 'LGUPLUS');
```

## 계정삭제

```sql
```





## 로그인

```
디바이스 등록정보가 이미 있습니다.
로그인에 성공했습니다.

디바이스를 저장했습니다.
로그인에 성공했습니다.
```



```sql
CREATE OR REPLACE PROCEDURE set_signin (
    p_mac_id    CHAR
    , p_device  VARCHAR2
    , p_acc_id  NUMBER
)
IS 
    exists_bool VARCHAR2(5);
BEGIN
    SELECT CASE WHEN EXISTS (SELECT * FROM streaming_dev WHERE mac_id = p_mac_id) 
            THEN 'true'
            ELSE 'false'
            END
        INTO exists_bool
    FROM dual;
    
    IF (exists_bool = 'false') THEN
        INSERT INTO streaming_dev
        VALUES (p_mac_id, p_device, p_acc_id);
        dbms_output.put_line('디바이스를 저장했습니다.');
    ELSE 
        dbms_output.put_line('디바이스 등록정보가 이미 있습니다.');
    END IF;

    COMMIT;    
    dbms_output.put_line('로그인에 성공했습니다.');
END; 
```

**EXISTS**

> MS-SQL 처럼 IF 문 안에 EXISTS 를 사용할 수 없다.

**mac_id 존재여부 확인**

```sql
SELECT 'true'
FROM dual
WHERE EXISTS (SELECT * FROM streaming_dev WHERE mac_id = '12-13-23-24-34-45');
```



**SELECT CASE WHEN EXISTS**

```sql
SELECT CASE WHEN EXISTS (SELECT * FROM streaming_dev WHERE mac_id = p_mac_id) 
        THEN 'true'
        ELSE 'false'
        END
    INTO exists_bool
FROM dual;
```

