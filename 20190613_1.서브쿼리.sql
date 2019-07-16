/*서브쿼리

subquery: 하위쿼리의 결과를 이용해서 주쿼리를 수행하는 조회명령(SQL)
*/

--사원테이블 최불암과 같은 부서 직원 추출

--1. 최불암 부서 확인
select deptno from SAWON where saname ='최불암'
--2. 10번부서 직원 추출
select * from sawon where deptno=10


--서브쿼리 방식
select * from sawon 
where deptno=(select deptno from SAWON where saname ='최불암')


--최민수과 동일한 년도에 입사한 직원 추출
--1.최민수의 입사년도
select to_char(sahire,'YYYY') from SAWON where saname='최민수'
--2.2005년도 입사자 추출
select * from SAWON
where to_char(sahire,'YYYY')='2005'



select * from SAWON
where to_char(sahire,'YYYY')=(select to_char(sahire,'YYYY') from SAWON where saname='최민수')


--집계(통계)함수
--카운트는(필드) : 필드의갯수 를 구한다.(null 포함 안시킴)
--count(*) : 전체 레코드 수
--sum(),avg(),max(),min(),stddev()

select count(*) 사원수, -- 추출된 행수(레코드수)
	   count(samgr) as 부서장이아닌사원수,
	   sum(sapay) as 급여합계,
	   avg(sapay) as 급여평균,
	   min(sapay) as 최저급여,
	   max(sapay) as 최대급여
from sawon

--전체급여평균보다 많이 받는 직원추출
--1.전체급여평균 구하기
select avg(sapay) as 전체급여평균 from sawon
--2.3085 보다 많이 받는 직원 추출
select * from SAWON
where sapay> (3085)


select * from sawon
where sapay>(select avg(sapay) as 전체급여평균 from sawon)

--가장최근에 입사한 사원과 동일한 부서를 갖는 직원들을 추출
--1.가장 최근에 입사한 날짜
select max(sahire)  as 최근입사사원 from sawon
--2.가장최근에 입사한 사원추출
select deptno from SAWON
where sahire=(select max(sahire) from sawon)
--3.위에서 추출된 해당부서 직원을 추출
select * from SAWON
where deptno =(30)

select * from sawon
where deptno = (select deptno from SAWON where sahire=(select max(sahire) from sawon))



--10부서의 최대급여자를 추출
--1.10번부서 의 최고급여
select max(sapay) from sawon where deptno=10

--2.급여을 4000받는 직원추출
select * from SAWON 
where sapay =(select max(sapay) from sawon where deptno=10) and deptno =10

-- 각부서별 최대급여자추출: 문제발생 사용X
--					    부서가 증가하거나 부서명이 바뀌거나 할때 쓸모없어진다.
select * from sawon
where (sapay =(select max(sapay) from sawon where deptno=10) and deptno =10)
	  or
	  (sapay =(select max(sapay) from sawon where deptno=20) and deptno =20)
	  or
	  (sapay =(select max(sapay) from sawon where deptno=30) and deptno =30)
	  or
	  (sapay =(select max(sapay) from sawon where deptno=40) and deptno =40)

--위의 query 문제점을 보완할수있는방법
--상관 query를 이용함
-- 각부서별 최대급여자추출 
--↓ 상관query를 이용
select * from sawon s1
where sapay =(select max(sapay) from sawon where deptno=s1.deptno)




--문제1) 사원테이블에서 장동건과 급여가 같은 직원을추출
select * from SAWON
where sapay =(select sapay from sawon where saname=(select saname from sawon where saname='장동건' ))
--문제2) 고객테이블에서 '강철'같은지역사는ㄴ 고객 추출 (대전사는사람)
select * from gogek
where goaddr =(select goaddr from gogek where goname=(select goname from gogek where goname='강철'))
--문제3) 고겍테이블에서 마징가 같은 달에 태어난 고객 추출
select gojumin from gogek
where goname ='마징가'

select * from gogek
where substr(gojumin,3,2) in (select substr(gojumin,3,2)from gogek where goname='마징가')

--문제4) 사원테이블에서 김민종과 동일한 계절에 입사한 직원추출
select saname,sahire,
		to_char(sahire,'YYYY') as 년,
		to_char(sahire,'MM') as 월,
		to_char(sahire,'DD') as 일
from sawon


select saname,sahire,
		case 
			when to_number(to_char(sahire,'MM')) in (3,4,5) then '봄'
			when to_number(to_char(sahire,'MM')) in (6,7,8) then '여름'
			when to_number(to_char(sahire,'MM')) in (9,10,11) then '가을'
			else '겨울'
		end as ipsa
from sawon

select * from sawon
where case 
			when to_number(to_char(sahire,'MM')) in (3,4,5) then '봄'
			when to_number(to_char(sahire,'MM')) in (6,7,8) then '여름'
			when to_number(to_char(sahire,'MM')) in (9,10,11) then '가을'
			else '겨울'
		end 
		=(
			select	
				case 
				when to_number(to_char(sahire,'MM')) in (3,4,5) then '봄'
				when to_number(to_char(sahire,'MM')) in (6,7,8) then '여름'
				when to_number(to_char(sahire,'MM')) in (9,10,11) then '가을'
				else '겨울'
	          end
			from sawon where saname='김민종'
			)



--다중행 서브query : 서브쿼리의 결과가 2개이상이 나오는것을 뜻함
--최불암(10) 또는 안재욱(20)이 소속된 부서 직원 추출
--ex  다중쿼리에서는 in을 써야한다.
select * from SAWON
where deptno in (select deptno from sawon where saname='최불암' or saname ='안재욱')
			


			
			