---
title: 스프링 프로젝트
category: project_fullstack
---

# 환경설정

## 필요파일

- `ojdbc6.jar`
- `apache-tomcat-8.5.73` 

**[workspace]**

인코딩 (enc): UTF-8

**[프로젝트 생성]**

프로젝트: Spring Legacy Project

템플릿: Spring MVC Project

**[pom.xml]**

java-version: 1.8

springframework-version: 5.0.7

**Spring&MyBatis**

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
    <version>${org.springframework-version}</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${org.springframework-version}</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-tx</artifactId>
    <version>${org.springframework-version}</version>
</dependency>

<!-- MyBatis -->
<dependency>
    <groupId>com.zaxxer</groupId>
    <artifactId>HikariCP</artifactId>
    <version>2.7.8</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.4.6</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis-spring</artifactId>
    <version>1.3.2</version>
</dependency>
<dependency>
    <groupId>org.bgee.log4jdbc-log4j2</groupId>
    <artifactId>log4jdbc-log4j2-jdbc4</artifactId>
    <version>1.16</version>
</dependency>
```

**테스트**

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.0</version>
    <scope>provided</scope>
</dependency>        
```

junit: 4.12

**Servlet**

javax.servlet-api: 3.1.0

**Maven**

maven-compiler-plugin

- source: 1.8
- target: 1.8

1. Update Project
2. Build Path 에 ojdbc6.jar 추가
3. Deployment Assembly 에도 추가

JRE System Library: JavaSE-1.8

Project Facets: Java 1.8

**[서버]**

Apache Tomcat v8.5 로 생성

경로 `/` 로 변경

**[SQL Developer]**

```sql
CREATE USER board
IDENTIFIED BY tiger;

GRANT CONNECT, RESOURCE
TO board;

create sequence seq_board;

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

alter table tbl_board add constraint pk_board 
primary key (bno);

INSERT INTO tbl_board (bno, title, content, writer)
  VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');COMMIT;  
```

**[root-context.xml]**

```xml
<!-- DB 연결 -->
<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
    <property name="driverClassName" value="net.sf.log4jdbc.sql.jdbcapi.DriverSpy"></property>
    <property name="jdbcUrl" value="jdbc:log4jdbc:oracle:thin:@localhost:1521:xe"></property>
    <property name="username" value="아이디"></property>
    <property name="password" value="비밀번호"></property>
</bean>
<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource" destroy-method="close">
    <constructor-arg ref="hikariConfig"></constructor-arg>
</bean>	
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="dataSource" ref="dataSource"></property>
</bean>
<mybatis-spring:scan base-package="org.zerock.mapper"/>
```

