/*
 * 서브 쿼리
 * */

SELECT * FROM STUDENT;
SELECT * FROM department;

-- 단일행 서브쿼리는 = <> >= < <= 같은 비교연산자로 비교
-- join으로 두 테이블 검색

 SELECT s.name, d.dname
   FROM STUDENT s , DEPARTMENT d 
  WHERE s.deptno1 = d.deptno
    AND s.deptno1 = (SELECT deptno1 
    				   FROM student 
    				  WHERE name = 'Anthony Hopkins');

-- Anthony Hopkins 학생과 같은 학과에 다니는 학생일 모두 조회
 SELECT deptno1 FROM student WHERE name = 'Anthony Hopkins' -- 이 값자체가 103이기 때문에 위에처럼 사용가능 

 
 -- where절 서브쿼리에서 =로 비교할 때 주의점 
SELECT s.name, d.dname
  FROM STUDENT s , DEPARTMENT d 
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1 
    				   FROM student);
-- single-row subquery returns more than one row오류 발생
-- WHERE절 서브쿼리는 다중행이 되면 안됨


-- 특정교수의 입사일보다 뒤에 입사한 교슈들의 정보출력
SELECT *
  FROM PROFESSOR;

SELECT *
  FROM department;

-- JOIN되는 쿼리부터 생성
-- 맥 라이언교수 입사일자로 비교
SELECT p.name AS "PROF_NAME"
	 , p.HIREDATE
	 , d.dname AS "DEPT_NAME"
  FROM professor p, DEPARTMENT d 
 WHERE p.deptno = d.deptno
   AND p.hiredate > '1985-09-18';

SELECT hiredate FROM professor WHERE name = 'Meg Ryan'; -- '1985-09-18값이 나옴'

COMMIT;

-- 다중행 서브쿼리
-- IN 서브쿼리 결과와 같은갑. 여러개(OR과 동일)
-- EXISTS 서브쿼리의 값이 있는 경우 메인쿼리를 수행
-- >ANY 서브쿼리의 최소값보다 메인쿼리의 큰값을 조회 
-- <ANY 서브쿼리의 최대값보다 메인쿼리의 작은값을 조회
-- >ALL 서브쿼리의 최대값보다 메인쿼리의 큰값을 조회
-- <ALL 서브쿼리의 최소값보다 메인쿼리의 작은값을 조회


-- 지역이 Pohang Main Office인 부서코드에 해당하는 직원들이 사번, 이름, 부서번호를 출력하시오

SELECT dcode
  FROM dept2
 WHERE area = 'Pohang Main Office';

SELECT *
  FROM emp2
 WHERE deptno = (SELECT dcode
 				   FROM dept2
				  WHERE area = 'Pohang Main Office');
-- single-row subquery returns more than one row 이 오류는 다중행이 있다는 소리


SELECT empno, name, deptno
  FROM emp2
 WHERE deptno IN (SELECT dcode
 				    FROM dept2
				   WHERE area = 'Pohang Main Office');

-- emp2 테이블에서 'Section head' 직급의 최소 연볼이 높은 사람의 이름, 직급, 연봉을 출력하시오.
-- 단, 연봉은 $75,000,000 식으로 출력할 것
COMMIT;

SELECT *
  FROM emp2;

SELECT *
  FROM EMP2
 WHERE EXISTS (SELECT *
  				 FROM EMP2
  				WHERE position = 'Section head');


-- 서브쿼리에 min함수 최소값 스칼라를 비교연산으로
SELECT name, POSITION
	 , To_char(pay, '$999,999,999') AS "SALARY"
  FROM EMP2
 WHERE pay > (SELECT min(pay)
  				 FROM EMP2
  				WHERE position = 'Section head');

-- any로 서브쿼리 다중행에서 최소값
SELECT name, POSITION
	 ,To_char(pay, '$999,999,999') AS "SALARY"
  FROM EMP2
 WHERE pay > any(SELECT min(pay)
  				 FROM EMP2
  				WHERE position = 'Section head');

-- 서브쿼리에 초
SELECT name, POSITION
	 ,To_char(pay, '$999,999,999') AS "SALARY"
  FROM EMP2
 WHERE pay > any (SELECT min(pay)
  				 FROM EMP2
  				WHERE position = 'Section head');



-- 다중 컬럼 서브쿼리(파이썬의 튜블과 동일)
-- 1~4학년 중 몸무게가 가장 많이 나가는 학생의 정보를 출력하라(4행)
SELECT grade, name, height, weight
  FROM student
 WHERE (grade, weight) IN (SELECT grade, max(weight)
							 FROM STUDENT
							GROUP BY grade);

SELECT grade, weigth
  FROM STUDENT
 GROUP BY grade;

-- 교수테이블과 학과 department 테이블을 조회하여 학과별로 입사일이 가장 오래된 교수의
-- 교수번호, 이름, 학과명을 출력하시오. 입수일 수능로 오늘차순




