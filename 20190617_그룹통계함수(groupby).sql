/*
 정렬:
 select * from 테이블명
 			1차정렬				2차정렬
 		  기준필드     정렬방식
 order by 필드1 [asc | desc] , 필드2[asc | desc]
  
 */

select * from sawon
order by deptno asc, sasex asc



--부서별 인원수 구하기
select 
	deptno,count(*) 인원수  --ORA-00979: GROUP BY 표현식이 아닙니다.
from SAWON
group by deptno
order by deptno

--오류
select 
	deptno,saname,count(*) 인원수  --ORA-00979: GROUP BY 표현식이 아닙니다.
from SAWON
group by deptno,saname   --group by 안에도 들어가야한다
order by deptno

--부서별,성별인원수

select
	deptno,sasex,count(*) 인원수
from sawon
group by deptno,sasex
order by deptno,sasex

--사원 성씨별 인원수

select 
	substr(saname,1,1) as 성씨,
	count(*) 인원수
from SAWON
group by substr(saname,1,1)
order by substr(saname,1,1)

--입사년도별 인원수

select to_char(sahire,'YYYY') as 입사년도,
		count(*) as 인원수
from sawon
group by to_char(sahire,'YYYY')
order by to_char(sahire,'YYYY')


--고객테이블
select * from gogek

--고객테이블 : 거주지 별 인원수구하기
select 
	substr(goaddr,1,2) as 시,
	count(*) as 인원수
from gogek
group by substr(goaddr,1,2)
order by substr(goaddr,1,2)


--사원테이블에서 부서별 급여합계가 10000 이상인 데이터만 추출
--방법1
select
* 
from
(
select
	deptno,sum(sapay) 급여합계
from sawon
group by deptno
)
where 급여합계 >=10000  --통계함수(내용) 에 대한 조건절

--또다른방법
select 
	deptno,sum(sapay) 급여합계
from sawon
group by deptno
having sum(sapay) >= 10000

select * from GOGEK

--문제1) 고객 출생년도 별 인원수
select substr(gojumin,1,2) as 출생년도,
	count(*) 인원수
from gogek
group by substr(gojumin,1,2)
order by substr(gojumin,1,2)

--다른방법
create or replace view gogek_view2
as
select
	substr(gojumin,1,2) as 출생년도,
	count(*) as 인원수
from gogek

--문제2) 
select substr(gojumin,1,1) as 출생년대,
	count(*) 인원수
from gogek
group by substr(gojumin,1,1)
order by substr(gojumin,1,1)
--뷰사용하지않는방법
select
	substr(gojumin,1,1) || '0' as 출생년대,
	count(*) as 인원수
from gogek
group by substr(gojumin,1,1)
order by substr(gojumin,1,1)

select * from SAWON
--문제3) 사원 입사계졀별 인원수
select substr(sahire,6,8) as 입사월,
	count(*)
from sawon
group by substr(sahire,6,8)
order by substr(sahire,6,8)

create or replace view  sawon_view_season
as
select
	sabun,saname,sajob,sasex,deptno,sahire,samgr,sapay,
	case 
			when to_number(to_char(sahire,'MM')) in (3,4,5) then '봄'
			when to_number(to_char(sahire,'MM')) in (6,7,8) then '여름'
			when to_number(to_char(sahire,'MM')) in (9,10,11) then '가을'
			else '겨울'
		end  as season
from sawon

select 
		season,
		count(*)
from sawon_view_season
group by season
order by season
--문제4) 고객  성별 인원수
--		국내 남자  13
--		국내 여자  2
--		외국 남자  1
--		외국 여자  1
select * from GOGEK
insert into gogek values(16,'존슨','서울 강서구','801212-5123456',10);
insert into gogek values(17,'제인','서울 강북구','901212-6123456',10);
commit


create or replace view test
as
select
	gobun,goname,goaddr,gojumin,godam,
	case
		when substr(gojumin,8,1) in(1,3) then '국내남자'
		when substr(gojumin,8,1) in(2,4) then '국내여자'
		when substr(gojumin,8,1) in(5) then '외국남자'
		when substr(gojumin,8,1) in(6) then '외국여자'
	end as nasex
from gogek

select
	 nasex,
	 count(*) as 인원수
from test
group by nasex
order by nasex

select
	gogender,
	count(*) 인원수
from(
	select
		g.*,
		case
			when substr(gojumin,8,1) in(1,3) then '국내남자'
			when substr(gojumin,8,1) in(2,4) then '국내여자'
			when substr(gojumin,8,1) in(5) then '외국남자'
			when substr(gojumin,8,1) in(6) then '외국여자'
		end as gogender
	from 
	(select * from gogek) g
)
group by gogender
order by gogender