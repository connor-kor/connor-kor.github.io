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
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
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
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
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
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
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

처음에 v_acc_id 를 시퀀스로 했다가 max + 1 로 변경했다.



**실행**

```sql
EXEC ins_signup_with_mobile('kor.allen@gmail.com', 'tiger7777', '010-1541-2830', 2, 'LGUPLUS');
```

## 이메일 변경

```
본인확인 코드를 잘못 입력하셨습니다.

aaaa@naver.com 계정의 이메일을 gildong@naver.com (으)로 변경했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE upd_email (
    p_acc_id          nf_account.acc_id%TYPE
    , confirm_code    NUMBER
    , new_email       nf_account.email%TYPE
)
IS
    v_email         nf_account.email%TYPE;
BEGIN
    SELECT email INTO v_email FROM nf_account WHERE acc_id = p_acc_id;
    
    IF confirm_code = 210818 THEN
        UPDATE nf_account
        SET email = new_email
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' 계정의 이메일을 ' || new_email || ' (으)로 변경했습니다.');
        COMMIT;
    ELSE    
        dbms_output.put_line('본인확인 코드를 잘못 입력하셨습니다.');
    END IF;
END;
```





## 비밀번호 변경

```
비밀번호를 잘못 입력하셨습니다.

cccc@naver.com 계정의 비밀번호를 변경했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE upd_password (
    p_acc_id        nf_account.acc_id%TYPE
    , p_password    nf_account.password%TYPE
    , new_password  nf_account.password%TYPE
)
IS
    v_password      nf_account.password%TYPE;
    v_email         nf_account.email%TYPE;
    
BEGIN
    SELECT password, email INTO v_password, v_email FROM nf_account WHERE acc_id = p_acc_id;
    
    
    IF p_password = v_password THEN
        UPDATE nf_account
        SET password = new_password
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' 계정의 비밀번호를 변경했습니다.');
        COMMIT;
    ELSE    
        dbms_output.put_line('비밀번호를 잘못 입력하셨습니다.');
    END IF;
END;
```

## 휴대폰번호 변경

```
aaaa@naver.com 계정의 휴대폰번호를 
010-3456-7890 에서 010-9427-2835 (으)로 변경했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE upd_phone_num (
    p_acc_id          nf_account.acc_id%TYPE
    , confirm_code    NUMBER
    , new_phone_num   nf_account.phone_num%TYPE
)
IS
    v_email           nf_account.email%TYPE;
    v_phone_num           nf_account.phone_num%TYPE;
BEGIN
    SELECT email, phone_num INTO v_email, v_phone_num FROM nf_account WHERE acc_id = p_acc_id;
    
    IF confirm_code = 210818 THEN
        UPDATE nf_account
        SET phone_num = new_phone_num
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' 계정의 휴대폰번호를 ' 
            || chr(10) || v_phone_num || ' 에서 ' || new_phone_num || ' (으)로 변경했습니다.');
        COMMIT;
    ELSE    
        dbms_output.put_line('본인확인 코드를 잘못 입력하셨습니다.');
    END IF;
END;
```



## 계정삭제

```
없는 계정입니다.

kor.allen@gmail.com 님의 계정을 삭제했습니다.
```



```sql
CREATE OR REPLACE PROCEDURE del_account (p_acc_id NUMBER)
IS 
    v_email     VARCHAR(40);
BEGIN
    SELECT email INTO v_email
    FROM nf_account
    WHERE acc_id = p_acc_id;

    DELETE FROM nf_account WHERE acc_id = p_acc_id;
    COMMIT;
    dbms_output.put_line(v_email || ' 님의 계정을 삭제했습니다.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 계정입니다.');
END;
```



## 로그인

```
죄송합니다.
이 이메일 주소를 사용하는 계정을 찾을 수 없습니다.
다시 시도하시거나 새로운 계정을 등록하세요.

비밀번호를 잘못 입력하셨습니다.
다시 입력하시거나 비밀번호를 재설정하세요.

로그인에 성공했습니다.
디바이스 Apple iPad 를 저장했습니다.

로그인에 성공했습니다.
디바이스 MAC 를 저장했습니다.

로그인에 성공했습니다.
디바이스 MAC 등록정보가 이미 있습니다.
```