SELECT p.profno AS "교수번호"
	 , p.name AS "교수명"
	 , d.dname AS "학과명"
	 , to_char(p.hiredate, 'YYYY-MM-DD') AS "입사일"
  FROM professor p, department d
 WHERE p.deptno = d.DEPTNO 
   AND (p.deptno, p.hiredate) IN (SELECT deptno, min(hiredate)
 								    FROM PROFESSOR
 							       WHERE deptno IS NOT NULL
 							       GROUP by deptno)
ORDER BY p.HIREDATE asc;

SELECT deptno, min(hiredate)
  FROM professor
 WHERE deptno IS NOT NULL
 GROUP BY deptno;

-- 상호연관 쿼리 메인쿼리의 컬럼이 서브쿼리의 조건에 들어가는 경우
-- 전체 20명의 평균연봉
SELECT POSITION, AVG(b.pay)
  FROM emp2 b
 GROUP BY b.POSITION;

SELECT AVG(b.pay)
  FROM emp2 b

  
-- 상호연관 쿼리로 작성
SELECT a.name
	 , a.POSITION
	 , a.pay
  FROM emp2 a
 WHERE a.pay >= (SELECT AVG(b.pay)
 				   FROM emp2 b
 				  WHERE b.POSITION = a.position);		



COMMIT;

-- 여기까지가 where절 서브쿼리


-- 스칼라 서브쿼리, select절 서브쿼리
SELECT *
  FROM emp2 e;

-- JOIN은 건수가 만약 700만건이라해도 조인은 한번만 수행  
SELECT e.empno, e.name, e.deptno, d.dname AS "부서명"
  FROM EMP2 e , DEPT2 d 
 WHERE e.DEPTNO  = d.DCODE;

-- JOIN없이 스칼라 서브쿼리로 해결
-- JOIN으로 되는 값을 서브쿼리로 쓰면 성능에 악영향을 끼침
-- 스칼라 서브쿼리를 쓰면 where검색을 700만건 수행
SELECT e.empno, e.name, e.deptno
	 , (SELECT dname FROM dept2 WHERE DCODE = e.deptno) AS "부서명"
	 , (SELECT area FROM dept2 WHERE DCODE = e.deptno) AS "지역"
  FROM emp2 e;

-- 여기까지가 스칼라 서브쿼리

-- from 서브쿼리

SELECT *
  FROM emp2;

SELECT empno, name, birthday
	 , deptno, EMP2.EMP_TYPE, tel
  FROM emp2;


-- from절에 소괄호 내에 서브쿼리를 작성하는 방식
SELECT es.name
  FROM (SELECT empno, name, birthday
  			 , deptno, EMP2.EMP_TYPE, tel
  		  FROM emp2) es -- from절에서 이름을 부여하는거처럼 서브쿼리도 이름을 부여해서 할당할 수 있다.

-- 각 부서별 연봉 합계
SELECT grpP.deptno, grpP.sumM
  FROM (SELECT deptno, sum(pay) AS "sumM"
		  FROM emp2
		 GROUP BY deptno) grpP

-- 각 부서별 평균연봉
SELECT grpP.deptno, grpP.avgG
  FROM (SELECT deptno, avg(pay) AS "avgG"
		  FROM emp2
		 GROUP BY deptno) Grpp		 

-- 11. emp2와 위에서 구한 값을 JOIN해서 평균연봉보다 얼마씩 차이가 나는지
  		  
SELECT e.name, e.empno, e.POSITION, e.deptno, e.pay, g.payavg
	 , (e.pay - g.payavg) AS "평균 연봉 차액"
  FROM emp2 e, (SELECT deptno, avg(pay) AS payAvg
  				  FROM emp2
  				 GROUP BY deptno) g
WHERE e.DEPTNO = g.DEPTNO;


-- 12.with절로 가상테이블 형태 서브쿼리
WITH g1 AS
(
SELECT deptno, avg(pay) AS payAvg
  FROM emp2
 GROUP BY deptno
)
SELECT e.name, e.empno, e.POSITION, e.deptno, e.pay, g1.payavg
	 , (e.pay - g1.payavg) AS "평균 연봉 차액"
  FROM emp2 e, g1
WHERE e.DEPTNO = g1.DEPTNO;

-- 11번과 12번은 차이가 없음.

-- where절 서브쿼리 > from절 서브쿼리 > select절 서브쿼리(사용자정의함수로 대체)

-- 서브쿼리 사용시 NULL값 처리
INSERT INTO emp2 (empno, name, birthday, deptno, emp_type, tel)
VALUES (202000219, 'Ray Osmond', '1988-03-22', '999','intern','02)909-2345');
commit;

SELECT * FROM emp2;

-- 각 직원의 부서명을 같이 출력하라
SELECT name, deptno, nvl((SELECT dname FROM dept2 WHERE dcode=emp2.deptno), '부서명 없음') AS "부서명"
  FROM emp2
 ORDER BY deptno;

-- 위에 쿼리 JOIN으로 변경가능
SELECT e.name, e.deptno, nvl(d.dname, '부서명 없음') AS "부서명"
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode(+)
 ORDER BY deptno, name;



































