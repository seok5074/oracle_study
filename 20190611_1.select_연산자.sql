select 
	* 
from dept;


--select ~ from 절 사이에 들어오는 항목 설명
-- : 기본필드,연산필드,인라인뷰가 들어올수있다.
select
name,kor,eng,mat,	--기본필드
kor+eng+mat as tot, -- 연산필드
rank() over(order by (kor+eng+mat) desc) as rank --연산필드 랭크함수(순위용)쓴다.
from SUNGJUK

--deptno as 부서번호 heading이름을 바꾼다
--변경시 as 생략가능하다.
-- " " <- 으로하면 띄어쓰기도 인정이된다 , heading 설정시에만 쓴다.
select
	deptno as 부서번호,
	dname   부서명,
	loc  	"부서 위치"
from dept;
/*
 detpno dname loc   <-- heading(코드명이름)
 ------ ----- ---
     10 총무부   101
     20 영업부   202
     30 전산실   303
     40 관리부   404
     50 경리부   505
*/
--오라클에서 사용되는 연산자
--산술연산자 : + - * /
--			나머지 구하는 함수 : mod(피젯수,젯수)

select 2+1,3-1,3*2,round(10/3.1) , mod(10,3) from dual;


-- 관계 연산자 : > >= < <= =(같냐) !=, (같지않냐)

-- 논리 연산자 : A and B(A,B 모두 참)
--			  A or B (A또는 B 참)
select * from sawon;

--사원테이블에서 남자 직원 추출
select * from sawon
where sasex ='남자'   -- 여자만 출력 where sasex <> '남자' where sasex != '남자'

--사원테이블에서연봉이 3000이상인사람
select * from sawon
where sapay >= 3000

--사원테이블에서 연봉이 3000미만인 직원추출
select * from sawon
where sapay < 3000


--사원테이블에서 10번부서의 여자 직원 만 추출
select * from sawon
where deptno=10 and sasex='여자'

--사원테이블에서 직위가 과장 또는 대리 추출
select * from sawon
where sajob= '과정' or sajob='대리'

--사원테이블에서 연봉이 2500~3500인 직원추출
select * from SAWON
where sapay >=2500 and sapay <=3500


-- 기타연산자 
--		필드명 between A and B = A~B사이에 있나?
--		필명명 in(A,B,C,..)
select * from SAWON
where sapay >=2500 and sapay <=3500

union all  -- 결과값을 합산해서 보여줘라

select * from SAWON
where sapay between 2500 and 3500

select * from sawon
where sajob in('과장','대리')

--사원테이블에서 부서가 10,30인 직원호출
select * from sawon
where deptno in(10,30)


--문자열검색(유사검색)
--			필드명 like '%_'
--			_: 모든문자 1개(자리)
--			%: 모든문자 개수 상관없다

--유사검색식에 대한 예제
select * from sawon
where saname='최불암'


--사원 테이블에서 최씨 성시를 갖는 직원 추출
select * from sawon
where saname like '최%'

--사원테이블에서 2번째 글자가 미 인직원 추출
select *from SAWON
where saname like '_미_'


--고객테이블 여자 고객만 추출

select * from gogek
where   gojumin like '%-2%'
	 or gojumin like '%-4%'
	 or gojumin like '%-6%'
	 or gojumin like '%-8%'
	 
	 
--사원테이블에서 10번 부서 직원에게 10%의 상여금을 지급
select 
sabun,saname,sajob,deptno,sapay,sapay *0.1 as bonus
from SAWON
where deptno=10

-- 사원 테이블에서 급여명세서 출력
--문자열 결합 연산자 : ||
select '"' || saname ||  '"님의 연봉은' || sapay || '만원으로 결정됨' from SAWON

	 

