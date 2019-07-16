-- 1줄 주석(--)
/* 
범위 주석 
*/

--1. 계정생성(DDL)
--          계정명                 비밀번호
create user test identified by test;

--2. 권한부여(DCL)

grant CONNECT to test; -- 연결권한
--리소스를 사용할수있는 권한
grant RESOURCE to test;-- 리소스(테이블/뷰사용할수 있는 권한)

--3. 테이블생성(DDL):test계정으로 접속하여 사용한다

--create table ttt(no int);

--접속 :scott
--객체사용 권한부여를한다.(DCL)
--grant -> 
--권한                on 개체(테이블 뷰) to user(권한받을 유저);

--모든 권한을 다준다.
--grant all on emp to test;

--조회만 가능하게한다.
grant select on emp to test;

--사용할려면 = test계정으로 다시 접속한다.

select * from scott.emp;



