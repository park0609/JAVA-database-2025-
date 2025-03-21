/*
 * JOIN 개념
 * */

-- 개념
-- 정규화되어 나누어진 테이블의 데이터를 한꺼번에 모아서 쉽게 출력하기 위한 기법
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id; 


-- 총데이터가 2889개 출력
-- 카테시안 곱 = 2개의 테이블에서 나올수있는 모든 경우의 수를 말함
SELECT *
  FROM employees e, departments d;

-- 오라클 방식. 표준방식 X 편하게 쿼리를 작성하라고 만든 편법
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

-- ANSI 표준 문법
SELECT *
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id;

-- 필요컬럼만 명세
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;


-- Join을 하면 할수록 갯수는 기존보다 줄어들거나 같다. 절대 커질수없다 커진다면 어딘가 연결이 잘못된 것
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.DEPARTMENT_ID
	 , d.department_name
	 , l.city, l.STREET_ADDRESS , l.STATE_PROVINCE
  FROM employees e, departments d, locations l
 WHERE e.department_id = d.department_id
   AND l.location_id = d.location_id
   AND d.department_id = 60;

-- 외부조인
-- 보통 PK와 FK간의 일치하는 조건의 데이터를 찾는것 - 내부조인 INNER
-- PK와 FK간의 일치하지 않는 조건의 데이터도 찾는것 - 외부조인 OUTER
-- 테이블1 OUTER JOIN 테이블 2
-- 테이블 1번을 기준으로 외부조인 LEFT OUTER JOIN
-- 테이블 2번을 기준으로 외부조인 RIGHT OUTER JOIN

SELECT *
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.department_id IS NULL;

-- ANSI 표준문법
-- employees테이블에는 있는데 departments테이블에는 없는 데이터를 같이 출력해줘
-- outer를 빼도 작동은 하나 표준문법을 지키는게 좋음
SELECT *
  FROM employees e
  LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.department_id IS NULL;

SELECT *
  FROM employees e
 RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- Oracle 문법
-- (+)만족하지 않는 조건도 더 나오게 한다는 뜻
-- LEFT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id(+);

-- RIGHT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id(+) = d.department_id;

-- INNER JOIN() -> INNER를 생략가능
-- OUTER JOIN() -> 얘네들은 LEFT와 RIGHT를 붙이면 OUTER 생략가능 

-- SELF JOIN() -> 자기자신을 2번 사용하는 JOIN
SELECT e1.employee_id
	 , e1.first_name || ' ' || e1.Last_name AS "full_emp_name"
	 , e1.job_id
	 , e1.MANAGER_ID 
	 , e2.first_name || ' ' || e2.Last_name AS "full_mng_name"
	 , e2.job_id
  FROM employees e1, employees e2
 WHERE e1.MANAGER_ID = e2.employee_id(+)
 ORDER BY e1.employee_id;