```sql
CREATE OR REPLACE PROCEDURE ins_signin (
    p_email         VARCHAR2
    , p_password    VARCHAR2
)
IS
    v_password      VARCHAR2(60 char);
    v_mac_id        CHAR(17);
    exists_bool     VARCHAR2(5);
    v_device        VARCHAR2(50);
    v_acc_id        NUMBER(6);
BEGIN
    -- 로그인
    SELECT password, acc_id INTO v_password, v_acc_id
    FROM nf_account
    WHERE email = p_email;
    
    IF v_password = p_password THEN
        
        -- 디바이스 저장
        SELECT CASE round(dbms_random.value(1, 5))
                WHEN 1 THEN 'iPhone'
                WHEN 2 THEN 'Android'
                WHEN 3 THEN 'PC'
                WHEN 4 THEN 'MAC'
                WHEN 5 THEN 'Apple iPad'
            END INTO v_device
        FROM dual;
        
        dbms_output.put_line('로그인에 성공했습니다.');
        
        SELECT CASE WHEN EXISTS (SELECT * FROM streaming_dev WHERE device = v_device AND acc_id = v_acc_id) 
                THEN 'true'
                ELSE 'false'
                END
            INTO exists_bool
        FROM dual;    
        
        IF (exists_bool = 'false') THEN
            v_mac_id := 
                regexp_replace(
                    regexp_replace(regexp_replace(
                        dbms_random.string('X', 12), '(.{2})(.{2})(.{2})(.{2})(.{2})(.{2})', '\1-\2-\3-\4-\5-\6')
                        , '[G-P]'
                        , round(dbms_random.value(0, 9))
                    ), '[Q-Z]', round(dbms_random.value(0, 9)));           
        
            INSERT INTO streaming_dev
            VALUES (v_mac_id, v_device, v_acc_id);
            dbms_output.put_line('디바이스 ' || v_device || ' 를 저장했습니다.');
        ELSE 
            dbms_output.put_line('디바이스 ' || v_device || ' 등록정보가 이미 있습니다.');
        END IF;
    
        COMMIT;           
    ELSE dbms_output.put_line('비밀번호를 잘못 입력하셨습니다.' 
        || chr(10) || '다시 입력하시거나 비밀번호를 재설정하세요.');
    END IF;
EXCEPTION 
    WHEN no_data_found THEN
        dbms_output.put_line('죄송합니다.' 
            || chr(10) || '이 이메일 주소를 사용하는 계정을 찾을 수 없습니다.' 
            || chr(10) || '다시 시도하시거나 새로운 계정을 등록하세요.');
END;
```

`chr(10)` 줄 바꿈



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



## 프로필 생성

```
키즈 프로필 라이언이(가) 생성됐습니다.

프로필을 어떤 이유로 생성할 수 없습니다. (갯수초과 등)
```



```sql
CREATE OR REPLACE PROCEDURE ins_profile (
    p_acc_id            NUMBER
    , p_pname           VARCHAR2
    , p_kids_profile    VARCHAR2
)
IS
    v_profile_id    VARCHAR2(10);
    v_kids_profile  VARCHAR2(5) := lower(p_kids_profile);
    have_one        NUMBER(1);
BEGIN
    SELECT min(substr(profile_id, 8)) INTO have_one
    FROM nf_profile
    WHERE acc_id = p_acc_id;
    
    -- 1~5 로 프로필 ID 생성 
    IF have_one != 1 THEN
        v_profile_id := 1;
    ELSE 
        SELECT nvl(min(substr(profile_id, 8) + 1), 1)
            INTO v_profile_id
        FROM nf_profile
        WHERE substr(profile_id, 8) + 1 NOT IN (SELECT substr(profile_id, 8) FROM nf_profile WHERE acc_id = p_acc_id)
            AND acc_id = p_acc_id;
    END IF;
    
    v_profile_id := lpad(p_acc_id, 6, 0) || '_' || v_profile_id;
    
    -- 프로필 생성
    IF (lower(p_kids_profile) = 'true') THEN
        INSERT INTO nf_profile (profile_id, pname, kids_profile, acc_id, limit_id)
        VALUES (v_profile_id, p_pname, v_kids_profile, p_acc_id, 3);        
        dbms_output.put_line('키즈 프로필 ' || p_pname || '이(가) 생성됐습니다.');
    ELSE 
        INSERT INTO nf_profile (profile_id, pname, acc_id, limit_id)
        VALUES (v_profile_id, p_pname, p_acc_id, 5);
        dbms_output.put_line('프로필 ' || p_pname || '이(가) 생성됐습니다.');
    END IF;
    
    COMMIT;
EXCEPTION 
    WHEN OTHERS THEN
    dbms_output.put_line('프로필을 어떤 이유로 생성할 수 없습니다. (갯수초과 등)');
END;
```

**빈 숫자 채우는 쿼리**

```sql
    SELECT min(substr(profile_id, 8)) INTO have_one
    FROM nf_profile
    WHERE acc_id = p_acc_id;
    
    -- 1~5 로 프로필 ID 생성 
    IF have_one != 1 THEN
        v_profile_id := 1;
    ELSE 
        SELECT nvl(min(substr(profile_id, 8) + 1), 1)
            INTO v_profile_id
        FROM nf_profile
        WHERE substr(profile_id, 8) + 1 NOT IN (SELECT substr(profile_id, 8) FROM nf_profile WHERE acc_id = p_acc_id)
            AND acc_id = p_acc_id;
    END IF;
```



**[제약조건]**

**형식**

```sql
ALTER TABLE 테이블
MODIFY 칼럼 [데이터타입] [디폴트] [NOT NULL]
```

> 테이블 변경 (디폴트값 변경 등) 은 ROLLBACK 이 되지 않는다.

**디폴트값 변경**

```sql
ALTER TABLE nf_profile MODIFY autoplay_episode DEFAULT 'true';
```

