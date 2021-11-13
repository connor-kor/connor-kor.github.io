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

**[회원가입 프로시저]**

```sql
-- 카드 회원가입 프로시저
CREATE OR REPLACE PROCEDURE ins_signup_with_card (
    pEmail          VARCHAR2
    , pPassword     VARCHAR2
    , pCardno       NUMBER
    , pExpiredDate  NUMBER
    , pName         VARCHAR2
    , pBirthYear    NUMBER
    , pBirthMonth   NUMBER
    , pBirthDate    NUMBER
    , pBank         VARCHAR2
)
IS 
    vAccId          VARCHAR(6);
BEGIN
    vAccId := lpad(sq_acc.NEXTVAL, 6, 0);
    
    -- 계정 테이블
    INSERT INTO nf_account (acc_id, email, password, pay_id)
        VALUES (vAccId, pEmail, pPassword, 1);
        
    -- 신용카드 테이블
    INSERT INTO creditCard VALUES (vAccId, pBank, pCardno, pExpiredDate, pName         
        , pBirthYear || pBirthMonth || pBirthDate
    );
    
    -- 계정 멤버십 정보
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
                    VALUES (vAccId, sysdate, 1);
                    
    COMMIT;
END; -- ins_signup_with_card
```



> DATE 타입에 INSERT 할 때 `pBirthYear || pBirthMonth || pBirthDate` 와 같이 to_date 가 필요없다.

**회원가입 프로시저 실행**

```sql
EXEC ins_signup_with_card('mea_95@naver.com' , '12341234' , 63960204058792 , 1222 , '라이언' , 1995 , 11 , 29, '국민' );
```

> 여러 줄로 나눠서 실행하면 오류가 난다.
>
> EXEC 에서 주석도 작성할 수 없다.

