/* 단일행함수 */

SELECT concat('hello','oracle')
  FROM dual; --한행, 한열만 출력되는 값을 스칼라값이라고 한다(scalar값)
  
-- DB는 인덱스가 1부터 시작, 일반프로그래밍은 0부터 시작하는 것과 차이가 남
-- substr() 파이썬 substring() 함수와 동일, 단 
  
SELECT substr(email,1,2) -- substr(변환하는 값, 인덱스 값, 길이 값) 사용방법 -인덱스는 뒤에서 부터 시작 파이선과 동일
	 , substr(email,-2,1)
	 , email
  FROM employees;

-- 전화번호, 주민번호 자를 때 substr()활용


-- instr(체크 할 문자열, 찾는글자, 시작위치, 몇번째) -> 찾는 문자의 위치를 알려줌

SELECT '010-9999-8888'
	 , instr('010-9999-8888','-',5,1)
  FROM dual;

-- LPAD(문자열,자릿수,채울문자) 문자가 다른 문자들과 형태가 다를 때 원하는 값을 원하는 자리수에 맞춰서 왼쪽부터 문자를 채워줌
-- RPAD LPAD랑 반대로 오른쪽부터 사용함
SELECT lpad('100',7,'0')
     , rpad('100',7,'0')
  FROM dual;

-- TRIM() 함수 트리플, == 파이썬 strip()함수와 동일/공백제거
-- LTRIM(),RTRIM(),TRIM() 순서대로 왼쪽 - 오른쪽 - 왼오 전부다 /
SELECT '<<<' || '     Hello oracle     ' || '>>>'
	 , '<<<' || ltrim('     Hello oracle     ') || '>>>'
	 , '<<<' || rtrim('     Hello oracle     ') || '>>>'
	 , '<<<' || trim('     Hello oracle     ') || '>>>' -- 많이 사용함
  FROM dual;

-- replace() 파이썬과 동일'
SELECT phone_number
 	 , REPLACE(phone_number, '123', '789') -- 많이 씀
  FROM employees;

/*
 * 숫자 함수, 집계함수와 같이 사용이 많이 됨
 * */
-- round(), 파이썬과 같음
-- ceil() 올림함수, floor() 내림함수, trunc() 내림함수 소수점
-- mod() 나누기의 나머지값, 파이썬 %와 동일한 기능
-- power() 파이썬 math.low(),power() 2^10 승수계산 동일
SELECT 786.5427 AS res1
 	 , round(786.5427) AS res2 -- 반올림
 	 , round(786.5427,1) AS res3 -- 소수점 첫째자리
	 , round(786.5427, 2) AS res4
	 , ceil(786.5427) AS ceil_s
	 , floor(786.5427) AS floor_s
	 , trunc(786.5427)
 	 , MOD(10,3) AS "나머지"
 	 , power(2,10) AS "2의10승"
  FROM dual;

/*
 * 날짜함수, 나라마다 표현하는 방식이 다름
 * 2025-03-12 아시아 ...
 * March/12/2025 미국,캐나다...
 * 12/March/2025 유럽,인도,베트남 ...
 * 포맷팅을 많이함
 * */

-- 오늘날짜
SELECT sysdate -- 그리니치 천문대를 기준으로 잡아서 우리랑 9시간 차이남 +해주기
	 -- 날짜 포맷팅에 사용되는 YY,YYYY,MM DD ,DAY 년월일
 	 -- AM/PM, HH, HH24, MI, SS, W, Q(분기)
 	 , TO_CHAR(sysdate, 'YYYY-MM-DD') AS "한국식"
 	 , TO_CHAR(sysdate, 'AM HH24:MI:SS') as "시간"
 	 , TO_CHAR(sysdate, 'MON/DD/YYYY') AS "미국식"
 	 , TO_CHAR(sysdate, 'DD/MM/YYYY') AS "영국식"
  FROM dual;

-- ADD_MONTHS() 월을 추가 함수
SELECT hire_date
 	 , to_char(hire_date, 'yyyy-mm-dd') AS "입사일자"
 	 , ADD_MONTHS(hire_date, 3) AS "정규직 일자"
 	 , next_day(hire_date, '월') AS "돌아오는 월요일"
 	 , LAST_day(sysdate) AS "달 마지막 날"
  FROM employees;

-- GMT+9H
-- 인터벌 숫자뒤 HOUR, DAY, MONTH, YEAR
SELECT to_char(sysdate + INTERVAL '9' HOUR, 'YYYY-MM-DD HH24:MI:SS') AS "seoul_time"
  FROM dual;

/*
 * 형 변환 함수
 * */

-- to_char() -> 숫자형을 문자형으로 변경

SELECT 12345 AS "원본"
 	 , TO_CHAR(12345, '9999999') AS "원본 + 두자리"
 	 , TO_CHAR(12345, '0999999') AS "원본 + 두자리0"
 	 , TO_CHAR(12345, '$999999') AS "통화단위 + 원본"
 	 , TO_CHAR(12345, '99999.99') AS "소수점"
 	 , TO_CHAR(12345, '99,999') AS "천단위 쉼표" -- 진짜 많이씀
  FROM dual;

-- to_number() 문자형된 데이터를 숫자로 변환
SELECT '5.0' * 5
 	 , to_number('5.0') AS "숫자형변환"
--   , to_number('hello') 애초에 숫자가 아닌건 숫자형으로 변환이 불가능
  FROM dual;

-- to_date() 날짜형태를 문자형으로
SELECT '2025-03-12' -- + 10 문자형은 숫자형과 산수가 불가능
 	 , TO_date ('2025-03-12') + 10 -- 날짜형과 숫자형은 산수가 가능 DD와 산수한다.
  FROM dual;

/*
 * 일반 함수
 * */

-- NVL(컬럼 | 데이터, 바꿀값) 널값을 다른값으로 치환
SELECT commission_pct
 	 , nvl(commission_pct, 0.0)
  FROM employees;

SELECT NVL(hire_date, sysdate) -- 입사일자가 비어있으면 오늘날짜로 대체해라
  FROM employees;

-- NVL2(컬럼|데이터, 널이 아닐때 처리, 널일때 처리할 부분)
SELECT commission_pct
	 , salary
 	 , nvl2(commission_pct, salary + (salary* commission_pct), salary)
  FROM employees;


-- DECODE(A,B,'1','2') A가 B일경우 1 아니면 2
-- 오라클만 있는 함수
SELECT email, phone_number, job_id
	 , DECODE(job_id, 'IT_PROG', '개발자','다죽어') AS "캐치프레이즈"
  FROM employees;
-- where job_id = 'IT_PROG'

/*
 * CASE 구문, 정말중요!!!
 * if, elif의 중복된 구문과 유사
 * */