**NOT NULL 제거**

```sql
ALTER TABLE nf_profile MODIFY lang_id NULL;
```

## 프로필 삭제

```
없는 프로필 입니다.

라이언 프로필을 삭제했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE del_account (p_profile_id VARCHAR2)
IS 
    v_pname     VARCHAR2(50);
BEGIN
    SELECT pname INTO v_pname
    FROM nf_profile
    WHERE profile_id = p_profile_id;

    DELETE FROM nf_profile WHERE profile_id = p_profile_id;
    COMMIT;
    dbms_output.put_line(v_pname || ' 프로필을 삭제했습니다.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 프로필 입니다.');
END;
```

## 프로필 변경

```
없는 프로필 입니다.

----------------------------

⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣠⣴⣾⣿⣟⣿⣿⣿⣿⣶⢤⡀⠀⠀⠀⠀
⠀⠀⣠⡞⣷⣟⣻⣿⣿⠁⠸⣻⣿⣿⣿⡽⣆⠀⠀⠀
⠀⢰⠏⣼⢿⣿⣿⣾⠁⠰⡄⠹⣶⣟⡿⣿⡜⣧⠀⠀
⠀⡟⢰⣿⣿⣭⡿⡇⠐⠛⠃⠀⢻⣿⣿⣿⣷⠸⡆⠀
⢰⡇⢸⣟⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⡇⠀
⠀⡇⠸⣿⣿⣾⣻⢿⣿⣿⣾⣛⣿⣿⣿⣶⡟⠀⡇⠀
⠀⢹⡄⢹⣿⣿⣿⣿⣭⣿⣿⣿⣷⣯⣿⣿⠃⡼⠀⠀
⠀⠀⠻⣄⠻⣯⣟⣿⣿⣿⣿⣽⢿⣿⡿⢁⡼⠁⠀⠀
⠀⠀⢀⠜⢷⠝⠛⠻⠿⢿⠿⠿⠻⢯⡴⠿⢄⡀⠀⠀
⠀⡔⠁⢀⡀⠀⠀⠻⠦⣿⣤⠔⠂⠀⠀⡀⠀⠙⢆⠀

tri 아이콘을 다시 사용했습니다.
라이언님의 프로필을 변경했습니다.

프로필이미지:     cir    -> tri
이름:            라이언   -> 춘식이
사이트언어:       Polski -> 한국어
다음화 자동재생:   false  -> true
미리보기 자동재생: false  -> true

----------------------------

⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣠⣴⣾⣿⣟⣿⣿⣿⣿⣶⢤⡀⠀⠀⠀⠀
⠀⠀⣠⡞⣷⣟⣻⣿⣿⠁⠸⣻⣿⣿⣿⡽⣆⠀⠀⠀
⠀⢰⠏⣼⢿⣿⣿⣾⠁⠰⡄⠹⣶⣟⡿⣿⡜⣧⠀⠀
⠀⡟⢰⣿⣿⣭⡿⡇⠐⠛⠃⠀⢻⣿⣿⣿⣷⠸⡆⠀
⢰⡇⢸⣟⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⡇⠀
⠀⡇⠸⣿⣿⣾⣻⢿⣿⣿⣾⣛⣿⣿⣿⣶⡟⠀⡇⠀
⠀⢹⡄⢹⣿⣿⣿⣿⣭⣿⣿⣿⣷⣯⣿⣿⠃⡼⠀⠀
⠀⠀⠻⣄⠻⣯⣟⣿⣿⣿⣿⣽⢿⣿⡿⢁⡼⠁⠀⠀
⠀⠀⢀⠜⢷⠝⠛⠻⠿⢿⠿⠿⠻⢯⡴⠿⢄⡀⠀⠀
⠀⡔⠁⢀⡀⠀⠀⠻⠦⣿⣤⠔⠂⠀⠀⡀⠀⠙⢆⠀

tri 아이콘을 다시 사용했습니다.
춘식이님의 프로필을 변경했습니다.
```



```sql
EXEC set_profile('000003_1', 2, '춘식이', 1, 'TRUE', 'TRUE');
```



