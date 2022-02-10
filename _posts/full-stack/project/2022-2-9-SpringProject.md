---
title: 스프링 프로젝트
category: project_fullstack
---

# 환경설정

## 필요파일

- `ojdbc6.jar`
- `apache-tomcat-8.5.73` 로컬서버 실행
- `log4jdbc.log4j2.properties` 

**[workspace]**

인코딩 (enc): UTF-8

**[프로젝트 생성]**

프로젝트: Spring Legacy Project

템플릿: Spring MVC Project

**[web.xml]**

```xml
<!-- 인코딩 -->
<filter>
    <filter-name>encodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
</filter>
<filter-mapping>
    <filter-name>encodingFilter</filter-name>
    <servlet-name>appServlet</servlet-name>
</filter-mapping>
```

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

<!-- 마이바티스 -->
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

<!-- 롬복 -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.0</version>
    <scope>provided</scope>
</dependency>        
```

**테스트**

junit: 4.12

**Servlet**

javax.servlet-api: 3.1.0

**Maven**

maven-compiler-plugin

- source: 1.8
- target: 1.8

**logging**

`<scope>runtime</scope>` 주석처리해야 log4j 를 사용할 수 있는듯하다.

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

# 시작

## DB연결

**DB연결 정리**

1. root-context.xml
2. properties
3. 객체
4. Mapper 인터페이스
6. (선택) Mapper.xml

**root-context.xml**

```xml
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
    <property name="typeAliases">
        <list> 
            <value>패키지명.domain.BoardVO</value>
        </list>
    </property>		        
</bean>
<mybatis-spring:scan base-package="패키지명.mapper"/>	
```

**예**

- 아이디: SQL 계정 아이디
- 비밀번호: SQL 계정 비밀번호
- 패키지명: io.github.dev_connor.mapper 

**log4jdbc.log4j2.properties**

```
log4jdbc.spylogdelegator.name=net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator
```

이 파일을 src/main/resources 에 root-context.xml 코드와 함께 추가한다.

**데이터 객체**

```java
@Data
@Alias("BoardVO")
public class BoardVO {
	private long bno;
	private String title; 
	private String content;
	private String writer;
	private Date regdate; 
	private Date updateDate;
}
```

**Mapper 인터페이스**

```java
public interface BoardMapper {
	@Select("SELECT * FROM tbl_board WHERE bno > 0")
	public List<BoardVO> getList();
}
```

**테스트**

```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
    
   @Setter(onMethod_ = @Autowired)
   private BoardMapper mapper;

   @Test
   public void testGetList() {
      mapper.getList().forEach(board -> log.info(board));
   } 
}
```

**Mapper.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="패키지명.mapper.BoardMapper">

   <select id="getList" resultType="BoardVO">
      <![CDATA[
      select * from tbl_board where bno > 0 
      ]]>
   </select>
</mapper>
```

**예**

- 패키지명: io.github.dev_connor

## 컨트롤러 구현

**정리**

1. controller
2. service
3. jsp

### 글 목록

**controller**

```java
@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
   private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
   private  BoardService service;

   @GetMapping("/list")
   public void list(Model model) {
      log.info("list");
      model.addAttribute("list", service.getList());
   }
} 
```

**service 인터페이스**

```java
public interface BoardService {
   public List<BoardVO> getList();
}
```

**service**

```java
@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

   @Setter(onMethod_ = @Autowired )
   private BoardMapper mapper;
    
    @Override
    public List<BoardVO> getList() {   
       log.info("getList..........");   
       return mapper.getList();
    }
}
```

**jsp**

