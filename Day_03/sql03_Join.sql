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