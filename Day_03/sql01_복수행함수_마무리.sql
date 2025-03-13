/*
 * 복수행 함수 마무리
 * */

-- GROUP BY
-- 그룹핑시 그룹바이에 들어가는 컬럼만 select절에 사용 가능
SELECT department_id
	 , sum(salary)
  FROM employees
 WHERE department_id <= 70
 GROUP BY department_id
HAVING sum(salary) <= 20000
 ORDER BY sum(salary) ASC; -- 대신 2번을 쓸수도 있다 왜냐면 순서에 따라 sum(salary)가 2번에 있기 때문에
 
-- rank() - 1, 2, 2, 4, 5 순
-- dense_rank() - 1, 2, 2, 3, 4 순
-- row_number() - 1, 2, 3, 4, 5 (행번호 매김)
 
-- 전체 employees에서 급여가 높은 사람부터 순위를 매길 때
SELECT first_name || ' ' || last_name AS "full_name" 
	 , salary
	 , department_id
	 , rank() OVER (ORDER BY salary desc) AS "rank"
	 , DENSE_RANK() OVER (ORDER BY salary desc) AS "rank" -- 일상에선 dense_rank를 더 많이 사용
	 , ROW_NUMBER() OVER (ORDER BY salary desc) AS "row_number"
  FROM employees
 WHERE salary IS NOT NULL
 ORDER BY salary DESC;

-- 부서별(department_id), 급여 높은 사람부터 순위를 매길 때
SELECT first_name || ' ' || last_name AS "full_name" 
	 , salary
	 , department_id
	 , rank() OVER (PARTITION BY department_id ORDER BY salary desc) AS "rank" -- PARTITION BY department_id를 붙이면 급여높은 순을 부서별안에서 뽑으라는 말이됨
	 , DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary desc) AS "rank" -- 일상에선 dense_rank를 더 많이 사용
	 , ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary desc) AS "row_number" -- PARTITION BY가 많이 사용안함
  FROM employees
 WHERE salary IS NOT NULL
 ORDER BY department_id;