```sql
CREATE OR REPLACE PROCEDURE set_profile (
    p_profile_id            VARCHAR2
    , p_icon_id             NUMBER
    , p_pname               VARCHAR2
    , p_lang_id             NUMBER
    , p_autoplay_episode    VARCHAR2
    , p_autoplay_previews   VARCHAR2
) 
IS 
    v_pname                 VARCHAR2(50);
    lang_before                 sitelang_info.lang%TYPE;
    lang_after                 sitelang_info.lang%TYPE;
    v_autoplay_episode                 nf_profile.autoplay_episode%TYPE;
    v_autoplay_previews                 nf_profile.autoplay_previews%TYPE;
    v_id                    NUMBER(38);
    have_icon_b             VARCHAR2(5);  
    ipath_before                 VARCHAR2(30);
    ipath_after                 VARCHAR2(30);
    v_icon_id               VARCHAR2(30);
BEGIN
    -- 변경 전 프로필 정보 가져오기
    SELECT pname, lang, autoplay_episode, autoplay_previews INTO v_pname, lang_before, v_autoplay_episode , v_autoplay_previews
    FROM nf_profile JOIN sitelang_info USING(lang_id)
    WHERE profile_id = p_profile_id;
    SELECT ipath INTO ipath_after FROM icon_info WHERE icon_id = p_icon_id;
    
    -- 변경 후 언어정보 가져오기
    SELECT lang INTO lang_after FROM sitelang_info WHERE lang_id = p_lang_id;

    -- 변경 전 아이콘 가져오기
    SELECT icon_id, ipath INTO v_icon_id, ipath_before 
    FROM (
        SELECT *
        FROM icon_history JOIN icon_info USING(icon_id)
        ORDER BY fix_date DESC)
    WHERE profile_id = p_profile_id
        AND rownum = 1;

    -- 프로필 업데이트
    UPDATE nf_profile
    SET 
        pname = p_pname
        , lang_id = p_lang_id
        , autoplay_episode = lower(p_autoplay_episode)
        , autoplay_previews = lower(p_autoplay_previews)
    WHERE profile_id = p_profile_id;
    
    print_profile(p_icon_id);


    
    SELECT CASE WHEN EXISTS(SELECT * FROM icon_history WHERE profile_id = p_profile_id AND icon_id = p_icon_id) 
        THEN 'true'
        ELSE 'false' END INTO have_icon_b
    FROM dual;
    
    -- 최근에 사용한 아이콘에 등록되있지 않은경우(false) 와 이미 등록된 경우(true)
    IF have_icon_b = 'false' THEN
        SELECT nvl(max(substr(history_id, 10)), 0) + 1 INTO v_id
        FROM icon_history
        WHERE profile_id = p_profile_id;
        
        INSERT INTO icon_history
        VALUES (
            p_profile_id || '_' || v_id
            , p_icon_id
            , p_profile_id
            , sysdate
        );    
        dbms_output.put_line('최근에 사용한 아이콘에 ' || ipath_after || ' 을(를) 저장했습니다.');
    ELSE
        UPDATE icon_history
        SET fix_date = sysdate
        WHERE profile_id = p_profile_id
            AND icon_id = p_icon_id;
        dbms_output.put_line(ipath_after || ' 아이콘을 다시 사용했습니다.');
    END IF;
    
    COMMIT;

    -- 출력
    dbms_output.put_line(v_pname || '님의 프로필을 변경했습니다.' || chr(10));
    
    IF ipath_before != ipath_after THEN
        dbms_output.put_line('프로필이미지:     ' || ipath_before || '    -> ' || ipath_after);
    END IF;
    
    IF v_pname != p_pname THEN
        dbms_output.put_line('이름:            ' || v_pname || '   -> ' || p_pname);
    END IF;
    
    IF lang_before != lang_after THEN
        dbms_output.put_line('사이트언어:       ' || lang_before || ' -> ' || lang_after);
    END IF;
    
    IF v_autoplay_episode != lower(p_autoplay_episode) THEN
        dbms_output.put_line('다음화 자동재생:   ' || v_autoplay_episode || '  -> ' || lower(p_autoplay_episode));
    END IF;
    
    IF v_autoplay_previews != lower(p_autoplay_previews) THEN
        dbms_output.put_line('미리보기 자동재생: ' || v_autoplay_previews || '  -> ' || lower(p_autoplay_previews));
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 프로필 입니다.');
END;
```



### 도트이미지

