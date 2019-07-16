
SELECT SUBSTRB('오라클클럽',1) name FROM DUAL
 UNION ALL
SELECT SUBSTRB('오라클클럽',3) name FROM DUAL;

--숫자형함수
select floor(10.1),ceil(10.1),floor(-10.1),ceil(-10.1)from dual;

--문자형함수
--			  1 2 3 4 5 6 7 8 <=oracle은 1 base다
select substr('우리나라대한민국',5,2) from dual;
select substr('우리나라대한민국',5) from dual;



--12345678901234  =위치
--911105-2325467

select gojumin, substr(gojumin,8,1 ) from gogek;

--substr 함수를 이용해서 여자고객만 추출
--to_numer('') 문자열 -> 숫자형
select * from gogek
where to_number(substr(gojumin,8,1)) in (2,4,6,8)

--고객테이블에서 겨울에 태어난 고객만추출

select * from gogek
where to_number(substr(gojumin,3,2)) in(12,01,02)

--사원테이블에서 '이' 씨 성씨만 추출
select * from SAWON
where saname like '이%'

select * from SAWON
where substr(saname,1,1) ='이'


--날짜형함수
SELECT TO_CHAR(SYSDATE,'RRRR-MM-DD HH24:MI:SS') "지금시간"FROM DUAL ;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') "지금시간"FROM DUAL ;

SELECT TO_CHAR(SYSTIMESTAMP,'RRRR-MM-DD HH24:MI:SS.FF3') FROM DUAL
--10일후
select sysdate, sysdate+10 from dual;

--18개월
select sysdate 입대날짜, add_months(sysdate,18) 제대날짜 from dual;


select to_date('2019-1-1') 입대날짜, add_months('2019-1-1',18) 제대날짜 from dual;

-- 게월의 차구하기
select months_between(sysdate,'1990-1-1') from dual;

--사원테이블에서 근속년 월 수를 구한다

select *from SAWON

select sabun,saname,sahire,round(months_between(sysdate,sahire),0) as 총월수,
floor(round(months_between(sysdate,sahire),0)/12.1) as 총년수,
mod(round(months_between(sysdate,sahire),0),12) as 총몇월,
round(sapay/13.0) as 월급,
round((round(sapay/13.0)*round(months_between(sysdate,sahire),0))/12.0) as 퇴직금
from sawon;

SELECT TO_CHAR(123,'09999') zero FROM DUAL;  				--  00123
SELECT TO_CHAR(12345678,'L999,999,999') local  FROM DUAL; 	--  ￦12,345,678


--고객테이블에서 성별출력
select gobun,goname,goaddr,gojumin ,
		decode(substr(gojumin,8,1),'1','남자',
								   '2','여자',
								   '3','남자',
								   '4','여자',
								   '5','남자',
								   '6','여자',
								   '7','남자',
								   '8','여자'						   
								   )as gogender
from gogek


--case문 이용한 성별출력
-- case 쓰고 end를쓰자

select gobun,goname,goaddr,gojumin,
	case		
		when to_number(substr(gojumin,8,1)) in (1,3,5,7) then '남자'
		when to_number(substr(gojumin,8,1)) in (2,4,6,8) then '여자'	
		else '몰라'
	end as gogender
from gogek;




--null관련함수 및 연산자 : nvl , nvl2 (변경대치) 
--					is null , is not null(check)

--사원테비을에서 부서장급 사원만 출력(상사가없는출력)
select * from sawon
where samgr is null     -- => samgr =null 은안된다


--사원테이블에서 부서장이 아닌 사원 출력(없는출력 is not null)
select * from SAWON
where samgr is not null


--null 대신에 0으로 치환한다.(변경)
select sabun,saname,nvl(samgr,0),nvl2(samgr,1,0) from sawon







