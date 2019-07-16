/*
view
1.가상의 테이블 : 테이블과 동일한 방법으로 사용된다.
2.뷰내부에는 sql문장이 저장(bacth형식의 파일)
3.목적)
	1)편리성(복잡한명령 단순하게 이용)
	2)보안성(중요데이터를 감출수있다)

*/


--사원테이블에서 여자만 조회
--뷰생성
create or replace view sawon_view_female
as
	select * from sawon where sasex='여자'
	
--뷰사용
select * from sawon_view_female


--사원테이블 +입사계절 추가
select
	*,
	추가컬럼
from sawon  안된다(오라클만안된다.)

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

select * from sawon_view_season
where season =(select season from sawon_view_season where saname='김민종')


--보안적 측면
--1234567
--960310-*******
create or replace view gogek_view_jumin
as
	select gobun,goname,goaddr,godam, 
			substr(gojumin,1,7) || '*******' as gojumin
	from gogek
	
select * from gogek_view_jumin

--사용자변경 system 계정으로 변경
create user test9 identified by test9
--연결권한 부여
grant connect to test9

--사용자변경: test계정으로 변환

--test9에게 test가 뷰를 조회할수있는 권한을준다
grant select on gogek_view_jumin to test9

--inline view: SQL문장내에 포함되어있는 뷰(익명의뷰)

select 
	s.* , to_char(sahire,'YYYY') as hire_year ,
	(select count(*)from sawon) as sa_count
from (select * from sawon) s


--문제1) 서브쿼리 장동건과 동일한 년대에 입사한 직원들을 호출
-- 1993-07-25 -> 1990년대 입사자 추출
--출력형식 ) sabun saname sahire 입사년대
--			1	  장동건	1993-07-23 1990
--			3	  이미자	1998-03-25 1990	
create or replace view  sawon_view_ipsa
as
select
	sabun,saname,sahire,
	case 
			when to_number(to_char(sahire,'YYYY')) in (1990,1991,1992,1993,1994,1995,1996,1997,1998,1999) then '1990'
			else '겨울'
		end  as 입사년도
from sawon

select * from sawon_view_ipsa
where 입사년도 =(select 입사년도 from sawon_view_ipsa where saname='장동건')

--문제2)  고객테이블을 이용해서 아래와 같은 결과의 뷰를 생성
--	출력형식) gobun goname goaddr gojumin 출생년도 나이 띠
create or replace view gogek_view1
as
select 
	g.*,
	(
		to_number(substr(gojumin,1,2)) +
	  	 case
	 		when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
	   		else 2000
		 end
	) as birth_year
from(select * from gogek)g
--사용	
select * from gogek_view1

--뷰(테이블) 이용해서 뷰생성
create or replace view gogek_view2
as
select
	gv.*,
	(to_number(to_char(sysdate,'YYYY'))-birth_year+1)as age, 
	case mod(birth_year,12)
		when 0 then '원숭이띠'
		when 1 then '닭띠'
		when 2 then '개띠'
		when 3 then '돼지띠'
		when 4 then '쥐띠'
		when 5 then '소띠'
		when 6 then '호랑이띠'
		when 7 then '토끼띠'
		when 8 then '용띠'
		when 9 then '뱀띠'
		when 10 then '말띠'
		when 11 then '양띠'
	end as tti
from (select * from gogek_view1) gv

select * from GOGEK_VIEW2

/*
// 4  5  6  7  8   9 10 11 0   1  2  3
// 자 축 인 묘 진 사 오 미 신 유 술 해
// 쥐 소 범 토 용 뱀 말 양 원 닭 개 돼
 */