```sql
CREATE OR REPLACE PROCEDURE print_profile (p_icon_id NUMBER)
IS
    image   VARCHAR2(4000);
BEGIN
    image := CASE p_icon_id
        WHEN 1 THEN
'            
⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠘⣧⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣾⠁⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠹⣧⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⠀⠀⠹⣇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠀
⠀⠀⢠⡞⠛⢻⡆⠀⠀⠀⠀⠀⠀⣴⠟⠙⢷⡄⠀⠀
⠀⠀⠘⢷⣤⡼⠃⠀⠀⠀⠀⠀⠀⠹⢧⣤⡾⠃⠀⠀
⠀⠀⠀⠀⣯⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣿⠀⠀⠀⠀
⠀⠀⠀⠀⡏⠉⠉⢹⡏⠉⠉⢹⠉⠉⠉⣿⠀⠀⠀⠀
⠀⠀⠀⠀⡇⠀⠀⢸⡇⠀⠀⢸⠀⠀⠀⣿⠀⠀⠀⠀
⠀⠰⣆⣀⡇⠀⠀⢸⡇⠀⠀⢸⠀⠀⠀⣿⣀⣶⠀⠀
⠀⠀⠙⠋⠁⠀⠀⣸⠇⠀⠀⢸⡄⠀⠀⠈⠛⠉⠀⠀
⠀⠀⠀⠀⠀⠶⠞⠋⠀⠀⠀⠀⠙⠳⠦⠀⠀⠀⠀⠀
'
        WHEN 2 THEN
'
⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣠⣴⣾⣿⣟⣿⣿⣿⣿⣶⢤⡀⠀⠀⠀⠀
⠀⠀⣠⡞⣷⣟⣻⣿⣿⠁⠸⣻⣿⣿⣿⡽⣆⠀⠀⠀
⠀⢰⠏⣼⢿⣿⣿⣾⠁⠰⡄⠹⣶⣟⡿⣿⡜⣧⠀⠀
⠀⡟⢰⣿⣿⣭⡿⡇⠐⠛⠃⠀⢻⣿⣿⣿⣷⠸⡆⠀
⢰⡇⢸⣟⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⡇⠀
⠀⡇⠸⣿⣿⣾⣻⢿⣿⣿⣾⣛⣿⣿⣿⣶⡟⠀⡇⠀
⠀⢹⡄⢹⣿⣿⣿⣿⣭⣿⣿⣿⣷⣯⣿⣿⠃⡼⠀⠀
⠀⠀⠻⣄⠻⣯⣟⣿⣿⣿⣿⣽⢿⣿⡿⢁⡼⠁⠀⠀
⠀⠀⢀⠜⢷⠝⠛⠻⠿⢿⠿⠿⠻⢯⡴⠿⢄⡀⠀⠀
⠀⡔⠁⢀⡀⠀⠀⠻⠦⣿⣤⠔⠂⠀⠀⡀⠀⠙⢆⠀
'
        WHEN 3 THEN
'
⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⣤⣾⣿⣿⣿⡿⠿⣿⣿⣿⣷⣦⡀⠀⠀⠀
⠀⠀⣠⣿⣿⣿⣿⡿⢡⣶⣶⣦⠹⣿⣿⣿⣿⣆⠀⠀
⠀⢰⣿⣿⣿⣿⣿⣇⢻⣿⣿⣿⢃⣿⣿⣿⣿⣿⣆⠀
⠀⣾⣿⣿⣿⣿⣿⣿⣷⣬⣭⣴⣿⣿⣿⣿⣿⣿⣿⠀
⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀
⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀
⠀⠀⠀⣙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⡀⠀⠀
⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀
'
        WHEN 4 THEN
'
⠀⠀⠀⠀⠀⢀⣠⣴⣶⣶⣶⣶⣶⣤⣀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⣴⣿⣿⣿⠟⠛⠛⠛⢻⣿⣿⣷⣄⠀⠀⠀
⠀⠀⢠⣿⣿⣿⣿⣿⠀⣿⣿⣿⢸⣿⣿⣿⣿⣧⠀⠀
⠀⢀⣿⣿⣿⣿⣿⣿⡀⠛⠛⠛⢸⣿⣿⣿⣿⣿⣇⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀
⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀
⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀
⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀
'
        WHEN 5 THEN
'
⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀
⠀⡐⠡⠒⡌⠆⠀⠀⠀⠀⠀⠀⠀⢠⠫⢂⡜⡆⠀⠀
⠀⠣⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠆⠀⡏⠀⠈⡆⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠂⠀⠀⢸⠓⠊⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⠔⠉⠀⠀⢀⠀⢸⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠐⠁⢀⠀⠤⠄⢈⣧⠀⠆⠀⠀⠀
⠀⠀⠀⠀⠰⡘⠀⠁⠀⠀⠀⠀⠀⠀⠈⠆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠁⠀⠄⠠⠄⢀⠀⠀⠀⠀⠀⠄⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡀⠘⠒⢢⠀⢀⠶⡄⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠀⠈⠉⠁⠀⠀
'
        WHEN 6 THEN
'
⠀⠀⠀⣠⠞⠛⠛⠻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢰⡟⠛⠁⠀⠀⢀⡆⠈⢿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠸⣧⣀⠀⠀⠀⢸⡇⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠙⠻⠿⣷⡄⠈⢿⣶⠟⢻⣦⡀⠀⠀⢀⠀⠀⠀⠀
⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠈⠻⣷⣔⣿⣿⣦⠀⠀
⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠈⢻⡜⣿⠹⡧⠀
⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡿⠀⣿⠀
⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠁⢀⡏⠀
⠀⠀⠀⠀⣾⣅⣀⣀⣀⣀⣀⣀⣀⣀⣀⣠⡴⠋⠀⠀
⠀⠀⠀⠀⠉⠛⠛⠛⠛⠛⠛⠛⠛⠛⠋⠉⠀⠀⠀
'
        WHEN 7 THEN
'
⠀⢀⡾⣷⣤⣤⣤⠾⣷⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀
⠀⣼⠀⠈⠉⠉⠁⠀⢻⡀⠀⠀⠀⠀⢀⡴⠞⣻⠃⠀
⠀⡟⠀⠀⣠⣄⠀⠀⢸⠁⠀⠀⠀⠀⡞⠀⢀⡇⠀⠀
⠀⡇⠀⠐⠛⠛⠂⠀⢻⣦⣀⠀⠀⢸⡇⠀⠸⣇⠀⠀
⠀⣇⠀⠀⠀⠀⠀⠀⠀⠙⠻⣷⣤⠈⣷⠀⠀⢿⡄⠀
⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⣿⡇⠀⠸⡇⠀
⠀⢹⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⠀⠀⡟⠀
⠀⠀⢿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠇⠀⢰⠃⠀
⠀⠀⢸⡋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣀⡴⠃⠀⠀
⠀⠀⠘⠻⠿⠛⠻⠿⠿⠛⠛⠛⠛⠛⠛⠉⠀⠀⠀⠀
'
        WHEN 8 THEN
'
⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢀⣤⣴⠛⠛⠻⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠈⠉⠻⣷⠀⠀⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣿⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡏⠀⠀⣷⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣧⠀⠀⠈⠛⠛⠛⠛⠛⠿⢷⣦⣄⡀⠀⠀⠀
⠀⠀⠀⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⠿⠿⡟
⠀⠀⠀⠘⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⠁
⠀⠀⠀⠀⠀⠙⠿⣷⣤⣄⣠⡀⠀⢀⣀⣠⠶⠋⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢻⡿⠟⠛⠋⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠰⠶⠾⠿⠃⠀⠀⠀⠀⠀⠀⠀
'
        WHEN 9 THEN
'
⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⡀⠀⠀⠀⠀⢀⠀⠀
⠀⠀⠀⠀⢀⣤⠾⠛⠛⠛⠛⠛⠛⠿⣶⣤⡀⢰⣧⠀
⠀⠀⠀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣦⡟⠀
⠀⣠⡼⠁⣴⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀
⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀
⠀⢻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡜⠀⠀
⠀⠀⠙⠿⣷⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠟⠀⠀⠀
⠀⠀⠀⠀⠀⢻⣀⣀⢰⠷⠶⠾⣿⣀⣀⣸⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠘⠛⠛⠋⠀⠀⠀⠘⠛⠛⠋⠀⠀⠀⠀
'
        WHEN 10 THEN
'
⠀⠀⣠⡄⠀⠀⠀⢰⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣠⡿⠻⠒⠒⠶⠞⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠸⠷⢶⠀⠀⠀⠀⢠⡾⠿⠂⣀⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠘⣇⣠⠤⣤⡸⠛⠛⠛⠛⠛⠛⠛⠳⢦⡀⠀⠀
⠀⠀⠀⣅⡀⠀⢀⡹⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⠀
⠀⠀⠀⣯⢉⢭⠉⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⢸⡇⠀
⠀⠀⠀⢻⡜⠛⠃⠀⡇⠀⠀⠀⠀⢸⡄⠀⠀⢿⡇⠀
⠀⠀⠀⠘⡇⢸⡀⠀⣷⣤⣤⣤⣶⡞⢻⣄⢸⡄⠀⠀
⠀⠀⠀⠀⣧⠘⡇⢸⠀⠀⠀⠀⠋⠟⢻⢿⢸⠇⠀⠀
⠀⠀⠀⠀⠛⠛⠛⠋⠀⠀⠀⠀⠀⠀⠀⠚⠛⠀⠀⠀
'    
    END;
    dbms_output.put_line(image);
END;
```



