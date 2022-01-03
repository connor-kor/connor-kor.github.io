---
title: JSP 프로젝트
category: project_fullstack
---

## 환경설정




```sql
CREATE USER ssd
IDENTIFIED BY 1234;
```

**권한부여**

```sql
GRANT CONNECT, RESOURCE, DBA, UNLIMITED TABLESPACE 
TO ssd;
```

- `CONNECT`  SQL Developer 에 접속권한을 준다.



**계정의 테이블 모두 삭제**

```sql
SELECT  'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;'
FROM    user_objects
WHERE   object_type = 'TABLE';
```

