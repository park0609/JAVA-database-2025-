/* 
 * SQL - DML - SELECT
 */

-- 01. HR.employees 테이블의 모든 데이터를 조회하세요.(107건)
SELECT * --asterik -> all로 발음. 모든컬럼을 다 보여라.
  FROM employees; -- ;은 끝맻침
  
-- 02. HR.employees 중 employee_id, first_name, last_name, email, hire_date를 출력하라(107행)
SELECT employee_id, first_name, last_name,email, hire_date
  FROM employees;

-- 03. 02번의 쿼리를 컬럼명을 변경하여 출력하시오. "직원번호","이름". "성", "이메일", "입사일자"로 변경하시오(107행)
-- alia 별명
SELECT employee_id AS "직원번호" --as쓰는게 표준 안써도 상관은 없다
 	 , first_name AS "이름"
	 , last_name AS "성"
	 , email AS  "이메일"
	 , hire_date AS "입사일자"
  FROM employees;

-- 04. employees에서 job_id가 중복되지 않게 출력하시오
-- disyinct - 중복제거, all - 전부다 근데 올은 *로 치환가능
SELECT distinct job_id
  FROM employees;

-- 05. employees 테이블의 이름과 성을 붙여서 full_name으로, phone_number를 출력하시오.
SELECT first_name || last_name  AS "full_name"-- ||를 두개 쓰면 합칠 수 있음
	 , phone_number
  FROM employees;

SELECT first_name || last_name || phone_number
  FROM employees;

-- 06. employees 테이블 직원들 정보를 아래와 같으 나오도록 출력하시오
/*
 * full_name(employee_id) - job_id[hire_date] / phone_number 하나의 컬럼에
 * 예) StevenKing(100) - AD_PRES[2023-06-17] 00:00:00] / 515.123.4567
 * ...
 * */
SELECT first_name || ' ' || last_name || '(' || employee_id || ') - ' || 
		job_id || '[' || hire_date || '] / ' || phone_number AS "total info"
  FROM employees;

/*
 * 조건절 - where 
 */
-- 연습. employees 테이블에서 employees_id가 110인 직원을 출력하세요
SELECT *
  FROM employees
 WHERE employee_id = 110;

-- first_name이 John인 직원을 출력하세요
SELECT *
  FROM employees
 WHERE first_name = 'John'; -- 원하는 값에는 대소문자를 구분하니 유의할 것

 -- hire_date가 2006년 2월 12일인 사람을 출력하세요
 
 SELECT *
   FROM employees
  WHERE hire_date = '2006-02-12'; --날짜타입은 문자열과 비교하면 됨 YEAR-MONTH-day

  -- 데이터타입 숫자형, 문자형, 날짜형 등

/*
 * where 연산자 종류
 * ★ = : 같다 라는 뜻 -> 여타 다른 언어와 달리 =를 하나만 쓴다
 * ★ != , <> : 같지않다 라는 뜻 
 * ★ >,<,>=,<= 크다, 작다, 크거나 같다, 작거나 같다,
 * ★ between a and b : 특정값이 a이상 b 이하에 포함되어있다
 * ★ in(a,b,c) : 특정값이 a거나 b거나 c중 하나 
 * ★ like : SQL에서 문자열과 비교시 특화된 연산
 * ★ is null, is not null : null값을 검색 할 때, null값이 아닌걸 검색할 때
 * ★ a and b : 두개 다 참일 때 True
 * ★ a or b : 둘 중 하나라도 참일 때 True
 * ★ not a : a가 아닌 조건, 반대 조건  
 **/  
 
 SELECT *
   FROM employees
  WHERE hire_date != '2006-02-12'; 
  
  
  SELECT *
   FROM employees
  WHERE hire_date BETWEEN '2005-01-=01' and '2006-02-12';
  
  -- between은 초과 미만이 아님 이상 이하
  SELECT *
   FROM employees
  WHERE salary BETWEEN 9000 AND 15000;
  
  SELECT *
   FROM employees
  WHERE salary >= 900 AND <=15000;

  SELECT *
   FROM employees
  WHERE first_name IN ( 'Johe', 'Steven', 'Neega');

  
  SELECT *
   FROM employees
  WHERE first_name = 'John'
  	 OR first_name = 'Steven'
   	 OR first_name = 'Neega';
  
  -- null비교
SELECT *
  FROM employees
 WHERE commission_pct  IS NULL;

SELECT *
  FROM employees
 WHERE commission_pct  IS NOT NULL;

-- like 문자열 패턴을 가지고 패턴으로 검색
SELECT *
  FROM employees
 WHERE job_id IN ['ST_MAN','MK_MAN','PU_MAN']
 
SELECT *
  FROM employees
 WHERE job_id LIKE '%MAN'; -- %는 앞에 무슨 글자가 있던지 상관없이 앞 또는 뒤쪽 문자열과 같은 패턴을 가진 문자를 찾아라 라는뜻
 
 SELECT *
  FROM employees
 WHERE last_name LIKE 'Ra%';
 
 SELECT *
  FROM employees
 WHERE job_id LIKE '%MAN%';-- %~%는 어디든지 ~문자가 들어가는 문자열은 다 찾아라
 
  SELECT *
  FROM employees
 WHERE last_name LIKE 'Ra__'; -- _는 갯수에 맞게 문자 뒤에 _개수를 포함하여 같은 문자개수를 가진 문자열을 다 찾아라
 
-- 07. employees에서 hire_date 가 2005-01-01 이후에 입사했고 , salary가 10000이상인 직원을 출력하시오
  -- 이름과 이메일, 전화번호, 입사일, 급여를 표시
SELECT first_name
 	 , last_name
 	 , phone_number
 	 , HIRE_DATE
 	 , salary
  FROM employees
 WHERE hire_date > '2005-01-01'
   AND salary >= 10000;


/*
 * 정렬 - order by  
 * ASC (오름) 
 * DESC (내림)
 * 
 * */
 
SELECT *
  FROM employees
 ORDER BY salary ASC;
 
SELECT *
  FROM employees
 ORDER BY commission_pct ASC; -- null은 정렬을 하지 않는다.

SELECT *
  FROM employees
 ORDER BY job_id ASC, salary DESC;
 
 /*
  * 집합 - union, union all, intersect, minus
  * */
 -- depaetments에서 department_id가 50이하인 부서아이디와 부서명 데이터
-- employees에서 employee_id가 110에서 150사이인 직원 아이디와 직원명(first_name || last_name)을 출력하시오.

SELECT department_id, department_name
  FROM departments
 WHERE department_id >= 50
 UNION
SELECT employee_id, first_name || ' ' || last_name AS "full_name"
  FROM employees
 WHERE employee_id BETWEEN 100 AND 150;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 