---

참조

https://m.blog.naver.com/pmw9440/221887457915

---



## 시청제한정보 변경

```
없는 프로필 입니다.

비밀번호를 틀렸습니다.

몽룡이 프로필을 변경했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE upd_limit_age (
    p_profile_id        VARCHAR2
    , p_password        VARCHAR2
    , p_limit_id        NUMBER
    , p_kids_profile    VARCHAR2
) 
IS 
    v_pname             VARCHAR2(50);
    v_password          VARCHAR2(60 char);
    v_kids_profile      VARCHAR2(5) := lower(p_kids_profile);
BEGIN
    SELECT pname, password INTO v_pname, v_password 
    FROM nf_profile JOIN nf_account USING(acc_id)
    WHERE profile_id = p_profile_id;
    
    IF p_password = v_password THEN
        UPDATE nf_profile
        SET 
            limit_id = p_limit_id
            , kids_profile = v_kids_profile
        WHERE profile_id = p_profile_id;   
        
        dbms_output.put_line(v_pname || ' 프로필을 변경했습니다.');    
    ELSE dbms_output.put_line('비밀번호를 틀렸습니다.');    
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 프로필 입니다.');
END;
```

## 프로필 언어설정 변경

```
사용자가 Deutsch 로 사이트 표시언어를 변경했습니다.

사용자가 Dansk, français 언어를 컨텐츠 언어로 설정했습니다.

사용자가 Deutsch 로 사이트 표시언어를 변경했습니다.
사용자가 English, Dansk, Nederlands 언어를 컨텐츠 언어로 설정했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE set_profile_language (
    p_profile_id    VARCHAR2
    , L1            NUMBER := NULL
    , L2            NUMBER := NULL
    , L3            NUMBER := NULL
    , L4            NUMBER := NULL
    , L5            NUMBER := NULL
    , L6            NUMBER := NULL
    , L7            NUMBER := NULL
    , L8            NUMBER := NULL
    , L9            NUMBER := NULL
    , L10           NUMBER := NULL
    , L11           NUMBER := NULL
    , L12           NUMBER := NULL
    , L13           NUMBER := NULL
    , L14           NUMBER := NULL
    , L15           NUMBER := NULL
    , L16           NUMBER := NULL
    , p_lang_id     NUMBER := NULL
)
IS
    L1_char         cont_lang.cont_lang%TYPE;
    L2_char         cont_lang.cont_lang%TYPE;
    L3_char         cont_lang.cont_lang%TYPE;
    L4_char         cont_lang.cont_lang%TYPE;
    L5_char         cont_lang.cont_lang%TYPE;
    L6_char         cont_lang.cont_lang%TYPE;
    L7_char         cont_lang.cont_lang%TYPE;
    L8_char         cont_lang.cont_lang%TYPE;
    L9_char         cont_lang.cont_lang%TYPE;
    L10_char         cont_lang.cont_lang%TYPE;
    L11_char         cont_lang.cont_lang%TYPE;
    L12_char         cont_lang.cont_lang%TYPE;
    L13_char         cont_lang.cont_lang%TYPE;
    L14_char         cont_lang.cont_lang%TYPE;
    L15_char         cont_lang.cont_lang%TYPE;
    L16_char         cont_lang.cont_lang%TYPE;
    lang_char        sitelang_info.lang%TYPE;
BEGIN
    IF p_lang_id IS NOT NULL THEN
        UPDATE nf_profile
        SET lang_id = p_lang_id
        WHERE profile_id = p_profile_id;
        
        SELECT lang INTO lang_char FROM sitelang_info WHERE lang_id = p_lang_id;
    END IF;
    
    -- 모든 언어 체크해제
    DELETE FROM pro_cont_lang WHERE profile_id = p_profile_id;
    
    -- 선택한 언어 체크
    IF L1 IS NOT NULL THEN
        INSERT INTO pro_cont_lang
        VALUES (
            p_profile_id || '_' || L1
            , p_profile_id
            , L1);
        SELECT cont_lang INTO L1_char FROM cont_lang WHERE cont_lang_id = L1;
    END IF;
            
    IF L2 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L2, p_profile_id, L2); SELECT cont_lang INTO L2_char FROM cont_lang WHERE cont_lang_id = L2; END IF;
    IF L3 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L3, p_profile_id, L3); SELECT cont_lang INTO L3_char FROM cont_lang WHERE cont_lang_id = L3; END IF;
    IF L4 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L4, p_profile_id, L4); SELECT cont_lang INTO L4_char FROM cont_lang WHERE cont_lang_id = L4; END IF;
    IF L5 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L5, p_profile_id, L5); SELECT cont_lang INTO L5_char FROM cont_lang WHERE cont_lang_id = L5; END IF;
    IF L6 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L6, p_profile_id, L6); SELECT cont_lang INTO L6_char FROM cont_lang WHERE cont_lang_id = L6; END IF;
    IF L7 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L7, p_profile_id, L7); SELECT cont_lang INTO L7_char FROM cont_lang WHERE cont_lang_id = L7; END IF;
    IF L8 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L8, p_profile_id, L8); SELECT cont_lang INTO L8_char FROM cont_lang WHERE cont_lang_id = L8; END IF;
    IF L9 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L9, p_profile_id, L9); SELECT cont_lang INTO L9_char FROM cont_lang WHERE cont_lang_id = L9; END IF;
    IF L10 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L10, p_profile_id, L10); SELECT cont_lang INTO L10_char FROM cont_lang WHERE cont_lang_id = L10; END IF;
    IF L11 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L11, p_profile_id, L11); SELECT cont_lang INTO L11_char FROM cont_lang WHERE cont_lang_id = L11; END IF;
    IF L12 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L12, p_profile_id, L12); SELECT cont_lang INTO L12_char FROM cont_lang WHERE cont_lang_id = L12; END IF;
    IF L13 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L13, p_profile_id, L13); SELECT cont_lang INTO L13_char FROM cont_lang WHERE cont_lang_id = L13; END IF;
    IF L14 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L14, p_profile_id, L14); SELECT cont_lang INTO L14_char FROM cont_lang WHERE cont_lang_id = L14; END IF;
    IF L15 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L15, p_profile_id, L15); SELECT cont_lang INTO L15_char FROM cont_lang WHERE cont_lang_id = L15; END IF;
    IF L16 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L16, p_profile_id, L16); SELECT cont_lang INTO L16_char FROM cont_lang WHERE cont_lang_id = L16; END IF;
    
    IF p_lang_id IS NOT NULL THEN
        dbms_output.put_line('사용자가 ' || lang_char || ' 로 사이트 표시언어를 변경했습니다.');
    END IF;
    
    IF L1 IS NOT NULL THEN dbms_output.put('사용자가 ' || L1_char); END IF;
    IF L2 IS NOT NULL THEN dbms_output.put(', ' || L2_char); END IF;
    IF L3 IS NOT NULL THEN dbms_output.put(', ' || L3_char); END IF;
    IF L4 IS NOT NULL THEN dbms_output.put(', ' || L4_char); END IF;
    IF L5 IS NOT NULL THEN dbms_output.put(', ' || L5_char); END IF;
    IF L6 IS NOT NULL THEN dbms_output.put(', ' || L6_char); END IF;
    IF L7 IS NOT NULL THEN dbms_output.put(', ' || L7_char); END IF;
    IF L8 IS NOT NULL THEN dbms_output.put(', ' || L8_char); END IF;
    IF L9 IS NOT NULL THEN dbms_output.put(', ' || L9_char); END IF;
    IF L10 IS NOT NULL THEN dbms_output.put(', ' || L10_char); END IF;
    IF L11 IS NOT NULL THEN dbms_output.put(', ' || L11_char); END IF;
    IF L12 IS NOT NULL THEN dbms_output.put(', ' || L12_char); END IF;
    IF L13 IS NOT NULL THEN dbms_output.put(', ' || L13_char); END IF;
    IF L14 IS NOT NULL THEN dbms_output.put(', ' || L14_char); END IF;
    IF L15 IS NOT NULL THEN dbms_output.put(', ' || L15_char); END IF;
    IF L16 IS NOT NULL THEN dbms_output.put(', ' || L16_char); END IF;
    
    IF L1 IS NOT NULL THEN
        dbms_output.put_line(' 언어를 컨텐츠 언어로 설정했습니다.');
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN dup_val_on_index THEN
        dbms_output.put_line('컨텐츠 언어를 중복할 수 없습니다.');
END;
```

