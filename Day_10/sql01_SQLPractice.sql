/*
 * 기본 select문
 */

-- 문제1. 사원정보 테이블에서 이름과 성은 name으로 합쳐서 출력

SELECT employee_id
	 , first_name || ' ' || last_name AS "name"
	 , salary
	 , job_id
	 , to_char(hire_date, 'yyyy-mm-dd') AS "HIRE_DATE" 
	 , manager_id
  FROM employees;

-- 문제2. employees에서 모든 사원의 이름(last_name)과 연볼을 '이름 : 1year salary = $연봉' 형식으로
-- 출력하고, 컬럼명을 1year Salary로 변경하시오(107행)

SELECT last_name || ': 1 year Salary =' || to_char(salary * 12, '$999,999.99') AS "1year Salary"   
  FROM EMPLOYEES;

-- 문제3. 부서별로 담당하는 업무를 한번씩만 출력하시오.(20행)
SELECT DISTINCT department_id
     , job_id
  FROM employees;

/*
 * where절, order by절
 */

-- 문제4. employees에서 급여가 7000에서 10000달러 범위인 사람의 이름과 성을 풀네임으로 출력,
-- 급여를 오름차순을 출력하시오(75행)
SELECT first_name || ' ' || last_name AS "full_name"
  FROM employees
 WHERE salary < 7000 
    OR salary > 10000;

SELECT first_name || ' ' || last_name AS "full_name"
	 , salary
  FROM employees
 WHERE salary NOT BETWEEN 7000 AND 10000
 ORDER BY salary ASC;

-- 문제5. 현재 날짜타입을 날짜 함수를 통해서 확인하고,
-- 입사일자가 2005년 5월 20일부터 2006년 5월 20일 사이에 입사한 사원의 이름(풀네임), 사원번호, 고용일자 출력
-- 단, 입사일을 빠른순으로 정렬하시오
SELECT sysdate FROM dual;

SELECT first_name || ' ' || last_name AS "full_name"
	 , employee_id
	 , to_char(hire_date, 'yyyy-mm-dd') AS "hire_date"
  FROM employees 
 WHERE hire_date BETWEEN '2003-05-20' AND '2004-05-20'
 ORDER BY hire_date;

/*
 * 단일행 함수와 변환 함수
 */

-- 문제6. 이번 분기, 60번 it부서 해당 부서 사원의 급여를 15.3.%인상. 정수만 반올림
-- 사번, 이름과 성, 급여, 인상된 급여(컬럼명 Increased Salary) 출력

SELECT employee_id
     , first_name || ' ' || last_name AS "full_name"
     , EMPLOYEES.SALARY 
     , round(salary * 1.153)  AS "Increased_Salary"
  FROM employees
 WHERE job_id = 'IT_PROG';

-- 문제7. 모든 사원의 연봉을 표시하는 보고서 작성
-- 사원 풀네임, 급여, 수당여부에 따라 연봉을 표시
-- 수당이 있으면 salary + commission, 없으면 salary only라고 표시. 연봉이 높은순으로 정렬(107행)
SELECT first_name || ' ' || last_name AS "full_name"
	 , SALARY 
	 , (salary * 12) + (salary + nvl(COMMISSION_PCT,0)) AS "Annual Salary"
	 , 
	 , CASE WHEN commission_pct IS NULL THEN 'salary only'
	 	    WHEN commission_pct	IS NOT NULL THEN 'salary + commission'
	 	    END AS "commission"
  FROM EMPLOYEES
 ORDER BY 3 DESC;

/*
 * 집계함수, min, max, sum, avg, count 
 * group by와 같이 사용함
 */

-- 문제8. employees에서 각 사원이 소속된 부서별 급여합계, 급여평균, 급여최대값, 급여 최소값
-- 출력 형식은 6자리와 3자리 구분기호 $를 앞에 표시할 것 부서번호의 오름차순으로 정렬
-- 단, 부서에 소속되지 않은 사원은 제외(11행)
SELECT department_id
	 , to_char(sum(salary), '$999,999') AS "sum_salary"
	 , to_char(avg(salary), '$99,999.9') AS "avg_salary"
	 , to_char(max(salary), '$999,999') AS "max_salary"
	 , to_char(min(salary), '$99,999.9') AS "min_salary"
  FROM employees 
 WHERE department_id IS NOT NULL 
 GROUP BY department_id
 ORDER BY department_id;

/*
 * join
 */

-- 문제9. employees,department,location 테이블 구조파악
-- Oxford에 근무하는 사원 full_name 업무 부서명 도시명을 출력하시오
SELECT e.first_name || ' ' || e.last_name AS "full_name"
	 , e.JOB_ID
	 , d.department_name
	 , l.city
  FROM employees e, departments d, locations l
 WHERE e.department_id = d.DEPARTMENT_ID
   AND d.location_id = l.location_id
   AND l.city = 'Oxford';

COMMIT;

-- 문제 10. 부서가 없는 직원까지 모두 full_name, 업무, 부서명을 출력하시오. 107행
SELECT e.first_name || ' ' || e.last_name AS "full_name"
	 , e.JOB_ID
	 , d.department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id(+);

/*
 * 서브 쿼리 
 */

-- 문제 11. Tucker 사원보다 급여를 많이 받는 사원의 full_name, 업무, 급여를 출력(15행)

SELECT salary
  FROM employees
 WHERE last_name = 'Tucker';

SELECT first_name || ' ' || last_name AS "full_name"
	 , JOB_ID
	 , salary
  FROM EMPLOYEEs
 WHERE salary > (SELECT salary
  				   FROM employees
 				  WHERE last_name = 'Tucker');

-- 문제 12. 부서와 업무별 급여합계를 구하여서 급여수준 레벨을 지정하고자 함.
-- 부서별, 업무별 급여합계 및 각 부서별 총합, 각 부서별. 업무별 직원수를 출력하시오

SELECT department_id, job_id
	 , to_char(SUM(salary), '$99,999') AS "Sum Salary"
	 , count(*) AS "Employees Count"
  FROM employees
 GROUP BY ROLLUP (department_id, job_id);
 
COMMIT;

























































































































































































