```jsp
<%@ page contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <h1>List Page</h1>

   <br>
   <a href="/board/register">register</a>
   <br>
   <br>

   <table class="table table-striped table-bordered table-hover">
      <thead>
         <tr>
            <th>#번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>수정일</th>
         </tr>
      </thead>

      <c:forEach items="${list}" var="board">
         <tr>
            <td><c:out value="${board.bno}" /></td>
            
            
<%--             <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'><c:out --%>
<%--                      value="${board.title}" /></a></td> --%>

            <td>
            	<a class='move' href='<c:out value="${board.bno}"/>'> 
            		<c:out value="${board.title}" />
            	</a>
            </td> 

            <td><c:out value="${board.writer}" /></td>
            <td><fmt:formatDate pattern="yyyy-MM-dd"
                  value="${board.regdate}" /></td>
            <td><fmt:formatDate pattern="yyyy-MM-dd"
                  value="${board.updateDate}" /></td>
         </tr>
      </c:forEach>
   </table>
   
   <!-- p 311 -->
		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
			<input type='hidden' name='type'
				value='<c:out value="${ pageMaker.cri.type }"/>'> 
			<input type='hidden' name='keyword'
				value='<c:out value="${ pageMaker.cri.keyword }"/>'>
		</form>
   
   
	   <!-- p 308 -->
	   <div class='pull-right'>
	      <ul class="pagination"> 
	          <c:if test="${pageMaker.prev}">
	              <li class="paginate_button previous"><a href="${pageMaker.startPage - 1 }">Previous</a>
	              </li>
	            </c:if> 
	            <c:forEach var="num" begin="${pageMaker.startPage}"
	              end="${pageMaker.endPage}">
	              <li class="paginate_button"><a href="${num }">${num}</a></li>
	            </c:forEach>
	            <c:if test="${pageMaker.next}">
	              <li class="paginate_button next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
	            </c:if>  
	      </ul>
	   </div>
	   <!--  end Pagination -->   

   <br>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
   $(document).ready(function(){
      var result = '<c:out value="${result}"/>';
      
      checkModal(result);
      
      // p.257
      history.replaceState({}, null, null);
      
      function checkModal(result){
         if(result === '' || history.state) return;
         if( parseInt(result)>0 ) alert("게시글 " + parseInt(result) +" 번이 등록되었습니다. "); 
      }
      
      	// 페이징처리
		var actionForm = $("#actionForm");

		$(".paginate_button a").on(
				"click",
				function(e) {

					e.preventDefault();

					console.log('click');

					actionForm.find("input[name='pageNum']")
							.val($(this).attr("href"));
					actionForm.submit();
				});

		$(".move").on("click",function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"
				+ $(this).attr("href") + "'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});

		var searchForm = $("#searchForm");

		$("#searchForm button").on(
				"click",
				function(e) {

					if (!searchForm.find("option:selected")
							.val()) {
						alert("검색종류를 선택하세요");
						return false;
					}

					if (!searchForm.find(
							"input[name='keyword']").val()) {
						alert("키워드를 입력하세요");
						return false;
					}

					searchForm.find("input[name='pageNum']")
							.val("1");
					e.preventDefault();

					searchForm.submit();

				});
   });
</script>

</body>
</html>
```

### 글 상세

**controller**

```java
@GetMapping({ "/get", "/modify" })
public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
    log.info("/get or modify");
    model.addAttribute("board", service.get(bno));
}
```

**service**

```java
@Override
public BoardVO get(Long bno) {
    log.info("get......" + bno);
    return mapper.read(bno);
}
```

**Mapper.xml**

```xml
<select id="read" resultType="BoardVO">
    select * 
    from tbl_board 
    where bno =   #{bno}
</select>   
```

### 글 작성

```xml
<insert id="insertSelectKey">
    <selectKey keyProperty="bno" order="BEFORE"   resultType="long">
        select seq_board.nextval from dual
    </selectKey>
    insert into tbl_board (bno,title,content, writer)
    values (#{bno}, #{title}, #{content}, #{writer})
</insert>    
```

### 글 수정

```xml
<update id="update">
    update tbl_board
    set title= #{title}, content=#{content}, writer=#{writer}, updateDate=sysdate
    where bno= #{bno}
</update>   
```

### 글 삭제

```xml
<delete id="delete">
    delete tbl_board 
    where bno = #{bno}
</delete>   
```

## CSS 적용

**list.jsp**

```jsp
<link href="${webappRoot}/resources/css/board.css" type="text/css" rel="stylesheet" />
```

**board.css**

webapp/resources/css 폴더 내에 작성한다.

```css
.paginate_button {
	list-style: none;
	float: left;
	padding: 3px;
}
```