> 파라미터를 비우기 위해서는 파라미터 := NULL 을 넣어줘야 한다.

### 예외처리



| 원인             | 예외                   |
| ---------------- | ---------------------- |
| dup_val_on_index | 중복값이 들어갔을 경우 |



---

참조

https://rosebud90.tistory.com/entry/18-Oracle-Exception-%EC%98%88%EC%99%B8%EC%B2%98%EB%A6%AC

---



## 화질 및 데이터 변경

```
없는 프로필 입니다.

몽룡이 프로필의 화질설정을 변경했습니다.
고화질 -> 자동
```

```sql
CREATE OR REPLACE PROCEDURE upd_video_quality (
    p_profile_id            VARCHAR2
    , p_autoplay_episode    VARCHAR2
    , p_autoplay_previews   VARCHAR2
    , p_screen_info_id      NUMBER
) 
IS 
    v_pname                 VARCHAR2(50);
    v_sname                 VARCHAR2(50);
    v_sname_after           VARCHAR2(50);
BEGIN
    SELECT pname, sname INTO v_pname, v_sname
    FROM nf_profile JOIN screen_info USING(screen_info_id)
    WHERE profile_id = p_profile_id;

    UPDATE nf_profile
    SET 
        autoplay_episode = p_autoplay_episode
        , autoplay_previews = p_autoplay_previews
        , screen_info_id = p_screen_info_id
    WHERE profile_id = p_profile_id;
    
    SELECT sname INTO v_sname_after
    FROM nf_profile JOIN screen_info USING(screen_info_id)
    WHERE profile_id = p_profile_id;    
    
    COMMIT;
    dbms_output.put_line(v_pname || ' 프로필의 화질설정을 변경했습니다.');
    dbms_output.put_line(v_sname || ' -> ' || v_sname_after);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 프로필 입니다.');
END;
```

