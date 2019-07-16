--테이블 생성
create table sungjuk
(
	name varchar2(100),
	kor  number(3),
	eng  number,
	mat  int
)

--DML (Data Manipulation Language)
--: insert , update,delete

--추가(insert)
--DB에서는 문자열을 '' 로한다
-- ; <- 자바sql문에선 쓰면안된다.
insert into sungjuk values('일길동',80,90,100)
--					테이블명 			뒤에  		테이블내용입력가능
--					table명(입력한필드정보기록)values(입력필드정보순서대로 값넣는다.)
insert into sungjuk(kor,eng,mat,name) values(99,77,88,'이길동')

insert into sungjuk values('일길동',80,90,100)

insert into sungjuk values('삼길동',180,90,100)
--삭제명령
delete SUNGJUK

--조회명령
select 
name,kor,eng,mat, kor+eng+mat as tot ,(kor+eng+mat)/3 as p
from sungjuk

--as tot는 헤딩(heading) 연산자를쓴 문에 필드명을 설정
--헤딩하면은 나중에 존재하게되는 필드명이기 때문에 바로 뒤에 연산할수없다.