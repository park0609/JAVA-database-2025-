/*
 * 복수행, GROUP BY와 가장 많이 사용
 * count(), sum(), avg(), min/max()   ,stddev(), ...
 * */

-- count()
SELECT count(*) -- scalar value
  FROM employees;

-- count()
select count(employee_id) -- scalar
  FROM employees;

-- sum(숫자형컬럼)합계 컬럼은 숫자형만
-- employees 206 salary 8300 삭제
SELECT sum(salary)
  FROM employees;

-- avg(숫자형컬럼) 평균
-- 컬럼에 NULL값이 있으면 제외하고 계산하기 때문에 잘못된 값이 도출
-- 금액이나 수량을 계산하는 컬럼의 NULL값은 전처리 해줘야함.
SELECT avg(salary)
  FROM employees;

SELECT count(salary)
  FROM employees;

-- min(숫자형 컬럼|문자열도 가능), max()
SELECT max(salary)
	 , min(salary)
	 , min(salary)
  FROM  employees;

/*
 * Group by  연계, 그룹화
 * */
-- 그룹바이를 사용하면 group by절에는 group by를 사용한 컬럼과 집계함수 및 일반함수만 사용할 수 있음
-- 아래의 경우 department_id 이외의 컬럼은 사용불가
SELECT department_id
	 , avg(salary) AS 부서별평균급여
	 , to_char(round(avg(salary), 1), '99,999.9') AS 부서별평균급여
	 , sum(salary) AS 부서별급여총액
  FROM employees
 GROUP BY department_id
 ORDER BY avg(salary) desc;

SELECT department_id, job_id
	 , sum(salary) AS 부서직군별급여총액
	 , count(*)
  FROM employees
 GROUP BY department_id, job_id
 ORDER BY department_id;

-- employees 테이블에서 부서와 직군별 급여총액과 직원수를 출력하는데 department_id가 30에서 90사이이고
-- 부서별 직군급여총액이 20000만달러 이상인 데이터만 보일것

-- order by에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체가능
SELECT department_id, job_id
	 , sum(salary) AS 부서직군별급여총액
	 , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
 -- and sum(salary) >= 20000 -> 집계함수는 where에 사용불가
 GROUP BY department_id, job_id
HAVING sum(salary) >=20000
 ORDER BY 3 DESC; -- 여기서 1번을 쓸수있는 이유는 컬럼값을 나타내는거기 때문에 사용이 가능하다.
 
-- rollup은 그룹별 소개와 총계를 표시해주는 기능
SELECT department_id, job_id
	 , sum(salary) AS 부서직군별급여총액
	 , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY ROLLUP (department_id, job_id);

-- pivot() 엑셀에 동일한 기능 있음
-- pivot안쓰고 각 달별로 입사한 사원수를 표시 12행

SELECT to_char(hire_date, 'MM')
  FROM employees;


-- 입사 달별로 그룹핑
SELECT to_char(hire_date, 'MM'), count(*)
  FROM employees
 GROUP BY to_char(hire_date, 'MM');

-- 1월달에 입사한 사람 카운팅
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM');

-- 옆으로 각 달별로 스프레드
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
	 , CASE to_char(hire_date, 'MM') WHEN '02' THEN count(*) ELSE 0 END AS "2월"
	 , CASE to_char(hire_date, 'MM') WHEN '03' THEN count(*) ELSE 0 END AS "3월"
	 , CASE to_char(hire_date, 'MM') WHEN '04' THEN count(*) ELSE 0 END AS "4월"
	 , CASE to_char(hire_date, 'MM') WHEN '05' THEN count(*) ELSE 0 END AS "5월"
	 , CASE to_char(hire_date, 'MM') WHEN '06' THEN count(*) ELSE 0 END AS "6월"
	 , CASE to_char(hire_date, 'MM') WHEN '07' THEN count(*) ELSE 0 END AS "7월"
	 , CASE to_char(hire_date, 'MM') WHEN '08' THEN count(*) ELSE 0 END AS "8월"
	 , CASE to_char(hire_date, 'MM') WHEN '09' THEN count(*) ELSE 0 END AS "9월"
	 , CASE to_char(hire_date, 'MM') WHEN '10' THEN count(*) ELSE 0 END AS "10월"
	 , CASE to_char(hire_date, 'MM') WHEN '11' THEN count(*) ELSE 0 END AS "11월"
	 , CASE to_char(hire_date, 'MM') WHEN '12' THEN count(*) ELSE 0 END AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM')
 ORDER BY to_char(hire_date, 'MM');

-- Rank() 등수 공동등수 번호가 띄워짐  dense_rank() 등수번호가 순차적으로 올라감
-- row_number() 현재 데이터 행번호 출력

SELECT employee_id, last_name, salary
	 , rank() OVER (ORDER BY salary DESC) AS "랭크"
	 , dense_rank() OVER (ORDER BY salary DESC) AS "랭크"
	 , ROW_NUMBER() OVER (ORDER BY salary DESC) AS "랭크"
  FROM employees;
  