## 컨텐츠 평가

```
가타카 를(을) 싫어요 했습니다.

가타카 를(을) 좋아요 로 변경했습니다.
```

```sql
CREATE OR REPLACE PROCEDURE set_contents_ratings (
    p_profile_id          VARCHAR2
    , p_contents_id       NUMBER
    , p_con_like          VARCHAR2
)
IS 
    v_con_like          VARCHAR2(5) := lower(p_con_like);
    v_title             VARCHAR2(4000);
    have_rating         VARCHAR2(5);
    like_char           VARCHAR2(3 char);
BEGIN
    like_char := CASE lower(p_con_like)
        WHEN 'true' THEN '좋아요'
        ELSE '싫어요'
    END;
    
    SELECT title INTO v_title FROM nf_contents WHERE contents_id = p_contents_id;

    SELECT con_like INTO have_rating
    FROM ratings
    WHERE profile_id = p_profile_id 
        AND contents_id = p_contents_id;

    UPDATE ratings
    SET rate_date = sysdate
        , con_like = v_con_like
    WHERE profile_id = p_profile_id
        AND contents_id = p_contents_id;
        
    COMMIT;
    dbms_output.put_line(v_title || ' 를(을) ' || like_char || ' 로 변경했습니다.');
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO ratings
        VALUES(
            p_profile_id || '_' || p_contents_id
            , p_profile_id
            , p_contents_id
            , sysdate
            , v_con_like
        );
        
    COMMIT;
    dbms_output.put_line(v_title || ' 를(을) ' || like_char || ' 했습니다.');
END;
```

> 없는 영화를 선택했을 때 예외처리가 필요하다.

토, 일 이틀동안 504줄의 코드를 작성했다.

## 

