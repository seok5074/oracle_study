/*
 제약조건(constraint)
 :데이터무결성(data integrity)을 지키기위한 수단 = 애초에 데이터를 삽입할때 제약을걸자
 
 1.null or not null : 필수입력여부
 2.unique			: 도메인(필드집합)내에 동일값 허용안함(고유값)
 					  중복허용안함
 3.check			:조건에 해당되지 않는 데이터를 입력불가
 					(범위 =성적(0~100), 성별(남 or 여 만 선택하겟다.(일관성))
 4.default			: 값을 입력하지 않으면 지정된 기본값 입력					
 5.primary key		:기본키(메인키) 조합이된 합성키 (not null + unique 제약+index)
 					 레코드를 대표(식별)하는 키
 6.foregin key		:외래키(입력값에 대한 체크를 외부테이블에서 참조)
 */


--1. null or not null제약  - 생략시 기본값은 null허용이다.
--						 - inline형식으로만 사용가능
create table tb1
(
--						뒤에다가 쓴다
	name varchar2(100) not null,   --이필드는 not null제약이 걸렷다 .필수입력이다.
	tel varchar2(100) null			--null허용
)
insert into tb1 values('일길동','010-111-1111') -- 정상적데이터
insert into tb1(name) values('이길동') 		  --이길동  NULL
insert into tb1(name,tel) values('삼길동',null) -- 직접적으로 null을 삽입할수도있다.
insert into tb1(tel) values('10104-51515-55')

select * from tb1


--2.unique =중복불가
-- inline방식
create table tb2
(
	id varchar2(100) unique,	--중복불가
	name varchar2(100) not null --필수입력
)

insert into tb2 values('hong','홍길동')
insert into tb2 values('hong','홍길순')  --무결성 제약 조건(TEST.SYS_C003999)에 위배됩니다

select * from tb2

--테이블 수정을 통한 제약조건부여(제약조건명을 사용자가 부여)
create table tb22
(
	id varchar2(100) not null,
	name varchar2(100) not null
)

--제약조건
alter table tb22
	add constraint uq_tb22_id id unique(id)
--					제약조건명
insert into tb22 values('hong','홍길동')
insert into tb22 values('hong','홍길순')

--3.check제약 : 조건에 맞을경우만 입력허용
--			check(조건)
--			범위산출(0~100) kor >=0 and kor <=100			or
create table tb3
(
	name varchar2(100) not null,
	kor int check(kor >=0 and kor<=100),   -- inline 방식
	eng int,
	mat int,
	--2.제약조건 부여 ↓
	constraint ck_tb3_eng check(eng>=0 and eng<=100)
)

--테이블 수정을 통한 제약조건 추가
alter table tb3
add constraint ck_tb3_mat check(mat>=0 and mat<=100)

insert into tb3 values('일길동',55,66,77)

--국어점수 위배
insert into tb3 values('국어위배',155,66,77)
--영어점수 위배
insert into tb3 values('영어위배',55,166,77)
--수학점수 위배
insert into tb3 values('수학위배',55,66,-77)

create table tb33
(
	name varchar2(100) not null,
	gender varchar2(100)
)

alter table tb33
	add constraint ck_tb33_gender check(gender ='남자' or gender='여자')
--문제) gender부분에는 남자 여자 만 입력가능하도록 제약조건 설정
--	제약조건명은 : ck_tb33_gender

insert into tb33 values('이름1','남자')
insert into tb33 values('이름2','여자')
insert into tb33 values('이름3','자')


select * from tb33



--4.default제약 : 기본값
create table tb4
(
	name varchar2(100) not null,
	gender varchar2(100) default '남자',
	age	   int			default 1
)

insert into tb4 values('일길동','남자',20);
insert into tb4(name) values('이길동');
insert into tb4 values('삼길동',default,default);

select *from tb4;

--5.primary key(기본키) : not null + unique +index
-- 						레코드를 대표하는 필드(구분용도)

create table tb5 
(
	seq_no int,
	name varchar2(100) not null
)

alter table tb5
	add constraint pk_tb5_seq_no primary key(seq_no)
	
insert into tb5 values(null,'널길동') --X
insert into tb5 values(1,'일길동')


insert into tb5 values(1,'원길동');
--ORA-00001: 무결성 제약 조건(TEST.PK_TB5_SEQ_NO)에 위배됩니다

-- 일련번호 관리하는 객체
create sequence seq_tb5_seq_no
	START WITH 1 -- 시작값 (기본값이 1이다)
	INCREMENT BY 1 --증가값(기본값이 1이다)
	
	
--사용
--dual == 오라클 임시용테이블
select seq_tb5_seq_no.nextVal 다음값, 
	   seq_tb5_seq_no.CurrVal 현재값

from dual;


-- 문법을 중요시한다

select 1+1 from dual;

insert into tb5 values(seq_tb5_seq_no.nextVal,'박길동')
insert into tb5 values(seq_tb5_seq_no.nextVal,'박길동2')


select * from tb5;


--primary key 복합키형태

create table tb55
(
	idx int,
	regdate date,
	name varchar2(100) not null
)

alter table tb55
	add constraint pr_tb55_idx_regdate primary key(idx,regdate)
	
--현재시스템 날짜 : sysdate

insert into tb55 values(1,sysdate,'TV');
insert into tb55 values(1,sysdate,'Radio');

select * from tb55;

--6. foreign key :외래키(입력값에 대한 체크를  부모키(외래테이블)에서 참조)

create table 학생
(
	학번 int,
	이름 varchar2(100) not null,
	전화 varchar2(100)not null,
	보호자 varchar2(100) not null,
	보호자직업 varchar2(100)not null,
	주소 	varchar2(100),
	constraint pk_학생_학번 primary key(학번)
)

insert into 학생 values(1,'일길동','111-1111','일아비','자영업','서울 관악 신림1동');
insert into 학생 values(2,'이길동','222-1111','이아비','회사원','서울 관악 신림2동');

select * from 학생

create table 성적
(
	일련번호 int,		--primary key
	학번		int,	-- foreign key
	국어		int,
	영어		int,
	수학		int,
	학년		int,
	학기		int,
	시험종류  varchar2(100)
)

-- 기본키지정(primary key)
alter table 성적
	add constraint pk_성적_일련번호 primary key(일련번호)
	
--참조키지정(외래키지정)  - foreign key

alter table 성적
	add constraint fk_성적_학번 foreign key(학번)
							  references 학생(학번)     -- <= 학생테이블안에있는 학번테이블을 참조할거다
							  
insert into 성적 values(1,1,100,100,100,1,1,'중간고사');							 

--오류
insert into 성적 values(2,10,100,100,100,1,1,'중간고사');				
--ORA-02291: 무결성 제약조건(TEST.FK_성적_학번)이 위배되었습니다- 부모 키가 없습니다
	

select * from 성적							  
							  
							  
select * from dept;
							  
select * from gogek;							  
							  
select * from sawon;							 
							  
							  